/* SPDX-License-Identifier: GPL-2.0-or-later */

#include <assert.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

_Static_assert(sizeof(uintptr_t) == sizeof(void*), "uintptr_t must hold a pointer");
