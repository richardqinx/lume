#include "lib/string.h"

void *memset(void *dst, int c, uint n)
{
    char *cdst = (char *)dst;
    for (uint i = 0; i < n; i++)
        cdst[i] = c;
    return dst;
}

int memcmp(const void *v1, const void *v2, uint n)
{
    const uchar *s1 = (const uchar *)v1;
    const uchar *s2 = (const uchar *)v2;
    while (n-- > 0)
    {
        if (*s1 != *s2)
            return *s1 - *s2;
        s1++, s2++;
    }
    return 0;
}

void *memmove(void *dst, const void *src, uint n)
{
    const char *s = (const char *)src;
    char *d = (char *)dst;
    if (s < d && s + n > d)
    {
        s += n;
        d += n;
        while (n-- > 0)
            *--d = *--s;
    }
    else
    {
        while (n-- > 0)
            *d++ = *s++;
    }
    return dst;
}

void *memcpy(void *dst, const void *src, uint n)
{
    return memmove(dst, src, n);
}

void strcpy(char *dst, const char *src)
{
    while (*src)
        *dst++ = *src++;
    *dst = 0;
}

int strlen(const char *s)
{
    int n = 0;
    while (s[n])
        n++;
    return n;
}

int strcmp(const char *s1, const char *s2)
{
    while (*s1 && (*s1 == *s2))
    {
        s1++;
        s2++;
    }
    return *(const unsigned char *)s1 - *(const unsigned char *)s2;
}
