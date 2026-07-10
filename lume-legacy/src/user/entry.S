# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026 Richard Qin

.section .text
.global _start

_start:
    call main

    call exit

1:  j 1b