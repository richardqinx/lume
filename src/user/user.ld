OUTPUT_ARCH(riscv)
ENTRY(_start)

SECTIONS
{
  . = 0x0;
  
  .text : {
    *(.text.entry)
    *(.text .text.*)
  }

  .rodata : {
    . = ALIGN(16);
    *(.rodata .rodata.*)
  }

  .data : {
    . = ALIGN(16);
    *(.data .data.*)
  }

  .bss : {
    . = ALIGN(16);
    *(.bss .bss.*)
  }
}