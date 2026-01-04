.section .text
.global _start

_start:
    call main

    call exit

1:  j 1b