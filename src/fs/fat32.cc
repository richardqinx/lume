#include "fs/fat32.h"
#include "lib/string.h"
#include "drivers/uart.h"
#include "kernel/mm.h"
#include "kernel/proc.h"

FAT32FileSystem fat32_fs;

// Helper function
static void generate_short_name(char *dst, const char *src)
{
    memset(dst, ' ', 11);

    int i = 0;
    for (; *src && *src != '.' && i < 8; src++)
    {
        char c = *src;
        if (c >= 'a' && c <= 'z')
            c -= 32;
        dst[i++] = c;
    }

    while (*src && *src != '.')
        src++;
    if (*src == '.')
        src++;

    i = 8;
    for (; *src && i < 11; src++)
    {
        char c = *src;
        if (c >= 'a' && c <= 'z')
            c -= 32;
        dst[i++] = c;
    }
}

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
    this->fat_sz = fat_sz;
    uint32 reserved_sec = bpb->reservedSecCnt;
    uint8 num_fats = bpb->numFATs;

    sectors_per_cluster = bpb->secPerClus;
    bytes_per_cluster = sectors_per_cluster * 512;
    root_cluster = bpb->rootClus;

    fat_start_sector = partition_lba + reserved_sec;
    data_start_sector = partition_lba + reserved_sec + (fat_sz * num_fats);

    Drivers::uart_puts(ANSI_GREEN);
    Drivers::uart_puts("[FAT32] Init Success: RootClus=");
    Drivers::uart_put_int(root_cluster);
    Drivers::uart_puts(", DataStart=");
    Drivers::uart_put_int(data_start_sector);
    Drivers::uart_puts(ANSI_RESET);
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

    // [FIX] 只有非目录文件才检查 size 边界
    // 目录文件 size 可能为 0，应允许读取直到簇链结束
    if (type != T_DIR)
    {
        if (off >= size)
        {
            return 0;
        }
        if (off + n > size)
        {
            n = size - off;
        }
    }

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

        for (uint32 i = 0; i < fs->sectors_per_cluster; i++)
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
                    ip->ent_sec = current_sec; // Log Sector
                    ip->ent_off = off;         // Log Setoff

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
uint32 FAT32FileSystem::alloc_cluster()
{
    uint32 fat_entries_per_sector = 512 / 4;
    for (uint32 i = 0; i < fat_sz; i++)
    {
        uint32 current_fat_sec = fat_start_sector + i;
        struct Buf *b = BufferCache::bread(0, current_fat_sec / 2);
        uint32 *table = (uint32 *)(b->data + (current_fat_sec % 2) * 512);
        for (uint32 j = 0; j < fat_entries_per_sector; j++)
        {
            if (i == 0 && j < 2)
                continue;

            if ((table[j] & 0x0FFFFFFF) == 0)
            {
                // Find the free cluster and mark it as EOF (0x0FFFFFFF)
                table[j] = 0x0FFFFFFF;
                BufferCache::bwrite(b); // Write back to disk
                BufferCache::brelse(b);

                uint32 cluster_idx = i * fat_entries_per_sector + j;

                // Clear the data content of the new cluster
                uint32 data_sec = cluster_to_sector(cluster_idx);
                for (uint32 k = 0; k < sectors_per_cluster; k++)
                {
                    struct Buf *db = BufferCache::bread(0, (data_sec + k) / 2);
                    memset(db->data + ((data_sec + k) % 2) * 512, 0, 512);
                    BufferCache::bwrite(db);
                    BufferCache::brelse(db);
                }

                return cluster_idx;
            }
        }
        BufferCache::brelse(b);
    }
    Drivers::uart_puts("[FAT32] Out of space!\n");
    return 0;
}

void FAT32FileSystem::free_cluster_chain(uint32 cluster)
{
    while (cluster >= 2 && cluster < 0x0FFFFFF8)
    {
        uint32 next = next_cluster(cluster);

        // Calculate the current cluster's position in the FAT table
        uint32 fat_offset = cluster * 4;
        uint32 fat_sector = fat_start_sector + (fat_offset / 512);
        uint32 ent_offset = fat_offset % 512;

        // Read FAT sector
        struct Buf *b = BufferCache::bread(0, fat_sector / 2);

        // Marked as idle (0x00000000)
        uint32 *entry = (uint32 *)(b->data + (fat_sector % 2) * 512 + ent_offset);
        *entry = 0;

        BufferCache::bwrite(b);
        BufferCache::brelse(b);

        cluster = next;
    }
}

void FAT32Inode::update()
{
    struct Buf *b = BufferCache::bread(dev, ent_sec / 2);
    uint32 offset = (ent_sec % 2) * 512 + ent_off;

    struct FAT32_DirEnt *de = (struct FAT32_DirEnt *)(b->data + offset);

    // Update file size and starting cluster
    de->fileSize = size;
    de->fstClusHI = (uint16)((first_clus >> 16) & 0xFFFF);
    de->fstClusLO = (uint16)(first_clus & 0xFFFF);

    BufferCache::bwrite(b);
    BufferCache::brelse(b);
}

