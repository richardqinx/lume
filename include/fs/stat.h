#pragma once
#include "common/types.h"

#define T_DIR 1    // Directory
#define T_FILE 2   // File
#define T_DEVICE 3 // Device

struct kstat
{
    int dev;        // File System's disk device
    uint32 ino;     // Inode number
    short type;     //Type of file
    short nlink;    // Number of links to file
    uint64 size;    // Size of file in bytes

    uint32 mode;  // Protection: rwx
    uint32 uid;   // User ID
    uint32 gid;   // Group ID
    uint32 atime; // Access time
    uint32 mtime; // Modified time
    uint32 ctime; // Change time
};
