#!/bin/sh
# SPDX-License-Identifier: GPL-2.0-or-later

set -eu
output=$1
assembly=$2
sed_script=$3
source=$4
tmp="$output.tmp.$$"
{
    echo '/* AUTO-GENERATED — DO NOT EDIT */'
    echo "/* Generated from $source */"
    echo '#ifndef _LUME_GENERATED_ASM_OFFSETS_H'
    echo '#define _LUME_GENERATED_ASM_OFFSETS_H'
    echo
    sed -n -f "$sed_script" "$assembly"
    echo
    echo '#endif /* _LUME_GENERATED_ASM_OFFSETS_H */'
} > "$tmp"
if [ -e "$output" ] && cmp -s "$tmp" "$output"; then
    rm -f "$tmp"
else
    mv -f "$tmp" "$output"
fi

