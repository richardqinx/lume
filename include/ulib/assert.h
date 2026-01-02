#ifndef _ASSERT_H
#define _ASSERT_H

#ifdef NDEBUG
#define assert(ignore) ((void)0)
#else
#ifdef __cplusplus
extern "C"
{
#endif
    void __assert_fail(const char *expr, const char *file, int line, const char *func);
#ifdef __cplusplus
}
#endif

#define assert(expr) \
    ((expr) ? (void)0 : __assert_fail(#expr, __FILE__, __LINE__, __func__))
#endif

#endif