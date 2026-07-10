/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * namei.h — Pathname lookup (path resolution)
 */

#include <lume/types.h>
#include <lume/file.h>      /* struct path */
#include <lume/dcache.h>    /* struct qstr */

/* ================================================================== */
/*  LOOKUP_* flags                                                    */
/* ================================================================== */

inline constexpr uint32 LOOKUP_FOLLOW    = 0x0001;
inline constexpr uint32 LOOKUP_DIRECTORY = 0x0002;
inline constexpr uint32 LOOKUP_CREATE    = 0x0200;
inline constexpr uint32 LOOKUP_EXCL      = 0x0400;
inline constexpr uint32 LOOKUP_PARENT    = 0x0010;

/* ================================================================== */
/*  Path lookup API                                                   */
/* ================================================================== */

int kern_path(const char* name, unsigned int flags, path* result);
int filename_lookup(int dfd, const char* name, unsigned int flags, path* result);
dentry* lookup_one_len(const char* name, dentry* parent, int len);

void namei_init();
