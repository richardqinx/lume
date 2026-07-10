#!/bin/sh
# SPDX-License-Identifier: GPL-2.0-or-later

set -eu

cmdfile=$1
output=$2
description=$3
shift 3

rebuild=false
if [ ! -e "$output" ] || [ ! -e "$cmdfile" ]; then
    rebuild=true
fi

while [ "$#" -gt 0 ] && [ "$1" != "--" ]; do
    prerequisite=$1
    shift
    if [ "$prerequisite" != FORCE ] && [ -e "$prerequisite" ] && \
       [ "$prerequisite" -nt "$output" ]; then
        rebuild=true
    fi
done

[ "$#" -gt 0 ] || { echo "run-if-changed: missing --" >&2; exit 2; }
shift

signature=$(printf '%s\0' "$@" | cksum)
old_signature=
if [ -e "$cmdfile" ]; then
    old_signature=$(cat "$cmdfile")
fi
if [ "$signature" != "$old_signature" ]; then
    rebuild=true
fi

if [ "$rebuild" = true ]; then
    printf '  %s\n' "$description"
    mkdir -p "$(dirname "$output")" "$(dirname "$cmdfile")"
    "$@"
    tmp="$cmdfile.tmp.$$"
    printf '%s\n' "$signature" > "$tmp"
    mv -f "$tmp" "$cmdfile"
fi

