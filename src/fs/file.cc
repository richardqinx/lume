#include "fs/file.h"
#include "kernel/spinlock.h"
#include "kernel/mm.h"
#include "drivers/uart.h"
#include "kernel/proc.h"
#include "kernel/slab.h"

#define NFILE 100
#define SEEK_SET 0
#define SEEK_CUR 1
#define SEEK_END 2

extern void *operator new(unsigned long, void *p);

int Pipe::create_pair(file** f0, file** f1)
{
    void *mem = Slab::kmalloc(sizeof(Pipe));
    if (!mem)
        return -1;
    Pipe *pi = new (mem) Pipe();

    *f0 = FileTable::alloc();
    *f1 = FileTable::alloc();

    if (*f0 == nullptr || *f1 == nullptr)
    {
        if (*f0)
            FileTable::close(*f0);
        if (*f1)
            FileTable::close(*f1);
        pi->~Pipe();
        Slab::kfree(pi);
        return -1;
    }

    (*f0)->type = FD_PIPE;
    (*f0)->readable = 1;
    (*f0)->writable = 0;
    (*f0)->pipe = pi;

    (*f1)->type = FD_PIPE;
    (*f1)->readable = 0;
    (*f1)->writable = 1;
    (*f1)->pipe = pi;

    return 0;
}

void Pipe::close(bool is_writer)
{
    lock.acquire();
    if (is_writer)
    {
        write_open = false;
        ProcManager::wakeup(&nread); // Wake up the process that is currently reading
    }
    else
    {
        read_open = false;
        ProcManager::wakeup(&nwrite); // Wake up the process that is writing
    }

    bool empty = !read_open && !write_open;
    lock.release();

    if (empty)
    {
        this->~Pipe();
        Slab::kfree(this);
    }
}

int Pipe::write(uint64_t addr, int n)
{
    int i = 0;
    struct Proc *p = myproc();

    lock.acquire();
    while (i < n)
    {
        if (!read_open || p->xstate) // The read end is closed or the process is abnormal
        {
            lock.release();
            return -1;
        }

        if (nwrite == nread + SIZE) // buffer is full
        {
            ProcManager::wakeup(&nread);
            ProcManager::sleep(&nwrite, &lock);
        }
        else
        {
            char ch;
            if (VM::copyin(p->pagetable, &ch, addr + i, 1) < 0)
                break;
            data[nwrite++ % SIZE] = ch;
            i++;
        }
    }
    ProcManager::wakeup(&nread);
    lock.release();
    return i;
}

int Pipe::read(uint64_t addr, int n)
{
    int i = 0;
    struct Proc *p = myproc();

    lock.acquire();
    while (nread == nwrite && write_open) // The buffer is empty and the write end is not closed
    {
        if (p->xstate)
        {
            lock.release();
            return -1;
        }
        ProcManager::sleep(&nread, &lock);
    }

    for (i = 0; i < n; ++i)
    {
        if (nread == nwrite)
            break;
        char ch = data[nread++ % SIZE];
        if (VM::copyout(p->pagetable, addr + i, &ch, 1) < 0)
            break;
    }
    ProcManager::wakeup(&nwrite);
    lock.release();
    return i;
}

namespace FileTable
{
    struct
    {
        Spinlock lock;
        struct file files[NFILE];
    } ftable;

    void init()
    {
        ftable.lock.init("file_table");
    }

    struct file *alloc()
    {
        struct file *f;
        ftable.lock.acquire();
        for (f = ftable.files; f < ftable.files + NFILE; f++)
        {
            if (f->ref == 0)
            {
                f->ref = 1;
                ftable.lock.release();
                return f;
            }
        }
        ftable.lock.release();
        return nullptr;
    }

    struct file *dup(struct file *f)
    {
        ftable.lock.acquire();
        if (f->ref < 1)
        {
            Drivers::uart_puts("panic: file dup\n");
            while (1)
                ;
        }
        f->ref++;
        ftable.lock.release();
        return f;
    }

