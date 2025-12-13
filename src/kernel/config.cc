#include "common/types.h"

uint64 g_uart_base = 0;
// uint64 g_clint_base = 0;
uint64 g_plic_base = 0;
uint64 g_ram_start = 0;
uint64 g_ram_size = 0;

extern "C" uint64 g_dtb_addr;