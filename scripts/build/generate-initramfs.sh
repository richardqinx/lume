#!/bin/sh
# SPDX-License-Identifier: GPL-2.0-or-later

set -eu
generator=$1
wrapper=$2
output=$3
uid=$4
gid=$5
source=$6
GEN_INIT_CPIO=$generator "$wrapper" -o "$output" -u "$uid" -g "$gid" "$source"

