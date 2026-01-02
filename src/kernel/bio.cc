#include "kernel/buf.h"
#include "kernel/spinlock.h"
#include "kernel/riscv.h"
#include "drivers/virtio.h"
#include "drivers/uart.h"

namespace BufferCache
{
    struct 
    {
        Spinlock lock;
        struct Buf buf[NBUF];
        struct Buf head;
    } bcache;

    void init()
    {
        bcache.lock.init("bcache");
        // Initialize LRU doubly circular linked list
        bcache.head.prev = &bcache.head;
        bcache.head.next = &bcache.head;
        for (struct Buf *b = bcache.buf; b < bcache.buf + NBUF; ++b)
        {
            b->lock.init("buffer");
            b->next = bcache.head.next;
            b->prev = &bcache.head;
            bcache.head.next->prev = b;
            bcache.head.next = b;
        }
        Drivers::uart_puts("[Bio] Buffer cache initialized.\n");
    }

    static struct Buf* bget(uint32 dev, uint32 blockno)
    {
        struct Buf* b;
        bcache.lock.acquire();

        // Attempt to hit the cache
        for (b = bcache.head.next; b != &bcache.head; b = b->next)
        {
            if (b->dev == dev && b->blockno == blockno)
            {
                b->refcnt++;
                bcache.lock.release();
                b->lock.acquire(); // Acquire Sleep Lock
                return b;
            }
        }

        // Cache miss, evicting LRU
        for (b = bcache.head.prev; b != &bcache.head; b = b->prev)
        {
            if (b->refcnt == 0)
            {
                b->dev = dev;
                b->blockno = blockno;
                b->valid = 0;
                b->refcnt = 1;
                bcache.lock.release();
                b->lock.acquire();
                return b;
            }
        }

        Drivers::uart_puts("panic: bget: no buffers\n");
        while (1)
            ;
    }

    struct Buf* bread(uint32 dev, uint32 blockno)
    {
        struct Buf *b = bget(dev, blockno);

        if (!b->valid)
        {
            VirtIO::rw(0, b->blockno, (char *)b->data);
            b->valid = 1;
        }

        return b;
    }

    void bwrite(struct Buf *b)
    {
        if (!b->lock.holding())
        { 
            Drivers::uart_puts("panic: bwrite\n");
            while (1)
                ;
        }
        VirtIO::rw(1, b->blockno, (char *)b->data);
    }

    void brelse(struct Buf *b)
    {
        if (!b->lock.holding())
        {
            Drivers::uart_puts("panic: brelse\n");
            while (1)
                ;
        }
        b->lock.release();

        bcache.lock.acquire();
        b->refcnt--;

        if (b->refcnt == 0)
        {
            b->next->prev = b->prev;
            b->prev->next = b->next;

            b->next = bcache.head.next;
            b->prev = &bcache.head;
            bcache.head.next->prev = b;
            bcache.head.next = b;
        }

        bcache.lock.release();
    }

    void bpin(struct Buf *b)
    {
        bcache.lock.acquire();
        b->refcnt++;
        bcache.lock.release();
    }

    void bunpin(struct Buf* b)
    {
        bcache.lock.acquire();
        b->refcnt --;
        bcache.lock.release();
    }

} // namespace BufferCache
