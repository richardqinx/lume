/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * fs_types.h — File mode constants, open flags, seek constants
 *
 * All values match Linux asm-generic so musl/busybox binaries work.
 * Reference: docs/vfs/02_inode.md, docs/vfs/04_file.md
 */

#include <lume/types.h>

/* ================================================================== */
/*  S_IF* — file type in inode::i_mode upper bits                     */
/* ================================================================== */

inline constexpr uint32 S_IFMT   = 0170000;
inline constexpr uint32 S_IFSOCK = 0140000;
inline constexpr uint32 S_IFLNK  = 0120000;
inline constexpr uint32 S_IFREG  = 0100000;
inline constexpr uint32 S_IFBLK  = 0060000;
inline constexpr uint32 S_IFDIR  = 0040000;
inline constexpr uint32 S_IFCHR  = 0020000;
inline constexpr uint32 S_IFIFO  = 0010000;

inline constexpr uint32 S_ISUID  = 04000;
inline constexpr uint32 S_ISGID  = 02000;
inline constexpr uint32 S_ISVTX  = 01000;

inline constexpr uint32 S_IRWXU  = 00700;
inline constexpr uint32 S_IRUSR  = 00400;
inline constexpr uint32 S_IWUSR  = 00200;
inline constexpr uint32 S_IXUSR  = 00100;
inline constexpr uint32 S_IRWXG  = 00070;
inline constexpr uint32 S_IRGRP  = 00040;
inline constexpr uint32 S_IWGRP  = 00020;
inline constexpr uint32 S_IXGRP  = 00010;
inline constexpr uint32 S_IRWXO  = 00007;
inline constexpr uint32 S_IROTH  = 00004;
inline constexpr uint32 S_IWOTH  = 00002;
inline constexpr uint32 S_IXOTH  = 00001;

inline bool S_ISREG(uint32 m)  { return (m & S_IFMT) == S_IFREG; }
inline bool S_ISDIR(uint32 m)  { return (m & S_IFMT) == S_IFDIR; }
inline bool S_ISCHR(uint32 m)  { return (m & S_IFMT) == S_IFCHR; }
inline bool S_ISBLK(uint32 m)  { return (m & S_IFMT) == S_IFBLK; }
inline bool S_ISFIFO(uint32 m) { return (m & S_IFMT) == S_IFIFO; }
inline bool S_ISLNK(uint32 m)  { return (m & S_IFMT) == S_IFLNK; }
inline bool S_ISSOCK(uint32 m) { return (m & S_IFMT) == S_IFSOCK; }

/* ================================================================== */
/*  O_* — open(2) flags                                               */
/* ================================================================== */

inline constexpr int O_RDONLY     = 00;
inline constexpr int O_WRONLY     = 01;
inline constexpr int O_RDWR       = 02;
inline constexpr int O_ACCMODE    = 03;
inline constexpr int O_CREAT      = 0100;
inline constexpr int O_EXCL       = 0200;
inline constexpr int O_NOCTTY     = 0400;
inline constexpr int O_TRUNC      = 01000;
inline constexpr int O_APPEND     = 02000;
inline constexpr int O_NONBLOCK   = 04000;
inline constexpr int O_DSYNC      = 010000;
inline constexpr int O_DIRECTORY  = 0200000;
inline constexpr int O_NOFOLLOW   = 0400000;
inline constexpr int O_CLOEXEC    = 02000000;

/* ================================================================== */
/*  AT_* — *at() syscall dirfd constants                              */
/* ================================================================== */

inline constexpr int AT_FDCWD             = -100;
inline constexpr int AT_REMOVEDIR         = 0x200;
inline constexpr int AT_SYMLINK_NOFOLLOW  = 0x100;
inline constexpr int AT_EMPTY_PATH        = 0x1000;

/* ================================================================== */
/*  SEEK_* — lseek(2) whence                                         */
/* ================================================================== */

inline constexpr int SEEK_SET = 0;
inline constexpr int SEEK_CUR = 1;
inline constexpr int SEEK_END = 2;

/* ================================================================== */
/*  FMODE_* — internal file mode flags                                */
/* ================================================================== */

inline constexpr uint32 FMODE_READ      = (1U << 0);
inline constexpr uint32 FMODE_WRITE     = (1U << 1);
inline constexpr uint32 FMODE_LSEEK     = (1U << 2);
inline constexpr uint32 FMODE_PREAD     = (1U << 3);
inline constexpr uint32 FMODE_PWRITE    = (1U << 4);
inline constexpr uint32 FMODE_EXEC      = (1U << 5);
inline constexpr uint32 FMODE_CAN_READ  = (1U << 17);
inline constexpr uint32 FMODE_CAN_WRITE = (1U << 18);
inline constexpr uint32 FMODE_OPENED    = (1U << 19);
inline constexpr uint32 FMODE_CREATED   = (1U << 20);
inline constexpr uint32 FMODE_STREAM    = (1U << 21);

