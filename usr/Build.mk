targets += host/gen_init_cpio
target.host/gen_init_cpio.kind := host-tool
target.host/gen_init_cpio.sources := usr/gen_init_cpio.c
target.host/gen_init_cpio.host-cflags := -Wno-sign-compare
