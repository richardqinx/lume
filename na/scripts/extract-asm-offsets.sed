# SPDX-License-Identifier: GPL-2.0-or-later
# Extract `->SYM val COMMENT` markers emitted by inline asm in
# asm-offsets.c into proper `#define SYM val /* COMMENT */` lines.
# 1:1 with Linux scripts/Makefile.lib `sed-offsets`.
#
# Input  : assembly source produced by `gcc -S asm-offsets.c` —
#          inline asm emits lines like
#             .ascii "->KERNEL_MAP_VIRT_ADDR 0 offsetof(...)"
# Output : header fragment for include/generated/asm-offsets.h
#
# Step 1 unwraps the `.ascii "..."` directive so the actual payload
# (starting with `->`) is exposed.  Steps 2-4 then rewrite into a
# proper #define.
s:^[[:space:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:
/^->/{s:->#\(.*\):/* \1 */:;
      s:^->\([^ ]*\) [\$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:;
      s:->::;
      p;}
