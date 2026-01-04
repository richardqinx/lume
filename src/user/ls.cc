// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (C) 2026 Richard QIn
 */
#include "ulib/stdio.h"
#include "ulib/stdlib.h"
#include "ulib/string.h"
#include "user/user.h"
#include "common/fcntl.h"


struct FAT32_DirEnt
{
    char name[11];
    uint8 attr;
    uint8 lcase;
    uint8 ctime_cs;
    uint16 ctime;
    uint16 cdate;
    uint16 adate;
    uint16 fstClusHI;
    uint16 wtime;
    uint16 wdate;
    uint16 fstClusLO;
    uint32 fileSize;
} __attribute__((packed));

#define ATTR_DIRECTORY 0x10
#define ATTR_LONG_NAME 0x0F

void fmt_name(char *dst, const char *src)
{
    int i;
    char *d = dst;

    for (i = 0; i < 8; i++)
    {
        if (src[i] == ' ')
            break;
        *d++ = src[i];
    }

    if (src[8] != ' ')
    {
        *d++ = '.';
        for (i = 8; i < 11; i++)
        {
            if (src[i] == ' ')
                break;
            *d++ = src[i];
        }
    }
    *d = 0;

    for (d = dst; *d; d++)
    {
        if (*d >= 'A' && *d <= 'Z')
            *d += 32;
    }
}

void ls(const char *path)
{
    int fd;
    struct FAT32_DirEnt de;
    char name_buf[16];

    if ((fd = open(path, O_RDONLY)) < 0)
    {
        printf("ls: cannot open %s\n", path);
        return;
    }

    while (read(fd, &de, sizeof(de)) == sizeof(de))
    {
        if (de.name[0] == 0)
        {
            break;
        }

        if ((unsigned char)de.name[0] == 0xE5)
        {
            continue;
        }

        if ((de.attr & ATTR_LONG_NAME) == ATTR_LONG_NAME)
        {
            continue;
        }

        fmt_name(name_buf, de.name);

        printf("%s %d\t%s\n",
               (de.attr & ATTR_DIRECTORY) ? "<DIR>" : "     ",
               de.fileSize,
               name_buf);
    }

    close(fd);
}

int main(int argc, char *argv[])
{
    if (argc < 2)
    {
        ls(".");
    }
    else
    {
        for (int i = 1; i < argc; i++)
        {
            ls(argv[i]);
        }
    }
    exit(0);
}