int FAT32Inode::write(const char *src, uint32 off, uint32 n, int isUser)
{
    if (off > size)
    {
        return -1;
    }

    uint32 tot = 0;
    uint32 clus = first_clus;
    uint32 clus_sz = fs->bytes_per_cluster;
    uint32 prev_clus = 0;

    if (clus == 0)
    {
        clus = fs->alloc_cluster();
        if (clus == 0)
            return -1;
        first_clus = clus;
        // Update the metadata immediately to prevent data loss in case of a power outage.
        update();
    }

    uint32 skip = off / clus_sz;
    uint32 current_off = off % clus_sz;

    while (skip > 0)
    {
        prev_clus = clus;
        clus = fs->next_cluster(clus);
        if (clus >= 0x0FFFFFF8)
        {
            return -1;
        }
        skip--;
    }
    while (tot < n)
    {
        if (current_off == clus_sz)
        {
            uint32 next = fs->next_cluster(clus);
            if (next >= 0x0FFFFFF8)
            {
                uint32 new_clus = fs->alloc_cluster();
                if (new_clus == 0)
                    break;

                // Point the current cluster to the new cluster (update the FAT table)
                uint32 fat_offset = clus * 4;
                uint32 fat_sec = fs->fat_start_sector + (fat_offset / 512);
                struct Buf *fat_b = BufferCache::bread(dev, fat_sec / 2);
                uint32 *entry = (uint32 *)(fat_b->data + (fat_sec % 2) * 512 + (fat_offset % 512));
                *entry = new_clus; // Link
                BufferCache::bwrite(fat_b);
                BufferCache::brelse(fat_b);

                clus = new_clus;
            }
            else
            {
                clus = next;
            }
            current_off = 0;
        }

        // Calculate the physical sector to write
        uint32 sec_in_clus = current_off / 512;
        uint32 sec = fs->cluster_to_sector(clus) + sec_in_clus;
        uint32 off_in_sec = current_off % 512;

        // Calculate how many bytes can be written this time
        uint32 m = 512 - off_in_sec;
        if (n - tot < m)
            m = n - tot;

        struct Buf *b = BufferCache::bread(dev, sec / 2);
        uint32 block_offset = (sec % 2) * 512 + off_in_sec;

        if (isUser)
        {
            if (VM::copyin(myproc()->pagetable, (char *)(b->data + block_offset), (uint64)src, m) < 0)
            {
                BufferCache::brelse(b);
                return -1;
            }
        }
        else
        {
            memmove(b->data + block_offset, src, m);
        }

        BufferCache::bwrite(b);
        BufferCache::brelse(b);

        tot += m;
        src += m;
        current_off += m;
    }
    if (off + n > size)
    {
        size = off + n;
        update();
    }

    return tot;
}

