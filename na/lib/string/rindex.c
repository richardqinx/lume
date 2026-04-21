/* SPDX-License-Identifier: MIT */
/* Derived from musl libc (Copyright © 2005-2020 Rich Felker, et al.) */

#define _BSD_SOURCE
#include <string.h>
#include <strings.h>

char *rindex(const char *s, int c)
{
	return strrchr(s, c);
}
