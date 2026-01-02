#include "stdio.h"

/* Include STB Sprintf Implementation */
#define STB_SPRINTF_IMPLEMENTATION
#include "stb_sprintf.h"

/*  Syscall Implementation  */

const int64 STDIN_FD = 0;
const int64 STDOUT_FD = 1;
const int64 STDERR_FD = 2;

#if defined(__x86_64__)

const int64 SYS_read = 0;
const int64 SYS_write = 1;
const int64 SYS_open = 2;
const int64 SYS_close = 3;
const int64 SYS_lseek = 8;

int64 write(int64 fd, const char *buf, uint64 count)
{
    int64 ret;
    __asm__ volatile("syscall" : "=a"(ret) : "a"(SYS_write), "D"(fd), "S"(buf), "d"(count) : "rcx", "r11", "memory");
    return ret;
}
int64 read(int64 fd, char *buf, uint64 count)
{
    int64 ret;
    __asm__ volatile("syscall" : "=a"(ret) : "a"(SYS_read), "D"(fd), "S"(buf), "d"(count) : "rcx", "r11", "memory");
    return ret;
}
int64 open(const char *path, int flags, int mode)
{
    int64 ret;
    __asm__ volatile("syscall" : "=a"(ret) : "a"(SYS_open), "D"(path), "S"(flags), "d"(mode) : "rcx", "r11", "memory");
    return ret;
}
int64 close(int64 fd)
{
    int64 ret;
    __asm__ volatile("syscall" : "=a"(ret) : "a"(SYS_close), "D"(fd) : "rcx", "r11", "memory");
    return ret;
}
int64 lseek(int64 fd, int64 offset, int whence)
{
    int64 ret;
    __asm__ volatile("syscall" : "=a"(ret) : "a"(SYS_lseek), "D"(fd), "S"(offset), "d"(whence) : "rcx", "r11", "memory");
    return ret;
}

#elif defined(__riscv)

const int64 SYS_read = 63;
const int64 SYS_write = 64;
const int64 SYS_open = 56; // openat
const int64 SYS_close = 57;
const int64 SYS_lseek = 62;

int64 write(int64 fd, const char *buf, uint64 count)
{
    register int64 a7 asm("a7") = SYS_write;
    register int64 a0 asm("a0") = fd;
    register int64 a1 asm("a1") = (int64)buf;
    register int64 a2 asm("a2") = count;
    __asm__ volatile("ecall" : "+r"(a0) : "r"(a7), "r"(a0), "r"(a1), "r"(a2) : "memory");
    return a0;
}
int64 read(int64 fd, char *buf, uint64 count)
{
    register int64 a7 asm("a7") = SYS_read;
    register int64 a0 asm("a0") = fd;
    register int64 a1 asm("a1") = (int64)buf;
    register int64 a2 asm("a2") = count;
    __asm__ volatile("ecall" : "+r"(a0) : "r"(a7), "r"(a0), "r"(a1), "r"(a2) : "memory");
    return a0;
}
int64 open(const char *path, int flags, int mode)
{
    register int64 a7 asm("a7") = SYS_open;
    register int64 a0 asm("a0") = -100; // AT_FDCWD
    register int64 a1 asm("a1") = (int64)path;
    register int64 a2 asm("a2") = flags;
    register int64 a3 asm("a3") = mode;
    __asm__ volatile("ecall" : "+r"(a0) : "r"(a7), "r"(a0), "r"(a1), "r"(a2), "r"(a3) : "memory");
    return a0;
}
int64 close(int64 fd)
{
    register int64 a7 asm("a7") = SYS_close;
    register int64 a0 asm("a0") = fd;
    __asm__ volatile("ecall" : "+r"(a0) : "r"(a7), "r"(a0) : "memory");
    return a0;
}
int64 lseek(int64 fd, int64 offset, int whence)
{
    register int64 a7 asm("a7") = SYS_lseek;
    register int64 a0 asm("a0") = fd;
    register int64 a1 asm("a1") = offset;
    register int64 a2 asm("a2") = whence;
    __asm__ volatile("ecall" : "+r"(a0) : "r"(a7), "r"(a0), "r"(a1), "r"(a2) : "memory");
    return a0;
}

