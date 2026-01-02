#ifndef _ULIB_TYPES_H
#define _ULIB_TYPES_H

#include "common/types.h"

#ifndef _ULIB_ALIASES
#define _ULIB_ALIASES
typedef unsigned int uint;
typedef unsigned short ushort;
typedef unsigned char uchar;
#endif

#ifndef NULL
#define NULL ((void *)0)
#endif

#ifndef __cplusplus
typedef int wchar_t;
#endif

#endif