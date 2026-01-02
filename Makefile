TOOLCHAIN_PREFIX := riscv64-linux-gnu-
CC      := $(TOOLCHAIN_PREFIX)gcc
CXX     := $(TOOLCHAIN_PREFIX)g++
LD      := $(TOOLCHAIN_PREFIX)ld
OBJCOPY := $(TOOLCHAIN_PREFIX)objcopy
OBJDUMP := $(TOOLCHAIN_PREFIX)objdump

BUILD_DIR := build
SRC_DIR   := src

CFLAGS   := -Wall -Wextra -O2 -g -ffreestanding -nostdlib -mcmodel=medany -Iinclude
CXXFLAGS := $(CFLAGS) -fno-exceptions -fno-rtti -fno-use-cxa-atexit
LINKER_SCRIPT := linker.ld

USER_LD    := $(SRC_DIR)/user/user.ld
ULIB_OBJS := $(BUILD_DIR)/user/entry.o \
             $(BUILD_DIR)/user/usys.o \
             $(BUILD_DIR)/ulib/stdio.o \
             $(BUILD_DIR)/ulib/stdlib.o \
             $(BUILD_DIR)/ulib/string.o \
             $(BUILD_DIR)/ulib/cxx.o \
             $(BUILD_DIR)/ulib/iostream.o

INITCODE_BIN := $(BUILD_DIR)/user/initcode

SH_SRC   := $(SRC_DIR)/user/sh.cc
SH_OBJ   := $(BUILD_DIR)/user/sh.o
SH_BIN   := $(BUILD_DIR)/user/sh

INIT_SRC := $(SRC_DIR)/user/init.cc
INIT_OBJ := $(BUILD_DIR)/user/init.o
INIT_BIN := $(BUILD_DIR)/user/init

SRCS_S   := $(shell find $(SRC_DIR) -name "*.S" -not -path "$(SRC_DIR)/user/*" -not -path "$(SRC_DIR)/ulib/*")
SRCS_CXX := $(shell find $(SRC_DIR) -name "*.cc" -not -path "$(SRC_DIR)/user/*" -not -path "$(SRC_DIR)/ulib/*")

OBJS     := $(SRCS_S:%.S=$(BUILD_DIR)/%.o) $(SRCS_CXX:%.cc=$(BUILD_DIR)/%.o)

TARGET   := $(BUILD_DIR)/kernel.elf

QEMUOPTS = -drive file=fs.img,if=none,format=raw,id=x0
QEMUOPTS += -device virtio-blk-device,drive=x0 -global virtio-mmio.force-legacy=false

.PHONY: all clean run debug

all: $(TARGET) fs.img

$(BUILD_DIR)/ulib/%.o: $(SRC_DIR)/ulib/%.c
	@mkdir -p $(dir $@)
	@echo "  ULIB_C  $<"
	@$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/ulib/%.o: $(SRC_DIR)/ulib/%.cc
	@mkdir -p $(dir $@)
	@echo "  ULIB_CC $<"
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/ulib/%.o: $(SRC_DIR)/ulib/%.cpp
	@mkdir -p $(dir $@)
	@echo "  ULIB_CPP $<"
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/user/%.o: $(SRC_DIR)/user/%.cc
	@mkdir -p $(dir $@)
	@echo "  USER_CC $<"
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/user/%.o: $(SRC_DIR)/user/%.S
	@mkdir -p $(dir $@)
	@echo "  USER_AS $<"
	@$(CC) $(CFLAGS) -c $< -o $@


$(INITCODE_BIN): $(BUILD_DIR)/user/init.o $(ULIB_OBJS) $(USER_LD)
	@echo "  U_LD    $@"
	@$(LD) -T $(USER_LD) -o $@.out $(BUILD_DIR)/user/init.o $(ULIB_OBJS)
	@$(OBJCOPY) -S -O binary $@.out $@
	@$(OBJDUMP) -S $@.out > $@.asm

$(SH_BIN): $(SH_OBJ) $(ULIB_OBJS) $(USER_LD)
	@echo "  SH_LD   $@"
	@$(LD) -T $(USER_LD) -o $@ $(SH_OBJ) $(ULIB_OBJS)
	@$(OBJDUMP) -S $@ > $@.asm

$(TARGET): $(OBJS) $(LINKER_SCRIPT)
	@echo "  K_LD    $@"
	@$(LD) -T $(LINKER_SCRIPT) -o $@ $(OBJS)

$(BUILD_DIR)/src/kernel/initcode.o: $(SRC_DIR)/kernel/initcode.S $(INITCODE_BIN)
	@mkdir -p $(dir $@)
	@echo "  AS_INC  $<"
	@$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: %.S
	@mkdir -p $(dir $@)
	@echo "  K_AS    $<"
	@$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: %.cc
	@mkdir -p $(dir $@)
	@echo "  K_CXX   $<"
	@$(CXX) $(CXXFLAGS) -c $< -o $@

fs.img: $(SH_BIN)
	@echo "  IMG     Generating fs.img (FAT32)"
	@dd if=/dev/zero of=fs.img bs=1M count=32 2>/dev/null
	@mkfs.vfat -F 32 fs.img >/dev/null
	@mcopy -i fs.img $(SH_BIN) ::/sh

run: $(TARGET) fs.img
	@echo "  QEMU    Running..."
	@qemu-system-riscv64 -machine virt -nographic \
		-kernel $(TARGET) -m 128M $(QEMUOPTS)

debug: $(TARGET) fs.img
	@echo "  QEMU (DEBUG)  Waiting for GDB..."
	@qemu-system-riscv64 -machine virt -nographic \
		-kernel $(TARGET) -m 128M -s -S $(QEMUOPTS)

clean:
	rm -rf $(BUILD_DIR) fs.img