#else
#error "Architecture not supported"
#endif

/*  Memory and String Functions  */

void *memset(void *dst, int c, uint64 n)
{
    char *cdst = (char *)dst;
    for (uint64 i = 0; i < n; i++)
        cdst[i] = (char)c;
    return dst;
}

void *memmove(void *vdst, const void *vsrc, uint64 n)
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

void *memcpy(void *vdst, const void *vsrc, uint64 n) { return memmove(vdst, vsrc, n); }

int memcmp(const void *s1, const void *s2, uint64 n)
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

uint64 strlen(const char *s)
{
    const char *p = s;
    while (*p)
        p++;
    return (uint64)(p - s);
}

char *strcpy(char *dst, const char *src)
{
    char *os = dst;
    while ((*dst++ = *src++) != 0)
        ;
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

int strcmp(const char *p, const char *q)
{
    while (*p && *p == *q)
    {
        p++;
        q++;
    }
    return (int)((unsigned char)*p - (unsigned char)*q);
}

static int isspace(int c)
{
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
}

int64 strtoll(const char *str, char **endptr, int base)
{
    const char *s = str;
    int64 acc = 0;
    int c;
    int neg = 0;
    int any = 0;

    while (isspace(*s))
        s++;
    if (*s == '-')
    {
        neg = 1;
        s++;
    }
    else if (*s == '+')
    {
        s++;
    }

    if ((base == 0 || base == 16) && *s == '0' && (s[1] == 'x' || s[1] == 'X'))
    {
        c = s[2];
        s += 2;
        base = 16;
    }
    else if (base == 0 && *s == '0')
    {
        base = 8;
    }
    else if (base == 0)
    {
        base = 10;
    }

    for (;; c = *s++)
    {
        c = *s;
        if (c >= '0' && c <= '9')
            c -= '0';
        else if (c >= 'A' && c <= 'Z')
            c -= 'A' - 10;
        else if (c >= 'a' && c <= 'z')
            c -= 'a' - 10;
        else
            break;
        if (c >= base)
            break;
        if (any < 0 || acc > (0x7FFFFFFFFFFFFFFFLL / base))
            any = -1;
        else
        {
            acc *= base;
            acc += c;
            any = 1;
        }
    }
    if (endptr != 0)
        *endptr = (char *)(any ? s : str);
    return (neg ? -acc : acc);
}

/*  Core Formatting Implementation  */

static int _ul_to_str_invert(char *buf, uint64 val, int base, int uppercase)
{
    int i = 0;
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    if (val == 0)
    {
        buf[i++] = '0';
        return i;
    }
    while (val != 0)
    {
        buf[i++] = digits[val % base];
        val /= base;
    }
    return i;
}

typedef struct
{
    char *buf;
    uint64 limit;
    uint64 written;
    int fd;
} _OutContext;

static void _out_char(_OutContext *ctx, char c)
{
    if (ctx->fd != -1)
    {
        write(ctx->fd, &c, 1);
        ctx->written++;
    }
    else
    {
        if (ctx->limit > 0 && ctx->written < ctx->limit - 1)
        {
            ctx->buf[ctx->written] = c;
        }
        ctx->written++;
    }
}

static int _vprintf_core(_OutContext *ctx, const char *format, va_list ap)
{
    const char *p = format;
    char num_buf[32];

    while (*p)
    {
        if (*p != '%')
        {
            _out_char(ctx, *p++);
            continue;
        }
        p++;

        int flag_left = 0, flag_zero = 0, flag_plus = 0, flag_space = 0, flag_hash = 0;
        while (1)
        {
            if (*p == '-')
                flag_left = 1;
            else if (*p == '0')
                flag_zero = 1;
            else if (*p == '+')
                flag_plus = 1;
            else if (*p == ' ')
                flag_space = 1;
            else if (*p == '#')
                flag_hash = 1;
            else
                break;
            p++;
        }

        int width = 0;
        if (*p == '*')
        {
            width = va_arg(ap, int);
            if (width < 0)
            {
                flag_left = 1;
                width = -width;
            }
            p++;
        }
        else
        {
            while (*p >= '0' && *p <= '9')
            {
                width = width * 10 + (*p - '0');
                p++;
            }
        }

        int precision = -1;
        if (*p == '.')
        {
            p++;
            if (*p == '*')
            {
                precision = va_arg(ap, int);
                p++;
            }
            else
            {
                precision = 0;
                while (*p >= '0' && *p <= '9')
                {
                    precision = precision * 10 + (*p - '0');
                    p++;
                }
            }
        }

        int len_mod = 0;
        if (*p == 'l')
        {
            len_mod = 1;
            p++;
            if (*p == 'l')
            {
                len_mod = 2;
                p++;
            }
        }
        else if (*p == 'z')
        {
            len_mod = 2;
            p++;
        }

        char spec = *p++;
        if (!spec)
            break;

        if (spec == 'd' || spec == 'i' || spec == 'u' || spec == 'x' || spec == 'X' || spec == 'p')
        {
            uint64 val;
            int is_signed = (spec == 'd' || spec == 'i');
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;

            if (spec == 'p')
                val = (uint64)va_arg(ap, void *);
            else if (len_mod == 2)
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
            else if (len_mod == 1)
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
            else
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);

            char sign_char = 0;
            if (is_signed)
            {
                int64 sval = (int64)val;
                if (sval < 0)
                {
                    sign_char = '-';
                    val = (uint64)(-sval);
                }
                else if (flag_plus)
                    sign_char = '+';
                else if (flag_space)
                    sign_char = ' ';
            }

            int digit_len = _ul_to_str_invert(num_buf, val, base, (spec == 'X'));
            if (precision >= 0)
                flag_zero = 0;
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
            if (precision == 0 && val == 0)
                digit_len = 0;

            int prefix_len = sign_char ? 1 : 0;
            char *prefix_str = NULL;
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
            {
                prefix_str = (spec == 'X') ? "0X" : "0x";
                prefix_len += 2;
            }

            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;

            if (!flag_left && !flag_zero)
                for (int i = 0; i < padding; i++)
                    _out_char(ctx, ' ');
            if (sign_char)
                _out_char(ctx, sign_char);
            if (prefix_str)
            {
                _out_char(ctx, prefix_str[0]);
                _out_char(ctx, prefix_str[1]);
            }
            int total_zeros = prec_zeros + ((flag_zero && !flag_left) ? padding : 0);
            for (int i = 0; i < total_zeros; i++)
                _out_char(ctx, '0');
            for (int i = digit_len - 1; i >= 0; i--)
                _out_char(ctx, num_buf[i]);
            if (flag_left)
                for (int i = 0; i < padding; i++)
                    _out_char(ctx, ' ');
        }
        else if (spec == 'f' || spec == 'F' || spec == 'e' || spec == 'E' || spec == 'g' || spec == 'G')
        {
            char fmt_tmp[32];
            int f_idx = 0;
            fmt_tmp[f_idx++] = '%';
            if (flag_left)
                fmt_tmp[f_idx++] = '-';
            if (flag_zero)
                fmt_tmp[f_idx++] = '0';
            if (flag_plus)
                fmt_tmp[f_idx++] = '+';
            if (flag_space)
                fmt_tmp[f_idx++] = ' ';
            if (flag_hash)
                fmt_tmp[f_idx++] = '#';
            if (width > 0)
                f_idx += sprintf(&fmt_tmp[f_idx], "%d", width);
            if (precision >= 0)
                f_idx += sprintf(&fmt_tmp[f_idx], ".%d", precision);
            fmt_tmp[f_idx++] = spec;
            fmt_tmp[f_idx] = '\0';
            double f_val = va_arg(ap, double);
            char f_buf[128];
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
            for (int i = 0; f_buf[i] != '\0'; i++)
                _out_char(ctx, f_buf[i]);
        }
        else if (spec == 's')
        {
            const char *s = va_arg(ap, char *);
            if (!s)
                s = "(null)";
            int len = 0;
            const char *tmp = s;
            while (*tmp && (precision < 0 || len < precision))
            {
                tmp++;
                len++;
            }
            int padding = (width > len) ? width - len : 0;
            if (!flag_left)
                for (int i = 0; i < padding; i++)
                    _out_char(ctx, ' ');
            for (int i = 0; i < len; i++)
                _out_char(ctx, s[i]);
            if (flag_left)
                for (int i = 0; i < padding; i++)
                    _out_char(ctx, ' ');
        }
        else if (spec == 'c')
        {
            char c = (char)va_arg(ap, int);
            int padding = (width > 1) ? width - 1 : 0;
            if (!flag_left)
                for (int i = 0; i < padding; i++)
                    _out_char(ctx, ' ');
            _out_char(ctx, c);
            if (flag_left)
                for (int i = 0; i < padding; i++)
                    _out_char(ctx, ' ');
        }
        else
        {
            _out_char(ctx, '%');
            if (spec != '%')
                _out_char(ctx, spec);
        }
    }
    return (int)ctx->written;
}

