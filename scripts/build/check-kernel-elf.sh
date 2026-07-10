#!/bin/sh
# SPDX-License-Identifier: GPL-2.0-or-later

set -eu
elf=$1
readelf=$2
nm=$3
arch=$4

case "$arch" in
    riscv) expected_machine='RISC-V' ;;
    aarch64) expected_machine='AArch64' ;;
    x86_64) expected_machine='Advanced Micro Devices X86-64' ;;
    *) echo "ELF check: unsupported architecture: $arch" >&2; exit 2 ;;
esac

machine=$($readelf -h "$elf" | sed -n 's/^[[:space:]]*Machine:[[:space:]]*//p')
[ "$machine" = "$expected_machine" ] || {
    echo "ELF check: expected machine '$expected_machine', got '$machine'" >&2
    exit 1
}

entry=$($readelf -h "$elf" | sed -n 's/^[[:space:]]*Entry point address:[[:space:]]*//p')
[ -n "$entry" ] && [ "$entry" != 0x0 ] || {
    echo "ELF check: kernel has no entry point" >&2
    exit 1
}

undefined=$($nm -u "$elf" || true)
[ -z "$undefined" ] || {
    echo "ELF check: undefined symbols:" >&2
    printf '%s\n' "$undefined" >&2
    exit 1
}

if $readelf -W -l "$elf" | awk '$1 == "LOAD" && $0 ~ /W/ && $0 ~ /E/ { found=1 } END { exit !found }'; then
    echo "ELF check: writable and executable LOAD segment" >&2
    exit 1
fi

$readelf -S "$elf" | grep -q '[.]rela[.]dyn' || {
    echo "ELF check: missing relocation section .rela.dyn" >&2
    exit 1
}

echo "Kernel ELF OK: $machine, entry $entry"

