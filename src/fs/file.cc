#include "fs/file.h"
#include "kernel/spinlock.h"
#include "kernel/mm.h"
#include "drivers/uart.h"
#include "kernel/proc.h"

#define NFILE 100

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
            // pipeclose(ff.pipe, ff.writable);
        }
    }

    int read(struct file *f, uint64 addr, int n)
    {
        if (f->readable == 0)
            return -1;
        if (f->type == FD_INODE)
        {
            VFS::ilock(f->ip);
            int r = f->ip->read((char*)addr, f->off, n, 1);
            if(r > 0)
            {
                f->off += r;
            }
            VFS::iunlock(f->ip);
            return r;
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
            int r = f->ip->write((char *)addr, f->off, n, 1);
            if (r > 0)
            {
                f->off += r;
            }
            VFS::iunlock(f->ip);
            return r;
        }
        // else if (f->type == FD_PIPE) ...

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
} // namespace FileTable
