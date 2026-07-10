/* SPDX-License-Identifier: MIT */
/* Derived from musl libc (Copyright © 2005-2020 Rich Felker, et al.) */

#include <string.h>

char *strncpy(char *restrict d, const char *restrict s, size_t n)
{
	__stpncpy(d, s, n);
	return d;
}
