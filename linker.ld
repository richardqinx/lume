OUTPUT_ARCH( "riscv" )
ENTRY(_start)

MEMORY
{
    ram  (wxa) : ORIGIN = 0x80000000, LENGTH = 128M
}

SECTIONS
{
    . = 0x80000000;

    .text : {
        PROVIDE(_text_start = .);
        *(.text.entry)
        *(.text .text.*)
        PROVIDE(_text_end = .);
    } > ram

    .rodata : {
        . = ALIGN(16);
        PROVIDE(_rodata_start = .);
        *(.rodata .rodata.*)
        PROVIDE(_rodata_end = .);
    } > ram

    .data : {
        . = ALIGN(16);
        PROVIDE(_data_start = .);
        *(.data .data.*)
        *(.sdata .sdata.*)
        PROVIDE(_data_end = .);
    } > ram

    .bss : {
        . = ALIGN(16);
        PROVIDE(_bss_start = .);
        *(.bss .bss.*)
        *(.sbss .sbss.*)
        PROVIDE(_bss_end = .);
    } > ram

    . = ALIGN(4096);
    PROVIDE(_stack_top = . + 0x8000);
    . = . + 0x8000;
    PROVIDE(_heap_start = .);
}