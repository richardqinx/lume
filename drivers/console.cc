/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * console.cc — Console character device (/dev/console)
 *
 * Wraps the existing early_putc() UART driver as a file_operations
 * chardev.  read() is a stub for now (returns 0 = EOF).
 * write() sends each byte through early_putc().
 */

#include <lume/file.h>
#include <lume/chardev.h>
#include <lume/types.h>

extern "C" void early_putc(char c);

/* ================================================================== */
/*  console_write                                                     */
/* ================================================================== */

static int64 console_write(file* fp, const char* buf, uint64 count, int64* pos)
{
    (void)fp;
    (void)pos;

    for (uint64 i = 0; i < count; i++) {
        early_putc(buf[i]);
    }

    return static_cast<int64>(count);
}

/* ================================================================== */
/*  console_read — stub (returns 0 = EOF for now)                     */
/* ================================================================== */

static int64 console_read(file* fp, char* buf, uint64 count, int64* pos)
{
    (void)fp;
    (void)buf;
    (void)count;
    (void)pos;
    /* TODO: implement UART RX polling/IRQ-based blocking read */
    return 0;
}

/* ================================================================== */
/*  null device — /dev/null                                           */
/* ================================================================== */

static int64 null_read(file* /*fp*/, char* /*buf*/, uint64 /*count*/, int64* /*pos*/)
{
    return 0;  /* EOF */
}

static int64 null_write(file* /*fp*/, const char* /*buf*/, uint64 count, int64* /*pos*/)
{
    return static_cast<int64>(count);  /* discard */
}

/* ================================================================== */
/*  zero device — /dev/zero                                           */
/* ================================================================== */

static int64 zero_read(file* /*fp*/, char* buf, uint64 count, int64* /*pos*/)
{
    for (uint64 i = 0; i < count; i++) {
        buf[i] = 0;
    }
    return static_cast<int64>(count);
}

static int64 zero_write(file* /*fp*/, const char* /*buf*/, uint64 count, int64* /*pos*/)
{
    return static_cast<int64>(count);  /* discard */
}

/* ================================================================== */
/*  Registration — runtime init (no static initializers!)             */
/* ================================================================== */

static file_operations console_fops;
static file_operations null_fops;
static file_operations zero_fops;

static cdev console_cdev;
static cdev null_cdev;
static cdev zero_cdev;

void console_cdev_init()
{
    /* Console: major=5, minor=1 */
    console_fops.read  = console_read;
    console_fops.write = console_write;

    console_cdev.name = "console";
    console_cdev.dev  = MKDEV(5, 1);
    console_cdev.fops = &console_fops;
    cdev_register(&console_cdev);

    /* /dev/null: major=1, minor=3 */
    null_fops.read  = null_read;
    null_fops.write = null_write;

    null_cdev.name = "null";
    null_cdev.dev  = MKDEV(1, 3);
    null_cdev.fops = &null_fops;
    cdev_register(&null_cdev);

    /* /dev/zero: major=1, minor=5 */
    zero_fops.read  = zero_read;
    zero_fops.write = zero_write;

    zero_cdev.name = "zero";
    zero_cdev.dev  = MKDEV(1, 5);
    zero_cdev.fops = &zero_fops;
    cdev_register(&zero_cdev);
}
