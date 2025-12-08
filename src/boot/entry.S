.section .text.entry
.global _start

_start:
    csrr t0, mhartid
    bnez t0, .L_park

    li t0, 0x1fffffffffffff
    csrw pmpaddr0, t0
    li t0, 0xf
    csrw pmpcfg0, t0

    li t0, 0
    li t1, (1 << 11) | (1 << 7)
    csrw mstatus, t1

    csrw satp, zero

    li t0, 0xffff
    csrw medeleg, t0
    csrw mideleg, t0
    
    la t0, kernel_main
    csrw mepc, t0

    la sp, stack_top

    mret

.L_park:
    wfi
    j .L_park


.section .bss
.align 4
.global stack_top
stack_base:
    .space 4096 * 4
stack_top: