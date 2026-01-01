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

UPROGS_SRC := $(SRC_DIR)/user/init.cc
UPROGS_OBJ := $(BUILD_DIR)/user/entry.o $(BUILD_DIR)/user/init.o
ULIB_OBJ   := $(BUILD_DIR)/user/usys.o
USER_LD    := $(SRC_DIR)/user/user.ld
INITCODE_BIN := $(BUILD_DIR)/user/initcode

SRCS_S   := $(shell find $(SRC_DIR) -name "*.S" -not -path "$(SRC_DIR)/user/*")
SRCS_CXX := $(shell find $(SRC_DIR) -name "*.cc" -not -path "$(SRC_DIR)/user/*")
OBJS     := $(SRCS_S:%.S=$(BUILD_DIR)/%.o) $(SRCS_CXX:%.cc=$(BUILD_DIR)/%.o)

TARGET   := $(BUILD_DIR)/kernel.elf

QEMUOPTS = -drive file=fs.img,if=none,format=raw,id=x0
QEMUOPTS += -device virtio-blk-device,drive=x0 -global virtio-mmio.force-legacy=false

.PHONY: all clean run debug

all: $(TARGET)

$(BUILD_DIR)/user/%.o: $(SRC_DIR)/user/%.cc
	@mkdir -p $(dir $@)
	@echo "  U_CXX   $<"
	@$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/user/%.o: $(SRC_DIR)/user/%.S
	@mkdir -p $(dir $@)
	@echo "  U_AS    $<"
	@$(CC) $(CFLAGS) -c $< -o $@

$(INITCODE_BIN): $(UPROGS_OBJ) $(ULIB_OBJ) $(USER_LD)
	@echo "  U_LD    $@"
	@$(LD) -T $(USER_LD) -o $@.out $(UPROGS_OBJ) $(ULIB_OBJ)
	@$(OBJCOPY) -S -O binary $@.out $@
	@$(OBJDUMP) -S $@.out > $@.asm

$(TARGET): $(OBJS) $(LINKER_SCRIPT)
	@echo "  LD      $@"
	@$(LD) -T $(LINKER_SCRIPT) -o $@ $(OBJS)

$(BUILD_DIR)/src/kernel/initcode.o: $(SRC_DIR)/kernel/initcode.S $(INITCODE_BIN)
	@mkdir -p $(dir $@)
	@echo "  AS_INC  $<"
	@$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: %.S
	@mkdir -p $(dir $@)
	@echo "  AS      $<"
	@$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: %.cc
	@mkdir -p $(dir $@)
	@echo "  CXX     $<"
	@$(CXX) $(CXXFLAGS) -c $< -o $@

fs.img:
	@echo "  IMG     Generating fs.img (1MB)"
	@dd if=/dev/zero of=fs.img bs=1M count=1 2>/dev/null

run: $(TARGET)	fs.img
	@echo "  QEMU    Running..."
	@qemu-system-riscv64 -machine virt -nographic \
		-kernel $(TARGET) -m 128M $(QEMUOPTS)

debug: $(TARGET) fs.img
	@echo "  QEMU (DEBUG)  Waiting for GDB..."
	@qemu-system-riscv64 -machine virt -nographic \
		-kernel $(TARGET) -m 128M -s -S $(QEMUOPTS)

clean:
	rm -rf $(BUILD_DIR) fs.img
