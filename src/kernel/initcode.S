.section .rodata
.global initcode_start
.global initcode_end
.align 4

initcode_start:
    .incbin "build/user/initcode"
initcode_end:
