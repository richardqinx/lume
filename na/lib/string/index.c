/* SPDX-License-Identifier: MIT */
/* Derived from musl libc (Copyright © 2005-2020 Rich Felker, et al.) */

#define _BSD_SOURCE
#include <string.h>
#include <strings.h>

char *index(const char *s, int c)
{
	return strchr(s, c);
}
