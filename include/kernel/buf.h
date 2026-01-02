#pragma once
#include "common/types.h"
#include "kernel/spinlock.h"

#define BSIZE 1024
#define NBUF 30

struct Buf
{
    int valid;        // Whether the data has been read from the disk (1=valid, 0=invalid)
    int disk;         // Whether it has been held by the driver (dirty bit/write-back flag is usually extended here)
    uint32 dev;       // Device Number
    uint32 blockno;   // Block number
    uint32 refcnt;    // Reference Counting
    struct Buf *prev; // LRU linked list
    struct Buf *next;
    uchar data[BSIZE];

    Mutex lock; // Sleep Lock
};

namespace BufferCache
{
    void init();
    struct Buf *bread(uint32 dev, uint32 blockno);
    void bwrite(struct Buf *b);
    void brelse(struct Buf *b);
    void bpin(struct Buf *b);
    void bunpin(struct Buf *b);
} // namespace BufferCache
