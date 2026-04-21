/* Shim: musl expects this header */
#ifndef _FEATURES_H
#define _FEATURES_H

/* weak_alias: musl uses this for symbol aliasing (e.g. __memrchr -> memrchr) */
#define weak_alias(old, new) \
    extern __typeof(old) new __attribute__((__weak__, __alias__(#old)))

/* hidden attribute used by some musl sources */
#define hidden __attribute__((__visibility__("hidden")))

#endif
