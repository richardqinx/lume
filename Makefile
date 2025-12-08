TOOLCHAIN := riscv64-linux-gnu
CC        := $(TOOLCHAIN)-gcc
CXX       := $(TOOLCHAIN)-g++
LD        := $(TOOLCHAIN)-ld
OBJCOPY   := $(TOOLCHAIN)-objcopy

TARGET_ELF := build/kernel.elf
TARGET_BIN := build/kernel.bin

ARCH_FLAGS := -march=rv64gc -mabi=lp64 -mcmodel=medany
CFLAGS     := -Wall -Wextra -O2 -ffreestanding -nostdlib -Iinclude $(ARCH_FLAGS)
CXXFLAGS   := $(CFLAGS) -fno-exceptions -fno-rtti -fno-use-cxa-atexit

SRC_DIRS  := src
SRCS_ASM  := $(shell find $(SRC_DIRS) -name "*.S")
SRCS_CXX  := $(shell find $(SRC_DIRS) -name "*.cc")

OBJS      := $(SRCS_ASM:%.S=build/%.o) $(SRCS_CXX:%.cc=build/%.o)

DEPS      := $(OBJS:.o=.d)


LINKER_SCRIPT := linker.ld

QEMU      := qemu-system-riscv64
QEMU_FLAGS := -machine virt -m 128M -nographic -bios none -kernel $(TARGET_ELF)


.PHONY: all clean run debug directories

all: directories $(TARGET_ELF)

$(TARGET_ELF): $(OBJS) $(LINKER_SCRIPT)
	@echo "Linking $@"
	@$(LD) -T $(LINKER_SCRIPT) -o $@ $(OBJS)

build/%.o: %.S
	@mkdir -p $(dir $@)
	@echo "Compiling ASM $<"
	@$(CC) $(CFLAGS) -MMD -c $< -o $@

build/%.o: %.cc
	@mkdir -p $(dir $@)
	@echo "Compiling C++ $<"
	@$(CXX) $(CXXFLAGS) -MMD -c $< -o $@

directories:
	@mkdir -p build

run: all
	@echo "Starting QEMU..."
	$(QEMU) $(QEMU_FLAGS)

debug: all
	@echo "Starting QEMU in debug mode (connect with gdb-multiarch)..."
	$(QEMU) $(QEMU_FLAGS) -S -s

clean:
	@rm -rf build

-include $(DEPS)