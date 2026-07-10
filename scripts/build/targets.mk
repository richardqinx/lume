# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026 Richard Qin

# Declarative target registry for the LumeOS build.
#
# Build.mk files populate target.<name>.* and append the name to targets.  A
# target name is metadata, not a Make rule, so names may contain '/' and ':'.

target-kinds := \
    interface-library header-library object-library source-set \
    static-library whole-archive host-library phys-library host-tool generated \
    binary-blob kernel-test host-test product
targets :=
generated-actions := autoconf asm-offsets linker-script initramfs

empty :=
space := $(empty) $(empty)
comma := ,

# Convert a logical target/source name into a path-safe component.
target-key = $(subst :,_,$(subst /,_,$(1)))

# Recursively collect a target and all of its dependencies. Dependency cycles
# are rejected separately before this is evaluated for build roots.
target-deps = $(sort $(target.$(1).deps) $(target.$(1).public-deps) \
    $(target.$(1).private-deps) $(target.$(1).interface-deps) \
    $(target.$(1).link-deps) $(target.$(1).tool-deps) \
    $(target.$(1).generated-deps) $(target.$(1).runtime-deps) \
    $(target.$(1).order-only-deps))
target-closure = $(strip \
    $(if $(filter $(1),$(2)),$(error target dependency cycle: $(2) -> $(1))) \
    $(1) $(foreach dep,$(call target-deps,$(1)),$(call target-closure,$(dep),$(2) $(1))))
target-link-deps = $(sort $(target.$(1).deps) $(target.$(1).public-deps) \
    $(target.$(1).private-deps) $(target.$(1).interface-deps) \
    $(target.$(1).link-deps))
target-link-order = $(strip $(1) $(foreach dep,$(call target-link-deps,$(1)),\
    $(call target-link-order,$(dep))))
unique-words = $(if $(strip $(1)),$(firstword $(1)) \
    $(call unique-words,$(filter-out $(firstword $(1)),$(1))))

duplicate-words = $(sort $(foreach word,$(1),\
    $(if $(word 2,$(filter $(word),$(1))),$(word))))
all-target-sources = $(foreach target,$(targets),$(target.$(target).sources))
duplicate-target-sources = $(call duplicate-words,$(all-target-sources))

define validate-target
$(if $(filter $(target.$(1).kind),$(target-kinds)),,$(error target '$(1)' has invalid kind '$(target.$(1).kind)'))
$(if $(filter header-library interface-library product generated binary-blob,$(target.$(1).kind)),$(if $(strip $(target.$(1).sources)),$(error target '$(1)' of kind $(target.$(1).kind) declares sources),),)
$(if $(filter host-tool,$(target.$(1).kind)),$(if $(word 2,$(target.$(1).sources)),$(error host-tool '$(1)' currently requires exactly one source),),)
$(foreach src,$(target.$(1).sources),$(if $(wildcard $(src)),,$(error target '$(1)' references missing source '$(src)')))
$(foreach dep,$(call target-deps,$(1)),$(if $(filter $(dep),$(targets)),,$(error target '$(1)' references unknown dependency '$(dep)')))
$(foreach dep,$(call target-deps,$(1)),$(if $(strip $(target.$(dep).visibility)),\
    $(if $(filter all $(1),$(target.$(dep).visibility)),,\
    $(error target '$(1)' cannot depend on '$(dep)': visibility is '$(target.$(dep).visibility)')),))
$(if $(filter generated,$(target.$(1).kind)),$(if $(strip $(target.$(1).outputs)),,$(error generated target '$(1)' has no outputs)),)
$(if $(filter generated,$(target.$(1).kind)),$(if $(filter $(target.$(1).action),$(generated-actions)),,$(error generated target '$(1)' has invalid action '$(target.$(1).action)')),)
endef

define validate-targets
$(if $(strip $(targets)),,$(error no build targets were registered))
$(if $(filter-out $(words $(sort $(targets))),$(words $(targets))),$(error duplicate build target name),)
$(foreach target,$(targets),$(call validate-target,$(target)))
endef

# Usage requirements are deliberately separate from link inputs. Public
# include paths and defines propagate through deps; private values apply only
# while compiling the target itself.
target-public-closure = $(sort $(1) $(foreach dep,$(target.$(1).public-deps) \
    $(target.$(1).deps),$(call target-public-closure,$(dep))))
target-public-includes = $(sort $(foreach target,$(call target-public-closure,$(1)),$(target.$(target).public-includes)))
target-public-after-includes = $(sort $(foreach target,$(call target-public-closure,$(1)),$(target.$(target).public-after-includes)))
target-public-defines = $(sort $(foreach target,$(call target-public-closure,$(1)),$(target.$(target).public-defines)))

target-usage-roots = $(sort $(1) $(target.$(1).deps) $(target.$(1).public-deps) \
    $(target.$(1).private-deps) $(target.$(1).interface-deps))
target-compile-includes = $(sort $(target.$(1).private-includes) \
    $(foreach root,$(call target-usage-roots,$(1)),$(call target-public-includes,$(root))))
target-compile-after-includes = $(sort $(target.$(1).private-after-includes) \
    $(foreach root,$(call target-usage-roots,$(1)),$(call target-public-after-includes,$(root))))
target-compile-defines = $(sort $(target.$(1).private-defines) \
    $(foreach root,$(call target-usage-roots,$(1)),$(call target-public-defines,$(root))))
