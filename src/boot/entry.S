.section .text.entry
.globl _start

_start:
    csrr t0, mhartid
    bnez t0, .L_park_harts

    la sp, _stack_top

    la a0, _bss_start
    la a1, _bss_end
    bge a0, a1, .L_call_main

.L_clear_bss:
    sd zero, (a0)
    addi a0, a0, 8
    blt a0, a1, .L_clear_bss

.L_call_main:
    call kernel_main

.L_infinite_loop:
    wfi
    j .L_infinite_loop

.L_park_harts:
    wfi
    j .L_park_harts