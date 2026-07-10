/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * arch/riscv/signal.cc — Signal frame construction and sigreturn
 *
 * Constructs a signal frame on the user stack before returning to
 * the user signal handler. On sigreturn, restores the original
 * registers from the saved frame.
 *
 * Frame layout on user stack (grows downward):
 *
 *   +-----------------------+  <- original sp
 *   |  sigset_t saved_mask  |   8 bytes
 *   |  TrapFrame saved_regs |   296 bytes
 *   |  kernel_siginfo info  |   128 bytes
 *   +-----------------------+  <- new sp (16-byte aligned)
 *
 * Reference: Linux arch/riscv/kernel/signal.c
 */

#include <lume/signal.h>
#include <lume/signal_types.h>
#include <lume/signal_nr.h>
#include <lume/task.h>
#include <lume/uaccess.h>
#include <lume/errno.h>
#include <lume/klog.h>
#include <arch/trapframe.h>

/* ================================================================== */
/*  Signal frame layout                                               */
/* ================================================================== */

struct rt_sigframe {
    kernel_siginfo info;          /* siginfo for SA_SIGINFO handlers */
    arch::TrapFrame saved_regs;   /* saved register state */
    sigset_t        saved_mask;   /* blocked mask to restore on sigreturn */
};

/* ================================================================== */
/*  Signal trampoline (written to user stack)                         */
/* ================================================================== */

/*
 * When the user's signal handler returns (via `ret`), ra points here.
 * This tiny code sequence invokes sys_rt_sigreturn to restore the
 * original execution context.
 *
 * RISC-V instructions (8 bytes):
 *   li  a7, 139    →  addi a7, zero, 139  →  0x08b00893
 *   ecall           →  0x00000073
 */
static constexpr uint32 sigreturn_trampoline[2] = {
    0x08b00893,  /* li a7, 139 (SYS_rt_sigreturn) */
    0x00000073,  /* ecall */
};

/* ================================================================== */
/*  setup_signal_frame                                                */
/* ================================================================== */

int setup_signal_frame(arch::TrapFrame* tf, int signo,
                       kernel_sigaction* ka, kernel_siginfo* info)
{
    TaskControlBlock* curr = current_task();
    if (!curr) return -EINVAL;

    /* Calculate frame location on user stack */
    uint64 sp = tf->sp;

    /* Reserve space for the trampoline below the frame */
    sp -= sizeof(sigreturn_trampoline);
    sp &= ~15ULL;  /* 16-byte align */
    uint64 trampoline_addr = sp;

    /* Reserve space for the signal frame */
    sp -= sizeof(rt_sigframe);
    sp &= ~15ULL;  /* 16-byte align */
    uint64 frame_addr = sp;

    /* Build the frame in kernel memory, then copy to user stack */
    rt_sigframe frame{};
    if (info) {
        frame.info = *info;
    }
    frame.saved_regs = *tf;
    frame.saved_mask = curr->blocked;

    /* Copy frame to user stack */
    int err = copy_to_user(frame_addr, &frame, sizeof(frame));
    if (err < 0) return -EFAULT;

    /* Copy trampoline to user stack */
    err = copy_to_user(trampoline_addr, sigreturn_trampoline,
                       sizeof(sigreturn_trampoline));
    if (err < 0) return -EFAULT;

    /* Set up the trap frame to execute the signal handler */
    tf->epc = ka->sa_handler;
    tf->sp  = frame_addr;

    /* Arguments to the handler: handler(int signo, siginfo_t*, ucontext_t*) */
    tf->a[0] = static_cast<uint64>(signo);

    if (ka->sa_flags & SA_SIGINFO) {
        /* SA_SIGINFO: pass siginfo and ucontext pointers */
        tf->a[1] = frame_addr;                                /* &info */
        tf->a[2] = frame_addr + sizeof(kernel_siginfo);       /* &saved_regs (as ucontext) */
    } else {
        tf->a[1] = 0;
        tf->a[2] = 0;
    }

    /* Return address: when the handler does `ret`, jump to trampoline */
    if (ka->sa_flags & SA_RESTORER) {
        tf->ra = ka->sa_restorer;
    } else {
        tf->ra = trampoline_addr;
    }

    return 0;
}

/* ================================================================== */
/*  arch_sigreturn — restore state from signal frame                  */
/* ================================================================== */

int64 arch_sigreturn(arch::TrapFrame* tf)
{
    TaskControlBlock* curr = current_task();
    if (!curr) return -EINVAL;

    /*
     * The signal frame is located at the current sp.
     * We need to read it back and restore the original state.
     */
    uint64 frame_addr = tf->sp;

    rt_sigframe frame{};
    int err = copy_from_user(&frame, frame_addr, sizeof(frame));
    if (err < 0) {
        printk(KERN_ERR "sigreturn: failed to read signal frame at %llx\n",
               frame_addr);
        task_kill_current(SIGSEGV);
        return -EFAULT;
    }

    /* Restore the saved register state */
    *tf = frame.saved_regs;

    /* Restore the blocked mask */
    curr->blocked = frame.saved_mask;
    curr->blocked.del(SIGKILL);
    curr->blocked.del(SIGSTOP);

    /*
     * Return value: we return the saved a0 from the original context.
     * The syscall dispatch will NOT overwrite a0 because sigreturn
     * is special — it returns via the restored trap frame directly.
     */
    return tf->a[0];
}
