#include "ulib/stdlib.h"


void *operator new(unsigned long n)
{
    return malloc(n);
}

void *operator new[](unsigned long n)
{
    return malloc(n);
}

void operator delete(void *p)
{
    free(p);
}

void operator delete[](void *p)
{
    free(p);
}

void operator delete(void *p, unsigned long)
{
    free(p);
}

void operator delete[](void *p, unsigned long)
{
    free(p);
}