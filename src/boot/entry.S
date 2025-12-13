# src/boot/entry.S
.section .text.entry
.global _start

_start:
    la t0, g_dtb_addr
    sd a1, 0(t0)

    la sp, stack_top

    call kernel_main

.L_park:
    wfi
    j .L_park

.section .bss
.align 4
.global stack_top
stack_base:
    .space 4096 * 4
stack_top:

.align 8
.global g_dtb_addr
g_dtb_addr:
    .space 8