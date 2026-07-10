/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * PtRegs ↔ TrapFrame conversion
 *
 * This is the ONLY file that knows both the internal TrapFrame layout
 * and the Linux-ABI PtRegs layout.  When TrapFrame is restructured
 * (e.g., to embed pt_regs directly), only this file needs to change.
 */

#include <lume/ptrace.h>
#include <arch/trapframe.h>

void trapframe_to_pt_regs(PtRegs* dst, const arch::TrapFrame* src,
                          uint64 scause, uint64 stval)
{
    dst->epc    = src->epc;
    dst->ra     = src->ra;
    dst->sp     = src->sp;
    dst->gp     = src->gp;
    dst->tp     = src->tp;
    dst->t0     = src->t[0];
    dst->t1     = src->t[1];
    dst->t2     = src->t[2];
    dst->s0     = src->s[0];
    dst->s1     = src->s[1];
    dst->a0     = src->a[0];
    dst->a1     = src->a[1];
    dst->a2     = src->a[2];
    dst->a3     = src->a[3];
    dst->a4     = src->a[4];
    dst->a5     = src->a[5];
    dst->a6     = src->a[6];
    dst->a7     = src->a[7];
    dst->s2     = src->s[2];
    dst->s3     = src->s[3];
    dst->s4     = src->s[4];
    dst->s5     = src->s[5];
    dst->s6     = src->s[6];
    dst->s7     = src->s[7];
    dst->s8     = src->s[8];
    dst->s9     = src->s[9];
    dst->s10    = src->s[10];
    dst->s11    = src->s[11];
    dst->t3     = src->t[3];
    dst->t4     = src->t[4];
    dst->t5     = src->t[5];
    dst->t6     = src->t[6];
    dst->status  = src->sstatus;
    dst->badaddr = stval;
    dst->cause   = scause;
    dst->orig_a0 = src->a[0]; /* Caller should set this before syscall dispatch */
}

void pt_regs_to_trapframe(arch::TrapFrame* dst, const PtRegs* src)
{
    dst->epc     = src->epc;
    dst->ra      = src->ra;
    dst->sp      = src->sp;
    dst->gp      = src->gp;
    dst->tp      = src->tp;
    dst->t[0]    = src->t0;
    dst->t[1]    = src->t1;
    dst->t[2]    = src->t2;
    dst->s[0]    = src->s0;
    dst->s[1]    = src->s1;
    dst->a[0]    = src->a0;
    dst->a[1]    = src->a1;
    dst->a[2]    = src->a2;
    dst->a[3]    = src->a3;
    dst->a[4]    = src->a4;
    dst->a[5]    = src->a5;
    dst->a[6]    = src->a6;
    dst->a[7]    = src->a7;
    dst->s[2]    = src->s2;
    dst->s[3]    = src->s3;
    dst->s[4]    = src->s4;
    dst->s[5]    = src->s5;
    dst->s[6]    = src->s6;
    dst->s[7]    = src->s7;
    dst->s[8]    = src->s8;
    dst->s[9]    = src->s9;
    dst->s[10]   = src->s10;
    dst->s[11]   = src->s11;
    dst->t[3]    = src->t3;
    dst->t[4]    = src->t4;
    dst->t[5]    = src->t5;
    dst->t[6]    = src->t6;
    dst->sstatus = src->status;
    /* badaddr and cause are CSR values, not written back to TrapFrame */
}
