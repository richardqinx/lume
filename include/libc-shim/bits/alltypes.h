/* Shim: provide types musl string functions need */
#ifndef _BITS_ALLTYPES_H
#define _BITS_ALLTYPES_H

#ifndef __cplusplus
typedef unsigned long size_t;
#endif

typedef long ssize_t;
typedef unsigned long uintptr_t;

/* locale_t stub — unused in kernel, but declared by some headers */
typedef void *locale_t;

#endif
