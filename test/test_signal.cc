/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * test_signal.cc — Self-tests for signal infrastructure
 *
 * Tests the kernel-internal signal APIs directly (not via syscalls,
 * since syscalls use copy_to_user which rejects kernel-space buffers).
 */

#include <lume/selftest.h>
#include <lume/signal.h>
#include <lume/signal_types.h>
#include <lume/signal_nr.h>
#include <lume/task.h>
#include <lume/errno.h>
#include <lume/new.h>

/* From signal.cc */
extern int send_signal(int sig, kernel_siginfo* info, TaskControlBlock* task);

/* Drain all queued sigqueue entries from a task's pending list */
static void flush_pending(TaskControlBlock* task)
{
    task->pending.signal = sigset_t{};
    list_node* head = &task->pending.list;
    while (head->next != head) {
        list_node* node = head->next;
        head->next = node->next;
        node->next->prev = head;
        auto* q = list_entry<sigqueue, &sigqueue::list>(node);
        delete q;
    }
}

void selftest_signal()
{
    TaskControlBlock* curr = current_task();

    /* Ensure sighand exists for this task */
    if (!curr->sighand) {
        curr->sighand = new sighand_struct;
        curr->sighand->init();
    }

    /* Ensure pending list is initialized */
    if (curr->pending.list.next == nullptr) {
        curr->pending.list.next = &curr->pending.list;
        curr->pending.list.prev = &curr->pending.list;
        curr->pending.signal = sigset_t{};
    }

    /* ---- send_signal queues a signal ---- */
    st_begin("signal: send_signal queues to pending");
    {
        curr->pending.signal = sigset_t{};

        kernel_siginfo info{};
        info.si_signo = SIGUSR1;
        info.si_code  = 0;

        int ret = send_signal(SIGUSR1, &info, curr);
        ST_ASSERT_EQ(ret, 0);
        ST_ASSERT(curr->pending.signal.has(SIGUSR1));

        flush_pending(curr);
    }
    st_pass();

    /* ---- send_signal: invalid signal returns -EINVAL ---- */
    st_begin("signal: send_signal invalid sig returns -EINVAL");
    {
        int ret = send_signal(0, nullptr, curr);
        ST_ASSERT_EQ(ret, -EINVAL);

        ret = send_signal(_NSIG + 1, nullptr, curr);
        ST_ASSERT_EQ(ret, -EINVAL);
    }
    st_pass();

    /* ---- send_signal: null task returns -ESRCH ---- */
    st_begin("signal: send_signal null task returns -ESRCH");
    {
        int ret = send_signal(SIGUSR1, nullptr, nullptr);
        ST_ASSERT_EQ(ret, -ESRCH);
    }
    st_pass();

    /* ---- duplicate standard signal is coalesced ---- */
    st_begin("signal: duplicate standard signal coalesced");
    {
        curr->pending.signal = sigset_t{};

        send_signal(SIGUSR1, nullptr, curr);
        ST_ASSERT(curr->pending.signal.has(SIGUSR1));

        int ret = send_signal(SIGUSR1, nullptr, curr);
        ST_ASSERT_EQ(ret, 0);

        flush_pending(curr);
    }
    st_pass();

    /* ---- sigset_t: add/del/has ---- */
    st_begin("signal: sigset_t add/del/has");
    {
        sigset_t s{};
        ST_ASSERT(!s.has(SIGUSR1));
        s.add(SIGUSR1);
        ST_ASSERT(s.has(SIGUSR1));
        s.del(SIGUSR1);
        ST_ASSERT(!s.has(SIGUSR1));
    }
    st_pass();

    /* ---- sigset_t: bitwise operators ---- */
    st_begin("signal: sigset_t bitwise OR and AND");
    {
        sigset_t a{};
        a.add(SIGUSR1);
        sigset_t b{};
        b.add(SIGUSR2);

        sigset_t c = a | b;
        ST_ASSERT(c.has(SIGUSR1));
        ST_ASSERT(c.has(SIGUSR2));

        sigset_t d = c & a;
        ST_ASSERT(d.has(SIGUSR1));
        ST_ASSERT(!d.has(SIGUSR2));
    }
    st_pass();

    /* ---- blocked mask: direct manipulation ---- */
    st_begin("signal: blocked mask direct manipulation");
    {
        sigset_t saved = curr->blocked;
        curr->blocked = sigset_t{};

        curr->blocked.add(SIGUSR1);
        curr->blocked.add(SIGUSR2);
        ST_ASSERT(curr->blocked.has(SIGUSR1));
        ST_ASSERT(curr->blocked.has(SIGUSR2));

        curr->blocked.del(SIGUSR1);
        ST_ASSERT(!curr->blocked.has(SIGUSR1));
        ST_ASSERT(curr->blocked.has(SIGUSR2));

        curr->blocked = saved;
    }
    st_pass();

    /* ---- sighand action table ---- */
    st_begin("signal: sighand action table defaults to SIG_DFL");
    {
        /* All handlers should default to SIG_DFL (0) */
        kernel_sigaction* ka = &curr->sighand->action[SIGUSR1 - 1];
        ST_ASSERT_EQ(ka->sa_handler, (uint64)SIG_DFL);

        /* Set a handler and verify */
        ka->sa_handler = 0x12345678ULL;
        ST_ASSERT_EQ(ka->sa_handler, (uint64)0x12345678ULL);

        /* Reset */
        ka->sa_handler = SIG_DFL;
    }
    st_pass();

    /* ---- sig_kernel_only rejects SIGKILL/SIGSTOP handlers ---- */
    st_begin("signal: SIGKILL/SIGSTOP are kernel-only");
    {
        ST_ASSERT(sig_kernel_only(SIGKILL));
        ST_ASSERT(sig_kernel_only(SIGSTOP));
        ST_ASSERT(!sig_kernel_only(SIGUSR1));
        ST_ASSERT(!sig_kernel_only(SIGINT));
    }
    st_pass();

    /* ---- sig_default_action correctness ---- */
    st_begin("signal: sig_default_action returns correct actions");
    {
        ST_ASSERT_EQ((int)sig_default_action(SIGCHLD), (int)SIG_ACT_IGN);
        ST_ASSERT_EQ((int)sig_default_action(SIGKILL), (int)SIG_ACT_TERM);
        ST_ASSERT_EQ((int)sig_default_action(SIGSTOP), (int)SIG_ACT_STOP);
        ST_ASSERT_EQ((int)sig_default_action(SIGCONT), (int)SIG_ACT_CONT);
        ST_ASSERT_EQ((int)sig_default_action(SIGSEGV), (int)SIG_ACT_CORE);
    }
    st_pass();

    /* Clean up */
    flush_pending(curr);
    curr->blocked = sigset_t{};
}
