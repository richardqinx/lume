#include "ulib/stdlib.h"
#include "ulib/string.h"
#include "ulib/ctypes.h"

extern int sys_exit(int status);
extern void *sbrk(long increment);

#undef errno
int errno = 0;

#define ATEXIT_MAX 32
static void (*__atexit_funcs[ATEXIT_MAX])(void);
static int __atexit_func_count = 0;

int atexit(void (*function)(void))
{
    if (__atexit_func_count >= ATEXIT_MAX)
        return -1;
    __atexit_funcs[__atexit_func_count++] = function;
    return 0;
}

int exit(int status)
{
    while (__atexit_func_count > 0)
    {
        (__atexit_funcs[--__atexit_func_count])();
    }
    sys_exit(status);

    while (1)
        ;
    return 0;
}

void abort(void)
{
    exit(127);
}

char *getenv(const char *name)
{
    /* None  */
    return NULL;
}

int system(const char *command)
{
    /* None */
    return -1;
}

/* Memory Management */
#define ALIGNMENT 16
#define ALIGN(size) (((size) + (ALIGNMENT - 1)) & ~(ALIGNMENT - 1))

typedef struct header
{
    size_t size;
    struct header *next;
} header_t;

static header_t base;
static header_t *freep = NULL;


#define LOCK()
#define UNLOCK()

void free(void *ptr)
{
    header_t *bp, *p;

    if (!ptr)
        return;


    bp = (header_t *)ptr - 1;

    LOCK();


    for (p = freep; !(bp > p && bp < p->next); p = p->next)
    {
        if (p >= p->next && (bp > p || bp < p->next))
            break;
    }

    if ((char *)bp + bp->size == (char *)p->next)
    {
        bp->size += p->next->size;
        bp->next = p->next->next;
    }
    else
    {
        bp->next = p->next;
    }

    if ((char *)p + p->size == (char *)bp)
    {
        p->size += bp->size;
        p->next = bp->next;
    }
    else
    {
        p->next = bp;
    }

    freep = p;
    UNLOCK();
}

static header_t *morecore(size_t nu)
{
    char *cp;
    header_t *up;

    if (nu < 4096)
        nu = 4096;

    nu = ALIGN(nu);

    cp = (char *)sbrk(nu);
    if (cp == (void *)-1)
        return NULL;

    up = (header_t *)cp;
    up->size = nu;

    free((void *)(up + 1));
    return freep;
}

void *malloc(size_t size)
{
    header_t *p, *prevp;

    if (size == 0)
        return NULL;

    size = ALIGN(size + sizeof(header_t));

    LOCK();

    if ((prevp = freep) == NULL)
    {
        base.next = freep = prevp = &base;
        base.size = 0;
    }

    for (p = prevp->next;; prevp = p, p = p->next)
    {
        if (p->size >= size)
        {
            if (p->size == size)
            {
                prevp->next = p->next;
            }
            else
            {
                p->size -= size;

                p = (header_t *)((char *)p + p->size);

                p->size = size;
            }
            freep = prevp;
            UNLOCK();
            return (void *)(p + 1);
        }

        if (p == freep)
        {
            if ((p = morecore(size)) == NULL)
            {
                UNLOCK();
                errno = ENOMEM;
                return NULL;
            }
        }
    }
}

void *calloc(size_t nmemb, size_t size)
{
    size_t total;
    if (__builtin_mul_overflow(nmemb, size, &total))
    {
        errno = ENOMEM;
        return NULL;
    }
    void *p = malloc(total);
    if (p)
        memset(p, 0, total);
    return p;
}

void *realloc(void *ptr, size_t size)
{
    if (!ptr)
        return malloc(size);
    if (size == 0)
    {
        free(ptr);
        return NULL;
    }

    header_t *bp = (header_t *)ptr - 1;
    size_t new_size = ALIGN(size + sizeof(header_t));

    if (bp->size >= new_size)
        return ptr;

    void *new_ptr = malloc(size);
    if (!new_ptr)
        return NULL;

    memcpy(new_ptr, ptr, bp->size - sizeof(header_t));
    free(ptr);
    return new_ptr;
}

/* String Conversion*/

unsigned long long strtoull(const char *nptr, char **endptr, int base)
{
    const char *s = nptr;
    unsigned long long acc;
    unsigned long long cutoff;
    int c;
    int neg = 0, any, cutlim;

    if (base < 0 || base == 1 || base > 36)
    {
        if (endptr)
            *endptr = (char *)nptr;
        errno = 0; /* EINVAL */
        return 0;
    }

    do
    {
        c = *s++;
    } while (isspace(c));

    if (c == '-')
    {
        neg = 1;
        c = *s++;
    }
    else if (c == '+')
    {
        c = *s++;
    }

    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    {
        c = s[1];
        s += 2;
        base = 16;
    }
    if (base == 0)
        base = (c == '0' ? 8 : 10);

    cutoff = ULLONG_MAX / (unsigned long long)base;
    cutlim = ULLONG_MAX % (unsigned long long)base;

    for (acc = 0, any = 0;; c = *s++)
    {
        if (isdigit(c))
            c -= '0';
        else if (isalpha(c))
            c -= isupper(c) ? 'A' - 10 : 'a' - 10;
        else
            break;

        if (c >= base)
            break;

        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
            any = -1;
        else
        {
            any = 1;
            acc *= base;
            acc += c;
        }
    }

    if (any < 0)
    {
        acc = ULLONG_MAX;
        errno = ERANGE;
    }
    else if (neg)
        acc = -acc;

    if (endptr != 0)
        *endptr = (char *)(any ? s - 1 : nptr);

    return acc;
}

