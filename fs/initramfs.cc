/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * initramfs.cc — Unpack embedded CPIO archive into ramfs
 *
 * The build system embeds a newc-format CPIO archive into the kernel
 * ELF as the section .init.ramfs. The linker script exports
 * __initramfs_start / __initramfs_end symbols.
 *
 * At boot, populate_rootfs() walks the CPIO entries and creates
 * directories and files in the already-mounted ramfs root.
 *
 * Reference: Linux init/initramfs.c
 *
 * CPIO "newc" header format (110 bytes, ASCII hex fields):
 *   magic[6]   "070701"
 *   ino[8] mode[8] uid[8] gid[8] nlink[8] mtime[8]
 *   filesize[8] devmajor[8] devminor[8] rdevmajor[8] rdevminor[8]
 *   namesize[8] check[8]
 *   filename (namesize bytes, NUL terminated, padded to 4-byte boundary)
 *   file data (filesize bytes, padded to 4-byte boundary)
 */

#include <lume/klog.h>
#include <lume/fs.h>
#include <lume/dcache.h>
#include <lume/file.h>
#include <lume/errno.h>
#include <lume/fs_types.h>

/* Linker-provided symbols for the embedded CPIO archive */
extern "C" const char __initramfs_start[];
extern "C" const char __initramfs_end[];

/* ramfs inode creation (from fs/ramfs/inode.cc) */
extern inode* ramfs_get_inode(super_block* sb, const inode* dir,
                              uint32 mode, uint32 rdev);

/* Global root dentry (from fs/vfs_init.cc) */
extern dentry* g_root_dentry;

/* ================================================================== */
/*  CPIO newc header parsing                                          */
/* ================================================================== */

struct cpio_header {
    char magic[6];
    char ino[8];
    char mode[8];
    char uid[8];
    char gid[8];
    char nlink[8];
    char mtime[8];
    char filesize[8];
    char devmajor[8];
    char devminor[8];
    char rdevmajor[8];
    char rdevminor[8];
    char namesize[8];
    char check[8];
};

static constexpr int kCpioHeaderSize = 110;

static uint32 parse_hex8(const char* s)
{
    uint32 val = 0;
    for (int i = 0; i < 8; i++) {
        char c = s[i];
        uint32 nibble;
        if (c >= '0' && c <= '9')      nibble = c - '0';
        else if (c >= 'a' && c <= 'f') nibble = c - 'a' + 10;
        else if (c >= 'A' && c <= 'F') nibble = c - 'A' + 10;
        else return val;
        val = (val << 4) | nibble;
    }
    return val;
}

static inline uint32 align4(uint32 v)
{
    return (v + 3) & ~3U;
}

/* ================================================================== */
/*  Path resolution helpers                                           */
/* ================================================================== */

static dentry* cpio_mkdir_p(dentry* root, const char* path,
                            const char** out_name)
{
    dentry* cur = root;

    while (*path == '/') path++;

    while (true) {
        const char* slash = path;
        while (*slash && *slash != '/') slash++;

        if (*slash == '\0') {
            *out_name = path;
            return cur;
        }

        uint32 len = static_cast<uint32>(slash - path);

        qstr name;
        name.name = path;
        name.len = len;
        name.hash = full_name_hash(path, len);

        dentry* child = d_lookup(cur, &name);
        if (!child) {
            child = d_alloc(cur, &name);
            if (!child) return nullptr;

            inode* ip = ramfs_get_inode(cur->d_inode->i_sb, cur->d_inode,
                                        S_IFDIR | 0755, 0);
            if (!ip) return nullptr;

            d_instantiate(child, ip);
            dget(child);
            inc_nlink(cur->d_inode);
        }

        cur = child;
        path = slash + 1;
        while (*path == '/') path++;
    }
}

/* ================================================================== */
/*  populate_rootfs — the main entry point                            */
/* ================================================================== */