int vsnprintf(char *str, uint64 size, const char *format, va_list ap)
{
    _OutContext ctx;
    ctx.buf = str;
    ctx.limit = size;
    ctx.written = 0;
    ctx.fd = -1;
    _vprintf_core(&ctx, format, ap);
    if (size > 0)
    {
        if (ctx.written < size)
            str[ctx.written] = '\0';
        else
            str[size - 1] = '\0';
    }
    return (int)ctx.written;
}
int snprintf(char *str, uint64 size, const char *format, ...)
{
    va_list ap;
    va_start(ap, format);
    int ret = vsnprintf(str, size, format, ap);
    va_end(ap);
    return ret;
}
int sprintf(char *str, const char *format, ...)
{
    va_list ap;
    va_start(ap, format);
    int ret = vsnprintf(str, (uint64)-1, format, ap);
    va_end(ap);
    return ret;
}
int printf(const char *format, ...)
{
    va_list ap;
    va_start(ap, format);
    _OutContext ctx;
    ctx.buf = NULL;
    ctx.limit = 0;
    ctx.written = 0;
    ctx.fd = STDOUT_FD;
    _vprintf_core(&ctx, format, ap);
    va_end(ap);
    return (int)ctx.written;
}

/*  Core Function Implementation  */

typedef struct
{
    const char *buf;
    int fd;
    uint64 pos;
    int ungotten;
} _InContext;