    void close(struct file *f)
    {
        struct file ff;

        ftable.lock.acquire();
        if(f->ref < 1)
        {
            Drivers::uart_puts("panic: file close\n");
            while (1)
                ;
        }
        f->ref--;
        if (f->ref > 0)
        {
            ftable.lock.release();
            return;
        }

        ff = *f;
        f->ref = 0;
        f->type = FD_NONE;
        ftable.lock.release();
        if (ff.type == FD_INODE)
        {
            // Release the corresponding Inode
            VFS::iput(ff.ip);
        }
        else if (ff.type == FD_PIPE)
        {
            if (ff.pipe)
                ff.pipe->close(ff.writable);
        }
    }

    int read(struct file *f, uint64 addr, int n)
    {
        if (f->readable == 0)
            return -1;
        if (f->type == FD_INODE)
        {
            VFS::ilock(f->ip);

            if (f->ip->type == T_DEVICE)
            {
                if (f->ip->major == 1)
                {
                    VFS::iunlock(f->ip);
                    return Drivers::console_read(addr, n);
                }
            }

            int r = f->ip->read((char*)addr, f->off, n, 1);
            if(r > 0)
            {
                f->off += r;
            }
            VFS::iunlock(f->ip);
            return r;
        }
        else if (f->type == FD_PIPE)
        {
            if (f->pipe)
                return f->pipe->read(addr, n);
        }
        return -1;
    }
    
    int write(struct file *f, uint64 addr, int n)
    {
        if (f->writable == 0)
            return -1;
        if (f->type == FD_INODE)
        {
            VFS::ilock(f->ip);

            if (f->ip->type == T_DEVICE)
            {
                if (f->ip->major == 1) // Console
                {
                    VFS::iunlock(f->ip);
                    struct Proc *proc = myproc();
                    constexpr int MAX_WRITE_BUF = 128;
                    char buf[MAX_WRITE_BUF];
                    int i = 0;
                    while (i < n)
                    {
                        int len = n - i;
                        if (len > MAX_WRITE_BUF)
                            len = MAX_WRITE_BUF;

                        if (VM::copyin(proc->pagetable, buf, addr + i, static_cast<uint64>(len)) < 0)
                        {
                            return -1;
                        }

                        for (int j = 0; j < len; j++)
                        {
                            Drivers::uart_putc(buf[j]);
                        }
                        i += len;
                    }
                    return n;
                }
            }

            int r = f->ip->write((char *)addr, f->off, n, 1);
            if (r > 0)
            {
                f->off += r;
            }
            VFS::iunlock(f->ip);
            return r;
        }
        else if (f->type == FD_PIPE)
        {
            if (f->pipe)
                return f->pipe->write(addr, n);
        }

        return -1;
    }

    int stat(struct file *f, uint64 addr)
    {
        if (f->type == FD_INODE)
        {
            struct kstat st;
            VFS::ilock(f->ip);
            f->ip->getattr(&st);
            VFS::iunlock(f->ip);

            struct Proc *p = myproc();
            if (VM::copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
                return -1;
            return 0;
        }
        return -1;
    }

    int lseek(struct file *f, int offset, int whence)
    {
        if (f->type != FD_INODE)
            return -1;

        VFS::ilock(f->ip);

        int new_off = f->off;
        int size = f->ip->size;

        switch (whence)
        {
        case SEEK_SET:
            new_off = offset;
            break;
        case SEEK_CUR:
            new_off += offset;
            break;
        case SEEK_END:
            new_off = size + offset;
            break;
        default:
            VFS::iunlock(f->ip);
            return -1;
        }

        if (new_off < 0)
        {
            VFS::iunlock(f->ip);
            return -1;
        }

        f->off = new_off;
        VFS::iunlock(f->ip);
        return new_off;
    }
} // namespace FileTable