void populate_rootfs()
{
    const char* p = __initramfs_start;
    const char* end = __initramfs_end;
    uint64 archive_size = static_cast<uint64>(end - p);

    if (archive_size == 0) {
        printk("[initramfs] no embedded archive found\n");
        return;
    }

    printk("[initramfs] unpacking %llu bytes...\n", archive_size);

    int file_count = 0;
    int dir_count = 0;

    while (p + kCpioHeaderSize <= end) {
        auto* hdr = reinterpret_cast<const cpio_header*>(p);

        /* Verify magic */
        if (hdr->magic[0] != '0' || hdr->magic[1] != '7' ||
            hdr->magic[2] != '0' || hdr->magic[3] != '7' ||
            hdr->magic[4] != '0' || hdr->magic[5] != '1') {
            printk("[initramfs] bad cpio magic at offset %llu\n",
                   static_cast<uint64>(p - __initramfs_start));
            break;
        }

        uint32 mode     = parse_hex8(hdr->mode);
        uint32 filesize = parse_hex8(hdr->filesize);
        uint32 namesize = parse_hex8(hdr->namesize);

        const char* name = p + kCpioHeaderSize;
        uint32 name_padded = align4(kCpioHeaderSize + namesize);
        const char* data = p + name_padded;
        uint32 data_padded = align4(filesize);

        const char* next = p + name_padded + data_padded;

        /* Check for TRAILER!!! end-of-archive marker */
        if (namesize == 11 && name[0] == 'T' && name[1] == 'R' &&
            name[2] == 'A' && name[3] == 'I' && name[4] == 'L' &&
            name[5] == 'E' && name[6] == 'R' && name[7] == '!' &&
            name[8] == '!' && name[9] == '!') {
            break;
        }

        /* Skip "." entry */
        if (namesize == 2 && name[0] == '.' && name[1] == '\0') {
            p = next;
            continue;
        }

        /* Resolve parent directory, creating intermediate dirs */
        const char* basename = nullptr;
        dentry* parent = cpio_mkdir_p(g_root_dentry, name, &basename);
        if (!parent || !basename || basename[0] == '\0') {
            p = next;
            continue;
        }

        /* Build qstr for the final component */
        uint32 blen = 0;
        while (basename[blen] && basename[blen] != '/') blen++;

        qstr bname;
        bname.name = basename;
        bname.len = blen;
        bname.hash = full_name_hash(basename, blen);

        if (S_ISDIR(mode)) {
            dentry* existing = d_lookup(parent, &bname);
            if (!existing) {
                dentry* de = d_alloc(parent, &bname);
                if (de) {
                    inode* ip = ramfs_get_inode(parent->d_inode->i_sb,
                                                parent->d_inode,
                                                S_IFDIR | (mode & 0777), 0);
                    if (ip) {
                        d_instantiate(de, ip);
                        dget(de);
                        inc_nlink(parent->d_inode);
                        dir_count++;
                    }
                }
            }
        } else if (S_ISREG(mode)) {
            dentry* de = d_alloc(parent, &bname);
            if (de) {
                inode* ip = ramfs_get_inode(parent->d_inode->i_sb,
                                            parent->d_inode,
                                            S_IFREG | (mode & 0777), 0);
                if (ip) {
                    d_instantiate(de, ip);
                    dget(de);

                    /* Write file content via ramfs write path */
                    if (filesize > 0 && ip->i_fop && ip->i_fop->write) {
                        file tmp_fp = {};
                        tmp_fp.f_inode = ip;
                        tmp_fp.f_path.de = de;
                        tmp_fp.f_pos = 0;
                        tmp_fp.f_flags = O_WRONLY;
                        tmp_fp.f_count.store(1);

                        int64 pos = 0;
                        ip->i_fop->write(&tmp_fp, data,
                                         filesize, &pos);
                    }

                    file_count++;
                    printk("[initramfs]   %s (%u bytes, mode %03o)\n",
                           name, filesize, mode & 0777);
                }
            }
        } else if (S_ISLNK(mode)) {
            /* Symlink: file data is the target path (not NUL-terminated).
             * Linux: init/initramfs.c do_symlink() */
            dentry* de = d_alloc(parent, &bname);
            if (de) {
                inode* ip = ramfs_get_inode(parent->d_inode->i_sb,
                                            parent->d_inode,
                                            S_IFLNK | 0777, 0);
                if (ip) {
                    /* Store symlink target in inode.
                     * Allocate a kernel buffer and copy the target. */
                    char* target = new char[filesize + 1];
                    if (target) {
                        for (uint32 i = 0; i < filesize; i++)
                            target[i] = data[i];
                        target[filesize] = '\0';
                        ip->i_link = target;
                    }

                    d_instantiate(de, ip);
                    dget(de);
                    file_count++;
                    printk("[initramfs]   %s -> %s (symlink)\n",
                           name, target ? target : "?");
                }
            }
        }

        p = next;
    }

    printk("[initramfs] done: %d files, %d dirs\n",
           file_count, dir_count);
}
