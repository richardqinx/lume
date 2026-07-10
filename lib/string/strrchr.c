/* SPDX-License-Identifier: MIT */
/* Derived from musl libc (Copyright © 2005-2020 Rich Felker, et al.) */

#include <string.h>

char *strrchr(const char *s, int c)
{
	return __memrchr(s, c, strlen(s) + 1);
}
