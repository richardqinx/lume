# arch/riscv/module.mk
SRCS_S  += arch/riscv/boot/entry.S
SRCS_S  += arch/riscv/trap/swtch.S
SRCS_S  += arch/riscv/trap/trap_vector.S

# Arch-specific headers (added to include path)
INCLUDES += -Iarch/riscv/include
