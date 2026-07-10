#!/bin/sh
# SPDX-License-Identifier: GPL-2.0-or-later

set -eu
output=$1
size_tool=$2
shift 2
"$@"
"$size_tool" "$output"

