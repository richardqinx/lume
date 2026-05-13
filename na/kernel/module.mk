# kernel/module.mk
SRCS_CC += kernel/main.cc
SRCS_CC += kernel/boot_params.cc
SRCS_CC += kernel/sync/spinlock.cc
SRCS_CC += kernel/trap.cc
SRCS_CC += kernel/irq.cc
SRCS_CC += kernel/sched_core.cc
SRCS_CC += kernel/sched_class_o1.cc
SRCS_CC += kernel/timer.cc
SRCS_CC += kernel/pid.cc
SRCS_CC += kernel/task.cc
SRCS_CC += kernel/syscall.cc
SRCS_CC += kernel/sys_process.cc
SRCS_CC += kernel/sys_mm.cc
SRCS_CC += kernel/sys_info.cc
SRCS_CC += kernel/uaccess.cc
SRCS_CC += kernel/waitqueue.cc
