#include "drivers/virtio.h"
#include "kernel/riscv.h"
#include "kernel/pmm.h"
#include "kernel/spinlock.h"
#include "lib/string.h"
#include "drivers/uart.h"
#include "kernel/proc.h"
#include "kernel/buf.h"

static uint64 virtio_base = 0x10001000;

// VirtIO Block Device Config Structure
struct virtio_blk_config
{
    uint64 capacity;
    uint32 size_max;
    uint32 seg_max;
    struct virtio_blk_geometry
    {
        uint16 cylinders;
        uint8 heads;
        uint8 sectors;
    } geometry;
    uint32 blk_size;
    uint8 physical_block_exp;
    uint8 alignment_offset;
    uint16 min_io_size;
    uint32 opt_io_size;
} __attribute__((packed));

static inline volatile uint32 *REG(uint32 offset)
{
    return reinterpret_cast<volatile uint32 *>(virtio_base + offset);
}

namespace VirtIO
{
    struct Disk
    {
        struct VRingDesc *desc;
        struct VRingAvail *avail;
        struct VRingUsed *used;

        int free_head;
        int num_free;
        int free_chain[NUM_DESCS];

        uint16 used_idx;

        struct TraceInfo
        {
            int busy;
            int status;
        } info[NUM_DESCS];

        struct BlockRequest reqs[NUM_DESCS];
        uint8 req_status[NUM_DESCS];

        Spinlock lock;
    } disk;