/* ================================================================== */
/*  MAY_* — permission check flags                                    */
/* ================================================================== */

inline constexpr int MAY_EXEC  = 0x00000001;
inline constexpr int MAY_WRITE = 0x00000002;
inline constexpr int MAY_READ  = 0x00000004;
inline constexpr int MAY_OPEN  = 0x00000020;
inline constexpr int MAY_CHDIR = 0x00000040;

/* ================================================================== */
/*  DT_* — directory entry types (for getdents64)                     */
/* ================================================================== */

inline constexpr uint8 DT_UNKNOWN = 0;
inline constexpr uint8 DT_FIFO    = 1;
inline constexpr uint8 DT_CHR     = 2;
inline constexpr uint8 DT_DIR     = 4;
inline constexpr uint8 DT_BLK     = 6;
inline constexpr uint8 DT_REG     = 8;
inline constexpr uint8 DT_LNK     = 10;
inline constexpr uint8 DT_SOCK    = 12;

/* ================================================================== */
/*  SB_* — super_block flags                                          */
/* ================================================================== */

inline constexpr uint64 SB_RDONLY      = (1ULL << 0);
inline constexpr uint64 SB_NOSUID      = (1ULL << 1);
inline constexpr uint64 SB_NODEV       = (1ULL << 2);
inline constexpr uint64 SB_NOEXEC      = (1ULL << 3);
inline constexpr uint64 SB_SYNCHRONOUS = (1ULL << 4);
inline constexpr uint64 SB_NOATIME     = (1ULL << 10);
inline constexpr uint64 SB_NODIRATIME  = (1ULL << 11);
inline constexpr uint64 SB_SILENT      = (1ULL << 15);
inline constexpr uint64 SB_KERNMOUNT   = (1ULL << 22);
inline constexpr uint64 SB_LAZYTIME    = (1ULL << 25);
inline constexpr uint64 SB_ACTIVE      = (1ULL << 30);

/* ================================================================== */
/*  MNT_* — mount flags                                               */
/* ================================================================== */

inline constexpr int MNT_NOSUID     = 0x01;
inline constexpr int MNT_NODEV      = 0x02;
inline constexpr int MNT_NOEXEC     = 0x04;
inline constexpr int MNT_NOATIME    = 0x08;
inline constexpr int MNT_RELATIME   = 0x20;
inline constexpr int MNT_READONLY   = 0x40;
inline constexpr int MNT_INTERNAL   = 0x4000;

/* ================================================================== */
/*  Inode state flags                                                 */
/* ================================================================== */

inline constexpr uint32 I_NEW           = (1U << 0);
inline constexpr uint32 I_DIRTY_SYNC    = (1U << 4);
inline constexpr uint32 I_DIRTY_DATASYNC = (1U << 5);
inline constexpr uint32 I_DIRTY_PAGES   = (1U << 6);
inline constexpr uint32 I_WILL_FREE     = (1U << 7);
inline constexpr uint32 I_FREEING       = (1U << 8);
inline constexpr uint32 I_CLEAR         = (1U << 9);
inline constexpr uint32 I_REFERENCED    = (1U << 10);
inline constexpr uint32 I_DIRTY_TIME    = (1U << 12);
inline constexpr uint32 I_CREATING      = (1U << 15);

inline constexpr uint32 I_DIRTY_INODE = I_DIRTY_SYNC | I_DIRTY_DATASYNC;
inline constexpr uint32 I_DIRTY       = I_DIRTY_INODE | I_DIRTY_PAGES;

/* ================================================================== */
/*  DCACHE_* — dentry flags                                           */
/* ================================================================== */

inline constexpr uint32 DCACHE_OP_HASH        = (1U << 0);
inline constexpr uint32 DCACHE_OP_COMPARE     = (1U << 1);
inline constexpr uint32 DCACHE_OP_REVALIDATE  = (1U << 2);
inline constexpr uint32 DCACHE_DISCONNECTED   = (1U << 5);
inline constexpr uint32 DCACHE_REFERENCED     = (1U << 6);
inline constexpr uint32 DCACHE_CANT_MOUNT     = (1U << 8);
inline constexpr uint32 DCACHE_MOUNTED        = (1U << 15);
inline constexpr uint32 DCACHE_ENTRY_TYPE     = (7U << 19);
inline constexpr uint32 DCACHE_MISS_TYPE      = (0U << 19);
inline constexpr uint32 DCACHE_DIRECTORY_TYPE = (2U << 19);
inline constexpr uint32 DCACHE_REGULAR_TYPE   = (4U << 19);
inline constexpr uint32 DCACHE_SPECIAL_TYPE   = (5U << 19);
inline constexpr uint32 DCACHE_SYMLINK_TYPE   = (6U << 19);

/* ================================================================== */
/*  FS_* — file_system_type flags                                     */
/* ================================================================== */

inline constexpr int FS_REQUIRES_DEV = 1;
inline constexpr int FS_NO_DEVICE    = 2;
