#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-or-later

import json
import pathlib
import sys

source = pathlib.Path(sys.argv[1])
output = pathlib.Path(sys.argv[2])
directory = pathlib.Path.cwd()
entries = []
for line in source.read_text().splitlines():
    file_name, object_name, command = line.split("\t", 2)
    entries.append(
        {
            "directory": str(directory),
            "file": file_name,
            "output": object_name,
            "command": command,
        }
    )
output.parent.mkdir(parents=True, exist_ok=True)
temporary = output.with_suffix(output.suffix + ".tmp")
temporary.write_text(json.dumps(entries, indent=2) + "\n")
temporary.replace(output)

