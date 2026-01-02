# Dev log
## **3.Device Model & HAL:**
* Interrupt Controller: PLIC:

    * Implement the PLIC (Platform-Level Interrupt Controller) driver.

    * Set the PLIC priority threshold and enable bits during the start() phase.

    * Dispatch Cause 9 (External Interrupt) in kerneltrap/usertrap.

* Character Device: Interrupt-Driven Console:

    * Implement a Ring Buffer. uart_putc returns immediately after writing to the buffer.

    * UART transmit interrupt: triggers when the serial port is idle, the ISR takes data from the Ring Buffer and writes it to the register.

    * UART receive interrupt: triggers when a key is pressed, the ISR reads the character and wakes up the process waiting to read.

* Block Device: VirtIO-Blk:

    * Implement a block device driver for the PCI or MMIO transport layer according to the VirtIO 2.0 standard.

    * DMA: Use the Buddy System to allocate contiguous memory as the descriptor table for the Virtqueue.