/* SPDX-License-Identifier: MIT */
/* Derived from musl libc (Copyright © 2005-2020 Rich Felker, et al.) */

#include <string.h>

int memcmp(const void *vl, const void *vr, size_t n)
{
	const unsigned char *l=vl, *r=vr;
	for (; n && *l == *r; n--, l++, r++);
	return n ? *l-*r : 0;
}
