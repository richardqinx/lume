#ifndef _STDLIB_H
#define _STDLIB_H

#include "ulib/types.h"
#include "ulib/limits.h"
#include "ulib/errno.h"

#ifdef __cplusplus
extern "C"
{
#endif

#ifndef NULL
#define NULL ((void *)0)
#endif

#define ERANGE 34 /* Math result not representable */
#define ENOMEM 12 /* Out of memory */

#define EXIT_SUCCESS 0
#define EXIT_FAILURE 1
#define RAND_MAX 32767
#define MB_CUR_MAX 1

typedef struct
{
    int quot;
    int rem;
} div_t;
typedef struct
{
    long quot;
    long rem;
} ldiv_t;
typedef struct
{
    long long quot;
    long long rem;
} lldiv_t;

typedef int (*__compar_fn_t)(const void *, const void *);

/* Memory Management */
void *malloc(size_t size);
void free(void *ptr);
void *calloc(size_t nmemb, size_t size);
void *realloc(void *ptr, size_t size);

/* Process Control */
int exit(int status);
void abort(void);
int atexit(void (*function)(void));
char *getenv(const char *name);
int system(const char *command);

/* String Conversion */
int atoi(const char *nptr);
long atol(const char *nptr);
long long atoll(const char *nptr);
double atof(const char *nptr);

long strtol(const char *nptr, char **endptr, int base);
unsigned long strtoul(const char *nptr, char **endptr, int base);
long long strtoll(const char *nptr, char **endptr, int base);
unsigned long long strtoull(const char *nptr, char **endptr, int base);

double strtod(const char *nptr, char **endptr);
float strtof(const char *nptr, char **endptr);

/* Search & Sort*/
void *bsearch(const void *key, const void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *));
void qsort(void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *));

/* Math & Mics */
int abs(int j);
long labs(long j);
long long llabs(long long j);
div_t div(int numer, int denom);
ldiv_t ldiv(long numer, long denom);
lldiv_t lldiv(long long numer, long long denom);

int rand(void);
void srand(unsigned int seed);

int mblen(const char *s, size_t n);
int mbtowc(wchar_t *pwc, const char *s, size_t n);
int wctomb(char *s, wchar_t wchar);
size_t mbstowcs(wchar_t *dest, const char *src, size_t n);
size_t wcstombs(char *dest, const wchar_t *src, size_t n);

#ifdef __cplusplus
}
#endif

#endif /* _STDLIB_H */