    void init()
    {
        disk.lock.init("virtio_disk");

        // 1. Probing for VirtIO-MMIO device
        bool found = false;
        // Probe common VirtIO addresses in QEMU virt machine
        for (uint64 addr = 0x10001000; addr < 0x10009000; addr += 0x1000)
        {
            volatile uint32 *magic = (volatile uint32 *)(addr + VIRTIO_MMIO_MAGIC_VALUE);
            volatile uint32 *dev_id = (volatile uint32 *)(addr + VIRTIO_MMIO_DEVICE_ID);

            if (*magic == 0x74726976 && *dev_id == 2) // ID 2 = Block Device
            {
                virtio_base = addr;
                found = true;
                Drivers::uart_puts(ANSI_GREEN "[VirtIO] Found Block Device @ ");
                Drivers::print_hex(addr);
                Drivers::uart_puts(ANSI_RESET "\n");
                break;
            }
        }

        if (!found)
        {
            Drivers::uart_puts(ANSI_RED "[VirtIO] Fatal - No Block Device found.\n" ANSI_RESET);
            return;
        }

        // 2. Check Device Version (We want Modern v2)
        if (*REG(VIRTIO_MMIO_VERSION) != 2)
        {
            Drivers::uart_puts(ANSI_YELLOW "[VirtIO] Warning: Legacy device detected (expected v2).\n" ANSI_RESET);
        }

        // 3. Reset Device
        *REG(VIRTIO_MMIO_STATUS) = 0;

        // 4. Set ACKNOWLEDGE & DRIVER status
        uint32 status = *REG(VIRTIO_MMIO_STATUS);
        status |= VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER;
        *REG(VIRTIO_MMIO_STATUS) = status;

        // 5. Feature Negotiation
        *REG(VIRTIO_MMIO_DEVICE_FEATURES_SEL) = 0;
        uint32 device_features_lo = *REG(VIRTIO_MMIO_DEVICE_FEATURES);
        (void)device_features_lo;

        *REG(VIRTIO_MMIO_DEVICE_FEATURES_SEL) = 1;
        uint32 device_features_hi = *REG(VIRTIO_MMIO_DEVICE_FEATURES);
        (void)device_features_hi;

        *REG(VIRTIO_MMIO_DRIVER_FEATURES_SEL) = 0;
        *REG(VIRTIO_MMIO_DRIVER_FEATURES) = 0;

        *REG(VIRTIO_MMIO_DRIVER_FEATURES_SEL) = 1;
        // VIRTIO_F_VERSION_1 is usually bit 32.
        // If not defined in header, we hardcode logic here: (1ULL << 0) for high bits
        *REG(VIRTIO_MMIO_DRIVER_FEATURES) = 1;

        status |= VIRTIO_CONFIG_S_FEATURES_OK;
        *REG(VIRTIO_MMIO_STATUS) = status;

        if (!(*REG(VIRTIO_MMIO_STATUS) & VIRTIO_CONFIG_S_FEATURES_OK))
        {
            Drivers::uart_puts("VirtIO: Feature negotiation failed.\n");
            return;
        }

        // 6. Queue Configuration
        *REG(VIRTIO_MMIO_QUEUE_SEL) = 0;
        if (*REG(VIRTIO_MMIO_QUEUE_READY))
        {
            Drivers::uart_puts("VirtIO: Queue 0 not ready.\n");
        }

        uint32 max_queue = *REG(VIRTIO_MMIO_QUEUE_NUM_MAX);
        if (max_queue < NUM_DESCS)
        {
            Drivers::uart_puts("VirtIO: Queue size too small.\n");
            return;
        }

        *REG(VIRTIO_MMIO_QUEUE_NUM) = NUM_DESCS;

        // Allocate Memory for VirtQueues
        void *ptr = PMM::alloc_pages(1); // 4KB is enough for small rings
        memset(ptr, 0, PGSIZE);

        uint64 base_addr = (uint64)ptr;
        disk.desc = reinterpret_cast<struct VRingDesc *>(base_addr);
        disk.avail = reinterpret_cast<struct VRingAvail *>(base_addr + NUM_DESCS * 16);
        disk.used = reinterpret_cast<struct VRingUsed *>(base_addr + PGSIZE / 2);

        *REG(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint32)base_addr;
        *REG(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint32)(base_addr >> 32);

        uint64 avail_addr = (uint64)disk.avail;
        *REG(VIRTIO_MMIO_QUEUE_DRIVER_LOW) = (uint32)avail_addr;
        *REG(VIRTIO_MMIO_QUEUE_DRIVER_HIGH) = (uint32)(avail_addr >> 32);

        uint64 used_addr = (uint64)disk.used;
        *REG(VIRTIO_MMIO_QUEUE_DEVICE_LOW) = (uint32)used_addr;
        *REG(VIRTIO_MMIO_QUEUE_DEVICE_HIGH) = (uint32)(used_addr >> 32);

        *REG(VIRTIO_MMIO_QUEUE_READY) = 1;

        // 7. Initialize Internal Structures
        disk.free_head = 0;
        disk.num_free = NUM_DESCS;
        disk.used_idx = 0;
        for (int i = 0; i < NUM_DESCS; i++)
        {
            disk.free_chain[i] = i + 1;
            disk.info[i].busy = 0;
        }

        // 8. Finalize Setup
        status |= VIRTIO_CONFIG_S_DRIVER_OK;
        *REG(VIRTIO_MMIO_STATUS) = status;

        // === [Feature] Read Capacity ===
        volatile struct virtio_blk_config *config = (volatile struct virtio_blk_config *)(virtio_base + VIRTIO_MMIO_CONFIG);
        uint64 capacity_sectors = config->capacity;
        uint64 size_mb = (capacity_sectors * 512) / (1024 * 1024);

        Drivers::uart_puts(ANSI_GREEN "[VirtIO] Initialized. Capacity: ");
        Drivers::uart_put_int(size_mb);
        Drivers::uart_puts(" MB\n" ANSI_RESET);
    }

    static int alloc_desc()
    {
        if (disk.num_free == 0)
            return -1;
        int id = disk.free_head;
        disk.free_head = disk.free_chain[id];
        disk.num_free--;
        return id;
    }

    static void free_desc(int id)
    {
        disk.free_chain[id] = disk.free_head;
        disk.free_head = id;
        disk.num_free++;
        ProcManager::wakeup(&disk.free_head);
    }

    static void free_chain_soft(int head_idx)
    {
        int curr = head_idx;
        while (1)
        {
            int flag = disk.desc[curr].flags;
            int next = disk.desc[curr].next;
            free_desc(curr);
            if (flag & VRING_DESC_F_NEXT)
                curr = next;
            else
                break;
        }
    }

