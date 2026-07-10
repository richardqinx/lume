/* SPDX-License-Identifier: MIT */
/* Derived from musl libc (Copyright © 2005-2020 Rich Felker, et al.) */

#include <string.h>

char *strcpy(char *restrict dest, const char *restrict src)
{
	__stpcpy(dest, src);
	return dest;
}
