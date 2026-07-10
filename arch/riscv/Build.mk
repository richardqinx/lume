targets += arch/riscv
target.arch/riscv.kind := source-set
target.arch/riscv.public-includes := arch/riscv/include
target.arch/riscv.sources := \
    arch/riscv/mm/pmap.cc \
    arch/riscv/mm/init.cc \
    arch/riscv/config.cc \
    arch/riscv/trap/trap_md.cc \
    arch/riscv/syscall/syscall_md.cc \
    arch/riscv/lib/random.cc \
    arch/riscv/mm/tlb_md.cc \
    arch/riscv/kernel/head.S \
    arch/riscv/trap/swtch.S \
    arch/riscv/trap/fpu.S \
    arch/riscv/trap/trap_vector.S \
    arch/riscv/uaccess/uaccess_memcpy.S \
    arch/riscv/trap/extable.cc \
    arch/riscv/kernel/signal.cc

