TOOLCHAIN_PREFIX := riscv64-linux-gnu-
CC      := $(TOOLCHAIN_PREFIX)gcc
CXX     := $(TOOLCHAIN_PREFIX)g++
LD      := $(TOOLCHAIN_PREFIX)ld
OBJCOPY := $(TOOLCHAIN_PREFIX)objcopy

BUILD_DIR := build
SRC_DIR   := src

CFLAGS   := -Wall -Wextra -O2 -ffreestanding -nostdlib -mcmodel=medany -Iinclude
CXXFLAGS := $(CFLAGS) -fno-exceptions -fno-rtti -fno-use-cxa-atexit

LINKER_SCRIPT := link.ld

SRCS_S   := $(shell find $(SRC_DIR) -name "*.S")
SRCS_CXX := $(shell find $(SRC_DIR) -name "*.cc")
OBJS     := $(SRCS_S:%.S=$(BUILD_DIR)/%.o) $(SRCS_CXX:%.cc=$(BUILD_DIR)/%.o)

TARGET   := $(BUILD_DIR)/kernel.elf

.PHONY: all clean run

all: $(TARGET)

$(TARGET): $(OBJS) $(LINKER_SCRIPT)
	@echo "  LD      $@"
	@$(LD) -T $(LINKER_SCRIPT) -o $@ $(OBJS)

$(BUILD_DIR)/%.o: %.S
	@mkdir -p $(dir $@)
	@echo "  AS      $<"
	@$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: %.cc
	@mkdir -p $(dir $@)
	@echo "  CXX     $<"
	@$(CXX) $(CXXFLAGS) -c $< -o $@

run: $(TARGET)
	@echo "  QEMU    Running..."
	@qemu-system-riscv64 -machine virt -nographic \
		-kernel $(TARGET) -m 128M

clean:
	rm -rf $(BUILD_DIR)