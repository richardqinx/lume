# arch/riscv/module.mk
SRCS_CC += arch/riscv/mm/pmap.cc
SRCS_CC += arch/riscv/mm/init.cc
SRCS_CC += arch/riscv/config.cc
SRCS_CC += arch/riscv/trap/trap_md.cc
SRCS_CC += arch/riscv/syscall/syscall_md.cc
SRCS_CC += arch/riscv/lib/random.cc
SRCS_CC += arch/riscv/mm/tlb_md.cc
SRCS_S  += arch/riscv/kernel/head.S
SRCS_S  += arch/riscv/trap/swtch.S
SRCS_S  += arch/riscv/trap/fpu.S
SRCS_S  += arch/riscv/trap/trap_vector.S
SRCS_S  += arch/riscv/uaccess/uaccess_memcpy.S
SRCS_CC += arch/riscv/trap/extable.cc
SRCS_CC += arch/riscv/kernel/signal.cc

# Arch-specific headers (added to include path)
INCLUDES += -Iarch/riscv/include
