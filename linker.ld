OUTPUT_ARCH( "riscv" )
ENTRY( _start )

SECTIONS
{
  . = 0x80200000;

  /* Text Segment */
  .text : {
    *(.text.entry)
    *(.text .text.*)
    . = ALIGN(0x1000); 
    PROVIDE(etext = .); 
  }

  /* Read Only Data Segment */
  .rodata : {
    . = ALIGN(16);
    *(.srodata .srodata.*)
    . = ALIGN(16);
    *(.rodata .rodata.*)
  }

  /* Data Segment */
  .data : {
    . = ALIGN(16);
    *(.sdata .sdata.*)
    . = ALIGN(16);
    *(.data .data.*)
  }

  /* BBS Segment */
  .bss : {
    . = ALIGN(16);
    PROVIDE(sbss = .);
    *(.sbss .sbss.*)
    . = ALIGN(16);
    *(.bss .bss.*)
    PROVIDE(ebss = .);
  }

  . = ALIGN(0x1000);
  PROVIDE(end = .);
  PROVIDE(kernel_end = .);
}