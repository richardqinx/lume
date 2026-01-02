#pragma once
#include "common/types.h"
#include "kernel/spinlock.h"
#include "fs/stat.h"

class FileSystem;

// VFS Inode (Abstract Base Class)

class Inode
{
private:
    ;
public:
    // VFS Common Fields
    uint32 dev;  // Device number (VirtIO Block ID)
    uint32 inum; // Inode number
    int ref_cnt; // Memory reference count (number of struct file or processes referencing it)
    int valid;   // Whether the data is valid (whether metadata has been read from disk)

    Mutex lock; // Sleep lock: protects internal Inode data and atomicity of read/write operations

    // Metadata Cache (for speeding up getattr)
    short type;  // T_DIR, T_FILE, T_DEVICE
    short major; // Major device number (only for T_DEVICE)
    short minor; // Minor device number (only for T_DEVICE)
    short nlink; // Number of hard links
    uint32 size; // File size

    Inode() : ref_cnt(0), valid(0)
    {
        lock.init("inode");
    }
    virtual ~Inode() {}

    /* Core Operation Interface (Subclass Must Implement) */
    // Update metadata
    // Sync size, type, links, etc. from memory back to disk
    virtual void update() = 0;
    // Read content
    // Read n bytes from the file at offset into dst
    // Returns the actual number of bytes read, returns -1 on error
    virtual int read(char *dst, uint32 off, uint32 n, int isUser) = 0;
    // 3. Write content
    // Write n bytes from src to the file at the given offset
    // Need to handle file growth
    virtual int write(const char *src, uint32 off, uint32 n, int isUser) = 0;
    // Directory Lookup (only valid when type == T_DIR)
    // Search for a file named 'name' in the current directory and return its Inode pointer (locked)
    // Return nullptr if not found
    virtual Inode *lookup(const char *name) = 0;
    // Create file/directory (only effective when type == T_DIR)
    // Create a new entry in the current directory
    virtual Inode *create(const char *name, short type, short major, short minor) = 0;
    // Get file status (populate the stat structure)
    // Default implementation, subclasses can override to provide more detailed information
    virtual void getattr(struct kstat *st);
    // Truncate file (set size to 0, release all data blocks)
    virtual void truncate() = 0;
};

// File System Abstraction (SuperBlock)
class FileSystem
{
private:
    ;
public:
    virtual void init() = 0;
    virtual Inode* root() = 0;
    virtual ~FileSystem() {};
};

// Inode Cache Interface (Global Function)
namespace VFS
{
    void init();

    // Decrease the reference count, and if it reaches 0, free the memory
    void iput(Inode *ip);
    // Increase reference count
    Inode *idup(Inode *ip);
    // lock and load data
    void ilock(Inode *ip);
    // unlock
    void iunlock(Inode *ip);
    void iunlockput(Inode *ip);
    // Mount the root filesystem
    void mount_root(Inode *root);
    // Get system root node
    Inode *get_root();
    // Path Analysis
    Inode *namei(const char *path);
} // namespace VFS
