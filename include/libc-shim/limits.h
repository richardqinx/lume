/* Shim: limits for musl string functions (memmem uses SIZE_MAX) */
#ifndef _LIMITS_H
#define _LIMITS_H

#define CHAR_BIT   8
#define UCHAR_MAX  255
#define SCHAR_MAX  127
#define SCHAR_MIN  (-128)
#define INT_MAX    2147483647
#define INT_MIN    (-INT_MAX - 1)
#define UINT_MAX   4294967295U
#define LONG_MAX   9223372036854775807L
#define LONG_MIN   (-LONG_MAX - 1L)
#define ULONG_MAX  18446744073709551615UL
#define SIZE_MAX   ULONG_MAX

#endif
