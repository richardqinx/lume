targets += lib/ktl/headers lib/libc/headers lib/ktl lib/runtime lib/string \
           lib/libfdt lib/core

target.lib/ktl/headers.kind := header-library
target.lib/ktl/headers.public-includes := lib/ktl/include
target.lib/ktl/headers.public-after-includes := lib/ktl/include-after

target.lib/libc/headers.kind := header-library
target.lib/libc/headers.public-includes := lib/libc/include
target.lib/libc/headers.public-after-includes := lib/libc/include-after
target.lib/libc/headers.deps := lib/ktl/headers

target.lib/ktl.kind := source-set
target.lib/ktl.sources := lib/ktl/popcount.cc lib/ktl/stub-new.cc
target.lib/ktl.deps := lib/ktl/headers lib/libc/headers

target.lib/runtime.kind := source-set
target.lib/runtime.sources := \
    lib/cxx_abi.cc lib/rbtree.cc lib/kobject.cc lib/kprintf.cc lib/klog.cc \
    lib/random.cc lib/printf.c

target.lib/string.kind := static-library
target.lib/string.sources := $(sort $(wildcard lib/string/*.c))

# Architecture assembly replaces the matching generic C implementation.
string-arch.riscv :=
string-arch.x86_64 := x86_64
string-arch.aarch64 := aarch64
string-arch.i386 := i386
string-arch.arm := arm
string-arch := $(string-arch.$(ARCH))
ifneq ($(string-arch),)
string-asm := $(sort $(wildcard lib/string/$(string-arch)/*.S) \
                           $(wildcard lib/string/$(string-arch)/*.s))
string-asm-names := $(sort $(basename $(notdir $(string-asm))))
target.lib/string.sources := $(filter-out \
    $(foreach name,$(string-asm-names),lib/string/$(name).c), \
    $(target.lib/string.sources)) $(string-asm)
endif

target.lib/libfdt.kind := static-library
target.lib/libfdt.sources := \
    lib/fdt.c lib/fdt_ro.c lib/fdt_wip.c lib/fdt_rw.c lib/fdt_sw.c \
    lib/fdt_strerror.c lib/fdt_empty_tree.c lib/fdt_addresses.c
target.lib/libfdt.private-includes := scripts/dtc/libfdt
target.lib/libfdt.cflags := -Wno-parentheses -Wno-sign-compare

target.lib/core.kind := header-library
target.lib/core.deps := lib/ktl lib/libc/headers lib/runtime lib/string lib/libfdt