    void rw(int write, uint64 blockno, char *buf)
    {
        uint64 sector = blockno * (1024 / 512); // Assume 1KB blocks

        disk.lock.acquire();

        // Wait for enough descriptors
        while (disk.num_free < 3)
        {
            ProcManager::sleep(&disk.free_head, &disk.lock);
        }

        int idx[3];
        idx[0] = alloc_desc();
        idx[1] = alloc_desc();
        idx[2] = alloc_desc();

        // 1. Request Header
        struct BlockRequest *req = &disk.reqs[idx[0]];
        req->type = write ? VIRTIO_BLK_T_OUT : VIRTIO_BLK_T_IN;
        req->reserved = 0;
        req->sector = sector;

        disk.desc[idx[0]].addr = (uint64)req;
        disk.desc[idx[0]].len = sizeof(struct BlockRequest);
        disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
        disk.desc[idx[0]].next = idx[1];

        // 2. Data Buffer
        disk.desc[idx[1]].addr = (uint64)buf;
        disk.desc[idx[1]].len = 1024; // Fixed 1KB for this test
        disk.desc[idx[1]].flags = VRING_DESC_F_NEXT;
        if (!write)
            disk.desc[idx[1]].flags |= VRING_DESC_F_WRITE;
        disk.desc[idx[1]].next = idx[2];

        // 3. Status Byte
        disk.desc[idx[2]].addr = (uint64)&disk.req_status[idx[0]];
        disk.desc[idx[2]].len = 1;
        disk.desc[idx[2]].flags = VRING_DESC_F_WRITE;
        disk.desc[idx[2]].next = 0;

        disk.info[idx[0]].busy = 1;

        // Submit to Avail Ring
        disk.avail->ring[disk.avail->idx % NUM_DESCS] = idx[0];
        __sync_synchronize();
        disk.avail->idx++;
        __sync_synchronize();

        // Notify Device
        *REG(VIRTIO_MMIO_QUEUE_NOTIFY) = 0;

        // Wait for Completion
        while (disk.info[idx[0]].busy)
        {
            ProcManager::sleep(&disk.info[idx[0]], &disk.lock);
        }

        free_chain_soft(idx[0]);
        disk.lock.release();
    }

    void intr()
    {
        disk.lock.acquire();

        uint32 status = *REG(VIRTIO_MMIO_INTERRUPT_STATUS);
        *REG(VIRTIO_MMIO_INTERRUPT_ACK) = status & 0x3;

        volatile struct VRingUsed *used_ring = (volatile struct VRingUsed *)disk.used;

        while (disk.used_idx != used_ring->idx)
        {
            int id = used_ring->ring[disk.used_idx % NUM_DESCS].id;

            if (disk.info[id].busy)
            {
                disk.info[id].busy = 0;
                ProcManager::wakeup(&disk.info[id]);
            }
            disk.used_idx++;
        }

        disk.lock.release();
    }

    void test_rw()
    {
        Drivers::uart_puts(ANSI_BLUE "[VirtIO] Disk Test Start...\n" ANSI_RESET);

        char *buf = (char *)PMM::alloc_page();
        if (!buf)
            return;

        const char *msg = "Lume OS Disk Driver Test Pattern";
        strcpy(buf, msg);

        rw(1, 0, buf); // Write
        memset(buf, 0, PGSIZE);
        rw(0, 0, buf); // Read

        if (strcmp(buf, msg) == 0)
        {
            Drivers::uart_puts(ANSI_GREEN "[VirtIO] Test PASSED (R/W Verified).\n" ANSI_RESET);
        }
        else
        {
            Drivers::uart_puts(ANSI_RED "[VirtIO] Test FAILED.\n" ANSI_RESET);
        }

        PMM::free_page(buf);
    }

    void test_bio()
    {
        Drivers::uart_puts(ANSI_BLUE "[Bio] Starting Buffer Cache Test...\n" ANSI_RESET);

        struct Buf *b = BufferCache::bread(0, 100);

        Drivers::uart_puts("[Bio] Bread block 100 (1st time).\n");

        b->data[0] = 'L';
        b->data[1] = 'u';
        b->data[2] = 'm';
        b->data[3] = 'e';
        b->data[4] = '\0';

        BufferCache::bwrite(b);
        Drivers::uart_puts("[Bio] Bwrite block 100.\n");

        BufferCache::brelse(b);
        Drivers::uart_puts("[Bio] Brelease block 100.\n");

        struct Buf *b2 = BufferCache::bread(0, 100);
        Drivers::uart_puts("[Bio] Bread block 100 (2nd time).\n");

        if (b2->data[0] == 'L' && b2->data[1] == 'u' && b2->data[3] == 'e')
        {
            Drivers::uart_puts(ANSI_GREEN "[Bio] Data verification PASSED.\n" ANSI_RESET);
        }
        else
        {
            Drivers::uart_puts(ANSI_RED "[Bio] Data verification FAILED.\n" ANSI_RESET);
        }

        BufferCache::brelse(b2);
    }
}