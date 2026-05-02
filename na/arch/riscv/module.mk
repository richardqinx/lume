# arch/riscv/module.mk
SRCS_CC += arch/riscv/mm/pmap.cc
SRCS_CC += arch/riscv/config.cc
SRCS_CC += arch/riscv/trap/trap_md.cc
SRCS_CC += arch/riscv/lib/random.cc
SRCS_S  += arch/riscv/boot/entry.S
SRCS_S  += arch/riscv/trap/swtch.S
SRCS_S  += arch/riscv/trap/trap_vector.S

# Arch-specific headers (added to include path)
INCLUDES += -Iarch/riscv/include
