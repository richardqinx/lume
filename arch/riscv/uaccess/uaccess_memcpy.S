/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#include <arch/extable.h>

/*
 * extern "C" int __uaccess_memcpy(void* dst, const void* src, uint64 len);
 *
 * a0: dst
 * a1: src
 * a2: len
 * Returns: 0 on success, -EFAULT (-14) on page fault.
 */
.global __uaccess_memcpy
.type __uaccess_memcpy, @function
__uaccess_memcpy:
    /* If len == 0, return 0 */
    beqz a2, .Lmemcpy_done

    /* Enable SUM (Supervisor User Memory) bit: sstatus.SUM is bit 18 */
    li t0, (1 << 18)
    csrs sstatus, t0

.Lmemcpy_loop:
    /* Load byte from src */
1:  lb t1, 0(a1)
    /* Store byte to dst */
2:  sb t1, 0(a0)

    addi a0, a0, 1
    addi a1, a1, 1
    addi a2, a2, -1
    bnez a2, .Lmemcpy_loop

.Lmemcpy_done:
    /* Disable SUM */
    li t0, (1 << 18)
    csrc sstatus, t0
    li a0, 0
    ret

.Lmemcpy_fault:
    /* Fixup routine on fault */
    /* Disable SUM */
    li t0, (1 << 18)
    csrc sstatus, t0
    li a0, -14 /* -EFAULT */
    ret

/* Exception table entries */
EXTABLE(1b, .Lmemcpy_fault)
EXTABLE(2b, .Lmemcpy_fault)


/*
 * extern "C" int64 __uaccess_strncpy(char* dst, const char* src, uint64 max_len);
 *
 * a0: dst
 * a1: src
 * a2: max_len
 * Returns: number of bytes copied (excluding null), or -EFAULT (-14) on page fault.
 */
.global __uaccess_strncpy
.type __uaccess_strncpy, @function
__uaccess_strncpy:
    /* If max_len == 0, return 0 */
    beqz a2, .Lstrncpy_done_zero

    /* Enable SUM */
    li t0, (1 << 18)
    csrs sstatus, t0

    /* t2 will store the length copied */
    li t2, 0

.Lstrncpy_loop:
    /* Load byte from src */
3:  lb t1, 0(a1)
    /* Store byte to dst */
4:  sb t1, 0(a0)

    /* If it was the null terminator, we're done */
    beqz t1, .Lstrncpy_done

    addi a0, a0, 1
    addi a1, a1, 1
    addi t2, t2, 1
    addi a2, a2, -1
    bnez a2, .Lstrncpy_loop

    /* Reached max_len without finding null */
    /* We must null-terminate at max_len - 1 as per typical strncpy_from_user semantics */
    addi a0, a0, -1
    sb zero, 0(a0)
    addi t2, t2, -1 /* length of string without the forced null terminator */

.Lstrncpy_done:
    /* Disable SUM */
    li t0, (1 << 18)
    csrc sstatus, t0
    mv a0, t2
    ret

.Lstrncpy_done_zero:
    li a0, 0
    ret

.Lstrncpy_fault:
    /* Fixup routine on fault */
    li t0, (1 << 18)
    csrc sstatus, t0
    li a0, -14 /* -EFAULT */
    ret

/* Exception table entries */
EXTABLE(3b, .Lstrncpy_fault)
EXTABLE(4b, .Lstrncpy_fault)
