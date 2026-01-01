.section .text
.global _start

_start:
    li a0, 0
    li a1, 0

    call main

    call exit

1:  j 1b