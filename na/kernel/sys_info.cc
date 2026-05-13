/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * System Information Calls
 *
 * Implements: uname
 *
 * Reference: docs/specs/syscall.md §7.3
 */

#include <lume/types.h>
#include <lume/errno.h>
#include <lume/uaccess.h>

/* Linux-compatible utsname structure (65-byte fields) */
struct utsname {
    char sysname[65];
    char nodename[65];
    char release[65];
    char version[65];
    char machine[65];
    char domainname[65];
};

/* Simple safe string copy */
static void safe_strncpy(char* dst, const char* src, uint64 n)
{
    uint64 i = 0;
    for (; i < n - 1 && src[i] != '\0'; i++)
        dst[i] = src[i];
    dst[i] = '\0';
}

int64 sys_uname(uint64 buf_ptr, uint64, uint64, uint64, uint64, uint64)
{
    utsname info = {};
    safe_strncpy(info.sysname,    "LumeOS",  sizeof(info.sysname));
    safe_strncpy(info.nodename,   "lume",    sizeof(info.nodename));
    safe_strncpy(info.release,    "0.1.0",   sizeof(info.release));
    safe_strncpy(info.version,    "Phase 2", sizeof(info.version));
    safe_strncpy(info.machine,    "riscv64", sizeof(info.machine));
    safe_strncpy(info.domainname, "(none)",  sizeof(info.domainname));

    if (copy_to_user(buf_ptr, &info, sizeof(info)) < 0)
        return -EFAULT;

    return 0;
}
