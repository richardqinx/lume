#pragma once
#include "common/types.h"

// VirtIO MMIO Base Address
#define VIRTIO0 0x10001000

// MMIO Registers (Modern / Version 2)
#define VIRTIO_MMIO_MAGIC_VALUE 0x000
#define VIRTIO_MMIO_VERSION 0x004
#define VIRTIO_MMIO_DEVICE_ID 0x008
#define VIRTIO_MMIO_VENDOR_ID 0x00c
#define VIRTIO_MMIO_DEVICE_FEATURES 0x010
#define VIRTIO_MMIO_DEVICE_FEATURES_SEL 0x014
#define VIRTIO_MMIO_DRIVER_FEATURES 0x020
#define VIRTIO_MMIO_DRIVER_FEATURES_SEL 0x024
#define VIRTIO_MMIO_QUEUE_SEL 0x030
#define VIRTIO_MMIO_QUEUE_NUM_MAX 0x034
#define VIRTIO_MMIO_QUEUE_NUM 0x038
#define VIRTIO_MMIO_QUEUE_READY 0x044
#define VIRTIO_MMIO_QUEUE_NOTIFY 0x050
#define VIRTIO_MMIO_INTERRUPT_STATUS 0x060
#define VIRTIO_MMIO_INTERRUPT_ACK 0x064
#define VIRTIO_MMIO_STATUS 0x070

// 64-bit Queue Address Registers (Modern)
#define VIRTIO_MMIO_QUEUE_DESC_LOW 0x080
#define VIRTIO_MMIO_QUEUE_DESC_HIGH 0x084
#define VIRTIO_MMIO_QUEUE_DRIVER_LOW 0x090
#define VIRTIO_MMIO_QUEUE_DRIVER_HIGH 0x094
#define VIRTIO_MMIO_QUEUE_DEVICE_LOW 0x0a0
#define VIRTIO_MMIO_QUEUE_DEVICE_HIGH 0x0a4

// Status Bits
#define VIRTIO_CONFIG_S_ACKNOWLEDGE 1
#define VIRTIO_CONFIG_S_DRIVER 2
#define VIRTIO_CONFIG_S_DRIVER_OK 4
#define VIRTIO_CONFIG_S_FEATURES_OK 8

// Feature Bits
#define VIRTIO_BLK_F_RO 5
#define VIRTIO_BLK_F_SCSI 7
#define VIRTIO_BLK_F_CONFIG_WCE 11
#define VIRTIO_BLK_F_MQ 12
#define VIRTIO_F_ANY_LAYOUT 27
#define VIRTIO_RING_F_INDIRECT_DESC 28
#define VIRTIO_RING_F_EVENT_IDX 29
#define VIRTIO_F_VERSION_1 32

// Descriptor Flags
#define VRING_DESC_F_NEXT 1
#define VRING_DESC_F_WRITE 2

#define NUM_DESCS 8

#define VIRTIO_BLK_T_IN 0
#define VIRTIO_BLK_T_OUT 1

// Device Configuration Layout (Offset 0x100)
#define VIRTIO_MMIO_CONFIG 0x100

namespace VirtIO
{
    struct VRingDesc
    {
        uint64 addr;
        uint32 len;
        uint16 flags;
        uint16 next;
    };

    struct VRingAvail
    {
        uint16 flags;
        uint16 idx;
        uint16 ring[NUM_DESCS];
    };

    struct VRingUsedElem
    {
        uint32 id;
        uint32 len;
    };

    struct VRingUsed
    {
        uint16 flags;
        uint16 idx;
        struct VRingUsedElem ring[NUM_DESCS];
    };

    struct __attribute__((packed)) BlockRequest
    {
        uint32 type; // 0=Read, 1=Write
        uint32 reserved;
        uint64 sector;
    };

    void init();
    void intr();
    void rw(int write, uint64 blockno, char *buf);
    void test_rw();
}