/* Standard I/O Library for Lume OS */

#ifndef _STDIO_H
#define _STDIO_H

#include <stdarg.h>
#include "ulib/types.h"

#ifdef __cplusplus
extern "C"  {
#endif

/*Type Definition (Adjusted According to Architecture)*/
#ifndef NULL
#define NULL ((void *)0)
#endif

/*Macro definition*/
#define EOF (-1)

#define SEEK_SET 0
#define SEEK_CUR 1
#define SEEK_END 2

#define BUFSIZ 1024


/* FILE structure */
typedef struct
{
    int fd;
    int flags;
    int error;
    int eof;

    char buffer[BUFSIZ];

    int buf_write_pos;

    int buf_read_pos;
    int buf_read_cnt;

    int buf_mode;
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
int ungetc(int c, FILE *stream);

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

#ifdef __cplusplus
}
#endif
#endif /* _STDIO_H */