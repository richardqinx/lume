#!/bin/sh
# SPDX-License-Identifier: GPL-2.0-or-later

set -eu
archive=$1
ar=$2
shift 2
rm -f "$archive"
"$ar" rcs "$archive" "$@"

