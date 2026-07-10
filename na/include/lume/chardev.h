/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * chardev.h — Character device abstraction
 *
 * Minimal Linux-style cdev registry: each character device has a
 * major/minor number and a file_operations table.
 */

#include <lume/types.h>
#include <lume/list.h>

struct file_operations;

/* ================================================================== */
/*  MKDEV / MAJOR / MINOR                                             */
/* ================================================================== */

inline constexpr uint32 MKDEV(uint32 ma, uint32 mi) {
    return (ma << 8) | (mi & 0xFF);
}
inline constexpr uint32 MAJOR(uint32 dev) { return dev >> 8; }
inline constexpr uint32 MINOR(uint32 dev) { return dev & 0xFF; }

/* ================================================================== */
/*  cdev — character device descriptor                                */
/* ================================================================== */

struct cdev {
    const char*             name;
    uint32                  dev;        /* MKDEV(major, minor) */
    const file_operations*  fops;
    list_node               list;       /* global cdev list */
};

/* ================================================================== */
/*  API                                                               */
/* ================================================================== */

void cdev_init();
void cdev_register(cdev* dev);
cdev* cdev_find(uint32 dev);
