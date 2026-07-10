/* SPDX-License-Identifier: GPL-2.0-or-later */

/*
 * Embed the generated CPIO through the target assembler instead of converting
 * it with `objcopy -I binary`.  The resulting object inherits the target ABI
 * attributes (notably RISC-V float ABI flags), which keeps both GNU ld and LLD
 * strict-linking compatible.
 */

#ifndef INITRAMFS_IMAGE
#error "INITRAMFS_IMAGE must name the generated CPIO archive"
#endif

    .section .init.ramfs, "a", @progbits
    .balign 8
    .incbin INITRAMFS_IMAGE

