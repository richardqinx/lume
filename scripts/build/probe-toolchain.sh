#!/bin/sh
# SPDX-License-Identifier: GPL-2.0-or-later

set -eu
output=$1
cc=$2
cxx=$3
ld=$4
family=$5
target=$6
gcc_toolchain=$7
sysroot=$8
ktl_include=$9
ktl_after_include=${10}
libc_include=${11}
libc_after_include=${12}
libcxx_include=${13}
compiler_resource_include=${14}

set --
if [ "$family" = clang ]; then
    set -- "$@" "--target=$target"
    [ -z "$gcc_toolchain" ] || set -- "$@" "--gcc-toolchain=$gcc_toolchain"
    [ -z "$sysroot" ] || set -- "$@" "--sysroot=$sysroot"
fi

probe() {
    language=$1
    standard=$2
    shift 2
    compiler=$cc
    [ "$language" = c++ ] && compiler=$cxx
    printf '' | "$compiler" "$@" "-std=$standard" -x "$language" \
        -fsyntax-only - >/dev/null 2>&1
}

probe_libcxx() {
    printf '%s\n' \
        '#include <ktl/array.h>' \
        '#include <ktl/atomic.h>' \
        '#include <ktl/optional.h>' \
        '#include <ktl/span.h>' \
        '#include <ktl/string_view.h>' \
        'constexpr ktl::array<int, 2> values{1, 2};' \
        'static_assert(values[1] == 2);' | \
        "$cxx" "$@" -std=c++23 -ffreestanding -fno-exceptions -fno-rtti \
        -nostdinc -I include -I "$ktl_include" -I "$libc_include" \
        -isystem "$compiler_resource_include" \
        -isystem "$libcxx_include" -idirafter "$ktl_after_include" \
        -idirafter "$libc_after_include" -fsyntax-only -x c++ - >/dev/null 2>&1
}

tmp="$output.tmp.$$"
mkdir -p "$(dirname "$output")"
{
    echo "cc=$($cc --version | head -n 1)"
    echo "cxx=$($cxx --version | head -n 1)"
    echo "ld=$($ld --version | head -n 1)"
    echo "target=$target"
    printf 'c23='; if probe c gnu23 "$@"; then echo yes; else echo no; fi
    printf 'cxx23='; if probe c++ c++23 "$@"; then echo yes; else echo no; fi
    printf 'libcxx-headers='; if probe_libcxx "$@"; then echo yes; else echo no; fi
    printf 'fno-pie='; if probe c++ c++23 "$@" -fno-pie; then echo yes; else echo no; fi
    printf 'mcmodel-medany='; if probe c++ c++23 "$@" -mcmodel=medany; then echo yes; else echo no; fi
} > "$tmp"
mv -f "$tmp" "$output"

grep -q '^c23=yes$' "$output"
grep -q '^cxx23=yes$' "$output"
grep -q '^libcxx-headers=yes$' "$output"
grep -q '^fno-pie=yes$' "$output"
grep -q '^mcmodel-medany=yes$' "$output"
