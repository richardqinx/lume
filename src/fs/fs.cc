#include "fs/fs.h"
#include "kernel/riscv.h"
#include "drivers/uart.h"
#include "kernel/spinlock.h"
#include "kernel/proc.h"
#include "fs/fat32.h"
#include "lib/string.h"

static Inode *global_root_inode = nullptr;

static const char *skipelem(const char *path, char *name)
{
    const char *s;
    int len;

    while (*path == '/')
        path++;
    if (*path == 0)
        return nullptr;

    s = path;
    while (*path != '/' && *path != 0)
        path++;

    len = path - s;
    if (len >= 128)
        len = 127;

    memmove(name, s, len);
    name[len] = 0;

    while (*path == '/')
        path++;
    return path;
}

void Inode::getattr(struct kstat *st)
{
    st->dev = dev;
    st->ino = inum;
    st->type = type;
    st->nlink = nlink;
    st->size = size;

    st->uid = 0;
    st->gid = 0;
    st->mode = 0;
}

namespace VFS
{
    void init()
    {
        Drivers::uart_puts("[VFS] Inode subsystem initialized.\n");
    }

    void iput(Inode *ip)
    {
        if (ip == nullptr)
            return;

        ip->lock.acquire();
        if(ip->ref_cnt < 1)
        {
            Drivers::uart_puts("panic: iput ref\n");
            while (1)
                ;
        }
        ip->ref_cnt--;
        int ref = ip->ref_cnt;
        ip->lock.release();

        if (ref == 0)
        {
            delete ip;
        }
    }

    Inode* idup(Inode *ip)
    {
        if (ip == nullptr)
            return nullptr;

        ip->lock.acquire();
        ip->ref_cnt++;
        ip->lock.release();
        return ip;
    }

    void ilock(Inode *ip)
    {
        if (ip == 0 || ip->ref_cnt < 1)
        {
            Drivers::uart_puts("panic: ilock\n");
            while (1)
                ;
        }

        ip->lock.acquire();

    }

    void iunlock(Inode *ip)
    {
        if (ip == 0 || !ip->lock.holding() || ip->ref_cnt < 1)
        {
            Drivers::uart_puts("panic: iunlock\n");
            while (1)
                ;
        }
        ip->lock.release();
    }

    void iunlockput(Inode *ip)
    {
        if (!ip)
            return;
        iunlock(ip);
        iput(ip);
    }

    void mount_root(Inode *root)
    {
        if (global_root_inode)
        {
            Drivers::uart_puts("VFS: Root already mounted!\n");
            return;
        }
        global_root_inode = root;
        Drivers::uart_puts("[VFS] Root filesystem mounted.\n");
    }

    Inode *get_root()
    {
        if (global_root_inode == nullptr)
        {
            Drivers::uart_puts("[VFS] Lazy init: Mounting FAT32...\n");
            fat32_fs.init();
            mount_root(fat32_fs.root());
        }
        if (!global_root_inode)
            return nullptr;
        return idup(global_root_inode);
    }

    Inode *namei(const char *path)
    {
        char name[128];
        Inode *ip, *next;
        struct Proc *p = myproc();

        if (*path == '/')
        {
            ip = get_root();
        }
        else
        {
            if (p->cwd == nullptr)
            {
                ip = get_root();
            }
            else
            {
                ip = idup(p->cwd);
            }
        }

        if (ip == nullptr)
            return nullptr;

        while ((path = skipelem(path, name)) != nullptr)
        {
            ilock(ip);

            if (ip->type != T_DIR)
            {
                iunlockput(ip);
                return nullptr;
            }

            next = ip->lookup(name);
            iunlockput(ip);

            ip = next;
            if (ip == nullptr)
                return nullptr;
        }

        return ip;
    }

} // namespace VFS
