#pragma once
#include "fs/fs.h"
#include "kernel/buf.h"

// Disk Layout Structures (On-Disk)

// FAT32 Boot Sector (BPB)
struct FAT32_BPB
{
    uint8 jmpBoot[3];
    char oemName[8];
    uint16 bytesPerSector;
    uint8 secPerClus;
    uint16 reservedSecCnt;
    uint8 numFATs;
    uint16 rootEntCnt;
    uint16 totSec16;
    uint8 media;
    uint16 FATSz16;
    uint16 secPerTrk;
    uint16 numHeads;
    uint32 hiddSec;
    uint32 totSec32;
    uint32 FATSz32;
    uint16 extFlags;
    uint16 FSVer;
    uint32 rootClus;
    uint16 FSInfo;
    uint16 bkBootSec;
    uint8 reserved[12];
    uint8 drvNum;
    uint8 reserved1;
    uint8 bootSig;
    uint32 volID;
    char volLab[11];
    char filSysType[8];
} __attribute__((packed));

// FAT32 Directory Entry (32 bytes)
struct FAT32_DirEnt
{
    char name[11]; // 8.3 filename
    uint8 attr;    // File attributes
    uint8 ntRes;
    uint8 crtTimeTenth;
    uint16 crtTime;
    uint16 crtDate;
    uint16 lstAccDate;
    uint16 fstClusHI; // High 16 bits of first cluster
    uint16 wrtTime;
    uint16 wrtDate;
    uint16 fstClusLO; // Low 16 bits of first cluster
    uint32 fileSize;
} __attribute__((packed));

#define ATTR_READ_ONLY 0x01
#define ATTR_HIDDEN 0x02
#define ATTR_SYSTEM 0x04
#define ATTR_VOLUME_ID 0x08
#define ATTR_DIRECTORY 0x10
#define ATTR_ARCHIVE 0x20
#define ATTR_LONG_NAME 0x0F

// In-Memory Classes

class FAT32FileSystem;

class FAT32Inode : public Inode
{
public:
    FAT32FileSystem *fs;

    // FAT32 Private Data
    uint32 first_clus;  // The starting cluster number of the file
    uint32 parent_clus; // Starting cluster number of the parent directory
    uint32 dir_offset;  // The byte offset of this directory entry in the parent directory

    FAT32Inode() : fs(nullptr), first_clus(0) {}
    // Implement VFS Interface
    void update() override;
    int read(char *dst, uint32 off, uint32 n, int isUser) override;
    int write(const char *src, uint32 off, uint32 n, int isUser) override;
    Inode *lookup(const char *name) override;
    Inode *create(const char *name, short type, short major, short minor) override;
    void truncate() override;
};

class FAT32FileSystem : public FileSystem
{
public:
    uint32 fat_start_sector;
    uint32 data_start_sector;
    uint32 root_cluster;
    uint32 sectors_per_cluster;
    uint32 bytes_per_cluster;

    void init() override;
    Inode* root() override;

    // Helper functions
    uint32 next_cluster(uint32 cluster); // Check the FAT table for the next cluster
    uint32 alloc_cluster();              // Assign a new cluster
    uint32 cluster_to_sector(uint32 cluster);

    // directory entry parsing
    void read_dir_ent(struct FAT32_DirEnt *de, char *filename);
};

extern FAT32FileSystem fat32_fs;

void fat32_test();