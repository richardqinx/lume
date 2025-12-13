OUTPUT_ARCH( "riscv" )
ENTRY(_start)

SECTIONS
{
    . = 0x80200000;

    .text : {
        PROVIDE(text_start = .);
        *(.text.entry)
        *(.text .text.*)
        . = ALIGN(4096);
        PROVIDE(text_end = .);
    }

    .rodata : {
        PROVIDE(rodata_start = .);
        *(.rodata .rodata.*)
        . = ALIGN(4096);
        PROVIDE(rodata_end = .);
    }

    .data : {
        PROVIDE(data_start = .);
        *(.data .data.*)
        . = ALIGN(4096);
        PROVIDE(data_end = .);
    }

    .bss : {
        PROVIDE(bss_start = .);
        *(.bss .bss.*)
        *(.sbss .sbss.*)
        . = ALIGN(4096);
        PROVIDE(bss_end = .);
    }

    PROVIDE(kernel_end = .);
}