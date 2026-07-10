/* SPDX-License-Identifier: MIT */
/* Derived from musl libc (Copyright © 2005-2020 Rich Felker, et al.) */

#define _BSD_SOURCE
#include <string.h>
#include <strings.h>

void bzero(void *s, size_t n)
{
	memset(s, 0, n);
}
