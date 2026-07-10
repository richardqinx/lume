targets += drivers/base drivers/tty drivers/core
target.drivers/base.kind := source-set
target.drivers/base.sources := \
    drivers/base/bus.cc drivers/base/core.cc drivers/base/driver.cc \
    drivers/base/platform.cc

target.drivers/tty.kind := source-set
target.drivers/tty.sources := \
    drivers/tty/tty_core.cc drivers/tty/n_tty.cc drivers/tty/tty_uart.cc

target.drivers/core.kind := source-set
target.drivers/core.deps := drivers/base drivers/tty
target.drivers/core.sources := drivers/uart.cc drivers/console.cc
ifeq ($(ARCH),riscv)
target.drivers/core.sources += drivers/plic.cc
endif

