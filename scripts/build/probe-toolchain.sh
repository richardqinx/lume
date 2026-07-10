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

tmp="$output.tmp.$$"
mkdir -p "$(dirname "$output")"
{
    echo "cc=$($cc --version | head -n 1)"
    echo "cxx=$($cxx --version | head -n 1)"
    echo "ld=$($ld --version | head -n 1)"
    echo "target=$target"
    printf 'c23='; if probe c gnu23 "$@"; then echo yes; else echo no; fi
    printf 'cxx23='; if probe c++ c++23 "$@"; then echo yes; else echo no; fi
    printf 'fno-pie='; if probe c++ c++23 "$@" -fno-pie; then echo yes; else echo no; fi
    printf 'mcmodel-medany='; if probe c++ c++23 "$@" -mcmodel=medany; then echo yes; else echo no; fi
} > "$tmp"
mv -f "$tmp" "$output"

grep -q '^c23=yes$' "$output"
grep -q '^cxx23=yes$' "$output"
grep -q '^fno-pie=yes$' "$output"
grep -q '^mcmodel-medany=yes$' "$output"
