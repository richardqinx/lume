.section .text.entry
.global _start

_start:
    mv tp, a0

    la t0, stack_base
    li t1, 4096
    addi t2, a0, 1
    mul t1, t1, t2
    add sp, t0, t1

    bnez a0, .L_jump_main

    la t0, sbss
    la t1, ebss
.L_clear_bss:
    bge t0, t1, .L_save_dtb
    sd zero, 0(t0)
    addi t0, t0, 8
    j .L_clear_bss

.L_save_dtb:
    la t0, g_dtb_addr
    sd a1, 0(t0)

.L_jump_main:
    call kernel_main

.L_park:
    wfi
    j .L_park

.section .bss
.align 4
.global stack_top
stack_base:
    .space 4096 * 8
stack_top:

.align 8
.global g_dtb_addr
g_dtb_addr:
    .space 8