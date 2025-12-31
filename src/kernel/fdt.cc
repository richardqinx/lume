#include "common/types.h"
#include "drivers/uart.h"
#include "kernel/config.h"
#include "lib/string.h"

inline uint32_t bswap(uint32_t x)
{
    return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) |
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
}

struct fdt_header
{
    uint32 magic;
    uint32 totalsize;
    uint32 off_dt_struct;
    uint32 off_dt_strings;
    uint32 off_mem_rsvmap;
    uint32 version;
    uint32 last_comp_version;
    uint32 boot_cpuid_phys;
    uint32 size_dt_strings;
    uint32 size_dt_struct;
};

#define FDT_MAGIC 0xd00dfeed
#define FDT_BEGIN_NODE 1
#define FDT_END_NODE 2
#define FDT_PROP 3
#define FDT_NOP 4
#define FDT_END 9


void fdt_init(uint64 dtb)
{
    if (dtb == 0) return;

    struct fdt_header* header = (struct fdt_header*)dtb;
    if (bswap(header->magic) != FDT_MAGIC)
        return;
    
    uint8* struct_ptr = (uint8*)(dtb + bswap(header->off_dt_struct));
    char* strings_ptr = (char *)(dtb + bswap(header->off_dt_strings));

    uint64 current_reg_addr = 0;

    while (1)
    {
        uint32 token = bswap(*(uint32*)struct_ptr);
        struct_ptr += 4;

        if(token == FDT_END)break;
        if(token == FDT_NOP)continue;

        if(token == FDT_BEGIN_NODE)
        {
            while (*struct_ptr != 0)struct_ptr++;
            struct_ptr++;
            struct_ptr = (uint8*)(((uint64)struct_ptr + 3) & ~3);
        }
        else if(token == FDT_END_NODE)
        {
            
        }
        else if (token == FDT_PROP)
        {
            uint32 len = bswap(*(uint32*)struct_ptr);
            struct_ptr += 4;
            uint32 nameoff = bswap(*(uint32*)struct_ptr);
            struct_ptr += 4;

            char* name = strings_ptr + nameoff;
            uint8* data = struct_ptr;

            struct_ptr += len;
            struct_ptr = (uint8*)(((uint64)struct_ptr + 3) & ~3);

            if(strcmp(name, "reg") == 0 && len >= 8)
            {
                uint32 hi = bswap(*(uint32*)data);
                uint32 lo = bswap(*(uint32*)(data + 4));
                current_reg_addr = ((uint64)hi << 32) | lo;
            }

            if(strcmp(name, "compatible") == 0)
            {
                if (g_uart_base == 0)
                {
                    for(uint32 i = 0; i < len; i++)
                    {
                        if (data[i] == 'n' && data[i + 1] == 's' && data[i + 2] == '1')
                        {
                            g_uart_base = current_reg_addr;
                            break;
                        }
                    }
                }

            }
        }
    }
    
}