// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (C) 2026 Richard QIn
 */
#include "ulib/stdlib.h"

void *operator new(unsigned long n)
{
    return malloc(n);
}

void *operator new[](unsigned long n)
{
    return malloc(n);
}

void operator delete(void *p)
{
    free(p);
}

void operator delete[](void *p)
{
    free(p);
}

void operator delete(void *p, unsigned long)
{
    free(p);
}

void operator delete[](void *p, unsigned long)
{
    free(p);
}