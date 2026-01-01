#pragma once
#include "common/types.h"
#include "fs/fs.h"

enum FileType
{
    FD_NONE,
    FD_INODE,
    FD_DEVICE,
    FD_PIPE
};

struct file
{
    enum FileType type;
    int ref;
    char readable;
    char writable;

    struct pipe *pipe; // pipeline pointer
    Inode *ip;         // VFS Inode
    uint32 off;        // Current Offset
};

namespace FileTable
{
    void init();
    struct file *alloc();             // Allocate a free file handle
    struct file *dup(struct file *f); // Duplicate handle (sys_dup)
    void close(struct file *f);       // Close handle

    int stat(struct file *f, uint64 addr);
    int read(struct file *f, uint64 addr, int n);
    int write(struct file *f, uint64 addr, int n);
} // namespace FileTable