static int _in_char(_InContext *ctx)
{
    if (ctx->ungotten >= 0)
    {
        int c = ctx->ungotten;
        ctx->ungotten = -1;
        return c;
    }
    if (ctx->fd == -1)
    {
        if (ctx->buf[ctx->pos] == '\0')
            return -1;
        return (unsigned char)ctx->buf[ctx->pos++];
    }
    char c;
    if (read(ctx->fd, &c, 1) == 1)
        return (unsigned char)c;
    return -1;
}

static void _unget_char(_InContext *ctx, int c)
{
    if (c != -1)
        ctx->ungotten = c;
}
static void _skip_space(_InContext *ctx)
{
    int c;
    while ((c = _in_char(ctx)) != -1)
    {
        if (!isspace(c))
        {
            _unget_char(ctx, c);
            break;
        }
    }
}

static double _simple_strtod(const char *str, char **endptr)
{
    double val = 0.0;
    int sign = 1;
    if (*str == '-')
    {
        sign = -1;
        str++;
    }
    else if (*str == '+')
        str++;
    while (*str >= '0' && *str <= '9')
    {
        val = val * 10.0 + (*str - '0');
        str++;
    }
    if (*str == '.')
    {
        str++;
        double div = 10.0;
        while (*str >= '0' && *str <= '9')
        {
            val += (*str - '0') / div;
            div *= 10.0;
            str++;
        }
    }
    if (*str == 'e' || *str == 'E')
    {
        str++;
        int esign = 1;
        if (*str == '-')
        {
            esign = -1;
            str++;
        }
        else if (*str == '+')
            str++;
        int eval = 0;
        while (*str >= '0' && *str <= '9')
        {
            eval = eval * 10 + (*str - '0');
            str++;
        }
        double p = 1.0;
        while (eval--)
            p *= 10.0;
        if (esign == 1)
            val *= p;
        else
            val /= p;
    }
    if (endptr)
        *endptr = (char *)str;
    return sign * val;
}

