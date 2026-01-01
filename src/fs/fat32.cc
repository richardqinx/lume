#include "fs/fat32.h"
#include "lib/string.h"
#include "drivers/uart.h"
#include "kernel/mm.h"
#include "kernel/proc.h"

FAT32FileSystem fat32_fs;

// FAT32 FileSystem Implementation

void FAT32FileSystem::init()
{
    struct Buf *b = BufferCache::bread(0, 0);
    uint8 *data = (uint8 *)b->data;
    struct FAT32_BPB *bpb = (struct FAT32_BPB *)data;

    uint32 partition_lba = 0;

    bool is_valid_bpb = (bpb->bytesPerSector == 512) && (bpb->rootClus != 0);

    if (!is_valid_bpb)
    {
        Drivers::uart_puts("[FAT32] Sector 0 is not a valid BPB. Checking MBR...\n");

        if (data[510] != 0x55 || data[511] != 0xAA)
        {
            Drivers::uart_puts("[FAT32] Panic: Invalid Disk Signature!\n");
            while (1)
                ;
        }

        uint32 lba = *(uint32 *)(data + 446 + 8);

        if (lba > 0)
        {
            Drivers::uart_puts("[FAT32] MBR Partition 1 found @ Sector ");
            Drivers::uart_put_int(lba);
            Drivers::uart_puts("\n");
            partition_lba = lba;
        }
        else
        {
            Drivers::uart_puts("[FAT32] Panic: No partition found.\n");
            while (1)
                ;
        }

        BufferCache::brelse(b);

        b = BufferCache::bread(0, partition_lba / 2);
        bpb = (struct FAT32_BPB *)b->data;
    }

    if (bpb->bytesPerSector != 512)
    {
        Drivers::uart_puts("[FAT32] Panic: Invalid FAT32 BPB in partition.\n");
        while (1)
            ;
    }

    uint32 fat_sz = bpb->FATSz32;
    uint32 reserved_sec = bpb->reservedSecCnt;
    uint8 num_fats = bpb->numFATs;

    sectors_per_cluster = bpb->secPerClus;
    bytes_per_cluster = sectors_per_cluster * 512;
    root_cluster = bpb->rootClus;

    fat_start_sector = partition_lba + reserved_sec;
    data_start_sector = partition_lba + reserved_sec + (fat_sz * num_fats);

    Drivers::uart_puts("[FAT32] Init Success: RootClus=");
    Drivers::uart_put_int(root_cluster);
    Drivers::uart_puts(", DataStart=");
    Drivers::uart_put_int(data_start_sector);
    Drivers::uart_puts("\n");

    BufferCache::brelse(b);
}

Inode *FAT32FileSystem::root()
{
    FAT32Inode *ip = new FAT32Inode();

    ip->fs = this;
    ip->dev = 0;
    ip->inum = root_cluster;
    ip->ref_cnt = 1;
    ip->valid = 1;
    ip->type = T_DIR;
    ip->size = 0;
    ip->nlink = 1;

    ip->first_clus = root_cluster;
    ip->parent_clus = 0;

    return ip;
}

uint32 FAT32FileSystem::cluster_to_sector(uint32 cluster)
{
    return data_start_sector + (cluster - 2) * sectors_per_cluster;
}

uint32 FAT32FileSystem::next_cluster(uint32 cluster)
{
    uint32 fat_offset = cluster * 4;
    uint32 fat_sector = fat_start_sector + (fat_offset / 512);
    uint32 ent_offset = fat_offset % 512;

    // block = sector / 2
    // offset in block = (sector % 2) * 512 + ent_offset

    struct Buf *b = BufferCache::bread(0, fat_sector / 2);

    uint32 block_offset = (fat_sector % 2) * 512 + ent_offset;
    uint32 next = *(uint32 *)(b->data + block_offset);

    BufferCache::brelse(b);

    return next & 0x0FFFFFFF;
}

// FAT32 Inode Implementation

static bool match_name(const char *disk_name, const char *target)
{
    char temp[13];
    int i, j;

    for (i = 0; i < 8 && disk_name[i] != ' '; i++)
        temp[i] = disk_name[i];
    if (disk_name[8] != ' ')
    {
        temp[i++] = '.';
        for (j = 0; j < 3 && disk_name[8 + j] != ' '; j++)
            temp[i++] = disk_name[8 + j];
    }
    temp[i] = 0;
    return strcasecmp(temp, target) == 0;
}

