#pragma once
#include "common/types.h"


void *memset(void *dst, int c, uint n);
int memcmp(const void *v1, const void *v2, uint n);
void *memmove(void *dst, const void *src, uint n);
void *memcpy(void *dst, const void *src, uint n);


void strcpy(char *dst, const char *src);
int strlen(const char *s);
int strcmp(const char *s1, const char *s2);
int strcasecmp(const char *s1, const char *s2);