Inode *FAT32Inode::create(const char *name, short type, short major, short minor)
{
    Inode *exist = lookup(name);
    if (exist)
    {
        return exist;
    }

    struct FAT32_DirEnt de;
    memset(&de, 0, sizeof(de));
    generate_short_name(de.name, name);
    de.attr = (type == T_DIR) ? ATTR_DIRECTORY : ATTR_ARCHIVE;

    uint32 new_dir_clus = 0;
    if (type == T_DIR)
    {
        new_dir_clus = fs->alloc_cluster();
        if (new_dir_clus == 0)
            return nullptr;

        de.fstClusHI = (uint16)((new_dir_clus >> 16) & 0xFFFF);
        de.fstClusLO = (uint16)(new_dir_clus & 0xFFFF);
    }
    else
    {
        de.fileSize = 0;
    }

    uint32 clus = first_clus;
    bool written = false;

    while (true)
    {
        uint32 sec = fs->cluster_to_sector(clus);

        for (uint32 i = 0; i < fs->sectors_per_cluster; i++)
        {
            struct Buf *b = BufferCache::bread(dev, (sec + i) / 2);
            uint8 *data = (uint8 *)b->data + ((sec + i) % 2) * 512;

            for (int off = 0; off < 512; off += 32)
            {
                if (data[off] == 0x00 || data[off] == 0xE5)
                {
                    memmove(data + off, &de, 32);
                    BufferCache::bwrite(b);
                    BufferCache::brelse(b);
                    written = true;
                    break;
                }
            }

            if (written)
                break;
            BufferCache::brelse(b);
        }

        if (written)
            break;

        uint32 next = fs->next_cluster(clus);
        if (next >= 0x0FFFFFF8)
        {
            uint32 new_parent_clus = fs->alloc_cluster();
            if (new_parent_clus == 0)
                return nullptr;

            uint32 fat_off = clus * 4;
            uint32 fat_sec = fs->fat_start_sector + (fat_off / 512);
            struct Buf *fb = BufferCache::bread(dev, fat_sec / 2);
            *(uint32 *)(fb->data + (fat_sec % 2) * 512 + (fat_off % 512)) = new_parent_clus;
            BufferCache::bwrite(fb);
            BufferCache::brelse(fb);

            uint32 s = fs->cluster_to_sector(new_parent_clus);
            for (uint32 k = 0; k < fs->sectors_per_cluster; k++)
            {
                struct Buf *zb = BufferCache::bread(dev, (s + k) / 2);
                uint8 *zdata = (uint8 *)zb->data + ((s + k) % 2) * 512;
                memset(zdata, 0, 512);

                if (k == 0)
                {
                    memmove(zdata, &de, 32);
                }

                BufferCache::bwrite(zb);
                BufferCache::brelse(zb);
            }

            written = true;
            break;
        }
        clus = next;
    }

    if (written && type == T_DIR)
    {
        struct FAT32_DirEnt dot;
        memset(&dot, 0, 32);
        memset(dot.name, ' ', 11);
        dot.name[0] = '.';
        dot.attr = ATTR_DIRECTORY;
        dot.fstClusHI = (uint16)((new_dir_clus >> 16) & 0xFFFF);
        dot.fstClusLO = (uint16)(new_dir_clus & 0xFFFF);

        struct FAT32_DirEnt dotdot;
        memset(&dotdot, 0, 32);
        memset(dotdot.name, ' ', 11);
        dotdot.name[0] = '.';
        dotdot.name[1] = '.';
        dotdot.attr = ATTR_DIRECTORY;

        uint32 parent_clus_num = this->first_clus;
        if (parent_clus_num == fs->root_cluster)
        {
            parent_clus_num = 0;
        }
        dotdot.fstClusHI = (uint16)((parent_clus_num >> 16) & 0xFFFF);
        dotdot.fstClusLO = (uint16)(parent_clus_num & 0xFFFF);

        uint32 s = fs->cluster_to_sector(new_dir_clus);

        struct Buf *zb = BufferCache::bread(dev, s / 2);
        uint8 *zdata = (uint8 *)zb->data + (s % 2) * 512;

        memmove(zdata, &dot, 32);         // Offset 0
        memmove(zdata + 32, &dotdot, 32); // Offset 32

        BufferCache::bwrite(zb);
        BufferCache::brelse(zb);
    }

    if (written)
    {
        return lookup(name);
    }

    return nullptr;
}

void FAT32Inode::truncate()
{
    if (first_clus == 0)
    {
        if (size != 0)
        {
            size = 0;
            update();
        }
        return;
    }

    fs->free_cluster_chain(first_clus);

    size = 0;
    first_clus = 0;

    update();
}

int FAT32Inode::unlink(const char *name)
{
    if (type != T_DIR)
        return -1;
    if (strcmp(name, ".") == 0 || strcmp(name, "..") == 0)
        return -1;

    uint32_t clus = first_clus;
    bool found = false;

    // [FIX] Deadlock prevention: Do not hold buffer while looking up inode
    uint32_t target_block = 0;
    uint32_t target_offset = 0;
    struct FAT32_DirEnt de;

    while (true)
    {
        uint32_t sec = fs->cluster_to_sector(clus);
        for (uint32 i = 0; i < fs->sectors_per_cluster; ++i)
        {
            struct Buf *b = BufferCache::bread(dev, (sec + i) / 2);
            uint8_t *data = (uint8_t *)b->data + ((sec + i) % 2) * 512;

            for (int off = 0; off < 512; off += 32)
            {
                memmove(&de, data + off, 32);
                if (de.name[0] == 0x00) // end of dir
                {
                    BufferCache::brelse(b);
                    return -1; // Not found
                }
                if (de.name[0] == 0xE5)
                    continue; // have been unlink
                if (de.attr & ATTR_LONG_NAME)
                    continue;

                if (match_name(de.name, name))
                {
                    target_block = (sec + i) / 2;
                    target_offset = ((sec + i) % 2) * 512 + off;
                    found = true;
                    break;
                }
            }

            BufferCache::brelse(b); // Always release buffer
            if (found)
                break;
        }

        if (found)
            break;

        clus = fs->next_cluster(clus);
        if (clus >= 0x0FFFFFF8)
            return -1;
    }

    if (found)
    {
        Inode *target_ip = lookup(name);
        if (target_ip)
        {
            VFS::ilock(target_ip);
            if (target_ip->type == T_DIR)
            {
                VFS::iunlockput(target_ip);
                return -1;
            }

            target_ip->nlink--;
            target_ip->update();
            VFS::iunlockput(target_ip);
        }

        // Re-read buffer to mark deletion
        struct Buf *target_buf = BufferCache::bread(dev, target_block);
        uint8_t *ptr = (uint8_t *)target_buf->data + target_offset;
        *ptr = 0xE5;

        BufferCache::bwrite(target_buf);
        BufferCache::brelse(target_buf);
        return 0;
    }

    return -1;
}

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