static int _vscanf_core(_InContext *ctx, const char *format, va_list ap)
{
    int assigned = 0;
    const char *p = format;
    while (*p)
    {
        if (isspace(*p))
        {
            _skip_space(ctx);
            while (isspace(*p))
                p++;
            continue;
        }
        if (*p != '%')
        {
            _skip_space(ctx);
            int c = _in_char(ctx);
            if (c != *p)
            {
                _unget_char(ctx, c);
                return assigned;
            }
            p++;
            continue;
        }
        p++;
        int suppress = 0;
        if (*p == '*')
        {
            suppress = 1;
            p++;
        }
        int width = -1;
        while (*p >= '0' && *p <= '9')
        {
            if (width == -1)
                width = 0;
            width = width * 10 + (*p - '0');
            p++;
        }
        int len_mod = 0;
        if (*p == 'l')
        {
            len_mod = 1;
            p++;
            if (*p == 'l')
            {
                len_mod = 2;
                p++;
            }
        }
        else if (*p == 'h')
        {
            p++;
            if (*p == 'h')
                p++;
        }
        char spec = *p++;
        if (!spec)
            break;

        if (spec == 'd' || spec == 'i' || spec == 'u' || spec == 'x')
        {
            _skip_space(ctx);
            char num_buf[64];
            int i = 0, c = _in_char(ctx);
            if (c == '-' || c == '+')
            {
                num_buf[i++] = (char)c;
                c = _in_char(ctx);
            }
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
            while (c != -1 && i < 63)
            {
                int digit = (c >= '0' && c <= '9');
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
                int x = (c == 'x' || c == 'X');
                if (base == 0 && i == 1 && num_buf[0] == '0' && x)
                    base = 16;
                if (width > 0 && i >= width)
                    break;
                if (digit || hex || x)
                {
                    num_buf[i++] = (char)c;
                    c = _in_char(ctx);
                }
                else
                    break;
            }
            num_buf[i] = '\0';
            _unget_char(ctx, c);
            if (i == 0)
                return assigned;
            if (!suppress)
            {
                int64 val = strtoll(num_buf, NULL, base);
                if (len_mod == 2)
                    *va_arg(ap, int64 *) = val;
                else if (len_mod == 1)
                    *va_arg(ap, long *) = (long)val;
                else
                    *va_arg(ap, int *) = (int)val;
                assigned++;
            }
        }
        else if (spec == 'f' || spec == 'F' || spec == 'e' || spec == 'E' || spec == 'g' || spec == 'G')
        {
            _skip_space(ctx);
            char num_buf[64];
            int i = 0, c = _in_char(ctx);
            if (c == '-' || c == '+')
            {
                num_buf[i++] = (char)c;
                c = _in_char(ctx);
            }
            while (c != -1 && i < 63)
            {
                if ((c >= '0' && c <= '9') || c == '.' || c == 'e' || c == 'E' || c == '+' || c == '-')
                {
                    num_buf[i++] = (char)c;
                    c = _in_char(ctx);
                }
                else
                    break;
            }
            num_buf[i] = '\0';
            _unget_char(ctx, c);
            if (i == 0)
                return assigned;
            if (!suppress)
            {
                double val = _simple_strtod(num_buf, NULL);
                if (len_mod == 1)
                    *va_arg(ap, double *) = val;
                else
                    *va_arg(ap, float *) = (float)val;
                assigned++;
            }
        }
        else if (spec == 's')
        {
            _skip_space(ctx);
            char *buf = suppress ? NULL : va_arg(ap, char *);
            int i = 0, c = _in_char(ctx);
            while (c != -1 && !isspace(c))
            {
                if (width > 0 && i >= width)
                    break;
                if (!suppress)
                    buf[i] = (char)c;
                i++;
                c = _in_char(ctx);
            }
            if (!suppress)
                buf[i] = '\0';
            _unget_char(ctx, c);
            if (i > 0 && !suppress)
                assigned++;
        }
        else if (spec == 'c')
        {
            int count = (width > 0) ? width : 1;
            char *buf = suppress ? NULL : va_arg(ap, char *);
            for (int i = 0; i < count; i++)
            {
                int c = _in_char(ctx);
                if (c == -1)
                    return assigned;
                if (!suppress)
                    buf[i] = (char)c;
            }
            if (!suppress)
                assigned++;
        }
    }
    return assigned;
}