int FAT32Inode::read(char *dst, uint32 off, uint32 n, int isUser)
{
    if (first_clus == 0)
        return 0;

    uint32 tot = 0;
    uint32 clus = first_clus;
    uint32 clus_sz = fs->bytes_per_cluster;

    uint32 skip = off / clus_sz;
    uint32 current_off = off % clus_sz;

    while (skip > 0)
    {
        clus = fs->next_cluster(clus);
        if (clus >= 0x0FFFFFF8)
            return 0;
        skip--;
    }

    while (tot < n)
    {
        uint32 sec_in_clus = current_off / 512;

        if (sec_in_clus >= fs->sectors_per_cluster)
        {
            clus = fs->next_cluster(clus);
            if (clus >= 0x0FFFFFF8)
                break;
            current_off = 0;
            continue;
        }

        uint32 sec = fs->cluster_to_sector(clus) + sec_in_clus;
        uint32 off_in_sec = current_off % 512;

        uint32 m = 512 - off_in_sec;
        if (n - tot < m)
            m = n - tot;

        struct Buf *b = BufferCache::bread(dev, sec / 2);
        uint32 block_offset = (sec % 2) * 512 + off_in_sec;

        if (isUser)
        {
            if (VM::copyout(myproc()->pagetable, (uint64)dst, (char *)(b->data + block_offset), m) < 0)
            {
                BufferCache::brelse(b);
                return -1;
            }
        }
        else
        {
            memmove(dst, b->data + block_offset, m);
        }
        BufferCache::brelse(b);

        tot += m;
        dst += m;
        current_off += m;
    }
    return tot;
}

Inode *FAT32Inode::lookup(const char *name)
{
    if (type != T_DIR)
        return nullptr;

    uint32 clus = first_clus;
    struct FAT32_DirEnt de;

    while (clus < 0x0FFFFFF8)
    {
        uint32 sec = fs->cluster_to_sector(clus);

        for (int i = 0; i < fs->sectors_per_cluster; i++)
        {
            uint32 current_sec = sec + i;
            struct Buf *b = BufferCache::bread(dev, current_sec / 2);
            uint32 block_base = (current_sec % 2) * 512;

            for (int off = 0; off < 512; off += 32)
            {
                memmove(&de, b->data + block_base + off, 32);

                if (de.name[0] == 0x00)
                {
                    BufferCache::brelse(b);
                    return nullptr;
                }
                if (de.name[0] == 0xE5)
                    continue;
                if (de.attr & ATTR_LONG_NAME)
                    continue;

                if (match_name(de.name, name))
                {
                    FAT32Inode *ip = new FAT32Inode();
                    ip->fs = fs;
                    ip->dev = dev;
                    ip->type = (de.attr & ATTR_DIRECTORY) ? T_DIR : T_FILE;
                    ip->size = de.fileSize;
                    ip->first_clus = (de.fstClusHI << 16) | de.fstClusLO;
                    ip->inum = ip->first_clus;
                    ip->nlink = 1;
                    ip->ref_cnt = 1;
                    ip->valid = 1;

                    BufferCache::brelse(b);
                    return ip;
                }
            }
            BufferCache::brelse(b);
        }
        clus = fs->next_cluster(clus);
    }
    return nullptr;
}

// Placeholder
void FAT32Inode::update() {}
int FAT32Inode::write(const char *src, uint32 off, uint32 n, int isUser) { return -1; }
Inode *FAT32Inode::create(const char *name, short type, short major, short minor) { return nullptr; }
void FAT32Inode::truncate() {}
uint32 FAT32FileSystem::alloc_cluster() { return 0; }

// Test Function
void fat32_test()
{
    static bool inited = false;
    if (!inited)
    {
        fat32_fs.init();
        inited = true;
    }

    Drivers::uart_puts("\n[FAT32] Starting Test via Syscall...\n");

    Inode *root = fat32_fs.root();
    if (root)
    {
        Drivers::uart_puts("[FAT32] Root Inode retrieved. Inum: ");
        Drivers::uart_put_int(root->inum);
        Drivers::uart_puts("\n");

        Drivers::uart_puts("[FAT32] Looking for TEST.TXT...\n");
        Inode *node = root->lookup("test.txt");

        if (node)
        {
            Drivers::uart_puts("[FAT32] Found TEST.TXT! Size: ");
            Drivers::uart_put_int(node->size);
            Drivers::uart_puts("\n");

            char buf[128];
            int n = node->read(buf, 0, 127, 0);
            if (n > 0)
            {
                buf[n] = 0;
                Drivers::uart_puts("[FAT32] Content:\n>> ");
                Drivers::uart_puts(buf);
                Drivers::uart_puts("\n");
            }
            else
            {
                Drivers::uart_puts("[FAT32] Read returned 0.\n");
            }
            VFS::iput(node);
        }
        else
        {
            Drivers::uart_puts("[FAT32] TEST.TXT not found.\n");
        }
        VFS::iput(root);
    }
    else
    {
        Drivers::uart_puts("[FAT32] Failed to get root inode.\n");
    }

    Drivers::uart_puts("[FAT32] Test Finished.\n");
}