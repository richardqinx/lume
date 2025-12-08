extern "C" void kernel_main();

#define UART_ADDR 0x10000000UL

#define THR_OFFSET 0x0
#define LSR_OFFSET 0x5
#define FCR_OFFSET 0x2
#define LCR_OFFSET 0x3
#define DLL_OFFSET 0x0
#define DLH_OFFSET 0x1

static void
write_byte(unsigned long addr, char byte)
{
    *((volatile char *)addr) = byte;
}

static int
is_tx_empty()
{
    return *((volatile char *)(UART_ADDR + LSR_OFFSET)) & (1 << 5);
}

void uart_init()
{
    write_byte(UART_ADDR + LCR_OFFSET, 0x80);

    write_byte(UART_ADDR + DLL_OFFSET, 0x01);
    write_byte(UART_ADDR + DLH_OFFSET, 0x00);

    write_byte(UART_ADDR + LCR_OFFSET, 0x03);

    write_byte(UART_ADDR + FCR_OFFSET, 0x07);
}

void put_char(char c)
{
    if (c == '\n')
    {
        put_char('\r');
    }

    while (!is_tx_empty())
    {
    }
    write_byte(UART_ADDR + THR_OFFSET, c);
}

void print_str(const char *s)
{
    while (*s != '\0')
    {
        put_char(*s++);
    }
}

void kernel_main()
{
    uart_init();

    print_str("Modern DOS 1.0\n");
    print_str("Hello OS! Running on RISC-V 64.\n");
    print_str("Hello Ziyi Yang! Love from RUC");

    while (1)
    {

    }
}