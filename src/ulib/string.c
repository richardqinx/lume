#include "ulib/string.h"
#include "ulib/stdlib.h"


/* Memory Manipulation Functions  */

void *memset(void *dst, int c, size_t n)
{
    char *cdst = (char *)dst;
    for (size_t i = 0; i < n; i++)
        cdst[i] = (char)c;
    return dst;
}

void *memmove(void *vdst, const void *vsrc, size_t n)
{
    char *dst = (char *)vdst;
    const char *src = (const char *)vsrc;
    if (dst == src)
        return vdst;

    if (src > dst)
    {
        while (n--)
            *dst++ = *src++;
    }
    else
    {
        dst += n;
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}

void *memcpy(void *vdst, const void *vsrc, size_t n)
{
    return memmove(vdst, vsrc, n);
}

int memcmp(const void *s1, const void *s2, size_t n)
{
    const unsigned char *p1 = (const unsigned char *)s1;
    const unsigned char *p2 = (const unsigned char *)s2;
    while (n--)
    {
        if (*p1 != *p2)
            return *p1 - *p2;
        p1++;
        p2++;
    }
    return 0;
}

void *memchr(const void *s, int c, size_t n)
{
    const unsigned char *p = (const unsigned char *)s;
    while (n--)
    {
        if (*p == (unsigned char)c)
            return (void *)p;
        p++;
    }
    return NULL;
}

/* String Manipulation Functions  */

size_t strlen(const char *s)
{
    const char *p = s;
    while (*p)
        p++;
    return (size_t)(p - s);
}

char *strcpy(char *dst, const char *src)
{
    char *os = dst;
    while ((*dst++ = *src++) != 0)
        ;
    return os;
}

char *strncpy(char *dst, const char *src, size_t n)
{
    char *os = dst;
    size_t i;

    for (i = 0; i < n && src[i] != '\0'; i++)
        dst[i] = src[i];

    for (; i < n; i++)
        dst[i] = '\0';

    return os;
}

char *strcat(char *dst, const char *src)
{
    char *os = dst;
    while (*dst)
        dst++;
    while ((*dst++ = *src++) != 0)
        ;
    return os;
}

char *strncat(char *dst, const char *src, size_t n)
{
    char *os = dst;
    size_t dest_len = strlen(dst);
    size_t i;

    dst += dest_len;

    for (i = 0; i < n && src[i] != '\0'; i++)
        dst[i] = src[i];

    dst[i] = '\0';

    return os;
}

int strcmp(const char *p, const char *q)
{
    while (*p && *p == *q)
    {
        p++;
        q++;
    }
    return (int)((unsigned char)*p - (unsigned char)*q);
}

int strncmp(const char *s1, const char *s2, size_t n)
{
    if (n == 0)
        return 0;

    while (n-- > 0 && *s1 && *s1 == *s2)
    {
        if (n == 0 || *s1 == '\0')
            break;
        s1++;
        s2++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
}

char *strchr(const char *s, int c)
{
    while (*s != (char)c)
    {
        if (!*s++)
            return NULL;
    }
    return (char *)s;
}

char *strrchr(const char *s, int c)
{
    const char *last = NULL;
    do
    {
        if (*s == (char)c)
            last = s;
    } while (*s++);

    return (char *)last;
}


char *strstr(const char *haystack, const char *needle)
{
    size_t n_len = strlen(needle);
    if (n_len == 0)
        return (char *)haystack;

    for (; *haystack; haystack++)
    {
        if (*haystack != *needle)
            continue;

        if (strncmp(haystack, needle, n_len) == 0)
            return (char *)haystack;
    }
    return NULL;
}

char *strdup(const char *s)
{
    size_t len = strlen(s) + 1;
    char *new_str = (char *)malloc(len);
    if (new_str == NULL)
        return NULL;

    return (char *)memcpy(new_str, s, len);
}

size_t strlcpy(char *dst, const char *src, size_t size)
{
    size_t src_len = strlen(src);

    if (size > 0)
    {
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
        memcpy(dst, src, copy_len);
        dst[copy_len] = '\0';
    }

    return src_len;
}

size_t strlcat(char *dst, const char *src, size_t size)
{
    size_t dst_len = 0;
    size_t src_len = strlen(src);

    while (dst_len < size && dst[dst_len] != '\0')
        dst_len++;

    if (dst_len == size)
        return size + src_len;

    size_t space_left = size - dst_len;
    size_t copy_len = (src_len >= space_left) ? space_left - 1 : src_len;

    memcpy(dst + dst_len, src, copy_len);
    dst[dst_len + copy_len] = '\0';

    return dst_len + src_len;
}


size_t strspn(const char *s, const char *accept)
{
    const char *p = s;
    const char *a;

    while (*p)
    {
        for (a = accept; *a; a++)
        {
            if (*p == *a)
                break;
        }
        if (*a == '\0')
            return (size_t)(p - s);
        p++;
    }
    return (size_t)(p - s);
}

size_t strcspn(const char *s, const char *reject)
{
    const char *p = s;
    const char *r;

    while (*p)
    {
        for (r = reject; *r; r++)
        {
            if (*p == *r)
                return (size_t)(p - s);
        }
        p++;
    }
    return (size_t)(p - s);
}

char *strpbrk(const char *s, const char *accept)
{
    const char *a;
    while (*s)
    {
        for (a = accept; *a; a++)
        {
            if (*s == *a)
                return (char *)s;
        }
        s++;
    }
    return NULL;
}

char *strtok(char *str, const char *delim)
{
    static char *olds;
    char *token;

    if (str == NULL)
        str = olds;

    str += strspn(str, delim);
    if (*str == '\0')
    {
        olds = str;
        return NULL;
    }

    token = str;
    str = strpbrk(token, delim);

    if (str == NULL)
    {
        olds = strchr(token, '\0');
    }
    else
    {
        *str = '\0';
        olds = str + 1;
    }

    return token;
}

char *strerror(int errnum)
{
    
    switch (errnum)
    {
    case 0:
        return "Success";
    // case EINVAL: return "Invalid argument";
    case ENOMEM: return "Out of memory";
    
    default:
        return "Unknown error";
    }
}