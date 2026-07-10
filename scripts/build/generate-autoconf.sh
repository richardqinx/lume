#!/bin/sh
# SPDX-License-Identifier: GPL-2.0-or-later

set -eu
output=$1
shift
tmp="$output.tmp.$$"
mkdir -p "$(dirname "$output")"
{
    echo '/* AUTO-GENERATED — DO NOT EDIT */'
    echo '#pragma once'
    while [ "$#" -gt 0 ]; do
        name=$1
        value=$2
        kind=$3
        shift 3
        if [ "$kind" = bool ]; then
            [ "$value" = y ] && echo "#define $name 1"
        else
            echo "#define $name $value"
        fi
    done
} > "$tmp"
if [ -e "$output" ] && cmp -s "$tmp" "$output"; then
    rm -f "$tmp"
else
    mv -f "$tmp" "$output"
fi