int sscanf(const char *str, const char *format, ...)
{
    va_list ap;
    va_start(ap, format);
    _InContext ctx;
    ctx.buf = str;
    ctx.fd = -1;
    ctx.pos = 0;
    ctx.ungotten = -1;
    int ret = _vscanf_core(&ctx, format, ap);
    va_end(ap);
    return ret;
}
int scanf(const char *format, ...)
{
    va_list ap;
    va_start(ap, format);
    _InContext ctx;
    ctx.buf = NULL;
    ctx.fd = STDIN_FD;
    ctx.pos = 0;
    ctx.ungotten = -1;
    int ret = _vscanf_core(&ctx, format, ap);
    va_end(ap);
    return ret;
}

/*  FILE Stream Implementation  */

#define O_RDONLY 00
#define O_WRONLY 01
#define O_RDWR 02
#define O_CREAT 0100
#define O_TRUNC 01000
#define O_APPEND 02000

#define MAX_FILES 8
static FILE _file_pool[MAX_FILES];
static FILE _stdin = {.fd = 0, .used = 1};
static FILE _stdout = {.fd = 1, .used = 1};
static FILE _stderr = {.fd = 2, .used = 1};

FILE *stdin = &_stdin;
FILE *stdout = &_stdout;
FILE *stderr = &_stderr;

FILE *fopen(const char *filename, const char *mode)
{
    int flags = 0;
    if (strcmp(mode, "r") == 0)
        flags = O_RDONLY;
    else if (strcmp(mode, "w") == 0)
        flags = O_WRONLY | O_CREAT | O_TRUNC;
    else if (strcmp(mode, "a") == 0)
        flags = O_WRONLY | O_CREAT | O_APPEND;
    else if (strcmp(mode, "r+") == 0)
        flags = O_RDWR;
    else
        return NULL;

    FILE *f = NULL;
    for (int i = 0; i < MAX_FILES; i++)
        if (!_file_pool[i].used)
        {
            f = &_file_pool[i];
            break;
        }
    if (!f)
        return NULL;

    int64 fd = open(filename, flags, 0666);
    if (fd < 0)
        return NULL;
    f->fd = (int)fd;
    f->flags = flags;
    f->error = 0;
    f->eof = 0;
    f->used = 1;
    return f;
}

int fclose(FILE *stream)
{
    if (!stream || !stream->used)
        return -1;
    if (stream == stdin || stream == stdout || stream == stderr)
        return 0;
    close(stream->fd);
    stream->used = 0;
    stream->fd = -1;
    return 0;
}

int fflush(FILE *stream) { return 0; }

