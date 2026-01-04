// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (C) 2026 Richard QIn
 */

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

class Pipe;

struct file
{
    enum FileType type;
    int ref;
    char readable;
    char writable;

    Pipe *pipe; // pipeline pointer
    Inode *ip;         // VFS Inode
    uint32 off;        // Current Offset
};

class Pipe
{
public:
    static constexpr uint32_t SIZE = 512;

    Pipe() : nread(0), nwrite(0), read_open(true), write_open(true)
    {
        lock.init("pipe");
    }

    // forbid copy
    Pipe(const Pipe &) = delete;
    Pipe &operator=(const Pipe &) = delete;

    ~Pipe()
    {
        //
    }

    // creates a pair of connected file objects
    static int create_pair(struct file **f0, struct file **f1);

    int read(uint64_t addr, int n);
    int write(uint64_t addr, int n);
    void close(bool is_writer);

private:
    Spinlock lock;
    char data[SIZE];
    uint32_t nread;  // read
    uint32_t nwrite; // write
    bool read_open;
    bool write_open;
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
    int lseek(struct file *f, int offset, int whence);
} // namespace FileTable
