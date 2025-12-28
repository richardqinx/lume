/* Standard I/O Library for Lume OS */

#ifndef _STDIO_H
#define _STDIO_H

#include <stdarg.h>

/*Type Definition (Adjusted According to Architecture)*/
#ifndef NULL
#define NULL ((void *)0)
#endif

/*Macro definition*/
#define EOF (-1)

#define SEEK_SET 0
#define SEEK_CUR 1
#define SEEK_END 2

/* Basic integer types */
typedef unsigned int uint;
typedef unsigned short ushort;
typedef unsigned char uchar;

typedef unsigned char uint8;
typedef unsigned short uint16;
typedef unsigned int uint32;
typedef unsigned long long uint64;

typedef char int8;
typedef short int16;
typedef int int32;
typedef long long int64;
typedef long long intptr_t;

/* FILE structure */
typedef struct
{
    int fd;    // File descriptor
    int flags; // Status flag
    int error; // Error flag
    int eof;   // EOF flag
    int used;  // Static pool occupancy flag
} FILE;

/* standard stream object */
extern FILE *stdin;
extern FILE *stdout;
extern FILE *stderr;

/* Function Declaration */

/* File Operations */
FILE *fopen(const char *filename, const char *mode);
int fclose(FILE *stream);
int fflush(FILE *stream); // Not implement

/* Formatted input and output */
int printf(const char *format, ...);
int scanf(const char *format, ...);
int sprintf(char *str, const char *format, ...);
int snprintf(char *str, uint64 size, const char *format, ...);
int vsnprintf(char *str, uint64 size, const char *format, va_list ap);
int sscanf(const char *str, const char *format, ...);

int fprintf(FILE *stream, const char *format, ...);
int fscanf(FILE *stream, const char *format, ...);

/* Character/String Read and Write */
int fputc(int c, FILE *stream);
int fputs(const char *s, FILE *stream);
int fgetc(FILE *stream);
char *fgets(char *str, int n, FILE *stream);

/* Common Macros/Wrapper Functions */
#define getchar() fgetc(stdin)
#define putchar(c) fputc((c), stdout)

/* Binary read and write */
uint64 fread(void *ptr, uint64 size, uint64 nmemb, FILE *stream);
uint64 fwrite(const void *ptr, uint64 size, uint64 nmemb, FILE *stream);

/* File location */
int fseek(FILE *stream, long offset, int whence);
long ftell(FILE *stream);
void rewind(FILE *stream);

/* Status Inquiry */
int feof(FILE *stream);
int ferror(FILE *stream);
void clearerr(FILE *stream);

/* Low-level system call */
int64 open(const char *path, int flags, int mode);
int64 close(int64 fd);
int64 read(int64 fd, char *buf, uint64 count);
int64 write(int64 fd, const char *buf, uint64 count);
int64 lseek(int64 fd, int64 offset, int whence);

#endif /* _STDIO_H */