int fprintf(FILE *stream, const char *format, ...)
{
    if (!stream)
        return -1;
    va_list ap;
    va_start(ap, format);
    _OutContext ctx;
    ctx.buf = NULL;
    ctx.limit = 0;
    ctx.written = 0;
    ctx.fd = stream->fd;
    _vprintf_core(&ctx, format, ap);
    va_end(ap);
    return (int)ctx.written;
}

int fscanf(FILE *stream, const char *format, ...)
{
    if (!stream)
        return -1;
    va_list ap;
    va_start(ap, format);
    _InContext ctx;
    ctx.buf = NULL;
    ctx.fd = stream->fd;
    ctx.pos = 0;
    ctx.ungotten = -1;
    int ret = _vscanf_core(&ctx, format, ap);
    va_end(ap);
    return ret;
}

int fputc(int c, FILE *stream)
{
    if (!stream)
        return -1;
    char ch = (char)c;
    write(stream->fd, &ch, 1);
    return c;
}

int fputs(const char *s, FILE *stream)
{
    if (!stream)
        return -1;
    write(stream->fd, s, strlen(s));
    return 0;
}

int fgetc(FILE *stream)
{
    if (!stream)
        return -1;
    char c;
    if (read(stream->fd, &c, 1) == 1)
        return (unsigned char)c;
    stream->eof = 1;
    return -1;
}

char *fgets(char *str, int n, FILE *stream)
{
    if (!stream || !stream->used || n <= 0)
        return NULL;
    int i = 0, c;
    while (i < n - 1)
    {
        c = fgetc(stream);
        if (c == -1)
        {
            if (i == 0)
                return NULL;
            break;
        }
        str[i++] = (char)c;
        if (c == '\n')
            break;
    }
    str[i] = '\0';
    return str;
}

uint64 fread(void *ptr, uint64 size, uint64 nmemb, FILE *stream)
{
    if (!stream || !stream->used || !ptr || size == 0 || nmemb == 0)
        return 0;
    uint64 total = size * nmemb, read_bytes = 0;
    char *p = (char *)ptr;
    while (read_bytes < total)
    {
        int64 ret = read(stream->fd, p + read_bytes, total - read_bytes);
        if (ret > 0)
            read_bytes += ret;
        else if (ret == 0)
        {
            stream->eof = 1;
            break;
        }
        else
        {
            stream->error = 1;
            break;
        }
    }
    return read_bytes / size;
}

uint64 fwrite(const void *ptr, uint64 size, uint64 nmemb, FILE *stream)
{
    if (!stream || !stream->used || !ptr || size == 0 || nmemb == 0)
        return 0;
    uint64 total = size * nmemb, written = 0;
    const char *p = (const char *)ptr;
    while (written < total)
    {
        int64 ret = write(stream->fd, p + written, total - written);
        if (ret > 0)
            written += ret;
        else
        {
            stream->error = 1;
            break;
        }
    }
    return written / size;
}

int fseek(FILE *stream, long offset, int whence)
{
    if (!stream || !stream->used)
        return -1;
    stream->eof = 0;
    if (lseek(stream->fd, offset, whence) < 0)
    {
        stream->error = 1;
        return -1;
    }
    return 0;
}
long ftell(FILE *stream)
{
    if (!stream || !stream->used)
        return -1L;
    int64 ret = lseek(stream->fd, 0, SEEK_CUR);
    if (ret < 0)
    {
        stream->error = 1;
        return -1L;
    }
    return (long)ret;
}
void rewind(FILE *stream)
{
    if (stream)
    {
        fseek(stream, 0, SEEK_SET);
        stream->error = 0;
    }
}

int feof(FILE *stream) { return (stream && stream->used) ? stream->eof : 1; }
int ferror(FILE *stream) { return (stream && stream->used) ? stream->error : 1; }
void clearerr(FILE *stream)
{
    if (stream && stream->used)
    {
        stream->error = 0;
        stream->eof = 0;
    }
}