long long strtoll(const char *nptr, char **endptr, int base)
{
    const char *s = nptr;
    unsigned long long acc;
    int c, neg = 0;

    do
    {
        c = *s++;
    } while (isspace(c));
    if (c == '-')
        neg = 1;

    acc = strtoull(nptr, endptr, base);

    if (errno == ERANGE && acc == ULLONG_MAX)
        return neg ? LLONG_MIN : LLONG_MAX;

    if (!neg && acc > (unsigned long long)LLONG_MAX)
    {
        errno = ERANGE;
        return LLONG_MAX;
    }
    if (neg && acc > (unsigned long long)LLONG_MAX + 1)
    {
        errno = ERANGE;
        return LLONG_MIN;
    }

    return neg ? -(long long)acc : (long long)acc;
}

unsigned long strtoul(const char *nptr, char **endptr, int base)
{
    unsigned long long ret = strtoull(nptr, endptr, base);
    if (ret > ULONG_MAX)
    {
        errno = ERANGE;
        return ULONG_MAX;
    }
    return (unsigned long)ret;
}

long strtol(const char *nptr, char **endptr, int base)
{
    long long ret = strtoll(nptr, endptr, base);
    if (ret > LONG_MAX)
    {
        errno = ERANGE;
        return LONG_MAX;
    }
    if (ret < LONG_MIN)
    {
        errno = ERANGE;
        return LONG_MIN;
    }
    return (long)ret;
}

int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
long atol(const char *nptr) { return strtol(nptr, NULL, 10); }
long long atoll(const char *nptr) { return strtoll(nptr, NULL, 10); }

double strtod(const char *nptr, char **endptr)
{
    double val = 0.0;
    int sign = 1;
    const char *s = nptr;

    while (isspace(*s))
        s++;
    if (*s == '-')
    {
        sign = -1;
        s++;
    }
    else if (*s == '+')
        s++;

    while (isdigit(*s))
    {
        val = val * 10.0 + (*s - '0');
        s++;
    }
    if (*s == '.')
    {
        double factor = 1.0;
        s++;
        while (isdigit(*s))
        {
            factor *= 0.1;
            val += (*s - '0') * factor;
            s++;
        }
    }

    if (endptr)
        *endptr = (char *)s;
    return val * sign;
}

double atof(const char *nptr) { return strtod(nptr, NULL); }
float strtof(const char *nptr, char **endptr) { return (float)strtod(nptr, endptr); }

/* Sort & Search */

static void swap_bytes(char *a, char *b, size_t size)
{
    char temp;
    while (size--)
    {
        temp = *a;
        *a++ = *b;
        *b++ = temp;
    }
}

void qsort(void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *))
{
    if (nmemb < 2 || size == 0)
        return;

    char *base_ptr = (char *)base;
    char *pivot = base_ptr + (nmemb - 1) * size;
    char *i = base_ptr;
    char *j = base_ptr;

    /* Partition */
    for (; j < pivot; j += size)
    {
        if (compar(j, pivot) < 0)
        {
            if (i != j)
                swap_bytes(i, j, size);
            i += size;
        }
    }
    swap_bytes(i, pivot, size);

    /* Recurse */
    size_t left_count = (i - base_ptr) / size;
    qsort(base, left_count, size, compar);
    qsort(i + size, nmemb - left_count - 1, size, compar);
}

void *bsearch(const void *key, const void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *))
{
    size_t l = 0, u = nmemb;
    while (l < u)
    {
        size_t idx = (l + u) / 2;
        const void *p = (void *)((const char *)base + (idx * size));
        int cmp = compar(key, p);
        if (cmp < 0)
            u = idx;
        else if (cmp > 0)
            l = idx + 1;
        else
            return (void *)p;
    }
    return NULL;
}

/* Math & Mics */

int abs(int j) { return (j < 0) ? -j : j; }
long labs(long j) { return (j < 0) ? -j : j; }
long long llabs(long long j) { return (j < 0) ? -j : j; }

div_t div(int numer, int denom)
{
    div_t res = {numer / denom, numer % denom};
    return res;
}
ldiv_t ldiv(long numer, long denom)
{
    ldiv_t res = {numer / denom, numer % denom};
    return res;
}
lldiv_t lldiv(long long numer, long long denom)
{
    lldiv_t res = {numer / denom, numer % denom};
    return res;
}

static unsigned long next = 1;
int rand(void)
{
    next = next * 1103515245 + 12345;
    return (unsigned int)(next / 65536) % 32768;
}
void srand(unsigned int seed) { next = seed; }

/* Stub */
int mblen(const char *s, size_t n) { return (s && *s && n) ? 1 : 0; }
int mbtowc(wchar_t *pwc, const char *s, size_t n)
{
    if (!s)
        return 0;
    if (n == 0)
        return -1;
    if (pwc)
        *pwc = (wchar_t)*s;
    return (*s != 0);
}
int wctomb(char *s, wchar_t wchar)
{
    if (!s)
        return 0;
    *s = (char)wchar;
    return 1;
}
size_t mbstowcs(wchar_t *dest, const char *src, size_t n)
{
    size_t i = 0;
    while (src[i] && i < n)
    {
        dest[i] = (wchar_t)src[i];
        i++;
    }
    if (i < n)
        dest[i] = 0;
    return i;
}
size_t wcstombs(char *dest, const wchar_t *src, size_t n)
{
    size_t i = 0;
    while (src[i] && i < n)
    {
        dest[i] = (char)src[i];
        i++;
    }
    if (i < n)
        dest[i] = 0;
    return i;
}