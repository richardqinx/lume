targets += kernel/core
target.kernel/core.kind := source-set
target.kernel/core.sources := \
    kernel/main.cc kernel/sync/spinlock.cc kernel/sync/mutex.cc \
    kernel/trap.cc kernel/irq.cc kernel/sched_core.cc \
    kernel/sched_class_o1.cc kernel/timer.cc kernel/pid.cc kernel/pgrp.cc \
    kernel/task.cc kernel/syscall.cc kernel/sys_process.cc kernel/sys_mm.cc \
    kernel/sys_info.cc kernel/sys_fs.cc kernel/uaccess.cc kernel/waitqueue.cc \
    kernel/signal.cc kernel/sys_signal.cc kernel/sys_misc.cc kernel/exec.cc \
    kernel/poll.cc kernel/ptrace.cc kernel/smp.cc

