
build/kernel.elf:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <_start>:
.section .text.entry
.global _start

_start:
    mv tp, a0
    80200000:	822a                	mv	tp,a0

    la t0, stack_base
    80200002:	00015297          	auipc	t0,0x15
    80200006:	a662b283          	ld	t0,-1434(t0) # 80214a68 <_GLOBAL_OFFSET_TABLE_+0x8>
    li t1, 4096
    8020000a:	6305                	lui	t1,0x1
    addi t2, a0, 1
    8020000c:	00150393          	addi	t2,a0,1
    mul t1, t1, t2
    80200010:	02730333          	mul	t1,t1,t2
    add sp, t0, t1
    80200014:	00628133          	add	sp,t0,t1

    bnez a0, .L_jump_main
    80200018:	e50d                	bnez	a0,80200042 <_start+0x42>

    la t0, sbss
    8020001a:	00015297          	auipc	t0,0x15
    8020001e:	a862b283          	ld	t0,-1402(t0) # 80214aa0 <_GLOBAL_OFFSET_TABLE_+0x40>
    la t1, ebss
    80200022:	00015317          	auipc	t1,0x15
    80200026:	aa633303          	ld	t1,-1370(t1) # 80214ac8 <_GLOBAL_OFFSET_TABLE_+0x68>
.L_clear_bss:
    bge t0, t1, .L_save_dtb
    8020002a:	0062d663          	bge	t0,t1,80200036 <_start+0x36>
    sd zero, 0(t0)
    8020002e:	0002b023          	sd	zero,0(t0)
    addi t0, t0, 8
    80200032:	02a1                	addi	t0,t0,8
    j .L_clear_bss
    80200034:	bfdd                	j	8020002a <_start+0x2a>

.L_save_dtb:
    la t0, g_dtb_addr
    80200036:	00015297          	auipc	t0,0x15
    8020003a:	a9a2b283          	ld	t0,-1382(t0) # 80214ad0 <_GLOBAL_OFFSET_TABLE_+0x70>
    sd a1, 0(t0)
    8020003e:	00b2b023          	sd	a1,0(t0)

.L_jump_main:
    call kernel_main
    80200042:	0dd050ef          	jal	8020591e <kernel_main>

.L_park:
    wfi
    80200046:	10500073          	wfi
    j .L_park
    8020004a:	bff5                	j	80200046 <_start+0x46>

000000008020004c <swtch>:
.global swtch

swtch:
    sd ra, 0(a0)
    8020004c:	00153023          	sd	ra,0(a0)
    sd sp, 8(a0)
    80200050:	00253423          	sd	sp,8(a0)
    sd s0, 16(a0)
    80200054:	e900                	sd	s0,16(a0)
    sd s1, 24(a0)
    80200056:	ed04                	sd	s1,24(a0)
    sd s2, 32(a0)
    80200058:	03253023          	sd	s2,32(a0)
    sd s3, 40(a0)
    8020005c:	03353423          	sd	s3,40(a0)
    sd s4, 48(a0)
    80200060:	03453823          	sd	s4,48(a0)
    sd s5, 56(a0)
    80200064:	03553c23          	sd	s5,56(a0)
    sd s6, 64(a0)
    80200068:	05653023          	sd	s6,64(a0)
    sd s7, 72(a0)
    8020006c:	05753423          	sd	s7,72(a0)
    sd s8, 80(a0)
    80200070:	05853823          	sd	s8,80(a0)
    sd s9, 88(a0)
    80200074:	05953c23          	sd	s9,88(a0)
    sd s10, 96(a0)
    80200078:	07a53023          	sd	s10,96(a0)
    sd s11, 104(a0)
    8020007c:	07b53423          	sd	s11,104(a0)

    ld ra, 0(a1)
    80200080:	0005b083          	ld	ra,0(a1)
    ld sp, 8(a1)
    80200084:	0085b103          	ld	sp,8(a1)
    ld s0, 16(a1)
    80200088:	6980                	ld	s0,16(a1)
    ld s1, 24(a1)
    8020008a:	6d84                	ld	s1,24(a1)
    ld s2, 32(a1)
    8020008c:	0205b903          	ld	s2,32(a1)
    ld s3, 40(a1)
    80200090:	0285b983          	ld	s3,40(a1)
    ld s4, 48(a1)
    80200094:	0305ba03          	ld	s4,48(a1)
    ld s5, 56(a1)
    80200098:	0385ba83          	ld	s5,56(a1)
    ld s6, 64(a1)
    8020009c:	0405bb03          	ld	s6,64(a1)
    ld s7, 72(a1)
    802000a0:	0485bb83          	ld	s7,72(a1)
    ld s8, 80(a1)
    802000a4:	0505bc03          	ld	s8,80(a1)
    ld s9, 88(a1)
    802000a8:	0585bc83          	ld	s9,88(a1)
    ld s10, 96(a1)
    802000ac:	0605bd03          	ld	s10,96(a1)
    ld s11, 104(a1)
    802000b0:	0685bd83          	ld	s11,104(a1)

    ret
    802000b4:	8082                	ret
	...

0000000080201000 <kernelvec>:
.global uservec
.global userret
.align 12

kernelvec:
    addi sp, sp, -288
    80201000:	712d                	addi	sp,sp,-288
    
    sd ra, 40(sp)
    80201002:	f406                	sd	ra,40(sp)
    sd sp, 48(sp)
    80201004:	f80a                	sd	sp,48(sp)
    sd gp, 56(sp)
    80201006:	fc0e                	sd	gp,56(sp)
    sd tp, 64(sp)
    80201008:	e092                	sd	tp,64(sp)
    sd t0, 72(sp)
    8020100a:	e496                	sd	t0,72(sp)
    sd t1, 80(sp)
    8020100c:	e89a                	sd	t1,80(sp)
    sd t2, 88(sp)
    8020100e:	ec9e                	sd	t2,88(sp)
    sd s0, 96(sp)
    80201010:	f0a2                	sd	s0,96(sp)
    sd s1, 104(sp)
    80201012:	f4a6                	sd	s1,104(sp)
    sd a0, 112(sp)
    80201014:	f8aa                	sd	a0,112(sp)
    sd a1, 120(sp)
    80201016:	fcae                	sd	a1,120(sp)
    sd a2, 128(sp)
    80201018:	e132                	sd	a2,128(sp)
    sd a3, 136(sp)
    8020101a:	e536                	sd	a3,136(sp)
    sd a4, 144(sp)
    8020101c:	e93a                	sd	a4,144(sp)
    sd a5, 152(sp)
    8020101e:	ed3e                	sd	a5,152(sp)
    sd a6, 160(sp)
    80201020:	f142                	sd	a6,160(sp)
    sd a7, 168(sp)
    80201022:	f546                	sd	a7,168(sp)
    sd s2, 176(sp)
    80201024:	f94a                	sd	s2,176(sp)
    sd s3, 184(sp)
    80201026:	fd4e                	sd	s3,184(sp)
    sd s4, 192(sp)
    80201028:	e1d2                	sd	s4,192(sp)
    sd s5, 200(sp)
    8020102a:	e5d6                	sd	s5,200(sp)
    sd s6, 208(sp)
    8020102c:	e9da                	sd	s6,208(sp)
    sd s7, 216(sp)
    8020102e:	edde                	sd	s7,216(sp)
    sd s8, 224(sp)
    80201030:	f1e2                	sd	s8,224(sp)
    sd s9, 232(sp)
    80201032:	f5e6                	sd	s9,232(sp)
    sd s10, 240(sp)
    80201034:	f9ea                	sd	s10,240(sp)
    sd s11, 248(sp)
    80201036:	fdee                	sd	s11,248(sp)
    sd t3, 256(sp)
    80201038:	e272                	sd	t3,256(sp)
    sd t4, 264(sp)
    8020103a:	e676                	sd	t4,264(sp)
    sd t5, 272(sp)
    8020103c:	ea7a                	sd	t5,272(sp)
    sd t6, 280(sp)
    8020103e:	ee7e                	sd	t6,280(sp)
    
    csrr t0, sepc
    80201040:	141022f3          	csrr	t0,sepc
    csrr t1, sstatus
    80201044:	10002373          	csrr	t1,sstatus
    sd t0, 24(sp)   # Trapframe.epc
    80201048:	ec16                	sd	t0,24(sp)
    sd t1, 32(sp)   # Trapframe.kernel_hartid
    8020104a:	f01a                	sd	t1,32(sp)
    
    mv a0, sp
    8020104c:	850a                	mv	a0,sp
    call kerneltrap
    8020104e:	1cf070ef          	jal	80208a1c <kerneltrap>
    
    ld t0, 24(sp)
    80201052:	62e2                	ld	t0,24(sp)
    ld t1, 32(sp)
    80201054:	7302                	ld	t1,32(sp)
    csrw sepc, t0
    80201056:	14129073          	csrw	sepc,t0
    csrw sstatus, t1
    8020105a:	10031073          	csrw	sstatus,t1

    ld ra, 40(sp)
    8020105e:	70a2                	ld	ra,40(sp)
    ld gp, 56(sp)
    80201060:	71e2                	ld	gp,56(sp)
    ld tp, 64(sp)
    80201062:	6206                	ld	tp,64(sp)
    ld t0, 72(sp)
    80201064:	62a6                	ld	t0,72(sp)
    ld t1, 80(sp)
    80201066:	6346                	ld	t1,80(sp)
    ld t2, 88(sp)
    80201068:	63e6                	ld	t2,88(sp)
    ld s0, 96(sp)
    8020106a:	7406                	ld	s0,96(sp)
    ld s1, 104(sp)
    8020106c:	74a6                	ld	s1,104(sp)
    ld a0, 112(sp)
    8020106e:	7546                	ld	a0,112(sp)
    ld a1, 120(sp)
    80201070:	75e6                	ld	a1,120(sp)
    ld a2, 128(sp)
    80201072:	660a                	ld	a2,128(sp)
    ld a3, 136(sp)
    80201074:	66aa                	ld	a3,136(sp)
    ld a4, 144(sp)
    80201076:	674a                	ld	a4,144(sp)
    ld a5, 152(sp)
    80201078:	67ea                	ld	a5,152(sp)
    ld a6, 160(sp)
    8020107a:	780a                	ld	a6,160(sp)
    ld a7, 168(sp)
    8020107c:	78aa                	ld	a7,168(sp)
    ld s2, 176(sp)
    8020107e:	794a                	ld	s2,176(sp)
    ld s3, 184(sp)
    80201080:	79ea                	ld	s3,184(sp)
    ld s4, 192(sp)
    80201082:	6a0e                	ld	s4,192(sp)
    ld s5, 200(sp)
    80201084:	6aae                	ld	s5,200(sp)
    ld s6, 208(sp)
    80201086:	6b4e                	ld	s6,208(sp)
    ld s7, 216(sp)
    80201088:	6bee                	ld	s7,216(sp)
    ld s8, 224(sp)
    8020108a:	7c0e                	ld	s8,224(sp)
    ld s9, 232(sp)
    8020108c:	7cae                	ld	s9,232(sp)
    ld s10, 240(sp)
    8020108e:	7d4e                	ld	s10,240(sp)
    ld s11, 248(sp)
    80201090:	7dee                	ld	s11,248(sp)
    ld t3, 256(sp)
    80201092:	6e12                	ld	t3,256(sp)
    ld t4, 264(sp)
    80201094:	6eb2                	ld	t4,264(sp)
    ld t5, 272(sp)
    80201096:	6f52                	ld	t5,272(sp)
    ld t6, 280(sp)
    80201098:	6ff2                	ld	t6,280(sp)
    
    addi sp, sp, 288
    8020109a:	6115                	addi	sp,sp,288
    8020109c:	10200073          	sret
	...

0000000080202000 <trampoline>:
.align 12
trampoline:
.align 4
uservec:    
    
    csrrw a0, sscratch, a0
    80202000:	14051573          	csrrw	a0,sscratch,a0

    sd ra, 40(a0)
    80202004:	02153423          	sd	ra,40(a0)
    sd sp, 48(a0)
    80202008:	02253823          	sd	sp,48(a0)
    sd gp, 56(a0)
    8020200c:	02353c23          	sd	gp,56(a0)
    sd tp, 64(a0)
    80202010:	04453023          	sd	tp,64(a0)
    sd t0, 72(a0)
    80202014:	04553423          	sd	t0,72(a0)
    sd t1, 80(a0)
    80202018:	04653823          	sd	t1,80(a0)
    sd t2, 88(a0)
    8020201c:	04753c23          	sd	t2,88(a0)
    sd s0, 96(a0)
    80202020:	f120                	sd	s0,96(a0)
    sd s1, 104(a0)
    80202022:	f524                	sd	s1,104(a0)
    sd a1, 120(a0)
    80202024:	fd2c                	sd	a1,120(a0)
    sd a2, 128(a0)
    80202026:	e150                	sd	a2,128(a0)
    sd a3, 136(a0)
    80202028:	e554                	sd	a3,136(a0)
    sd a4, 144(a0)
    8020202a:	e958                	sd	a4,144(a0)
    sd a5, 152(a0)
    8020202c:	ed5c                	sd	a5,152(a0)
    sd a6, 160(a0)
    8020202e:	0b053023          	sd	a6,160(a0)
    sd a7, 168(a0)
    80202032:	0b153423          	sd	a7,168(a0)
    sd s2, 176(a0)
    80202036:	0b253823          	sd	s2,176(a0)
    sd s3, 184(a0)
    8020203a:	0b353c23          	sd	s3,184(a0)
    sd s4, 192(a0)
    8020203e:	0d453023          	sd	s4,192(a0)
    sd s5, 200(a0)
    80202042:	0d553423          	sd	s5,200(a0)
    sd s6, 208(a0)
    80202046:	0d653823          	sd	s6,208(a0)
    sd s7, 216(a0)
    8020204a:	0d753c23          	sd	s7,216(a0)
    sd s8, 224(a0)
    8020204e:	0f853023          	sd	s8,224(a0)
    sd s9, 232(a0)
    80202052:	0f953423          	sd	s9,232(a0)
    sd s10, 240(a0)
    80202056:	0fa53823          	sd	s10,240(a0)
    sd s11, 248(a0)
    8020205a:	0fb53c23          	sd	s11,248(a0)
    sd t3, 256(a0)
    8020205e:	11c53023          	sd	t3,256(a0)
    sd t4, 264(a0)
    80202062:	11d53423          	sd	t4,264(a0)
    sd t5, 272(a0)
    80202066:	11e53823          	sd	t5,272(a0)
    sd t6, 280(a0)
    8020206a:	11f53c23          	sd	t6,280(a0)

    csrr t0, sscratch
    8020206e:	140022f3          	csrr	t0,sscratch
    sd t0, 112(a0)
    80202072:	06553823          	sd	t0,112(a0)

    ld sp, 8(a0)
    80202076:	00853103          	ld	sp,8(a0)
    ld tp, 32(a0)
    8020207a:	02053203          	ld	tp,32(a0)
    ld t0, 16(a0)
    8020207e:	01053283          	ld	t0,16(a0)
    ld t1, 0(a0)
    80202082:	00053303          	ld	t1,0(a0)

    csrw satp, t1
    80202086:	18031073          	csrw	satp,t1
    sfence.vma zero, zero
    8020208a:	12000073          	sfence.vma

    jr t0
    8020208e:	8282                	jr	t0

0000000080202090 <userret>:

.align 4
userret:
    
    csrw satp, a1
    80202090:	18059073          	csrw	satp,a1
    sfence.vma zero, zero
    80202094:	12000073          	sfence.vma

    csrw sscratch, a0
    80202098:	14051073          	csrw	sscratch,a0

    ld ra, 40(a0)
    8020209c:	02853083          	ld	ra,40(a0)
    ld sp, 48(a0)
    802020a0:	03053103          	ld	sp,48(a0)
    ld gp, 56(a0)
    802020a4:	03853183          	ld	gp,56(a0)
    ld tp, 64(a0)
    802020a8:	04053203          	ld	tp,64(a0)
    ld t0, 72(a0)
    802020ac:	04853283          	ld	t0,72(a0)
    ld t1, 80(a0)
    802020b0:	05053303          	ld	t1,80(a0)
    ld t2, 88(a0)
    802020b4:	05853383          	ld	t2,88(a0)
    ld s0, 96(a0)
    802020b8:	7120                	ld	s0,96(a0)
    ld s1, 104(a0)
    802020ba:	7524                	ld	s1,104(a0)
    ld a1, 120(a0)
    802020bc:	7d2c                	ld	a1,120(a0)
    ld a2, 128(a0)
    802020be:	6150                	ld	a2,128(a0)
    ld a3, 136(a0)
    802020c0:	6554                	ld	a3,136(a0)
    ld a4, 144(a0)
    802020c2:	6958                	ld	a4,144(a0)
    ld a5, 152(a0)
    802020c4:	6d5c                	ld	a5,152(a0)
    ld a6, 160(a0)
    802020c6:	0a053803          	ld	a6,160(a0)
    ld a7, 168(a0)
    802020ca:	0a853883          	ld	a7,168(a0)
    ld s2, 176(a0)
    802020ce:	0b053903          	ld	s2,176(a0)
    ld s3, 184(a0)
    802020d2:	0b853983          	ld	s3,184(a0)
    ld s4, 192(a0)
    802020d6:	0c053a03          	ld	s4,192(a0)
    ld s5, 200(a0)
    802020da:	0c853a83          	ld	s5,200(a0)
    ld s6, 208(a0)
    802020de:	0d053b03          	ld	s6,208(a0)
    ld s7, 216(a0)
    802020e2:	0d853b83          	ld	s7,216(a0)
    ld s8, 224(a0)
    802020e6:	0e053c03          	ld	s8,224(a0)
    ld s9, 232(a0)
    802020ea:	0e853c83          	ld	s9,232(a0)
    ld s10, 240(a0)
    802020ee:	0f053d03          	ld	s10,240(a0)
    ld s11, 248(a0)
    802020f2:	0f853d83          	ld	s11,248(a0)
    ld t3, 256(a0)
    802020f6:	10053e03          	ld	t3,256(a0)
    ld t4, 264(a0)
    802020fa:	10853e83          	ld	t4,264(a0)
    ld t5, 272(a0)
    802020fe:	11053f03          	ld	t5,272(a0)
    ld t6, 280(a0)
    80202102:	11853f83          	ld	t6,280(a0)
    
    ld a0, 112(a0)
    80202106:	7928                	ld	a0,112(a0)
    
    80202108:	10200073          	sret
	...

0000000080202fe6 <_ZN4Pipe5closeEb>:

    return 0;
}

void Pipe::close(bool is_writer)
{
    80202fe6:	1101                	addi	sp,sp,-32
    80202fe8:	e426                	sd	s1,8(sp)
    80202fea:	84ae                	mv	s1,a1
    80202fec:	e822                	sd	s0,16(sp)
    80202fee:	ec06                	sd	ra,24(sp)
    80202ff0:	842a                	mv	s0,a0
    lock.acquire();
    80202ff2:	38f020ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
    if (is_writer)
    80202ff6:	cc8d                	beqz	s1,80203030 <_ZN4Pipe5closeEb+0x4a>
    {
        write_open = false;
    80202ff8:	220400a3          	sb	zero,545(s0)
        ProcManager::wakeup(&nread); // Wake up the process that is currently reading
    80202ffc:	21840513          	addi	a0,s0,536
    80203000:	04a050ef          	jal	8020804a <_ZN11ProcManager6wakeupEPv>
    {
        read_open = false;
        ProcManager::wakeup(&nwrite); // Wake up the process that is writing
    }

    bool empty = !read_open && !write_open;
    80203004:	22044783          	lbu	a5,544(s0)
    lock.release();
    80203008:	8522                	mv	a0,s0
    bool empty = !read_open && !write_open;
    8020300a:	ef89                	bnez	a5,80203024 <_ZN4Pipe5closeEb+0x3e>
    8020300c:	22144783          	lbu	a5,545(s0)
    80203010:	eb91                	bnez	a5,80203024 <_ZN4Pipe5closeEb+0x3e>
    lock.release();
    80203012:	307020ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>

    if (empty)
    {
        this->~Pipe();
        Slab::kfree(this);
    80203016:	8522                	mv	a0,s0
    }
}
    80203018:	6442                	ld	s0,16(sp)
    8020301a:	60e2                	ld	ra,24(sp)
    8020301c:	64a2                	ld	s1,8(sp)
    8020301e:	6105                	addi	sp,sp,32
        Slab::kfree(this);
    80203020:	3190306f          	j	80206b38 <_ZN4Slab5kfreeEPv>
}
    80203024:	6442                	ld	s0,16(sp)
    80203026:	60e2                	ld	ra,24(sp)
    80203028:	64a2                	ld	s1,8(sp)
    8020302a:	6105                	addi	sp,sp,32
    lock.release();
    8020302c:	2ed0206f          	j	80205b18 <_ZN8Spinlock7releaseEv>
        read_open = false;
    80203030:	22040023          	sb	zero,544(s0)
        ProcManager::wakeup(&nwrite); // Wake up the process that is writing
    80203034:	21c40513          	addi	a0,s0,540
    80203038:	012050ef          	jal	8020804a <_ZN11ProcManager6wakeupEPv>
    8020303c:	b7e1                	j	80203004 <_ZN4Pipe5closeEb+0x1e>

000000008020303e <_ZN4Pipe5writeEyi>:

int Pipe::write(uint64_t addr, int n)
{
    8020303e:	711d                	addi	sp,sp,-96
    80203040:	e8a2                	sd	s0,80(sp)
    80203042:	e4a6                	sd	s1,72(sp)
    80203044:	e0ca                	sd	s2,64(sp)
    80203046:	fc4e                	sd	s3,56(sp)
    80203048:	ec86                	sd	ra,88(sp)
    8020304a:	ec5e                	sd	s7,24(sp)
    8020304c:	842a                	mv	s0,a0
    8020304e:	8932                	mv	s2,a2
    80203050:	89ae                	mv	s3,a1
    int i = 0;
    struct Proc *p = myproc();
    80203052:	231020ef          	jal	80205a82 <_Z6myprocv>
    80203056:	84aa                	mv	s1,a0

    lock.acquire();
    80203058:	8522                	mv	a0,s0
    8020305a:	327020ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
    while (i < n)
    8020305e:	0b205863          	blez	s2,8020310e <_ZN4Pipe5writeEyi+0xd0>
    80203062:	f852                	sd	s4,48(sp)
    80203064:	f456                	sd	s5,40(sp)
    80203066:	f05a                	sd	s6,32(sp)
    int i = 0;
    80203068:	4b81                	li	s7,0
            ProcManager::sleep(&nwrite, &lock);
        }
        else
        {
            char ch;
            if (VM::copyin(p->pagetable, &ch, addr + i, 1) < 0)
    8020306a:	00f10a13          	addi	s4,sp,15
            ProcManager::wakeup(&nread);
    8020306e:	21840b13          	addi	s6,s0,536
            ProcManager::sleep(&nwrite, &lock);
    80203072:	21c40a93          	addi	s5,s0,540
        if (!read_open || p->xstate) // The read end is closed or the process is abnormal
    80203076:	22044783          	lbu	a5,544(s0)
            if (VM::copyin(p->pagetable, &ch, addr + i, 1) < 0)
    8020307a:	4685                	li	a3,1
    8020307c:	013b8633          	add	a2,s7,s3
    80203080:	85d2                	mv	a1,s4
        if (!read_open || p->xstate) // The read end is closed or the process is abnormal
    80203082:	c7b5                	beqz	a5,802030ee <_ZN4Pipe5writeEyi+0xb0>
    80203084:	0b84a783          	lw	a5,184(s1)
    80203088:	e3bd                	bnez	a5,802030ee <_ZN4Pipe5writeEyi+0xb0>
        if (nwrite == nread + SIZE) // buffer is full
    8020308a:	21842783          	lw	a5,536(s0)
    8020308e:	21c42703          	lw	a4,540(s0)
    80203092:	2007879b          	addiw	a5,a5,512
    80203096:	04f70263          	beq	a4,a5,802030da <_ZN4Pipe5writeEyi+0x9c>
            if (VM::copyin(p->pagetable, &ch, addr + i, 1) < 0)
    8020309a:	7ca8                	ld	a0,120(s1)
    8020309c:	3e4030ef          	jal	80206480 <_ZN2VM6copyinEPyPcyy>
    802030a0:	02054263          	bltz	a0,802030c4 <_ZN4Pipe5writeEyi+0x86>
                break;
            data[nwrite++ % SIZE] = ch;
    802030a4:	21c42783          	lw	a5,540(s0)
    802030a8:	00f14703          	lbu	a4,15(sp)
            i++;
    802030ac:	2b85                	addiw	s7,s7,1
            data[nwrite++ % SIZE] = ch;
    802030ae:	0017869b          	addiw	a3,a5,1
    802030b2:	1ff7f793          	andi	a5,a5,511
    802030b6:	20d42e23          	sw	a3,540(s0)
    802030ba:	97a2                	add	a5,a5,s0
    802030bc:	00e78c23          	sb	a4,24(a5)
    while (i < n)
    802030c0:	fb2bcbe3          	blt	s7,s2,80203076 <_ZN4Pipe5writeEyi+0x38>
    802030c4:	7a42                	ld	s4,48(sp)
    802030c6:	7aa2                	ld	s5,40(sp)
    802030c8:	7b02                	ld	s6,32(sp)
        }
    }
    ProcManager::wakeup(&nread);
    802030ca:	21840513          	addi	a0,s0,536
    802030ce:	77d040ef          	jal	8020804a <_ZN11ProcManager6wakeupEPv>
    lock.release();
    802030d2:	8522                	mv	a0,s0
    802030d4:	245020ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
    return i;
    802030d8:	a015                	j	802030fc <_ZN4Pipe5writeEyi+0xbe>
            ProcManager::wakeup(&nread);
    802030da:	855a                	mv	a0,s6
    802030dc:	76f040ef          	jal	8020804a <_ZN11ProcManager6wakeupEPv>
            ProcManager::sleep(&nwrite, &lock);
    802030e0:	85a2                	mv	a1,s0
    802030e2:	8556                	mv	a0,s5
    802030e4:	663040ef          	jal	80207f46 <_ZN11ProcManager5sleepEPvP8Spinlock>
    while (i < n)
    802030e8:	f92bc7e3          	blt	s7,s2,80203076 <_ZN4Pipe5writeEyi+0x38>
    802030ec:	bfe1                	j	802030c4 <_ZN4Pipe5writeEyi+0x86>
            lock.release();
    802030ee:	8522                	mv	a0,s0
    802030f0:	229020ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
            return -1;
    802030f4:	7a42                	ld	s4,48(sp)
    802030f6:	7aa2                	ld	s5,40(sp)
    802030f8:	7b02                	ld	s6,32(sp)
    802030fa:	5bfd                	li	s7,-1
}
    802030fc:	60e6                	ld	ra,88(sp)
    802030fe:	6446                	ld	s0,80(sp)
    80203100:	64a6                	ld	s1,72(sp)
    80203102:	6906                	ld	s2,64(sp)
    80203104:	79e2                	ld	s3,56(sp)
    80203106:	855e                	mv	a0,s7
    80203108:	6be2                	ld	s7,24(sp)
    8020310a:	6125                	addi	sp,sp,96
    8020310c:	8082                	ret
    int i = 0;
    8020310e:	4b81                	li	s7,0
    80203110:	bf6d                	j	802030ca <_ZN4Pipe5writeEyi+0x8c>

0000000080203112 <_ZN4Pipe4readEyi>:

int Pipe::read(uint64_t addr, int n)
{
    80203112:	715d                	addi	sp,sp,-80
    80203114:	e486                	sd	ra,72(sp)
    80203116:	e0a2                	sd	s0,64(sp)
    80203118:	fc26                	sd	s1,56(sp)
    8020311a:	842a                	mv	s0,a0
    8020311c:	f84a                	sd	s2,48(sp)
    8020311e:	f44e                	sd	s3,40(sp)
    80203120:	f052                	sd	s4,32(sp)
    80203122:	84ae                	mv	s1,a1
    80203124:	8a32                	mv	s4,a2
    int i = 0;
    struct Proc *p = myproc();
    80203126:	15d020ef          	jal	80205a82 <_Z6myprocv>
    8020312a:	89aa                	mv	s3,a0

    lock.acquire();
    8020312c:	8522                	mv	a0,s0
    8020312e:	253020ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
    while (nread == nwrite && write_open) // The buffer is empty and the write end is not closed
    80203132:	21842783          	lw	a5,536(s0)
    80203136:	21c42703          	lw	a4,540(s0)
    8020313a:	21840913          	addi	s2,s0,536
    8020313e:	00e78e63          	beq	a5,a4,8020315a <_ZN4Pipe4readEyi+0x48>
    80203142:	a00d                	j	80203164 <_ZN4Pipe4readEyi+0x52>
    {
        if (p->xstate)
    80203144:	0b89a783          	lw	a5,184(s3)
    80203148:	e7c9                	bnez	a5,802031d2 <_ZN4Pipe4readEyi+0xc0>
        {
            lock.release();
            return -1;
        }
        ProcManager::sleep(&nread, &lock);
    8020314a:	5fd040ef          	jal	80207f46 <_ZN11ProcManager5sleepEPvP8Spinlock>
    while (nread == nwrite && write_open) // The buffer is empty and the write end is not closed
    8020314e:	21842783          	lw	a5,536(s0)
    80203152:	21c42703          	lw	a4,540(s0)
    80203156:	00e79763          	bne	a5,a4,80203164 <_ZN4Pipe4readEyi+0x52>
    8020315a:	22144683          	lbu	a3,545(s0)
        ProcManager::sleep(&nread, &lock);
    8020315e:	85a2                	mv	a1,s0
    80203160:	854a                	mv	a0,s2
    while (nread == nwrite && write_open) // The buffer is empty and the write end is not closed
    80203162:	f2ed                	bnez	a3,80203144 <_ZN4Pipe4readEyi+0x32>
    80203164:	ec56                	sd	s5,24(sp)
    }

    for (i = 0; i < n; ++i)
    80203166:	4901                	li	s2,0
    {
        if (nread == nwrite)
            break;
        char ch = data[nread++ % SIZE];
        if (VM::copyout(p->pagetable, addr + i, &ch, 1) < 0)
    80203168:	00f10a93          	addi	s5,sp,15
    for (i = 0; i < n; ++i)
    8020316c:	03404763          	bgtz	s4,8020319a <_ZN4Pipe4readEyi+0x88>
    80203170:	a081                	j	802031b0 <_ZN4Pipe4readEyi+0x9e>
        char ch = data[nread++ % SIZE];
    80203172:	20a42c23          	sw	a0,536(s0)
    80203176:	01884783          	lbu	a5,24(a6)
        if (VM::copyout(p->pagetable, addr + i, &ch, 1) < 0)
    8020317a:	0789b503          	ld	a0,120(s3)
        char ch = data[nread++ % SIZE];
    8020317e:	00f107a3          	sb	a5,15(sp)
        if (VM::copyout(p->pagetable, addr + i, &ch, 1) < 0)
    80203182:	520030ef          	jal	802066a2 <_ZN2VM7copyoutEPyyPcy>
    80203186:	02054563          	bltz	a0,802031b0 <_ZN4Pipe4readEyi+0x9e>
    for (i = 0; i < n; ++i)
    8020318a:	2905                	addiw	s2,s2,1
    8020318c:	0485                	addi	s1,s1,1
    8020318e:	032a0163          	beq	s4,s2,802031b0 <_ZN4Pipe4readEyi+0x9e>
    80203192:	21842783          	lw	a5,536(s0)
    80203196:	21c42703          	lw	a4,540(s0)
        char ch = data[nread++ % SIZE];
    8020319a:	1ff7f693          	andi	a3,a5,511
    8020319e:	00d40833          	add	a6,s0,a3
    802031a2:	0017851b          	addiw	a0,a5,1
        if (VM::copyout(p->pagetable, addr + i, &ch, 1) < 0)
    802031a6:	4685                	li	a3,1
    802031a8:	8656                	mv	a2,s5
    802031aa:	85a6                	mv	a1,s1
        if (nread == nwrite)
    802031ac:	fcf713e3          	bne	a4,a5,80203172 <_ZN4Pipe4readEyi+0x60>
            break;
    }
    ProcManager::wakeup(&nwrite);
    802031b0:	21c40513          	addi	a0,s0,540
    802031b4:	697040ef          	jal	8020804a <_ZN11ProcManager6wakeupEPv>
    lock.release();
    802031b8:	8522                	mv	a0,s0
    802031ba:	15f020ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
    802031be:	6ae2                	ld	s5,24(sp)
    return i;
}
    802031c0:	60a6                	ld	ra,72(sp)
    802031c2:	6406                	ld	s0,64(sp)
    802031c4:	74e2                	ld	s1,56(sp)
    802031c6:	79a2                	ld	s3,40(sp)
    802031c8:	7a02                	ld	s4,32(sp)
    802031ca:	854a                	mv	a0,s2
    802031cc:	7942                	ld	s2,48(sp)
    802031ce:	6161                	addi	sp,sp,80
    802031d0:	8082                	ret
            lock.release();
    802031d2:	8522                	mv	a0,s0
    802031d4:	145020ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
            return -1;
    802031d8:	597d                	li	s2,-1
    802031da:	b7dd                	j	802031c0 <_ZN4Pipe4readEyi+0xae>

00000000802031dc <_ZN9FileTable4initEv>:
        struct file files[NFILE];
    } ftable;

    void init()
    {
        ftable.lock.init("file_table");
    802031dc:	0000e597          	auipc	a1,0xe
    802031e0:	56c58593          	addi	a1,a1,1388 # 80211748 <initcode_end>
    802031e4:	0001a517          	auipc	a0,0x1a
    802031e8:	a2450513          	addi	a0,a0,-1500 # 8021cc08 <_ZN9FileTable6ftableE>
    802031ec:	7ee0206f          	j	802059da <_ZN8Spinlock4initEPKc>

00000000802031f0 <_ZN9FileTable5allocEv>:
    }

    struct file *alloc()
    {
    802031f0:	1141                	addi	sp,sp,-16
        struct file *f;
        ftable.lock.acquire();
    802031f2:	0001a517          	auipc	a0,0x1a
    802031f6:	a1650513          	addi	a0,a0,-1514 # 8021cc08 <_ZN9FileTable6ftableE>
    {
    802031fa:	e022                	sd	s0,0(sp)
    802031fc:	e406                	sd	ra,8(sp)
        ftable.lock.acquire();
    802031fe:	183020ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        for (f = ftable.files; f < ftable.files + NFILE; f++)
    80203202:	0001a417          	auipc	s0,0x1a
    80203206:	a1e40413          	addi	s0,s0,-1506 # 8021cc20 <_ZN9FileTable6ftableE+0x18>
    8020320a:	0001b717          	auipc	a4,0x1b
    8020320e:	9b670713          	addi	a4,a4,-1610 # 8021dbc0 <_ZZ10fat32_testvE6inited>
    80203212:	a029                	j	8020321c <_ZN9FileTable5allocEv+0x2c>
    80203214:	02840413          	addi	s0,s0,40
    80203218:	02e40163          	beq	s0,a4,8020323a <_ZN9FileTable5allocEv+0x4a>
        {
            if (f->ref == 0)
    8020321c:	405c                	lw	a5,4(s0)
    8020321e:	fbfd                	bnez	a5,80203214 <_ZN9FileTable5allocEv+0x24>
            {
                f->ref = 1;
    80203220:	4785                	li	a5,1
    80203222:	c05c                	sw	a5,4(s0)
                ftable.lock.release();
    80203224:	0001a517          	auipc	a0,0x1a
    80203228:	9e450513          	addi	a0,a0,-1564 # 8021cc08 <_ZN9FileTable6ftableE>
    8020322c:	0ed020ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
                return f;
            }
        }
        ftable.lock.release();
        return nullptr;
    }
    80203230:	60a2                	ld	ra,8(sp)
    80203232:	8522                	mv	a0,s0
    80203234:	6402                	ld	s0,0(sp)
    80203236:	0141                	addi	sp,sp,16
    80203238:	8082                	ret
        ftable.lock.release();
    8020323a:	0001a517          	auipc	a0,0x1a
    8020323e:	9ce50513          	addi	a0,a0,-1586 # 8021cc08 <_ZN9FileTable6ftableE>
    80203242:	0d7020ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
        return nullptr;
    80203246:	4401                	li	s0,0
    }
    80203248:	60a2                	ld	ra,8(sp)
    8020324a:	8522                	mv	a0,s0
    8020324c:	6402                	ld	s0,0(sp)
    8020324e:	0141                	addi	sp,sp,16
    80203250:	8082                	ret

0000000080203252 <_ZN9FileTable3dupEP4file>:

    struct file *dup(struct file *f)
    {
    80203252:	1141                	addi	sp,sp,-16
    80203254:	e022                	sd	s0,0(sp)
    80203256:	842a                	mv	s0,a0
        ftable.lock.acquire();
    80203258:	0001a517          	auipc	a0,0x1a
    8020325c:	9b050513          	addi	a0,a0,-1616 # 8021cc08 <_ZN9FileTable6ftableE>
    {
    80203260:	e406                	sd	ra,8(sp)
        ftable.lock.acquire();
    80203262:	11f020ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        if (f->ref < 1)
    80203266:	405c                	lw	a5,4(s0)
    80203268:	00f05f63          	blez	a5,80203286 <_ZN9FileTable3dupEP4file+0x34>
        {
            Drivers::uart_puts("panic: file dup\n");
            while (1)
                ;
        }
        f->ref++;
    8020326c:	2785                	addiw	a5,a5,1
    8020326e:	c05c                	sw	a5,4(s0)
        ftable.lock.release();
    80203270:	0001a517          	auipc	a0,0x1a
    80203274:	99850513          	addi	a0,a0,-1640 # 8021cc08 <_ZN9FileTable6ftableE>
    80203278:	0a1020ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
        return f;
    }
    8020327c:	60a2                	ld	ra,8(sp)
    8020327e:	8522                	mv	a0,s0
    80203280:	6402                	ld	s0,0(sp)
    80203282:	0141                	addi	sp,sp,16
    80203284:	8082                	ret
            Drivers::uart_puts("panic: file dup\n");
    80203286:	0000e517          	auipc	a0,0xe
    8020328a:	4d250513          	addi	a0,a0,1234 # 80211758 <initcode_end+0x10>
    8020328e:	2dd050ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            while (1)
    80203292:	a001                	j	80203292 <_ZN9FileTable3dupEP4file+0x40>

0000000080203294 <_ZN9FileTable5closeEP4file>:

    void close(struct file *f)
    {
    80203294:	7179                	addi	sp,sp,-48
    80203296:	f022                	sd	s0,32(sp)
    80203298:	842a                	mv	s0,a0
        struct file ff;

        ftable.lock.acquire();
    8020329a:	0001a517          	auipc	a0,0x1a
    8020329e:	96e50513          	addi	a0,a0,-1682 # 8021cc08 <_ZN9FileTable6ftableE>
    {
    802032a2:	f406                	sd	ra,40(sp)
        ftable.lock.acquire();
    802032a4:	0dd020ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        if(f->ref < 1)
    802032a8:	405c                	lw	a5,4(s0)
    802032aa:	04f05d63          	blez	a5,80203304 <_ZN9FileTable5closeEP4file+0x70>
        {
            Drivers::uart_puts("panic: file close\n");
            while (1)
                ;
        }
        f->ref--;
    802032ae:	fff7871b          	addiw	a4,a5,-1
    802032b2:	c058                	sw	a4,4(s0)
        if (f->ref > 0)
    802032b4:	ef1d                	bnez	a4,802032f2 <_ZN9FileTable5closeEP4file+0x5e>
    802032b6:	ec26                	sd	s1,24(sp)
    802032b8:	e84a                	sd	s2,16(sp)
    802032ba:	e44e                	sd	s3,8(sp)
        {
            ftable.lock.release();
            return;
        }

        ff = *f;
    802032bc:	4004                	lw	s1,0(s0)
        f->ref = 0;
        f->type = FD_NONE;
        ftable.lock.release();
    802032be:	0001a517          	auipc	a0,0x1a
    802032c2:	94a50513          	addi	a0,a0,-1718 # 8021cc08 <_ZN9FileTable6ftableE>
        f->type = FD_NONE;
    802032c6:	00042023          	sw	zero,0(s0)
        ff = *f;
    802032ca:	00944983          	lbu	s3,9(s0)
    802032ce:	01043903          	ld	s2,16(s0)
    802032d2:	6c00                	ld	s0,24(s0)
        ftable.lock.release();
    802032d4:	045020ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
        if (ff.type == FD_INODE)
    802032d8:	4785                	li	a5,1
    802032da:	04f48963          	beq	s1,a5,8020332c <_ZN9FileTable5closeEP4file+0x98>
        {
            // Release the corresponding Inode
            VFS::iput(ff.ip);
        }
        else if (ff.type == FD_PIPE)
    802032de:	478d                	li	a5,3
    802032e0:	02f48963          	beq	s1,a5,80203312 <_ZN9FileTable5closeEP4file+0x7e>
        {
            if (ff.pipe)
                ff.pipe->close(ff.writable);
        }
    }
    802032e4:	70a2                	ld	ra,40(sp)
    802032e6:	7402                	ld	s0,32(sp)
    802032e8:	64e2                	ld	s1,24(sp)
    802032ea:	6942                	ld	s2,16(sp)
    802032ec:	69a2                	ld	s3,8(sp)
    802032ee:	6145                	addi	sp,sp,48
    802032f0:	8082                	ret
    802032f2:	7402                	ld	s0,32(sp)
    802032f4:	70a2                	ld	ra,40(sp)
            ftable.lock.release();
    802032f6:	0001a517          	auipc	a0,0x1a
    802032fa:	91250513          	addi	a0,a0,-1774 # 8021cc08 <_ZN9FileTable6ftableE>
    }
    802032fe:	6145                	addi	sp,sp,48
            ftable.lock.release();
    80203300:	0190206f          	j	80205b18 <_ZN8Spinlock7releaseEv>
            Drivers::uart_puts("panic: file close\n");
    80203304:	0000e517          	auipc	a0,0xe
    80203308:	46c50513          	addi	a0,a0,1132 # 80211770 <initcode_end+0x28>
    8020330c:	25f050ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            while (1)
    80203310:	a001                	j	80203310 <_ZN9FileTable5closeEP4file+0x7c>
            if (ff.pipe)
    80203312:	fc0909e3          	beqz	s2,802032e4 <_ZN9FileTable5closeEP4file+0x50>
    }
    80203316:	7402                	ld	s0,32(sp)
                ff.pipe->close(ff.writable);
    80203318:	64e2                	ld	s1,24(sp)
    }
    8020331a:	70a2                	ld	ra,40(sp)
                ff.pipe->close(ff.writable);
    8020331c:	013035b3          	snez	a1,s3
    80203320:	854a                	mv	a0,s2
    80203322:	69a2                	ld	s3,8(sp)
    80203324:	6942                	ld	s2,16(sp)
    }
    80203326:	6145                	addi	sp,sp,48
                ff.pipe->close(ff.writable);
    80203328:	cbfff06f          	j	80202fe6 <_ZN4Pipe5closeEb>
            VFS::iput(ff.ip);
    8020332c:	8522                	mv	a0,s0
    }
    8020332e:	7402                	ld	s0,32(sp)
            VFS::iput(ff.ip);
    80203330:	64e2                	ld	s1,24(sp)
    80203332:	6942                	ld	s2,16(sp)
    80203334:	69a2                	ld	s3,8(sp)
    }
    80203336:	70a2                	ld	ra,40(sp)
    80203338:	6145                	addi	sp,sp,48
            VFS::iput(ff.ip);
    8020333a:	6a20106f          	j	802049dc <_ZN3VFS4iputEP5Inode>

000000008020333e <_ZN4Pipe11create_pairEPP4fileS2_>:
{
    8020333e:	7139                	addi	sp,sp,-64
    80203340:	ec4e                	sd	s3,24(sp)
    80203342:	89aa                	mv	s3,a0
    void *mem = Slab::kmalloc(sizeof(Pipe));
    80203344:	22800513          	li	a0,552
{
    80203348:	e852                	sd	s4,16(sp)
    8020334a:	fc06                	sd	ra,56(sp)
    8020334c:	f426                	sd	s1,40(sp)
    8020334e:	8a2e                	mv	s4,a1
    void *mem = Slab::kmalloc(sizeof(Pipe));
    80203350:	618030ef          	jal	80206968 <_ZN4Slab7kmallocEy>
    if (!mem)
    80203354:	12050663          	beqz	a0,80203480 <_ZN4Pipe11create_pairEPP4fileS2_+0x142>
    80203358:	85aa                	mv	a1,a0
    Pipe *pi = new (mem) Pipe();
    8020335a:	22800513          	li	a0,552
    8020335e:	f822                	sd	s0,48(sp)
    80203360:	f04a                	sd	s2,32(sp)
    80203362:	5b8020ef          	jal	8020591a <_ZnwmPv>
    volatile uint32 locked;     // Whether it is locked (0: unlocked, 1: locked)
    const char *name;      // Lock Name (for debugging)
    struct cpu *cpu; // The CPU holding the lock

    // Constructor
    Spinlock() : locked(0), name("uninit"), cpu(nullptr) {}
    80203366:	0000e797          	auipc	a5,0xe
    8020336a:	42278793          	addi	a5,a5,1058 # 80211788 <initcode_end+0x40>
    8020336e:	e51c                	sd	a5,8(a0)
class Pipe
{
public:
    static constexpr uint32_t SIZE = 512;

    Pipe() : nread(0), nwrite(0), read_open(true), write_open(true)
    80203370:	10100793          	li	a5,257
    80203374:	22f51023          	sh	a5,544(a0)
    80203378:	00052023          	sw	zero,0(a0)
    8020337c:	00053823          	sd	zero,16(a0)
    80203380:	20053c23          	sd	zero,536(a0)
    {
        lock.init("pipe");
    80203384:	0000e597          	auipc	a1,0xe
    80203388:	40c58593          	addi	a1,a1,1036 # 80211790 <initcode_end+0x48>
    8020338c:	892a                	mv	s2,a0
    8020338e:	64c020ef          	jal	802059da <_ZN8Spinlock4initEPKc>
        ftable.lock.acquire();
    80203392:	0001a517          	auipc	a0,0x1a
    80203396:	87650513          	addi	a0,a0,-1930 # 8021cc08 <_ZN9FileTable6ftableE>
    8020339a:	7e6020ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        for (f = ftable.files; f < ftable.files + NFILE; f++)
    8020339e:	0001a417          	auipc	s0,0x1a
    802033a2:	88240413          	addi	s0,s0,-1918 # 8021cc20 <_ZN9FileTable6ftableE+0x18>
    802033a6:	0001b717          	auipc	a4,0x1b
    802033aa:	81a70713          	addi	a4,a4,-2022 # 8021dbc0 <_ZZ10fat32_testvE6inited>
    802033ae:	a029                	j	802033b8 <_ZN4Pipe11create_pairEPP4fileS2_+0x7a>
    802033b0:	02840413          	addi	s0,s0,40
    802033b4:	08e40963          	beq	s0,a4,80203446 <_ZN4Pipe11create_pairEPP4fileS2_+0x108>
            if (f->ref == 0)
    802033b8:	405c                	lw	a5,4(s0)
    802033ba:	fbfd                	bnez	a5,802033b0 <_ZN4Pipe11create_pairEPP4fileS2_+0x72>
                f->ref = 1;
    802033bc:	4785                	li	a5,1
    802033be:	c05c                	sw	a5,4(s0)
                ftable.lock.release();
    802033c0:	0001a517          	auipc	a0,0x1a
    802033c4:	84850513          	addi	a0,a0,-1976 # 8021cc08 <_ZN9FileTable6ftableE>
    802033c8:	750020ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
    *f0 = FileTable::alloc();
    802033cc:	0089b023          	sd	s0,0(s3)
        ftable.lock.acquire();
    802033d0:	0001a517          	auipc	a0,0x1a
    802033d4:	83850513          	addi	a0,a0,-1992 # 8021cc08 <_ZN9FileTable6ftableE>
    802033d8:	7a8020ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        for (f = ftable.files; f < ftable.files + NFILE; f++)
    802033dc:	0001a417          	auipc	s0,0x1a
    802033e0:	84440413          	addi	s0,s0,-1980 # 8021cc20 <_ZN9FileTable6ftableE+0x18>
    802033e4:	0001a797          	auipc	a5,0x1a
    802033e8:	7dc78793          	addi	a5,a5,2012 # 8021dbc0 <_ZZ10fat32_testvE6inited>
    802033ec:	a029                	j	802033f6 <_ZN4Pipe11create_pairEPP4fileS2_+0xb8>
    802033ee:	02840413          	addi	s0,s0,40
    802033f2:	06f40263          	beq	s0,a5,80203456 <_ZN4Pipe11create_pairEPP4fileS2_+0x118>
            if (f->ref == 0)
    802033f6:	4044                	lw	s1,4(s0)
    802033f8:	f8fd                	bnez	s1,802033ee <_ZN4Pipe11create_pairEPP4fileS2_+0xb0>
    802033fa:	e456                	sd	s5,8(sp)
                f->ref = 1;
    802033fc:	4a85                	li	s5,1
    802033fe:	01542223          	sw	s5,4(s0)
                ftable.lock.release();
    80203402:	0001a517          	auipc	a0,0x1a
    80203406:	80650513          	addi	a0,a0,-2042 # 8021cc08 <_ZN9FileTable6ftableE>
    8020340a:	70e020ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
    *f1 = FileTable::alloc();
    8020340e:	008a3023          	sd	s0,0(s4)
    if (*f0 == nullptr || *f1 == nullptr)
    80203412:	0009b783          	ld	a5,0(s3)
    80203416:	c7bd                	beqz	a5,80203484 <_ZN4Pipe11create_pairEPP4fileS2_+0x146>
    (*f0)->type = FD_PIPE;
    80203418:	470d                	li	a4,3
    (*f0)->readable = 1;
    8020341a:	01579423          	sh	s5,8(a5)
    (*f0)->pipe = pi;
    8020341e:	0127b823          	sd	s2,16(a5)
    (*f0)->type = FD_PIPE;
    80203422:	c398                	sw	a4,0(a5)
    (*f1)->readable = 0;
    80203424:	10000793          	li	a5,256
    80203428:	00f41423          	sh	a5,8(s0)
    (*f1)->pipe = pi;
    8020342c:	01243823          	sd	s2,16(s0)
    (*f1)->type = FD_PIPE;
    80203430:	c018                	sw	a4,0(s0)
    (*f1)->pipe = pi;
    80203432:	7902                	ld	s2,32(sp)
    80203434:	7442                	ld	s0,48(sp)
    80203436:	6aa2                	ld	s5,8(sp)
}
    80203438:	70e2                	ld	ra,56(sp)
    8020343a:	69e2                	ld	s3,24(sp)
    8020343c:	6a42                	ld	s4,16(sp)
    8020343e:	8526                	mv	a0,s1
    80203440:	74a2                	ld	s1,40(sp)
    80203442:	6121                	addi	sp,sp,64
    80203444:	8082                	ret
        ftable.lock.release();
    80203446:	00019517          	auipc	a0,0x19
    8020344a:	7c250513          	addi	a0,a0,1986 # 8021cc08 <_ZN9FileTable6ftableE>
    8020344e:	6ca020ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
        return nullptr;
    80203452:	4401                	li	s0,0
    80203454:	bfa5                	j	802033cc <_ZN4Pipe11create_pairEPP4fileS2_+0x8e>
        ftable.lock.release();
    80203456:	00019517          	auipc	a0,0x19
    8020345a:	7b250513          	addi	a0,a0,1970 # 8021cc08 <_ZN9FileTable6ftableE>
    8020345e:	6ba020ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
    *f1 = FileTable::alloc();
    80203462:	000a3023          	sd	zero,0(s4)
    if (*f0 == nullptr || *f1 == nullptr)
    80203466:	0009b503          	ld	a0,0(s3)
    8020346a:	c511                	beqz	a0,80203476 <_ZN4Pipe11create_pairEPP4fileS2_+0x138>
            FileTable::close(*f0);
    8020346c:	e29ff0ef          	jal	80203294 <_ZN9FileTable5closeEP4file>
        if (*f1)
    80203470:	000a3403          	ld	s0,0(s4)
    80203474:	e809                	bnez	s0,80203486 <_ZN4Pipe11create_pairEPP4fileS2_+0x148>
        Slab::kfree(pi);
    80203476:	854a                	mv	a0,s2
    80203478:	6c0030ef          	jal	80206b38 <_ZN4Slab5kfreeEPv>
    8020347c:	7442                	ld	s0,48(sp)
    8020347e:	7902                	ld	s2,32(sp)
        return -1;
    80203480:	54fd                	li	s1,-1
    80203482:	bf5d                	j	80203438 <_ZN4Pipe11create_pairEPP4fileS2_+0xfa>
    80203484:	6aa2                	ld	s5,8(sp)
            FileTable::close(*f1);
    80203486:	8522                	mv	a0,s0
    80203488:	e0dff0ef          	jal	80203294 <_ZN9FileTable5closeEP4file>
    8020348c:	b7ed                	j	80203476 <_ZN4Pipe11create_pairEPP4fileS2_+0x138>

000000008020348e <_ZN9FileTable4readEP4fileyi>:

    int read(struct file *f, uint64 addr, int n)
    {
    8020348e:	1101                	addi	sp,sp,-32
    80203490:	ec06                	sd	ra,24(sp)
        if (f->readable == 0)
    80203492:	00854783          	lbu	a5,8(a0)
    80203496:	c7a5                	beqz	a5,802034fe <_ZN9FileTable4readEP4fileyi+0x70>
            return -1;
        if (f->type == FD_INODE)
    80203498:	411c                	lw	a5,0(a0)
    8020349a:	e822                	sd	s0,16(sp)
    8020349c:	4705                	li	a4,1
    8020349e:	842a                	mv	s0,a0
    802034a0:	00e78c63          	beq	a5,a4,802034b8 <_ZN9FileTable4readEP4fileyi+0x2a>
                f->off += r;
            }
            VFS::iunlock(f->ip);
            return r;
        }
        else if (f->type == FD_PIPE)
    802034a4:	470d                	li	a4,3
    802034a6:	04e79863          	bne	a5,a4,802034f6 <_ZN9FileTable4readEP4fileyi+0x68>
        {
            if (f->pipe)
    802034aa:	6908                	ld	a0,16(a0)
    802034ac:	c529                	beqz	a0,802034f6 <_ZN9FileTable4readEP4fileyi+0x68>
                return f->pipe->read(addr, n);
    802034ae:	6442                	ld	s0,16(sp)
        }
        return -1;
    }
    802034b0:	60e2                	ld	ra,24(sp)
    802034b2:	6105                	addi	sp,sp,32
                return f->pipe->read(addr, n);
    802034b4:	c5fff06f          	j	80203112 <_ZN4Pipe4readEyi>
            VFS::ilock(f->ip);
    802034b8:	6d08                	ld	a0,24(a0)
    802034ba:	e426                	sd	s1,8(sp)
    802034bc:	e04a                	sd	s2,0(sp)
    802034be:	84ae                	mv	s1,a1
    802034c0:	8932                	mv	s2,a2
    802034c2:	59e010ef          	jal	80204a60 <_ZN3VFS5ilockEP5Inode>
            int r = f->ip->read((char*)addr, f->off, n, 1);
    802034c6:	6c08                	ld	a0,24(s0)
    802034c8:	5010                	lw	a2,32(s0)
    802034ca:	85a6                	mv	a1,s1
    802034cc:	611c                	ld	a5,0(a0)
    802034ce:	4705                	li	a4,1
    802034d0:	86ca                	mv	a3,s2
    802034d2:	6f9c                	ld	a5,24(a5)
    802034d4:	9782                	jalr	a5
    802034d6:	84aa                	mv	s1,a0
            if(r > 0)
    802034d8:	00a05563          	blez	a0,802034e2 <_ZN9FileTable4readEP4fileyi+0x54>
                f->off += r;
    802034dc:	501c                	lw	a5,32(s0)
    802034de:	9fa9                	addw	a5,a5,a0
    802034e0:	d01c                	sw	a5,32(s0)
            VFS::iunlock(f->ip);
    802034e2:	6c08                	ld	a0,24(s0)
    802034e4:	59c010ef          	jal	80204a80 <_ZN3VFS7iunlockEP5Inode>
            return r;
    802034e8:	6442                	ld	s0,16(sp)
    802034ea:	6902                	ld	s2,0(sp)
    }
    802034ec:	60e2                	ld	ra,24(sp)
    802034ee:	8526                	mv	a0,s1
    802034f0:	64a2                	ld	s1,8(sp)
    802034f2:	6105                	addi	sp,sp,32
    802034f4:	8082                	ret
    802034f6:	e426                	sd	s1,8(sp)
            return -1;
    802034f8:	6442                	ld	s0,16(sp)
    802034fa:	54fd                	li	s1,-1
    802034fc:	bfc5                	j	802034ec <_ZN9FileTable4readEP4fileyi+0x5e>
    802034fe:	e426                	sd	s1,8(sp)
    80203500:	54fd                	li	s1,-1
    80203502:	b7ed                	j	802034ec <_ZN9FileTable4readEP4fileyi+0x5e>

0000000080203504 <_ZN9FileTable5writeEP4fileyi>:
    
    int write(struct file *f, uint64 addr, int n)
    {
    80203504:	1101                	addi	sp,sp,-32
    80203506:	ec06                	sd	ra,24(sp)
        if (f->writable == 0)
    80203508:	00954783          	lbu	a5,9(a0)
    8020350c:	c7a5                	beqz	a5,80203574 <_ZN9FileTable5writeEP4fileyi+0x70>
            return -1;
        if (f->type == FD_INODE)
    8020350e:	411c                	lw	a5,0(a0)
    80203510:	e822                	sd	s0,16(sp)
    80203512:	4705                	li	a4,1
    80203514:	842a                	mv	s0,a0
    80203516:	00e78c63          	beq	a5,a4,8020352e <_ZN9FileTable5writeEP4fileyi+0x2a>
                f->off += r;
            }
            VFS::iunlock(f->ip);
            return r;
        }
        else if (f->type == FD_PIPE)
    8020351a:	470d                	li	a4,3
    8020351c:	04e79863          	bne	a5,a4,8020356c <_ZN9FileTable5writeEP4fileyi+0x68>
        {
            if (f->pipe)
    80203520:	6908                	ld	a0,16(a0)
    80203522:	c529                	beqz	a0,8020356c <_ZN9FileTable5writeEP4fileyi+0x68>
                return f->pipe->write(addr, n);
    80203524:	6442                	ld	s0,16(sp)
        }

        return -1;
    }
    80203526:	60e2                	ld	ra,24(sp)
    80203528:	6105                	addi	sp,sp,32
                return f->pipe->write(addr, n);
    8020352a:	b15ff06f          	j	8020303e <_ZN4Pipe5writeEyi>
            VFS::ilock(f->ip);
    8020352e:	6d08                	ld	a0,24(a0)
    80203530:	e426                	sd	s1,8(sp)
    80203532:	e04a                	sd	s2,0(sp)
    80203534:	84ae                	mv	s1,a1
    80203536:	8932                	mv	s2,a2
    80203538:	528010ef          	jal	80204a60 <_ZN3VFS5ilockEP5Inode>
            int r = f->ip->write((char *)addr, f->off, n, 1);
    8020353c:	6c08                	ld	a0,24(s0)
    8020353e:	5010                	lw	a2,32(s0)
    80203540:	85a6                	mv	a1,s1
    80203542:	611c                	ld	a5,0(a0)
    80203544:	4705                	li	a4,1
    80203546:	86ca                	mv	a3,s2
    80203548:	739c                	ld	a5,32(a5)
    8020354a:	9782                	jalr	a5
    8020354c:	84aa                	mv	s1,a0
            if (r > 0)
    8020354e:	00a05563          	blez	a0,80203558 <_ZN9FileTable5writeEP4fileyi+0x54>
                f->off += r;
    80203552:	501c                	lw	a5,32(s0)
    80203554:	9fa9                	addw	a5,a5,a0
    80203556:	d01c                	sw	a5,32(s0)
            VFS::iunlock(f->ip);
    80203558:	6c08                	ld	a0,24(s0)
    8020355a:	526010ef          	jal	80204a80 <_ZN3VFS7iunlockEP5Inode>
            return r;
    8020355e:	6442                	ld	s0,16(sp)
    80203560:	6902                	ld	s2,0(sp)
    }
    80203562:	60e2                	ld	ra,24(sp)
    80203564:	8526                	mv	a0,s1
    80203566:	64a2                	ld	s1,8(sp)
    80203568:	6105                	addi	sp,sp,32
    8020356a:	8082                	ret
    8020356c:	e426                	sd	s1,8(sp)
            return -1;
    8020356e:	6442                	ld	s0,16(sp)
    80203570:	54fd                	li	s1,-1
    80203572:	bfc5                	j	80203562 <_ZN9FileTable5writeEP4fileyi+0x5e>
    80203574:	e426                	sd	s1,8(sp)
    80203576:	54fd                	li	s1,-1
    80203578:	b7ed                	j	80203562 <_ZN9FileTable5writeEP4fileyi+0x5e>

000000008020357a <_ZN9FileTable4statEP4filey>:

    int stat(struct file *f, uint64 addr)
    {
        if (f->type == FD_INODE)
    8020357a:	4118                	lw	a4,0(a0)
    8020357c:	4785                	li	a5,1
    8020357e:	04f71663          	bne	a4,a5,802035ca <_ZN9FileTable4statEP4filey+0x50>
    {
    80203582:	715d                	addi	sp,sp,-80
    80203584:	e0a2                	sd	s0,64(sp)
    80203586:	842a                	mv	s0,a0
        {
            struct kstat st;
            VFS::ilock(f->ip);
    80203588:	6d08                	ld	a0,24(a0)
    {
    8020358a:	e486                	sd	ra,72(sp)
    8020358c:	fc26                	sd	s1,56(sp)
    8020358e:	f84a                	sd	s2,48(sp)
    80203590:	84ae                	mv	s1,a1
            VFS::ilock(f->ip);
    80203592:	4ce010ef          	jal	80204a60 <_ZN3VFS5ilockEP5Inode>
            f->ip->getattr(&st);
    80203596:	6c08                	ld	a0,24(s0)
    80203598:	890a                	mv	s2,sp
    8020359a:	85ca                	mv	a1,s2
    8020359c:	611c                	ld	a5,0(a0)
    8020359e:	7f9c                	ld	a5,56(a5)
    802035a0:	9782                	jalr	a5
            VFS::iunlock(f->ip);
    802035a2:	6c08                	ld	a0,24(s0)
    802035a4:	4dc010ef          	jal	80204a80 <_ZN3VFS7iunlockEP5Inode>

            struct Proc *p = myproc();
    802035a8:	4da020ef          	jal	80205a82 <_Z6myprocv>
            if (VM::copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    802035ac:	7d28                	ld	a0,120(a0)
    802035ae:	864a                	mv	a2,s2
    802035b0:	85a6                	mv	a1,s1
    802035b2:	03000693          	li	a3,48
    802035b6:	0ec030ef          	jal	802066a2 <_ZN2VM7copyoutEPyyPcy>
                return -1;
            return 0;
        }
        return -1;
    }
    802035ba:	60a6                	ld	ra,72(sp)
    802035bc:	6406                	ld	s0,64(sp)
    802035be:	74e2                	ld	s1,56(sp)
    802035c0:	7942                	ld	s2,48(sp)
            if (VM::copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    802035c2:	41f5551b          	sraiw	a0,a0,0x1f
    }
    802035c6:	6161                	addi	sp,sp,80
    802035c8:	8082                	ret
        return -1;
    802035ca:	557d                	li	a0,-1
    }
    802035cc:	8082                	ret

00000000802035ce <_ZN9FileTable5lseekEP4fileii>:

    int lseek(struct file *f, int offset, int whence)
    {
    802035ce:	7179                	addi	sp,sp,-48
    802035d0:	e44e                	sd	s3,8(sp)
        if (f->type != FD_INODE)
    802035d2:	00052983          	lw	s3,0(a0)
    {
    802035d6:	f406                	sd	ra,40(sp)
    802035d8:	ec26                	sd	s1,24(sp)
        if (f->type != FD_INODE)
    802035da:	4785                	li	a5,1
    802035dc:	02f99863          	bne	s3,a5,8020360c <_ZN9FileTable5lseekEP4fileii+0x3e>
            return -1;

        VFS::ilock(f->ip);
    802035e0:	f022                	sd	s0,32(sp)
    802035e2:	842a                	mv	s0,a0
    802035e4:	6d08                	ld	a0,24(a0)
    802035e6:	e84a                	sd	s2,16(sp)
    802035e8:	84ae                	mv	s1,a1
    802035ea:	8932                	mv	s2,a2
    802035ec:	474010ef          	jal	80204a60 <_ZN3VFS5ilockEP5Inode>

        int new_off = f->off;
        int size = f->ip->size;
    802035f0:	6c08                	ld	a0,24(s0)
        int new_off = f->off;
    802035f2:	501c                	lw	a5,32(s0)
        int size = f->ip->size;
    802035f4:	4938                	lw	a4,80(a0)

        switch (whence)
    802035f6:	05390063          	beq	s2,s3,80203636 <_ZN9FileTable5lseekEP4fileii+0x68>
    802035fa:	4789                	li	a5,2
    802035fc:	00f90f63          	beq	s2,a5,8020361a <_ZN9FileTable5lseekEP4fileii+0x4c>
    80203600:	00090e63          	beqz	s2,8020361c <_ZN9FileTable5lseekEP4fileii+0x4e>
            break;
        case SEEK_END:
            new_off = size + offset;
            break;
        default:
            VFS::iunlock(f->ip);
    80203604:	47c010ef          	jal	80204a80 <_ZN3VFS7iunlockEP5Inode>
    80203608:	7402                	ld	s0,32(sp)
    8020360a:	6942                	ld	s2,16(sp)
        }

        f->off = new_off;
        VFS::iunlock(f->ip);
        return new_off;
    }
    8020360c:	70a2                	ld	ra,40(sp)
            return -1;
    8020360e:	54fd                	li	s1,-1
    }
    80203610:	69a2                	ld	s3,8(sp)
    80203612:	8526                	mv	a0,s1
    80203614:	64e2                	ld	s1,24(sp)
    80203616:	6145                	addi	sp,sp,48
    80203618:	8082                	ret
            new_off = size + offset;
    8020361a:	9cb9                	addw	s1,s1,a4
        if (new_off < 0)
    8020361c:	fe04c4e3          	bltz	s1,80203604 <_ZN9FileTable5lseekEP4fileii+0x36>
        f->off = new_off;
    80203620:	d004                	sw	s1,32(s0)
        VFS::iunlock(f->ip);
    80203622:	45e010ef          	jal	80204a80 <_ZN3VFS7iunlockEP5Inode>
    }
    80203626:	70a2                	ld	ra,40(sp)
        VFS::iunlock(f->ip);
    80203628:	7402                	ld	s0,32(sp)
    8020362a:	6942                	ld	s2,16(sp)
    }
    8020362c:	69a2                	ld	s3,8(sp)
    8020362e:	8526                	mv	a0,s1
    80203630:	64e2                	ld	s1,24(sp)
    80203632:	6145                	addi	sp,sp,48
    80203634:	8082                	ret
            new_off += offset;
    80203636:	9cbd                	addw	s1,s1,a5
            break;
    80203638:	b7d5                	j	8020361c <_ZN9FileTable5lseekEP4fileii+0x4e>

000000008020363a <_GLOBAL__sub_I__ZN4Pipe11create_pairEPP4fileS2_>:
    8020363a:	00019797          	auipc	a5,0x19
    8020363e:	5ce78793          	addi	a5,a5,1486 # 8021cc08 <_ZN9FileTable6ftableE>
    80203642:	0000e717          	auipc	a4,0xe
    80203646:	14670713          	addi	a4,a4,326 # 80211788 <initcode_end+0x40>
    8020364a:	0007a023          	sw	zero,0(a5)
    8020364e:	e798                	sd	a4,8(a5)
    80203650:	0007b823          	sd	zero,16(a5)
} // namespace FileTable
    80203654:	8082                	ret

0000000080203656 <_ZN15FAT32FileSystem4initEv>:
}

// FAT32 FileSystem Implementation

void FAT32FileSystem::init()
{
    80203656:	1101                	addi	sp,sp,-32
    80203658:	e426                	sd	s1,8(sp)
    struct Buf *b = BufferCache::bread(0, 0);
    8020365a:	4581                	li	a1,0
{
    8020365c:	84aa                	mv	s1,a0
    struct Buf *b = BufferCache::bread(0, 0);
    8020365e:	4501                	li	a0,0
{
    80203660:	e822                	sd	s0,16(sp)
    80203662:	ec06                	sd	ra,24(sp)
    80203664:	e04a                	sd	s2,0(sp)
    struct Buf *b = BufferCache::bread(0, 0);
    80203666:	65b040ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
    uint8 *data = (uint8 *)b->data;
    struct FAT32_BPB *bpb = (struct FAT32_BPB *)data;

    uint32 partition_lba = 0;

    bool is_valid_bpb = (bpb->bytesPerSector == 512) && (bpb->rootClus != 0);
    8020366a:	03454783          	lbu	a5,52(a0)
    8020366e:	03354683          	lbu	a3,51(a0)
    80203672:	20000713          	li	a4,512
    80203676:	07a2                	slli	a5,a5,0x8
    80203678:	8fd5                	or	a5,a5,a3
    struct Buf *b = BufferCache::bread(0, 0);
    8020367a:	842a                	mv	s0,a0
    bool is_valid_bpb = (bpb->bytesPerSector == 512) && (bpb->rootClus != 0);
    8020367c:	0ee79b63          	bne	a5,a4,80203772 <_ZN15FAT32FileSystem4initEv+0x11c>
    80203680:	05554683          	lbu	a3,85(a0)
    80203684:	05454603          	lbu	a2,84(a0)
    80203688:	05654703          	lbu	a4,86(a0)
    8020368c:	05754783          	lbu	a5,87(a0)
    80203690:	06a2                	slli	a3,a3,0x8
    80203692:	8ed1                	or	a3,a3,a2
    80203694:	0742                	slli	a4,a4,0x10
    80203696:	8f55                	or	a4,a4,a3
    80203698:	07e2                	slli	a5,a5,0x18
    8020369a:	8fd9                	or	a5,a5,a4
    8020369c:	cbf9                	beqz	a5,80203772 <_ZN15FAT32FileSystem4initEv+0x11c>
    uint8 *data = (uint8 *)b->data;
    8020369e:	02850793          	addi	a5,a0,40
    uint32 partition_lba = 0;
    802036a2:	4901                	li	s2,0
        Drivers::uart_puts("[FAT32] Panic: Invalid FAT32 BPB in partition.\n");
        while (1)
            ;
    }

    uint32 fat_sz = bpb->FATSz32;
    802036a4:	0257c603          	lbu	a2,37(a5)
    802036a8:	0247c583          	lbu	a1,36(a5)
    802036ac:	0267c703          	lbu	a4,38(a5)
    802036b0:	0277c683          	lbu	a3,39(a5)
    802036b4:	0622                	slli	a2,a2,0x8
    802036b6:	8e4d                	or	a2,a2,a1
    802036b8:	0742                	slli	a4,a4,0x10
    802036ba:	8f51                	or	a4,a4,a2
    802036bc:	06e2                	slli	a3,a3,0x18
    802036be:	8ed9                	or	a3,a3,a4
    802036c0:	2681                	sext.w	a3,a3
    this->fat_sz = fat_sz;
    802036c2:	ccd4                	sw	a3,28(s1)
    uint32 reserved_sec = bpb->reservedSecCnt;
    uint8 num_fats = bpb->numFATs;
    802036c4:	0107c603          	lbu	a2,16(a5)

    sectors_per_cluster = bpb->secPerClus;
    802036c8:	00d7c583          	lbu	a1,13(a5)
    uint32 reserved_sec = bpb->reservedSecCnt;
    802036cc:	00f7c703          	lbu	a4,15(a5)
    bytes_per_cluster = sectors_per_cluster * 512;
    root_cluster = bpb->rootClus;

    fat_start_sector = partition_lba + reserved_sec;
    data_start_sector = partition_lba + reserved_sec + (fat_sz * num_fats);
    802036d0:	02d606bb          	mulw	a3,a2,a3
    bytes_per_cluster = sectors_per_cluster * 512;
    802036d4:	0095961b          	slliw	a2,a1,0x9
    uint32 reserved_sec = bpb->reservedSecCnt;
    802036d8:	00e7c883          	lbu	a7,14(a5)
    sectors_per_cluster = bpb->secPerClus;
    802036dc:	c8cc                	sw	a1,20(s1)
    bytes_per_cluster = sectors_per_cluster * 512;
    802036de:	cc90                	sw	a2,24(s1)
    root_cluster = bpb->rootClus;
    802036e0:	02d7c503          	lbu	a0,45(a5)
    802036e4:	02c7c803          	lbu	a6,44(a5)
    802036e8:	02e7c583          	lbu	a1,46(a5)
    uint32 reserved_sec = bpb->reservedSecCnt;
    802036ec:	0722                	slli	a4,a4,0x8
    root_cluster = bpb->rootClus;
    802036ee:	02f7c603          	lbu	a2,47(a5)
    uint32 reserved_sec = bpb->reservedSecCnt;
    802036f2:	011767b3          	or	a5,a4,a7
    fat_start_sector = partition_lba + reserved_sec;
    802036f6:	012787bb          	addw	a5,a5,s2
    root_cluster = bpb->rootClus;
    802036fa:	0522                	slli	a0,a0,0x8
    802036fc:	01056533          	or	a0,a0,a6
    data_start_sector = partition_lba + reserved_sec + (fat_sz * num_fats);
    80203700:	00f6873b          	addw	a4,a3,a5
    root_cluster = bpb->rootClus;
    80203704:	05c2                	slli	a1,a1,0x10
    fat_start_sector = partition_lba + reserved_sec;
    80203706:	1782                	slli	a5,a5,0x20
    root_cluster = bpb->rootClus;
    80203708:	8dc9                	or	a1,a1,a0
    8020370a:	01861693          	slli	a3,a2,0x18
    fat_start_sector = partition_lba + reserved_sec;
    8020370e:	1702                	slli	a4,a4,0x20
    80203710:	9381                	srli	a5,a5,0x20
    root_cluster = bpb->rootClus;
    80203712:	8ecd                	or	a3,a3,a1
    fat_start_sector = partition_lba + reserved_sec;
    80203714:	8fd9                	or	a5,a5,a4
    root_cluster = bpb->rootClus;
    80203716:	c894                	sw	a3,16(s1)
    fat_start_sector = partition_lba + reserved_sec;
    80203718:	e49c                	sd	a5,8(s1)

    Drivers::uart_puts(ANSI_GREEN);
    8020371a:	0000e517          	auipc	a0,0xe
    8020371e:	16650513          	addi	a0,a0,358 # 80211880 <initcode_end+0x138>
    80203722:	648050ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
    Drivers::uart_puts("[FAT32] Init Success: RootClus=");
    80203726:	0000e517          	auipc	a0,0xe
    8020372a:	16250513          	addi	a0,a0,354 # 80211888 <initcode_end+0x140>
    8020372e:	63c050ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
    Drivers::uart_put_int(root_cluster);
    80203732:	4888                	lw	a0,16(s1)
    80203734:	694050ef          	jal	80208dc8 <_ZN7Drivers12uart_put_intEi>
    Drivers::uart_puts(", DataStart=");
    80203738:	0000e517          	auipc	a0,0xe
    8020373c:	17050513          	addi	a0,a0,368 # 802118a8 <initcode_end+0x160>
    80203740:	62a050ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
    Drivers::uart_put_int(data_start_sector);
    80203744:	44c8                	lw	a0,12(s1)
    80203746:	682050ef          	jal	80208dc8 <_ZN7Drivers12uart_put_intEi>
    Drivers::uart_puts(ANSI_RESET);
    8020374a:	0000e517          	auipc	a0,0xe
    8020374e:	16e50513          	addi	a0,a0,366 # 802118b8 <initcode_end+0x170>
    80203752:	618050ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
    Drivers::uart_puts("\n");
    80203756:	0000e517          	auipc	a0,0xe
    8020375a:	0ca50513          	addi	a0,a0,202 # 80211820 <initcode_end+0xd8>
    8020375e:	60c050ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>

    BufferCache::brelse(b);
    80203762:	8522                	mv	a0,s0
}
    80203764:	6442                	ld	s0,16(sp)
    80203766:	60e2                	ld	ra,24(sp)
    80203768:	64a2                	ld	s1,8(sp)
    8020376a:	6902                	ld	s2,0(sp)
    8020376c:	6105                	addi	sp,sp,32
    BufferCache::brelse(b);
    8020376e:	6690406f          	j	802085d6 <_ZN11BufferCache6brelseEP3Buf>
        Drivers::uart_puts("[FAT32] Sector 0 is not a valid BPB. Checking MBR...\n");
    80203772:	0000e517          	auipc	a0,0xe
    80203776:	02650513          	addi	a0,a0,38 # 80211798 <initcode_end+0x50>
    8020377a:	5f0050ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        if (data[510] != 0x55 || data[511] != 0xAA)
    8020377e:	22644703          	lbu	a4,550(s0)
    80203782:	05500793          	li	a5,85
    80203786:	00f71863          	bne	a4,a5,80203796 <_ZN15FAT32FileSystem4initEv+0x140>
    8020378a:	22744703          	lbu	a4,551(s0)
    8020378e:	0aa00793          	li	a5,170
    80203792:	00f70963          	beq	a4,a5,802037a4 <_ZN15FAT32FileSystem4initEv+0x14e>
            Drivers::uart_puts("[FAT32] Panic: Invalid Disk Signature!\n");
    80203796:	0000e517          	auipc	a0,0xe
    8020379a:	03a50513          	addi	a0,a0,58 # 802117d0 <initcode_end+0x88>
    8020379e:	5cc050ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            while (1)
    802037a2:	a001                	j	802037a2 <_ZN15FAT32FileSystem4initEv+0x14c>
        uint32 lba = *(uint32 *)(data + 446 + 8);
    802037a4:	1ee42903          	lw	s2,494(s0)
        if (lba > 0)
    802037a8:	04090b63          	beqz	s2,802037fe <_ZN15FAT32FileSystem4initEv+0x1a8>
            Drivers::uart_puts("[FAT32] MBR Partition 1 found @ Sector ");
    802037ac:	0000e517          	auipc	a0,0xe
    802037b0:	04c50513          	addi	a0,a0,76 # 802117f8 <initcode_end+0xb0>
    802037b4:	5b6050ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            Drivers::uart_put_int(lba);
    802037b8:	854a                	mv	a0,s2
    802037ba:	60e050ef          	jal	80208dc8 <_ZN7Drivers12uart_put_intEi>
            Drivers::uart_puts("\n");
    802037be:	0000e517          	auipc	a0,0xe
    802037c2:	06250513          	addi	a0,a0,98 # 80211820 <initcode_end+0xd8>
    802037c6:	5a4050ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        BufferCache::brelse(b);
    802037ca:	8522                	mv	a0,s0
    802037cc:	60b040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
        b = BufferCache::bread(0, partition_lba / 2);
    802037d0:	0019559b          	srliw	a1,s2,0x1
    802037d4:	4501                	li	a0,0
    802037d6:	4eb040ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
    if (bpb->bytesPerSector != 512)
    802037da:	03454783          	lbu	a5,52(a0)
    802037de:	03354683          	lbu	a3,51(a0)
    802037e2:	20000713          	li	a4,512
    802037e6:	07a2                	slli	a5,a5,0x8
    802037e8:	8fd5                	or	a5,a5,a3
        b = BufferCache::bread(0, partition_lba / 2);
    802037ea:	842a                	mv	s0,a0
    if (bpb->bytesPerSector != 512)
    802037ec:	02e78063          	beq	a5,a4,8020380c <_ZN15FAT32FileSystem4initEv+0x1b6>
        Drivers::uart_puts("[FAT32] Panic: Invalid FAT32 BPB in partition.\n");
    802037f0:	0000e517          	auipc	a0,0xe
    802037f4:	06050513          	addi	a0,a0,96 # 80211850 <initcode_end+0x108>
    802037f8:	572050ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        while (1)
    802037fc:	a001                	j	802037fc <_ZN15FAT32FileSystem4initEv+0x1a6>
            Drivers::uart_puts("[FAT32] Panic: No partition found.\n");
    802037fe:	0000e517          	auipc	a0,0xe
    80203802:	02a50513          	addi	a0,a0,42 # 80211828 <initcode_end+0xe0>
    80203806:	564050ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            while (1)
    8020380a:	a001                	j	8020380a <_ZN15FAT32FileSystem4initEv+0x1b4>
        bpb = (struct FAT32_BPB *)b->data;
    8020380c:	02850793          	addi	a5,a0,40
    80203810:	bd51                	j	802036a4 <_ZN15FAT32FileSystem4initEv+0x4e>

0000000080203812 <_ZL10match_namePKcS0_>:
}

// FAT32 Inode Implementation

static bool match_name(const char *disk_name, const char *target)
{
    80203812:	1101                	addi	sp,sp,-32
    80203814:	862a                	mv	a2,a0
    80203816:	850a                	mv	a0,sp
    80203818:	ec06                	sd	ra,24(sp)
    8020381a:	872a                	mv	a4,a0
    8020381c:	4781                	li	a5,0
    char temp[13];
    int i, j;

    for (i = 0; i < 8 && disk_name[i] != ' '; i++)
    8020381e:	02000813          	li	a6,32
    80203822:	48a1                	li	a7,8
    80203824:	00f606b3          	add	a3,a2,a5
    80203828:	0006c683          	lbu	a3,0(a3)
    8020382c:	07068463          	beq	a3,a6,80203894 <_ZL10match_namePKcS0_+0x82>
        temp[i] = disk_name[i];
    80203830:	00d70023          	sb	a3,0(a4)
    for (i = 0; i < 8 && disk_name[i] != ' '; i++)
    80203834:	0785                	addi	a5,a5,1
    80203836:	0705                	addi	a4,a4,1
    80203838:	ff1796e3          	bne	a5,a7,80203824 <_ZL10match_namePKcS0_+0x12>
    8020383c:	47a1                	li	a5,8
    if (disk_name[8] != ' ')
    8020383e:	00864683          	lbu	a3,8(a2)
    80203842:	02000713          	li	a4,32
    80203846:	02e68c63          	beq	a3,a4,8020387e <_ZL10match_namePKcS0_+0x6c>
    {
        temp[i++] = '.';
    8020384a:	01078693          	addi	a3,a5,16
    8020384e:	0017871b          	addiw	a4,a5,1
    80203852:	968a                	add	a3,a3,sp
    80203854:	02e00813          	li	a6,46
    80203858:	ff068823          	sb	a6,-16(a3)
        for (j = 0; j < 3 && disk_name[8 + j] != ' '; j++)
    8020385c:	0621                	addi	a2,a2,8
    8020385e:	00e506b3          	add	a3,a0,a4
    80203862:	2791                	addiw	a5,a5,4
    80203864:	02000893          	li	a7,32
    80203868:	00064803          	lbu	a6,0(a2)
    8020386c:	0605                	addi	a2,a2,1
    8020386e:	03180563          	beq	a6,a7,80203898 <_ZL10match_namePKcS0_+0x86>
            temp[i++] = disk_name[8 + j];
    80203872:	01068023          	sb	a6,0(a3)
    80203876:	2705                	addiw	a4,a4,1
        for (j = 0; j < 3 && disk_name[8 + j] != ' '; j++)
    80203878:	0685                	addi	a3,a3,1
    8020387a:	fef717e3          	bne	a4,a5,80203868 <_ZL10match_namePKcS0_+0x56>
    }
    temp[i] = 0;
    8020387e:	07c1                	addi	a5,a5,16
    80203880:	978a                	add	a5,a5,sp
    80203882:	fe078823          	sb	zero,-16(a5)
    return strcasecmp(temp, target) == 0;
    80203886:	6be010ef          	jal	80204f44 <_Z10strcasecmpPKcS0_>
}
    8020388a:	60e2                	ld	ra,24(sp)
    8020388c:	00153513          	seqz	a0,a0
    80203890:	6105                	addi	sp,sp,32
    80203892:	8082                	ret
    80203894:	2781                	sext.w	a5,a5
    80203896:	b765                	j	8020383e <_ZL10match_namePKcS0_+0x2c>
    80203898:	87ba                	mv	a5,a4
    8020389a:	b7d5                	j	8020387e <_ZL10match_namePKcS0_+0x6c>

000000008020389c <_ZN10FAT32Inode6updateEv>:
    }
    
}

void FAT32Inode::update()
{
    8020389c:	1101                	addi	sp,sp,-32
    struct Buf *b = BufferCache::bread(dev, ent_sec / 2);
    8020389e:	556c                	lw	a1,108(a0)
{
    802038a0:	e822                	sd	s0,16(sp)
    802038a2:	842a                	mv	s0,a0
    struct Buf *b = BufferCache::bread(dev, ent_sec / 2);
    802038a4:	4508                	lw	a0,8(a0)
    802038a6:	0015d59b          	srliw	a1,a1,0x1
{
    802038aa:	ec06                	sd	ra,24(sp)
    802038ac:	e426                	sd	s1,8(sp)
    struct Buf *b = BufferCache::bread(dev, ent_sec / 2);
    802038ae:	413040ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
    uint32 offset = (ent_sec % 2) * 512 + ent_off;
    802038b2:	547c                	lw	a5,108(s0)
    802038b4:	5838                	lw	a4,112(s0)

    struct FAT32_DirEnt *de = (struct FAT32_DirEnt *)(b->data + offset);

    // Update file size and starting cluster
    de->fileSize = size;
    802038b6:	4834                	lw	a3,80(s0)
    uint32 offset = (ent_sec % 2) * 512 + ent_off;
    802038b8:	8b85                	andi	a5,a5,1
    802038ba:	0097979b          	slliw	a5,a5,0x9
    802038be:	9f3d                	addw	a4,a4,a5
    struct FAT32_DirEnt *de = (struct FAT32_DirEnt *)(b->data + offset);
    802038c0:	1702                	slli	a4,a4,0x20
    802038c2:	02850793          	addi	a5,a0,40
    802038c6:	9301                	srli	a4,a4,0x20
    802038c8:	97ba                	add	a5,a5,a4
    de->fileSize = size;
    802038ca:	0086d59b          	srliw	a1,a3,0x8
    802038ce:	0106d61b          	srliw	a2,a3,0x10
    802038d2:	0186d71b          	srliw	a4,a3,0x18
    802038d6:	00d78e23          	sb	a3,28(a5)
    802038da:	00b78ea3          	sb	a1,29(a5)
    802038de:	00c78f23          	sb	a2,30(a5)
    802038e2:	00e78fa3          	sb	a4,31(a5)
    de->fstClusHI = (uint16)((first_clus >> 16) & 0xFFFF);
    802038e6:	5038                	lw	a4,96(s0)
    struct Buf *b = BufferCache::bread(dev, ent_sec / 2);
    802038e8:	84aa                	mv	s1,a0
    de->fstClusHI = (uint16)((first_clus >> 16) & 0xFFFF);
    802038ea:	0107559b          	srliw	a1,a4,0x10
    802038ee:	0187561b          	srliw	a2,a4,0x18
    de->fstClusLO = (uint16)(first_clus & 0xFFFF);
    802038f2:	00875693          	srli	a3,a4,0x8
    de->fstClusHI = (uint16)((first_clus >> 16) & 0xFFFF);
    802038f6:	00b78a23          	sb	a1,20(a5)
    802038fa:	00c78aa3          	sb	a2,21(a5)
    de->fstClusLO = (uint16)(first_clus & 0xFFFF);
    802038fe:	00e78d23          	sb	a4,26(a5)
    80203902:	00d78da3          	sb	a3,27(a5)

    BufferCache::bwrite(b);
    80203906:	49d040ef          	jal	802085a2 <_ZN11BufferCache6bwriteEP3Buf>
    BufferCache::brelse(b);
}
    8020390a:	6442                	ld	s0,16(sp)
    8020390c:	60e2                	ld	ra,24(sp)
    BufferCache::brelse(b);
    8020390e:	8526                	mv	a0,s1
}
    80203910:	64a2                	ld	s1,8(sp)
    80203912:	6105                	addi	sp,sp,32
    BufferCache::brelse(b);
    80203914:	4c30406f          	j	802085d6 <_ZN11BufferCache6brelseEP3Buf>

0000000080203918 <_ZN15FAT32FileSystem4rootEv>:
{
    80203918:	1101                	addi	sp,sp,-32
    8020391a:	e426                	sd	s1,8(sp)
    8020391c:	84aa                	mv	s1,a0
    FAT32Inode *ip = new FAT32Inode();
    8020391e:	07800513          	li	a0,120
{
    80203922:	ec06                	sd	ra,24(sp)
    80203924:	e822                	sd	s0,16(sp)
    FAT32Inode *ip = new FAT32Inode();
    80203926:	771010ef          	jal	80205896 <_Znwm>
    short major; // Major device number (only for T_DEVICE)
    short minor; // Minor device number (only for T_DEVICE)
    short nlink; // Number of hard links
    uint32 size; // File size

    Inode() : ref_cnt(0), valid(0)
    8020392a:	00011797          	auipc	a5,0x11
    8020392e:	1967b783          	ld	a5,406(a5) # 80214ac0 <_GLOBAL_OFFSET_TABLE_+0x60>
    80203932:	842a                	mv	s0,a0
    80203934:	07c1                	addi	a5,a5,16
    80203936:	e01c                	sd	a5,0(s0)
    80203938:	0000e797          	auipc	a5,0xe
    8020393c:	e5078793          	addi	a5,a5,-432 # 80211788 <initcode_end+0x40>
    80203940:	fc1c                	sd	a5,56(s0)
    {
        lock.init("inode");
    80203942:	0561                	addi	a0,a0,24
    Inode() : ref_cnt(0), valid(0)
    80203944:	00043823          	sd	zero,16(s0)
    80203948:	02042823          	sw	zero,48(s0)
    8020394c:	04043023          	sd	zero,64(s0)
        lock.init("inode");
    80203950:	0000e597          	auipc	a1,0xe
    80203954:	f7058593          	addi	a1,a1,-144 # 802118c0 <initcode_end+0x178>
    80203958:	08e020ef          	jal	802059e6 <_ZN5Mutex4initEPKc>
    ip->inum = root_cluster;
    8020395c:	4898                	lw	a4,16(s1)
    ip->ref_cnt = 1;
    8020395e:	4785                	li	a5,1
    80203960:	1782                	slli	a5,a5,0x20
    80203962:	4685                	li	a3,1
    80203964:	0785                	addi	a5,a5,1
    uint32 parent_clus; // Starting cluster number of the parent directory
    uint32 dir_offset;  // The byte offset of this directory entry in the parent directory
    uint32 ent_sec;     // Sector number of the directory entry
    uint32 ent_off;     // Offset of the directory entry within the sector

    FAT32Inode() : fs(nullptr), first_clus(0) {}
    80203966:	00011617          	auipc	a2,0x11
    8020396a:	03a60613          	addi	a2,a2,58 # 802149a0 <_ZTV10FAT32Inode+0x10>
    ip->fs = this;
    8020396e:	ec24                	sd	s1,88(s0)
}
    80203970:	60e2                	ld	ra,24(sp)
    80203972:	e010                	sd	a2,0(s0)
    ip->dev = 0;
    80203974:	00042423          	sw	zero,8(s0)
    ip->inum = root_cluster;
    80203978:	c458                	sw	a4,12(s0)
    ip->ref_cnt = 1;
    8020397a:	e81c                	sd	a5,16(s0)
    ip->type = T_DIR;
    8020397c:	04d41423          	sh	a3,72(s0)
    ip->size = 0;
    80203980:	04042823          	sw	zero,80(s0)
    ip->nlink = 1;
    80203984:	04d41723          	sh	a3,78(s0)
    ip->first_clus = root_cluster;
    80203988:	d038                	sw	a4,96(s0)
    ip->parent_clus = 0;
    8020398a:	06042223          	sw	zero,100(s0)
}
    8020398e:	8522                	mv	a0,s0
    80203990:	6442                	ld	s0,16(sp)
    80203992:	64a2                	ld	s1,8(sp)
    80203994:	6105                	addi	sp,sp,32
    80203996:	8082                	ret

0000000080203998 <_ZN10FAT32Inode4readEPcjji>:
{
    80203998:	7119                	addi	sp,sp,-128
    8020399a:	f8a2                	sd	s0,112(sp)
    if (first_clus == 0)
    8020399c:	5120                	lw	s0,96(a0)
{
    8020399e:	fc86                	sd	ra,120(sp)
    if (first_clus == 0)
    802039a0:	c449                	beqz	s0,80203a2a <_ZN10FAT32Inode4readEPcjji+0x92>
    uint32 clus_sz = fs->bytes_per_cluster;
    802039a2:	6d3c                	ld	a5,88(a0)
    802039a4:	e8d2                	sd	s4,80(sp)
    802039a6:	f4a6                	sd	s1,104(sp)
    802039a8:	0187aa03          	lw	s4,24(a5)
    uint32 skip = off / clus_sz;
    802039ac:	e4d6                	sd	s5,72(sp)
    802039ae:	e0da                	sd	s6,64(sp)
    802039b0:	fc5e                	sd	s7,56(sp)
    802039b2:	f862                	sd	s8,48(sp)
    802039b4:	f06a                	sd	s10,32(sp)
    802039b6:	f0ca                	sd	s2,96(sp)
    802039b8:	ecce                	sd	s3,88(sp)
    802039ba:	f466                	sd	s9,40(sp)
    802039bc:	03465d3b          	divuw	s10,a2,s4
    while (skip > 0)
    802039c0:	84aa                	mv	s1,a0
    802039c2:	8bae                	mv	s7,a1
    802039c4:	8b32                	mv	s6,a2
    802039c6:	8ab6                	mv	s5,a3
    802039c8:	8c3a                	mv	s8,a4
    802039ca:	07466563          	bltu	a2,s4,80203a34 <_ZN10FAT32Inode4readEPcjji+0x9c>
        if (clus >= 0x0FFFFFF8)
    802039ce:	10000937          	lui	s2,0x10000
    return next & 0x0FFFFFFF;
    802039d2:	100009b7          	lui	s3,0x10000
    802039d6:	19fd                	addi	s3,s3,-1 # fffffff <_start-0x70200001>
        if (clus >= 0x0FFFFFF8)
    802039d8:	195d                	addi	s2,s2,-9 # ffffff7 <_start-0x70200009>
    802039da:	a021                	j	802039e2 <_ZN10FAT32Inode4readEPcjji+0x4a>
    while (skip > 0)
    802039dc:	040d0c63          	beqz	s10,80203a34 <_ZN10FAT32Inode4readEPcjji+0x9c>
        clus = fs->next_cluster(clus);
    802039e0:	6cbc                	ld	a5,88(s1)
    uint32 fat_sector = fat_start_sector + (fat_offset / 512);
    802039e2:	479c                	lw	a5,8(a5)
    uint32 fat_offset = cluster * 4;
    802039e4:	00241c9b          	slliw	s9,s0,0x2
    uint32 fat_sector = fat_start_sector + (fat_offset / 512);
    802039e8:	009cd41b          	srliw	s0,s9,0x9
    802039ec:	9c3d                	addw	s0,s0,a5
    struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    802039ee:	0014559b          	srliw	a1,s0,0x1
    uint32 block_offset = (fat_sector % 2) * 512 + ent_offset;
    802039f2:	8805                	andi	s0,s0,1
    struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    802039f4:	4501                	li	a0,0
    uint32 ent_offset = fat_offset % 512;
    802039f6:	1ffcfc93          	andi	s9,s9,511
    uint32 block_offset = (fat_sector % 2) * 512 + ent_offset;
    802039fa:	0426                	slli	s0,s0,0x9
    struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    802039fc:	2c5040ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
    uint32 next = *(uint32 *)(b->data + block_offset);
    80203a00:	9466                	add	s0,s0,s9
    80203a02:	008507b3          	add	a5,a0,s0
    80203a06:	5780                	lw	s0,40(a5)
        skip--;
    80203a08:	3d7d                	addiw	s10,s10,-1
    BufferCache::brelse(b);
    80203a0a:	3cd040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
    return next & 0x0FFFFFFF;
    80203a0e:	01347433          	and	s0,s0,s3
        if (clus >= 0x0FFFFFF8)
    80203a12:	fc8975e3          	bgeu	s2,s0,802039dc <_ZN10FAT32Inode4readEPcjji+0x44>
    80203a16:	74a6                	ld	s1,104(sp)
    80203a18:	7906                	ld	s2,96(sp)
    80203a1a:	69e6                	ld	s3,88(sp)
    80203a1c:	6a46                	ld	s4,80(sp)
    80203a1e:	6aa6                	ld	s5,72(sp)
    80203a20:	6b06                	ld	s6,64(sp)
    80203a22:	7be2                	ld	s7,56(sp)
    80203a24:	7c42                	ld	s8,48(sp)
    80203a26:	7ca2                	ld	s9,40(sp)
    80203a28:	7d02                	ld	s10,32(sp)
        return 0;
    80203a2a:	4501                	li	a0,0
}
    80203a2c:	70e6                	ld	ra,120(sp)
    80203a2e:	7446                	ld	s0,112(sp)
    80203a30:	6109                	addi	sp,sp,128
    80203a32:	8082                	ret
    while (tot < n)
    80203a34:	100a8e63          	beqz	s5,80203b50 <_ZN10FAT32Inode4readEPcjji+0x1b8>
    return next & 0x0FFFFFFF;
    80203a38:	10000cb7          	lui	s9,0x10000
    uint32 current_off = off % clus_sz;
    80203a3c:	034b7d3b          	remuw	s10,s6,s4
    return next & 0x0FFFFFFF;
    80203a40:	fffc8793          	addi	a5,s9,-1 # fffffff <_start-0x70200001>
            if (clus >= 0x0FFFFFF8)
    80203a44:	10000b37          	lui	s6,0x10000
    80203a48:	ec6e                	sd	s11,24(sp)
    uint32 tot = 0;
    80203a4a:	4981                	li	s3,0
    return next & 0x0FFFFFFF;
    80203a4c:	e43e                	sd	a5,8(sp)
            if (clus >= 0x0FFFFFF8)
    80203a4e:	1b5d                	addi	s6,s6,-9 # ffffff7 <_start-0x70200009>
        if (sec_in_clus >= fs->sectors_per_cluster)
    80203a50:	6cb0                	ld	a2,88(s1)
    uint32 fat_offset = cluster * 4;
    80203a52:	00241d9b          	slliw	s11,s0,0x2
        uint32 off_in_sec = current_off % 512;
    80203a56:	1ffd7813          	andi	a6,s10,511
        if (sec_in_clus >= fs->sectors_per_cluster)
    80203a5a:	01462883          	lw	a7,20(a2)
        if (n - tot < m)
    80203a5e:	413a8a3b          	subw	s4,s5,s3
        uint32 m = 512 - off_in_sec;
    80203a62:	20000713          	li	a4,512
        uint32 sec_in_clus = current_off / 512;
    80203a66:	009d569b          	srliw	a3,s10,0x9
    return data_start_sector + (cluster - 2) * sectors_per_cluster;
    80203a6a:	ffe4059b          	addiw	a1,s0,-2
    uint32 fat_sector = fat_start_sector + (fat_offset / 512);
    80203a6e:	009dd79b          	srliw	a5,s11,0x9
    struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    80203a72:	4501                	li	a0,0
        uint32 m = 512 - off_in_sec;
    80203a74:	41070e3b          	subw	t3,a4,a6
        if (n - tot < m)
    80203a78:	000a0e9b          	sext.w	t4,s4
        uint32 sec_in_clus = current_off / 512;
    80203a7c:	009d591b          	srliw	s2,s10,0x9
        if (sec_in_clus >= fs->sectors_per_cluster)
    80203a80:	0516e863          	bltu	a3,a7,80203ad0 <_ZN10FAT32Inode4readEPcjji+0x138>
    uint32 fat_sector = fat_start_sector + (fat_offset / 512);
    80203a84:	4618                	lw	a4,8(a2)
    uint32 ent_offset = fat_offset % 512;
    80203a86:	1ffdfd93          	andi	s11,s11,511
    uint32 fat_sector = fat_start_sector + (fat_offset / 512);
    80203a8a:	00e7843b          	addw	s0,a5,a4
    struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    80203a8e:	0014559b          	srliw	a1,s0,0x1
    uint32 block_offset = (fat_sector % 2) * 512 + ent_offset;
    80203a92:	8805                	andi	s0,s0,1
    80203a94:	0426                	slli	s0,s0,0x9
    struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    80203a96:	22b040ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
    uint32 next = *(uint32 *)(b->data + block_offset);
    80203a9a:	946e                	add	s0,s0,s11
    80203a9c:	008507b3          	add	a5,a0,s0
    80203aa0:	5780                	lw	s0,40(a5)
    BufferCache::brelse(b);
    80203aa2:	335040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
    return next & 0x0FFFFFFF;
    80203aa6:	67a2                	ld	a5,8(sp)
    80203aa8:	8c7d                	and	s0,s0,a5
            if (clus >= 0x0FFFFFF8)
    80203aaa:	088b7f63          	bgeu	s6,s0,80203b48 <_ZN10FAT32Inode4readEPcjji+0x1b0>
    return tot;
    80203aae:	0009851b          	sext.w	a0,s3
}
    80203ab2:	70e6                	ld	ra,120(sp)
    80203ab4:	7446                	ld	s0,112(sp)
    80203ab6:	74a6                	ld	s1,104(sp)
    80203ab8:	7906                	ld	s2,96(sp)
    80203aba:	69e6                	ld	s3,88(sp)
    80203abc:	6a46                	ld	s4,80(sp)
    80203abe:	6aa6                	ld	s5,72(sp)
    80203ac0:	6b06                	ld	s6,64(sp)
    80203ac2:	7be2                	ld	s7,56(sp)
    80203ac4:	7c42                	ld	s8,48(sp)
    80203ac6:	7ca2                	ld	s9,40(sp)
    80203ac8:	7d02                	ld	s10,32(sp)
    80203aca:	6de2                	ld	s11,24(sp)
    80203acc:	6109                	addi	sp,sp,128
    80203ace:	8082                	ret
    return data_start_sector + (cluster - 2) * sectors_per_cluster;
    80203ad0:	031585bb          	mulw	a1,a1,a7
        uint32 sec = fs->cluster_to_sector(clus) + sec_in_clus;
    80203ad4:	465c                	lw	a5,12(a2)
    80203ad6:	00f9093b          	addw	s2,s2,a5
    80203ada:	00b9093b          	addw	s2,s2,a1
        struct Buf *b = BufferCache::bread(dev, sec / 2);
    80203ade:	0019559b          	srliw	a1,s2,0x1
        if (n - tot < m)
    80203ae2:	01de7363          	bgeu	t3,t4,80203ae8 <_ZN10FAT32Inode4readEPcjji+0x150>
    80203ae6:	8a72                	mv	s4,t3
        struct Buf *b = BufferCache::bread(dev, sec / 2);
    80203ae8:	4488                	lw	a0,8(s1)
    80203aea:	e042                	sd	a6,0(sp)
        uint32 block_offset = (sec % 2) * 512 + off_in_sec;
    80203aec:	00197913          	andi	s2,s2,1
        struct Buf *b = BufferCache::bread(dev, sec / 2);
    80203af0:	1d1040ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
            if (VM::copyout(myproc()->pagetable, (uint64)dst, (char *)(b->data + block_offset), m) < 0)
    80203af4:	6802                	ld	a6,0(sp)
        struct Buf *b = BufferCache::bread(dev, sec / 2);
    80203af6:	8caa                	mv	s9,a0
        uint32 block_offset = (sec % 2) * 512 + off_in_sec;
    80203af8:	0926                	slli	s2,s2,0x9
        if (n - tot < m)
    80203afa:	000a0d9b          	sext.w	s11,s4
            memmove(dst, b->data + block_offset, m);
    80203afe:	028c8593          	addi	a1,s9,40
            if (VM::copyout(myproc()->pagetable, (uint64)dst, (char *)(b->data + block_offset), m) < 0)
    80203b02:	9942                	add	s2,s2,a6
    80203b04:	1a02                	slli	s4,s4,0x20
            memmove(dst, b->data + block_offset, m);
    80203b06:	866e                	mv	a2,s11
    80203b08:	855e                	mv	a0,s7
    80203b0a:	95ca                	add	a1,a1,s2
            if (VM::copyout(myproc()->pagetable, (uint64)dst, (char *)(b->data + block_offset), m) < 0)
    80203b0c:	020a5a13          	srli	s4,s4,0x20
        if (isUser)
    80203b10:	020c0963          	beqz	s8,80203b42 <_ZN10FAT32Inode4readEPcjji+0x1aa>
            if (VM::copyout(myproc()->pagetable, (uint64)dst, (char *)(b->data + block_offset), m) < 0)
    80203b14:	76f010ef          	jal	80205a82 <_Z6myprocv>
    80203b18:	7d28                	ld	a0,120(a0)
    80203b1a:	028c8613          	addi	a2,s9,40
    80203b1e:	86d2                	mv	a3,s4
    80203b20:	964a                	add	a2,a2,s2
    80203b22:	85de                	mv	a1,s7
    80203b24:	37f020ef          	jal	802066a2 <_ZN2VM7copyoutEPyyPcy>
    80203b28:	04054063          	bltz	a0,80203b68 <_ZN10FAT32Inode4readEPcjji+0x1d0>
        BufferCache::brelse(b);
    80203b2c:	8566                	mv	a0,s9
        tot += m;
    80203b2e:	013d89bb          	addw	s3,s11,s3
        BufferCache::brelse(b);
    80203b32:	2a5040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
        dst += m;
    80203b36:	9bd2                	add	s7,s7,s4
        current_off += m;
    80203b38:	01ad8d3b          	addw	s10,s11,s10
    while (tot < n)
    80203b3c:	f159eae3          	bltu	s3,s5,80203a50 <_ZN10FAT32Inode4readEPcjji+0xb8>
    80203b40:	b7bd                	j	80203aae <_ZN10FAT32Inode4readEPcjji+0x116>
            memmove(dst, b->data + block_offset, m);
    80203b42:	332010ef          	jal	80204e74 <_Z7memmovePvPKvj>
    80203b46:	b7dd                	j	80203b2c <_ZN10FAT32Inode4readEPcjji+0x194>
            current_off = 0;
    80203b48:	4d01                	li	s10,0
    while (tot < n)
    80203b4a:	f159e3e3          	bltu	s3,s5,80203a50 <_ZN10FAT32Inode4readEPcjji+0xb8>
    80203b4e:	b785                	j	80203aae <_ZN10FAT32Inode4readEPcjji+0x116>
    80203b50:	74a6                	ld	s1,104(sp)
    80203b52:	7906                	ld	s2,96(sp)
    80203b54:	69e6                	ld	s3,88(sp)
    80203b56:	6a46                	ld	s4,80(sp)
    80203b58:	6aa6                	ld	s5,72(sp)
    80203b5a:	6b06                	ld	s6,64(sp)
    80203b5c:	7be2                	ld	s7,56(sp)
    80203b5e:	7c42                	ld	s8,48(sp)
    80203b60:	7ca2                	ld	s9,40(sp)
    80203b62:	7d02                	ld	s10,32(sp)
    80203b64:	4501                	li	a0,0
    return tot;
    80203b66:	b5d9                	j	80203a2c <_ZN10FAT32Inode4readEPcjji+0x94>
                BufferCache::brelse(b);
    80203b68:	8566                	mv	a0,s9
    80203b6a:	26d040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
                return -1;
    80203b6e:	557d                	li	a0,-1
    80203b70:	b789                	j	80203ab2 <_ZN10FAT32Inode4readEPcjji+0x11a>

0000000080203b72 <_ZN10FAT32Inode6unlinkEPKc>:
    update();
}

int FAT32Inode::unlink(const char *name)
{
    if (type != T_DIR)
    80203b72:	04851703          	lh	a4,72(a0)
    80203b76:	4785                	li	a5,1
    80203b78:	1af71863          	bne	a4,a5,80203d28 <_ZN10FAT32Inode6unlinkEPKc+0x1b6>
{
    80203b7c:	7175                	addi	sp,sp,-144
    80203b7e:	f0d2                	sd	s4,96(sp)
    80203b80:	8a2e                	mv	s4,a1
    80203b82:	e4de                	sd	s7,72(sp)
        return -1;
    if (strcmp(name, ".") == 0 || strcmp(name, "..") == 0)
    80203b84:	0000e597          	auipc	a1,0xe
    80203b88:	d4458593          	addi	a1,a1,-700 # 802118c8 <initcode_end+0x180>
    80203b8c:	8baa                	mv	s7,a0
    80203b8e:	8552                	mv	a0,s4
{
    80203b90:	e506                	sd	ra,136(sp)
    if (strcmp(name, ".") == 0 || strcmp(name, "..") == 0)
    80203b92:	37a010ef          	jal	80204f0c <_Z6strcmpPKcS0_>
    80203b96:	10050c63          	beqz	a0,80203cae <_ZN10FAT32Inode6unlinkEPKc+0x13c>
    80203b9a:	0000e597          	auipc	a1,0xe
    80203b9e:	d3658593          	addi	a1,a1,-714 # 802118d0 <initcode_end+0x188>
    80203ba2:	8552                	mv	a0,s4
    80203ba4:	368010ef          	jal	80204f0c <_Z6strcmpPKcS0_>
    80203ba8:	10050363          	beqz	a0,80203cae <_ZN10FAT32Inode6unlinkEPKc+0x13c>
    80203bac:	f86a                	sd	s10,48(sp)
        return -1;

    uint32_t clus = first_clus;
    80203bae:	060bad03          	lw	s10,96(s7)
    80203bb2:	fca6                	sd	s1,120(sp)
    80203bb4:	f8ca                	sd	s2,112(sp)
    80203bb6:	f4ce                	sd	s3,104(sp)
    80203bb8:	e122                	sd	s0,128(sp)
    80203bba:	ecd6                	sd	s5,88(sp)
    80203bbc:	e8da                	sd	s6,80(sp)
    80203bbe:	e0e2                	sd	s8,64(sp)
    80203bc0:	fc66                	sd	s9,56(sp)
    80203bc2:	f46e                	sd	s11,40(sp)
    bool found = false;
    struct Buf *target_buf = nullptr;
    uint32_t target_offset = 0;
    80203bc4:	848a                	mv	s1,sp
                if (de.name[0] == 0x00) // end of dir
                {
                    BufferCache::brelse(b);
                    return -1; // Not found
                }
                if (de.name[0] == 0xE5)
    80203bc6:	0e500913          	li	s2,229
            for (int off = 0; off < 512; off += 32)
    80203bca:	20000993          	li	s3,512
        uint32_t sec = fs->cluster_to_sector(clus);
    80203bce:	058bb783          	ld	a5,88(s7)
    return data_start_sector + (cluster - 2) * sectors_per_cluster;
    80203bd2:	ffed0c1b          	addiw	s8,s10,-2
    80203bd6:	4bd8                	lw	a4,20(a5)
    80203bd8:	47d4                	lw	a3,12(a5)
    80203bda:	02ec0c3b          	mulw	s8,s8,a4
    80203bde:	00dc0c3b          	addw	s8,s8,a3
        for (uint32 i = 0; i < fs->sectors_per_cluster; ++i)
    80203be2:	cb25                	beqz	a4,80203c52 <_ZN10FAT32Inode6unlinkEPKc+0xe0>
    80203be4:	4c81                	li	s9,0
            struct Buf *b = BufferCache::bread(dev, (sec + i) / 2);
    80203be6:	018c8abb          	addw	s5,s9,s8
    80203bea:	001ad59b          	srliw	a1,s5,0x1
            uint8_t *data = (uint8_t *)b->data + ((sec + i) % 2) * 512;
    80203bee:	001afa93          	andi	s5,s5,1
            struct Buf *b = BufferCache::bread(dev, (sec + i) / 2);
    80203bf2:	008ba503          	lw	a0,8(s7)
            uint8_t *data = (uint8_t *)b->data + ((sec + i) % 2) * 512;
    80203bf6:	009a9a9b          	slliw	s5,s5,0x9
    80203bfa:	028a841b          	addiw	s0,s5,40
    80203bfe:	1402                	slli	s0,s0,0x20
            struct Buf *b = BufferCache::bread(dev, (sec + i) / 2);
    80203c00:	0c1040ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
    80203c04:	9001                	srli	s0,s0,0x20
    80203c06:	8b2a                	mv	s6,a0
            for (int off = 0; off < 512; off += 32)
    80203c08:	942a                	add	s0,s0,a0
    80203c0a:	4d81                	li	s11,0
                memmove(&de, data + off, 32);
    80203c0c:	02000613          	li	a2,32
    80203c10:	85a2                	mv	a1,s0
    80203c12:	8526                	mv	a0,s1
    80203c14:	260010ef          	jal	80204e74 <_Z7memmovePvPKvj>
                if (de.name[0] == 0x00) // end of dir
    80203c18:	00014783          	lbu	a5,0(sp)
    80203c1c:	cfa5                	beqz	a5,80203c94 <_ZN10FAT32Inode6unlinkEPKc+0x122>
                if (de.name[0] == 0xE5)
    80203c1e:	01278b63          	beq	a5,s2,80203c34 <_ZN10FAT32Inode6unlinkEPKc+0xc2>
                    continue; // have been unlink
                if (de.attr & ATTR_LONG_NAME)
    80203c22:	00b14783          	lbu	a5,11(sp)
                    continue;

                if (match_name(de.name, name))
    80203c26:	85d2                	mv	a1,s4
    80203c28:	8526                	mv	a0,s1
                if (de.attr & ATTR_LONG_NAME)
    80203c2a:	8bbd                	andi	a5,a5,15
    80203c2c:	e781                	bnez	a5,80203c34 <_ZN10FAT32Inode6unlinkEPKc+0xc2>
                if (match_name(de.name, name))
    80203c2e:	be5ff0ef          	jal	80203812 <_ZL10match_namePKcS0_>
    80203c32:	e541                	bnez	a0,80203cba <_ZN10FAT32Inode6unlinkEPKc+0x148>
            for (int off = 0; off < 512; off += 32)
    80203c34:	020d8d9b          	addiw	s11,s11,32
    80203c38:	02040413          	addi	s0,s0,32
    80203c3c:	fd3d98e3          	bne	s11,s3,80203c0c <_ZN10FAT32Inode6unlinkEPKc+0x9a>
                }
            }

            if (found)
                break;
            BufferCache::brelse(b);
    80203c40:	855a                	mv	a0,s6
    80203c42:	195040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
        for (uint32 i = 0; i < fs->sectors_per_cluster; ++i)
    80203c46:	058bb783          	ld	a5,88(s7)
    80203c4a:	2c85                	addiw	s9,s9,1
    80203c4c:	4bd8                	lw	a4,20(a5)
    80203c4e:	f8ecece3          	bltu	s9,a4,80203be6 <_ZN10FAT32Inode6unlinkEPKc+0x74>
    uint32 fat_sector = fat_start_sector + (fat_offset / 512);
    80203c52:	479c                	lw	a5,8(a5)
    uint32 fat_offset = cluster * 4;
    80203c54:	002d1d1b          	slliw	s10,s10,0x2
    uint32 fat_sector = fat_start_sector + (fat_offset / 512);
    80203c58:	009d541b          	srliw	s0,s10,0x9
    80203c5c:	9c3d                	addw	s0,s0,a5
    struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    80203c5e:	0014559b          	srliw	a1,s0,0x1
    80203c62:	4501                	li	a0,0
    80203c64:	05d040ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
    uint32 block_offset = (fat_sector % 2) * 512 + ent_offset;
    80203c68:	00147793          	andi	a5,s0,1
    uint32 ent_offset = fat_offset % 512;
    80203c6c:	1ffd7d13          	andi	s10,s10,511
    uint32 block_offset = (fat_sector % 2) * 512 + ent_offset;
    80203c70:	07a6                	slli	a5,a5,0x9
    uint32 next = *(uint32 *)(b->data + block_offset);
    80203c72:	97ea                	add	a5,a5,s10
    80203c74:	97aa                	add	a5,a5,a0
    80203c76:	5780                	lw	s0,40(a5)
    BufferCache::brelse(b);
    80203c78:	15f040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>

        if (found)
            break;

        clus = fs->next_cluster(clus);
        if (clus >= 0x0FFFFFF8)
    80203c7c:	100007b7          	lui	a5,0x10000
    return next & 0x0FFFFFFF;
    80203c80:	1412                	slli	s0,s0,0x24
    80203c82:	02445d13          	srli	s10,s0,0x24
        if (clus >= 0x0FFFFFF8)
    80203c86:	17dd                	addi	a5,a5,-9 # ffffff7 <_start-0x70200009>
    80203c88:	f5a7f3e3          	bgeu	a5,s10,80203bce <_ZN10FAT32Inode6unlinkEPKc+0x5c>
    80203c8c:	a039                	j	80203c9a <_ZN10FAT32Inode6unlinkEPKc+0x128>
        if (target_ip)
        {
            VFS::ilock(target_ip);
            if (target_ip->type == T_DIR)
            {
                VFS::iunlockput(target_ip);
    80203c8e:	8522                	mv	a0,s0
    80203c90:	62b000ef          	jal	80204aba <_ZN3VFS10iunlockputEP5Inode>
                BufferCache::brelse(target_buf);
    80203c94:	855a                	mv	a0,s6
    80203c96:	141040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
    80203c9a:	640a                	ld	s0,128(sp)
    80203c9c:	74e6                	ld	s1,120(sp)
    80203c9e:	7946                	ld	s2,112(sp)
    80203ca0:	79a6                	ld	s3,104(sp)
    80203ca2:	6ae6                	ld	s5,88(sp)
    80203ca4:	6b46                	ld	s6,80(sp)
    80203ca6:	6c06                	ld	s8,64(sp)
    80203ca8:	7ce2                	ld	s9,56(sp)
    80203caa:	7d42                	ld	s10,48(sp)
    80203cac:	7da2                	ld	s11,40(sp)
        return -1;
    80203cae:	557d                	li	a0,-1
        BufferCache::brelse(target_buf);
        return 0;
    }

    return -1;
}
    80203cb0:	60aa                	ld	ra,136(sp)
    80203cb2:	7a06                	ld	s4,96(sp)
    80203cb4:	6ba6                	ld	s7,72(sp)
    80203cb6:	6149                	addi	sp,sp,144
    80203cb8:	8082                	ret
    if (found && target_buf)
    80203cba:	fe0b00e3          	beqz	s6,80203c9a <_ZN10FAT32Inode6unlinkEPKc+0x128>
        Inode *target_ip = lookup(name);
    80203cbe:	000bb783          	ld	a5,0(s7)
    80203cc2:	85d2                	mv	a1,s4
    80203cc4:	855e                	mv	a0,s7
    80203cc6:	779c                	ld	a5,40(a5)
    80203cc8:	9782                	jalr	a5
    80203cca:	842a                	mv	s0,a0
        if (target_ip)
    80203ccc:	c505                	beqz	a0,80203cf4 <_ZN10FAT32Inode6unlinkEPKc+0x182>
            VFS::ilock(target_ip);
    80203cce:	593000ef          	jal	80204a60 <_ZN3VFS5ilockEP5Inode>
            if (target_ip->type == T_DIR)
    80203cd2:	04841703          	lh	a4,72(s0)
    80203cd6:	4785                	li	a5,1
    80203cd8:	faf70be3          	beq	a4,a5,80203c8e <_ZN10FAT32Inode6unlinkEPKc+0x11c>
            target_ip->update();
    80203cdc:	6018                	ld	a4,0(s0)
            target_ip->nlink--;
    80203cde:	04e45783          	lhu	a5,78(s0)
            target_ip->update();
    80203ce2:	8522                	mv	a0,s0
    80203ce4:	6b18                	ld	a4,16(a4)
            target_ip->nlink--;
    80203ce6:	37fd                	addiw	a5,a5,-1
    80203ce8:	04f41723          	sh	a5,78(s0)
            target_ip->update();
    80203cec:	9702                	jalr	a4
            VFS::iunlockput(target_ip);
    80203cee:	8522                	mv	a0,s0
    80203cf0:	5cb000ef          	jal	80204aba <_ZN3VFS10iunlockputEP5Inode>
                    target_offset = ((sec + i) % 2) * 512 + off;
    80203cf4:	015d87bb          	addw	a5,s11,s5
        uint8_t *ptr = (uint8_t *)target_buf->data + target_offset;
    80203cf8:	1782                	slli	a5,a5,0x20
    80203cfa:	9381                	srli	a5,a5,0x20
        *ptr = 0xE5;
    80203cfc:	97da                	add	a5,a5,s6
    80203cfe:	5715                	li	a4,-27
        BufferCache::bwrite(target_buf);
    80203d00:	855a                	mv	a0,s6
        *ptr = 0xE5;
    80203d02:	02e78423          	sb	a4,40(a5)
        BufferCache::bwrite(target_buf);
    80203d06:	09d040ef          	jal	802085a2 <_ZN11BufferCache6bwriteEP3Buf>
        BufferCache::brelse(target_buf);
    80203d0a:	855a                	mv	a0,s6
    80203d0c:	0cb040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
        return 0;
    80203d10:	4501                	li	a0,0
    80203d12:	640a                	ld	s0,128(sp)
    80203d14:	74e6                	ld	s1,120(sp)
    80203d16:	7946                	ld	s2,112(sp)
    80203d18:	79a6                	ld	s3,104(sp)
    80203d1a:	6ae6                	ld	s5,88(sp)
    80203d1c:	6b46                	ld	s6,80(sp)
    80203d1e:	6c06                	ld	s8,64(sp)
    80203d20:	7ce2                	ld	s9,56(sp)
    80203d22:	7d42                	ld	s10,48(sp)
    80203d24:	7da2                	ld	s11,40(sp)
    80203d26:	b769                	j	80203cb0 <_ZN10FAT32Inode6unlinkEPKc+0x13e>
        return -1;
    80203d28:	557d                	li	a0,-1
}
    80203d2a:	8082                	ret

0000000080203d2c <_ZN10FAT32Inode6lookupEPKc>:
    if (type != T_DIR)
    80203d2c:	04851703          	lh	a4,72(a0)
{
    80203d30:	7135                	addi	sp,sp,-160
    80203d32:	ed06                	sd	ra,152(sp)
    80203d34:	e922                	sd	s0,144(sp)
    if (type != T_DIR)
    80203d36:	e43a                	sd	a4,8(sp)
    80203d38:	4785                	li	a5,1
    80203d3a:	10f71663          	bne	a4,a5,80203e46 <_ZN10FAT32Inode6lookupEPKc+0x11a>
    80203d3e:	e0ea                	sd	s10,64(sp)
    uint32 clus = first_clus;
    80203d40:	06052d03          	lw	s10,96(a0)
    while (clus < 0x0FFFFFF8)
    80203d44:	100007b7          	lui	a5,0x10000
    80203d48:	f4d6                	sd	s5,104(sp)
    80203d4a:	17dd                	addi	a5,a5,-9 # ffffff7 <_start-0x70200009>
    80203d4c:	8aaa                	mv	s5,a0
    80203d4e:	1ba7ed63          	bltu	a5,s10,80203f08 <_ZN10FAT32Inode6lookupEPKc+0x1dc>
    80203d52:	e526                	sd	s1,136(sp)
    80203d54:	e14a                	sd	s2,128(sp)
    80203d56:	fcce                	sd	s3,120(sp)
    80203d58:	f8d2                	sd	s4,112(sp)
    80203d5a:	f0da                	sd	s6,96(sp)
    80203d5c:	ecde                	sd	s7,88(sp)
    80203d5e:	e8e2                	sd	s8,80(sp)
    80203d60:	e4e6                	sd	s9,72(sp)
    80203d62:	fc6e                	sd	s11,56(sp)
    80203d64:	8a2e                	mv	s4,a1
    80203d66:	0804                	addi	s1,sp,16
                if (de.name[0] == 0xE5)
    80203d68:	0e500913          	li	s2,229
            for (int off = 0; off < 512; off += 32)
    80203d6c:	20000993          	li	s3,512
        uint32 sec = fs->cluster_to_sector(clus);
    80203d70:	058ab783          	ld	a5,88(s5)
    return data_start_sector + (cluster - 2) * sectors_per_cluster;
    80203d74:	ffed0b9b          	addiw	s7,s10,-2
    80203d78:	4bd8                	lw	a4,20(a5)
    80203d7a:	47d4                	lw	a3,12(a5)
    80203d7c:	02eb8bbb          	mulw	s7,s7,a4
    80203d80:	00db8bbb          	addw	s7,s7,a3
        for (uint32 i = 0; i < fs->sectors_per_cluster; i++)
    80203d84:	c72d                	beqz	a4,80203dee <_ZN10FAT32Inode6lookupEPKc+0xc2>
    80203d86:	4c81                	li	s9,0
            uint32 current_sec = sec + i;
    80203d88:	019b8c3b          	addw	s8,s7,s9
            struct Buf *b = BufferCache::bread(dev, current_sec / 2);
    80203d8c:	008aa503          	lw	a0,8(s5)
            uint32 block_base = (current_sec % 2) * 512;
    80203d90:	001c7413          	andi	s0,s8,1
            struct Buf *b = BufferCache::bread(dev, current_sec / 2);
    80203d94:	001c559b          	srliw	a1,s8,0x1
    80203d98:	0426                	slli	s0,s0,0x9
    80203d9a:	726040ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
    80203d9e:	02840413          	addi	s0,s0,40
    80203da2:	8b2a                	mv	s6,a0
            for (int off = 0; off < 512; off += 32)
    80203da4:	942a                	add	s0,s0,a0
    80203da6:	4d81                	li	s11,0
                memmove(&de, b->data + block_base + off, 32);
    80203da8:	02000613          	li	a2,32
    80203dac:	85a2                	mv	a1,s0
    80203dae:	8526                	mv	a0,s1
    80203db0:	0c4010ef          	jal	80204e74 <_Z7memmovePvPKvj>
                if (de.name[0] == 0x00)
    80203db4:	01014783          	lbu	a5,16(sp)
    80203db8:	cbad                	beqz	a5,80203e2a <_ZN10FAT32Inode6lookupEPKc+0xfe>
                if (de.name[0] == 0xE5)
    80203dba:	01278b63          	beq	a5,s2,80203dd0 <_ZN10FAT32Inode6lookupEPKc+0xa4>
                if (de.attr & ATTR_LONG_NAME)
    80203dbe:	01b14783          	lbu	a5,27(sp)
                if (match_name(de.name, name))
    80203dc2:	85d2                	mv	a1,s4
    80203dc4:	8526                	mv	a0,s1
                if (de.attr & ATTR_LONG_NAME)
    80203dc6:	8bbd                	andi	a5,a5,15
    80203dc8:	e781                	bnez	a5,80203dd0 <_ZN10FAT32Inode6lookupEPKc+0xa4>
                if (match_name(de.name, name))
    80203dca:	a49ff0ef          	jal	80203812 <_ZL10match_namePKcS0_>
    80203dce:	e151                	bnez	a0,80203e52 <_ZN10FAT32Inode6lookupEPKc+0x126>
            for (int off = 0; off < 512; off += 32)
    80203dd0:	020d8d9b          	addiw	s11,s11,32
    80203dd4:	02040413          	addi	s0,s0,32
    80203dd8:	fd3d98e3          	bne	s11,s3,80203da8 <_ZN10FAT32Inode6lookupEPKc+0x7c>
            BufferCache::brelse(b);
    80203ddc:	855a                	mv	a0,s6
    80203dde:	7f8040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
        for (uint32 i = 0; i < fs->sectors_per_cluster; i++)
    80203de2:	058ab783          	ld	a5,88(s5)
    80203de6:	2c85                	addiw	s9,s9,1
    80203de8:	4bd8                	lw	a4,20(a5)
    80203dea:	f8ecefe3          	bltu	s9,a4,80203d88 <_ZN10FAT32Inode6lookupEPKc+0x5c>
    uint32 fat_sector = fat_start_sector + (fat_offset / 512);
    80203dee:	479c                	lw	a5,8(a5)
    uint32 fat_offset = cluster * 4;
    80203df0:	002d1d1b          	slliw	s10,s10,0x2
    uint32 fat_sector = fat_start_sector + (fat_offset / 512);
    80203df4:	009d541b          	srliw	s0,s10,0x9
    80203df8:	9c3d                	addw	s0,s0,a5
    struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    80203dfa:	0014559b          	srliw	a1,s0,0x1
    80203dfe:	4501                	li	a0,0
    80203e00:	6c0040ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
    uint32 block_offset = (fat_sector % 2) * 512 + ent_offset;
    80203e04:	00147793          	andi	a5,s0,1
    uint32 ent_offset = fat_offset % 512;
    80203e08:	1ffd7d13          	andi	s10,s10,511
    uint32 block_offset = (fat_sector % 2) * 512 + ent_offset;
    80203e0c:	07a6                	slli	a5,a5,0x9
    uint32 next = *(uint32 *)(b->data + block_offset);
    80203e0e:	97ea                	add	a5,a5,s10
    80203e10:	97aa                	add	a5,a5,a0
    80203e12:	5780                	lw	s0,40(a5)
    BufferCache::brelse(b);
    80203e14:	7c2040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
    while (clus < 0x0FFFFFF8)
    80203e18:	100007b7          	lui	a5,0x10000
    return next & 0x0FFFFFFF;
    80203e1c:	1412                	slli	s0,s0,0x24
    80203e1e:	02445d13          	srli	s10,s0,0x24
    while (clus < 0x0FFFFFF8)
    80203e22:	17dd                	addi	a5,a5,-9 # ffffff7 <_start-0x70200009>
    80203e24:	f5a7f6e3          	bgeu	a5,s10,80203d70 <_ZN10FAT32Inode6lookupEPKc+0x44>
    80203e28:	a021                	j	80203e30 <_ZN10FAT32Inode6lookupEPKc+0x104>
                    BufferCache::brelse(b);
    80203e2a:	855a                	mv	a0,s6
    80203e2c:	7aa040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
                    return nullptr;
    80203e30:	64aa                	ld	s1,136(sp)
    80203e32:	690a                	ld	s2,128(sp)
    80203e34:	79e6                	ld	s3,120(sp)
    80203e36:	7a46                	ld	s4,112(sp)
    80203e38:	7aa6                	ld	s5,104(sp)
    80203e3a:	7b06                	ld	s6,96(sp)
    80203e3c:	6be6                	ld	s7,88(sp)
    80203e3e:	6c46                	ld	s8,80(sp)
    80203e40:	6ca6                	ld	s9,72(sp)
    80203e42:	6d06                	ld	s10,64(sp)
    80203e44:	7de2                	ld	s11,56(sp)
        return nullptr;
    80203e46:	4401                	li	s0,0
}
    80203e48:	60ea                	ld	ra,152(sp)
    80203e4a:	8522                	mv	a0,s0
    80203e4c:	644a                	ld	s0,144(sp)
    80203e4e:	610d                	addi	sp,sp,160
    80203e50:	8082                	ret
                    FAT32Inode *ip = new FAT32Inode();
    80203e52:	07800513          	li	a0,120
    80203e56:	241010ef          	jal	80205896 <_Znwm>
    Inode() : ref_cnt(0), valid(0)
    80203e5a:	00011797          	auipc	a5,0x11
    80203e5e:	c667b783          	ld	a5,-922(a5) # 80214ac0 <_GLOBAL_OFFSET_TABLE_+0x60>
    80203e62:	07c1                	addi	a5,a5,16
    80203e64:	e11c                	sd	a5,0(a0)
    80203e66:	0000e797          	auipc	a5,0xe
    80203e6a:	92278793          	addi	a5,a5,-1758 # 80211788 <initcode_end+0x40>
    80203e6e:	842a                	mv	s0,a0
    80203e70:	fd1c                	sd	a5,56(a0)
    80203e72:	00053823          	sd	zero,16(a0)
    80203e76:	02052823          	sw	zero,48(a0)
    80203e7a:	04053023          	sd	zero,64(a0)
        lock.init("inode");
    80203e7e:	0000e597          	auipc	a1,0xe
    80203e82:	a4258593          	addi	a1,a1,-1470 # 802118c0 <initcode_end+0x178>
    80203e86:	0561                	addi	a0,a0,24
    80203e88:	35f010ef          	jal	802059e6 <_ZN5Mutex4initEPKc>
                    ip->fs = fs;
    80203e8c:	058ab603          	ld	a2,88(s5)
                    ip->dev = dev;
    80203e90:	008aa683          	lw	a3,8(s5)
                    ip->type = (de.attr & ATTR_DIRECTORY) ? T_DIR : T_FILE;
    80203e94:	01b14783          	lbu	a5,27(sp)
    80203e98:	00011597          	auipc	a1,0x11
    80203e9c:	b0858593          	addi	a1,a1,-1272 # 802149a0 <_ZTV10FAT32Inode+0x10>
    80203ea0:	e00c                	sd	a1,0(s0)
                    ip->fs = fs;
    80203ea2:	ec30                	sd	a2,88(s0)
                    ip->dev = dev;
    80203ea4:	c414                	sw	a3,8(s0)
                    ip->type = (de.attr & ATTR_DIRECTORY) ? T_DIR : T_FILE;
    80203ea6:	8bc1                	andi	a5,a5,16
    80203ea8:	e399                	bnez	a5,80203eae <_ZN10FAT32Inode6lookupEPKc+0x182>
    80203eaa:	4789                	li	a5,2
    80203eac:	e43e                	sd	a5,8(sp)
                    ip->first_clus = (de.fstClusHI << 16) | de.fstClusLO;
    80203eae:	02415783          	lhu	a5,36(sp)
    80203eb2:	02a15583          	lhu	a1,42(sp)
                    ip->size = de.fileSize;
    80203eb6:	5632                	lw	a2,44(sp)
                    ip->first_clus = (de.fstClusHI << 16) | de.fstClusLO;
    80203eb8:	0107979b          	slliw	a5,a5,0x10
                    ip->type = (de.attr & ATTR_DIRECTORY) ? T_DIR : T_FILE;
    80203ebc:	6722                	ld	a4,8(sp)
                    ip->first_clus = (de.fstClusHI << 16) | de.fstClusLO;
    80203ebe:	8fcd                	or	a5,a5,a1
                    ip->ref_cnt = 1;
    80203ec0:	4685                	li	a3,1
                    ip->first_clus = (de.fstClusHI << 16) | de.fstClusLO;
    80203ec2:	2781                	sext.w	a5,a5
                    ip->ref_cnt = 1;
    80203ec4:	1682                	slli	a3,a3,0x20
                    ip->first_clus = (de.fstClusHI << 16) | de.fstClusLO;
    80203ec6:	d03c                	sw	a5,96(s0)
                    ip->inum = ip->first_clus;
    80203ec8:	c45c                	sw	a5,12(s0)
                    ip->ref_cnt = 1;
    80203eca:	0685                	addi	a3,a3,1
                    ip->nlink = 1;
    80203ecc:	4785                	li	a5,1
                    ip->ent_sec = current_sec; // Log Sector
    80203ece:	07842623          	sw	s8,108(s0)
                    ip->ent_off = off;         // Log Setoff
    80203ed2:	07b42823          	sw	s11,112(s0)
                    BufferCache::brelse(b);
    80203ed6:	855a                	mv	a0,s6
                    ip->type = (de.attr & ATTR_DIRECTORY) ? T_DIR : T_FILE;
    80203ed8:	04e41423          	sh	a4,72(s0)
                    ip->size = de.fileSize;
    80203edc:	c830                	sw	a2,80(s0)
                    ip->nlink = 1;
    80203ede:	04f41723          	sh	a5,78(s0)
                    ip->ref_cnt = 1;
    80203ee2:	e814                	sd	a3,16(s0)
                    BufferCache::brelse(b);
    80203ee4:	6f2040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
}
    80203ee8:	60ea                	ld	ra,152(sp)
    80203eea:	8522                	mv	a0,s0
    80203eec:	644a                	ld	s0,144(sp)
                    return ip;
    80203eee:	64aa                	ld	s1,136(sp)
    80203ef0:	690a                	ld	s2,128(sp)
    80203ef2:	79e6                	ld	s3,120(sp)
    80203ef4:	7a46                	ld	s4,112(sp)
    80203ef6:	7aa6                	ld	s5,104(sp)
    80203ef8:	7b06                	ld	s6,96(sp)
    80203efa:	6be6                	ld	s7,88(sp)
    80203efc:	6c46                	ld	s8,80(sp)
    80203efe:	6ca6                	ld	s9,72(sp)
    80203f00:	6d06                	ld	s10,64(sp)
    80203f02:	7de2                	ld	s11,56(sp)
}
    80203f04:	610d                	addi	sp,sp,160
    80203f06:	8082                	ret
    80203f08:	7aa6                	ld	s5,104(sp)
    80203f0a:	6d06                	ld	s10,64(sp)
    80203f0c:	bf2d                	j	80203e46 <_ZN10FAT32Inode6lookupEPKc+0x11a>

0000000080203f0e <_ZN15FAT32FileSystem17cluster_to_sectorEj>:
    return data_start_sector + (cluster - 2) * sectors_per_cluster;
    80203f0e:	495c                	lw	a5,20(a0)
    80203f10:	35f9                	addiw	a1,a1,-2
    80203f12:	4548                	lw	a0,12(a0)
    80203f14:	02f585bb          	mulw	a1,a1,a5
}
    80203f18:	9d2d                	addw	a0,a0,a1
    80203f1a:	8082                	ret

0000000080203f1c <_ZN15FAT32FileSystem12next_clusterEj>:
{
    80203f1c:	1101                	addi	sp,sp,-32
    uint32 fat_sector = fat_start_sector + (fat_offset / 512);
    80203f1e:	451c                	lw	a5,8(a0)
{
    80203f20:	e426                	sd	s1,8(sp)
    uint32 fat_offset = cluster * 4;
    80203f22:	0025949b          	slliw	s1,a1,0x2
{
    80203f26:	e822                	sd	s0,16(sp)
    uint32 fat_sector = fat_start_sector + (fat_offset / 512);
    80203f28:	0094d41b          	srliw	s0,s1,0x9
    80203f2c:	9c3d                	addw	s0,s0,a5
    struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    80203f2e:	0014559b          	srliw	a1,s0,0x1
    uint32 block_offset = (fat_sector % 2) * 512 + ent_offset;
    80203f32:	8805                	andi	s0,s0,1
    uint32 ent_offset = fat_offset % 512;
    80203f34:	1ff4f493          	andi	s1,s1,511
    struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    80203f38:	4501                	li	a0,0
    uint32 block_offset = (fat_sector % 2) * 512 + ent_offset;
    80203f3a:	0426                	slli	s0,s0,0x9
{
    80203f3c:	ec06                	sd	ra,24(sp)
    uint32 next = *(uint32 *)(b->data + block_offset);
    80203f3e:	9426                	add	s0,s0,s1
    struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    80203f40:	580040ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
    uint32 next = *(uint32 *)(b->data + block_offset);
    80203f44:	008507b3          	add	a5,a0,s0
    80203f48:	5780                	lw	s0,40(a5)
    BufferCache::brelse(b);
    80203f4a:	68c040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
}
    80203f4e:	60e2                	ld	ra,24(sp)
    return next & 0x0FFFFFFF;
    80203f50:	02441513          	slli	a0,s0,0x24
}
    80203f54:	6442                	ld	s0,16(sp)
    80203f56:	64a2                	ld	s1,8(sp)
    80203f58:	9111                	srli	a0,a0,0x24
    80203f5a:	6105                	addi	sp,sp,32
    80203f5c:	8082                	ret

0000000080203f5e <_ZN15FAT32FileSystem13alloc_clusterEv>:
    for (uint32 i = 0; i < fat_sz; i++)
    80203f5e:	4d5c                	lw	a5,28(a0)
{
    80203f60:	715d                	addi	sp,sp,-80
    80203f62:	e486                	sd	ra,72(sp)
    80203f64:	f052                	sd	s4,32(sp)
    for (uint32 i = 0; i < fat_sz; i++)
    80203f66:	cbb5                	beqz	a5,80203fda <_ZN15FAT32FileSystem13alloc_clusterEv+0x7c>
            if ((table[j] & 0x0FFFFFFF) == 0)
    80203f68:	10000a37          	lui	s4,0x10000
    80203f6c:	f84a                	sd	s2,48(sp)
    80203f6e:	f44e                	sd	s3,40(sp)
    80203f70:	ec56                	sd	s5,24(sp)
    80203f72:	e85a                	sd	s6,16(sp)
    80203f74:	e0a2                	sd	s0,64(sp)
    80203f76:	fc26                	sd	s1,56(sp)
    80203f78:	e45e                	sd	s7,8(sp)
    80203f7a:	892a                	mv	s2,a0
    for (uint32 i = 0; i < fat_sz; i++)
    80203f7c:	4981                	li	s3,0
            if (i == 0 && j < 2)
    80203f7e:	4b05                	li	s6,1
            if ((table[j] & 0x0FFFFFFF) == 0)
    80203f80:	1a7d                	addi	s4,s4,-1 # fffffff <_start-0x70200001>
        for(uint32 j = 0; j <  fat_entries_per_sector; j++)
    80203f82:	08000a93          	li	s5,128
        uint32 current_fat_sec = fat_start_sector + i;
    80203f86:	00892403          	lw	s0,8(s2)
        struct Buf *b = BufferCache::bread(0, current_fat_sec / 2);
    80203f8a:	4501                	li	a0,0
        for(uint32 j = 0; j <  fat_entries_per_sector; j++)
    80203f8c:	4481                	li	s1,0
        uint32 current_fat_sec = fat_start_sector + i;
    80203f8e:	0134043b          	addw	s0,s0,s3
        struct Buf *b = BufferCache::bread(0, current_fat_sec / 2);
    80203f92:	0014559b          	srliw	a1,s0,0x1
    80203f96:	52a040ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
        uint32 *table = (uint32 *)(b->data + (current_fat_sec % 2) * 512);
    80203f9a:	00147793          	andi	a5,s0,1
    80203f9e:	07a6                	slli	a5,a5,0x9
    80203fa0:	02878793          	addi	a5,a5,40
        struct Buf *b = BufferCache::bread(0, current_fat_sec / 2);
    80203fa4:	8baa                	mv	s7,a0
        for(uint32 j = 0; j <  fat_entries_per_sector; j++)
    80203fa6:	97aa                	add	a5,a5,a0
            if (i == 0 && j < 2)
    80203fa8:	04098363          	beqz	s3,80203fee <_ZN15FAT32FileSystem13alloc_clusterEv+0x90>
            if ((table[j] & 0x0FFFFFFF) == 0)
    80203fac:	4380                	lw	s0,0(a5)
    80203fae:	01447433          	and	s0,s0,s4
    80203fb2:	c421                	beqz	s0,80203ffa <_ZN15FAT32FileSystem13alloc_clusterEv+0x9c>
        for(uint32 j = 0; j <  fat_entries_per_sector; j++)
    80203fb4:	2485                	addiw	s1,s1,1
    80203fb6:	0791                	addi	a5,a5,4
    80203fb8:	ff5498e3          	bne	s1,s5,80203fa8 <_ZN15FAT32FileSystem13alloc_clusterEv+0x4a>
        BufferCache::brelse(b);
    80203fbc:	855e                	mv	a0,s7
    80203fbe:	618040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
    for (uint32 i = 0; i < fat_sz; i++)
    80203fc2:	01c92783          	lw	a5,28(s2)
    80203fc6:	2985                	addiw	s3,s3,1
    80203fc8:	faf9efe3          	bltu	s3,a5,80203f86 <_ZN15FAT32FileSystem13alloc_clusterEv+0x28>
    80203fcc:	6406                	ld	s0,64(sp)
    80203fce:	74e2                	ld	s1,56(sp)
    80203fd0:	7942                	ld	s2,48(sp)
    80203fd2:	79a2                	ld	s3,40(sp)
    80203fd4:	6ae2                	ld	s5,24(sp)
    80203fd6:	6b42                	ld	s6,16(sp)
    80203fd8:	6ba2                	ld	s7,8(sp)
    Drivers::uart_puts("[FAT32] Out of space!\n");
    80203fda:	0000e517          	auipc	a0,0xe
    80203fde:	8fe50513          	addi	a0,a0,-1794 # 802118d8 <initcode_end+0x190>
    80203fe2:	589040ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
    return 0;
    80203fe6:	4a01                	li	s4,0
    80203fe8:	a061                	j	80204070 <_ZN15FAT32FileSystem13alloc_clusterEv+0x112>
        for(uint32 j = 0; j <  fat_entries_per_sector; j++)
    80203fea:	2485                	addiw	s1,s1,1
    80203fec:	0791                	addi	a5,a5,4
            if (i == 0 && j < 2)
    80203fee:	fe9b7ee3          	bgeu	s6,s1,80203fea <_ZN15FAT32FileSystem13alloc_clusterEv+0x8c>
            if ((table[j] & 0x0FFFFFFF) == 0)
    80203ff2:	4380                	lw	s0,0(a5)
    80203ff4:	01447433          	and	s0,s0,s4
    80203ff8:	fc55                	bnez	s0,80203fb4 <_ZN15FAT32FileSystem13alloc_clusterEv+0x56>
                table[j] = 0x0FFFFFFF;
    80203ffa:	0147a023          	sw	s4,0(a5)
                BufferCache::bwrite(b); // Write back to disk
    80203ffe:	855e                	mv	a0,s7
    80204000:	5a2040ef          	jal	802085a2 <_ZN11BufferCache6bwriteEP3Buf>
                BufferCache::brelse(b);
    80204004:	855e                	mv	a0,s7
    80204006:	5d0040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
    return data_start_sector + (cluster - 2) * sectors_per_cluster;
    8020400a:	01492783          	lw	a5,20(s2)
                uint32 cluster_idx = i * fat_entries_per_sector + j;
    8020400e:	0079999b          	slliw	s3,s3,0x7
    80204012:	00998a3b          	addw	s4,s3,s1
    return data_start_sector + (cluster - 2) * sectors_per_cluster;
    80204016:	ffea0a9b          	addiw	s5,s4,-2
    8020401a:	02fa8abb          	mulw	s5,s5,a5
    8020401e:	00c92703          	lw	a4,12(s2)
    80204022:	00ea8abb          	addw	s5,s5,a4
                for (uint32 k = 0; k < sectors_per_cluster; k++)
    80204026:	cf95                	beqz	a5,80204062 <_ZN15FAT32FileSystem13alloc_clusterEv+0x104>
                    struct Buf *db = BufferCache::bread(0, (data_sec + k) / 2);
    80204028:	008a84bb          	addw	s1,s5,s0
    8020402c:	0014d59b          	srliw	a1,s1,0x1
    80204030:	4501                	li	a0,0
    80204032:	48e040ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
                    memset(db->data + ((data_sec + k) % 2) * 512, 0, 512);
    80204036:	8885                	andi	s1,s1,1
                    struct Buf *db = BufferCache::bread(0, (data_sec + k) / 2);
    80204038:	89aa                	mv	s3,a0
                    memset(db->data + ((data_sec + k) % 2) * 512, 0, 512);
    8020403a:	04a6                	slli	s1,s1,0x9
    8020403c:	02850513          	addi	a0,a0,40
    80204040:	20000613          	li	a2,512
    80204044:	4581                	li	a1,0
    80204046:	9526                	add	a0,a0,s1
    80204048:	5e3000ef          	jal	80204e2a <_Z6memsetPvij>
                    BufferCache::bwrite(db);
    8020404c:	854e                	mv	a0,s3
    8020404e:	554040ef          	jal	802085a2 <_ZN11BufferCache6bwriteEP3Buf>
                    BufferCache::brelse(db);
    80204052:	854e                	mv	a0,s3
    80204054:	582040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
                for (uint32 k = 0; k < sectors_per_cluster; k++)
    80204058:	01492783          	lw	a5,20(s2)
    8020405c:	2405                	addiw	s0,s0,1
    8020405e:	fcf465e3          	bltu	s0,a5,80204028 <_ZN15FAT32FileSystem13alloc_clusterEv+0xca>
    80204062:	6406                	ld	s0,64(sp)
    80204064:	74e2                	ld	s1,56(sp)
    80204066:	7942                	ld	s2,48(sp)
    80204068:	79a2                	ld	s3,40(sp)
    8020406a:	6ae2                	ld	s5,24(sp)
    8020406c:	6b42                	ld	s6,16(sp)
    8020406e:	6ba2                	ld	s7,8(sp)
}
    80204070:	60a6                	ld	ra,72(sp)
    80204072:	8552                	mv	a0,s4
    80204074:	7a02                	ld	s4,32(sp)
    80204076:	6161                	addi	sp,sp,80
    80204078:	8082                	ret

000000008020407a <_ZN10FAT32Inode5writeEPKcjji>:
    if (off > size)
    8020407a:	493c                	lw	a5,80(a0)
{
    8020407c:	7175                	addi	sp,sp,-144
    8020407e:	e506                	sd	ra,136(sp)
    80204080:	ecd6                	sd	s5,88(sp)
    80204082:	ec32                	sd	a2,24(sp)
    80204084:	e03a                	sd	a4,0(sp)
    if (off > size)
    80204086:	08c7e663          	bltu	a5,a2,80204112 <_ZN10FAT32Inode5writeEPKcjji+0x98>
    8020408a:	f0d2                	sd	s4,96(sp)
    8020408c:	8a2a                	mv	s4,a0
    8020408e:	e122                	sd	s0,128(sp)
    uint32 clus_sz = fs->bytes_per_cluster;
    80204090:	6d28                	ld	a0,88(a0)
    uint32 clus = first_clus;
    80204092:	060a2403          	lw	s0,96(s4)
    80204096:	e4de                	sd	s7,72(sp)
    80204098:	e0e2                	sd	s8,64(sp)
    8020409a:	fc66                	sd	s9,56(sp)
    8020409c:	8bae                	mv	s7,a1
    uint32 clus_sz = fs->bytes_per_cluster;
    8020409e:	01852c83          	lw	s9,24(a0)
    802040a2:	8c36                	mv	s8,a3
    if (clus == 0)
    802040a4:	1a040f63          	beqz	s0,80204262 <_ZN10FAT32Inode5writeEPKcjji+0x1e8>
    802040a8:	fca6                	sd	s1,120(sp)
    802040aa:	f8ca                	sd	s2,112(sp)
    802040ac:	f4ce                	sd	s3,104(sp)
    uint32 skip = off / clus_sz;
    802040ae:	67e2                	ld	a5,24(sp)
    802040b0:	0397dabb          	divuw	s5,a5,s9
    while (skip > 0)
    802040b4:	0797e563          	bltu	a5,s9,8020411e <_ZN10FAT32Inode5writeEPKcjji+0xa4>
        if (clus >= 0x0FFFFFF8)
    802040b8:	10000937          	lui	s2,0x10000
    return next & 0x0FFFFFFF;
    802040bc:	100009b7          	lui	s3,0x10000
    802040c0:	19fd                	addi	s3,s3,-1 # fffffff <_start-0x70200001>
        if (clus >= 0x0FFFFFF8)
    802040c2:	195d                	addi	s2,s2,-9 # ffffff7 <_start-0x70200009>
    802040c4:	a019                	j	802040ca <_ZN10FAT32Inode5writeEPKcjji+0x50>
    while (skip > 0)
    802040c6:	040a8c63          	beqz	s5,8020411e <_ZN10FAT32Inode5writeEPKcjji+0xa4>
    uint32 fat_sector = fat_start_sector + (fat_offset / 512);
    802040ca:	058a3783          	ld	a5,88(s4)
    uint32 fat_offset = cluster * 4;
    802040ce:	0024141b          	slliw	s0,s0,0x2
    uint32 fat_sector = fat_start_sector + (fat_offset / 512);
    802040d2:	0094549b          	srliw	s1,s0,0x9
    802040d6:	479c                	lw	a5,8(a5)
    uint32 ent_offset = fat_offset % 512;
    802040d8:	1ff47413          	andi	s0,s0,511
    struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    802040dc:	4501                	li	a0,0
    uint32 fat_sector = fat_start_sector + (fat_offset / 512);
    802040de:	9cbd                	addw	s1,s1,a5
    struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    802040e0:	0014d59b          	srliw	a1,s1,0x1
    uint32 block_offset = (fat_sector % 2) * 512 + ent_offset;
    802040e4:	8885                	andi	s1,s1,1
    802040e6:	04a6                	slli	s1,s1,0x9
    struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    802040e8:	3d8040ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
    uint32 next = *(uint32 *)(b->data + block_offset);
    802040ec:	94a2                	add	s1,s1,s0
    802040ee:	009507b3          	add	a5,a0,s1
    802040f2:	5780                	lw	s0,40(a5)
        skip--;
    802040f4:	3afd                	addiw	s5,s5,-1
    BufferCache::brelse(b);
    802040f6:	4e0040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
    return next & 0x0FFFFFFF;
    802040fa:	01347433          	and	s0,s0,s3
        if (clus >= 0x0FFFFFF8)
    802040fe:	fc8974e3          	bgeu	s2,s0,802040c6 <_ZN10FAT32Inode5writeEPKcjji+0x4c>
    80204102:	640a                	ld	s0,128(sp)
    80204104:	74e6                	ld	s1,120(sp)
    80204106:	7946                	ld	s2,112(sp)
    80204108:	79a6                	ld	s3,104(sp)
    8020410a:	7a06                	ld	s4,96(sp)
    8020410c:	6ba6                	ld	s7,72(sp)
    8020410e:	6c06                	ld	s8,64(sp)
    80204110:	7ce2                	ld	s9,56(sp)
        return -1;
    80204112:	5afd                	li	s5,-1
}
    80204114:	60aa                	ld	ra,136(sp)
    80204116:	8556                	mv	a0,s5
    80204118:	6ae6                	ld	s5,88(sp)
    8020411a:	6149                	addi	sp,sp,144
    8020411c:	8082                	ret
    while (tot < n)
    8020411e:	1c0c0263          	beqz	s8,802042e2 <_ZN10FAT32Inode5writeEPKcjji+0x268>
    uint32 current_off = off % clus_sz;
    80204122:	67e2                	ld	a5,24(sp)
            if (next >= 0x0FFFFFF8)
    80204124:	10000737          	lui	a4,0x10000
    80204128:	e8da                	sd	s6,80(sp)
    uint32 current_off = off % clus_sz;
    8020412a:	0397f9bb          	remuw	s3,a5,s9
    return next & 0x0FFFFFFF;
    8020412e:	100007b7          	lui	a5,0x10000
    80204132:	17fd                	addi	a5,a5,-1 # fffffff <_start-0x70200001>
    80204134:	e43e                	sd	a5,8(sp)
            if (next >= 0x0FFFFFF8)
    80204136:	ff770793          	addi	a5,a4,-9 # ffffff7 <_start-0x70200009>
    8020413a:	f86a                	sd	s10,48(sp)
    8020413c:	f46e                	sd	s11,40(sp)
    uint32 tot = 0;
    8020413e:	4a81                	li	s5,0
            if (next >= 0x0FFFFFF8)
    80204140:	e83e                	sd	a5,16(sp)
    80204142:	a815                	j	80204176 <_ZN10FAT32Inode5writeEPKcjji+0xfc>
            if (VM::copyin(myproc()->pagetable, (char *)(b->data + block_offset), (uint64)src, m) < 0)
    80204144:	13f010ef          	jal	80205a82 <_Z6myprocv>
    80204148:	7d28                	ld	a0,120(a0)
    8020414a:	02890593          	addi	a1,s2,40
    8020414e:	86a6                	mv	a3,s1
    80204150:	865e                	mv	a2,s7
    80204152:	95ee                	add	a1,a1,s11
    80204154:	32c020ef          	jal	80206480 <_ZN2VM6copyinEPyPcyy>
    80204158:	16054563          	bltz	a0,802042c2 <_ZN10FAT32Inode5writeEPKcjji+0x248>
        BufferCache::bwrite(b);
    8020415c:	854a                	mv	a0,s2
    8020415e:	444040ef          	jal	802085a2 <_ZN11BufferCache6bwriteEP3Buf>
        BufferCache::brelse(b);
    80204162:	854a                	mv	a0,s2
        tot += m;
    80204164:	015b0abb          	addw	s5,s6,s5
        BufferCache::brelse(b);
    80204168:	46e040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
        src += m;
    8020416c:	9ba6                	add	s7,s7,s1
        current_off += m;
    8020416e:	013b09bb          	addw	s3,s6,s3
    while (tot < n)
    80204172:	118af863          	bgeu	s5,s8,80204282 <_ZN10FAT32Inode5writeEPKcjji+0x208>
            uint32 next = fs->next_cluster(clus);
    80204176:	058a3783          	ld	a5,88(s4)
        if (current_off == clus_sz)
    8020417a:	073c8463          	beq	s9,s3,802041e2 <_ZN10FAT32Inode5writeEPKcjji+0x168>
        uint32 off_in_sec = current_off % 512;
    8020417e:	1ff9fd93          	andi	s11,s3,511
        uint32 m = 512 - off_in_sec;
    80204182:	20000713          	li	a4,512
        uint32 sec_in_clus = current_off / 512;
    80204186:	0099d51b          	srliw	a0,s3,0x9
        uint32 m = 512 - off_in_sec;
    8020418a:	41b705bb          	subw	a1,a4,s11
    return data_start_sector + (cluster - 2) * sectors_per_cluster;
    8020418e:	4bd8                	lw	a4,20(a5)
    80204190:	ffe4049b          	addiw	s1,s0,-2
        uint32 sec = fs->cluster_to_sector(clus) + sec_in_clus;
    80204194:	47d4                	lw	a3,12(a5)
    return data_start_sector + (cluster - 2) * sectors_per_cluster;
    80204196:	02e487bb          	mulw	a5,s1,a4
        if (n - tot < m)
    8020419a:	415c0d3b          	subw	s10,s8,s5
        uint32 sec = fs->cluster_to_sector(clus) + sec_in_clus;
    8020419e:	9ea9                	addw	a3,a3,a0
        if (n - tot < m)
    802041a0:	000d051b          	sext.w	a0,s10
        uint32 sec = fs->cluster_to_sector(clus) + sec_in_clus;
    802041a4:	00d784bb          	addw	s1,a5,a3
        if (n - tot < m)
    802041a8:	00a5f363          	bgeu	a1,a0,802041ae <_ZN10FAT32Inode5writeEPKcjji+0x134>
    802041ac:	8d2e                	mv	s10,a1
        struct Buf *b = BufferCache::bread(dev, sec / 2);
    802041ae:	008a2503          	lw	a0,8(s4)
    802041b2:	0014d59b          	srliw	a1,s1,0x1
        if (n - tot < m)
    802041b6:	000d0b1b          	sext.w	s6,s10
        struct Buf *b = BufferCache::bread(dev, sec / 2);
    802041ba:	306040ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
        uint32 block_offset = (sec % 2) * 512 + off_in_sec;
    802041be:	0014f793          	andi	a5,s1,1
    802041c2:	07a6                	slli	a5,a5,0x9
            if (VM::copyin(myproc()->pagetable, (char *)(b->data + block_offset), (uint64)src, m) < 0)
    802041c4:	9dbe                	add	s11,s11,a5
        if (isUser)
    802041c6:	6782                	ld	a5,0(sp)
            if (VM::copyin(myproc()->pagetable, (char *)(b->data + block_offset), (uint64)src, m) < 0)
    802041c8:	020d1493          	slli	s1,s10,0x20
        struct Buf *b = BufferCache::bread(dev, sec / 2);
    802041cc:	892a                	mv	s2,a0
            if (VM::copyin(myproc()->pagetable, (char *)(b->data + block_offset), (uint64)src, m) < 0)
    802041ce:	9081                	srli	s1,s1,0x20
        if (isUser)
    802041d0:	fbb5                	bnez	a5,80204144 <_ZN10FAT32Inode5writeEPKcjji+0xca>
            memmove(b->data + block_offset, src, m);
    802041d2:	02850513          	addi	a0,a0,40
    802041d6:	865a                	mv	a2,s6
    802041d8:	85de                	mv	a1,s7
    802041da:	956e                	add	a0,a0,s11
    802041dc:	499000ef          	jal	80204e74 <_Z7memmovePvPKvj>
    802041e0:	bfb5                	j	8020415c <_ZN10FAT32Inode5writeEPKcjji+0xe2>
    uint32 fat_sector = fat_start_sector + (fat_offset / 512);
    802041e2:	479c                	lw	a5,8(a5)
    uint32 fat_offset = cluster * 4;
    802041e4:	0024191b          	slliw	s2,s0,0x2
    uint32 fat_sector = fat_start_sector + (fat_offset / 512);
    802041e8:	0099549b          	srliw	s1,s2,0x9
    802041ec:	00f4843b          	addw	s0,s1,a5
    struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    802041f0:	0014559b          	srliw	a1,s0,0x1
    uint32 block_offset = (fat_sector % 2) * 512 + ent_offset;
    802041f4:	8805                	andi	s0,s0,1
    struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    802041f6:	4501                	li	a0,0
    uint32 ent_offset = fat_offset % 512;
    802041f8:	1fc97913          	andi	s2,s2,508
    uint32 block_offset = (fat_sector % 2) * 512 + ent_offset;
    802041fc:	0426                	slli	s0,s0,0x9
    struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    802041fe:	2c2040ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
    uint32 next = *(uint32 *)(b->data + block_offset);
    80204202:	944a                	add	s0,s0,s2
    80204204:	008507b3          	add	a5,a0,s0
    80204208:	5780                	lw	s0,40(a5)
    BufferCache::brelse(b);
    8020420a:	3cc040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
    return next & 0x0FFFFFFF;
    8020420e:	67a2                	ld	a5,8(sp)
    80204210:	8c7d                	and	s0,s0,a5
            if (next >= 0x0FFFFFF8)
    80204212:	67c2                	ld	a5,16(sp)
    80204214:	0087ea63          	bltu	a5,s0,80204228 <_ZN10FAT32Inode5writeEPKcjji+0x1ae>
    80204218:	058a3783          	ld	a5,88(s4)
    8020421c:	20000593          	li	a1,512
    80204220:	4d81                	li	s11,0
    80204222:	4501                	li	a0,0
            current_off = 0;
    80204224:	4981                	li	s3,0
    80204226:	b7a5                	j	8020418e <_ZN10FAT32Inode5writeEPKcjji+0x114>
                uint32 new_clus = fs->alloc_cluster();
    80204228:	058a3503          	ld	a0,88(s4)
    8020422c:	d33ff0ef          	jal	80203f5e <_ZN15FAT32FileSystem13alloc_clusterEv>
    80204230:	0005041b          	sext.w	s0,a0
                if (new_clus == 0)
    80204234:	c84d                	beqz	s0,802042e6 <_ZN10FAT32Inode5writeEPKcjji+0x26c>
                uint32 fat_sec = fs->fat_start_sector + (fat_offset / 512);
    80204236:	058a3783          	ld	a5,88(s4)
                struct Buf *fat_b = BufferCache::bread(dev, fat_sec / 2);
    8020423a:	008a2503          	lw	a0,8(s4)
                uint32 fat_sec = fs->fat_start_sector + (fat_offset / 512);
    8020423e:	479c                	lw	a5,8(a5)
    80204240:	9cbd                	addw	s1,s1,a5
                struct Buf *fat_b = BufferCache::bread(dev, fat_sec / 2);
    80204242:	0014d59b          	srliw	a1,s1,0x1
                uint32 *entry = (uint32 *)(fat_b->data + (fat_sec % 2) * 512 + (fat_offset % 512));
    80204246:	8885                	andi	s1,s1,1
                struct Buf *fat_b = BufferCache::bread(dev, fat_sec / 2);
    80204248:	278040ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
                uint32 *entry = (uint32 *)(fat_b->data + (fat_sec % 2) * 512 + (fat_offset % 512));
    8020424c:	04a6                	slli	s1,s1,0x9
                *entry = new_clus; // Link
    8020424e:	94aa                	add	s1,s1,a0
    80204250:	94ca                	add	s1,s1,s2
    80204252:	d480                	sw	s0,40(s1)
                struct Buf *fat_b = BufferCache::bread(dev, fat_sec / 2);
    80204254:	89aa                	mv	s3,a0
                BufferCache::bwrite(fat_b);
    80204256:	34c040ef          	jal	802085a2 <_ZN11BufferCache6bwriteEP3Buf>
                BufferCache::brelse(fat_b);
    8020425a:	854e                	mv	a0,s3
    8020425c:	37a040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
                clus = new_clus;
    80204260:	bf65                	j	80204218 <_ZN10FAT32Inode5writeEPKcjji+0x19e>
        clus = fs->alloc_cluster();
    80204262:	cfdff0ef          	jal	80203f5e <_ZN15FAT32FileSystem13alloc_clusterEv>
    80204266:	0005041b          	sext.w	s0,a0
        if (clus == 0)
    8020426a:	c059                	beqz	s0,802042f0 <_ZN10FAT32Inode5writeEPKcjji+0x276>
        update();
    8020426c:	000a3783          	ld	a5,0(s4)
    80204270:	fca6                	sd	s1,120(sp)
    80204272:	f8ca                	sd	s2,112(sp)
    80204274:	6b9c                	ld	a5,16(a5)
    80204276:	f4ce                	sd	s3,104(sp)
        first_clus = clus;
    80204278:	068a2023          	sw	s0,96(s4)
        update();
    8020427c:	8552                	mv	a0,s4
    8020427e:	9782                	jalr	a5
    80204280:	b53d                	j	802040ae <_ZN10FAT32Inode5writeEPKcjji+0x34>
    80204282:	6b46                	ld	s6,80(sp)
    80204284:	7d42                	ld	s10,48(sp)
    80204286:	7da2                	ld	s11,40(sp)
    if (off + n > size)
    80204288:	67e2                	ld	a5,24(sp)
    8020428a:	050a2683          	lw	a3,80(s4)
    8020428e:	0187873b          	addw	a4,a5,s8
    80204292:	87ba                	mv	a5,a4
    80204294:	00e6ef63          	bltu	a3,a4,802042b2 <_ZN10FAT32Inode5writeEPKcjji+0x238>
    80204298:	640a                	ld	s0,128(sp)
}
    8020429a:	60aa                	ld	ra,136(sp)
    8020429c:	74e6                	ld	s1,120(sp)
    8020429e:	7946                	ld	s2,112(sp)
    802042a0:	79a6                	ld	s3,104(sp)
    802042a2:	7a06                	ld	s4,96(sp)
    802042a4:	6ba6                	ld	s7,72(sp)
    802042a6:	6c06                	ld	s8,64(sp)
    802042a8:	7ce2                	ld	s9,56(sp)
    802042aa:	8556                	mv	a0,s5
    802042ac:	6ae6                	ld	s5,88(sp)
    802042ae:	6149                	addi	sp,sp,144
    802042b0:	8082                	ret
        update();
    802042b2:	000a3703          	ld	a4,0(s4)
        size = off + n;
    802042b6:	04fa2823          	sw	a5,80(s4)
        update();
    802042ba:	8552                	mv	a0,s4
    802042bc:	6b1c                	ld	a5,16(a4)
    802042be:	9782                	jalr	a5
    return tot;
    802042c0:	bfe1                	j	80204298 <_ZN10FAT32Inode5writeEPKcjji+0x21e>
                BufferCache::brelse(b);
    802042c2:	854a                	mv	a0,s2
    802042c4:	312040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
        return -1;
    802042c8:	5afd                	li	s5,-1
                BufferCache::brelse(b);
    802042ca:	640a                	ld	s0,128(sp)
    802042cc:	74e6                	ld	s1,120(sp)
    802042ce:	7946                	ld	s2,112(sp)
    802042d0:	79a6                	ld	s3,104(sp)
    802042d2:	7a06                	ld	s4,96(sp)
    802042d4:	6b46                	ld	s6,80(sp)
    802042d6:	6ba6                	ld	s7,72(sp)
    802042d8:	6c06                	ld	s8,64(sp)
    802042da:	7ce2                	ld	s9,56(sp)
    802042dc:	7d42                	ld	s10,48(sp)
    802042de:	7da2                	ld	s11,40(sp)
    802042e0:	bd15                	j	80204114 <_ZN10FAT32Inode5writeEPKcjji+0x9a>
    while (tot < n)
    802042e2:	4a81                	li	s5,0
    802042e4:	b755                	j	80204288 <_ZN10FAT32Inode5writeEPKcjji+0x20e>
    802042e6:	6b46                	ld	s6,80(sp)
    802042e8:	7d42                	ld	s10,48(sp)
    802042ea:	7da2                	ld	s11,40(sp)
    return tot;
    802042ec:	2a81                	sext.w	s5,s5
    802042ee:	bf69                	j	80204288 <_ZN10FAT32Inode5writeEPKcjji+0x20e>
    802042f0:	640a                	ld	s0,128(sp)
    802042f2:	7a06                	ld	s4,96(sp)
    802042f4:	6ba6                	ld	s7,72(sp)
    802042f6:	6c06                	ld	s8,64(sp)
    802042f8:	7ce2                	ld	s9,56(sp)
        return -1;
    802042fa:	5afd                	li	s5,-1
    802042fc:	bd21                	j	80204114 <_ZN10FAT32Inode5writeEPKcjji+0x9a>

00000000802042fe <_ZN10FAT32Inode6createEPKcsss>:
    Inode *exist = lookup(name);
    802042fe:	611c                	ld	a5,0(a0)
{
    80204300:	7115                	addi	sp,sp,-224
    80204302:	e5a6                	sd	s1,200(sp)
    Inode *exist = lookup(name);
    80204304:	779c                	ld	a5,40(a5)
{
    80204306:	fd4e                	sd	s3,184(sp)
    80204308:	f556                	sd	s5,168(sp)
    8020430a:	ed86                	sd	ra,216(sp)
    8020430c:	e032                	sd	a2,0(sp)
    8020430e:	84aa                	mv	s1,a0
    80204310:	8aae                	mv	s5,a1
    Inode *exist = lookup(name);
    80204312:	9782                	jalr	a5
    80204314:	89aa                	mv	s3,a0
    if (exist)
    80204316:	c901                	beqz	a0,80204326 <_ZN10FAT32Inode6createEPKcsss+0x28>
}
    80204318:	60ee                	ld	ra,216(sp)
    8020431a:	64ae                	ld	s1,200(sp)
    8020431c:	7aaa                	ld	s5,168(sp)
    8020431e:	854e                	mv	a0,s3
    80204320:	79ea                	ld	s3,184(sp)
    80204322:	612d                	addi	sp,sp,224
    80204324:	8082                	ret
    80204326:	f952                	sd	s4,176(sp)
    memset(&de, 0, sizeof(de));
    80204328:	01010a13          	addi	s4,sp,16
    8020432c:	02000613          	li	a2,32
    80204330:	4581                	li	a1,0
    80204332:	8552                	mv	a0,s4
    80204334:	2f7000ef          	jal	80204e2a <_Z6memsetPvij>
    memset(dst, ' ', 11);
    80204338:	462d                	li	a2,11
    8020433a:	02000593          	li	a1,32
    8020433e:	8552                	mv	a0,s4
    80204340:	2eb000ef          	jal	80204e2a <_Z6memsetPvij>
    for (; *src && *src != '.' && i < 8; src++)
    80204344:	000ac703          	lbu	a4,0(s5)
    80204348:	c359                	beqz	a4,802043ce <_ZN10FAT32Inode6createEPKcsss+0xd0>
    8020434a:	85d2                	mv	a1,s4
    8020434c:	008a8893          	addi	a7,s5,8
    80204350:	8652                	mv	a2,s4
    80204352:	87d6                	mv	a5,s5
    80204354:	02e00813          	li	a6,46
        if (c >= 'a' && c <= 'z')
    80204358:	4365                	li	t1,25
    8020435a:	a821                	j	80204372 <_ZN10FAT32Inode6createEPKcsss+0x74>
    for (; *src && *src != '.' && i < 8; src++)
    8020435c:	0785                	addi	a5,a5,1
        if (c >= 'a' && c <= 'z')
    8020435e:	00d36463          	bltu	t1,a3,80204366 <_ZN10FAT32Inode6createEPKcsss+0x68>
            c -= 32;
    80204362:	0ff57713          	zext.b	a4,a0
        dst[i++] = c;
    80204366:	00e60023          	sb	a4,0(a2)
    for (; *src && *src != '.' && i < 8; src++)
    8020436a:	0007c703          	lbu	a4,0(a5)
    8020436e:	0605                	addi	a2,a2,1
    80204370:	cf39                	beqz	a4,802043ce <_ZN10FAT32Inode6createEPKcsss+0xd0>
        if (c >= 'a' && c <= 'z')
    80204372:	f9f7069b          	addiw	a3,a4,-97
    80204376:	0ff6f693          	zext.b	a3,a3
            c -= 32;
    8020437a:	fe07051b          	addiw	a0,a4,-32
    for (; *src && *src != '.' && i < 8; src++)
    8020437e:	01070463          	beq	a4,a6,80204386 <_ZN10FAT32Inode6createEPKcsss+0x88>
    80204382:	fcf89de3          	bne	a7,a5,8020435c <_ZN10FAT32Inode6createEPKcsss+0x5e>
    while (*src && *src != '.')
    80204386:	0007c703          	lbu	a4,0(a5)
    8020438a:	02e00693          	li	a3,46
    8020438e:	c321                	beqz	a4,802043ce <_ZN10FAT32Inode6createEPKcsss+0xd0>
    80204390:	22d70663          	beq	a4,a3,802045bc <_ZN10FAT32Inode6createEPKcsss+0x2be>
    80204394:	0017c703          	lbu	a4,1(a5)
        src++;
    80204398:	0785                	addi	a5,a5,1
    while (*src && *src != '.')
    8020439a:	fb7d                	bnez	a4,80204390 <_ZN10FAT32Inode6createEPKcsss+0x92>
    for (; *src && i < 11; src++)
    8020439c:	0007c703          	lbu	a4,0(a5)
    802043a0:	c71d                	beqz	a4,802043ce <_ZN10FAT32Inode6createEPKcsss+0xd0>
    802043a2:	00378813          	addi	a6,a5,3
        if (c >= 'a' && c <= 'z')
    802043a6:	4565                	li	a0,25
    802043a8:	f9f7069b          	addiw	a3,a4,-97
    802043ac:	0ff6f693          	zext.b	a3,a3
    for (; *src && i < 11; src++)
    802043b0:	0785                	addi	a5,a5,1
            c -= 32;
    802043b2:	fe07061b          	addiw	a2,a4,-32
        if (c >= 'a' && c <= 'z')
    802043b6:	00d56463          	bltu	a0,a3,802043be <_ZN10FAT32Inode6createEPKcsss+0xc0>
            c -= 32;
    802043ba:	0ff67713          	zext.b	a4,a2
        dst[i++] = c;
    802043be:	00e58423          	sb	a4,8(a1)
    for (; *src && i < 11; src++)
    802043c2:	0007c703          	lbu	a4,0(a5)
    802043c6:	0585                	addi	a1,a1,1
    802043c8:	c319                	beqz	a4,802043ce <_ZN10FAT32Inode6createEPKcsss+0xd0>
    802043ca:	fcf81fe3          	bne	a6,a5,802043a8 <_ZN10FAT32Inode6createEPKcsss+0xaa>
    de.attr = (type == T_DIR) ? ATTR_DIRECTORY : ATTR_ARCHIVE;
    802043ce:	6702                	ld	a4,0(sp)
    802043d0:	4785                	li	a5,1
        new_dir_clus = fs->alloc_cluster();
    802043d2:	6ca8                	ld	a0,88(s1)
    de.attr = (type == T_DIR) ? ATTR_DIRECTORY : ATTR_ARCHIVE;
    802043d4:	1af70963          	beq	a4,a5,80204586 <_ZN10FAT32Inode6createEPKcsss+0x288>
    802043d8:	02000793          	li	a5,32
    802043dc:	e9a2                	sd	s0,208(sp)
    802043de:	e1ca                	sd	s2,192(sp)
    802043e0:	f15a                	sd	s6,160(sp)
    802043e2:	ed5e                	sd	s7,152(sp)
    802043e4:	e962                	sd	s8,144(sp)
    802043e6:	e566                	sd	s9,136(sp)
    802043e8:	e16a                	sd	s10,128(sp)
    802043ea:	fcee                	sd	s11,120(sp)
    802043ec:	00f10da3          	sb	a5,27(sp)
        de.fileSize = 0;
    802043f0:	d602                	sw	zero,44(sp)
    uint32 new_dir_clus = 0;
    802043f2:	e402                	sd	zero,8(sp)
    uint32 clus = first_clus;
    802043f4:	0604a903          	lw	s2,96(s1)
        if (next >= 0x0FFFFFF8)
    802043f8:	10000bb7          	lui	s7,0x10000
    return next & 0x0FFFFFFF;
    802043fc:	10000c37          	lui	s8,0x10000
                if (data[off] == 0x00 || data[off] == 0xE5)
    80204400:	0e500d93          	li	s11,229
    return next & 0x0FFFFFFF;
    80204404:	1c7d                	addi	s8,s8,-1 # fffffff <_start-0x70200001>
        if (next >= 0x0FFFFFF8)
    80204406:	1bdd                	addi	s7,s7,-9 # ffffff7 <_start-0x70200009>
    return data_start_sector + (cluster - 2) * sectors_per_cluster;
    80204408:	495c                	lw	a5,20(a0)
    8020440a:	ffe9041b          	addiw	s0,s2,-2
    8020440e:	4558                	lw	a4,12(a0)
    80204410:	02f4043b          	mulw	s0,s0,a5
    80204414:	9c39                	addw	s0,s0,a4
        for (uint32 i = 0; i < fs->sectors_per_cluster; i++)
    80204416:	c7b9                	beqz	a5,80204464 <_ZN10FAT32Inode6createEPKcsss+0x166>
    80204418:	4b01                	li	s6,0
            struct Buf *b = BufferCache::bread(dev, (sec + i) / 2);
    8020441a:	4488                	lw	a0,8(s1)
    8020441c:	01640d3b          	addw	s10,s0,s6
    80204420:	001d559b          	srliw	a1,s10,0x1
    80204424:	09c040ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
            uint8 *data = (uint8 *)b->data + ((sec + i) % 2) * 512;
    80204428:	001d7d13          	andi	s10,s10,1
    8020442c:	009d1793          	slli	a5,s10,0x9
    80204430:	22850713          	addi	a4,a0,552
    80204434:	02878793          	addi	a5,a5,40
    80204438:	0d26                	slli	s10,s10,0x9
            struct Buf *b = BufferCache::bread(dev, (sec + i) / 2);
    8020443a:	8caa                	mv	s9,a0
            for (int off = 0; off < 512; off += 32)
    8020443c:	976a                	add	a4,a4,s10
    8020443e:	953e                	add	a0,a0,a5
                if (data[off] == 0x00 || data[off] == 0xE5)
    80204440:	00054783          	lbu	a5,0(a0)
    80204444:	0e078c63          	beqz	a5,8020453c <_ZN10FAT32Inode6createEPKcsss+0x23e>
    80204448:	0fb78a63          	beq	a5,s11,8020453c <_ZN10FAT32Inode6createEPKcsss+0x23e>
            for (int off = 0; off < 512; off += 32)
    8020444c:	02050513          	addi	a0,a0,32
    80204450:	fea718e3          	bne	a4,a0,80204440 <_ZN10FAT32Inode6createEPKcsss+0x142>
            BufferCache::brelse(b);
    80204454:	8566                	mv	a0,s9
    80204456:	180040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
        for (uint32 i = 0; i < fs->sectors_per_cluster; i++)
    8020445a:	6ca8                	ld	a0,88(s1)
    8020445c:	2b05                	addiw	s6,s6,1
    8020445e:	495c                	lw	a5,20(a0)
    80204460:	fafb6de3          	bltu	s6,a5,8020441a <_ZN10FAT32Inode6createEPKcsss+0x11c>
    uint32 fat_sector = fat_start_sector + (fat_offset / 512);
    80204464:	451c                	lw	a5,8(a0)
    uint32 fat_offset = cluster * 4;
    80204466:	0029141b          	slliw	s0,s2,0x2
    uint32 fat_sector = fat_start_sector + (fat_offset / 512);
    8020446a:	00945d1b          	srliw	s10,s0,0x9
    8020446e:	00fd093b          	addw	s2,s10,a5
    struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    80204472:	0019559b          	srliw	a1,s2,0x1
    uint32 block_offset = (fat_sector % 2) * 512 + ent_offset;
    80204476:	00197913          	andi	s2,s2,1
    struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    8020447a:	4501                	li	a0,0
    uint32 ent_offset = fat_offset % 512;
    8020447c:	1fc47413          	andi	s0,s0,508
    uint32 block_offset = (fat_sector % 2) * 512 + ent_offset;
    80204480:	0926                	slli	s2,s2,0x9
    struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    80204482:	03e040ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
    uint32 next = *(uint32 *)(b->data + block_offset);
    80204486:	9922                	add	s2,s2,s0
    80204488:	012507b3          	add	a5,a0,s2
    8020448c:	0287a903          	lw	s2,40(a5)
    BufferCache::brelse(b);
    80204490:	146040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
            uint32 new_parent_clus = fs->alloc_cluster();
    80204494:	6ca8                	ld	a0,88(s1)
    return next & 0x0FFFFFFF;
    80204496:	01897933          	and	s2,s2,s8
        if (next >= 0x0FFFFFF8)
    8020449a:	f72bf7e3          	bgeu	s7,s2,80204408 <_ZN10FAT32Inode6createEPKcsss+0x10a>
            uint32 new_parent_clus = fs->alloc_cluster();
    8020449e:	ac1ff0ef          	jal	80203f5e <_ZN15FAT32FileSystem13alloc_clusterEv>
    802044a2:	00050b9b          	sext.w	s7,a0
            if (new_parent_clus == 0)
    802044a6:	0c0b8063          	beqz	s7,80204566 <_ZN10FAT32Inode6createEPKcsss+0x268>
            uint32 fat_sec = fs->fat_start_sector + (fat_off / 512);
    802044aa:	6cbc                	ld	a5,88(s1)
            struct Buf *fb = BufferCache::bread(dev, fat_sec / 2);
    802044ac:	4488                	lw	a0,8(s1)
            uint32 fat_sec = fs->fat_start_sector + (fat_off / 512);
    802044ae:	479c                	lw	a5,8(a5)
    802044b0:	00fd0d3b          	addw	s10,s10,a5
            struct Buf *fb = BufferCache::bread(dev, fat_sec / 2);
    802044b4:	001d559b          	srliw	a1,s10,0x1
    802044b8:	008040ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
            *(uint32 *)(fb->data + (fat_sec % 2) * 512 + (fat_off % 512)) = new_parent_clus;
    802044bc:	001d7d13          	andi	s10,s10,1
    802044c0:	009d1793          	slli	a5,s10,0x9
    802044c4:	97aa                	add	a5,a5,a0
    802044c6:	97a2                	add	a5,a5,s0
    802044c8:	0377a423          	sw	s7,40(a5)
            struct Buf *fb = BufferCache::bread(dev, fat_sec / 2);
    802044cc:	89aa                	mv	s3,a0
            BufferCache::bwrite(fb);
    802044ce:	0d4040ef          	jal	802085a2 <_ZN11BufferCache6bwriteEP3Buf>
            BufferCache::brelse(fb);
    802044d2:	854e                	mv	a0,s3
    802044d4:	102040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
            uint32 s = fs->cluster_to_sector(new_parent_clus);
    802044d8:	6cb8                	ld	a4,88(s1)
    return data_start_sector + (cluster - 2) * sectors_per_cluster;
    802044da:	3bf9                	addiw	s7,s7,-2
            for (uint32 k = 0; k < fs->sectors_per_cluster; k++)
    802044dc:	4981                	li	s3,0
    return data_start_sector + (cluster - 2) * sectors_per_cluster;
    802044de:	4b5c                	lw	a5,20(a4)
    802044e0:	4758                	lw	a4,12(a4)
    802044e2:	02fb8bbb          	mulw	s7,s7,a5
    802044e6:	00eb8bbb          	addw	s7,s7,a4
            for (uint32 k = 0; k < fs->sectors_per_cluster; k++)
    802044ea:	ef89                	bnez	a5,80204504 <_ZN10FAT32Inode6createEPKcsss+0x206>
    802044ec:	a09d                	j	80204552 <_ZN10FAT32Inode6createEPKcsss+0x254>
                BufferCache::bwrite(zb);
    802044ee:	854a                	mv	a0,s2
    802044f0:	0b2040ef          	jal	802085a2 <_ZN11BufferCache6bwriteEP3Buf>
                BufferCache::brelse(zb);
    802044f4:	854a                	mv	a0,s2
    802044f6:	0e0040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
            for (uint32 k = 0; k < fs->sectors_per_cluster; k++)
    802044fa:	6cbc                	ld	a5,88(s1)
    802044fc:	2985                	addiw	s3,s3,1
    802044fe:	4bdc                	lw	a5,20(a5)
    80204500:	04f9f963          	bgeu	s3,a5,80204552 <_ZN10FAT32Inode6createEPKcsss+0x254>
                struct Buf *zb = BufferCache::bread(dev, (s + k) / 2);
    80204504:	4488                	lw	a0,8(s1)
    80204506:	013b843b          	addw	s0,s7,s3
    8020450a:	0014559b          	srliw	a1,s0,0x1
    8020450e:	7b3030ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
                uint8 *zdata = (uint8 *)zb->data + ((s + k) % 2) * 512;
    80204512:	8805                	andi	s0,s0,1
    80204514:	02850793          	addi	a5,a0,40
    80204518:	0426                	slli	s0,s0,0x9
    8020451a:	943e                	add	s0,s0,a5
                struct Buf *zb = BufferCache::bread(dev, (s + k) / 2);
    8020451c:	892a                	mv	s2,a0
                memset(zdata, 0, 512);
    8020451e:	20000613          	li	a2,512
    80204522:	4581                	li	a1,0
    80204524:	8522                	mv	a0,s0
    80204526:	105000ef          	jal	80204e2a <_Z6memsetPvij>
                if (k == 0)
    8020452a:	fc0992e3          	bnez	s3,802044ee <_ZN10FAT32Inode6createEPKcsss+0x1f0>
                    memmove(zdata, &de, 32);
    8020452e:	02000613          	li	a2,32
    80204532:	85d2                	mv	a1,s4
    80204534:	8522                	mv	a0,s0
    80204536:	13f000ef          	jal	80204e74 <_Z7memmovePvPKvj>
    8020453a:	bf55                	j	802044ee <_ZN10FAT32Inode6createEPKcsss+0x1f0>
                    memmove(data + off, &de, 32);
    8020453c:	02000613          	li	a2,32
    80204540:	85d2                	mv	a1,s4
    80204542:	133000ef          	jal	80204e74 <_Z7memmovePvPKvj>
                    BufferCache::bwrite(b);
    80204546:	8566                	mv	a0,s9
    80204548:	05a040ef          	jal	802085a2 <_ZN11BufferCache6bwriteEP3Buf>
                    BufferCache::brelse(b);
    8020454c:	8566                	mv	a0,s9
    8020454e:	088040ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
    if (written && type == T_DIR)
    80204552:	6702                	ld	a4,0(sp)
    80204554:	4785                	li	a5,1
    80204556:	06f70563          	beq	a4,a5,802045c0 <_ZN10FAT32Inode6createEPKcsss+0x2c2>
        return lookup(name);
    8020455a:	609c                	ld	a5,0(s1)
    8020455c:	85d6                	mv	a1,s5
    8020455e:	8526                	mv	a0,s1
    80204560:	779c                	ld	a5,40(a5)
    80204562:	9782                	jalr	a5
    80204564:	89aa                	mv	s3,a0
    80204566:	644e                	ld	s0,208(sp)
}
    80204568:	60ee                	ld	ra,216(sp)
    8020456a:	690e                	ld	s2,192(sp)
    8020456c:	7a4a                	ld	s4,176(sp)
    8020456e:	7b0a                	ld	s6,160(sp)
    80204570:	6bea                	ld	s7,152(sp)
    80204572:	6c4a                	ld	s8,144(sp)
    80204574:	6caa                	ld	s9,136(sp)
    80204576:	6d0a                	ld	s10,128(sp)
    80204578:	7de6                	ld	s11,120(sp)
    8020457a:	64ae                	ld	s1,200(sp)
    8020457c:	7aaa                	ld	s5,168(sp)
    8020457e:	854e                	mv	a0,s3
    80204580:	79ea                	ld	s3,184(sp)
    80204582:	612d                	addi	sp,sp,224
    80204584:	8082                	ret
    de.attr = (type == T_DIR) ? ATTR_DIRECTORY : ATTR_ARCHIVE;
    80204586:	47c1                	li	a5,16
    80204588:	00f10da3          	sb	a5,27(sp)
        new_dir_clus = fs->alloc_cluster();
    8020458c:	9d3ff0ef          	jal	80203f5e <_ZN15FAT32FileSystem13alloc_clusterEv>
    80204590:	0005079b          	sext.w	a5,a0
    80204594:	e43e                	sd	a5,8(sp)
        if (new_dir_clus == 0)
    80204596:	0e078b63          	beqz	a5,8020468c <_ZN10FAT32Inode6createEPKcsss+0x38e>
        de.fstClusHI = (uint16)((new_dir_clus >> 16) & 0xFFFF);
    8020459a:	6722                	ld	a4,8(sp)
    8020459c:	6ca8                	ld	a0,88(s1)
    8020459e:	e9a2                	sd	s0,208(sp)
    802045a0:	0107579b          	srliw	a5,a4,0x10
    802045a4:	e1ca                	sd	s2,192(sp)
    802045a6:	f15a                	sd	s6,160(sp)
    802045a8:	ed5e                	sd	s7,152(sp)
    802045aa:	e962                	sd	s8,144(sp)
    802045ac:	e566                	sd	s9,136(sp)
    802045ae:	e16a                	sd	s10,128(sp)
    802045b0:	fcee                	sd	s11,120(sp)
    802045b2:	02f11223          	sh	a5,36(sp)
        de.fstClusLO = (uint16)(new_dir_clus & 0xFFFF);
    802045b6:	02e11523          	sh	a4,42(sp)
    802045ba:	bd2d                	j	802043f4 <_ZN10FAT32Inode6createEPKcsss+0xf6>
        src++;
    802045bc:	0785                	addi	a5,a5,1
    802045be:	bbf9                	j	8020439c <_ZN10FAT32Inode6createEPKcsss+0x9e>
        memset(&dot, 0, 32);
    802045c0:	03010993          	addi	s3,sp,48
    802045c4:	02000613          	li	a2,32
    802045c8:	4581                	li	a1,0
    802045ca:	854e                	mv	a0,s3
    802045cc:	05f000ef          	jal	80204e2a <_Z6memsetPvij>
        memset(dot.name, ' ', 11);
    802045d0:	462d                	li	a2,11
    802045d2:	02000593          	li	a1,32
    802045d6:	854e                	mv	a0,s3
    802045d8:	053000ef          	jal	80204e2a <_Z6memsetPvij>
        dot.fstClusHI = (uint16)((new_dir_clus >> 16) & 0xFFFF);
    802045dc:	66a2                	ld	a3,8(sp)
        memset(&dotdot, 0, 32);
    802045de:	05010913          	addi	s2,sp,80
        dot.name[0] = '.';
    802045e2:	02e00713          	li	a4,46
        dot.fstClusHI = (uint16)((new_dir_clus >> 16) & 0xFFFF);
    802045e6:	0106d79b          	srliw	a5,a3,0x10
        dot.attr = ATTR_DIRECTORY;
    802045ea:	4441                	li	s0,16
        memset(&dotdot, 0, 32);
    802045ec:	02000613          	li	a2,32
    802045f0:	4581                	li	a1,0
    802045f2:	854a                	mv	a0,s2
        dot.name[0] = '.';
    802045f4:	02e10823          	sb	a4,48(sp)
        dot.fstClusHI = (uint16)((new_dir_clus >> 16) & 0xFFFF);
    802045f8:	04f11223          	sh	a5,68(sp)
        dot.fstClusLO = (uint16)(new_dir_clus & 0xFFFF);
    802045fc:	04d11523          	sh	a3,74(sp)
        dot.attr = ATTR_DIRECTORY;
    80204600:	02810da3          	sb	s0,59(sp)
        memset(&dotdot, 0, 32);
    80204604:	027000ef          	jal	80204e2a <_Z6memsetPvij>
        memset(dotdot.name, ' ', 11);
    80204608:	462d                	li	a2,11
    8020460a:	02000593          	li	a1,32
    8020460e:	854a                	mv	a0,s2
    80204610:	01b000ef          	jal	80204e2a <_Z6memsetPvij>
        if (parent_clus_num == fs->root_cluster)
    80204614:	6cb8                	ld	a4,88(s1)
        dotdot.name[0] = '.';
    80204616:	668d                	lui	a3,0x3
        uint32 parent_clus_num = this->first_clus;
    80204618:	50bc                	lw	a5,96(s1)
        if (parent_clus_num == fs->root_cluster)
    8020461a:	4b10                	lw	a2,16(a4)
        dotdot.name[0] = '.';
    8020461c:	e2e68693          	addi	a3,a3,-466 # 2e2e <_start-0x801fd1d2>
    80204620:	04d11823          	sh	a3,80(sp)
        dotdot.attr = ATTR_DIRECTORY;
    80204624:	04810da3          	sb	s0,91(sp)
        if (parent_clus_num == fs->root_cluster)
    80204628:	06f60463          	beq	a2,a5,80204690 <_ZN10FAT32Inode6createEPKcsss+0x392>
        dotdot.fstClusHI = (uint16)((parent_clus_num >> 16) & 0xFFFF);
    8020462c:	0107d69b          	srliw	a3,a5,0x10
        dotdot.fstClusLO = (uint16)(parent_clus_num & 0xFFFF);
    80204630:	17c2                	slli	a5,a5,0x30
    80204632:	93c1                	srli	a5,a5,0x30
    return data_start_sector + (cluster - 2) * sectors_per_cluster;
    80204634:	65a2                	ld	a1,8(sp)
    80204636:	4b50                	lw	a2,20(a4)
    80204638:	4758                	lw	a4,12(a4)
    8020463a:	ffe5841b          	addiw	s0,a1,-2
    8020463e:	02c4043b          	mulw	s0,s0,a2
        struct Buf *zb = BufferCache::bread(dev, s / 2);
    80204642:	4488                	lw	a0,8(s1)
        dotdot.fstClusHI = (uint16)((parent_clus_num >> 16) & 0xFFFF);
    80204644:	06d11223          	sh	a3,100(sp)
        dotdot.fstClusLO = (uint16)(parent_clus_num & 0xFFFF);
    80204648:	06f11523          	sh	a5,106(sp)
    return data_start_sector + (cluster - 2) * sectors_per_cluster;
    8020464c:	9c39                	addw	s0,s0,a4
        struct Buf *zb = BufferCache::bread(dev, s / 2);
    8020464e:	0014559b          	srliw	a1,s0,0x1
    80204652:	66f030ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
        uint8 *zdata = (uint8 *)zb->data + (s % 2) * 512;
    80204656:	00147793          	andi	a5,s0,1
    8020465a:	07a6                	slli	a5,a5,0x9
    8020465c:	02850413          	addi	s0,a0,40
    80204660:	943e                	add	s0,s0,a5
        struct Buf *zb = BufferCache::bread(dev, s / 2);
    80204662:	8a2a                	mv	s4,a0
        memmove(zdata, &dot, 32);         // Offset 0
    80204664:	85ce                	mv	a1,s3
    80204666:	02000613          	li	a2,32
    8020466a:	8522                	mv	a0,s0
    8020466c:	009000ef          	jal	80204e74 <_Z7memmovePvPKvj>
        memmove(zdata + 32, &dotdot, 32); // Offset 32
    80204670:	02000613          	li	a2,32
    80204674:	85ca                	mv	a1,s2
    80204676:	02040513          	addi	a0,s0,32
    8020467a:	7fa000ef          	jal	80204e74 <_Z7memmovePvPKvj>
        BufferCache::bwrite(zb);
    8020467e:	8552                	mv	a0,s4
    80204680:	723030ef          	jal	802085a2 <_ZN11BufferCache6bwriteEP3Buf>
        BufferCache::brelse(zb);
    80204684:	8552                	mv	a0,s4
    80204686:	751030ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
    8020468a:	bdc1                	j	8020455a <_ZN10FAT32Inode6createEPKcsss+0x25c>
    8020468c:	7a4a                	ld	s4,176(sp)
    8020468e:	b169                	j	80204318 <_ZN10FAT32Inode6createEPKcsss+0x1a>
    80204690:	4781                	li	a5,0
    80204692:	4681                	li	a3,0
    80204694:	b745                	j	80204634 <_ZN10FAT32Inode6createEPKcsss+0x336>

0000000080204696 <_ZN15FAT32FileSystem18free_cluster_chainEj>:
{
    80204696:	7139                	addi	sp,sp,-64
    80204698:	ec4e                	sd	s3,24(sp)
    while (cluster >= 2 && cluster < 0x0FFFFFF8)
    8020469a:	100009b7          	lui	s3,0x10000
{
    8020469e:	fc06                	sd	ra,56(sp)
    while (cluster >= 2 && cluster < 0x0FFFFFF8)
    802046a0:	ffe5879b          	addiw	a5,a1,-2
    802046a4:	19d5                	addi	s3,s3,-11 # ffffff5 <_start-0x7020000b>
    802046a6:	08f9e463          	bltu	s3,a5,8020472e <_ZN15FAT32FileSystem18free_cluster_chainEj+0x98>
    802046aa:	e852                	sd	s4,16(sp)
    return next & 0x0FFFFFFF;
    802046ac:	10000a37          	lui	s4,0x10000
    802046b0:	f04a                	sd	s2,32(sp)
    802046b2:	e05a                	sd	s6,0(sp)
    802046b4:	f822                	sd	s0,48(sp)
    802046b6:	f426                	sd	s1,40(sp)
    802046b8:	e456                	sd	s5,8(sp)
    802046ba:	8b2e                	mv	s6,a1
    802046bc:	892a                	mv	s2,a0
    802046be:	1a7d                	addi	s4,s4,-1 # fffffff <_start-0x70200001>
    uint32 fat_sector = fat_start_sector + (fat_offset / 512);
    802046c0:	00892483          	lw	s1,8(s2)
    uint32 fat_offset = cluster * 4;
    802046c4:	002b1b1b          	slliw	s6,s6,0x2
    uint32 fat_sector = fat_start_sector + (fat_offset / 512);
    802046c8:	009b541b          	srliw	s0,s6,0x9
    802046cc:	9ca1                	addw	s1,s1,s0
    struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    802046ce:	0014d59b          	srliw	a1,s1,0x1
    uint32 block_offset = (fat_sector % 2) * 512 + ent_offset;
    802046d2:	8885                	andi	s1,s1,1
    uint32 ent_offset = fat_offset % 512;
    802046d4:	1fcb7a93          	andi	s5,s6,508
    struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    802046d8:	4501                	li	a0,0
    uint32 block_offset = (fat_sector % 2) * 512 + ent_offset;
    802046da:	04a6                	slli	s1,s1,0x9
    struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    802046dc:	5e5030ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
    uint32 next = *(uint32 *)(b->data + block_offset);
    802046e0:	94d6                	add	s1,s1,s5
    802046e2:	009507b3          	add	a5,a0,s1
    802046e6:	0287ab03          	lw	s6,40(a5)
    BufferCache::brelse(b);
    802046ea:	6ed030ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
        uint32 fat_sector = fat_start_sector + (fat_offset / 512);
    802046ee:	00892783          	lw	a5,8(s2)
        struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    802046f2:	4501                	li	a0,0
    return next & 0x0FFFFFFF;
    802046f4:	014b7b33          	and	s6,s6,s4
        uint32 fat_sector = fat_start_sector + (fat_offset / 512);
    802046f8:	9c3d                	addw	s0,s0,a5
        struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    802046fa:	0014559b          	srliw	a1,s0,0x1
        uint32 *entry = (uint32 *)(b->data + (fat_sector % 2) * 512 + ent_offset);
    802046fe:	8805                	andi	s0,s0,1
        struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    80204700:	5c1030ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
        uint32 *entry = (uint32 *)(b->data + (fat_sector % 2) * 512 + ent_offset);
    80204704:	0426                	slli	s0,s0,0x9
        *entry = 0;
    80204706:	942a                	add	s0,s0,a0
    80204708:	9456                	add	s0,s0,s5
    8020470a:	02042423          	sw	zero,40(s0)
        struct Buf *b = BufferCache::bread(0, fat_sector / 2);
    8020470e:	84aa                	mv	s1,a0
        BufferCache::bwrite(b);
    80204710:	693030ef          	jal	802085a2 <_ZN11BufferCache6bwriteEP3Buf>
        BufferCache::brelse(b);
    80204714:	8526                	mv	a0,s1
    80204716:	6c1030ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
    while (cluster >= 2 && cluster < 0x0FFFFFF8)
    8020471a:	ffeb079b          	addiw	a5,s6,-2
    8020471e:	faf9f1e3          	bgeu	s3,a5,802046c0 <_ZN15FAT32FileSystem18free_cluster_chainEj+0x2a>
    80204722:	7442                	ld	s0,48(sp)
    80204724:	74a2                	ld	s1,40(sp)
    80204726:	7902                	ld	s2,32(sp)
    80204728:	6a42                	ld	s4,16(sp)
    8020472a:	6aa2                	ld	s5,8(sp)
    8020472c:	6b02                	ld	s6,0(sp)
}
    8020472e:	70e2                	ld	ra,56(sp)
    80204730:	69e2                	ld	s3,24(sp)
    80204732:	6121                	addi	sp,sp,64
    80204734:	8082                	ret

0000000080204736 <_ZN10FAT32Inode8truncateEv>:
    if (first_clus == 0)
    80204736:	512c                	lw	a1,96(a0)
{
    80204738:	1141                	addi	sp,sp,-16
    8020473a:	e022                	sd	s0,0(sp)
    8020473c:	e406                	sd	ra,8(sp)
    8020473e:	842a                	mv	s0,a0
    if (first_clus == 0)
    80204740:	ed99                	bnez	a1,8020475e <_ZN10FAT32Inode8truncateEv+0x28>
        if (size != 0)
    80204742:	493c                	lw	a5,80(a0)
    80204744:	cb89                	beqz	a5,80204756 <_ZN10FAT32Inode8truncateEv+0x20>
            update();
    80204746:	611c                	ld	a5,0(a0)
}
    80204748:	6402                	ld	s0,0(sp)
    8020474a:	60a2                	ld	ra,8(sp)
            update();
    8020474c:	6b9c                	ld	a5,16(a5)
            size = 0;
    8020474e:	04052823          	sw	zero,80(a0)
}
    80204752:	0141                	addi	sp,sp,16
    update();
    80204754:	8782                	jr	a5
}
    80204756:	60a2                	ld	ra,8(sp)
    80204758:	6402                	ld	s0,0(sp)
    8020475a:	0141                	addi	sp,sp,16
    8020475c:	8082                	ret
    fs->free_cluster_chain(first_clus);
    8020475e:	6d28                	ld	a0,88(a0)
    80204760:	f37ff0ef          	jal	80204696 <_ZN15FAT32FileSystem18free_cluster_chainEj>
    update();
    80204764:	601c                	ld	a5,0(s0)
    size = 0;
    80204766:	04042823          	sw	zero,80(s0)
    first_clus = 0;
    8020476a:	06042023          	sw	zero,96(s0)
    update();
    8020476e:	8522                	mv	a0,s0
}
    80204770:	6402                	ld	s0,0(sp)
    80204772:	60a2                	ld	ra,8(sp)
    update();
    80204774:	6b9c                	ld	a5,16(a5)
}
    80204776:	0141                	addi	sp,sp,16
    update();
    80204778:	8782                	jr	a5

000000008020477a <_Z10fat32_testv>:

// Test Function
void fat32_test()
{
    8020477a:	7135                	addi	sp,sp,-160
    8020477c:	e922                	sd	s0,144(sp)
    static bool inited = false;
    if (!inited)
    8020477e:	00019417          	auipc	s0,0x19
    80204782:	44240413          	addi	s0,s0,1090 # 8021dbc0 <_ZZ10fat32_testvE6inited>
    80204786:	00044783          	lbu	a5,0(s0)
{
    8020478a:	ed06                	sd	ra,152(sp)
    if (!inited)
    8020478c:	0e078963          	beqz	a5,8020487e <_Z10fat32_testv+0x104>
    {
        fat32_fs.init();
        inited = true;
    }

    Drivers::uart_puts("\n[FAT32] Starting Test via Syscall...\n");
    80204790:	0000d517          	auipc	a0,0xd
    80204794:	16050513          	addi	a0,a0,352 # 802118f0 <initcode_end+0x1a8>
    80204798:	5d2040ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>

    Inode *root = fat32_fs.root();
    8020479c:	00019517          	auipc	a0,0x19
    802047a0:	42c50513          	addi	a0,a0,1068 # 8021dbc8 <fat32_fs>
    802047a4:	974ff0ef          	jal	80203918 <_ZN15FAT32FileSystem4rootEv>
    802047a8:	842a                	mv	s0,a0
    if (root)
    802047aa:	10050263          	beqz	a0,802048ae <_Z10fat32_testv+0x134>
    {
        Drivers::uart_puts("[FAT32] Root Inode retrieved. Inum: ");
    802047ae:	0000d517          	auipc	a0,0xd
    802047b2:	16a50513          	addi	a0,a0,362 # 80211918 <initcode_end+0x1d0>
    802047b6:	e526                	sd	s1,136(sp)
    802047b8:	5b2040ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        Drivers::uart_put_int(root->inum);
    802047bc:	4448                	lw	a0,12(s0)
    802047be:	60a040ef          	jal	80208dc8 <_ZN7Drivers12uart_put_intEi>
        Drivers::uart_puts("\n");
    802047c2:	0000d517          	auipc	a0,0xd
    802047c6:	05e50513          	addi	a0,a0,94 # 80211820 <initcode_end+0xd8>
    802047ca:	5a0040ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>

        Drivers::uart_puts("[FAT32] Looking for TEST.TXT...\n");
    802047ce:	0000d517          	auipc	a0,0xd
    802047d2:	17250513          	addi	a0,a0,370 # 80211940 <initcode_end+0x1f8>
    802047d6:	594040ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        Inode *node = root->lookup("test.txt");
    802047da:	601c                	ld	a5,0(s0)
    802047dc:	0000d597          	auipc	a1,0xd
    802047e0:	18c58593          	addi	a1,a1,396 # 80211968 <initcode_end+0x220>
    802047e4:	8522                	mv	a0,s0
    802047e6:	779c                	ld	a5,40(a5)
    802047e8:	9782                	jalr	a5
    802047ea:	84aa                	mv	s1,a0

        if (node)
    802047ec:	c151                	beqz	a0,80204870 <_Z10fat32_testv+0xf6>
        {
            Drivers::uart_puts("[FAT32] Found TEST.TXT! Size: ");
    802047ee:	0000d517          	auipc	a0,0xd
    802047f2:	18a50513          	addi	a0,a0,394 # 80211978 <initcode_end+0x230>
    802047f6:	e14a                	sd	s2,128(sp)
    802047f8:	572040ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            Drivers::uart_put_int(node->size);
    802047fc:	48a8                	lw	a0,80(s1)
            Drivers::uart_puts("\n");

            char buf[128];
            int n = node->read(buf, 0, 127, 0);
    802047fe:	890a                	mv	s2,sp
            Drivers::uart_put_int(node->size);
    80204800:	5c8040ef          	jal	80208dc8 <_ZN7Drivers12uart_put_intEi>
            Drivers::uart_puts("\n");
    80204804:	0000d517          	auipc	a0,0xd
    80204808:	01c50513          	addi	a0,a0,28 # 80211820 <initcode_end+0xd8>
    8020480c:	55e040ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            int n = node->read(buf, 0, 127, 0);
    80204810:	609c                	ld	a5,0(s1)
    80204812:	4701                	li	a4,0
    80204814:	07f00693          	li	a3,127
    80204818:	6f9c                	ld	a5,24(a5)
    8020481a:	4601                	li	a2,0
    8020481c:	85ca                	mv	a1,s2
    8020481e:	8526                	mv	a0,s1
    80204820:	9782                	jalr	a5
            if (n > 0)
    80204822:	0aa05563          	blez	a0,802048cc <_Z10fat32_testv+0x152>
            {
                buf[n] = 0;
    80204826:	08050793          	addi	a5,a0,128
    8020482a:	978a                	add	a5,a5,sp
                Drivers::uart_puts("[FAT32] Content:\n>> ");
    8020482c:	0000d517          	auipc	a0,0xd
    80204830:	16c50513          	addi	a0,a0,364 # 80211998 <initcode_end+0x250>
                buf[n] = 0;
    80204834:	f8078023          	sb	zero,-128(a5)
                Drivers::uart_puts("[FAT32] Content:\n>> ");
    80204838:	532040ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
                Drivers::uart_puts(buf);
    8020483c:	854a                	mv	a0,s2
    8020483e:	52c040ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
                Drivers::uart_puts("\n");
    80204842:	0000d517          	auipc	a0,0xd
    80204846:	fde50513          	addi	a0,a0,-34 # 80211820 <initcode_end+0xd8>
    8020484a:	520040ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            }
            else
            {
                Drivers::uart_puts("[FAT32] Read returned 0.\n");
            }
            VFS::iput(node);
    8020484e:	8526                	mv	a0,s1
    80204850:	18c000ef          	jal	802049dc <_ZN3VFS4iputEP5Inode>
    80204854:	690a                	ld	s2,128(sp)
        }
        else
        {
            Drivers::uart_puts("[FAT32] TEST.TXT not found.\n");
        }
        VFS::iput(root);
    80204856:	8522                	mv	a0,s0
    80204858:	184000ef          	jal	802049dc <_ZN3VFS4iputEP5Inode>
    {
        Drivers::uart_puts("[FAT32] Failed to get root inode.\n");
    }

    Drivers::uart_puts("[FAT32] Test Finished.\n");
    8020485c:	644a                	ld	s0,144(sp)
    8020485e:	64aa                	ld	s1,136(sp)
    80204860:	60ea                	ld	ra,152(sp)
    Drivers::uart_puts("[FAT32] Test Finished.\n");
    80204862:	0000d517          	auipc	a0,0xd
    80204866:	1b650513          	addi	a0,a0,438 # 80211a18 <initcode_end+0x2d0>
    8020486a:	610d                	addi	sp,sp,160
    Drivers::uart_puts("[FAT32] Test Finished.\n");
    8020486c:	4fe0406f          	j	80208d6a <_ZN7Drivers9uart_putsEPKc>
            Drivers::uart_puts("[FAT32] TEST.TXT not found.\n");
    80204870:	0000d517          	auipc	a0,0xd
    80204874:	16050513          	addi	a0,a0,352 # 802119d0 <initcode_end+0x288>
    80204878:	4f2040ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
    8020487c:	bfe9                	j	80204856 <_Z10fat32_testv+0xdc>
        fat32_fs.init();
    8020487e:	00019517          	auipc	a0,0x19
    80204882:	34a50513          	addi	a0,a0,842 # 8021dbc8 <fat32_fs>
    80204886:	dd1fe0ef          	jal	80203656 <_ZN15FAT32FileSystem4initEv>
        inited = true;
    8020488a:	4785                	li	a5,1
    Drivers::uart_puts("\n[FAT32] Starting Test via Syscall...\n");
    8020488c:	0000d517          	auipc	a0,0xd
    80204890:	06450513          	addi	a0,a0,100 # 802118f0 <initcode_end+0x1a8>
        inited = true;
    80204894:	00f40023          	sb	a5,0(s0)
    Drivers::uart_puts("\n[FAT32] Starting Test via Syscall...\n");
    80204898:	4d2040ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
    Inode *root = fat32_fs.root();
    8020489c:	00019517          	auipc	a0,0x19
    802048a0:	32c50513          	addi	a0,a0,812 # 8021dbc8 <fat32_fs>
    802048a4:	874ff0ef          	jal	80203918 <_ZN15FAT32FileSystem4rootEv>
    802048a8:	842a                	mv	s0,a0
    if (root)
    802048aa:	f00512e3          	bnez	a0,802047ae <_Z10fat32_testv+0x34>
        Drivers::uart_puts("[FAT32] Failed to get root inode.\n");
    802048ae:	0000d517          	auipc	a0,0xd
    802048b2:	14250513          	addi	a0,a0,322 # 802119f0 <initcode_end+0x2a8>
    802048b6:	4b4040ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
    802048ba:	644a                	ld	s0,144(sp)
    802048bc:	60ea                	ld	ra,152(sp)
    Drivers::uart_puts("[FAT32] Test Finished.\n");
    802048be:	0000d517          	auipc	a0,0xd
    802048c2:	15a50513          	addi	a0,a0,346 # 80211a18 <initcode_end+0x2d0>
    802048c6:	610d                	addi	sp,sp,160
    Drivers::uart_puts("[FAT32] Test Finished.\n");
    802048c8:	4a20406f          	j	80208d6a <_ZN7Drivers9uart_putsEPKc>
                Drivers::uart_puts("[FAT32] Read returned 0.\n");
    802048cc:	0000d517          	auipc	a0,0xd
    802048d0:	0e450513          	addi	a0,a0,228 # 802119b0 <initcode_end+0x268>
    802048d4:	496040ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
    802048d8:	bf9d                	j	8020484e <_Z10fat32_testv+0xd4>

00000000802048da <_ZN10FAT32InodeD1Ev>:
            partition_lba = lba;
    802048da:	8082                	ret

00000000802048dc <_ZN15FAT32FileSystemD1Ev>:
    this->fat_sz = fat_sz;
    802048dc:	8082                	ret

00000000802048de <_ZN10FAT32InodeD0Ev>:
            partition_lba = lba;
    802048de:	07800593          	li	a1,120
    802048e2:	0280106f          	j	8020590a <_ZdlPvm>

00000000802048e6 <_ZN15FAT32FileSystemD0Ev>:
    this->fat_sz = fat_sz;
    802048e6:	02000593          	li	a1,32
    802048ea:	0200106f          	j	8020590a <_ZdlPvm>

00000000802048ee <_GLOBAL__sub_I_fat32_fs>:
    Inode *create(const char *name, short type, short major, short minor) override;
    void truncate() override;
    int unlink(const char *name) override;
};

class FAT32FileSystem : public FileSystem
    802048ee:	00010797          	auipc	a5,0x10
    802048f2:	08278793          	addi	a5,a5,130 # 80214970 <_ZTV15FAT32FileSystem+0x10>
    802048f6:	00019717          	auipc	a4,0x19
    802048fa:	2cf73923          	sd	a5,722(a4) # 8021dbc8 <fat32_fs>
    802048fe:	8082                	ret

0000000080204900 <_ZN5Inode7getattrEP5kstat>:

void Inode::getattr(struct kstat *st)
{
    st->dev = dev;
    st->ino = inum;
    st->type = type;
    80204900:	04e55703          	lhu	a4,78(a0)
    80204904:	04855783          	lhu	a5,72(a0)
    st->dev = dev;
    80204908:	00852803          	lw	a6,8(a0)
    st->ino = inum;
    8020490c:	4550                	lw	a2,12(a0)
    st->nlink = nlink;
    st->size = size;
    8020490e:	05056683          	lwu	a3,80(a0)
    st->type = type;
    80204912:	0107171b          	slliw	a4,a4,0x10
    80204916:	8fd9                	or	a5,a5,a4
    st->dev = dev;
    80204918:	0105a023          	sw	a6,0(a1)
    st->ino = inum;
    8020491c:	c1d0                	sw	a2,4(a1)
    st->type = type;
    8020491e:	c59c                	sw	a5,8(a1)
    st->size = size;
    80204920:	e994                	sd	a3,16(a1)

    st->uid = 0;
    st->gid = 0;
    80204922:	0205a023          	sw	zero,32(a1)
    st->mode = 0;
    80204926:	0005bc23          	sd	zero,24(a1)
}
    8020492a:	8082                	ret

000000008020492c <_ZL8skipelemPKcPc>:
{
    8020492c:	1101                	addi	sp,sp,-32
    8020492e:	e822                	sd	s0,16(sp)
    80204930:	ec06                	sd	ra,24(sp)
    80204932:	e426                	sd	s1,8(sp)
    80204934:	e04a                	sd	s2,0(sp)
    while (*path == '/')
    80204936:	00054783          	lbu	a5,0(a0)
    8020493a:	02f00713          	li	a4,47
{
    8020493e:	842a                	mv	s0,a0
    80204940:	852e                	mv	a0,a1
    while (*path == '/')
    80204942:	06e79d63          	bne	a5,a4,802049bc <_ZL8skipelemPKcPc+0x90>
    80204946:	00144783          	lbu	a5,1(s0)
        path++;
    8020494a:	0405                	addi	s0,s0,1
    while (*path == '/')
    8020494c:	fee78de3          	beq	a5,a4,80204946 <_ZL8skipelemPKcPc+0x1a>
    if (*path == 0)
    80204950:	cba5                	beqz	a5,802049c0 <_ZL8skipelemPKcPc+0x94>
    while (*path != '/' && *path != 0)
    80204952:	85a2                	mv	a1,s0
    80204954:	892a                	mv	s2,a0
    80204956:	84a2                	mv	s1,s0
    80204958:	4601                	li	a2,0
    8020495a:	02e78663          	beq	a5,a4,80204986 <_ZL8skipelemPKcPc+0x5a>
    8020495e:	02f00713          	li	a4,47
    80204962:	c791                	beqz	a5,8020496e <_ZL8skipelemPKcPc+0x42>
    80204964:	00144783          	lbu	a5,1(s0)
        path++;
    80204968:	0405                	addi	s0,s0,1
    while (*path != '/' && *path != 0)
    8020496a:	fee79ce3          	bne	a5,a4,80204962 <_ZL8skipelemPKcPc+0x36>
    len = path - s;
    8020496e:	40b40633          	sub	a2,s0,a1
    if (len >= 128)
    80204972:	0006071b          	sext.w	a4,a2
    80204976:	07f00793          	li	a5,127
    8020497a:	02e7ce63          	blt	a5,a4,802049b6 <_ZL8skipelemPKcPc+0x8a>
    8020497e:	2601                	sext.w	a2,a2
    name[len] = 0;
    80204980:	00c50933          	add	s2,a0,a2
    80204984:	84a2                	mv	s1,s0
    memmove(name, s, len);
    80204986:	4ee000ef          	jal	80204e74 <_Z7memmovePvPKvj>
    name[len] = 0;
    8020498a:	00090023          	sb	zero,0(s2)
    while (*path == '/')
    8020498e:	00044703          	lbu	a4,0(s0)
    80204992:	02f00793          	li	a5,47
    80204996:	00f71963          	bne	a4,a5,802049a8 <_ZL8skipelemPKcPc+0x7c>
    8020499a:	02f00713          	li	a4,47
    8020499e:	0014c783          	lbu	a5,1(s1)
        path++;
    802049a2:	0485                	addi	s1,s1,1
    while (*path == '/')
    802049a4:	fee78de3          	beq	a5,a4,8020499e <_ZL8skipelemPKcPc+0x72>
}
    802049a8:	60e2                	ld	ra,24(sp)
    802049aa:	6442                	ld	s0,16(sp)
    802049ac:	6902                	ld	s2,0(sp)
    802049ae:	8526                	mv	a0,s1
    802049b0:	64a2                	ld	s1,8(sp)
    802049b2:	6105                	addi	sp,sp,32
    802049b4:	8082                	ret
    if (len >= 128)
    802049b6:	07f00613          	li	a2,127
    802049ba:	b7d1                	j	8020497e <_ZL8skipelemPKcPc+0x52>
    while (*path != '/' && *path != 0)
    802049bc:	85a2                	mv	a1,s0
    if (*path == 0)
    802049be:	f3c5                	bnez	a5,8020495e <_ZL8skipelemPKcPc+0x32>
}
    802049c0:	60e2                	ld	ra,24(sp)
    802049c2:	6442                	ld	s0,16(sp)
        return nullptr;
    802049c4:	4481                	li	s1,0
}
    802049c6:	6902                	ld	s2,0(sp)
    802049c8:	8526                	mv	a0,s1
    802049ca:	64a2                	ld	s1,8(sp)
    802049cc:	6105                	addi	sp,sp,32
    802049ce:	8082                	ret

00000000802049d0 <_ZN3VFS4initEv>:

namespace VFS
{
    void init()
    {
        Drivers::uart_puts("[VFS] Inode subsystem initialized.\n");
    802049d0:	0000d517          	auipc	a0,0xd
    802049d4:	06050513          	addi	a0,a0,96 # 80211a30 <initcode_end+0x2e8>
    802049d8:	3920406f          	j	80208d6a <_ZN7Drivers9uart_putsEPKc>

00000000802049dc <_ZN3VFS4iputEP5Inode>:
    }

    void iput(Inode *ip)
    {
        if (ip == nullptr)
    802049dc:	c931                	beqz	a0,80204a30 <_ZN3VFS4iputEP5Inode+0x54>
    {
    802049de:	1101                	addi	sp,sp,-32
    802049e0:	e426                	sd	s1,8(sp)
            return;

        ip->lock.acquire();
    802049e2:	01850493          	addi	s1,a0,24
    {
    802049e6:	e822                	sd	s0,16(sp)
    802049e8:	842a                	mv	s0,a0
        ip->lock.acquire();
    802049ea:	8526                	mv	a0,s1
    {
    802049ec:	ec06                	sd	ra,24(sp)
        ip->lock.acquire();
    802049ee:	240010ef          	jal	80205c2e <_ZN5Mutex7acquireEv>
        if(ip->ref_cnt < 1)
    802049f2:	481c                	lw	a5,16(s0)
    802049f4:	02f05263          	blez	a5,80204a18 <_ZN3VFS4iputEP5Inode+0x3c>
        {
            Drivers::uart_puts("panic: iput ref\n");
            while (1)
                ;
        }
        ip->ref_cnt--;
    802049f8:	37fd                	addiw	a5,a5,-1
        int ref = ip->ref_cnt;
        ip->lock.release();
    802049fa:	8526                	mv	a0,s1
        ip->ref_cnt--;
    802049fc:	c81c                	sw	a5,16(s0)
    802049fe:	0007849b          	sext.w	s1,a5
        ip->lock.release();
    80204a02:	29e010ef          	jal	80205ca0 <_ZN5Mutex7releaseEv>

        if (ref == 0)
    80204a06:	e085                	bnez	s1,80204a26 <_ZN3VFS4iputEP5Inode+0x4a>
        {
            delete ip;
    80204a08:	601c                	ld	a5,0(s0)
    80204a0a:	8522                	mv	a0,s0
        }
    }
    80204a0c:	6442                	ld	s0,16(sp)
    80204a0e:	60e2                	ld	ra,24(sp)
    80204a10:	64a2                	ld	s1,8(sp)
            delete ip;
    80204a12:	679c                	ld	a5,8(a5)
    }
    80204a14:	6105                	addi	sp,sp,32
            delete ip;
    80204a16:	8782                	jr	a5
            Drivers::uart_puts("panic: iput ref\n");
    80204a18:	0000d517          	auipc	a0,0xd
    80204a1c:	04050513          	addi	a0,a0,64 # 80211a58 <initcode_end+0x310>
    80204a20:	34a040ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            while (1)
    80204a24:	a001                	j	80204a24 <_ZN3VFS4iputEP5Inode+0x48>
    }
    80204a26:	60e2                	ld	ra,24(sp)
    80204a28:	6442                	ld	s0,16(sp)
    80204a2a:	64a2                	ld	s1,8(sp)
    80204a2c:	6105                	addi	sp,sp,32
    80204a2e:	8082                	ret
    80204a30:	8082                	ret

0000000080204a32 <_ZN3VFS4idupEP5Inode>:

    Inode* idup(Inode *ip)
    {
    80204a32:	1101                	addi	sp,sp,-32
    80204a34:	e822                	sd	s0,16(sp)
    80204a36:	ec06                	sd	ra,24(sp)
    80204a38:	842a                	mv	s0,a0
        if (ip == nullptr)
    80204a3a:	cd11                	beqz	a0,80204a56 <_ZN3VFS4idupEP5Inode+0x24>
    80204a3c:	e426                	sd	s1,8(sp)
            return nullptr;

        ip->lock.acquire();
    80204a3e:	01850493          	addi	s1,a0,24
    80204a42:	8526                	mv	a0,s1
    80204a44:	1ea010ef          	jal	80205c2e <_ZN5Mutex7acquireEv>
        ip->ref_cnt++;
    80204a48:	481c                	lw	a5,16(s0)
        ip->lock.release();
    80204a4a:	8526                	mv	a0,s1
        ip->ref_cnt++;
    80204a4c:	2785                	addiw	a5,a5,1
    80204a4e:	c81c                	sw	a5,16(s0)
        ip->lock.release();
    80204a50:	250010ef          	jal	80205ca0 <_ZN5Mutex7releaseEv>
    80204a54:	64a2                	ld	s1,8(sp)
        return ip;
    }
    80204a56:	60e2                	ld	ra,24(sp)
    80204a58:	8522                	mv	a0,s0
    80204a5a:	6442                	ld	s0,16(sp)
    80204a5c:	6105                	addi	sp,sp,32
    80204a5e:	8082                	ret

0000000080204a60 <_ZN3VFS5ilockEP5Inode>:

    void ilock(Inode *ip)
    {
        if (ip == 0 || ip->ref_cnt < 1)
    80204a60:	c501                	beqz	a0,80204a68 <_ZN3VFS5ilockEP5Inode+0x8>
    80204a62:	491c                	lw	a5,16(a0)
    80204a64:	00f04b63          	bgtz	a5,80204a7a <_ZN3VFS5ilockEP5Inode+0x1a>
    {
    80204a68:	1141                	addi	sp,sp,-16
        {
            Drivers::uart_puts("panic: ilock\n");
    80204a6a:	0000d517          	auipc	a0,0xd
    80204a6e:	00650513          	addi	a0,a0,6 # 80211a70 <initcode_end+0x328>
    {
    80204a72:	e406                	sd	ra,8(sp)
            Drivers::uart_puts("panic: ilock\n");
    80204a74:	2f6040ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            while (1)
    80204a78:	a001                	j	80204a78 <_ZN3VFS5ilockEP5Inode+0x18>
                ;
        }

        ip->lock.acquire();
    80204a7a:	0561                	addi	a0,a0,24
    80204a7c:	1b20106f          	j	80205c2e <_ZN5Mutex7acquireEv>

0000000080204a80 <_ZN3VFS7iunlockEP5Inode>:

    }

    void iunlock(Inode *ip)
    {
    80204a80:	1101                	addi	sp,sp,-32
    80204a82:	ec06                	sd	ra,24(sp)
    80204a84:	e822                	sd	s0,16(sp)
    80204a86:	e426                	sd	s1,8(sp)
        if (ip == 0 || !ip->lock.holding() || ip->ref_cnt < 1)
    80204a88:	c901                	beqz	a0,80204a98 <_ZN3VFS7iunlockEP5Inode+0x18>
    80204a8a:	01850493          	addi	s1,a0,24
    80204a8e:	842a                	mv	s0,a0
    80204a90:	8526                	mv	a0,s1
    80204a92:	23e010ef          	jal	80205cd0 <_ZN5Mutex7holdingEv>
    80204a96:	e901                	bnez	a0,80204aa6 <_ZN3VFS7iunlockEP5Inode+0x26>
        {
            Drivers::uart_puts("panic: iunlock\n");
    80204a98:	0000d517          	auipc	a0,0xd
    80204a9c:	fe850513          	addi	a0,a0,-24 # 80211a80 <initcode_end+0x338>
    80204aa0:	2ca040ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            while (1)
    80204aa4:	a001                	j	80204aa4 <_ZN3VFS7iunlockEP5Inode+0x24>
        if (ip == 0 || !ip->lock.holding() || ip->ref_cnt < 1)
    80204aa6:	481c                	lw	a5,16(s0)
    80204aa8:	fef058e3          	blez	a5,80204a98 <_ZN3VFS7iunlockEP5Inode+0x18>
                ;
        }
        ip->lock.release();
    }
    80204aac:	6442                	ld	s0,16(sp)
    80204aae:	60e2                	ld	ra,24(sp)
        ip->lock.release();
    80204ab0:	8526                	mv	a0,s1
    }
    80204ab2:	64a2                	ld	s1,8(sp)
    80204ab4:	6105                	addi	sp,sp,32
        ip->lock.release();
    80204ab6:	1ea0106f          	j	80205ca0 <_ZN5Mutex7releaseEv>

0000000080204aba <_ZN3VFS10iunlockputEP5Inode>:

    void iunlockput(Inode *ip)
    {
        if (!ip)
    80204aba:	c121                	beqz	a0,80204afa <_ZN3VFS10iunlockputEP5Inode+0x40>
    {
    80204abc:	1101                	addi	sp,sp,-32
    80204abe:	e426                	sd	s1,8(sp)
        if (ip == 0 || !ip->lock.holding() || ip->ref_cnt < 1)
    80204ac0:	01850493          	addi	s1,a0,24
    {
    80204ac4:	e822                	sd	s0,16(sp)
    80204ac6:	842a                	mv	s0,a0
        if (ip == 0 || !ip->lock.holding() || ip->ref_cnt < 1)
    80204ac8:	8526                	mv	a0,s1
    {
    80204aca:	ec06                	sd	ra,24(sp)
        if (ip == 0 || !ip->lock.holding() || ip->ref_cnt < 1)
    80204acc:	204010ef          	jal	80205cd0 <_ZN5Mutex7holdingEv>
    80204ad0:	e901                	bnez	a0,80204ae0 <_ZN3VFS10iunlockputEP5Inode+0x26>
            Drivers::uart_puts("panic: iunlock\n");
    80204ad2:	0000d517          	auipc	a0,0xd
    80204ad6:	fae50513          	addi	a0,a0,-82 # 80211a80 <initcode_end+0x338>
    80204ada:	290040ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            while (1)
    80204ade:	a001                	j	80204ade <_ZN3VFS10iunlockputEP5Inode+0x24>
        if (ip == 0 || !ip->lock.holding() || ip->ref_cnt < 1)
    80204ae0:	481c                	lw	a5,16(s0)
    80204ae2:	fef058e3          	blez	a5,80204ad2 <_ZN3VFS10iunlockputEP5Inode+0x18>
        ip->lock.release();
    80204ae6:	8526                	mv	a0,s1
    80204ae8:	1b8010ef          	jal	80205ca0 <_ZN5Mutex7releaseEv>
            return;
        iunlock(ip);
        iput(ip);
    80204aec:	8522                	mv	a0,s0
    }
    80204aee:	6442                	ld	s0,16(sp)
    80204af0:	60e2                	ld	ra,24(sp)
    80204af2:	64a2                	ld	s1,8(sp)
    80204af4:	6105                	addi	sp,sp,32
        iput(ip);
    80204af6:	ee7ff06f          	j	802049dc <_ZN3VFS4iputEP5Inode>
    80204afa:	8082                	ret

0000000080204afc <_ZN3VFS10mount_rootEP5Inode>:

    void mount_root(Inode *root)
    {
        if (global_root_inode)
    80204afc:	00019717          	auipc	a4,0x19
    80204b00:	0ec70713          	addi	a4,a4,236 # 8021dbe8 <_ZL17global_root_inode>
    80204b04:	6314                	ld	a3,0(a4)
    {
    80204b06:	87aa                	mv	a5,a0
        if (global_root_inode)
    80204b08:	c699                	beqz	a3,80204b16 <_ZN3VFS10mount_rootEP5Inode+0x1a>
        {
            Drivers::uart_puts("VFS: Root already mounted!\n");
    80204b0a:	0000d517          	auipc	a0,0xd
    80204b0e:	f8650513          	addi	a0,a0,-122 # 80211a90 <initcode_end+0x348>
    80204b12:	2580406f          	j	80208d6a <_ZN7Drivers9uart_putsEPKc>
            return;
        }
        global_root_inode = root;
        Drivers::uart_puts("[VFS] Root filesystem mounted.\n");
    80204b16:	0000d517          	auipc	a0,0xd
    80204b1a:	f9a50513          	addi	a0,a0,-102 # 80211ab0 <initcode_end+0x368>
        global_root_inode = root;
    80204b1e:	e31c                	sd	a5,0(a4)
        Drivers::uart_puts("[VFS] Root filesystem mounted.\n");
    80204b20:	24a0406f          	j	80208d6a <_ZN7Drivers9uart_putsEPKc>

0000000080204b24 <_ZN3VFS8get_rootEv>:
    }

    Inode *get_root()
    {
    80204b24:	1101                	addi	sp,sp,-32
    80204b26:	e426                	sd	s1,8(sp)
        if (global_root_inode == nullptr)
    80204b28:	00019497          	auipc	s1,0x19
    80204b2c:	0c048493          	addi	s1,s1,192 # 8021dbe8 <_ZL17global_root_inode>
    {
    80204b30:	e822                	sd	s0,16(sp)
        if (global_root_inode == nullptr)
    80204b32:	6080                	ld	s0,0(s1)
    {
    80204b34:	ec06                	sd	ra,24(sp)
        if (global_root_inode == nullptr)
    80204b36:	c015                	beqz	s0,80204b5a <_ZN3VFS8get_rootEv+0x36>
        ip->lock.acquire();
    80204b38:	01840493          	addi	s1,s0,24
    80204b3c:	8526                	mv	a0,s1
    80204b3e:	0f0010ef          	jal	80205c2e <_ZN5Mutex7acquireEv>
        ip->ref_cnt++;
    80204b42:	481c                	lw	a5,16(s0)
        ip->lock.release();
    80204b44:	8526                	mv	a0,s1
        ip->ref_cnt++;
    80204b46:	2785                	addiw	a5,a5,1
    80204b48:	c81c                	sw	a5,16(s0)
        ip->lock.release();
    80204b4a:	156010ef          	jal	80205ca0 <_ZN5Mutex7releaseEv>
            mount_root(fat32_fs.root());
        }
        if (!global_root_inode)
            return nullptr;
        return idup(global_root_inode);
    }
    80204b4e:	60e2                	ld	ra,24(sp)
    80204b50:	8522                	mv	a0,s0
    80204b52:	6442                	ld	s0,16(sp)
    80204b54:	64a2                	ld	s1,8(sp)
    80204b56:	6105                	addi	sp,sp,32
    80204b58:	8082                	ret
            Drivers::uart_puts("[VFS] Lazy init: Mounting FAT32...\n");
    80204b5a:	0000d517          	auipc	a0,0xd
    80204b5e:	f7650513          	addi	a0,a0,-138 # 80211ad0 <initcode_end+0x388>
    80204b62:	208040ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            fat32_fs.init();
    80204b66:	00010517          	auipc	a0,0x10
    80204b6a:	f2253503          	ld	a0,-222(a0) # 80214a88 <_GLOBAL_OFFSET_TABLE_+0x28>
    80204b6e:	ae9fe0ef          	jal	80203656 <_ZN15FAT32FileSystem4initEv>
            mount_root(fat32_fs.root());
    80204b72:	00010517          	auipc	a0,0x10
    80204b76:	f1653503          	ld	a0,-234(a0) # 80214a88 <_GLOBAL_OFFSET_TABLE_+0x28>
    80204b7a:	d9ffe0ef          	jal	80203918 <_ZN15FAT32FileSystem4rootEv>
        if (global_root_inode)
    80204b7e:	6098                	ld	a4,0(s1)
            mount_root(fat32_fs.root());
    80204b80:	87aa                	mv	a5,a0
        if (global_root_inode)
    80204b82:	cf19                	beqz	a4,80204ba0 <_ZN3VFS8get_rootEv+0x7c>
            Drivers::uart_puts("VFS: Root already mounted!\n");
    80204b84:	0000d517          	auipc	a0,0xd
    80204b88:	f0c50513          	addi	a0,a0,-244 # 80211a90 <initcode_end+0x348>
    80204b8c:	1de040ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        if (!global_root_inode)
    80204b90:	6080                	ld	s0,0(s1)
    80204b92:	f05d                	bnez	s0,80204b38 <_ZN3VFS8get_rootEv+0x14>
    }
    80204b94:	60e2                	ld	ra,24(sp)
    80204b96:	8522                	mv	a0,s0
    80204b98:	6442                	ld	s0,16(sp)
    80204b9a:	64a2                	ld	s1,8(sp)
    80204b9c:	6105                	addi	sp,sp,32
    80204b9e:	8082                	ret
        Drivers::uart_puts("[VFS] Root filesystem mounted.\n");
    80204ba0:	0000d517          	auipc	a0,0xd
    80204ba4:	f1050513          	addi	a0,a0,-240 # 80211ab0 <initcode_end+0x368>
        global_root_inode = root;
    80204ba8:	e09c                	sd	a5,0(s1)
        Drivers::uart_puts("[VFS] Root filesystem mounted.\n");
    80204baa:	1c0040ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
    80204bae:	b7cd                	j	80204b90 <_ZN3VFS8get_rootEv+0x6c>

0000000080204bb0 <_ZN3VFS5nameiEPKc>:

    Inode *namei(const char *path)
    {
    80204bb0:	7131                	addi	sp,sp,-192
    80204bb2:	f922                	sd	s0,176(sp)
    80204bb4:	fd06                	sd	ra,184(sp)
    80204bb6:	842a                	mv	s0,a0
    80204bb8:	f526                	sd	s1,168(sp)
    80204bba:	f14a                	sd	s2,160(sp)
        char name[128];
        Inode *ip, *next;
        struct Proc *p = myproc();
    80204bbc:	6c7000ef          	jal	80205a82 <_Z6myprocv>

        // 1. 确定起点
        if (*path == '/')
    80204bc0:	00044703          	lbu	a4,0(s0)
    80204bc4:	02f00793          	li	a5,47
    80204bc8:	0cf70063          	beq	a4,a5,80204c88 <_ZN3VFS5nameiEPKc+0xd8>
        {
            ip = get_root();
        }
        else
        {
            if (p->cwd == nullptr)
    80204bcc:	6164                	ld	s1,192(a0)
    80204bce:	cccd                	beqz	s1,80204c88 <_ZN3VFS5nameiEPKc+0xd8>
        ip->lock.acquire();
    80204bd0:	01848913          	addi	s2,s1,24
    80204bd4:	854a                	mv	a0,s2
    80204bd6:	ed4e                	sd	s3,152(sp)
    80204bd8:	e952                	sd	s4,144(sp)
    80204bda:	054010ef          	jal	80205c2e <_ZN5Mutex7acquireEv>
        ip->ref_cnt++;
    80204bde:	489c                	lw	a5,16(s1)
        ip->lock.release();
    80204be0:	854a                	mv	a0,s2
        ip->ref_cnt++;
    80204be2:	2785                	addiw	a5,a5,1
    80204be4:	c89c                	sw	a5,16(s1)
        ip->lock.release();
    80204be6:	0ba010ef          	jal	80205ca0 <_ZN5Mutex7releaseEv>
            {
                ip = idup(p->cwd);
            }
        }

        if (ip == nullptr)
    80204bea:	890a                	mv	s2,sp
            return nullptr;

        while ((path = skipelem(path, name)) != nullptr)
        {
            if (strcmp(name, ".") == 0)
    80204bec:	0000d997          	auipc	s3,0xd
    80204bf0:	cdc98993          	addi	s3,s3,-804 # 802118c8 <initcode_end+0x180>
            {
                continue;
            }

            if (strcmp(name, "..") == 0)
    80204bf4:	0000da17          	auipc	s4,0xd
    80204bf8:	cdca0a13          	addi	s4,s4,-804 # 802118d0 <initcode_end+0x188>
        while ((path = skipelem(path, name)) != nullptr)
    80204bfc:	8522                	mv	a0,s0
    80204bfe:	85ca                	mv	a1,s2
    80204c00:	d2dff0ef          	jal	8020492c <_ZL8skipelemPKcPc>
    80204c04:	842a                	mv	s0,a0
    80204c06:	c955                	beqz	a0,80204cba <_ZN3VFS5nameiEPKc+0x10a>
            if (strcmp(name, ".") == 0)
    80204c08:	85ce                	mv	a1,s3
    80204c0a:	854a                	mv	a0,s2
    80204c0c:	300000ef          	jal	80204f0c <_Z6strcmpPKcS0_>
    80204c10:	d575                	beqz	a0,80204bfc <_ZN3VFS5nameiEPKc+0x4c>
            if (strcmp(name, "..") == 0)
    80204c12:	85d2                	mv	a1,s4
    80204c14:	854a                	mv	a0,s2
    80204c16:	2f6000ef          	jal	80204f0c <_Z6strcmpPKcS0_>
    80204c1a:	ed39                	bnez	a0,80204c78 <_ZN3VFS5nameiEPKc+0xc8>
            {
                Inode *root = get_root();
    80204c1c:	e556                	sd	s5,136(sp)
    80204c1e:	e15a                	sd	s6,128(sp)
    80204c20:	f05ff0ef          	jal	80204b24 <_ZN3VFS8get_rootEv>
                bool is_root = (ip->inum == root->inum);
    80204c24:	00c52a83          	lw	s5,12(a0)
    80204c28:	00c4ab03          	lw	s6,12(s1)
                iput(root);
    80204c2c:	db1ff0ef          	jal	802049dc <_ZN3VFS4iputEP5Inode>

                if (is_root)
    80204c30:	095b0263          	beq	s6,s5,80204cb4 <_ZN3VFS5nameiEPKc+0x104>
    80204c34:	6aaa                	ld	s5,136(sp)
    80204c36:	6b0a                	ld	s6,128(sp)
        if (ip == 0 || ip->ref_cnt < 1)
    80204c38:	489c                	lw	a5,16(s1)
    80204c3a:	04f05063          	blez	a5,80204c7a <_ZN3VFS5nameiEPKc+0xca>
        ip->lock.acquire();
    80204c3e:	e556                	sd	s5,136(sp)
    80204c40:	01848a93          	addi	s5,s1,24
    80204c44:	8556                	mv	a0,s5
    80204c46:	7e9000ef          	jal	80205c2e <_ZN5Mutex7acquireEv>
                }
            }

            ilock(ip);

            if (ip->type != T_DIR)
    80204c4a:	04849703          	lh	a4,72(s1)
    80204c4e:	4785                	li	a5,1
    80204c50:	06f71e63          	bne	a4,a5,80204ccc <_ZN3VFS5nameiEPKc+0x11c>
            {
                iunlockput(ip);
                return nullptr;
            }

            next = ip->lookup(name);
    80204c54:	609c                	ld	a5,0(s1)
    80204c56:	e15a                	sd	s6,128(sp)
    80204c58:	85ca                	mv	a1,s2
    80204c5a:	779c                	ld	a5,40(a5)
    80204c5c:	8526                	mv	a0,s1
    80204c5e:	9782                	jalr	a5
    80204c60:	8b2a                	mv	s6,a0
        if (ip == 0 || !ip->lock.holding() || ip->ref_cnt < 1)
    80204c62:	8556                	mv	a0,s5
    80204c64:	06c010ef          	jal	80205cd0 <_ZN5Mutex7holdingEv>
    80204c68:	e51d                	bnez	a0,80204c96 <_ZN3VFS5nameiEPKc+0xe6>
            Drivers::uart_puts("panic: iunlock\n");
    80204c6a:	0000d517          	auipc	a0,0xd
    80204c6e:	e1650513          	addi	a0,a0,-490 # 80211a80 <initcode_end+0x338>
    80204c72:	0f8040ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            while (1)
    80204c76:	a001                	j	80204c76 <_ZN3VFS5nameiEPKc+0xc6>
        if (ip == 0 || ip->ref_cnt < 1)
    80204c78:	f0e1                	bnez	s1,80204c38 <_ZN3VFS5nameiEPKc+0x88>
            Drivers::uart_puts("panic: ilock\n");
    80204c7a:	0000d517          	auipc	a0,0xd
    80204c7e:	df650513          	addi	a0,a0,-522 # 80211a70 <initcode_end+0x328>
    80204c82:	0e8040ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            while (1)
    80204c86:	a001                	j	80204c86 <_ZN3VFS5nameiEPKc+0xd6>
            ip = get_root();
    80204c88:	e9dff0ef          	jal	80204b24 <_ZN3VFS8get_rootEv>
    80204c8c:	84aa                	mv	s1,a0
        if (ip == nullptr)
    80204c8e:	c535                	beqz	a0,80204cfa <_ZN3VFS5nameiEPKc+0x14a>
    80204c90:	ed4e                	sd	s3,152(sp)
    80204c92:	e952                	sd	s4,144(sp)
    80204c94:	bf99                	j	80204bea <_ZN3VFS5nameiEPKc+0x3a>
        if (ip == 0 || !ip->lock.holding() || ip->ref_cnt < 1)
    80204c96:	489c                	lw	a5,16(s1)
    80204c98:	fcf059e3          	blez	a5,80204c6a <_ZN3VFS5nameiEPKc+0xba>
        ip->lock.release();
    80204c9c:	8556                	mv	a0,s5
    80204c9e:	002010ef          	jal	80205ca0 <_ZN5Mutex7releaseEv>
        iput(ip);
    80204ca2:	8526                	mv	a0,s1
    80204ca4:	d39ff0ef          	jal	802049dc <_ZN3VFS4iputEP5Inode>
            iunlockput(ip);

            ip = next;
            if (ip == nullptr)
    80204ca8:	040b0b63          	beqz	s6,80204cfe <_ZN3VFS5nameiEPKc+0x14e>
            ip = next;
    80204cac:	84da                	mv	s1,s6
    80204cae:	6aaa                	ld	s5,136(sp)
    80204cb0:	6b0a                	ld	s6,128(sp)
    80204cb2:	b7a9                	j	80204bfc <_ZN3VFS5nameiEPKc+0x4c>
    80204cb4:	6aaa                	ld	s5,136(sp)
    80204cb6:	6b0a                	ld	s6,128(sp)
    80204cb8:	b791                	j	80204bfc <_ZN3VFS5nameiEPKc+0x4c>
    80204cba:	69ea                	ld	s3,152(sp)
    80204cbc:	6a4a                	ld	s4,144(sp)
                return nullptr;
        }

        return ip;
    }
    80204cbe:	70ea                	ld	ra,184(sp)
    80204cc0:	744a                	ld	s0,176(sp)
    80204cc2:	790a                	ld	s2,160(sp)
    80204cc4:	8526                	mv	a0,s1
    80204cc6:	74aa                	ld	s1,168(sp)
    80204cc8:	6129                	addi	sp,sp,192
    80204cca:	8082                	ret
        if (ip == 0 || !ip->lock.holding() || ip->ref_cnt < 1)
    80204ccc:	8556                	mv	a0,s5
    80204cce:	002010ef          	jal	80205cd0 <_ZN5Mutex7holdingEv>
    80204cd2:	c501                	beqz	a0,80204cda <_ZN3VFS5nameiEPKc+0x12a>
    80204cd4:	489c                	lw	a5,16(s1)
    80204cd6:	00f04963          	bgtz	a5,80204ce8 <_ZN3VFS5nameiEPKc+0x138>
            Drivers::uart_puts("panic: iunlock\n");
    80204cda:	0000d517          	auipc	a0,0xd
    80204cde:	da650513          	addi	a0,a0,-602 # 80211a80 <initcode_end+0x338>
    80204ce2:	088040ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            while (1)
    80204ce6:	a001                	j	80204ce6 <_ZN3VFS5nameiEPKc+0x136>
        ip->lock.release();
    80204ce8:	8556                	mv	a0,s5
    80204cea:	7b7000ef          	jal	80205ca0 <_ZN5Mutex7releaseEv>
        iput(ip);
    80204cee:	8526                	mv	a0,s1
    80204cf0:	cedff0ef          	jal	802049dc <_ZN3VFS4iputEP5Inode>
    80204cf4:	69ea                	ld	s3,152(sp)
    80204cf6:	6a4a                	ld	s4,144(sp)
    80204cf8:	6aaa                	ld	s5,136(sp)
            return nullptr;
    80204cfa:	4481                	li	s1,0
    80204cfc:	b7c9                	j	80204cbe <_ZN3VFS5nameiEPKc+0x10e>
    80204cfe:	69ea                	ld	s3,152(sp)
    80204d00:	6a4a                	ld	s4,144(sp)
    80204d02:	6aaa                	ld	s5,136(sp)
    80204d04:	6b0a                	ld	s6,128(sp)
    80204d06:	4481                	li	s1,0
    80204d08:	bf5d                	j	80204cbe <_ZN3VFS5nameiEPKc+0x10e>

0000000080204d0a <_ZN3VFS11nameiparentEPKcPc>:

    Inode *nameiparent(const char* path, char* name)
    {
    80204d0a:	7179                	addi	sp,sp,-48
    80204d0c:	f022                	sd	s0,32(sp)
    80204d0e:	e84a                	sd	s2,16(sp)
    80204d10:	f406                	sd	ra,40(sp)
    80204d12:	ec26                	sd	s1,24(sp)
        Inode* ip;
        Inode* next;

        if (*path == '/')
    80204d14:	00054703          	lbu	a4,0(a0)
    80204d18:	02f00793          	li	a5,47
    {
    80204d1c:	842a                	mv	s0,a0
    80204d1e:	892e                	mv	s2,a1
        if (*path == '/')
    80204d20:	08f70863          	beq	a4,a5,80204db0 <_ZN3VFS11nameiparentEPKcPc+0xa6>
            ip = get_root();
        else
            ip = idup(myproc()->cwd ? myproc()->cwd : get_root());
    80204d24:	55f000ef          	jal	80205a82 <_Z6myprocv>
    80204d28:	617c                	ld	a5,192(a0)
    80204d2a:	c7d9                	beqz	a5,80204db8 <_ZN3VFS11nameiparentEPKcPc+0xae>
    80204d2c:	557000ef          	jal	80205a82 <_Z6myprocv>
    80204d30:	6164                	ld	s1,192(a0)
        if (ip == nullptr)
    80204d32:	cc91                	beqz	s1,80204d4e <_ZN3VFS11nameiparentEPKcPc+0x44>
    80204d34:	e44e                	sd	s3,8(sp)
        ip->lock.acquire();
    80204d36:	01848993          	addi	s3,s1,24
    80204d3a:	854e                	mv	a0,s3
    80204d3c:	6f3000ef          	jal	80205c2e <_ZN5Mutex7acquireEv>
        ip->ref_cnt++;
    80204d40:	489c                	lw	a5,16(s1)
        ip->lock.release();
    80204d42:	854e                	mv	a0,s3
        ip->ref_cnt++;
    80204d44:	2785                	addiw	a5,a5,1
    80204d46:	c89c                	sw	a5,16(s1)
        ip->lock.release();
    80204d48:	759000ef          	jal	80205ca0 <_ZN5Mutex7releaseEv>
        return ip;
    80204d4c:	69a2                	ld	s3,8(sp)

        while ((path = skipelem(path, name)) != nullptr)
    80204d4e:	8522                	mv	a0,s0
    80204d50:	85ca                	mv	a1,s2
    80204d52:	bdbff0ef          	jal	8020492c <_ZL8skipelemPKcPc>
    80204d56:	842a                	mv	s0,a0
    80204d58:	c159                	beqz	a0,80204dde <_ZN3VFS11nameiparentEPKcPc+0xd4>
        {
            if (*path == 0)
    80204d5a:	00044783          	lbu	a5,0(s0)
    80204d5e:	c7c1                	beqz	a5,80204de6 <_ZN3VFS11nameiparentEPKcPc+0xdc>
        if (ip == 0 || ip->ref_cnt < 1)
    80204d60:	c481                	beqz	s1,80204d68 <_ZN3VFS11nameiparentEPKcPc+0x5e>
    80204d62:	489c                	lw	a5,16(s1)
    80204d64:	00f04963          	bgtz	a5,80204d76 <_ZN3VFS11nameiparentEPKcPc+0x6c>
            Drivers::uart_puts("panic: ilock\n");
    80204d68:	0000d517          	auipc	a0,0xd
    80204d6c:	d0850513          	addi	a0,a0,-760 # 80211a70 <initcode_end+0x328>
    80204d70:	7fb030ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            while (1)
    80204d74:	a001                	j	80204d74 <_ZN3VFS11nameiparentEPKcPc+0x6a>
        ip->lock.acquire();
    80204d76:	e44e                	sd	s3,8(sp)
    80204d78:	01848993          	addi	s3,s1,24
    80204d7c:	854e                	mv	a0,s3
    80204d7e:	6b1000ef          	jal	80205c2e <_ZN5Mutex7acquireEv>
            {
                return ip;
            }

            ilock(ip);
            if (ip->type != T_DIR)
    80204d82:	04849703          	lh	a4,72(s1)
    80204d86:	4785                	li	a5,1
            {
                iunlockput(ip);
                return nullptr;
            }

            next = ip->lookup(name);
    80204d88:	85ca                	mv	a1,s2
    80204d8a:	8526                	mv	a0,s1
            if (ip->type != T_DIR)
    80204d8c:	06f71463          	bne	a4,a5,80204df4 <_ZN3VFS11nameiparentEPKcPc+0xea>
            next = ip->lookup(name);
    80204d90:	609c                	ld	a5,0(s1)
    80204d92:	e052                	sd	s4,0(sp)
    80204d94:	779c                	ld	a5,40(a5)
    80204d96:	9782                	jalr	a5
    80204d98:	8a2a                	mv	s4,a0
        if (ip == 0 || !ip->lock.holding() || ip->ref_cnt < 1)
    80204d9a:	854e                	mv	a0,s3
    80204d9c:	735000ef          	jal	80205cd0 <_ZN5Mutex7holdingEv>
    80204da0:	e105                	bnez	a0,80204dc0 <_ZN3VFS11nameiparentEPKcPc+0xb6>
            Drivers::uart_puts("panic: iunlock\n");
    80204da2:	0000d517          	auipc	a0,0xd
    80204da6:	cde50513          	addi	a0,a0,-802 # 80211a80 <initcode_end+0x338>
    80204daa:	7c1030ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            while (1)
    80204dae:	a001                	j	80204dae <_ZN3VFS11nameiparentEPKcPc+0xa4>
            ip = get_root();
    80204db0:	d75ff0ef          	jal	80204b24 <_ZN3VFS8get_rootEv>
    80204db4:	84aa                	mv	s1,a0
    80204db6:	bf61                	j	80204d4e <_ZN3VFS11nameiparentEPKcPc+0x44>
            ip = idup(myproc()->cwd ? myproc()->cwd : get_root());
    80204db8:	d6dff0ef          	jal	80204b24 <_ZN3VFS8get_rootEv>
    80204dbc:	84aa                	mv	s1,a0
    80204dbe:	bf95                	j	80204d32 <_ZN3VFS11nameiparentEPKcPc+0x28>
        if (ip == 0 || !ip->lock.holding() || ip->ref_cnt < 1)
    80204dc0:	489c                	lw	a5,16(s1)
        ip->lock.release();
    80204dc2:	854e                	mv	a0,s3
        if (ip == 0 || !ip->lock.holding() || ip->ref_cnt < 1)
    80204dc4:	fcf05fe3          	blez	a5,80204da2 <_ZN3VFS11nameiparentEPKcPc+0x98>
        ip->lock.release();
    80204dc8:	6d9000ef          	jal	80205ca0 <_ZN5Mutex7releaseEv>
        iput(ip);
    80204dcc:	8526                	mv	a0,s1
    80204dce:	c0fff0ef          	jal	802049dc <_ZN3VFS4iputEP5Inode>
            iunlockput(ip);

            ip = next;
            if (!ip)
    80204dd2:	020a0f63          	beqz	s4,80204e10 <_ZN3VFS11nameiparentEPKcPc+0x106>
            ip = next;
    80204dd6:	84d2                	mv	s1,s4
    80204dd8:	69a2                	ld	s3,8(sp)
    80204dda:	6a02                	ld	s4,0(sp)
    80204ddc:	bf8d                	j	80204d4e <_ZN3VFS11nameiparentEPKcPc+0x44>
                return nullptr;
        }
        iput(ip);
    80204dde:	8526                	mv	a0,s1
    80204de0:	bfdff0ef          	jal	802049dc <_ZN3VFS4iputEP5Inode>
                return nullptr;
    80204de4:	4481                	li	s1,0
        return nullptr;
    }
    80204de6:	70a2                	ld	ra,40(sp)
    80204de8:	7402                	ld	s0,32(sp)
    80204dea:	6942                	ld	s2,16(sp)
    80204dec:	8526                	mv	a0,s1
    80204dee:	64e2                	ld	s1,24(sp)
    80204df0:	6145                	addi	sp,sp,48
    80204df2:	8082                	ret
        if (ip == 0 || !ip->lock.holding() || ip->ref_cnt < 1)
    80204df4:	854e                	mv	a0,s3
    80204df6:	6db000ef          	jal	80205cd0 <_ZN5Mutex7holdingEv>
    80204dfa:	c501                	beqz	a0,80204e02 <_ZN3VFS11nameiparentEPKcPc+0xf8>
    80204dfc:	489c                	lw	a5,16(s1)
    80204dfe:	00f04d63          	bgtz	a5,80204e18 <_ZN3VFS11nameiparentEPKcPc+0x10e>
            Drivers::uart_puts("panic: iunlock\n");
    80204e02:	0000d517          	auipc	a0,0xd
    80204e06:	c7e50513          	addi	a0,a0,-898 # 80211a80 <initcode_end+0x338>
    80204e0a:	761030ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            while (1)
    80204e0e:	a001                	j	80204e0e <_ZN3VFS11nameiparentEPKcPc+0x104>
    80204e10:	69a2                	ld	s3,8(sp)
    80204e12:	6a02                	ld	s4,0(sp)
                return nullptr;
    80204e14:	4481                	li	s1,0
    80204e16:	bfc1                	j	80204de6 <_ZN3VFS11nameiparentEPKcPc+0xdc>
        ip->lock.release();
    80204e18:	854e                	mv	a0,s3
    80204e1a:	687000ef          	jal	80205ca0 <_ZN5Mutex7releaseEv>
        iput(ip);
    80204e1e:	8526                	mv	a0,s1
    80204e20:	bbdff0ef          	jal	802049dc <_ZN3VFS4iputEP5Inode>
                return nullptr;
    80204e24:	4481                	li	s1,0
    80204e26:	69a2                	ld	s3,8(sp)
    80204e28:	bf7d                	j	80204de6 <_ZN3VFS11nameiparentEPKcPc+0xdc>

0000000080204e2a <_Z6memsetPvij>:
#include "lib/string.h"

void *memset(void *dst, int c, uint n)
{
    char *cdst = (char *)dst;
    for (uint i = 0; i < n; i++)
    80204e2a:	ce09                	beqz	a2,80204e44 <_Z6memsetPvij+0x1a>
    80204e2c:	1602                	slli	a2,a2,0x20
    80204e2e:	9201                	srli	a2,a2,0x20
        cdst[i] = c;
    80204e30:	0ff5f593          	zext.b	a1,a1
    80204e34:	87aa                	mv	a5,a0
    80204e36:	00a60733          	add	a4,a2,a0
    80204e3a:	00b78023          	sb	a1,0(a5)
    for (uint i = 0; i < n; i++)
    80204e3e:	0785                	addi	a5,a5,1
    80204e40:	fee79de3          	bne	a5,a4,80204e3a <_Z6memsetPvij+0x10>
    return dst;
}
    80204e44:	8082                	ret

0000000080204e46 <_Z6memcmpPKvS0_j>:

int memcmp(const void *v1, const void *v2, uint n)
{
    const uchar *s1 = (const uchar *)v1;
    const uchar *s2 = (const uchar *)v2;
    while (n-- > 0)
    80204e46:	fff6069b          	addiw	a3,a2,-1
    80204e4a:	c21d                	beqz	a2,80204e70 <_Z6memcmpPKvS0_j+0x2a>
    80204e4c:	1682                	slli	a3,a3,0x20
    80204e4e:	9281                	srli	a3,a3,0x20
    80204e50:	0685                	addi	a3,a3,1
    80204e52:	96aa                	add	a3,a3,a0
    80204e54:	a019                	j	80204e5a <_Z6memcmpPKvS0_j+0x14>
    80204e56:	00a68d63          	beq	a3,a0,80204e70 <_Z6memcmpPKvS0_j+0x2a>
    {
        if (*s1 != *s2)
    80204e5a:	00054783          	lbu	a5,0(a0)
    80204e5e:	0005c703          	lbu	a4,0(a1)
            return *s1 - *s2;
        s1++, s2++;
    80204e62:	0505                	addi	a0,a0,1
    80204e64:	0585                	addi	a1,a1,1
        if (*s1 != *s2)
    80204e66:	fee788e3          	beq	a5,a4,80204e56 <_Z6memcmpPKvS0_j+0x10>
            return *s1 - *s2;
    80204e6a:	40e7853b          	subw	a0,a5,a4
    80204e6e:	8082                	ret
    }
    return 0;
    80204e70:	4501                	li	a0,0
}
    80204e72:	8082                	ret

0000000080204e74 <_Z7memmovePvPKvj>:
    char *d = (char *)dst;
    if (s < d && s + n > d)
    {
        s += n;
        d += n;
        while (n-- > 0)
    80204e74:	fff6071b          	addiw	a4,a2,-1
    if (s < d && s + n > d)
    80204e78:	02a5fb63          	bgeu	a1,a0,80204eae <_Z7memmovePvPKvj+0x3a>
    80204e7c:	02061793          	slli	a5,a2,0x20
    80204e80:	9381                	srli	a5,a5,0x20
    80204e82:	00f586b3          	add	a3,a1,a5
    80204e86:	02d57463          	bgeu	a0,a3,80204eae <_Z7memmovePvPKvj+0x3a>
        d += n;
    80204e8a:	00f505b3          	add	a1,a0,a5
        while (n-- > 0)
    80204e8e:	ce15                	beqz	a2,80204eca <_Z7memmovePvPKvj+0x56>
    80204e90:	02071793          	slli	a5,a4,0x20
    80204e94:	9381                	srli	a5,a5,0x20
    80204e96:	fff7c793          	not	a5,a5
    80204e9a:	97b6                	add	a5,a5,a3
            *--d = *--s;
    80204e9c:	fff6c703          	lbu	a4,-1(a3)
    80204ea0:	16fd                	addi	a3,a3,-1
    80204ea2:	15fd                	addi	a1,a1,-1
    80204ea4:	00e58023          	sb	a4,0(a1)
        while (n-- > 0)
    80204ea8:	fef69ae3          	bne	a3,a5,80204e9c <_Z7memmovePvPKvj+0x28>
    80204eac:	8082                	ret
    }
    else
    {
        while (n-- > 0)
    80204eae:	ce19                	beqz	a2,80204ecc <_Z7memmovePvPKvj+0x58>
    80204eb0:	1702                	slli	a4,a4,0x20
    80204eb2:	9301                	srli	a4,a4,0x20
    80204eb4:	0705                	addi	a4,a4,1
    80204eb6:	972e                	add	a4,a4,a1
    80204eb8:	87aa                	mv	a5,a0
            *d++ = *s++;
    80204eba:	0005c683          	lbu	a3,0(a1)
    80204ebe:	0585                	addi	a1,a1,1
    80204ec0:	0785                	addi	a5,a5,1
    80204ec2:	fed78fa3          	sb	a3,-1(a5)
        while (n-- > 0)
    80204ec6:	feb71ae3          	bne	a4,a1,80204eba <_Z7memmovePvPKvj+0x46>
    }
    return dst;
}
    80204eca:	8082                	ret
    80204ecc:	8082                	ret

0000000080204ece <_Z6memcpyPvPKvj>:

void *memcpy(void *dst, const void *src, uint n)
{
    return memmove(dst, src, n);
    80204ece:	fa7ff06f          	j	80204e74 <_Z7memmovePvPKvj>

0000000080204ed2 <_Z6strcpyPcPKc>:
}

void strcpy(char *dst, const char *src)
{
    while (*src)
    80204ed2:	0005c783          	lbu	a5,0(a1)
    80204ed6:	cb81                	beqz	a5,80204ee6 <_Z6strcpyPcPKc+0x14>
        *dst++ = *src++;
    80204ed8:	00f50023          	sb	a5,0(a0)
    while (*src)
    80204edc:	0015c783          	lbu	a5,1(a1)
        *dst++ = *src++;
    80204ee0:	0585                	addi	a1,a1,1
    80204ee2:	0505                	addi	a0,a0,1
    while (*src)
    80204ee4:	fbf5                	bnez	a5,80204ed8 <_Z6strcpyPcPKc+0x6>
    *dst = 0;
    80204ee6:	00050023          	sb	zero,0(a0)
}
    80204eea:	8082                	ret

0000000080204eec <_Z6strlenPKc>:

int strlen(const char *s)
{
    int n = 0;
    while (s[n])
    80204eec:	00054783          	lbu	a5,0(a0)
    80204ef0:	cf81                	beqz	a5,80204f08 <_Z6strlenPKc+0x1c>
    80204ef2:	0505                	addi	a0,a0,1
    80204ef4:	87aa                	mv	a5,a0
    80204ef6:	0007c703          	lbu	a4,0(a5)
    80204efa:	86be                	mv	a3,a5
    80204efc:	0785                	addi	a5,a5,1
    80204efe:	ff65                	bnez	a4,80204ef6 <_Z6strlenPKc+0xa>
        n++;
    80204f00:	40a6853b          	subw	a0,a3,a0
    80204f04:	2505                	addiw	a0,a0,1
    80204f06:	8082                	ret
    int n = 0;
    80204f08:	4501                	li	a0,0
    return n;
}
    80204f0a:	8082                	ret

0000000080204f0c <_Z6strcmpPKcS0_>:

int strcmp(const char *s1, const char *s2)
{
    while (*s1 && (*s1 == *s2))
    80204f0c:	00054783          	lbu	a5,0(a0)
    80204f10:	e791                	bnez	a5,80204f1c <_Z6strcmpPKcS0_+0x10>
    80204f12:	a02d                	j	80204f3c <_Z6strcmpPKcS0_+0x30>
    80204f14:	00054783          	lbu	a5,0(a0)
    80204f18:	cf89                	beqz	a5,80204f32 <_Z6strcmpPKcS0_+0x26>
    80204f1a:	85b6                	mv	a1,a3
    80204f1c:	0005c703          	lbu	a4,0(a1)
    {
        s1++;
    80204f20:	0505                	addi	a0,a0,1
        s2++;
    80204f22:	00158693          	addi	a3,a1,1
    while (*s1 && (*s1 == *s2))
    80204f26:	fef707e3          	beq	a4,a5,80204f14 <_Z6strcmpPKcS0_+0x8>
    }
    return *(const unsigned char *)s1 - *(const unsigned char *)s2;
    80204f2a:	0007851b          	sext.w	a0,a5
}
    80204f2e:	9d19                	subw	a0,a0,a4
    80204f30:	8082                	ret
    return *(const unsigned char *)s1 - *(const unsigned char *)s2;
    80204f32:	0015c703          	lbu	a4,1(a1)
    80204f36:	4501                	li	a0,0
}
    80204f38:	9d19                	subw	a0,a0,a4
    80204f3a:	8082                	ret
    return *(const unsigned char *)s1 - *(const unsigned char *)s2;
    80204f3c:	0005c703          	lbu	a4,0(a1)
    80204f40:	4501                	li	a0,0
    80204f42:	b7f5                	j	80204f2e <_Z6strcmpPKcS0_+0x22>

0000000080204f44 <_Z10strcasecmpPKcS0_>:

int strcasecmp(const char *s1, const char *s2)
{
    while (*s1)
    80204f44:	00054783          	lbu	a5,0(a0)
    80204f48:	e399                	bnez	a5,80204f4e <_Z10strcasecmpPKcS0_+0xa>
    80204f4a:	a825                	j	80204f82 <_Z10strcasecmpPKcS0_+0x3e>
    80204f4c:	85b6                	mv	a1,a3
    {
        if(*s1 == *s2 || *s1 + 32 == *s2 || *s1 == *s2 + 32){
    80204f4e:	0005c703          	lbu	a4,0(a1)
            s1++;
    80204f52:	0505                	addi	a0,a0,1
        if(*s1 == *s2 || *s1 + 32 == *s2 || *s1 == *s2 + 32){
    80204f54:	02078613          	addi	a2,a5,32
            s2++;
    80204f58:	00158693          	addi	a3,a1,1
        if(*s1 == *s2 || *s1 + 32 == *s2 || *s1 == *s2 + 32){
    80204f5c:	00f70b63          	beq	a4,a5,80204f72 <_Z10strcasecmpPKcS0_+0x2e>
    80204f60:	0007081b          	sext.w	a6,a4
    80204f64:	2781                	sext.w	a5,a5
    80204f66:	02080893          	addi	a7,a6,32
    80204f6a:	00e60463          	beq	a2,a4,80204f72 <_Z10strcasecmpPKcS0_+0x2e>
    80204f6e:	00f89763          	bne	a7,a5,80204f7c <_Z10strcasecmpPKcS0_+0x38>
    while (*s1)
    80204f72:	00054783          	lbu	a5,0(a0)
    80204f76:	fbf9                	bnez	a5,80204f4c <_Z10strcasecmpPKcS0_+0x8>
        }
        else break;
    }
    return *(const unsigned char *)s1 - *(const unsigned char *)s2;
    80204f78:	0015c803          	lbu	a6,1(a1)
    80204f7c:	4107853b          	subw	a0,a5,a6
    80204f80:	8082                	ret
    return *(const unsigned char *)s1 - *(const unsigned char *)s2;
    80204f82:	0005c803          	lbu	a6,0(a1)
    80204f86:	4781                	li	a5,0
    80204f88:	bfd5                	j	80204f7c <_Z10strcasecmpPKcS0_+0x38>

0000000080204f8a <_ZN3SBI8sbi_callEiiyyy>:
        long error;
        long value;
    };

    struct sbiret sbi_call(int ext, int fid, uint64 arg0, uint64 arg1, uint64 arg2)
    {
    80204f8a:	1141                	addi	sp,sp,-16
    80204f8c:	88aa                	mv	a7,a0
    80204f8e:	882e                	mv	a6,a1
        struct sbiret ret;
        register uint64 a0 asm("a0") = arg0;
    80204f90:	8532                	mv	a0,a2
        register uint64 a1 asm("a1") = arg1;
    80204f92:	85b6                	mv	a1,a3
        register uint64 a2 asm("a2") = arg2;
    80204f94:	863a                	mv	a2,a4
        register uint64 a6 asm("a6") = fid;
        register uint64 a7 asm("a7") = ext;

        asm volatile(
    80204f96:	00000073          	ecall
            : "r"(a0), "r"(a1), "r"(a2), "r"(a6), "r"(a7)
            : "memory");
        ret.error = a0;
        ret.value = a1;
        return ret;
    }
    80204f9a:	0141                	addi	sp,sp,16
    80204f9c:	8082                	ret

0000000080204f9e <_ZN3SBI9set_timerEy>:
        register uint64 a7 asm("a7") = ext;
    80204f9e:	544958b7          	lui	a7,0x54495
        register uint64 a1 asm("a1") = arg1;
    80204fa2:	4581                	li	a1,0
        register uint64 a2 asm("a2") = arg2;
    80204fa4:	4601                	li	a2,0
        register uint64 a6 asm("a6") = fid;
    80204fa6:	4801                	li	a6,0
        register uint64 a7 asm("a7") = ext;
    80204fa8:	d4588893          	addi	a7,a7,-699 # 54494d45 <_start-0x2bd6b2bb>
        asm volatile(
    80204fac:	00000073          	ecall

    void set_timer(uint64 stime_value)
    {
        sbi_call(0x54494D45, 0, stime_value, 0, 0);
    }
    80204fb0:	8082                	ret

0000000080204fb2 <_ZN3SBI12sbi_shutdownEv>:
        register uint64 a7 asm("a7") = ext;
    80204fb2:	535258b7          	lui	a7,0x53525
        register uint64 a0 asm("a0") = arg0;
    80204fb6:	4501                	li	a0,0
        register uint64 a1 asm("a1") = arg1;
    80204fb8:	4581                	li	a1,0
        register uint64 a2 asm("a2") = arg2;
    80204fba:	4601                	li	a2,0
        register uint64 a6 asm("a6") = fid;
    80204fbc:	4801                	li	a6,0
        register uint64 a7 asm("a7") = ext;
    80204fbe:	35488893          	addi	a7,a7,852 # 53525354 <_start-0x2ccdacac>
        asm volatile(
    80204fc2:	00000073          	ecall
        register uint64 a0 asm("a0") = arg0;
    80204fc6:	4501                	li	a0,0
        register uint64 a1 asm("a1") = arg1;
    80204fc8:	4581                	li	a1,0
        register uint64 a7 asm("a7") = ext;
    80204fca:	48a1                	li	a7,8
        asm volatile(
    80204fcc:	00000073          	ecall

    void sbi_shutdown()
    {
        sbi_call(0x53525354, 0, 0, 0, 0);
        sbi_call(0x08, 0, 0, 0, 0);
        while (1)
    80204fd0:	a001                	j	80204fd0 <_ZN3SBI12sbi_shutdownEv+0x1e>

0000000080204fd2 <_ZN3SBI10sbi_rebootEv>:
        register uint64 a7 asm("a7") = ext;
    80204fd2:	535258b7          	lui	a7,0x53525
        register uint64 a0 asm("a0") = arg0;
    80204fd6:	4505                	li	a0,1
        register uint64 a1 asm("a1") = arg1;
    80204fd8:	4581                	li	a1,0
        register uint64 a2 asm("a2") = arg2;
    80204fda:	4601                	li	a2,0
        register uint64 a6 asm("a6") = fid;
    80204fdc:	4801                	li	a6,0
        register uint64 a7 asm("a7") = ext;
    80204fde:	35488893          	addi	a7,a7,852 # 53525354 <_start-0x2ccdacac>
        asm volatile(
    80204fe2:	00000073          	ecall
    }

    void sbi_reboot()
    {
        sbi_call(SBI_EID_SRST, SBI_FID_SRST_RESET, SBI_SRST_TYPE_COLD_REBOOT, SBI_SRST_REASON_NONE, 0);
    }
    80204fe6:	8082                	ret

0000000080204fe8 <_ZL8sys_execv>:

    return ret;
}

static uint64 sys_exec()
{
    80204fe8:	7105                	addi	sp,sp,-480
    80204fea:	ef86                	sd	ra,472(sp)
    80204fec:	eba2                	sd	s0,464(sp)
    80204fee:	ff4e                	sd	s3,440(sp)
    80204ff0:	f756                	sd	s5,424(sp)
    Proc *p = myproc();
    80204ff2:	291000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a0;
    80204ff6:	793c                	ld	a5,112(a0)
    return VM::copyinstr(myproc()->pagetable, buf, addr, max);
    80204ff8:	01010a93          	addi	s5,sp,16
    80204ffc:	59fd                	li	s3,-1
        return p->tf->a0;
    80204ffe:	7ba0                	ld	s0,112(a5)
    return VM::copyinstr(myproc()->pagetable, buf, addr, max);
    80205000:	283000ef          	jal	80205a82 <_Z6myprocv>
    80205004:	7d28                	ld	a0,120(a0)
    80205006:	08000693          	li	a3,128
    8020500a:	8622                	mv	a2,s0
    8020500c:	85d6                	mv	a1,s5
    8020500e:	502010ef          	jal	80206510 <_ZN2VM9copyinstrEPyPcyy>
    char path[128];
    uint64 uargv_ptr;

    if (argstr(0, path, sizeof(path)) < 0)
    80205012:	0a054563          	bltz	a0,802050bc <_ZL8sys_execv+0xd4>
    Proc *p = myproc();
    80205016:	e7a6                	sd	s1,456(sp)
    80205018:	e3ca                	sd	s2,448(sp)
    8020501a:	fb52                	sd	s4,432(sp)
    8020501c:	f35a                	sd	s6,416(sp)
    8020501e:	ef5e                	sd	s7,408(sp)
    80205020:	263000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a1;
    80205024:	793c                	ld	a5,112(a0)
        memset(args, 0, sizeof(args));
    80205026:	09010913          	addi	s2,sp,144
    8020502a:	10000613          	li	a2,256
        return p->tf->a1;
    8020502e:	0787ba03          	ld	s4,120(a5)
        memset(args, 0, sizeof(args));
    80205032:	4581                	li	a1,0
    80205034:	854a                	mv	a0,s2
    80205036:	df5ff0ef          	jal	80204e2a <_Z6memsetPvij>

    uargv_ptr = argraw(1);

    KernelArgv kargv;

    for (int i = 0; i < KernelArgv::MAX_ARGS; ++i)
    8020503a:	844a                	mv	s0,s2
        memset(args, 0, sizeof(args));
    8020503c:	84ca                	mv	s1,s2
    for (int i = 0; i < KernelArgv::MAX_ARGS; ++i)
    8020503e:	4981                	li	s3,0
    80205040:	412a0a33          	sub	s4,s4,s2
    80205044:	00810b13          	addi	s6,sp,8
    80205048:	02000b93          	li	s7,32
    {
        uint64 uarg_str_ptr;

        if (VM::copyin(myproc()->pagetable, (char *)&uarg_str_ptr, uargv_ptr + i * sizeof(uint64), sizeof(uint64)) < 0)
    8020504c:	237000ef          	jal	80205a82 <_Z6myprocv>
    80205050:	7d28                	ld	a0,120(a0)
    80205052:	46a1                	li	a3,8
    80205054:	009a0633          	add	a2,s4,s1
    80205058:	85da                	mv	a1,s6
    8020505a:	426010ef          	jal	80206480 <_ZN2VM6copyinEPyPcyy>
    8020505e:	87aa                	mv	a5,a0
        {
            kargv.args[i] = nullptr;
            break;
        }

        kargv.args[i] = (char *)Slab::kmalloc(KernelArgv::MAX_ARG_LEN);
    80205060:	08000513          	li	a0,128
        if (VM::copyin(myproc()->pagetable, (char *)&uarg_str_ptr, uargv_ptr + i * sizeof(uint64), sizeof(uint64)) < 0)
    80205064:	0607c363          	bltz	a5,802050ca <_ZL8sys_execv+0xe2>
        if (uarg_str_ptr == 0)
    80205068:	67a2                	ld	a5,8(sp)
    8020506a:	c3b5                	beqz	a5,802050ce <_ZL8sys_execv+0xe6>
        kargv.args[i] = (char *)Slab::kmalloc(KernelArgv::MAX_ARG_LEN);
    8020506c:	0fd010ef          	jal	80206968 <_ZN4Slab7kmallocEy>
    80205070:	e088                	sd	a0,0(s1)
        if (kargv.args[i] == nullptr)
    80205072:	cd21                	beqz	a0,802050ca <_ZL8sys_execv+0xe2>
        {
            return -1;
        }

        if (VM::copyinstr(myproc()->pagetable, kargv.args[i], uarg_str_ptr, KernelArgv::MAX_ARG_LEN) < 0)
    80205074:	20f000ef          	jal	80205a82 <_Z6myprocv>
    80205078:	6622                	ld	a2,8(sp)
    8020507a:	608c                	ld	a1,0(s1)
    8020507c:	7d28                	ld	a0,120(a0)
    8020507e:	08000693          	li	a3,128
    for (int i = 0; i < KernelArgv::MAX_ARGS; ++i)
    80205082:	2985                	addiw	s3,s3,1
        if (VM::copyinstr(myproc()->pagetable, kargv.args[i], uarg_str_ptr, KernelArgv::MAX_ARG_LEN) < 0)
    80205084:	48c010ef          	jal	80206510 <_ZN2VM9copyinstrEPyPcyy>
    80205088:	04054163          	bltz	a0,802050ca <_ZL8sys_execv+0xe2>
    for (int i = 0; i < KernelArgv::MAX_ARGS; ++i)
    8020508c:	04a1                	addi	s1,s1,8
    8020508e:	fb799fe3          	bne	s3,s7,8020504c <_ZL8sys_execv+0x64>
        {
            return -1;
        }
    }

    return Exec::exec(path, kargv.args);
    80205092:	85ca                	mv	a1,s2
    80205094:	8556                	mv	a0,s5
    80205096:	262020ef          	jal	802072f8 <_ZN4Exec4execEPcPS0_>
    8020509a:	89aa                	mv	s3,a0
        for (int i = 0; i < MAX_ARGS; i++)
    8020509c:	10090913          	addi	s2,s2,256
            if (args[i])
    802050a0:	6008                	ld	a0,0(s0)
    802050a2:	c509                	beqz	a0,802050ac <_ZL8sys_execv+0xc4>
                Slab::kfree(args[i]);
    802050a4:	295010ef          	jal	80206b38 <_ZN4Slab5kfreeEPv>
                args[i] = nullptr;
    802050a8:	00043023          	sd	zero,0(s0)
        for (int i = 0; i < MAX_ARGS; i++)
    802050ac:	0421                	addi	s0,s0,8
    802050ae:	ff2419e3          	bne	s0,s2,802050a0 <_ZL8sys_execv+0xb8>
    802050b2:	64be                	ld	s1,456(sp)
    802050b4:	691e                	ld	s2,448(sp)
    802050b6:	7a5a                	ld	s4,432(sp)
    802050b8:	7b1a                	ld	s6,416(sp)
    802050ba:	6bfa                	ld	s7,408(sp)
}
    802050bc:	60fe                	ld	ra,472(sp)
    802050be:	645e                	ld	s0,464(sp)
    802050c0:	7aba                	ld	s5,424(sp)
    802050c2:	854e                	mv	a0,s3
    802050c4:	79fa                	ld	s3,440(sp)
    802050c6:	613d                	addi	sp,sp,480
    802050c8:	8082                	ret
            return -1;
    802050ca:	59fd                	li	s3,-1
    802050cc:	bfc1                	j	8020509c <_ZL8sys_execv+0xb4>
            kargv.args[i] = nullptr;
    802050ce:	00399793          	slli	a5,s3,0x3
    802050d2:	19078793          	addi	a5,a5,400
    802050d6:	978a                	add	a5,a5,sp
    return Exec::exec(path, kargv.args);
    802050d8:	85ca                	mv	a1,s2
    802050da:	8556                	mv	a0,s5
            kargv.args[i] = nullptr;
    802050dc:	f007b023          	sd	zero,-256(a5)
    return Exec::exec(path, kargv.args);
    802050e0:	218020ef          	jal	802072f8 <_ZN4Exec4execEPcPS0_>
    802050e4:	89aa                	mv	s3,a0
    802050e6:	bf5d                	j	8020509c <_ZL8sys_execv+0xb4>

00000000802050e8 <_Z7syscallv>:
        ;
    return 0;
}

void syscall()
{
    802050e8:	7149                	addi	sp,sp,-368
    802050ea:	f2a2                	sd	s0,352(sp)
    802050ec:	eea6                	sd	s1,344(sp)
    802050ee:	f686                	sd	ra,360(sp)
    Proc *p = myproc();
    802050f0:	193000ef          	jal	80205a82 <_Z6myprocv>
    int num = p->tf->a7;
    802050f4:	7938                	ld	a4,112(a0)
    /* Just For Debug */
    // Drivers::uart_puts("Syscall: ");
    // Drivers::print_hex(num);
    // Drivers::uart_puts("\n");

    switch (num)
    802050f6:	47e5                	li	a5,25
    Proc *p = myproc();
    802050f8:	842a                	mv	s0,a0
    int num = p->tf->a7;
    802050fa:	0a872483          	lw	s1,168(a4)
    switch (num)
    802050fe:	4e97ec63          	bltu	a5,s1,802055f6 <_Z7syscallv+0x50e>
    80205102:	0000d717          	auipc	a4,0xd
    80205106:	49e70713          	addi	a4,a4,1182 # 802125a0 <initcode_end+0xe58>
    8020510a:	00249793          	slli	a5,s1,0x2
    8020510e:	97ba                	add	a5,a5,a4
    80205110:	439c                	lw	a5,0(a5)
    80205112:	97ba                	add	a5,a5,a4
    80205114:	8782                	jr	a5
    SBI::sbi_shutdown();
    80205116:	e9dff0ef          	jal	80204fb2 <_ZN3SBI12sbi_shutdownEv>
    while (1)
    8020511a:	a001                	j	8020511a <_Z7syscallv+0x32>
    Proc *p = myproc();
    8020511c:	eaca                	sd	s2,336(sp)
    8020511e:	e6ce                	sd	s3,328(sp)
    80205120:	163000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a0;
    80205124:	793c                	ld	a5,112(a0)
    *ip = static_cast<int>(argraw(n));
    80205126:	5ba4                	lw	s1,112(a5)
    Proc *p = myproc();
    80205128:	15b000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a1;
    8020512c:	793c                	ld	a5,112(a0)
    8020512e:	0787b903          	ld	s2,120(a5)
    Proc *p = myproc();
    80205132:	151000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a2;
    80205136:	793c                	ld	a5,112(a0)
    80205138:	0807b983          	ld	s3,128(a5)
    struct Proc *p = myproc();
    8020513c:	147000ef          	jal	80205a82 <_Z6myprocv>
    if (fd < 0 || fd >= NOFILE || p->ofile[fd] == 0)
    80205140:	47bd                	li	a5,15
    80205142:	6097e263          	bltu	a5,s1,80205746 <_Z7syscallv+0x65e>
    80205146:	01848793          	addi	a5,s1,24
    8020514a:	078e                	slli	a5,a5,0x3
    8020514c:	953e                	add	a0,a0,a5
    8020514e:	6508                	ld	a0,8(a0)
    80205150:	5e050b63          	beqz	a0,80205746 <_Z7syscallv+0x65e>
    return FileTable::lseek(p->ofile[fd], offset, whence);
    80205154:	0009861b          	sext.w	a2,s3
    80205158:	0009059b          	sext.w	a1,s2
    8020515c:	c72fe0ef          	jal	802035ce <_ZN9FileTable5lseekEP4fileii>
    80205160:	6956                	ld	s2,336(sp)
    80205162:	69b6                	ld	s3,328(sp)
    80205164:	84aa                	mv	s1,a0
        Drivers::uart_puts("\n");
        ret = static_cast<uint64>(-1);
        break;
    }

    p->tf->a0 = ret;
    80205166:	783c                	ld	a5,112(s0)
    80205168:	fba4                	sd	s1,112(a5)
    8020516a:	70b6                	ld	ra,360(sp)
    8020516c:	7416                	ld	s0,352(sp)
    8020516e:	64f6                	ld	s1,344(sp)
    80205170:	6175                	addi	sp,sp,368
    80205172:	8082                	ret
    fat32_test();
    80205174:	e06ff0ef          	jal	8020477a <_Z10fat32_testv>
    return 0;
    80205178:	4481                	li	s1,0
    8020517a:	b7f5                	j	80205166 <_Z7syscallv+0x7e>
        Drivers::uart_puts("Unimplemented syscall\n");
    8020517c:	0000d517          	auipc	a0,0xd
    80205180:	99c50513          	addi	a0,a0,-1636 # 80211b18 <initcode_end+0x3d0>
    80205184:	3e7030ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
    Drivers::uart_puts("Not supported now");
    80205188:	0000d517          	auipc	a0,0xd
    8020518c:	9a850513          	addi	a0,a0,-1624 # 80211b30 <initcode_end+0x3e8>
    80205190:	3db030ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        ret = sys_exec();
    80205194:	54fd                	li	s1,-1
    80205196:	bfc1                	j	80205166 <_Z7syscallv+0x7e>
    Proc *p = myproc();
    80205198:	0eb000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a0;
    8020519c:	793c                	ld	a5,112(a0)
    *ip = static_cast<int>(argraw(n));
    8020519e:	5ba4                	lw	s1,112(a5)
    struct Proc *p = myproc();
    802051a0:	0e3000ef          	jal	80205a82 <_Z6myprocv>
    if (fd < 0 || fd >= NOFILE || p->ofile[fd] == 0)
    802051a4:	47bd                	li	a5,15
    802051a6:	fe97e7e3          	bltu	a5,s1,80205194 <_Z7syscallv+0xac>
    802051aa:	048e                	slli	s1,s1,0x3
    802051ac:	94aa                	add	s1,s1,a0
    802051ae:	64e8                	ld	a0,200(s1)
    802051b0:	d175                	beqz	a0,80205194 <_Z7syscallv+0xac>
    FileTable::close(p->ofile[fd]);
    802051b2:	8e2fe0ef          	jal	80203294 <_ZN9FileTable5closeEP4file>
    p->ofile[fd] = 0;
    802051b6:	0c04b423          	sd	zero,200(s1)
    return 0;
    802051ba:	4481                	li	s1,0
    802051bc:	b76d                	j	80205166 <_Z7syscallv+0x7e>
    Proc *p = myproc();
    802051be:	eaca                	sd	s2,336(sp)
    802051c0:	0c3000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a0;
    802051c4:	793c                	ld	a5,112(a0)
    return VM::copyinstr(myproc()->pagetable, buf, addr, max);
    802051c6:	0804                	addi	s1,sp,16
        return p->tf->a0;
    802051c8:	0707b903          	ld	s2,112(a5)
    return VM::copyinstr(myproc()->pagetable, buf, addr, max);
    802051cc:	0b7000ef          	jal	80205a82 <_Z6myprocv>
    802051d0:	7d28                	ld	a0,120(a0)
    802051d2:	08000693          	li	a3,128
    802051d6:	864a                	mv	a2,s2
    802051d8:	85a6                	mv	a1,s1
    802051da:	336010ef          	jal	80206510 <_ZN2VM9copyinstrEPyPcyy>
    if (argstr(0, path, 128) < 0 || argint(1, &major) < 0 || argint(2, &minor) < 0)
    802051de:	42055d63          	bgez	a0,80205618 <_Z7syscallv+0x530>
    802051e2:	6956                	ld	s2,336(sp)
        return -1;
    802051e4:	54fd                	li	s1,-1
    802051e6:	b741                	j	80205166 <_Z7syscallv+0x7e>
    Proc *p = myproc();
    802051e8:	eaca                	sd	s2,336(sp)
    802051ea:	e2d2                	sd	s4,320(sp)
    802051ec:	f65e                	sd	s7,296(sp)
    802051ee:	095000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a0;
    802051f2:	793c                	ld	a5,112(a0)
    *ip = static_cast<int>(argraw(n));
    802051f4:	0707a903          	lw	s2,112(a5)
    Proc *p = myproc();
    802051f8:	08b000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a2;
    802051fc:	793c                	ld	a5,112(a0)
    *ip = static_cast<int>(argraw(n));
    802051fe:	0807a483          	lw	s1,128(a5)
    Proc *p = myproc();
    80205202:	081000ef          	jal	80205a82 <_Z6myprocv>
    struct Proc *proc = myproc();
    80205206:	07d000ef          	jal	80205a82 <_Z6myprocv>
    8020520a:	8a2a                	mv	s4,a0
    Proc *p = myproc();
    8020520c:	077000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a1;
    80205210:	7938                	ld	a4,112(a0)
    if (fd == 1 && proc->ofile[fd] == nullptr) // stdout
    80205212:	4785                	li	a5,1
        return p->tf->a1;
    80205214:	07873b83          	ld	s7,120(a4)
    if (fd == 1 && proc->ofile[fd] == nullptr) // stdout
    80205218:	56f90e63          	beq	s2,a5,80205794 <_Z7syscallv+0x6ac>
    if (fd < 0 || fd >= NOFILE || (f = proc->ofile[fd]) == 0)
    8020521c:	47bd                	li	a5,15
    8020521e:	5f27e363          	bltu	a5,s2,80205804 <_Z7syscallv+0x71c>
    80205222:	01890793          	addi	a5,s2,24
    80205226:	078e                	slli	a5,a5,0x3
    80205228:	9a3e                	add	s4,s4,a5
    8020522a:	008a3503          	ld	a0,8(s4)
    8020522e:	5c050b63          	beqz	a0,80205804 <_Z7syscallv+0x71c>
    return FileTable::write(f, p, n);
    80205232:	8626                	mv	a2,s1
    80205234:	85de                	mv	a1,s7
    80205236:	acefe0ef          	jal	80203504 <_ZN9FileTable5writeEP4fileyi>
    8020523a:	84aa                	mv	s1,a0
    8020523c:	6956                	ld	s2,336(sp)
    8020523e:	6a16                	ld	s4,320(sp)
    80205240:	7bb2                	ld	s7,296(sp)
    80205242:	b715                	j	80205166 <_Z7syscallv+0x7e>
    Proc *p = myproc();
    80205244:	eaca                	sd	s2,336(sp)
    80205246:	03d000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a0;
    8020524a:	793c                	ld	a5,112(a0)
    return VM::copyinstr(myproc()->pagetable, buf, addr, max);
    8020524c:	0804                	addi	s1,sp,16
        return p->tf->a0;
    8020524e:	0707b903          	ld	s2,112(a5)
    return VM::copyinstr(myproc()->pagetable, buf, addr, max);
    80205252:	031000ef          	jal	80205a82 <_Z6myprocv>
    80205256:	7d28                	ld	a0,120(a0)
    80205258:	08000693          	li	a3,128
    8020525c:	864a                	mv	a2,s2
    8020525e:	85a6                	mv	a1,s1
    80205260:	2b0010ef          	jal	80206510 <_ZN2VM9copyinstrEPyPcyy>
    if (argstr(0, path, 128) < 0)
    80205264:	f6054fe3          	bltz	a0,802051e2 <_Z7syscallv+0xfa>
    80205268:	e6ce                	sd	s3,328(sp)
    Inode *dp = VFS::nameiparent(path, name);
    8020526a:	09010993          	addi	s3,sp,144
    8020526e:	85ce                	mv	a1,s3
    80205270:	8526                	mv	a0,s1
    80205272:	a99ff0ef          	jal	80204d0a <_ZN3VFS11nameiparentEPKcPc>
    80205276:	892a                	mv	s2,a0
    if (!dp)
    80205278:	50050c63          	beqz	a0,80205790 <_Z7syscallv+0x6a8>
    VFS::ilock(dp);
    8020527c:	fe4ff0ef          	jal	80204a60 <_ZN3VFS5ilockEP5Inode>
    int ret = dp->unlink(name);
    80205280:	00093783          	ld	a5,0(s2)
    80205284:	85ce                	mv	a1,s3
    80205286:	854a                	mv	a0,s2
    80205288:	67bc                	ld	a5,72(a5)
    8020528a:	9782                	jalr	a5
    8020528c:	84aa                	mv	s1,a0
    VFS::iunlockput(dp);
    8020528e:	854a                	mv	a0,s2
    80205290:	82bff0ef          	jal	80204aba <_ZN3VFS10iunlockputEP5Inode>
        break;
    80205294:	6956                	ld	s2,336(sp)
    80205296:	69b6                	ld	s3,328(sp)
    80205298:	b5f9                	j	80205166 <_Z7syscallv+0x7e>
    Proc *p = myproc();
    8020529a:	eaca                	sd	s2,336(sp)
    8020529c:	7e6000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a0;
    802052a0:	793c                	ld	a5,112(a0)
    return VM::copyinstr(myproc()->pagetable, buf, addr, max);
    802052a2:	0804                	addi	s1,sp,16
        return p->tf->a0;
    802052a4:	0707b903          	ld	s2,112(a5)
    return VM::copyinstr(myproc()->pagetable, buf, addr, max);
    802052a8:	7da000ef          	jal	80205a82 <_Z6myprocv>
    802052ac:	7d28                	ld	a0,120(a0)
    802052ae:	08000693          	li	a3,128
    802052b2:	864a                	mv	a2,s2
    802052b4:	85a6                	mv	a1,s1
    802052b6:	25a010ef          	jal	80206510 <_ZN2VM9copyinstrEPyPcyy>
    if (argstr(0, path, 128) < 0)
    802052ba:	f20544e3          	bltz	a0,802051e2 <_Z7syscallv+0xfa>
    Inode *ip = VFS::namei(path);
    802052be:	8526                	mv	a0,s1
    802052c0:	8f1ff0ef          	jal	80204bb0 <_ZN3VFS5nameiEPKc>
    if (ip != nullptr)
    802052c4:	54051663          	bnez	a0,80205810 <_Z7syscallv+0x728>
    Inode *dp = VFS::nameiparent(path, name);
    802052c8:	09010913          	addi	s2,sp,144
    802052cc:	8526                	mv	a0,s1
    802052ce:	85ca                	mv	a1,s2
    802052d0:	a3bff0ef          	jal	80204d0a <_ZN3VFS11nameiparentEPKcPc>
    802052d4:	84aa                	mv	s1,a0
    if (dp == nullptr)
    802052d6:	f00506e3          	beqz	a0,802051e2 <_Z7syscallv+0xfa>
    VFS::ilock(dp);
    802052da:	f86ff0ef          	jal	80204a60 <_ZN3VFS5ilockEP5Inode>
    ip = dp->create(name, T_DIR, 0, 0);
    802052de:	609c                	ld	a5,0(s1)
    802052e0:	8526                	mv	a0,s1
    802052e2:	4701                	li	a4,0
    802052e4:	7b9c                	ld	a5,48(a5)
    802052e6:	4681                	li	a3,0
    802052e8:	4605                	li	a2,1
    802052ea:	85ca                	mv	a1,s2
    802052ec:	9782                	jalr	a5
    802052ee:	87aa                	mv	a5,a0
    VFS::iunlockput(dp);
    802052f0:	8526                	mv	a0,s1
    ip = dp->create(name, T_DIR, 0, 0);
    802052f2:	84be                	mv	s1,a5
    VFS::iunlockput(dp);
    802052f4:	fc6ff0ef          	jal	80204aba <_ZN3VFS10iunlockputEP5Inode>
    if (ip == nullptr)
    802052f8:	ee0485e3          	beqz	s1,802051e2 <_Z7syscallv+0xfa>
    VFS::iput(ip);
    802052fc:	8526                	mv	a0,s1
    802052fe:	edeff0ef          	jal	802049dc <_ZN3VFS4iputEP5Inode>
    return 0;
    80205302:	4481                	li	s1,0
        break;
    80205304:	6956                	ld	s2,336(sp)
    80205306:	b585                	j	80205166 <_Z7syscallv+0x7e>
    Proc *p = myproc();
    80205308:	eaca                	sd	s2,336(sp)
    8020530a:	778000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a0;
    8020530e:	793c                	ld	a5,112(a0)
    return VM::copyinstr(myproc()->pagetable, buf, addr, max);
    80205310:	0804                	addi	s1,sp,16
        return p->tf->a0;
    80205312:	0707b903          	ld	s2,112(a5)
    return VM::copyinstr(myproc()->pagetable, buf, addr, max);
    80205316:	76c000ef          	jal	80205a82 <_Z6myprocv>
    8020531a:	7d28                	ld	a0,120(a0)
    8020531c:	08000693          	li	a3,128
    80205320:	864a                	mv	a2,s2
    80205322:	85a6                	mv	a1,s1
    80205324:	1ec010ef          	jal	80206510 <_ZN2VM9copyinstrEPyPcyy>
    if (argstr(0, path, 128) < 0 || argint(1, &omode) < 0)
    80205328:	ea054de3          	bltz	a0,802051e2 <_Z7syscallv+0xfa>
    Proc *p = myproc();
    8020532c:	e6ce                	sd	s3,328(sp)
    8020532e:	754000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a1;
    80205332:	793c                	ld	a5,112(a0)
        ip = VFS::namei(path);
    80205334:	8526                	mv	a0,s1
    *ip = static_cast<int>(argraw(n));
    80205336:	0787a903          	lw	s2,120(a5)
    if (omode & O_CREATE)
    8020533a:	20097793          	andi	a5,s2,512
    8020533e:	44078463          	beqz	a5,80205786 <_Z7syscallv+0x69e>
        ip = VFS::namei(path);
    80205342:	86fff0ef          	jal	80204bb0 <_ZN3VFS5nameiEPKc>
    80205346:	89aa                	mv	s3,a0
        if (ip == nullptr)
    80205348:	4e050e63          	beqz	a0,80205844 <_Z7syscallv+0x75c>
    VFS::ilock(ip);
    8020534c:	854e                	mv	a0,s3
    8020534e:	e2d2                	sd	s4,320(sp)
    80205350:	f10ff0ef          	jal	80204a60 <_ZN3VFS5ilockEP5Inode>
    if ((omode & O_TRUNC) && ip->type == T_FILE)
    80205354:	40097793          	andi	a5,s2,1024
    80205358:	cb99                	beqz	a5,8020536e <_Z7syscallv+0x286>
    8020535a:	04899703          	lh	a4,72(s3)
    8020535e:	4789                	li	a5,2
    80205360:	00f71763          	bne	a4,a5,8020536e <_Z7syscallv+0x286>
        ip->truncate();
    80205364:	0009b783          	ld	a5,0(s3)
    80205368:	854e                	mv	a0,s3
    8020536a:	63bc                	ld	a5,64(a5)
    8020536c:	9782                	jalr	a5
    VFS::iunlock(ip);
    8020536e:	854e                	mv	a0,s3
    80205370:	f10ff0ef          	jal	80204a80 <_ZN3VFS7iunlockEP5Inode>
    f = FileTable::alloc();
    80205374:	e7dfd0ef          	jal	802031f0 <_ZN9FileTable5allocEv>
    80205378:	8a2a                	mv	s4,a0
    if (f == nullptr)
    8020537a:	c105                	beqz	a0,8020539a <_Z7syscallv+0x2b2>
    struct Proc *p = myproc();
    8020537c:	706000ef          	jal	80205a82 <_Z6myprocv>
    for (int i = 0; i < NOFILE; i++)
    80205380:	0c850793          	addi	a5,a0,200
    80205384:	4481                	li	s1,0
    80205386:	46c1                	li	a3,16
        if (p->ofile[i] == 0)
    80205388:	6398                	ld	a4,0(a5)
    8020538a:	30070863          	beqz	a4,8020569a <_Z7syscallv+0x5b2>
    for (int i = 0; i < NOFILE; i++)
    8020538e:	2485                	addiw	s1,s1,1
    80205390:	07a1                	addi	a5,a5,8
    80205392:	fed49be3          	bne	s1,a3,80205388 <_Z7syscallv+0x2a0>
        f->type = FD_NONE;
    80205396:	000a3023          	sd	zero,0(s4)
        VFS::iput(ip);
    8020539a:	854e                	mv	a0,s3
    8020539c:	e40ff0ef          	jal	802049dc <_ZN3VFS4iputEP5Inode>
        return -1;
    802053a0:	69b6                	ld	s3,328(sp)
    802053a2:	6a16                	ld	s4,320(sp)
    802053a4:	bd3d                	j	802051e2 <_Z7syscallv+0xfa>
        ret = sys_exec();
    802053a6:	c43ff0ef          	jal	80204fe8 <_ZL8sys_execv>
        if (ret != static_cast<uint64>(-1))
    802053aa:	57fd                	li	a5,-1
    802053ac:	daf51fe3          	bne	a0,a5,8020516a <_Z7syscallv+0x82>
    802053b0:	b3d5                	j	80205194 <_Z7syscallv+0xac>
    Proc *p = myproc();
    802053b2:	eaca                	sd	s2,336(sp)
    802053b4:	e6ce                	sd	s3,328(sp)
    802053b6:	e2d2                	sd	s4,320(sp)
    802053b8:	6ca000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a0;
    802053bc:	793c                	ld	a5,112(a0)
    *ip = static_cast<int>(argraw(n));
    802053be:	0707a903          	lw	s2,112(a5)
    Proc *p = myproc();
    802053c2:	6c0000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a2;
    802053c6:	793c                	ld	a5,112(a0)
    *ip = static_cast<int>(argraw(n));
    802053c8:	0807a983          	lw	s3,128(a5)
    Proc *p = myproc();
    802053cc:	6b6000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a1;
    802053d0:	793c                	ld	a5,112(a0)
    *ip = static_cast<int>(argraw(n));
    802053d2:	0787ea03          	lwu	s4,120(a5)
    struct Proc* proc = myproc();
    802053d6:	6ac000ef          	jal	80205a82 <_Z6myprocv>
    if (fd == 0 && proc->ofile[fd] == nullptr)
    802053da:	32091d63          	bnez	s2,80205714 <_Z7syscallv+0x62c>
    802053de:	6568                	ld	a0,200(a0)
    802053e0:	44050863          	beqz	a0,80205830 <_Z7syscallv+0x748>
    return FileTable::read(f, p, n);
    802053e4:	864e                	mv	a2,s3
    802053e6:	85d2                	mv	a1,s4
    802053e8:	8a6fe0ef          	jal	8020348e <_ZN9FileTable4readEP4fileyi>
    802053ec:	84aa                	mv	s1,a0
    802053ee:	6956                	ld	s2,336(sp)
    802053f0:	69b6                	ld	s3,328(sp)
    802053f2:	6a16                	ld	s4,320(sp)
    802053f4:	bb8d                	j	80205166 <_Z7syscallv+0x7e>
    struct Proc *p = myproc();
    802053f6:	eaca                	sd	s2,336(sp)
    802053f8:	68a000ef          	jal	80205a82 <_Z6myprocv>
    802053fc:	84aa                	mv	s1,a0
    Proc *p = myproc();
    802053fe:	684000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a0;
    80205402:	793c                	ld	a5,112(a0)
    if(Pipe::create_pair(&rf, &wf) < 0)
    80205404:	090c                	addi	a1,sp,144
    80205406:	0808                	addi	a0,sp,16
    *ip = static_cast<int>(argraw(n));
    80205408:	0707e903          	lwu	s2,112(a5)
    if(Pipe::create_pair(&rf, &wf) < 0)
    8020540c:	f33fd0ef          	jal	8020333e <_ZN4Pipe11create_pairEPP4fileS2_>
    80205410:	dc0549e3          	bltz	a0,802051e2 <_Z7syscallv+0xfa>
    80205414:	e6ce                	sd	s3,328(sp)
    if ((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0)
    80205416:	69c2                	ld	s3,16(sp)
    struct Proc *p = myproc();
    80205418:	66a000ef          	jal	80205a82 <_Z6myprocv>
    for (int i = 0; i < NOFILE; i++)
    8020541c:	0c850713          	addi	a4,a0,200
    80205420:	4781                	li	a5,0
    80205422:	4641                	li	a2,16
        if (p->ofile[i] == 0)
    80205424:	6314                	ld	a3,0(a4)
    80205426:	2a068763          	beqz	a3,802056d4 <_Z7syscallv+0x5ec>
    for (int i = 0; i < NOFILE; i++)
    8020542a:	2785                	addiw	a5,a5,1
    8020542c:	0721                	addi	a4,a4,8
    8020542e:	fec79be3          	bne	a5,a2,80205424 <_Z7syscallv+0x33c>
    if ((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0)
    80205432:	57fd                	li	a5,-1
    80205434:	c43e                	sw	a5,8(sp)
        FileTable::close(rf);
    80205436:	6542                	ld	a0,16(sp)
    80205438:	e5dfd0ef          	jal	80203294 <_ZN9FileTable5closeEP4file>
        FileTable::close(wf);
    8020543c:	654a                	ld	a0,144(sp)
    8020543e:	e57fd0ef          	jal	80203294 <_ZN9FileTable5closeEP4file>
    80205442:	69b6                	ld	s3,328(sp)
        return -1;
    80205444:	bb79                	j	802051e2 <_Z7syscallv+0xfa>
    return static_cast<uint64>(myproc()->pid);
    80205446:	63c000ef          	jal	80205a82 <_Z6myprocv>
    8020544a:	08452483          	lw	s1,132(a0)
        break;
    8020544e:	bb21                	j	80205166 <_Z7syscallv+0x7e>
    Proc *p = myproc();
    80205450:	632000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a0;
    80205454:	793c                	ld	a5,112(a0)
    *ip = static_cast<int>(argraw(n));
    80205456:	5ba4                	lw	s1,112(a5)
    struct Proc *p = myproc();
    80205458:	62a000ef          	jal	80205a82 <_Z6myprocv>
    if (oldfd < 0 || oldfd >= NOFILE || p->ofile[oldfd] == nullptr)
    8020545c:	47bd                	li	a5,15
    8020545e:	d297ebe3          	bltu	a5,s1,80205194 <_Z7syscallv+0xac>
    80205462:	01848793          	addi	a5,s1,24
    80205466:	078e                	slli	a5,a5,0x3
    80205468:	953e                	add	a0,a0,a5
    8020546a:	6508                	ld	a0,8(a0)
    8020546c:	d20504e3          	beqz	a0,80205194 <_Z7syscallv+0xac>
    80205470:	eaca                	sd	s2,336(sp)
    struct file *f = FileTable::dup(p->ofile[oldfd]);
    80205472:	de1fd0ef          	jal	80203252 <_ZN9FileTable3dupEP4file>
    80205476:	892a                	mv	s2,a0
    struct Proc *p = myproc();
    80205478:	60a000ef          	jal	80205a82 <_Z6myprocv>
    for (int i = 0; i < NOFILE; i++)
    8020547c:	0c850793          	addi	a5,a0,200
    80205480:	4481                	li	s1,0
    80205482:	46c1                	li	a3,16
        if (p->ofile[i] == 0)
    80205484:	6398                	ld	a4,0(a5)
    80205486:	20070263          	beqz	a4,8020568a <_Z7syscallv+0x5a2>
    for (int i = 0; i < NOFILE; i++)
    8020548a:	2485                	addiw	s1,s1,1
    8020548c:	07a1                	addi	a5,a5,8
    8020548e:	fed49be3          	bne	s1,a3,80205484 <_Z7syscallv+0x39c>
        FileTable::close(f); // fdalloc failed
    80205492:	854a                	mv	a0,s2
    80205494:	e01fd0ef          	jal	80203294 <_ZN9FileTable5closeEP4file>
        ret = sys_exec();
    80205498:	54fd                	li	s1,-1
        return -1;
    8020549a:	6956                	ld	s2,336(sp)
    8020549c:	b1e9                	j	80205166 <_Z7syscallv+0x7e>
    Proc *p = myproc();
    8020549e:	5e4000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a0;
    802054a2:	793c                	ld	a5,112(a0)
    return static_cast<uint64>(ProcManager::wait(p));
    802054a4:	7ba8                	ld	a0,112(a5)
    802054a6:	4e5020ef          	jal	8020818a <_ZN11ProcManager4waitEy>
    802054aa:	84aa                	mv	s1,a0
        break;
    802054ac:	b96d                	j	80205166 <_Z7syscallv+0x7e>
    Proc *p = myproc();
    802054ae:	5d4000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a0;
    802054b2:	793c                	ld	a5,112(a0)
    return 0;
    802054b4:	4481                	li	s1,0
    ProcManager::exit(n);
    802054b6:	5ba8                	lw	a0,112(a5)
    802054b8:	445020ef          	jal	802080fc <_ZN11ProcManager4exitEi>
        break;
    802054bc:	b16d                	j	80205166 <_Z7syscallv+0x7e>
    Proc *p = myproc();
    802054be:	eaca                	sd	s2,336(sp)
    802054c0:	e6ce                	sd	s3,328(sp)
    802054c2:	5c0000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a0;
    802054c6:	793c                	ld	a5,112(a0)
    *ip = static_cast<int>(argraw(n));
    802054c8:	0707a983          	lw	s3,112(a5)
    Spinlock *lk = Timer::get_lock();
    802054cc:	5fd010ef          	jal	802072c8 <_ZN5Timer8get_lockEv>
    802054d0:	892a                	mv	s2,a0
    lk->acquire();
    802054d2:	6ae000ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
    ticks0 = Timer::get_ticks();
    802054d6:	5cd010ef          	jal	802072a2 <_ZN5Timer9get_ticksEv>
    802054da:	84aa                	mv	s1,a0
    while (Timer::get_ticks() - ticks0 < (uint64)n)
    802054dc:	a821                	j	802054f4 <_Z7syscallv+0x40c>
        if (myproc()->killed)
    802054de:	5a4000ef          	jal	80205a82 <_Z6myprocv>
    802054e2:	0bc52783          	lw	a5,188(a0)
    802054e6:	24079663          	bnez	a5,80205732 <_Z7syscallv+0x64a>
        ProcManager::sleep(Timer::get_tick_chan(), lk);
    802054ea:	5e9010ef          	jal	802072d2 <_ZN5Timer13get_tick_chanEv>
    802054ee:	85ca                	mv	a1,s2
    802054f0:	257020ef          	jal	80207f46 <_ZN11ProcManager5sleepEPvP8Spinlock>
    while (Timer::get_ticks() - ticks0 < (uint64)n)
    802054f4:	5af010ef          	jal	802072a2 <_ZN5Timer9get_ticksEv>
    802054f8:	8d05                	sub	a0,a0,s1
    802054fa:	ff3562e3          	bltu	a0,s3,802054de <_Z7syscallv+0x3f6>
    lk->release();
    802054fe:	854a                	mv	a0,s2
    80205500:	618000ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
    return 0;
    80205504:	4481                	li	s1,0
    return 0;
    80205506:	6956                	ld	s2,336(sp)
    80205508:	69b6                	ld	s3,328(sp)
    8020550a:	b9b1                	j	80205166 <_Z7syscallv+0x7e>
    Proc *p = myproc();
    8020550c:	576000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a0;
    80205510:	793c                	ld	a5,112(a0)
    *ip = static_cast<int>(argraw(n));
    80205512:	5ba4                	lw	s1,112(a5)
    uint64 addr = myproc()->sz;
    80205514:	56e000ef          	jal	80205a82 <_Z6myprocv>
    80205518:	87aa                	mv	a5,a0
    if (ProcManager::growproc(n) < 0)
    8020551a:	8526                	mv	a0,s1
    uint64 addr = myproc()->sz;
    8020551c:	73c4                	ld	s1,160(a5)
    if (ProcManager::growproc(n) < 0)
    8020551e:	68f020ef          	jal	802083ac <_ZN11ProcManager8growprocEi>
    80205522:	c40552e3          	bgez	a0,80205166 <_Z7syscallv+0x7e>
        ret = sys_exec();
    80205526:	54fd                	li	s1,-1
    80205528:	b93d                	j	80205166 <_Z7syscallv+0x7e>
    return Timer::get_ticks();
    8020552a:	579010ef          	jal	802072a2 <_ZN5Timer9get_ticksEv>
    8020552e:	84aa                	mv	s1,a0
        break;
    80205530:	b91d                	j	80205166 <_Z7syscallv+0x7e>
    Proc *p = myproc();
    80205532:	eaca                	sd	s2,336(sp)
    80205534:	54e000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a0;
    80205538:	793c                	ld	a5,112(a0)
    return VM::copyinstr(myproc()->pagetable, buf, addr, max);
    8020553a:	0904                	addi	s1,sp,144
        return p->tf->a0;
    8020553c:	0707b903          	ld	s2,112(a5)
    return VM::copyinstr(myproc()->pagetable, buf, addr, max);
    80205540:	542000ef          	jal	80205a82 <_Z6myprocv>
    80205544:	7d28                	ld	a0,120(a0)
    80205546:	08000693          	li	a3,128
    8020554a:	864a                	mv	a2,s2
    8020554c:	85a6                	mv	a1,s1
    8020554e:	7c3000ef          	jal	80206510 <_ZN2VM9copyinstrEPyPcyy>
    if (argstr(0, path, 128) < 0)
    80205552:	c80548e3          	bltz	a0,802051e2 <_Z7syscallv+0xfa>
    Inode *ip = VFS::namei(path);
    80205556:	8526                	mv	a0,s1
    80205558:	e58ff0ef          	jal	80204bb0 <_ZN3VFS5nameiEPKc>
    8020555c:	84aa                	mv	s1,a0
    if (ip == nullptr)
    8020555e:	c80502e3          	beqz	a0,802051e2 <_Z7syscallv+0xfa>
    VFS::ilock(ip);
    80205562:	cfeff0ef          	jal	80204a60 <_ZN3VFS5ilockEP5Inode>
    if (ip->type != T_DIR)
    80205566:	04849703          	lh	a4,72(s1)
    8020556a:	4785                	li	a5,1
        VFS::iunlockput(ip);
    8020556c:	8526                	mv	a0,s1
    if (ip->type != T_DIR)
    8020556e:	2af71463          	bne	a4,a5,80205816 <_Z7syscallv+0x72e>
    VFS::iunlock(ip);
    80205572:	d0eff0ef          	jal	80204a80 <_ZN3VFS7iunlockEP5Inode>
    struct Proc *p = myproc();
    80205576:	50c000ef          	jal	80205a82 <_Z6myprocv>
    8020557a:	892a                	mv	s2,a0
    VFS::iput(p->cwd); // release old cwd
    8020557c:	6168                	ld	a0,192(a0)
    8020557e:	c5eff0ef          	jal	802049dc <_ZN3VFS4iputEP5Inode>
    p->cwd = ip;       // switch to new cwd
    80205582:	0c993023          	sd	s1,192(s2)
        break;
    80205586:	6956                	ld	s2,336(sp)
    return 0;
    80205588:	4481                	li	s1,0
        break;
    8020558a:	bef1                	j	80205166 <_Z7syscallv+0x7e>
    Proc *p = myproc();
    8020558c:	eaca                	sd	s2,336(sp)
    8020558e:	e6ce                	sd	s3,328(sp)
    80205590:	4f2000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a0;
    80205594:	793c                	ld	a5,112(a0)
        return -1;
    80205596:	54fd                	li	s1,-1
    *ip = static_cast<int>(argraw(n));
    80205598:	0707a903          	lw	s2,112(a5)
    Proc *p = myproc();
    8020559c:	4e6000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a1;
    802055a0:	793c                	ld	a5,112(a0)
    *ip = static_cast<int>(argraw(n));
    802055a2:	0787e983          	lwu	s3,120(a5)
    struct Proc *p = myproc();
    802055a6:	4dc000ef          	jal	80205a82 <_Z6myprocv>
    if (fd < 0 || fd >= NOFILE || p->ofile[fd] == nullptr)
    802055aa:	47bd                	li	a5,15
    802055ac:	1927ea63          	bltu	a5,s2,80205740 <_Z7syscallv+0x658>
    802055b0:	01890793          	addi	a5,s2,24
    802055b4:	078e                	slli	a5,a5,0x3
    802055b6:	953e                	add	a0,a0,a5
    802055b8:	6508                	ld	a0,8(a0)
    802055ba:	18050363          	beqz	a0,80205740 <_Z7syscallv+0x658>
    return FileTable::stat(p->ofile[fd], stat_addr);
    802055be:	85ce                	mv	a1,s3
    802055c0:	fbbfd0ef          	jal	8020357a <_ZN9FileTable4statEP4filey>
    802055c4:	84aa                	mv	s1,a0
    802055c6:	6956                	ld	s2,336(sp)
    802055c8:	69b6                	ld	s3,328(sp)
    802055ca:	be71                	j	80205166 <_Z7syscallv+0x7e>
    Proc *p = myproc();
    802055cc:	4b6000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a0;
    802055d0:	793c                	ld	a5,112(a0)
    return ProcManager::kill(pid);
    802055d2:	5ba8                	lw	a0,112(a5)
    802055d4:	4f5020ef          	jal	802082c8 <_ZN11ProcManager4killEi>
    802055d8:	84aa                	mv	s1,a0
        break;
    802055da:	b671                	j	80205166 <_Z7syscallv+0x7e>
    return static_cast<uint64>(fork());
    802055dc:	380020ef          	jal	8020795c <_Z4forkv>
    802055e0:	84aa                	mv	s1,a0
        break;
    802055e2:	b651                	j	80205166 <_Z7syscallv+0x7e>
    Proc *p = myproc();
    802055e4:	49e000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a0;
    802055e8:	793c                	ld	a5,112(a0)
    return 0;
    802055ea:	4481                	li	s1,0
    Drivers::uart_putc(c);
    802055ec:	0707c503          	lbu	a0,112(a5)
    802055f0:	73c030ef          	jal	80208d2c <_ZN7Drivers9uart_putcEc>
        break;
    802055f4:	be8d                	j	80205166 <_Z7syscallv+0x7e>
        Drivers::uart_puts("Unknown Syscall ID: ");
    802055f6:	0000c517          	auipc	a0,0xc
    802055fa:	55250513          	addi	a0,a0,1362 # 80211b48 <initcode_end+0x400>
    802055fe:	76c030ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        Drivers::print_hex(num);
    80205602:	8526                	mv	a0,s1
    80205604:	0cf030ef          	jal	80208ed2 <_ZN7Drivers9print_hexEy>
        Drivers::uart_puts("\n");
    80205608:	0000c517          	auipc	a0,0xc
    8020560c:	21850513          	addi	a0,a0,536 # 80211820 <initcode_end+0xd8>
    80205610:	75a030ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        ret = sys_exec();
    80205614:	54fd                	li	s1,-1
    80205616:	be81                	j	80205166 <_Z7syscallv+0x7e>
    Proc *p = myproc();
    80205618:	e6ce                	sd	s3,328(sp)
    8020561a:	e2d2                	sd	s4,320(sp)
    8020561c:	466000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a1;
    80205620:	793c                	ld	a5,112(a0)
    80205622:	0787b983          	ld	s3,120(a5)
    Proc *p = myproc();
    80205626:	45c000ef          	jal	80205a82 <_Z6myprocv>
        return p->tf->a2;
    8020562a:	793c                	ld	a5,112(a0)
    Inode *ip = VFS::namei(path);
    8020562c:	8526                	mv	a0,s1
        return p->tf->a2;
    8020562e:	0807ba03          	ld	s4,128(a5)
    Inode *ip = VFS::namei(path);
    80205632:	d7eff0ef          	jal	80204bb0 <_ZN3VFS5nameiEPKc>
    if (ip != nullptr)
    80205636:	d60513e3          	bnez	a0,8020539c <_Z7syscallv+0x2b4>
    Inode *dp = VFS::nameiparent(path, name);
    8020563a:	09010913          	addi	s2,sp,144
    8020563e:	8526                	mv	a0,s1
    80205640:	85ca                	mv	a1,s2
    80205642:	ec8ff0ef          	jal	80204d0a <_ZN3VFS11nameiparentEPKcPc>
    80205646:	84aa                	mv	s1,a0
    if (dp == nullptr)
    80205648:	d4050ce3          	beqz	a0,802053a0 <_Z7syscallv+0x2b8>
    VFS::ilock(dp);
    8020564c:	c14ff0ef          	jal	80204a60 <_ZN3VFS5ilockEP5Inode>
    ip = dp->create(name, T_DEVICE, major, minor);
    80205650:	609c                	ld	a5,0(s1)
    80205652:	010a171b          	slliw	a4,s4,0x10
    80205656:	0109969b          	slliw	a3,s3,0x10
    8020565a:	7b9c                	ld	a5,48(a5)
    8020565c:	8526                	mv	a0,s1
    8020565e:	4107571b          	sraiw	a4,a4,0x10
    80205662:	4106d69b          	sraiw	a3,a3,0x10
    80205666:	460d                	li	a2,3
    80205668:	85ca                	mv	a1,s2
    8020566a:	9782                	jalr	a5
    8020566c:	87aa                	mv	a5,a0
    VFS::iunlockput(dp);
    8020566e:	8526                	mv	a0,s1
    ip = dp->create(name, T_DEVICE, major, minor);
    80205670:	84be                	mv	s1,a5
    VFS::iunlockput(dp);
    80205672:	c48ff0ef          	jal	80204aba <_ZN3VFS10iunlockputEP5Inode>
    if (ip == nullptr)
    80205676:	d20485e3          	beqz	s1,802053a0 <_Z7syscallv+0x2b8>
    VFS::iput(ip);
    8020567a:	8526                	mv	a0,s1
    8020567c:	b60ff0ef          	jal	802049dc <_ZN3VFS4iputEP5Inode>
    return 0;
    80205680:	4481                	li	s1,0
        break;
    80205682:	6956                	ld	s2,336(sp)
    80205684:	69b6                	ld	s3,328(sp)
    80205686:	6a16                	ld	s4,320(sp)
    80205688:	bcf9                	j	80205166 <_Z7syscallv+0x7e>
            p->ofile[i] = f;
    8020568a:	01848793          	addi	a5,s1,24
    8020568e:	078e                	slli	a5,a5,0x3
    80205690:	97aa                	add	a5,a5,a0
    80205692:	0127b423          	sd	s2,8(a5)
    return newfd;
    80205696:	6956                	ld	s2,336(sp)
    80205698:	b4f9                	j	80205166 <_Z7syscallv+0x7e>
    f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    8020569a:	00397713          	andi	a4,s2,3
            p->ofile[i] = f;
    8020569e:	01848693          	addi	a3,s1,24
    f->readable = !(omode & O_WRONLY);
    802056a2:	fff94793          	not	a5,s2
            p->ofile[i] = f;
    802056a6:	068e                	slli	a3,a3,0x3
    f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    802056a8:	00e03733          	snez	a4,a4
    f->readable = !(omode & O_WRONLY);
    802056ac:	0087171b          	slliw	a4,a4,0x8
            p->ofile[i] = f;
    802056b0:	9536                	add	a0,a0,a3
    f->readable = !(omode & O_WRONLY);
    802056b2:	8b85                	andi	a5,a5,1
            p->ofile[i] = f;
    802056b4:	01453423          	sd	s4,8(a0)
    f->readable = !(omode & O_WRONLY);
    802056b8:	8fd9                	or	a5,a5,a4
    802056ba:	00fa1423          	sh	a5,8(s4)
    f->type = FD_INODE;
    802056be:	4705                	li	a4,1
    f->ip = ip;
    802056c0:	013a3c23          	sd	s3,24(s4)
    f->type = FD_INODE;
    802056c4:	00ea2023          	sw	a4,0(s4)
    f->off = 0;
    802056c8:	020a2023          	sw	zero,32(s4)
    return fd;
    802056cc:	6956                	ld	s2,336(sp)
    802056ce:	69b6                	ld	s3,328(sp)
    802056d0:	6a16                	ld	s4,320(sp)
    802056d2:	bc51                	j	80205166 <_Z7syscallv+0x7e>
            p->ofile[i] = f;
    802056d4:	01878713          	addi	a4,a5,24
    802056d8:	070e                	slli	a4,a4,0x3
    802056da:	953a                	add	a0,a0,a4
    802056dc:	01353423          	sd	s3,8(a0)
    if ((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0)
    802056e0:	c43e                	sw	a5,8(sp)
    802056e2:	69ca                	ld	s3,144(sp)
    struct Proc *p = myproc();
    802056e4:	39e000ef          	jal	80205a82 <_Z6myprocv>
    802056e8:	85aa                	mv	a1,a0
    for (int i = 0; i < NOFILE; i++)
    802056ea:	0c850713          	addi	a4,a0,200
    802056ee:	4781                	li	a5,0
    802056f0:	4641                	li	a2,16
        if (p->ofile[i] == 0)
    802056f2:	6314                	ld	a3,0(a4)
    802056f4:	cea9                	beqz	a3,8020574e <_Z7syscallv+0x666>
    for (int i = 0; i < NOFILE; i++)
    802056f6:	2785                	addiw	a5,a5,1
    802056f8:	0721                	addi	a4,a4,8
    802056fa:	fec79ce3          	bne	a5,a2,802056f2 <_Z7syscallv+0x60a>
        if (fd0 >= 0)
    802056fe:	47a2                	lw	a5,8(sp)
    if ((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0)
    80205700:	577d                	li	a4,-1
    80205702:	c63a                	sw	a4,12(sp)
        if (fd0 >= 0)
    80205704:	d207c9e3          	bltz	a5,80205436 <_Z7syscallv+0x34e>
            p->ofile[fd0] = nullptr;
    80205708:	07e1                	addi	a5,a5,24
    8020570a:	078e                	slli	a5,a5,0x3
    8020570c:	97a6                	add	a5,a5,s1
    8020570e:	0007b423          	sd	zero,8(a5)
    80205712:	b315                	j	80205436 <_Z7syscallv+0x34e>
    if (fd < 0 || fd >= NOFILE || (f = proc->ofile[fd]) == 0)
    80205714:	47bd                	li	a5,15
        return -1;
    80205716:	54fd                	li	s1,-1
    if (fd < 0 || fd >= NOFILE || (f = proc->ofile[fd]) == 0)
    80205718:	0127e963          	bltu	a5,s2,8020572a <_Z7syscallv+0x642>
    8020571c:	01890793          	addi	a5,s2,24
    80205720:	078e                	slli	a5,a5,0x3
    80205722:	953e                	add	a0,a0,a5
    80205724:	6508                	ld	a0,8(a0)
    80205726:	ca051fe3          	bnez	a0,802053e4 <_Z7syscallv+0x2fc>
    8020572a:	6956                	ld	s2,336(sp)
    8020572c:	69b6                	ld	s3,328(sp)
    8020572e:	6a16                	ld	s4,320(sp)
    80205730:	bc1d                	j	80205166 <_Z7syscallv+0x7e>
            lk->release();
    80205732:	854a                	mv	a0,s2
    80205734:	3e4000ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
        ret = sys_exec();
    80205738:	54fd                	li	s1,-1
            return -1;
    8020573a:	6956                	ld	s2,336(sp)
    8020573c:	69b6                	ld	s3,328(sp)
    8020573e:	b425                	j	80205166 <_Z7syscallv+0x7e>
    80205740:	6956                	ld	s2,336(sp)
    80205742:	69b6                	ld	s3,328(sp)
    80205744:	b40d                	j	80205166 <_Z7syscallv+0x7e>
    80205746:	6956                	ld	s2,336(sp)
    80205748:	69b6                	ld	s3,328(sp)
        ret = sys_exec();
    8020574a:	54fd                	li	s1,-1
    8020574c:	bc29                	j	80205166 <_Z7syscallv+0x7e>
            p->ofile[i] = f;
    8020574e:	01878713          	addi	a4,a5,24
    if (VM::copyout(p->pagetable, fdarray, (char *)&fd0, sizeof(int)) < 0 ||
    80205752:	7ca8                	ld	a0,120(s1)
            p->ofile[i] = f;
    80205754:	070e                	slli	a4,a4,0x3
    80205756:	95ba                	add	a1,a1,a4
    80205758:	0135b423          	sd	s3,8(a1)
    if (VM::copyout(p->pagetable, fdarray, (char *)&fd0, sizeof(int)) < 0 ||
    8020575c:	4691                	li	a3,4
    8020575e:	0030                	addi	a2,sp,8
    80205760:	85ca                	mv	a1,s2
    if ((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0)
    80205762:	c63e                	sw	a5,12(sp)
    if (VM::copyout(p->pagetable, fdarray, (char *)&fd0, sizeof(int)) < 0 ||
    80205764:	73f000ef          	jal	802066a2 <_ZN2VM7copyoutEPyyPcy>
    80205768:	0a054a63          	bltz	a0,8020581c <_Z7syscallv+0x734>
        VM::copyout(p->pagetable, fdarray + sizeof(int), (char *)&fd1, sizeof(int)) < 0)
    8020576c:	7ca8                	ld	a0,120(s1)
    8020576e:	4691                	li	a3,4
    80205770:	0070                	addi	a2,sp,12
    80205772:	00490593          	addi	a1,s2,4
    80205776:	72d000ef          	jal	802066a2 <_ZN2VM7copyoutEPyyPcy>
    if (VM::copyout(p->pagetable, fdarray, (char *)&fd0, sizeof(int)) < 0 ||
    8020577a:	0a054163          	bltz	a0,8020581c <_Z7syscallv+0x734>
        break;
    8020577e:	6956                	ld	s2,336(sp)
    80205780:	69b6                	ld	s3,328(sp)
    return 0;
    80205782:	4481                	li	s1,0
        break;
    80205784:	b2cd                	j	80205166 <_Z7syscallv+0x7e>
        ip = VFS::namei(path);
    80205786:	c2aff0ef          	jal	80204bb0 <_ZN3VFS5nameiEPKc>
    8020578a:	89aa                	mv	s3,a0
    if (ip == nullptr)
    8020578c:	bc0990e3          	bnez	s3,8020534c <_Z7syscallv+0x264>
    80205790:	69b6                	ld	s3,328(sp)
    80205792:	bc81                	j	802051e2 <_Z7syscallv+0xfa>
    if (fd == 1 && proc->ofile[fd] == nullptr) // stdout
    80205794:	0d0a3503          	ld	a0,208(s4)
    80205798:	a8051de3          	bnez	a0,80205232 <_Z7syscallv+0x14a>
    8020579c:	fa5a                	sd	s6,304(sp)
    8020579e:	f262                	sd	s8,288(sp)
    802057a0:	ee66                	sd	s9,280(sp)
        int i = 0;
    802057a2:	4b01                	li	s6,0
    802057a4:	09010c13          	addi	s8,sp,144
            if (len > MAX_WRITE_BUF)
    802057a8:	08000c93          	li	s9,128
        while (i < n)
    802057ac:	0c905d63          	blez	s1,80205886 <_Z7syscallv+0x79e>
    802057b0:	e6ce                	sd	s3,328(sp)
    802057b2:	fe56                	sd	s5,312(sp)
            if (len > MAX_WRITE_BUF)
    802057b4:	41648abb          	subw	s5,s1,s6
    802057b8:	015cd463          	bge	s9,s5,802057c0 <_Z7syscallv+0x6d8>
    802057bc:	08000a93          	li	s5,128
            if (VM::copyin(proc->pagetable, buf, p + i, static_cast<uint64>(len)) < 0)
    802057c0:	078a3503          	ld	a0,120(s4)
    802057c4:	86d6                	mv	a3,s5
    802057c6:	017b0633          	add	a2,s6,s7
    802057ca:	85e2                	mv	a1,s8
    802057cc:	4b5000ef          	jal	80206480 <_ZN2VM6copyinEPyPcyy>
    802057d0:	0a054363          	bltz	a0,80205876 <_Z7syscallv+0x78e>
    802057d4:	8962                	mv	s2,s8
    802057d6:	015c09b3          	add	s3,s8,s5
                Drivers::uart_putc(buf[j]);
    802057da:	00094503          	lbu	a0,0(s2)
            for (int j = 0; j < len; j++)
    802057de:	0905                	addi	s2,s2,1
                Drivers::uart_putc(buf[j]);
    802057e0:	54c030ef          	jal	80208d2c <_ZN7Drivers9uart_putcEc>
            for (int j = 0; j < len; j++)
    802057e4:	ff391be3          	bne	s2,s3,802057da <_Z7syscallv+0x6f2>
            i += len;
    802057e8:	016a8b3b          	addw	s6,s5,s6
        while (i < n)
    802057ec:	fc9b44e3          	blt	s6,s1,802057b4 <_Z7syscallv+0x6cc>
    802057f0:	6956                	ld	s2,336(sp)
    802057f2:	69b6                	ld	s3,328(sp)
    802057f4:	6a16                	ld	s4,320(sp)
    802057f6:	7af2                	ld	s5,312(sp)
    802057f8:	7b52                	ld	s6,304(sp)
    802057fa:	7bb2                	ld	s7,296(sp)
    802057fc:	7c12                	ld	s8,288(sp)
    802057fe:	6cf2                	ld	s9,280(sp)
    80205800:	967ff06f          	j	80205166 <_Z7syscallv+0x7e>
    80205804:	6956                	ld	s2,336(sp)
    80205806:	6a16                	ld	s4,320(sp)
    80205808:	7bb2                	ld	s7,296(sp)
        ret = sys_exec();
    8020580a:	54fd                	li	s1,-1
    8020580c:	95bff06f          	j	80205166 <_Z7syscallv+0x7e>
        VFS::iput(ip);
    80205810:	9ccff0ef          	jal	802049dc <_ZN3VFS4iputEP5Inode>
        return -1; // the dir is exist
    80205814:	b2f9                	j	802051e2 <_Z7syscallv+0xfa>
        VFS::iunlockput(ip);
    80205816:	aa4ff0ef          	jal	80204aba <_ZN3VFS10iunlockputEP5Inode>
        return -1;
    8020581a:	b2e1                	j	802051e2 <_Z7syscallv+0xfa>
        p->ofile[fd0] = nullptr;
    8020581c:	4722                	lw	a4,8(sp)
        p->ofile[fd1] = nullptr;
    8020581e:	47b2                	lw	a5,12(sp)
        p->ofile[fd0] = nullptr;
    80205820:	0761                	addi	a4,a4,24
    80205822:	070e                	slli	a4,a4,0x3
        p->ofile[fd1] = nullptr;
    80205824:	07e1                	addi	a5,a5,24
        p->ofile[fd0] = nullptr;
    80205826:	9726                	add	a4,a4,s1
        p->ofile[fd1] = nullptr;
    80205828:	078e                	slli	a5,a5,0x3
        p->ofile[fd0] = nullptr;
    8020582a:	00073423          	sd	zero,8(a4)
        p->ofile[fd1] = nullptr;
    8020582e:	bdf9                	j	8020570c <_Z7syscallv+0x624>
        return Drivers::console_read(p, n);
    80205830:	85ce                	mv	a1,s3
    80205832:	8552                	mv	a0,s4
    80205834:	7d4030ef          	jal	80209008 <_ZN7Drivers12console_readEyi>
    80205838:	84aa                	mv	s1,a0
    8020583a:	6956                	ld	s2,336(sp)
    8020583c:	69b6                	ld	s3,328(sp)
    8020583e:	6a16                	ld	s4,320(sp)
    80205840:	927ff06f          	j	80205166 <_Z7syscallv+0x7e>
            Inode *dp = VFS::nameiparent(path, name);
    80205844:	09010993          	addi	s3,sp,144
    80205848:	8526                	mv	a0,s1
    8020584a:	85ce                	mv	a1,s3
    8020584c:	cbeff0ef          	jal	80204d0a <_ZN3VFS11nameiparentEPKcPc>
    80205850:	84aa                	mv	s1,a0
            if (dp)
    80205852:	dd1d                	beqz	a0,80205790 <_Z7syscallv+0x6a8>
                VFS::ilock(dp);
    80205854:	a0cff0ef          	jal	80204a60 <_ZN3VFS5ilockEP5Inode>
                ip = dp->create(name, T_FILE, 0, 0);
    80205858:	609c                	ld	a5,0(s1)
    8020585a:	85ce                	mv	a1,s3
    8020585c:	4701                	li	a4,0
    8020585e:	7b9c                	ld	a5,48(a5)
    80205860:	4681                	li	a3,0
    80205862:	4609                	li	a2,2
    80205864:	8526                	mv	a0,s1
    80205866:	9782                	jalr	a5
    80205868:	89aa                	mv	s3,a0
                VFS::iunlockput(dp);
    8020586a:	8526                	mv	a0,s1
    8020586c:	a4eff0ef          	jal	80204aba <_ZN3VFS10iunlockputEP5Inode>
    if (ip == nullptr)
    80205870:	ac099ee3          	bnez	s3,8020534c <_Z7syscallv+0x264>
    80205874:	bf31                	j	80205790 <_Z7syscallv+0x6a8>
                Drivers::uart_puts("sys_write: copyin failed\n");
    80205876:	0000c517          	auipc	a0,0xc
    8020587a:	28250513          	addi	a0,a0,642 # 80211af8 <initcode_end+0x3b0>
    8020587e:	4ec030ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
                return static_cast<uint64>(-1);
    80205882:	54fd                	li	s1,-1
    80205884:	b7b5                	j	802057f0 <_Z7syscallv+0x708>
    80205886:	6956                	ld	s2,336(sp)
    80205888:	6a16                	ld	s4,320(sp)
    8020588a:	7b52                	ld	s6,304(sp)
    8020588c:	7bb2                	ld	s7,296(sp)
    8020588e:	7c12                	ld	s8,288(sp)
    80205890:	6cf2                	ld	s9,280(sp)
    80205892:	8d5ff06f          	j	80205166 <_Z7syscallv+0x7e>

0000000080205896 <_Znwm>:
 * Cons: Allocates 4KB for every object (wasteful for small objects),
 * but acceptable for current stage.
 */

void *operator new(unsigned long size)
{
    80205896:	1141                	addi	sp,sp,-16
    80205898:	e406                	sd	ra,8(sp)
    // Safety check: PMM allocates 4096 bytes max per call
    if (size > 4096)
    8020589a:	6785                	lui	a5,0x1
    8020589c:	00a7f963          	bgeu	a5,a0,802058ae <_Znwm+0x18>
    {
        Drivers::uart_puts("panic: new allocation too big (max 4096)\n");
    802058a0:	0000c517          	auipc	a0,0xc
    802058a4:	2c050513          	addi	a0,a0,704 # 80211b60 <initcode_end+0x418>
    802058a8:	4c2030ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        while (1)
    802058ac:	a001                	j	802058ac <_Znwm+0x16>
            ;
    }

    void *p = PMM::alloc_page();
    802058ae:	0b5010ef          	jal	80207162 <_ZN3PMM10alloc_pageEv>
    if (!p)
    802058b2:	c501                	beqz	a0,802058ba <_Znwm+0x24>
    }
    // PMM::alloc_page returns zeroed memory usually,
    // but standard 'new' doesn't guarantee it.
    // The constructor will handle initialization.
    return p;
}
    802058b4:	60a2                	ld	ra,8(sp)
    802058b6:	0141                	addi	sp,sp,16
    802058b8:	8082                	ret
        Drivers::uart_puts("panic: new out of memory\n");
    802058ba:	0000c517          	auipc	a0,0xc
    802058be:	2d650513          	addi	a0,a0,726 # 80211b90 <initcode_end+0x448>
    802058c2:	4a8030ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        while (1)
    802058c6:	a001                	j	802058c6 <_Znwm+0x30>

00000000802058c8 <_Znam>:

void *operator new[](unsigned long size)
{
    802058c8:	1141                	addi	sp,sp,-16
    802058ca:	e406                	sd	ra,8(sp)
    if (size > 4096)
    802058cc:	6785                	lui	a5,0x1
    802058ce:	00a7f963          	bgeu	a5,a0,802058e0 <_Znam+0x18>
        Drivers::uart_puts("panic: new allocation too big (max 4096)\n");
    802058d2:	0000c517          	auipc	a0,0xc
    802058d6:	28e50513          	addi	a0,a0,654 # 80211b60 <initcode_end+0x418>
    802058da:	490030ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        while (1)
    802058de:	a001                	j	802058de <_Znam+0x16>
    void *p = PMM::alloc_page();
    802058e0:	083010ef          	jal	80207162 <_ZN3PMM10alloc_pageEv>
    if (!p)
    802058e4:	c501                	beqz	a0,802058ec <_Znam+0x24>
    return operator new(size);
}
    802058e6:	60a2                	ld	ra,8(sp)
    802058e8:	0141                	addi	sp,sp,16
    802058ea:	8082                	ret
        Drivers::uart_puts("panic: new out of memory\n");
    802058ec:	0000c517          	auipc	a0,0xc
    802058f0:	2a450513          	addi	a0,a0,676 # 80211b90 <initcode_end+0x448>
    802058f4:	476030ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        while (1)
    802058f8:	a001                	j	802058f8 <_Znam+0x30>

00000000802058fa <_ZdlPv>:

void operator delete(void *p)
{
    if (p)
    802058fa:	c119                	beqz	a0,80205900 <_ZdlPv+0x6>
        PMM::free_page(p);
    802058fc:	0890106f          	j	80207184 <_ZN3PMM9free_pageEPv>
}
    80205900:	8082                	ret

0000000080205902 <_ZdaPv>:

void operator delete[](void *p)
    80205902:	c119                	beqz	a0,80205908 <_ZdaPv+0x6>
    80205904:	0810106f          	j	80207184 <_ZN3PMM9free_pageEPv>
    80205908:	8082                	ret

000000008020590a <_ZdlPvm>:
// C++14 Sized Deallocation (Required by modern compilers)
// The compiler optimizes 'delete' calls to pass the size of the object
void operator delete(void *p, unsigned long size)
{
    (void)size; // We ignore size because PMM always frees a full page
    if (p)
    8020590a:	c119                	beqz	a0,80205910 <_ZdlPvm+0x6>
        PMM::free_page(p);
    8020590c:	0790106f          	j	80207184 <_ZN3PMM9free_pageEPv>
}
    80205910:	8082                	ret

0000000080205912 <_ZdaPvm>:

void operator delete[](void *p, unsigned long size)
    80205912:	c119                	beqz	a0,80205918 <_ZdaPvm+0x6>
    80205914:	0710106f          	j	80207184 <_ZN3PMM9free_pageEPv>
    80205918:	8082                	ret

000000008020591a <_ZnwmPv>:

void *operator new(unsigned long size, void *ptr)
{
    (void)size;
    return ptr;
    8020591a:	852e                	mv	a0,a1
    8020591c:	8082                	ret

000000008020591e <kernel_main>:
extern uint64 g_dtb_addr;

volatile static int started = 0;

extern "C" void kernel_main(uint64 hartid, uint64 dtb)
{
    8020591e:	1141                	addi	sp,sp,-16
    80205920:	e022                	sd	s0,0(sp)
    80205922:	e406                	sd	ra,8(sp)
    80205924:	00018417          	auipc	s0,0x18
    80205928:	2cc40413          	addi	s0,s0,716 # 8021dbf0 <_ZL7started>
    if (hartid == 0)
    8020592c:	c90d                	beqz	a0,8020595e <kernel_main+0x40>

        Drivers::uart_puts("[Boot] System initialized. Entering scheduler...\n");
    }
    else
    {
        while (__atomic_load_n(&started, __ATOMIC_ACQUIRE) == 0)
    8020592e:	401c                	lw	a5,0(s0)
    80205930:	0230000f          	fence	r,rw
    80205934:	2781                	sext.w	a5,a5
    80205936:	dfe5                	beqz	a5,8020592e <kernel_main+0x10>
            ;

        VM::kvminithart();
    80205938:	759000ef          	jal	80206890 <_ZN2VM11kvminithartEv>
        Trap::inithart();
    8020593c:	050030ef          	jal	8020898c <_ZN4Trap8inithartEv>
        PLIC::inithart();
    80205940:	7cd030ef          	jal	8020990c <_ZN4PLIC8inithartEv>
        Timer::init();
    80205944:	0f3010ef          	jal	80207236 <_ZN5Timer4initEv>
        Drivers::uart_puts("[Boot] Hart started.\n");
    80205948:	0000c517          	auipc	a0,0xc
    8020594c:	2d050513          	addi	a0,a0,720 # 80211c18 <initcode_end+0x4d0>
    80205950:	41a030ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
    }

    ProcManager::scheduler(); // Enable Scheduler
    80205954:	6402                	ld	s0,0(sp)
    80205956:	60a2                	ld	ra,8(sp)
    80205958:	0141                	addi	sp,sp,16
    ProcManager::scheduler(); // Enable Scheduler
    8020595a:	1fe0206f          	j	80207b58 <_ZN11ProcManager9schedulerEv>
        fdt_init(dtb);
    8020595e:	852e                	mv	a0,a1
    80205960:	5ad020ef          	jal	8020870c <_Z8fdt_inity>
        Drivers::uart_init();
    80205964:	346030ef          	jal	80208caa <_ZN7Drivers9uart_initEv>
        Drivers::uart_puts("\n[Lume OS] Booting...\n");
    80205968:	0000c517          	auipc	a0,0xc
    8020596c:	24850513          	addi	a0,a0,584 # 80211bb0 <initcode_end+0x468>
    80205970:	3fa030ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        Drivers::uart_puts("[Boot] PMP configured.\n");
    80205974:	0000c517          	auipc	a0,0xc
    80205978:	25450513          	addi	a0,a0,596 # 80211bc8 <initcode_end+0x480>
    8020597c:	3ee030ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        PMM::init();              // Physical Memory Management
    80205980:	656010ef          	jal	80206fd6 <_ZN3PMM4initEv>
        VM::kvminit();            // Kernel Pagetable
    80205984:	5d9000ef          	jal	8020675c <_ZN2VM7kvminitEv>
        VM::kvminithart();        // Enable MMU
    80205988:	709000ef          	jal	80206890 <_ZN2VM11kvminithartEv>
        Slab::init();
    8020598c:	75f000ef          	jal	802068ea <_ZN4Slab4initEv>
        Trap::init();             // Trap Management
    80205990:	7f1020ef          	jal	80208980 <_ZN4Trap4initEv>
        Trap::inithart();
    80205994:	7f9020ef          	jal	8020898c <_ZN4Trap8inithartEv>
        PLIC::init();
    80205998:	733030ef          	jal	802098ca <_ZN4PLIC4initEv>
        PLIC::inithart();
    8020599c:	771030ef          	jal	8020990c <_ZN4PLIC8inithartEv>
        VirtIO::init();
    802059a0:	15d030ef          	jal	802092fc <_ZN6VirtIO4initEv>
        BufferCache::init();
    802059a4:	297020ef          	jal	8020843a <_ZN11BufferCache4initEv>
        VFS::init();
    802059a8:	828ff0ef          	jal	802049d0 <_ZN3VFS4initEv>
        FileTable::init();
    802059ac:	831fd0ef          	jal	802031dc <_ZN9FileTable4initEv>
        Timer::init();
    802059b0:	087010ef          	jal	80207236 <_ZN5Timer4initEv>
        ProcManager::init();      // Process Management
    802059b4:	114020ef          	jal	80207ac8 <_ZN11ProcManager4initEv>
        ProcManager::user_init(); // Initialize first user process
    802059b8:	39e020ef          	jal	80207d56 <_ZN11ProcManager9user_initEv>
        __atomic_store_n(&started, 1, __ATOMIC_RELEASE);
    802059bc:	4785                	li	a5,1
    802059be:	0310000f          	fence	rw,w
    802059c2:	c01c                	sw	a5,0(s0)
        Drivers::uart_puts("[Boot] System initialized. Entering scheduler...\n");
    802059c4:	0000c517          	auipc	a0,0xc
    802059c8:	21c50513          	addi	a0,a0,540 # 80211be0 <initcode_end+0x498>
    802059cc:	39e030ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
    802059d0:	6402                	ld	s0,0(sp)
    802059d2:	60a2                	ld	ra,8(sp)
    802059d4:	0141                	addi	sp,sp,16
    ProcManager::scheduler(); // Enable Scheduler
    802059d6:	1820206f          	j	80207b58 <_ZN11ProcManager9schedulerEv>

00000000802059da <_ZN8Spinlock4initEPKc>:

// Spinlock Implementation

void Spinlock::init(const char *lock_name)
{
    name = lock_name;
    802059da:	e50c                	sd	a1,8(a0)
    locked = 0;
    802059dc:	00052023          	sw	zero,0(a0)
    cpu = nullptr;
    802059e0:	00053823          	sd	zero,16(a0)
}
    802059e4:	8082                	ret

00000000802059e6 <_ZN5Mutex4initEPKc>:
    name = lock_name;
    802059e6:	0000c797          	auipc	a5,0xc
    802059ea:	24a78793          	addi	a5,a5,586 # 80211c30 <initcode_end+0x4e8>

// Mutex Implementation (Sleep Locks)

void Mutex::init(const char *lock_name)
{
    name = lock_name;
    802059ee:	e50c                	sd	a1,8(a0)
    locked = 0;
    802059f0:	00052023          	sw	zero,0(a0)
    pid = 0;
    802059f4:	00052823          	sw	zero,16(a0)
    name = lock_name;
    802059f8:	f11c                	sd	a5,32(a0)
    locked = 0;
    802059fa:	00052c23          	sw	zero,24(a0)
    cpu = nullptr;
    802059fe:	02053423          	sd	zero,40(a0)
    lk.init("mutex_internal");
}
    80205a02:	8082                	ret

0000000080205a04 <_Z8push_offv>:
}

// Interrupt Depth Management

void push_off(void)
{
    80205a04:	1141                	addi	sp,sp,-16
    80205a06:	e406                	sd	ra,8(sp)
    80205a08:	e022                	sd	s0,0(sp)

static inline uint64
r_sstatus()
{
  uint64 x;
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80205a0a:	10002473          	csrr	s0,sstatus
    80205a0e:	100027f3          	csrr	a5,sstatus

// disable device interrupts
static inline void
intr_off()
{
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80205a12:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80205a14:	10079073          	csrw	sstatus,a5
    int old = intr_get();
    intr_off();

    struct cpu *c = mycpu();
    80205a18:	59f010ef          	jal	802077b6 <_Z5mycpuv>

    if (c->noff == 0)
    80205a1c:	5d3c                	lw	a5,120(a0)
    80205a1e:	e781                	bnez	a5,80205a26 <_Z8push_offv+0x22>
// are device interrupts enabled?
static inline int
intr_get()
{
  uint64 x = r_sstatus();
  return (x & SSTATUS_SIE) != 0;
    80205a20:	8005                	srli	s0,s0,0x1
    80205a22:	8805                	andi	s0,s0,1
        c->intena = old;
    80205a24:	dd60                	sw	s0,124(a0)

    c->noff += 1;
}
    80205a26:	60a2                	ld	ra,8(sp)
    80205a28:	6402                	ld	s0,0(sp)
    c->noff += 1;
    80205a2a:	2785                	addiw	a5,a5,1
    80205a2c:	dd3c                	sw	a5,120(a0)
}
    80205a2e:	0141                	addi	sp,sp,16
    80205a30:	8082                	ret

0000000080205a32 <_Z7pop_offv>:

void pop_off(void)
{
    80205a32:	1141                	addi	sp,sp,-16
    80205a34:	e406                	sd	ra,8(sp)
    struct cpu *c = mycpu();
    80205a36:	581010ef          	jal	802077b6 <_Z5mycpuv>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80205a3a:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80205a3e:	8b89                	andi	a5,a5,2

    if (intr_get())
    80205a40:	e39d                	bnez	a5,80205a66 <_Z7pop_offv+0x34>
    {
        Drivers::uart_puts("panic: pop_off - interruptible\n");
        while (1)
            ;
    }
    if (c->noff < 1)
    80205a42:	5d3c                	lw	a5,120(a0)
    80205a44:	02f05863          	blez	a5,80205a74 <_Z7pop_offv+0x42>
        Drivers::uart_puts("panic: pop_off count\n");
        while (1)
            ;
    }

    c->noff -= 1;
    80205a48:	fff7871b          	addiw	a4,a5,-1
    80205a4c:	dd38                	sw	a4,120(a0)

    // An interrupt is only truly enabled when the nesting level returns to zero and the outermost layer allows interrupts.
    if (c->noff == 0 && c->intena)
    80205a4e:	eb09                	bnez	a4,80205a60 <_Z7pop_offv+0x2e>
    80205a50:	5d7c                	lw	a5,124(a0)
    80205a52:	c799                	beqz	a5,80205a60 <_Z7pop_offv+0x2e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80205a54:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80205a58:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80205a5c:	10079073          	csrw	sstatus,a5
        intr_on();
    80205a60:	60a2                	ld	ra,8(sp)
    80205a62:	0141                	addi	sp,sp,16
    80205a64:	8082                	ret
        Drivers::uart_puts("panic: pop_off - interruptible\n");
    80205a66:	0000c517          	auipc	a0,0xc
    80205a6a:	1da50513          	addi	a0,a0,474 # 80211c40 <initcode_end+0x4f8>
    80205a6e:	2fc030ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        while (1)
    80205a72:	a001                	j	80205a72 <_Z7pop_offv+0x40>
        Drivers::uart_puts("panic: pop_off count\n");
    80205a74:	0000c517          	auipc	a0,0xc
    80205a78:	1ec50513          	addi	a0,a0,492 # 80211c60 <initcode_end+0x518>
    80205a7c:	2ee030ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        while (1)
    80205a80:	a001                	j	80205a80 <_Z7pop_offv+0x4e>

0000000080205a82 <_Z6myprocv>:
{
    80205a82:	1141                	addi	sp,sp,-16
    80205a84:	e406                	sd	ra,8(sp)
    80205a86:	e022                	sd	s0,0(sp)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80205a88:	10002473          	csrr	s0,sstatus
    80205a8c:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80205a90:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80205a92:	10079073          	csrw	sstatus,a5
    struct cpu *c = mycpu();
    80205a96:	521010ef          	jal	802077b6 <_Z5mycpuv>
    if (c->noff == 0)
    80205a9a:	5d3c                	lw	a5,120(a0)
    80205a9c:	e781                	bnez	a5,80205aa4 <_Z6myprocv+0x22>
  return (x & SSTATUS_SIE) != 0;
    80205a9e:	8005                	srli	s0,s0,0x1
    80205aa0:	8805                	andi	s0,s0,1
        c->intena = old;
    80205aa2:	dd60                	sw	s0,124(a0)
    c->noff += 1;
    80205aa4:	2785                	addiw	a5,a5,1
    80205aa6:	dd3c                	sw	a5,120(a0)
    struct cpu *c = mycpu();
    80205aa8:	50f010ef          	jal	802077b6 <_Z5mycpuv>
    struct Proc *p = c->proc;
    80205aac:	6100                	ld	s0,0(a0)
    pop_off();
    80205aae:	f85ff0ef          	jal	80205a32 <_Z7pop_offv>
}
    80205ab2:	60a2                	ld	ra,8(sp)
    80205ab4:	8522                	mv	a0,s0
    80205ab6:	6402                	ld	s0,0(sp)
    80205ab8:	0141                	addi	sp,sp,16
    80205aba:	8082                	ret

0000000080205abc <_ZN8Spinlock7holdingEv>:
{
    80205abc:	1101                	addi	sp,sp,-32
    80205abe:	e822                	sd	s0,16(sp)
    80205ac0:	ec06                	sd	ra,24(sp)
    80205ac2:	e426                	sd	s1,8(sp)
    80205ac4:	842a                	mv	s0,a0
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80205ac6:	100024f3          	csrr	s1,sstatus
    80205aca:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80205ace:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80205ad0:	10079073          	csrw	sstatus,a5
    struct cpu *c = mycpu();
    80205ad4:	4e3010ef          	jal	802077b6 <_Z5mycpuv>
    if (c->noff == 0)
    80205ad8:	5d3c                	lw	a5,120(a0)
    80205ada:	e781                	bnez	a5,80205ae2 <_ZN8Spinlock7holdingEv+0x26>
  return (x & SSTATUS_SIE) != 0;
    80205adc:	8085                	srli	s1,s1,0x1
    80205ade:	8885                	andi	s1,s1,1
        c->intena = old;
    80205ae0:	dd64                	sw	s1,124(a0)
    r = (locked && cpu == mycpu());
    80205ae2:	4018                	lw	a4,0(s0)
    c->noff += 1;
    80205ae4:	2785                	addiw	a5,a5,1
    80205ae6:	dd3c                	sw	a5,120(a0)
    r = (locked && cpu == mycpu());
    80205ae8:	4481                	li	s1,0
    80205aea:	eb09                	bnez	a4,80205afc <_ZN8Spinlock7holdingEv+0x40>
    pop_off();
    80205aec:	f47ff0ef          	jal	80205a32 <_Z7pop_offv>
}
    80205af0:	60e2                	ld	ra,24(sp)
    80205af2:	6442                	ld	s0,16(sp)
    80205af4:	8526                	mv	a0,s1
    80205af6:	64a2                	ld	s1,8(sp)
    80205af8:	6105                	addi	sp,sp,32
    80205afa:	8082                	ret
    r = (locked && cpu == mycpu());
    80205afc:	6804                	ld	s1,16(s0)
    80205afe:	4b9010ef          	jal	802077b6 <_Z5mycpuv>
    80205b02:	8c89                	sub	s1,s1,a0
    pop_off();
    80205b04:	f2fff0ef          	jal	80205a32 <_Z7pop_offv>
}
    80205b08:	60e2                	ld	ra,24(sp)
    80205b0a:	6442                	ld	s0,16(sp)
    r = (locked && cpu == mycpu());
    80205b0c:	0014b493          	seqz	s1,s1
}
    80205b10:	8526                	mv	a0,s1
    80205b12:	64a2                	ld	s1,8(sp)
    80205b14:	6105                	addi	sp,sp,32
    80205b16:	8082                	ret

0000000080205b18 <_ZN8Spinlock7releaseEv>:
{
    80205b18:	1101                	addi	sp,sp,-32
    80205b1a:	e822                	sd	s0,16(sp)
    80205b1c:	ec06                	sd	ra,24(sp)
    80205b1e:	e426                	sd	s1,8(sp)
    80205b20:	842a                	mv	s0,a0
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80205b22:	100024f3          	csrr	s1,sstatus
    80205b26:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80205b2a:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80205b2c:	10079073          	csrw	sstatus,a5
    struct cpu *c = mycpu();
    80205b30:	487010ef          	jal	802077b6 <_Z5mycpuv>
    if (c->noff == 0)
    80205b34:	5d3c                	lw	a5,120(a0)
    80205b36:	e789                	bnez	a5,80205b40 <_ZN8Spinlock7releaseEv+0x28>
  return (x & SSTATUS_SIE) != 0;
    80205b38:	0014d713          	srli	a4,s1,0x1
    80205b3c:	8b05                	andi	a4,a4,1
        c->intena = old;
    80205b3e:	dd78                	sw	a4,124(a0)
    r = (locked && cpu == mycpu());
    80205b40:	4018                	lw	a4,0(s0)
    c->noff += 1;
    80205b42:	2785                	addiw	a5,a5,1
    80205b44:	dd3c                	sw	a5,120(a0)
    r = (locked && cpu == mycpu());
    80205b46:	eb11                	bnez	a4,80205b5a <_ZN8Spinlock7releaseEv+0x42>
    pop_off();
    80205b48:	eebff0ef          	jal	80205a32 <_Z7pop_offv>
        Drivers::uart_puts("panic: release not holding\n");
    80205b4c:	0000c517          	auipc	a0,0xc
    80205b50:	12c50513          	addi	a0,a0,300 # 80211c78 <initcode_end+0x530>
    80205b54:	216030ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        while (1)
    80205b58:	a001                	j	80205b58 <_ZN8Spinlock7releaseEv+0x40>
    r = (locked && cpu == mycpu());
    80205b5a:	6804                	ld	s1,16(s0)
    80205b5c:	45b010ef          	jal	802077b6 <_Z5mycpuv>
    80205b60:	fea494e3          	bne	s1,a0,80205b48 <_ZN8Spinlock7releaseEv+0x30>
    pop_off();
    80205b64:	ecfff0ef          	jal	80205a32 <_Z7pop_offv>
    cpu = nullptr;
    80205b68:	00043823          	sd	zero,16(s0)
    __atomic_store_n(&locked, 0, __ATOMIC_RELEASE);
    80205b6c:	0310000f          	fence	rw,w
    80205b70:	00042023          	sw	zero,0(s0)
}
    80205b74:	6442                	ld	s0,16(sp)
    80205b76:	60e2                	ld	ra,24(sp)
    80205b78:	64a2                	ld	s1,8(sp)
    80205b7a:	6105                	addi	sp,sp,32
    pop_off();
    80205b7c:	eb7ff06f          	j	80205a32 <_Z7pop_offv>

0000000080205b80 <_ZN8Spinlock7acquireEv>:
{
    80205b80:	1101                	addi	sp,sp,-32
    80205b82:	e822                	sd	s0,16(sp)
    80205b84:	ec06                	sd	ra,24(sp)
    80205b86:	e426                	sd	s1,8(sp)
    80205b88:	842a                	mv	s0,a0
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80205b8a:	100024f3          	csrr	s1,sstatus
    80205b8e:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80205b92:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80205b94:	10079073          	csrw	sstatus,a5
    struct cpu *c = mycpu();
    80205b98:	41f010ef          	jal	802077b6 <_Z5mycpuv>
    if (c->noff == 0)
    80205b9c:	5d3c                	lw	a5,120(a0)
    80205b9e:	e789                	bnez	a5,80205ba8 <_ZN8Spinlock7acquireEv+0x28>
  return (x & SSTATUS_SIE) != 0;
    80205ba0:	0014d713          	srli	a4,s1,0x1
    80205ba4:	8b05                	andi	a4,a4,1
        c->intena = old;
    80205ba6:	dd78                	sw	a4,124(a0)
    c->noff += 1;
    80205ba8:	2785                	addiw	a5,a5,1
    80205baa:	dd3c                	sw	a5,120(a0)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80205bac:	100024f3          	csrr	s1,sstatus
    80205bb0:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80205bb4:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80205bb6:	10079073          	csrw	sstatus,a5
    struct cpu *c = mycpu();
    80205bba:	3fd010ef          	jal	802077b6 <_Z5mycpuv>
    if (c->noff == 0)
    80205bbe:	5d3c                	lw	a5,120(a0)
    80205bc0:	e789                	bnez	a5,80205bca <_ZN8Spinlock7acquireEv+0x4a>
  return (x & SSTATUS_SIE) != 0;
    80205bc2:	0014d713          	srli	a4,s1,0x1
    80205bc6:	8b05                	andi	a4,a4,1
        c->intena = old;
    80205bc8:	dd78                	sw	a4,124(a0)
    r = (locked && cpu == mycpu());
    80205bca:	4018                	lw	a4,0(s0)
    c->noff += 1;
    80205bcc:	2785                	addiw	a5,a5,1
    80205bce:	dd3c                	sw	a5,120(a0)
    r = (locked && cpu == mycpu());
    80205bd0:	eb05                	bnez	a4,80205c00 <_ZN8Spinlock7acquireEv+0x80>
    pop_off();
    80205bd2:	e61ff0ef          	jal	80205a32 <_Z7pop_offv>
    while (__atomic_exchange_n(&locked, 1, __ATOMIC_ACQUIRE))
    80205bd6:	4685                	li	a3,1
        while (__atomic_load_n(&locked, __ATOMIC_RELAXED) == 1)
    80205bd8:	4705                	li	a4,1
    while (__atomic_exchange_n(&locked, 1, __ATOMIC_ACQUIRE))
    80205bda:	87b6                	mv	a5,a3
    80205bdc:	0cf427af          	amoswap.w.aq	a5,a5,(s0)
    80205be0:	2781                	sext.w	a5,a5
    80205be2:	c799                	beqz	a5,80205bf0 <_ZN8Spinlock7acquireEv+0x70>
        while (__atomic_load_n(&locked, __ATOMIC_RELAXED) == 1)
    80205be4:	401c                	lw	a5,0(s0)
    80205be6:	2781                	sext.w	a5,a5
    80205be8:	fee799e3          	bne	a5,a4,80205bda <_ZN8Spinlock7acquireEv+0x5a>
            asm volatile("nop"); // RISC-V indicates that the CPU is in a spin state
    80205bec:	0001                	nop
    80205bee:	bfdd                	j	80205be4 <_ZN8Spinlock7acquireEv+0x64>
    cpu = mycpu();
    80205bf0:	3c7010ef          	jal	802077b6 <_Z5mycpuv>
}
    80205bf4:	60e2                	ld	ra,24(sp)
    cpu = mycpu();
    80205bf6:	e808                	sd	a0,16(s0)
}
    80205bf8:	6442                	ld	s0,16(sp)
    80205bfa:	64a2                	ld	s1,8(sp)
    80205bfc:	6105                	addi	sp,sp,32
    80205bfe:	8082                	ret
    r = (locked && cpu == mycpu());
    80205c00:	6804                	ld	s1,16(s0)
    80205c02:	3b5010ef          	jal	802077b6 <_Z5mycpuv>
    80205c06:	fca496e3          	bne	s1,a0,80205bd2 <_ZN8Spinlock7acquireEv+0x52>
    pop_off();
    80205c0a:	e29ff0ef          	jal	80205a32 <_Z7pop_offv>
        Drivers::uart_puts("panic: recursive acquire ");
    80205c0e:	0000c517          	auipc	a0,0xc
    80205c12:	08a50513          	addi	a0,a0,138 # 80211c98 <initcode_end+0x550>
    80205c16:	154030ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        Drivers::uart_puts(name);
    80205c1a:	6408                	ld	a0,8(s0)
    80205c1c:	14e030ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        Drivers::uart_puts("\n");
    80205c20:	0000c517          	auipc	a0,0xc
    80205c24:	c0050513          	addi	a0,a0,-1024 # 80211820 <initcode_end+0xd8>
    80205c28:	142030ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        while (1)
    80205c2c:	a001                	j	80205c2c <_ZN8Spinlock7acquireEv+0xac>

0000000080205c2e <_ZN5Mutex7acquireEv>:
{
    80205c2e:	1101                	addi	sp,sp,-32
    80205c30:	e426                	sd	s1,8(sp)
    lk.acquire(); // Acquire the internal lock to protect the locked field
    80205c32:	01850493          	addi	s1,a0,24
{
    80205c36:	e822                	sd	s0,16(sp)
    80205c38:	842a                	mv	s0,a0
    lk.acquire(); // Acquire the internal lock to protect the locked field
    80205c3a:	8526                	mv	a0,s1
{
    80205c3c:	ec06                	sd	ra,24(sp)
    80205c3e:	e04a                	sd	s2,0(sp)
    lk.acquire(); // Acquire the internal lock to protect the locked field
    80205c40:	f41ff0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
    while (locked)
    80205c44:	401c                	lw	a5,0(s0)
    80205c46:	c799                	beqz	a5,80205c54 <_ZN5Mutex7acquireEv+0x26>
        ProcManager::sleep(this, &lk);
    80205c48:	85a6                	mv	a1,s1
    80205c4a:	8522                	mv	a0,s0
    80205c4c:	2fa020ef          	jal	80207f46 <_ZN11ProcManager5sleepEPvP8Spinlock>
    while (locked)
    80205c50:	401c                	lw	a5,0(s0)
    80205c52:	fbfd                	bnez	a5,80205c48 <_ZN5Mutex7acquireEv+0x1a>
    locked = 1;
    80205c54:	4785                	li	a5,1
    80205c56:	c01c                	sw	a5,0(s0)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80205c58:	10002973          	csrr	s2,sstatus
    80205c5c:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80205c60:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80205c62:	10079073          	csrw	sstatus,a5
    struct cpu *c = mycpu();
    80205c66:	351010ef          	jal	802077b6 <_Z5mycpuv>
    if (c->noff == 0)
    80205c6a:	5d3c                	lw	a5,120(a0)
    80205c6c:	e799                	bnez	a5,80205c7a <_ZN5Mutex7acquireEv+0x4c>
  return (x & SSTATUS_SIE) != 0;
    80205c6e:	00195913          	srli	s2,s2,0x1
    80205c72:	00197913          	andi	s2,s2,1
        c->intena = old;
    80205c76:	07252e23          	sw	s2,124(a0)
    c->noff += 1;
    80205c7a:	2785                	addiw	a5,a5,1
    80205c7c:	dd3c                	sw	a5,120(a0)
    struct cpu *c = mycpu();
    80205c7e:	339010ef          	jal	802077b6 <_Z5mycpuv>
    struct Proc *p = c->proc;
    80205c82:	00053903          	ld	s2,0(a0)
    pop_off();
    80205c86:	dadff0ef          	jal	80205a32 <_Z7pop_offv>
}
    80205c8a:	60e2                	ld	ra,24(sp)
    pid = myproc()->pid;
    80205c8c:	08492783          	lw	a5,132(s2)
    lk.release();
    80205c90:	8526                	mv	a0,s1
}
    80205c92:	6902                	ld	s2,0(sp)
    pid = myproc()->pid;
    80205c94:	c81c                	sw	a5,16(s0)
}
    80205c96:	6442                	ld	s0,16(sp)
    80205c98:	64a2                	ld	s1,8(sp)
    80205c9a:	6105                	addi	sp,sp,32
    lk.release();
    80205c9c:	e7dff06f          	j	80205b18 <_ZN8Spinlock7releaseEv>

0000000080205ca0 <_ZN5Mutex7releaseEv>:
{
    80205ca0:	1101                	addi	sp,sp,-32
    80205ca2:	e426                	sd	s1,8(sp)
    lk.acquire();
    80205ca4:	01850493          	addi	s1,a0,24
{
    80205ca8:	e822                	sd	s0,16(sp)
    80205caa:	842a                	mv	s0,a0
    lk.acquire();
    80205cac:	8526                	mv	a0,s1
{
    80205cae:	ec06                	sd	ra,24(sp)
    lk.acquire();
    80205cb0:	ed1ff0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
    ProcManager::wakeup(this);
    80205cb4:	8522                	mv	a0,s0
    locked = 0;
    80205cb6:	00042023          	sw	zero,0(s0)
    pid = 0;
    80205cba:	00042823          	sw	zero,16(s0)
    ProcManager::wakeup(this);
    80205cbe:	38c020ef          	jal	8020804a <_ZN11ProcManager6wakeupEPv>
}
    80205cc2:	6442                	ld	s0,16(sp)
    80205cc4:	60e2                	ld	ra,24(sp)
    lk.release();
    80205cc6:	8526                	mv	a0,s1
}
    80205cc8:	64a2                	ld	s1,8(sp)
    80205cca:	6105                	addi	sp,sp,32
    lk.release();
    80205ccc:	e4dff06f          	j	80205b18 <_ZN8Spinlock7releaseEv>

0000000080205cd0 <_ZN5Mutex7holdingEv>:
{
    80205cd0:	1101                	addi	sp,sp,-32
    80205cd2:	e426                	sd	s1,8(sp)
    lk.acquire(); // Must use a lock when reading to prevent race conditions.
    80205cd4:	01850493          	addi	s1,a0,24
{
    80205cd8:	e822                	sd	s0,16(sp)
    80205cda:	842a                	mv	s0,a0
    lk.acquire(); // Must use a lock when reading to prevent race conditions.
    80205cdc:	8526                	mv	a0,s1
{
    80205cde:	ec06                	sd	ra,24(sp)
    lk.acquire(); // Must use a lock when reading to prevent race conditions.
    80205ce0:	ea1ff0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
    bool r = locked && (pid == myproc()->pid);
    80205ce4:	401c                	lw	a5,0(s0)
    80205ce6:	eb99                	bnez	a5,80205cfc <_ZN5Mutex7holdingEv+0x2c>
    80205ce8:	4401                	li	s0,0
    lk.release();
    80205cea:	8526                	mv	a0,s1
    80205cec:	e2dff0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
}
    80205cf0:	60e2                	ld	ra,24(sp)
    80205cf2:	8522                	mv	a0,s0
    80205cf4:	6442                	ld	s0,16(sp)
    80205cf6:	64a2                	ld	s1,8(sp)
    80205cf8:	6105                	addi	sp,sp,32
    80205cfa:	8082                	ret
    80205cfc:	e04a                	sd	s2,0(sp)
    bool r = locked && (pid == myproc()->pid);
    80205cfe:	01042903          	lw	s2,16(s0)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80205d02:	10002473          	csrr	s0,sstatus
    80205d06:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80205d0a:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80205d0c:	10079073          	csrw	sstatus,a5
    struct cpu *c = mycpu();
    80205d10:	2a7010ef          	jal	802077b6 <_Z5mycpuv>
    if (c->noff == 0)
    80205d14:	5d3c                	lw	a5,120(a0)
    80205d16:	e781                	bnez	a5,80205d1e <_ZN5Mutex7holdingEv+0x4e>
  return (x & SSTATUS_SIE) != 0;
    80205d18:	8005                	srli	s0,s0,0x1
    80205d1a:	8805                	andi	s0,s0,1
        c->intena = old;
    80205d1c:	dd60                	sw	s0,124(a0)
    c->noff += 1;
    80205d1e:	2785                	addiw	a5,a5,1
    80205d20:	dd3c                	sw	a5,120(a0)
    struct cpu *c = mycpu();
    80205d22:	295010ef          	jal	802077b6 <_Z5mycpuv>
    struct Proc *p = c->proc;
    80205d26:	6100                	ld	s0,0(a0)
    pop_off();
    80205d28:	d0bff0ef          	jal	80205a32 <_Z7pop_offv>
    bool r = locked && (pid == myproc()->pid);
    80205d2c:	08442403          	lw	s0,132(s0)
    80205d30:	41240433          	sub	s0,s0,s2
    80205d34:	00143413          	seqz	s0,s0
    80205d38:	6902                	ld	s2,0(sp)
    80205d3a:	bf45                	j	80205cea <_ZN5Mutex7holdingEv+0x1a>

0000000080205d3c <_ZN2VML4walkEPyyi>:
        return false;
    }

    static uint64 *walk(uint64 *pagetable, uint64 va, int alloc)
    {
        if (va >= MAXVA)
    80205d3c:	577d                	li	a4,-1
    80205d3e:	8369                	srli	a4,a4,0x1a
    80205d40:	08b76763          	bltu	a4,a1,80205dce <_ZN2VML4walkEPyyi+0x92>
    {
    80205d44:	7139                	addi	sp,sp,-64
    80205d46:	f426                	sd	s1,40(sp)
    80205d48:	f04a                	sd	s2,32(sp)
    80205d4a:	ec4e                	sd	s3,24(sp)
    80205d4c:	e852                	sd	s4,16(sp)
    80205d4e:	e456                	sd	s5,8(sp)
    80205d50:	fc06                	sd	ra,56(sp)
    80205d52:	f822                	sd	s0,48(sp)
    80205d54:	8a2e                	mv	s4,a1
    80205d56:	84aa                	mv	s1,a0
    80205d58:	8932                	mv	s2,a2
    80205d5a:	4a89                	li	s5,2
    80205d5c:	4789                	li	a5,2
    80205d5e:	4985                	li	s3,1
            return nullptr;

        for (int level = 2; level > 0; level--)
        {
            uint64 *pte = &pagetable[PX(level, va)];
    80205d60:	0037941b          	slliw	s0,a5,0x3
    80205d64:	9c3d                	addw	s0,s0,a5
    80205d66:	2431                	addiw	s0,s0,12
    80205d68:	008a5433          	srl	s0,s4,s0
    80205d6c:	1ff47413          	andi	s0,s0,511
    80205d70:	040e                	slli	s0,s0,0x3
    80205d72:	9426                	add	s0,s0,s1
            if (*pte & PTE_V)
    80205d74:	6004                	ld	s1,0(s0)
    80205d76:	0014f793          	andi	a5,s1,1
            {
                pagetable = (uint64 *)PTE2PA(*pte);
    80205d7a:	80a9                	srli	s1,s1,0xa
    80205d7c:	04b2                	slli	s1,s1,0xc
            if (*pte & PTE_V)
    80205d7e:	e38d                	bnez	a5,80205da0 <_ZN2VML4walkEPyyi+0x64>
            }
            else
            {
                if (!alloc || (pagetable = (uint64 *)PMM::alloc_page()) == nullptr)
    80205d80:	04090563          	beqz	s2,80205dca <_ZN2VML4walkEPyyi+0x8e>
    80205d84:	3de010ef          	jal	80207162 <_ZN3PMM10alloc_pageEv>
                    return nullptr;

                memset(pagetable, 0, PGSIZE);
    80205d88:	6605                	lui	a2,0x1
    80205d8a:	4581                	li	a1,0
                if (!alloc || (pagetable = (uint64 *)PMM::alloc_page()) == nullptr)
    80205d8c:	84aa                	mv	s1,a0
    80205d8e:	cd15                	beqz	a0,80205dca <_ZN2VML4walkEPyyi+0x8e>
                memset(pagetable, 0, PGSIZE);
    80205d90:	89aff0ef          	jal	80204e2a <_Z6memsetPvij>
                *pte = PA2PTE(pagetable) | PTE_V;
    80205d94:	00c4d793          	srli	a5,s1,0xc
    80205d98:	07aa                	slli	a5,a5,0xa
    80205d9a:	0017e793          	ori	a5,a5,1
    80205d9e:	e01c                	sd	a5,0(s0)
        for (int level = 2; level > 0; level--)
    80205da0:	4785                	li	a5,1
    80205da2:	013a8463          	beq	s5,s3,80205daa <_ZN2VML4walkEPyyi+0x6e>
    80205da6:	4a85                	li	s5,1
    80205da8:	bf65                	j	80205d60 <_ZN2VML4walkEPyyi+0x24>
            }
        }
        return &pagetable[PX(0, va)];
    80205daa:	00ca5a13          	srli	s4,s4,0xc
    80205dae:	1ffa7a13          	andi	s4,s4,511
    80205db2:	0a0e                	slli	s4,s4,0x3
    80205db4:	01448533          	add	a0,s1,s4
    }
    80205db8:	70e2                	ld	ra,56(sp)
    80205dba:	7442                	ld	s0,48(sp)
    80205dbc:	74a2                	ld	s1,40(sp)
    80205dbe:	7902                	ld	s2,32(sp)
    80205dc0:	69e2                	ld	s3,24(sp)
    80205dc2:	6a42                	ld	s4,16(sp)
    80205dc4:	6aa2                	ld	s5,8(sp)
    80205dc6:	6121                	addi	sp,sp,64
    80205dc8:	8082                	ret
            return nullptr;
    80205dca:	4501                	li	a0,0
    80205dcc:	b7f5                	j	80205db8 <_ZN2VML4walkEPyyi+0x7c>
    80205dce:	4501                	li	a0,0
    }
    80205dd0:	8082                	ret

0000000080205dd2 <_ZN2VM8uvmunmapEPyyyi.part.0>:
        }

        return newsz;
    }

    void uvmunmap(uint64 *pagetable, uint64 va, uint64 npages, int do_free)
    80205dd2:	7139                	addi	sp,sp,-64
    80205dd4:	ec4e                	sd	s3,24(sp)
        uint64 *pte;

        if ((va % PGSIZE) != 0)
            return;

        for (a = va; a < va + npages * PGSIZE; a += PGSIZE)
    80205dd6:	00c61993          	slli	s3,a2,0xc
    void uvmunmap(uint64 *pagetable, uint64 va, uint64 npages, int do_free)
    80205dda:	fc06                	sd	ra,56(sp)
        for (a = va; a < va + npages * PGSIZE; a += PGSIZE)
    80205ddc:	99ae                	add	s3,s3,a1
    80205dde:	0535f763          	bgeu	a1,s3,80205e2c <_ZN2VM8uvmunmapEPyyyi.part.0+0x5a>
    80205de2:	f426                	sd	s1,40(sp)
    80205de4:	e852                	sd	s4,16(sp)
    80205de6:	e456                	sd	s5,8(sp)
    80205de8:	e05a                	sd	s6,0(sp)
    80205dea:	f822                	sd	s0,48(sp)
    80205dec:	f04a                	sd	s2,32(sp)
    80205dee:	84ae                	mv	s1,a1
    80205df0:	8a2a                	mv	s4,a0
    80205df2:	8b36                	mv	s6,a3
    80205df4:	6a85                	lui	s5,0x1
        {
            if ((pte = walk(pagetable, a, 0)) == nullptr)
    80205df6:	4601                	li	a2,0
    80205df8:	85a6                	mv	a1,s1
    80205dfa:	8552                	mv	a0,s4
    80205dfc:	f41ff0ef          	jal	80205d3c <_ZN2VML4walkEPyyi>
    80205e00:	842a                	mv	s0,a0
    80205e02:	cd01                	beqz	a0,80205e1a <_ZN2VM8uvmunmapEPyyyi.part.0+0x48>
                continue;

            if ((*pte & PTE_V) == 0)
    80205e04:	611c                	ld	a5,0(a0)
    80205e06:	0017f713          	andi	a4,a5,1
                continue;

            if ((PTE_FLAGS(*pte) & (PTE_R | PTE_W | PTE_X)) == 0)
    80205e0a:	00e7f613          	andi	a2,a5,14
            if ((*pte & PTE_V) == 0)
    80205e0e:	c711                	beqz	a4,80205e1a <_ZN2VM8uvmunmapEPyyyi.part.0+0x48>
            if ((PTE_FLAGS(*pte) & (PTE_R | PTE_W | PTE_X)) == 0)
    80205e10:	c609                	beqz	a2,80205e1a <_ZN2VM8uvmunmapEPyyyi.part.0+0x48>
            {
                continue;
            }

            if (do_free)
    80205e12:	020b1163          	bnez	s6,80205e34 <_ZN2VM8uvmunmapEPyyyi.part.0+0x62>
                if (page_ref_dec(pa))
                {
                    PMM::free_page((void *)pa);
                }
            }
            *pte = 0;
    80205e16:	00043023          	sd	zero,0(s0)
        for (a = va; a < va + npages * PGSIZE; a += PGSIZE)
    80205e1a:	94d6                	add	s1,s1,s5
    80205e1c:	fd34ede3          	bltu	s1,s3,80205df6 <_ZN2VM8uvmunmapEPyyyi.part.0+0x24>
    80205e20:	7442                	ld	s0,48(sp)
    80205e22:	74a2                	ld	s1,40(sp)
    80205e24:	7902                	ld	s2,32(sp)
    80205e26:	6a42                	ld	s4,16(sp)
    80205e28:	6aa2                	ld	s5,8(sp)
    80205e2a:	6b02                	ld	s6,0(sp)
        }
    }
    80205e2c:	70e2                	ld	ra,56(sp)
    80205e2e:	69e2                	ld	s3,24(sp)
    80205e30:	6121                	addi	sp,sp,64
    80205e32:	8082                	ret
                uint64 pa = PTE2PA(*pte);
    80205e34:	83a9                	srli	a5,a5,0xa
    80205e36:	00c79913          	slli	s2,a5,0xc
        struct Page *p = PMM::pa_to_page(pa);
    80205e3a:	854a                	mv	a0,s2
    80205e3c:	65b000ef          	jal	80206c96 <_ZN3PMM10pa_to_pageEy>
            if (__atomic_sub_fetch(&p->refcnt, 1, __ATOMIC_RELEASE) == 0)
    80205e40:	00250713          	addi	a4,a0,2
    80205e44:	00377693          	andi	a3,a4,3
    80205e48:	67c1                	lui	a5,0x10
    80205e4a:	0036969b          	slliw	a3,a3,0x3
    80205e4e:	37fd                	addiw	a5,a5,-1 # ffff <_start-0x801f0001>
    80205e50:	00d797bb          	sllw	a5,a5,a3
    80205e54:	567d                	li	a2,-1
    80205e56:	9b71                	andi	a4,a4,-4
    80205e58:	fff7c813          	not	a6,a5
    80205e5c:	00d615bb          	sllw	a1,a2,a3
        if (p)
    80205e60:	d95d                	beqz	a0,80205e16 <_ZN2VM8uvmunmapEPyyyi.part.0+0x44>
            if (__atomic_sub_fetch(&p->refcnt, 1, __ATOMIC_RELEASE) == 0)
    80205e62:	1007262f          	lr.w	a2,(a4)
    80205e66:	00b60533          	add	a0,a2,a1
    80205e6a:	8d7d                	and	a0,a0,a5
    80205e6c:	010678b3          	and	a7,a2,a6
    80205e70:	00a8e8b3          	or	a7,a7,a0
    80205e74:	1b17252f          	sc.w.rl	a0,a7,(a4)
    80205e78:	f56d                	bnez	a0,80205e62 <_ZN2VM8uvmunmapEPyyyi.part.0+0x90>
    80205e7a:	40d6563b          	sraw	a2,a2,a3
    80205e7e:	367d                	addiw	a2,a2,-1 # fff <_start-0x801ff001>
    80205e80:	1642                	slli	a2,a2,0x30
    80205e82:	9241                	srli	a2,a2,0x30
    80205e84:	fa49                	bnez	a2,80205e16 <_ZN2VM8uvmunmapEPyyyi.part.0+0x44>
                    PMM::free_page((void *)pa);
    80205e86:	854a                	mv	a0,s2
    80205e88:	2fc010ef          	jal	80207184 <_ZN3PMM9free_pageEPv>
    80205e8c:	b769                	j	80205e16 <_ZN2VM8uvmunmapEPyyyi.part.0+0x44>

0000000080205e8e <_ZN2VML8freewalkEPy>:

    static void freewalk(uint64 *pagetable)
    {
    80205e8e:	7111                	addi	sp,sp,-256
    80205e90:	6785                	lui	a5,0x1
    80205e92:	f9a2                	sd	s0,240(sp)
    80205e94:	f1ca                	sd	s2,224(sp)
    80205e96:	e1da                	sd	s6,192(sp)
    80205e98:	fd5e                	sd	s7,184(sp)
    80205e9a:	fd86                	sd	ra,248(sp)
    80205e9c:	842a                	mv	s0,a0
    80205e9e:	892a                	mv	s2,a0
    80205ea0:	00f50b33          	add	s6,a0,a5
    80205ea4:	6b85                	lui	s7,0x1
    80205ea6:	a021                	j	80205eae <_ZN2VML8freewalkEPy+0x20>
        for (int i = 0; i < 512; i++)
    80205ea8:	0921                	addi	s2,s2,8
    80205eaa:	23690563          	beq	s2,s6,802060d4 <_ZN2VML8freewalkEPy+0x246>
        {
            uint64 pte = pagetable[i];
    80205eae:	00093783          	ld	a5,0(s2)
            if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0)
    80205eb2:	4705                	li	a4,1
    80205eb4:	00f7f693          	andi	a3,a5,15
    80205eb8:	fee698e3          	bne	a3,a4,80205ea8 <_ZN2VML8freewalkEPy+0x1a>
            {
                uint64 *child = (uint64 *)PTE2PA(pte);
    80205ebc:	83a9                	srli	a5,a5,0xa
    80205ebe:	e9d2                	sd	s4,208(sp)
    80205ec0:	00c79a13          	slli	s4,a5,0xc
    80205ec4:	f5a6                	sd	s1,232(sp)
    80205ec6:	e5d6                	sd	s5,200(sp)
    80205ec8:	f566                	sd	s9,168(sp)
    80205eca:	ed6e                	sd	s11,152(sp)
        for (int i = 0; i < 512; i++)
    80205ecc:	017a0cb3          	add	s9,s4,s7
            if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0)
    80205ed0:	4d85                	li	s11,1
    80205ed2:	8ad2                	mv	s5,s4
    80205ed4:	84a2                	mv	s1,s0
    80205ed6:	a021                	j	80205ede <_ZN2VML8freewalkEPy+0x50>
        for (int i = 0; i < 512; i++)
    80205ed8:	0a21                	addi	s4,s4,8
    80205eda:	1d9a0f63          	beq	s4,s9,802060b8 <_ZN2VML8freewalkEPy+0x22a>
            uint64 pte = pagetable[i];
    80205ede:	000a3783          	ld	a5,0(s4)
            if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0)
    80205ee2:	00f7f713          	andi	a4,a5,15
    80205ee6:	ffb719e3          	bne	a4,s11,80205ed8 <_ZN2VML8freewalkEPy+0x4a>
                uint64 *child = (uint64 *)PTE2PA(pte);
    80205eea:	83a9                	srli	a5,a5,0xa
    80205eec:	edce                	sd	s3,216(sp)
    80205eee:	00c79993          	slli	s3,a5,0xc
    80205ef2:	f962                	sd	s8,176(sp)
    80205ef4:	f16a                	sd	s10,160(sp)
    80205ef6:	8c4e                	mv	s8,s3
        for (int i = 0; i < 512; i++)
    80205ef8:	01798d33          	add	s10,s3,s7
    80205efc:	844e                	mv	s0,s3
    80205efe:	a021                	j	80205f06 <_ZN2VML8freewalkEPy+0x78>
    80205f00:	0421                	addi	s0,s0,8
    80205f02:	1ba40063          	beq	s0,s10,802060a2 <_ZN2VML8freewalkEPy+0x214>
            uint64 pte = pagetable[i];
    80205f06:	601c                	ld	a5,0(s0)
            if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0)
    80205f08:	00f7f713          	andi	a4,a5,15
    80205f0c:	ffb71ae3          	bne	a4,s11,80205f00 <_ZN2VML8freewalkEPy+0x72>
                uint64 *child = (uint64 *)PTE2PA(pte);
    80205f10:	83a9                	srli	a5,a5,0xa
    80205f12:	07b2                	slli	a5,a5,0xc
        for (int i = 0; i < 512; i++)
    80205f14:	8726                	mv	a4,s1
    80205f16:	fc56                	sd	s5,56(sp)
    80205f18:	84ca                	mv	s1,s2
    80205f1a:	017789b3          	add	s3,a5,s7
    80205f1e:	f822                	sd	s0,48(sp)
    80205f20:	8abe                	mv	s5,a5
    80205f22:	893a                	mv	s2,a4
    80205f24:	a021                	j	80205f2c <_ZN2VML8freewalkEPy+0x9e>
    80205f26:	07a1                	addi	a5,a5,8 # 1008 <_start-0x801feff8>
    80205f28:	16f98063          	beq	s3,a5,80206088 <_ZN2VML8freewalkEPy+0x1fa>
            uint64 pte = pagetable[i];
    80205f2c:	6398                	ld	a4,0(a5)
            if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0)
    80205f2e:	00f77693          	andi	a3,a4,15
    80205f32:	ffb69ae3          	bne	a3,s11,80205f26 <_ZN2VML8freewalkEPy+0x98>
                uint64 *child = (uint64 *)PTE2PA(pte);
    80205f36:	8329                	srli	a4,a4,0xa
    80205f38:	0732                	slli	a4,a4,0xc
        for (int i = 0; i < 512; i++)
    80205f3a:	017706b3          	add	a3,a4,s7
    80205f3e:	e0ce                	sd	s3,64(sp)
    80205f40:	e436                	sd	a3,8(sp)
    80205f42:	e4be                	sd	a5,72(sp)
    80205f44:	89ba                	mv	s3,a4
    80205f46:	a029                	j	80205f50 <_ZN2VML8freewalkEPy+0xc2>
    80205f48:	67a2                	ld	a5,8(sp)
    80205f4a:	0721                	addi	a4,a4,8
    80205f4c:	12e78263          	beq	a5,a4,80206070 <_ZN2VML8freewalkEPy+0x1e2>
            uint64 pte = pagetable[i];
    80205f50:	631c                	ld	a5,0(a4)
            if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0)
    80205f52:	00f7f693          	andi	a3,a5,15
    80205f56:	ffb699e3          	bne	a3,s11,80205f48 <_ZN2VML8freewalkEPy+0xba>
                uint64 *child = (uint64 *)PTE2PA(pte);
    80205f5a:	83a9                	srli	a5,a5,0xa
    80205f5c:	07b2                	slli	a5,a5,0xc
        for (int i = 0; i < 512; i++)
    80205f5e:	017786b3          	add	a3,a5,s7
    80205f62:	e8e2                	sd	s8,80(sp)
    80205f64:	ec36                	sd	a3,24(sp)
    80205f66:	8c56                	mv	s8,s5
    80205f68:	ecba                	sd	a4,88(sp)
    80205f6a:	8abe                	mv	s5,a5
    80205f6c:	f0ca                	sd	s2,96(sp)
    80205f6e:	a029                	j	80205f78 <_ZN2VML8freewalkEPy+0xea>
    80205f70:	6762                	ld	a4,24(sp)
    80205f72:	07a1                	addi	a5,a5,8
    80205f74:	0cf70f63          	beq	a4,a5,80206052 <_ZN2VML8freewalkEPy+0x1c4>
            uint64 pte = pagetable[i];
    80205f78:	6398                	ld	a4,0(a5)
            if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0)
    80205f7a:	00f77693          	andi	a3,a4,15
    80205f7e:	ffb699e3          	bne	a3,s11,80205f70 <_ZN2VML8freewalkEPy+0xe2>
                uint64 *child = (uint64 *)PTE2PA(pte);
    80205f82:	8329                	srli	a4,a4,0xa
    80205f84:	00c71913          	slli	s2,a4,0xc
        for (int i = 0; i < 512; i++)
    80205f88:	01790733          	add	a4,s2,s7
    80205f8c:	f4ca                	sd	s2,104(sp)
    80205f8e:	844a                	mv	s0,s2
    80205f90:	f03a                	sd	a4,32(sp)
    80205f92:	f8be                	sd	a5,112(sp)
    80205f94:	8926                	mv	s2,s1
    80205f96:	a029                	j	80205fa0 <_ZN2VML8freewalkEPy+0x112>
    80205f98:	7782                	ld	a5,32(sp)
    80205f9a:	0421                	addi	s0,s0,8
    80205f9c:	08878e63          	beq	a5,s0,80206038 <_ZN2VML8freewalkEPy+0x1aa>
            uint64 pte = pagetable[i];
    80205fa0:	601c                	ld	a5,0(s0)
            if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0)
    80205fa2:	00f7f693          	andi	a3,a5,15
    80205fa6:	ffb699e3          	bne	a3,s11,80205f98 <_ZN2VML8freewalkEPy+0x10a>
                uint64 *child = (uint64 *)PTE2PA(pte);
    80205faa:	83a9                	srli	a5,a5,0xa
    80205fac:	00c79493          	slli	s1,a5,0xc
    80205fb0:	017487b3          	add	a5,s1,s7
    80205fb4:	e826                	sd	s1,16(sp)
        for (int i = 0; i < 512; i++)
    80205fb6:	f43e                	sd	a5,40(sp)
    80205fb8:	fca2                	sd	s0,120(sp)
    80205fba:	a029                	j	80205fc4 <_ZN2VML8freewalkEPy+0x136>
    80205fbc:	77a2                	ld	a5,40(sp)
    80205fbe:	04a1                	addi	s1,s1,8
    80205fc0:	06978263          	beq	a5,s1,80206024 <_ZN2VML8freewalkEPy+0x196>
            uint64 pte = pagetable[i];
    80205fc4:	609c                	ld	a5,0(s1)
            if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0)
    80205fc6:	00f7f693          	andi	a3,a5,15
    80205fca:	ffb699e3          	bne	a3,s11,80205fbc <_ZN2VML8freewalkEPy+0x12e>
                uint64 *child = (uint64 *)PTE2PA(pte);
    80205fce:	83a9                	srli	a5,a5,0xa
    80205fd0:	00c79413          	slli	s0,a5,0xc
        for (int i = 0; i < 512; i++)
    80205fd4:	017406b3          	add	a3,s0,s7
    80205fd8:	e14a                	sd	s2,128(sp)
    80205fda:	e55a                	sd	s6,136(sp)
    80205fdc:	8922                	mv	s2,s0
    80205fde:	8b52                	mv	s6,s4
    80205fe0:	8a26                	mv	s4,s1
    80205fe2:	84b6                	mv	s1,a3
    80205fe4:	a021                	j	80205fec <_ZN2VML8freewalkEPy+0x15e>
    80205fe6:	0421                	addi	s0,s0,8
    80205fe8:	02848163          	beq	s1,s0,8020600a <_ZN2VML8freewalkEPy+0x17c>
            uint64 pte = pagetable[i];
    80205fec:	601c                	ld	a5,0(s0)
            if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0)
    80205fee:	00f7f713          	andi	a4,a5,15
    80205ff2:	ffb71ae3          	bne	a4,s11,80205fe6 <_ZN2VML8freewalkEPy+0x158>
                uint64 *child = (uint64 *)PTE2PA(pte);
    80205ff6:	83a9                	srli	a5,a5,0xa
                freewalk(child);
    80205ff8:	00c79513          	slli	a0,a5,0xc
    80205ffc:	e93ff0ef          	jal	80205e8e <_ZN2VML8freewalkEPy>
        for (int i = 0; i < 512; i++)
    80206000:	0421                	addi	s0,s0,8
                pagetable[i] = 0;
    80206002:	fe043c23          	sd	zero,-8(s0)
        for (int i = 0; i < 512; i++)
    80206006:	fe8493e3          	bne	s1,s0,80205fec <_ZN2VML8freewalkEPy+0x15e>
            }
        }
        PMM::free_page(pagetable);
    8020600a:	854a                	mv	a0,s2
    8020600c:	84d2                	mv	s1,s4
    8020600e:	690a                	ld	s2,128(sp)
    80206010:	8a5a                	mv	s4,s6
    80206012:	6b2a                	ld	s6,136(sp)
    80206014:	170010ef          	jal	80207184 <_ZN3PMM9free_pageEPv>
        for (int i = 0; i < 512; i++)
    80206018:	77a2                	ld	a5,40(sp)
                pagetable[i] = 0;
    8020601a:	0004b023          	sd	zero,0(s1)
        for (int i = 0; i < 512; i++)
    8020601e:	04a1                	addi	s1,s1,8
    80206020:	fa9792e3          	bne	a5,s1,80205fc4 <_ZN2VML8freewalkEPy+0x136>
        PMM::free_page(pagetable);
    80206024:	6542                	ld	a0,16(sp)
    80206026:	7466                	ld	s0,120(sp)
    80206028:	15c010ef          	jal	80207184 <_ZN3PMM9free_pageEPv>
        for (int i = 0; i < 512; i++)
    8020602c:	7782                	ld	a5,32(sp)
                pagetable[i] = 0;
    8020602e:	00043023          	sd	zero,0(s0)
        for (int i = 0; i < 512; i++)
    80206032:	0421                	addi	s0,s0,8
    80206034:	f68796e3          	bne	a5,s0,80205fa0 <_ZN2VML8freewalkEPy+0x112>
        PMM::free_page(pagetable);
    80206038:	77c6                	ld	a5,112(sp)
    8020603a:	7526                	ld	a0,104(sp)
    8020603c:	84ca                	mv	s1,s2
    8020603e:	e83e                	sd	a5,16(sp)
    80206040:	144010ef          	jal	80207184 <_ZN3PMM9free_pageEPv>
                pagetable[i] = 0;
    80206044:	67c2                	ld	a5,16(sp)
        for (int i = 0; i < 512; i++)
    80206046:	6762                	ld	a4,24(sp)
                pagetable[i] = 0;
    80206048:	0007b023          	sd	zero,0(a5)
        for (int i = 0; i < 512; i++)
    8020604c:	07a1                	addi	a5,a5,8
    8020604e:	f2f715e3          	bne	a4,a5,80205f78 <_ZN2VML8freewalkEPy+0xea>
        PMM::free_page(pagetable);
    80206052:	6766                	ld	a4,88(sp)
    80206054:	8556                	mv	a0,s5
    80206056:	7906                	ld	s2,96(sp)
    80206058:	e83a                	sd	a4,16(sp)
    8020605a:	8ae2                	mv	s5,s8
    8020605c:	6c46                	ld	s8,80(sp)
    8020605e:	126010ef          	jal	80207184 <_ZN3PMM9free_pageEPv>
                pagetable[i] = 0;
    80206062:	6742                	ld	a4,16(sp)
        for (int i = 0; i < 512; i++)
    80206064:	67a2                	ld	a5,8(sp)
                pagetable[i] = 0;
    80206066:	00073023          	sd	zero,0(a4)
        for (int i = 0; i < 512; i++)
    8020606a:	0721                	addi	a4,a4,8
    8020606c:	eee792e3          	bne	a5,a4,80205f50 <_ZN2VML8freewalkEPy+0xc2>
        PMM::free_page(pagetable);
    80206070:	67a6                	ld	a5,72(sp)
    80206072:	854e                	mv	a0,s3
    80206074:	6986                	ld	s3,64(sp)
    80206076:	e43e                	sd	a5,8(sp)
    80206078:	10c010ef          	jal	80207184 <_ZN3PMM9free_pageEPv>
                pagetable[i] = 0;
    8020607c:	67a2                	ld	a5,8(sp)
    8020607e:	0007b023          	sd	zero,0(a5)
        for (int i = 0; i < 512; i++)
    80206082:	07a1                	addi	a5,a5,8
    80206084:	eaf994e3          	bne	s3,a5,80205f2c <_ZN2VML8freewalkEPy+0x9e>
        PMM::free_page(pagetable);
    80206088:	7442                	ld	s0,48(sp)
    8020608a:	87ca                	mv	a5,s2
    8020608c:	8556                	mv	a0,s5
    8020608e:	8926                	mv	s2,s1
    80206090:	7ae2                	ld	s5,56(sp)
    80206092:	84be                	mv	s1,a5
        for (int i = 0; i < 512; i++)
    80206094:	0421                	addi	s0,s0,8
        PMM::free_page(pagetable);
    80206096:	0ee010ef          	jal	80207184 <_ZN3PMM9free_pageEPv>
                pagetable[i] = 0;
    8020609a:	fe043c23          	sd	zero,-8(s0)
        for (int i = 0; i < 512; i++)
    8020609e:	e7a414e3          	bne	s0,s10,80205f06 <_ZN2VML8freewalkEPy+0x78>
        PMM::free_page(pagetable);
    802060a2:	8562                	mv	a0,s8
    802060a4:	0e0010ef          	jal	80207184 <_ZN3PMM9free_pageEPv>
        for (int i = 0; i < 512; i++)
    802060a8:	0a21                	addi	s4,s4,8
                pagetable[i] = 0;
    802060aa:	fe0a3c23          	sd	zero,-8(s4)
    802060ae:	69ee                	ld	s3,216(sp)
    802060b0:	7c4a                	ld	s8,176(sp)
    802060b2:	7d0a                	ld	s10,160(sp)
        for (int i = 0; i < 512; i++)
    802060b4:	e39a15e3          	bne	s4,s9,80205ede <_ZN2VML8freewalkEPy+0x50>
        PMM::free_page(pagetable);
    802060b8:	8556                	mv	a0,s5
    802060ba:	0ca010ef          	jal	80207184 <_ZN3PMM9free_pageEPv>
        for (int i = 0; i < 512; i++)
    802060be:	0921                	addi	s2,s2,8
                pagetable[i] = 0;
    802060c0:	fe093c23          	sd	zero,-8(s2)
        PMM::free_page(pagetable);
    802060c4:	8426                	mv	s0,s1
                pagetable[i] = 0;
    802060c6:	6a4e                	ld	s4,208(sp)
    802060c8:	74ae                	ld	s1,232(sp)
    802060ca:	6aae                	ld	s5,200(sp)
    802060cc:	7caa                	ld	s9,168(sp)
    802060ce:	6dea                	ld	s11,152(sp)
        for (int i = 0; i < 512; i++)
    802060d0:	dd691fe3          	bne	s2,s6,80205eae <_ZN2VML8freewalkEPy+0x20>
        PMM::free_page(pagetable);
    802060d4:	8522                	mv	a0,s0
    }
    802060d6:	744e                	ld	s0,240(sp)
    802060d8:	70ee                	ld	ra,248(sp)
    802060da:	790e                	ld	s2,224(sp)
    802060dc:	6b0e                	ld	s6,192(sp)
    802060de:	7bea                	ld	s7,184(sp)
    802060e0:	6111                	addi	sp,sp,256
        PMM::free_page(pagetable);
    802060e2:	0a20106f          	j	80207184 <_ZN3PMM9free_pageEPv>

00000000802060e6 <_ZN2VM8mappagesEPyyyyi>:
        if (size == 0)
    802060e6:	ca35                	beqz	a2,8020615a <_ZN2VM8mappagesEPyyyyi+0x74>
    {
    802060e8:	7139                	addi	sp,sp,-64
        a = PGROUNDDOWN(va);
    802060ea:	77fd                	lui	a5,0xfffff
    {
    802060ec:	f04a                	sd	s2,32(sp)
        last = PGROUNDDOWN(va + size - 1);
    802060ee:	fff58913          	addi	s2,a1,-1
    {
    802060f2:	e05a                	sd	s6,0(sp)
        last = PGROUNDDOWN(va + size - 1);
    802060f4:	9932                	add	s2,s2,a2
        a = PGROUNDDOWN(va);
    802060f6:	00f5fb33          	and	s6,a1,a5
    {
    802060fa:	f426                	sd	s1,40(sp)
    802060fc:	ec4e                	sd	s3,24(sp)
    802060fe:	e852                	sd	s4,16(sp)
    80206100:	e456                	sd	s5,8(sp)
    80206102:	fc06                	sd	ra,56(sp)
    80206104:	f822                	sd	s0,48(sp)
    80206106:	89aa                	mv	s3,a0
    80206108:	8a3a                	mv	s4,a4
        last = PGROUNDDOWN(va + size - 1);
    8020610a:	00f97933          	and	s2,s2,a5
    8020610e:	416684b3          	sub	s1,a3,s6
            a += PGSIZE;
    80206112:	6a85                	lui	s5,0x1
    80206114:	a801                	j	80206124 <_ZN2VM8mappagesEPyyyyi+0x3e>
            if (*pte & PTE_V)
    80206116:	611c                	ld	a5,0(a0)
    80206118:	8b85                	andi	a5,a5,1
    8020611a:	e39d                	bnez	a5,80206140 <_ZN2VM8mappagesEPyyyyi+0x5a>
            *pte = PA2PTE(pa) | perm | PTE_V;
    8020611c:	e100                	sd	s0,0(a0)
            if (a == last)
    8020611e:	032b0c63          	beq	s6,s2,80206156 <_ZN2VM8mappagesEPyyyyi+0x70>
            a += PGSIZE;
    80206122:	9b56                	add	s6,s6,s5
        for (;;)
    80206124:	009b0433          	add	s0,s6,s1
            *pte = PA2PTE(pa) | perm | PTE_V;
    80206128:	8031                	srli	s0,s0,0xc
            if ((pte = walk(pagetable, a, 1)) == nullptr)
    8020612a:	4605                	li	a2,1
    8020612c:	85da                	mv	a1,s6
    8020612e:	854e                	mv	a0,s3
            *pte = PA2PTE(pa) | perm | PTE_V;
    80206130:	042a                	slli	s0,s0,0xa
    80206132:	01446433          	or	s0,s0,s4
            if ((pte = walk(pagetable, a, 1)) == nullptr)
    80206136:	c07ff0ef          	jal	80205d3c <_ZN2VML4walkEPyyi>
            *pte = PA2PTE(pa) | perm | PTE_V;
    8020613a:	00146413          	ori	s0,s0,1
            if ((pte = walk(pagetable, a, 1)) == nullptr)
    8020613e:	fd61                	bnez	a0,80206116 <_ZN2VM8mappagesEPyyyyi+0x30>
            return -1;
    80206140:	557d                	li	a0,-1
    }
    80206142:	70e2                	ld	ra,56(sp)
    80206144:	7442                	ld	s0,48(sp)
    80206146:	74a2                	ld	s1,40(sp)
    80206148:	7902                	ld	s2,32(sp)
    8020614a:	69e2                	ld	s3,24(sp)
    8020614c:	6a42                	ld	s4,16(sp)
    8020614e:	6aa2                	ld	s5,8(sp)
    80206150:	6b02                	ld	s6,0(sp)
    80206152:	6121                	addi	sp,sp,64
    80206154:	8082                	ret
        return 0;
    80206156:	4501                	li	a0,0
    80206158:	b7ed                	j	80206142 <_ZN2VM8mappagesEPyyyyi+0x5c>
            return -1;
    8020615a:	557d                	li	a0,-1
    }
    8020615c:	8082                	ret

000000008020615e <_ZN2VM9uvmcreateEv>:
    {
    8020615e:	1141                	addi	sp,sp,-16
    80206160:	e406                	sd	ra,8(sp)
    80206162:	e022                	sd	s0,0(sp)
        uint64 *pagetable = (uint64 *)PMM::alloc_page();
    80206164:	7ff000ef          	jal	80207162 <_ZN3PMM10alloc_pageEv>
        if (pagetable)
    80206168:	c139                	beqz	a0,802061ae <_ZN2VM9uvmcreateEv+0x50>
            memset(pagetable, 0, PGSIZE);
    8020616a:	6605                	lui	a2,0x1
    8020616c:	4581                	li	a1,0
    8020616e:	842a                	mv	s0,a0
    80206170:	cbbfe0ef          	jal	80204e2a <_Z6memsetPvij>
            if ((pte = walk(pagetable, a, 1)) == nullptr)
    80206174:	040005b7          	lui	a1,0x4000
    80206178:	15fd                	addi	a1,a1,-1 # 3ffffff <_start-0x7c200001>
    8020617a:	4605                	li	a2,1
    8020617c:	05b2                	slli	a1,a1,0xc
    8020617e:	8522                	mv	a0,s0
    80206180:	bbdff0ef          	jal	80205d3c <_ZN2VML4walkEPyyi>
    80206184:	c115                	beqz	a0,802061a8 <_ZN2VM9uvmcreateEv+0x4a>
            if (*pte & PTE_V)
    80206186:	611c                	ld	a5,0(a0)
    80206188:	8b85                	andi	a5,a5,1
    8020618a:	ef99                	bnez	a5,802061a8 <_ZN2VM9uvmcreateEv+0x4a>
            *pte = PA2PTE(pa) | perm | PTE_V;
    8020618c:	0000f797          	auipc	a5,0xf
    80206190:	8e47b783          	ld	a5,-1820(a5) # 80214a70 <_GLOBAL_OFFSET_TABLE_+0x10>
    80206194:	83b1                	srli	a5,a5,0xc
    80206196:	07aa                	slli	a5,a5,0xa
    80206198:	00b7e793          	ori	a5,a5,11
    8020619c:	e11c                	sd	a5,0(a0)
    }
    8020619e:	60a2                	ld	ra,8(sp)
    802061a0:	8522                	mv	a0,s0
    802061a2:	6402                	ld	s0,0(sp)
    802061a4:	0141                	addi	sp,sp,16
    802061a6:	8082                	ret
                PMM::free_page(pagetable);
    802061a8:	8522                	mv	a0,s0
    802061aa:	7db000ef          	jal	80207184 <_ZN3PMM9free_pageEPv>
                return nullptr;
    802061ae:	4401                	li	s0,0
    802061b0:	b7fd                	j	8020619e <_ZN2VM9uvmcreateEv+0x40>

00000000802061b2 <_ZN2VM7uvminitEPyPhy>:
        if (sz >= PGSIZE)
    802061b2:	6785                	lui	a5,0x1
    802061b4:	04f67d63          	bgeu	a2,a5,8020620e <_ZN2VM7uvminitEPyPhy+0x5c>
    {
    802061b8:	7179                	addi	sp,sp,-48
    802061ba:	f406                	sd	ra,40(sp)
    802061bc:	f022                	sd	s0,32(sp)
    802061be:	ec26                	sd	s1,24(sp)
    802061c0:	e84a                	sd	s2,16(sp)
    802061c2:	e44e                	sd	s3,8(sp)
    802061c4:	84b2                	mv	s1,a2
    802061c6:	89aa                	mv	s3,a0
    802061c8:	892e                	mv	s2,a1
        mem = (char *)PMM::alloc_page();
    802061ca:	799000ef          	jal	80207162 <_ZN3PMM10alloc_pageEv>
        memset(mem, 0, PGSIZE);
    802061ce:	6605                	lui	a2,0x1
    802061d0:	4581                	li	a1,0
        mem = (char *)PMM::alloc_page();
    802061d2:	842a                	mv	s0,a0
        memset(mem, 0, PGSIZE);
    802061d4:	c57fe0ef          	jal	80204e2a <_Z6memsetPvij>
            if ((pte = walk(pagetable, a, 1)) == nullptr)
    802061d8:	4605                	li	a2,1
    802061da:	4581                	li	a1,0
    802061dc:	854e                	mv	a0,s3
    802061de:	b5fff0ef          	jal	80205d3c <_ZN2VML4walkEPyyi>
    802061e2:	c911                	beqz	a0,802061f6 <_ZN2VM7uvminitEPyPhy+0x44>
            if (*pte & PTE_V)
    802061e4:	611c                	ld	a5,0(a0)
    802061e6:	8b85                	andi	a5,a5,1
    802061e8:	e799                	bnez	a5,802061f6 <_ZN2VM7uvminitEPyPhy+0x44>
            *pte = PA2PTE(pa) | perm | PTE_V;
    802061ea:	00c45793          	srli	a5,s0,0xc
    802061ee:	07aa                	slli	a5,a5,0xa
    802061f0:	01f7e793          	ori	a5,a5,31
    802061f4:	e11c                	sd	a5,0(a0)
        memmove(mem, src, sz);
    802061f6:	8522                	mv	a0,s0
    }
    802061f8:	7402                	ld	s0,32(sp)
    802061fa:	70a2                	ld	ra,40(sp)
    802061fc:	69a2                	ld	s3,8(sp)
        memmove(mem, src, sz);
    802061fe:	0004861b          	sext.w	a2,s1
    80206202:	85ca                	mv	a1,s2
    }
    80206204:	64e2                	ld	s1,24(sp)
    80206206:	6942                	ld	s2,16(sp)
    80206208:	6145                	addi	sp,sp,48
        memmove(mem, src, sz);
    8020620a:	c6bfe06f          	j	80204e74 <_Z7memmovePvPKvj>
            Drivers::uart_puts("uvminit: initcode too big!\n");
    8020620e:	0000c517          	auipc	a0,0xc
    80206212:	aaa50513          	addi	a0,a0,-1366 # 80211cb8 <initcode_end+0x570>
    80206216:	3550206f          	j	80208d6a <_ZN7Drivers9uart_putsEPKc>

000000008020621a <_ZN2VM8uvmallocEPyyyi>:
        if (newsz < oldsz)
    8020621a:	06b66b63          	bltu	a2,a1,80206290 <_ZN2VM8uvmallocEPyyyi+0x76>
        oldsz = PGROUNDUP(oldsz);
    8020621e:	6785                	lui	a5,0x1
    80206220:	17fd                	addi	a5,a5,-1 # fff <_start-0x801ff001>
    {
    80206222:	7139                	addi	sp,sp,-64
        oldsz = PGROUNDUP(oldsz);
    80206224:	95be                	add	a1,a1,a5
    80206226:	77fd                	lui	a5,0xfffff
    {
    80206228:	f426                	sd	s1,40(sp)
    8020622a:	f04a                	sd	s2,32(sp)
    8020622c:	ec4e                	sd	s3,24(sp)
    8020622e:	e852                	sd	s4,16(sp)
    80206230:	e456                	sd	s5,8(sp)
        oldsz = PGROUNDUP(oldsz);
    80206232:	00f5fa33          	and	s4,a1,a5
    {
    80206236:	fc06                	sd	ra,56(sp)
    80206238:	8ab2                	mv	s5,a2
    8020623a:	89aa                	mv	s3,a0
        for (a = oldsz; a < newsz; a += PGSIZE)
    8020623c:	84d2                	mv	s1,s4
            if (mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R | PTE_U | xperm) != 0)
    8020623e:	0126e913          	ori	s2,a3,18
        for (a = oldsz; a < newsz; a += PGSIZE)
    80206242:	04ca7a63          	bgeu	s4,a2,80206296 <_ZN2VM8uvmallocEPyyyi+0x7c>
    80206246:	f822                	sd	s0,48(sp)
    80206248:	a839                	j	80206266 <_ZN2VM8uvmallocEPyyyi+0x4c>
            memset(mem, 0, PGSIZE);
    8020624a:	be1fe0ef          	jal	80204e2a <_Z6memsetPvij>
            if (mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R | PTE_U | xperm) != 0)
    8020624e:	874a                	mv	a4,s2
    80206250:	86a2                	mv	a3,s0
    80206252:	6605                	lui	a2,0x1
    80206254:	85a6                	mv	a1,s1
    80206256:	854e                	mv	a0,s3
    80206258:	e8fff0ef          	jal	802060e6 <_ZN2VM8mappagesEPyyyyi>
    8020625c:	e531                	bnez	a0,802062a8 <_ZN2VM8uvmallocEPyyyi+0x8e>
        for (a = oldsz; a < newsz; a += PGSIZE)
    8020625e:	6785                	lui	a5,0x1
    80206260:	94be                	add	s1,s1,a5
    80206262:	0354f963          	bgeu	s1,s5,80206294 <_ZN2VM8uvmallocEPyyyi+0x7a>
            mem = (char *)PMM::alloc_page();
    80206266:	6fd000ef          	jal	80207162 <_ZN3PMM10alloc_pageEv>
            memset(mem, 0, PGSIZE);
    8020626a:	6605                	lui	a2,0x1
    8020626c:	4581                	li	a1,0
            mem = (char *)PMM::alloc_page();
    8020626e:	842a                	mv	s0,a0
            if (mem == nullptr)
    80206270:	fd69                	bnez	a0,8020624a <_ZN2VM8uvmallocEPyyyi+0x30>
        if (newsz >= oldsz)
    80206272:	009a7c63          	bgeu	s4,s1,8020628a <_ZN2VM8uvmallocEPyyyi+0x70>
        if (PGROUNDUP(newsz) < PGROUNDUP(oldsz))
    80206276:	6785                	lui	a5,0x1
    80206278:	17fd                	addi	a5,a5,-1 # fff <_start-0x801ff001>
    8020627a:	777d                	lui	a4,0xfffff
    8020627c:	00fa05b3          	add	a1,s4,a5
    80206280:	97a6                	add	a5,a5,s1
    80206282:	8df9                	and	a1,a1,a4
    80206284:	8ff9                	and	a5,a5,a4
    80206286:	04f5e963          	bltu	a1,a5,802062d8 <_ZN2VM8uvmallocEPyyyi+0xbe>
    8020628a:	7442                	ld	s0,48(sp)
                return 0;
    8020628c:	4501                	li	a0,0
    8020628e:	a029                	j	80206298 <_ZN2VM8uvmallocEPyyyi+0x7e>
            return oldsz;
    80206290:	852e                	mv	a0,a1
    }
    80206292:	8082                	ret
    80206294:	7442                	ld	s0,48(sp)
        return newsz;
    80206296:	8556                	mv	a0,s5
    }
    80206298:	70e2                	ld	ra,56(sp)
    8020629a:	74a2                	ld	s1,40(sp)
    8020629c:	7902                	ld	s2,32(sp)
    8020629e:	69e2                	ld	s3,24(sp)
    802062a0:	6a42                	ld	s4,16(sp)
    802062a2:	6aa2                	ld	s5,8(sp)
    802062a4:	6121                	addi	sp,sp,64
    802062a6:	8082                	ret
                PMM::free_page(mem);
    802062a8:	8522                	mv	a0,s0
    802062aa:	6db000ef          	jal	80207184 <_ZN3PMM9free_pageEPv>
        if (newsz >= oldsz)
    802062ae:	fc9a7ee3          	bgeu	s4,s1,8020628a <_ZN2VM8uvmallocEPyyyi+0x70>
        if (PGROUNDUP(newsz) < PGROUNDUP(oldsz))
    802062b2:	6785                	lui	a5,0x1
    802062b4:	17fd                	addi	a5,a5,-1 # fff <_start-0x801ff001>
    802062b6:	777d                	lui	a4,0xfffff
    802062b8:	00fa05b3          	add	a1,s4,a5
    802062bc:	94be                	add	s1,s1,a5
    802062be:	8df9                	and	a1,a1,a4
    802062c0:	8cf9                	and	s1,s1,a4
    802062c2:	fc95f4e3          	bgeu	a1,s1,8020628a <_ZN2VM8uvmallocEPyyyi+0x70>
            int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    802062c6:	40b48633          	sub	a2,s1,a1
    802062ca:	8231                	srli	a2,a2,0xc
    802062cc:	4685                	li	a3,1
    802062ce:	2601                	sext.w	a2,a2
    802062d0:	854e                	mv	a0,s3
    802062d2:	b01ff0ef          	jal	80205dd2 <_ZN2VM8uvmunmapEPyyyi.part.0>
    802062d6:	bf55                	j	8020628a <_ZN2VM8uvmallocEPyyyi+0x70>
    802062d8:	8f8d                	sub	a5,a5,a1
    802062da:	00c7d613          	srli	a2,a5,0xc
    802062de:	4685                	li	a3,1
    802062e0:	2601                	sext.w	a2,a2
    802062e2:	854e                	mv	a0,s3
    802062e4:	aefff0ef          	jal	80205dd2 <_ZN2VM8uvmunmapEPyyyi.part.0>
    802062e8:	b74d                	j	8020628a <_ZN2VM8uvmallocEPyyyi+0x70>

00000000802062ea <_ZN2VM10uvmdeallocEPyyy>:
        if (newsz >= oldsz)
    802062ea:	04b67263          	bgeu	a2,a1,8020632e <_ZN2VM10uvmdeallocEPyyy+0x44>
        if (PGROUNDUP(newsz) < PGROUNDUP(oldsz))
    802062ee:	6785                	lui	a5,0x1
    802062f0:	17fd                	addi	a5,a5,-1 # fff <_start-0x801ff001>
    {
    802062f2:	1141                	addi	sp,sp,-16
        if (PGROUNDUP(newsz) < PGROUNDUP(oldsz))
    802062f4:	76fd                	lui	a3,0xfffff
    802062f6:	00f60733          	add	a4,a2,a5
    802062fa:	97ae                	add	a5,a5,a1
    {
    802062fc:	e022                	sd	s0,0(sp)
    802062fe:	e406                	sd	ra,8(sp)
        if (PGROUNDUP(newsz) < PGROUNDUP(oldsz))
    80206300:	00d775b3          	and	a1,a4,a3
    80206304:	8ff5                	and	a5,a5,a3
    80206306:	8432                	mv	s0,a2
    80206308:	00f5e763          	bltu	a1,a5,80206316 <_ZN2VM10uvmdeallocEPyyy+0x2c>
    }
    8020630c:	60a2                	ld	ra,8(sp)
            return oldsz;
    8020630e:	8522                	mv	a0,s0
    }
    80206310:	6402                	ld	s0,0(sp)
    80206312:	0141                	addi	sp,sp,16
    80206314:	8082                	ret
            int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    80206316:	8f8d                	sub	a5,a5,a1
    80206318:	83b1                	srli	a5,a5,0xc
    8020631a:	4685                	li	a3,1
    8020631c:	0007861b          	sext.w	a2,a5
    80206320:	ab3ff0ef          	jal	80205dd2 <_ZN2VM8uvmunmapEPyyyi.part.0>
    }
    80206324:	60a2                	ld	ra,8(sp)
            return oldsz;
    80206326:	8522                	mv	a0,s0
    }
    80206328:	6402                	ld	s0,0(sp)
    8020632a:	0141                	addi	sp,sp,16
    8020632c:	8082                	ret
            return oldsz;
    8020632e:	852e                	mv	a0,a1
    }
    80206330:	8082                	ret

0000000080206332 <_ZN2VM8uvmunmapEPyyyi>:
        if ((va % PGSIZE) != 0)
    80206332:	03459793          	slli	a5,a1,0x34
    80206336:	e399                	bnez	a5,8020633c <_ZN2VM8uvmunmapEPyyyi+0xa>
    80206338:	a9bff06f          	j	80205dd2 <_ZN2VM8uvmunmapEPyyyi.part.0>
    }
    8020633c:	8082                	ret

000000008020633e <_ZN2VM7uvmfreeEPyy>:

    void uvmfree(uint64 *pagetable, uint64 sz)
    {
    8020633e:	7179                	addi	sp,sp,-48
    80206340:	e44e                	sd	s3,8(sp)
    80206342:	f406                	sd	ra,40(sp)
    80206344:	f022                	sd	s0,32(sp)
    80206346:	ec26                	sd	s1,24(sp)
    80206348:	e84a                	sd	s2,16(sp)
    8020634a:	89aa                	mv	s3,a0
        if (sz > 0)
    8020634c:	e1a1                	bnez	a1,8020638c <_ZN2VM7uvmfreeEPyy+0x4e>
    8020634e:	6485                	lui	s1,0x1
    80206350:	844e                	mv	s0,s3
    80206352:	94ce                	add	s1,s1,s3
            if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0)
    80206354:	4905                	li	s2,1
    80206356:	a021                	j	8020635e <_ZN2VM7uvmfreeEPyy+0x20>
        for (int i = 0; i < 512; i++)
    80206358:	0421                	addi	s0,s0,8
    8020635a:	02940063          	beq	s0,s1,8020637a <_ZN2VM7uvmfreeEPyy+0x3c>
            uint64 pte = pagetable[i];
    8020635e:	6008                	ld	a0,0(s0)
            if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0)
    80206360:	00f57793          	andi	a5,a0,15
    80206364:	ff279ae3          	bne	a5,s2,80206358 <_ZN2VM7uvmfreeEPyy+0x1a>
                uint64 *child = (uint64 *)PTE2PA(pte);
    80206368:	8129                	srli	a0,a0,0xa
                freewalk(child);
    8020636a:	0532                	slli	a0,a0,0xc
    8020636c:	b23ff0ef          	jal	80205e8e <_ZN2VML8freewalkEPy>
        for (int i = 0; i < 512; i++)
    80206370:	0421                	addi	s0,s0,8
                pagetable[i] = 0;
    80206372:	fe043c23          	sd	zero,-8(s0)
        for (int i = 0; i < 512; i++)
    80206376:	fe9414e3          	bne	s0,s1,8020635e <_ZN2VM7uvmfreeEPyy+0x20>
            uvmunmap(pagetable, 0, PGROUNDUP(sz) / PGSIZE, 1);
        freewalk(pagetable);
    }
    8020637a:	7402                	ld	s0,32(sp)
    8020637c:	70a2                	ld	ra,40(sp)
    8020637e:	64e2                	ld	s1,24(sp)
    80206380:	6942                	ld	s2,16(sp)
        PMM::free_page(pagetable);
    80206382:	854e                	mv	a0,s3
    }
    80206384:	69a2                	ld	s3,8(sp)
    80206386:	6145                	addi	sp,sp,48
        PMM::free_page(pagetable);
    80206388:	5fd0006f          	j	80207184 <_ZN3PMM9free_pageEPv>
            uvmunmap(pagetable, 0, PGROUNDUP(sz) / PGSIZE, 1);
    8020638c:	6785                	lui	a5,0x1
    8020638e:	17fd                	addi	a5,a5,-1 # fff <_start-0x801ff001>
    80206390:	00f58633          	add	a2,a1,a5
    80206394:	4685                	li	a3,1
    80206396:	8231                	srli	a2,a2,0xc
    80206398:	4581                	li	a1,0
    8020639a:	a39ff0ef          	jal	80205dd2 <_ZN2VM8uvmunmapEPyyyi.part.0>
        for (int i = 0; i < 512; i++)
    8020639e:	bf45                	j	8020634e <_ZN2VM7uvmfreeEPyy+0x10>

00000000802063a0 <_ZN2VM7uvmcopyEPyS0_y>:
    {
        uint64 *pte;
        uint64 pa, i;
        uint flags;

        for (i = 0; i < sz; i += PGSIZE)
    802063a0:	ce61                	beqz	a2,80206478 <_ZN2VM7uvmcopyEPyS0_y+0xd8>
    {
    802063a2:	715d                	addi	sp,sp,-80
    802063a4:	f052                	sd	s4,32(sp)

            if (flags & PTE_W)
            {
                flags &= ~PTE_W;
                flags |= PTE_COW;
                *pte = PA2PTE(pa) | flags;
    802063a6:	7a7d                	lui	s4,0xfffff
    {
    802063a8:	e0a2                	sd	s0,64(sp)
    802063aa:	fc26                	sd	s1,56(sp)
    802063ac:	f84a                	sd	s2,48(sp)
    802063ae:	f44e                	sd	s3,40(sp)
    802063b0:	ec56                	sd	s5,24(sp)
    802063b2:	e85a                	sd	s6,16(sp)
    802063b4:	e486                	sd	ra,72(sp)
    802063b6:	e45e                	sd	s7,8(sp)
    802063b8:	84b2                	mv	s1,a2
    802063ba:	892a                	mv	s2,a0
    802063bc:	89ae                	mv	s3,a1
        for (i = 0; i < sz; i += PGSIZE)
    802063be:	4401                	li	s0,0
            __atomic_add_fetch(&p->refcnt, 1, __ATOMIC_RELAXED);
    802063c0:	6b41                	lui	s6,0x10
    802063c2:	4a85                	li	s5,1
                *pte = PA2PTE(pa) | flags;
    802063c4:	002a5a13          	srli	s4,s4,0x2
            if ((pte = walk(oldpt, i, 0)) == nullptr)
    802063c8:	4601                	li	a2,0
    802063ca:	85a2                	mv	a1,s0
    802063cc:	854a                	mv	a0,s2
    802063ce:	96fff0ef          	jal	80205d3c <_ZN2VML4walkEPyyi>
    802063d2:	cd3d                	beqz	a0,80206450 <_ZN2VM7uvmcopyEPyS0_y+0xb0>
            if ((*pte & PTE_V) == 0)
    802063d4:	6118                	ld	a4,0(a0)
    802063d6:	00177793          	andi	a5,a4,1
            pa = PTE2PA(*pte);
    802063da:	00a75b93          	srli	s7,a4,0xa
            if (flags & PTE_W)
    802063de:	00477613          	andi	a2,a4,4
            if ((*pte & PTE_V) == 0)
    802063e2:	c7bd                	beqz	a5,80206450 <_ZN2VM7uvmcopyEPyS0_y+0xb0>
                *pte = PA2PTE(pa) | flags;
    802063e4:	014776b3          	and	a3,a4,s4
            flags = PTE_FLAGS(*pte);
    802063e8:	2701                	sext.w	a4,a4
                flags &= ~PTE_W;
    802063ea:	3fb77793          	andi	a5,a4,1019
                *pte = PA2PTE(pa) | flags;
    802063ee:	1007e593          	ori	a1,a5,256
    802063f2:	8ecd                	or	a3,a3,a1
            pa = PTE2PA(*pte);
    802063f4:	0bb2                	slli	s7,s7,0xc
            flags = PTE_FLAGS(*pte);
    802063f6:	3ff77713          	andi	a4,a4,1023
            if (flags & PTE_W)
    802063fa:	c601                	beqz	a2,80206402 <_ZN2VM7uvmcopyEPyS0_y+0x62>
                flags |= PTE_COW;
    802063fc:	1007e713          	ori	a4,a5,256
                *pte = PA2PTE(pa) | flags;
    80206400:	e114                	sd	a3,0(a0)
            }

            if (mappages(newpt, i, PGSIZE, pa, flags) != 0)
    80206402:	86de                	mv	a3,s7
    80206404:	6605                	lui	a2,0x1
    80206406:	85a2                	mv	a1,s0
    80206408:	854e                	mv	a0,s3
    8020640a:	cddff0ef          	jal	802060e6 <_ZN2VM8mappagesEPyyyyi>
    8020640e:	87aa                	mv	a5,a0
        struct Page *p = PMM::pa_to_page(pa);
    80206410:	855e                	mv	a0,s7
            if (mappages(newpt, i, PGSIZE, pa, flags) != 0)
    80206412:	e3ad                	bnez	a5,80206474 <_ZN2VM7uvmcopyEPyS0_y+0xd4>
        struct Page *p = PMM::pa_to_page(pa);
    80206414:	083000ef          	jal	80206c96 <_ZN3PMM10pa_to_pageEy>
            __atomic_add_fetch(&p->refcnt, 1, __ATOMIC_RELAXED);
    80206418:	00250713          	addi	a4,a0,2
    8020641c:	00377793          	andi	a5,a4,3
    80206420:	0037979b          	slliw	a5,a5,0x3
    80206424:	fffb069b          	addiw	a3,s6,-1 # ffff <_start-0x801f0001>
    80206428:	00f696bb          	sllw	a3,a3,a5
    8020642c:	9b71                	andi	a4,a4,-4
    8020642e:	fff6c613          	not	a2,a3
    80206432:	00fa97bb          	sllw	a5,s5,a5
        if (p)
    80206436:	cd09                	beqz	a0,80206450 <_ZN2VM7uvmcopyEPyS0_y+0xb0>
            __atomic_add_fetch(&p->refcnt, 1, __ATOMIC_RELAXED);
    80206438:	100725af          	lr.w	a1,(a4)
    8020643c:	00f58533          	add	a0,a1,a5
    80206440:	8d75                	and	a0,a0,a3
    80206442:	00c5f833          	and	a6,a1,a2
    80206446:	00a86833          	or	a6,a6,a0
    8020644a:	1907252f          	sc.w	a0,a6,(a4)
    8020644e:	f56d                	bnez	a0,80206438 <_ZN2VM7uvmcopyEPyS0_y+0x98>
        for (i = 0; i < sz; i += PGSIZE)
    80206450:	6785                	lui	a5,0x1
    80206452:	943e                	add	s0,s0,a5
    80206454:	f6946ae3          	bltu	s0,s1,802063c8 <_ZN2VM7uvmcopyEPyS0_y+0x28>
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80206458:	12000073          	sfence.vma

            page_ref_inc(pa);
        }

        sfence_vma();
        return 0;
    8020645c:	4501                	li	a0,0
    }
    8020645e:	60a6                	ld	ra,72(sp)
    80206460:	6406                	ld	s0,64(sp)
    80206462:	74e2                	ld	s1,56(sp)
    80206464:	7942                	ld	s2,48(sp)
    80206466:	79a2                	ld	s3,40(sp)
    80206468:	7a02                	ld	s4,32(sp)
    8020646a:	6ae2                	ld	s5,24(sp)
    8020646c:	6b42                	ld	s6,16(sp)
    8020646e:	6ba2                	ld	s7,8(sp)
    80206470:	6161                	addi	sp,sp,80
    80206472:	8082                	ret
                return -1;
    80206474:	557d                	li	a0,-1
    80206476:	b7e5                	j	8020645e <_ZN2VM7uvmcopyEPyS0_y+0xbe>
    80206478:	12000073          	sfence.vma
        return 0;
    8020647c:	4501                	li	a0,0
    }
    8020647e:	8082                	ret

0000000080206480 <_ZN2VM6copyinEPyPcyy>:
    int copyin(uint64 *pagetable, char *dst, uint64 srcva, uint64 len)
    {
        uint64 n, va0, pa0;
        uint64 *pte;

        while (len > 0)
    80206480:	c6d1                	beqz	a3,8020650c <_ZN2VM6copyinEPyPcyy+0x8c>
    {
    80206482:	715d                	addi	sp,sp,-80
    80206484:	e0a2                	sd	s0,64(sp)
    80206486:	f84a                	sd	s2,48(sp)
    80206488:	f44e                	sd	s3,40(sp)
    8020648a:	f052                	sd	s4,32(sp)
    8020648c:	ec56                	sd	s5,24(sp)
    8020648e:	e85a                	sd	s6,16(sp)
    80206490:	e45e                	sd	s7,8(sp)
    80206492:	e486                	sd	ra,72(sp)
    80206494:	fc26                	sd	s1,56(sp)
    80206496:	8bb6                	mv	s7,a3
    80206498:	8a2a                	mv	s4,a0
    8020649a:	892e                	mv	s2,a1
    8020649c:	8432                	mv	s0,a2
        {
            va0 = PGROUNDDOWN(srcva);
    8020649e:	7afd                	lui	s5,0xfffff
            pte = walk(pagetable, va0, 0);
            if (pte == nullptr || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0)
    802064a0:	4b45                	li	s6,17
                return -1;

            pa0 = PTE2PA(*pte);
            n = PGSIZE - (srcva - va0);
    802064a2:	6985                	lui	s3,0x1
    802064a4:	a03d                	j	802064d2 <_ZN2VM6copyinEPyPcyy+0x52>
            if (pte == nullptr || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0)
    802064a6:	639c                	ld	a5,0(a5)
            pa0 = PTE2PA(*pte);
    802064a8:	00a7d713          	srli	a4,a5,0xa
    802064ac:	0732                	slli	a4,a4,0xc
            if (pte == nullptr || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0)
    802064ae:	8bc5                	andi	a5,a5,17
            if (n > len)
                n = len;

            memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    802064b0:	95ba                	add	a1,a1,a4
            if (pte == nullptr || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0)
    802064b2:	03679f63          	bne	a5,s6,802064f0 <_ZN2VM6copyinEPyPcyy+0x70>
            if (n > len)
    802064b6:	008bf363          	bgeu	s7,s0,802064bc <_ZN2VM6copyinEPyPcyy+0x3c>
    802064ba:	845e                	mv	s0,s7
            memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    802064bc:	0004061b          	sext.w	a2,s0

            len -= n;
    802064c0:	408b8bb3          	sub	s7,s7,s0
            dst += n;
    802064c4:	9922                	add	s2,s2,s0
            memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    802064c6:	9affe0ef          	jal	80204e74 <_Z7memmovePvPKvj>
            srcva = va0 + PGSIZE;
    802064ca:	01348433          	add	s0,s1,s3
        while (len > 0)
    802064ce:	020b8d63          	beqz	s7,80206508 <_ZN2VM6copyinEPyPcyy+0x88>
            va0 = PGROUNDDOWN(srcva);
    802064d2:	015474b3          	and	s1,s0,s5
            pte = walk(pagetable, va0, 0);
    802064d6:	85a6                	mv	a1,s1
    802064d8:	4601                	li	a2,0
    802064da:	8552                	mv	a0,s4
    802064dc:	861ff0ef          	jal	80205d3c <_ZN2VML4walkEPyyi>
    802064e0:	87aa                	mv	a5,a0
            memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    802064e2:	409405b3          	sub	a1,s0,s1
            n = PGSIZE - (srcva - va0);
    802064e6:	40848433          	sub	s0,s1,s0
            memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    802064ea:	854a                	mv	a0,s2
            n = PGSIZE - (srcva - va0);
    802064ec:	944e                	add	s0,s0,s3
            if (pte == nullptr || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0)
    802064ee:	ffc5                	bnez	a5,802064a6 <_ZN2VM6copyinEPyPcyy+0x26>
                return -1;
    802064f0:	557d                	li	a0,-1
        }
        return 0;
    }
    802064f2:	60a6                	ld	ra,72(sp)
    802064f4:	6406                	ld	s0,64(sp)
    802064f6:	74e2                	ld	s1,56(sp)
    802064f8:	7942                	ld	s2,48(sp)
    802064fa:	79a2                	ld	s3,40(sp)
    802064fc:	7a02                	ld	s4,32(sp)
    802064fe:	6ae2                	ld	s5,24(sp)
    80206500:	6b42                	ld	s6,16(sp)
    80206502:	6ba2                	ld	s7,8(sp)
    80206504:	6161                	addi	sp,sp,80
    80206506:	8082                	ret
        return 0;
    80206508:	4501                	li	a0,0
    8020650a:	b7e5                	j	802064f2 <_ZN2VM6copyinEPyPcyy+0x72>
    8020650c:	4501                	li	a0,0
    }
    8020650e:	8082                	ret

0000000080206510 <_ZN2VM9copyinstrEPyPcyy>:
        uint64 n, va0, pa0;
        uint64 *pte;
        int got_null = 0;
        uint64 len = 0;

        while (len < max)
    80206510:	cec5                	beqz	a3,802065c8 <_ZN2VM9copyinstrEPyPcyy+0xb8>
    {
    80206512:	715d                	addi	sp,sp,-80
    80206514:	e0a2                	sd	s0,64(sp)
    80206516:	fc26                	sd	s1,56(sp)
    80206518:	f84a                	sd	s2,48(sp)
    8020651a:	f44e                	sd	s3,40(sp)
    8020651c:	f052                	sd	s4,32(sp)
    8020651e:	e85a                	sd	s6,16(sp)
    80206520:	e45e                	sd	s7,8(sp)
    80206522:	e062                	sd	s8,0(sp)
    80206524:	e486                	sd	ra,72(sp)
    80206526:	ec56                	sd	s5,24(sp)
    80206528:	8c36                	mv	s8,a3
    8020652a:	842a                	mv	s0,a0
    8020652c:	8b2e                	mv	s6,a1
    8020652e:	8a32                	mv	s4,a2
    80206530:	4b81                	li	s7,0
    80206532:	74fd                	lui	s1,0xfffff
    80206534:	4945                	li	s2,17
    80206536:	6985                	lui	s3,0x1
        {
            va0 = PGROUNDDOWN(srcva);
    80206538:	009a7ab3          	and	s5,s4,s1
            pte = walk(pagetable, va0, 0);
    8020653c:	4601                	li	a2,0
    8020653e:	85d6                	mv	a1,s5
    80206540:	8522                	mv	a0,s0
    80206542:	ffaff0ef          	jal	80205d3c <_ZN2VML4walkEPyyi>

            if (pte == nullptr || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0)
    80206546:	cd3d                	beqz	a0,802065c4 <_ZN2VM9copyinstrEPyPcyy+0xb4>
    80206548:	611c                	ld	a5,0(a0)
    8020654a:	0117f713          	andi	a4,a5,17
    8020654e:	07271b63          	bne	a4,s2,802065c4 <_ZN2VM9copyinstrEPyPcyy+0xb4>
                return -1;

            pa0 = PTE2PA(*pte);

            n = PGSIZE - (srcva - va0);
    80206552:	414a88b3          	sub	a7,s5,s4
            if (n > max - len)
    80206556:	417c0733          	sub	a4,s8,s7
    8020655a:	98ce                	add	a7,a7,s3
    8020655c:	01177363          	bgeu	a4,a7,80206562 <_ZN2VM9copyinstrEPyPcyy+0x52>
    80206560:	88ba                	mv	a7,a4
            pa0 = PTE2PA(*pte);
    80206562:	83a9                	srli	a5,a5,0xa
    80206564:	07b2                	slli	a5,a5,0xc
                n = max - len;

            char *p = (char *)(pa0 + (srcva - va0));
    80206566:	415a0ab3          	sub	s5,s4,s5
    8020656a:	01578833          	add	a6,a5,s5
            while (n > 0)
    8020656e:	04088963          	beqz	a7,802065c0 <_ZN2VM9copyinstrEPyPcyy+0xb0>
    80206572:	87da                	mv	a5,s6
    80206574:	41680833          	sub	a6,a6,s6
    80206578:	98da                	add	a7,a7,s6
    8020657a:	a031                	j	80206586 <_ZN2VM9copyinstrEPyPcyy+0x76>
                {
                    *dst = '\0';
                    got_null = 1;
                    break;
                }
                *dst = *p;
    8020657c:	00e78023          	sb	a4,0(a5) # 1000 <_start-0x801ff000>
                n--;
                srcva++;
                dst++;
    80206580:	0785                	addi	a5,a5,1
            while (n > 0)
    80206582:	03178763          	beq	a5,a7,802065b0 <_ZN2VM9copyinstrEPyPcyy+0xa0>
                if (*p == '\0')
    80206586:	01078733          	add	a4,a5,a6
    8020658a:	00074703          	lbu	a4,0(a4) # fffffffffffff000 <kernel_end+0xffffffff7fdd8000>
    8020658e:	853e                	mv	a0,a5
    80206590:	f775                	bnez	a4,8020657c <_ZN2VM9copyinstrEPyPcyy+0x6c>
                    *dst = '\0';
    80206592:	00078023          	sb	zero,0(a5)
    80206596:	4501                	li	a0,0

        if (got_null)
            return 0;

        return -1;
    }
    80206598:	60a6                	ld	ra,72(sp)
    8020659a:	6406                	ld	s0,64(sp)
    8020659c:	74e2                	ld	s1,56(sp)
    8020659e:	7942                	ld	s2,48(sp)
    802065a0:	79a2                	ld	s3,40(sp)
    802065a2:	7a02                	ld	s4,32(sp)
    802065a4:	6ae2                	ld	s5,24(sp)
    802065a6:	6b42                	ld	s6,16(sp)
    802065a8:	6ba2                	ld	s7,8(sp)
    802065aa:	6c02                	ld	s8,0(sp)
    802065ac:	6161                	addi	sp,sp,80
    802065ae:	8082                	ret
    802065b0:	0a05                	addi	s4,s4,1 # fffffffffffff001 <kernel_end+0xffffffff7fdd8001>
    802065b2:	416a0a33          	sub	s4,s4,s6
    802065b6:	416b8bb3          	sub	s7,s7,s6
                srcva++;
    802065ba:	9a2a                	add	s4,s4,a0
                len++;
    802065bc:	9bbe                	add	s7,s7,a5
    802065be:	8b3e                	mv	s6,a5
        while (len < max)
    802065c0:	f78bece3          	bltu	s7,s8,80206538 <_ZN2VM9copyinstrEPyPcyy+0x28>
                return -1;
    802065c4:	557d                	li	a0,-1
    802065c6:	bfc9                	j	80206598 <_ZN2VM9copyinstrEPyPcyy+0x88>
                    *dst = '\0';
    802065c8:	557d                	li	a0,-1
    }
    802065ca:	8082                	ret

00000000802065cc <_ZN2VM16handle_cow_faultEPyy>:

    int handle_cow_fault(uint64 *pagetable, uint64 va)
    {
        if (va >= MAXVA)
    802065cc:	57fd                	li	a5,-1
    802065ce:	83e9                	srli	a5,a5,0x1a
    802065d0:	0cb7e763          	bltu	a5,a1,8020669e <_ZN2VM16handle_cow_faultEPyy+0xd2>
    {
    802065d4:	7179                	addi	sp,sp,-48
            return -1;

        uint64 *pte = walk(pagetable, va, 0);
    802065d6:	4601                	li	a2,0
    {
    802065d8:	e44e                	sd	s3,8(sp)
    802065da:	f406                	sd	ra,40(sp)
        uint64 *pte = walk(pagetable, va, 0);
    802065dc:	f60ff0ef          	jal	80205d3c <_ZN2VML4walkEPyyi>
    802065e0:	89aa                	mv	s3,a0
        if (pte == nullptr || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0)
    802065e2:	c55d                	beqz	a0,80206690 <_ZN2VM16handle_cow_faultEPyy+0xc4>
    802065e4:	ec26                	sd	s1,24(sp)
    802065e6:	6104                	ld	s1,0(a0)
    802065e8:	47c5                	li	a5,17
    802065ea:	0114f713          	andi	a4,s1,17
    802065ee:	0af71063          	bne	a4,a5,8020668e <_ZN2VM16handle_cow_faultEPyy+0xc2>
            return -1;

        if ((*pte & PTE_COW) == 0)
    802065f2:	1004f793          	andi	a5,s1,256
    802065f6:	cfc1                	beqz	a5,8020668e <_ZN2VM16handle_cow_faultEPyy+0xc2>
    802065f8:	f022                	sd	s0,32(sp)
    802065fa:	e84a                	sd	s2,16(sp)
            return -1;

        uint64 pa = PTE2PA(*pte);
    802065fc:	00a4d913          	srli	s2,s1,0xa
        uint64 flags = PTE_FLAGS(*pte);

        char *mem = (char *)PMM::alloc_page();
    80206600:	363000ef          	jal	80207162 <_ZN3PMM10alloc_pageEv>
        uint64 pa = PTE2PA(*pte);
    80206604:	0932                	slli	s2,s2,0xc
        char *mem = (char *)PMM::alloc_page();
    80206606:	842a                	mv	s0,a0
        if (mem == nullptr)
    80206608:	c551                	beqz	a0,80206694 <_ZN2VM16handle_cow_faultEPyy+0xc8>
            return -1;

        memmove(mem, (char *)pa, PGSIZE);

        uint64 new_flags = (flags | PTE_W) & ~PTE_COW;
        *pte = PA2PTE((uint64)mem) | new_flags | PTE_V;
    8020660a:	8031                	srli	s0,s0,0xc
    8020660c:	042a                	slli	s0,s0,0xa
        uint64 new_flags = (flags | PTE_W) & ~PTE_COW;
    8020660e:	2fb4f493          	andi	s1,s1,763
        memmove(mem, (char *)pa, PGSIZE);
    80206612:	6605                	lui	a2,0x1
    80206614:	85ca                	mv	a1,s2
        *pte = PA2PTE((uint64)mem) | new_flags | PTE_V;
    80206616:	8c45                	or	s0,s0,s1
        memmove(mem, (char *)pa, PGSIZE);
    80206618:	85dfe0ef          	jal	80204e74 <_Z7memmovePvPKvj>
        *pte = PA2PTE((uint64)mem) | new_flags | PTE_V;
    8020661c:	00546413          	ori	s0,s0,5
    80206620:	0089b023          	sd	s0,0(s3) # 1000 <_start-0x801ff000>
        struct Page *p = PMM::pa_to_page(pa);
    80206624:	854a                	mv	a0,s2
    80206626:	670000ef          	jal	80206c96 <_ZN3PMM10pa_to_pageEy>
        if (p)
    8020662a:	c521                	beqz	a0,80206672 <_ZN2VM16handle_cow_faultEPyy+0xa6>
            if (__atomic_sub_fetch(&p->refcnt, 1, __ATOMIC_RELEASE) == 0)
    8020662c:	0509                	addi	a0,a0,2
    8020662e:	00357693          	andi	a3,a0,3
    80206632:	6741                	lui	a4,0x10
    80206634:	0036969b          	slliw	a3,a3,0x3
    80206638:	377d                	addiw	a4,a4,-1 # ffff <_start-0x801f0001>
    8020663a:	00d7173b          	sllw	a4,a4,a3
    8020663e:	567d                	li	a2,-1
    80206640:	9971                	andi	a0,a0,-4
    80206642:	fff74593          	not	a1,a4
    80206646:	00d6163b          	sllw	a2,a2,a3
    8020664a:	100527af          	lr.w	a5,(a0)
    8020664e:	00c78833          	add	a6,a5,a2
    80206652:	00e87833          	and	a6,a6,a4
    80206656:	00b7f8b3          	and	a7,a5,a1
    8020665a:	0108e8b3          	or	a7,a7,a6
    8020665e:	1b15282f          	sc.w.rl	a6,a7,(a0)
    80206662:	fe0814e3          	bnez	a6,8020664a <_ZN2VM16handle_cow_faultEPyy+0x7e>
    80206666:	40d7d7bb          	sraw	a5,a5,a3
    8020666a:	37fd                	addiw	a5,a5,-1
    8020666c:	17c2                	slli	a5,a5,0x30
    8020666e:	93c1                	srli	a5,a5,0x30
    80206670:	cb99                	beqz	a5,80206686 <_ZN2VM16handle_cow_faultEPyy+0xba>
    80206672:	12000073          	sfence.vma
        {
            PMM::free_page((void *)pa);
        }

        sfence_vma();
        return 0;
    80206676:	7402                	ld	s0,32(sp)
    80206678:	64e2                	ld	s1,24(sp)
    8020667a:	6942                	ld	s2,16(sp)
    8020667c:	4501                	li	a0,0
    }
    8020667e:	70a2                	ld	ra,40(sp)
    80206680:	69a2                	ld	s3,8(sp)
    80206682:	6145                	addi	sp,sp,48
    80206684:	8082                	ret
            PMM::free_page((void *)pa);
    80206686:	854a                	mv	a0,s2
    80206688:	2fd000ef          	jal	80207184 <_ZN3PMM9free_pageEPv>
    8020668c:	b7dd                	j	80206672 <_ZN2VM16handle_cow_faultEPyy+0xa6>
    8020668e:	64e2                	ld	s1,24(sp)
            return -1;
    80206690:	557d                	li	a0,-1
    80206692:	b7f5                	j	8020667e <_ZN2VM16handle_cow_faultEPyy+0xb2>
    80206694:	7402                	ld	s0,32(sp)
    80206696:	64e2                	ld	s1,24(sp)
    80206698:	6942                	ld	s2,16(sp)
    8020669a:	557d                	li	a0,-1
    8020669c:	b7cd                	j	8020667e <_ZN2VM16handle_cow_faultEPyy+0xb2>
    8020669e:	557d                	li	a0,-1
    }
    802066a0:	8082                	ret

00000000802066a2 <_ZN2VM7copyoutEPyyPcy>:
        while (len > 0)
    802066a2:	cadd                	beqz	a3,80206758 <_ZN2VM7copyoutEPyyPcy+0xb6>
    {
    802066a4:	715d                	addi	sp,sp,-80
    802066a6:	e0a2                	sd	s0,64(sp)
    802066a8:	f84a                	sd	s2,48(sp)
    802066aa:	f44e                	sd	s3,40(sp)
    802066ac:	f052                	sd	s4,32(sp)
    802066ae:	ec56                	sd	s5,24(sp)
    802066b0:	e85a                	sd	s6,16(sp)
    802066b2:	e45e                	sd	s7,8(sp)
    802066b4:	e486                	sd	ra,72(sp)
    802066b6:	fc26                	sd	s1,56(sp)
    802066b8:	8936                	mv	s2,a3
    802066ba:	8a2a                	mv	s4,a0
    802066bc:	842e                	mv	s0,a1
    802066be:	89b2                	mv	s3,a2
            va0 = PGROUNDDOWN(dstva);
    802066c0:	7bfd                	lui	s7,0xfffff
            if (pte == nullptr || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0)
    802066c2:	4b45                	li	s6,17
            n = PGSIZE - (dstva - va0);
    802066c4:	6a85                	lui	s5,0x1
    802066c6:	a085                	j	80206726 <_ZN2VM7copyoutEPyyPcy+0x84>
            if (pte == nullptr || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0)
    802066c8:	639c                	ld	a5,0(a5)
    802066ca:	0117f713          	andi	a4,a5,17
            if (*pte & PTE_COW)
    802066ce:	1007f693          	andi	a3,a5,256
            if (pte == nullptr || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0)
    802066d2:	07671563          	bne	a4,s6,8020673c <_ZN2VM7copyoutEPyyPcy+0x9a>
            if (*pte & PTE_COW)
    802066d6:	c28d                	beqz	a3,802066f8 <_ZN2VM7copyoutEPyyPcy+0x56>
                if (handle_cow_fault(pagetable, va0) < 0)
    802066d8:	ef5ff0ef          	jal	802065cc <_ZN2VM16handle_cow_faultEPyy>
    802066dc:	87aa                	mv	a5,a0
                pte = walk(pagetable, va0, 0);
    802066de:	4601                	li	a2,0
    802066e0:	85a6                	mv	a1,s1
    802066e2:	8552                	mv	a0,s4
                if (handle_cow_fault(pagetable, va0) < 0)
    802066e4:	0407cc63          	bltz	a5,8020673c <_ZN2VM7copyoutEPyyPcy+0x9a>
                pte = walk(pagetable, va0, 0);
    802066e8:	e54ff0ef          	jal	80205d3c <_ZN2VML4walkEPyyi>
                if (pte == nullptr || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0)
    802066ec:	c921                	beqz	a0,8020673c <_ZN2VM7copyoutEPyyPcy+0x9a>
    802066ee:	611c                	ld	a5,0(a0)
    802066f0:	0117f713          	andi	a4,a5,17
    802066f4:	05671463          	bne	a4,s6,8020673c <_ZN2VM7copyoutEPyyPcy+0x9a>
            memmove((void *)(pa0 + (dstva - va0)), src, n);
    802066f8:	40940533          	sub	a0,s0,s1
            pa0 = PTE2PA(*pte);
    802066fc:	83a9                	srli	a5,a5,0xa
            n = PGSIZE - (dstva - va0);
    802066fe:	40848433          	sub	s0,s1,s0
            pa0 = PTE2PA(*pte);
    80206702:	07b2                	slli	a5,a5,0xc
            n = PGSIZE - (dstva - va0);
    80206704:	9456                	add	s0,s0,s5
            memmove((void *)(pa0 + (dstva - va0)), src, n);
    80206706:	85ce                	mv	a1,s3
    80206708:	953e                	add	a0,a0,a5
            if (n > len)
    8020670a:	00897363          	bgeu	s2,s0,80206710 <_ZN2VM7copyoutEPyyPcy+0x6e>
    8020670e:	844a                	mv	s0,s2
            memmove((void *)(pa0 + (dstva - va0)), src, n);
    80206710:	0004061b          	sext.w	a2,s0
            len -= n;
    80206714:	40890933          	sub	s2,s2,s0
            src += n;
    80206718:	99a2                	add	s3,s3,s0
            memmove((void *)(pa0 + (dstva - va0)), src, n);
    8020671a:	f5afe0ef          	jal	80204e74 <_Z7memmovePvPKvj>
            dstva = va0 + PGSIZE;
    8020671e:	01548433          	add	s0,s1,s5
        while (len > 0)
    80206722:	02090963          	beqz	s2,80206754 <_ZN2VM7copyoutEPyyPcy+0xb2>
            va0 = PGROUNDDOWN(dstva);
    80206726:	017474b3          	and	s1,s0,s7
            pte = walk(pagetable, va0, 0);
    8020672a:	85a6                	mv	a1,s1
    8020672c:	4601                	li	a2,0
    8020672e:	8552                	mv	a0,s4
    80206730:	e0cff0ef          	jal	80205d3c <_ZN2VML4walkEPyyi>
    80206734:	87aa                	mv	a5,a0
                if (handle_cow_fault(pagetable, va0) < 0)
    80206736:	85a6                	mv	a1,s1
    80206738:	8552                	mv	a0,s4
            if (pte == nullptr || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0)
    8020673a:	f7d9                	bnez	a5,802066c8 <_ZN2VM7copyoutEPyyPcy+0x26>
                return -1;
    8020673c:	557d                	li	a0,-1
    }
    8020673e:	60a6                	ld	ra,72(sp)
    80206740:	6406                	ld	s0,64(sp)
    80206742:	74e2                	ld	s1,56(sp)
    80206744:	7942                	ld	s2,48(sp)
    80206746:	79a2                	ld	s3,40(sp)
    80206748:	7a02                	ld	s4,32(sp)
    8020674a:	6ae2                	ld	s5,24(sp)
    8020674c:	6b42                	ld	s6,16(sp)
    8020674e:	6ba2                	ld	s7,8(sp)
    80206750:	6161                	addi	sp,sp,80
    80206752:	8082                	ret
        return 0;
    80206754:	4501                	li	a0,0
    80206756:	b7e5                	j	8020673e <_ZN2VM7copyoutEPyyPcy+0x9c>
    80206758:	4501                	li	a0,0
    }
    8020675a:	8082                	ret

000000008020675c <_ZN2VM7kvminitEv>:
                ;
        }
    }

    void kvminit()
    {
    8020675c:	7179                	addi	sp,sp,-48
    8020675e:	f022                	sd	s0,32(sp)
    80206760:	ec26                	sd	s1,24(sp)
    80206762:	e84a                	sd	s2,16(sp)
    80206764:	e44e                	sd	s3,8(sp)
    80206766:	e052                	sd	s4,0(sp)
    80206768:	f406                	sd	ra,40(sp)
        kernel_pagetable = uvmcreate();
    8020676a:	00017497          	auipc	s1,0x17
    8020676e:	4ae48493          	addi	s1,s1,1198 # 8021dc18 <_ZN2VM16kernel_pagetableE>
    80206772:	9edff0ef          	jal	8020615e <_ZN2VM9uvmcreateEv>
    80206776:	892a                	mv	s2,a0
    80206778:	e088                	sd	a0,0(s1)
    8020677a:	10000437          	lui	s0,0x10000
            if (a == last)
    8020677e:	1000f9b7          	lui	s3,0x1000f
            a += PGSIZE;
    80206782:	6a05                	lui	s4,0x1
    80206784:	a801                	j	80206794 <_ZN2VM7kvminitEv+0x38>
            if (*pte & PTE_V)
    80206786:	6118                	ld	a4,0(a0)
    80206788:	8b05                	andi	a4,a4,1
    8020678a:	e305                	bnez	a4,802067aa <_ZN2VM7kvminitEv+0x4e>
            *pte = PA2PTE(pa) | perm | PTE_V;
    8020678c:	e11c                	sd	a5,0(a0)
            if (a == last)
    8020678e:	03340563          	beq	s0,s3,802067b8 <_ZN2VM7kvminitEv+0x5c>
            a += PGSIZE;
    80206792:	9452                	add	s0,s0,s4
            if ((pte = walk(pagetable, a, 1)) == nullptr)
    80206794:	4605                	li	a2,1
    80206796:	85a2                	mv	a1,s0
    80206798:	854a                	mv	a0,s2
    8020679a:	da2ff0ef          	jal	80205d3c <_ZN2VML4walkEPyyi>
            *pte = PA2PTE(pa) | perm | PTE_V;
    8020679e:	00c45793          	srli	a5,s0,0xc
    802067a2:	07aa                	slli	a5,a5,0xa
    802067a4:	0077e793          	ori	a5,a5,7
            if ((pte = walk(pagetable, a, 1)) == nullptr)
    802067a8:	fd79                	bnez	a0,80206786 <_ZN2VM7kvminitEv+0x2a>
            Drivers::uart_puts("kvmmap: failed\n");
    802067aa:	0000b517          	auipc	a0,0xb
    802067ae:	52e50513          	addi	a0,a0,1326 # 80211cd8 <initcode_end+0x590>
    802067b2:	5b8020ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            while (1)
    802067b6:	a001                	j	802067b6 <_ZN2VM7kvminitEv+0x5a>
        if (mappages(kernel_pagetable, va, sz, pa, perm) != 0)
    802067b8:	0004b903          	ld	s2,0(s1)
    802067bc:	0c000437          	lui	s0,0xc000
            if (a == last)
    802067c0:	0c3ff9b7          	lui	s3,0xc3ff
            a += PGSIZE;
    802067c4:	6a05                	lui	s4,0x1
    802067c6:	a801                	j	802067d6 <_ZN2VM7kvminitEv+0x7a>
            if (*pte & PTE_V)
    802067c8:	6118                	ld	a4,0(a0)
    802067ca:	8b05                	andi	a4,a4,1
    802067cc:	e305                	bnez	a4,802067ec <_ZN2VM7kvminitEv+0x90>
            *pte = PA2PTE(pa) | perm | PTE_V;
    802067ce:	e11c                	sd	a5,0(a0)
            if (a == last)
    802067d0:	03340563          	beq	s0,s3,802067fa <_ZN2VM7kvminitEv+0x9e>
            a += PGSIZE;
    802067d4:	9452                	add	s0,s0,s4
            if ((pte = walk(pagetable, a, 1)) == nullptr)
    802067d6:	4605                	li	a2,1
    802067d8:	85a2                	mv	a1,s0
    802067da:	854a                	mv	a0,s2
    802067dc:	d60ff0ef          	jal	80205d3c <_ZN2VML4walkEPyyi>
            *pte = PA2PTE(pa) | perm | PTE_V;
    802067e0:	00c45793          	srli	a5,s0,0xc
    802067e4:	07aa                	slli	a5,a5,0xa
    802067e6:	0077e793          	ori	a5,a5,7
            if ((pte = walk(pagetable, a, 1)) == nullptr)
    802067ea:	fd79                	bnez	a0,802067c8 <_ZN2VM7kvminitEv+0x6c>
            Drivers::uart_puts("kvmmap: failed\n");
    802067ec:	0000b517          	auipc	a0,0xb
    802067f0:	4ec50513          	addi	a0,a0,1260 # 80211cd8 <initcode_end+0x590>
    802067f4:	576020ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            while (1)
    802067f8:	a001                	j	802067f8 <_ZN2VM7kvminitEv+0x9c>
        if (mappages(kernel_pagetable, va, sz, pa, perm) != 0)
    802067fa:	0004b903          	ld	s2,0(s1)
    802067fe:	02000437          	lui	s0,0x2000
            if (a == last)
    80206802:	0200f9b7          	lui	s3,0x200f
            a += PGSIZE;
    80206806:	6a05                	lui	s4,0x1
    80206808:	a801                	j	80206818 <_ZN2VM7kvminitEv+0xbc>
            if (*pte & PTE_V)
    8020680a:	6118                	ld	a4,0(a0)
    8020680c:	8b05                	andi	a4,a4,1
    8020680e:	e305                	bnez	a4,8020682e <_ZN2VM7kvminitEv+0xd2>
            *pte = PA2PTE(pa) | perm | PTE_V;
    80206810:	e11c                	sd	a5,0(a0)
            if (a == last)
    80206812:	03340563          	beq	s0,s3,8020683c <_ZN2VM7kvminitEv+0xe0>
            a += PGSIZE;
    80206816:	9452                	add	s0,s0,s4
            if ((pte = walk(pagetable, a, 1)) == nullptr)
    80206818:	4605                	li	a2,1
    8020681a:	85a2                	mv	a1,s0
    8020681c:	854a                	mv	a0,s2
    8020681e:	d1eff0ef          	jal	80205d3c <_ZN2VML4walkEPyyi>
            *pte = PA2PTE(pa) | perm | PTE_V;
    80206822:	00c45793          	srli	a5,s0,0xc
    80206826:	07aa                	slli	a5,a5,0xa
    80206828:	0077e793          	ori	a5,a5,7
            if ((pte = walk(pagetable, a, 1)) == nullptr)
    8020682c:	fd79                	bnez	a0,8020680a <_ZN2VM7kvminitEv+0xae>
            Drivers::uart_puts("kvmmap: failed\n");
    8020682e:	0000b517          	auipc	a0,0xb
    80206832:	4aa50513          	addi	a0,a0,1194 # 80211cd8 <initcode_end+0x590>
    80206836:	534020ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            while (1)
    8020683a:	a001                	j	8020683a <_ZN2VM7kvminitEv+0xde>
            if (a == last)
    8020683c:	00088937          	lui	s2,0x88
        if (mappages(kernel_pagetable, va, sz, pa, perm) != 0)
    80206840:	4405                	li	s0,1
            if (a == last)
    80206842:	197d                	addi	s2,s2,-1 # 87fff <_start-0x80178001>
        if (mappages(kernel_pagetable, va, sz, pa, perm) != 0)
    80206844:	6084                	ld	s1,0(s1)
    80206846:	047e                	slli	s0,s0,0x1f
            if (a == last)
    80206848:	0932                	slli	s2,s2,0xc
            a += PGSIZE;
    8020684a:	6985                	lui	s3,0x1
    8020684c:	a801                	j	8020685c <_ZN2VM7kvminitEv+0x100>
            if (*pte & PTE_V)
    8020684e:	6118                	ld	a4,0(a0)
    80206850:	8b05                	andi	a4,a4,1
    80206852:	e305                	bnez	a4,80206872 <_ZN2VM7kvminitEv+0x116>
            *pte = PA2PTE(pa) | perm | PTE_V;
    80206854:	e11c                	sd	a5,0(a0)
            if (a == last)
    80206856:	03240563          	beq	s0,s2,80206880 <_ZN2VM7kvminitEv+0x124>
            a += PGSIZE;
    8020685a:	944e                	add	s0,s0,s3
            if ((pte = walk(pagetable, a, 1)) == nullptr)
    8020685c:	4605                	li	a2,1
    8020685e:	85a2                	mv	a1,s0
    80206860:	8526                	mv	a0,s1
    80206862:	cdaff0ef          	jal	80205d3c <_ZN2VML4walkEPyyi>
            *pte = PA2PTE(pa) | perm | PTE_V;
    80206866:	00c45793          	srli	a5,s0,0xc
    8020686a:	07aa                	slli	a5,a5,0xa
    8020686c:	00f7e793          	ori	a5,a5,15
            if ((pte = walk(pagetable, a, 1)) == nullptr)
    80206870:	fd79                	bnez	a0,8020684e <_ZN2VM7kvminitEv+0xf2>
            Drivers::uart_puts("kvmmap: failed\n");
    80206872:	0000b517          	auipc	a0,0xb
    80206876:	46650513          	addi	a0,a0,1126 # 80211cd8 <initcode_end+0x590>
    8020687a:	4f0020ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            while (1)
    8020687e:	a001                	j	8020687e <_ZN2VM7kvminitEv+0x122>

        kvmmap(0x10000000, 0x10000000, 0x10000, PTE_R | PTE_W);
        kvmmap(0x0c000000, 0x0c000000, 0x400000, PTE_R | PTE_W);
        kvmmap(0x02000000, 0x02000000, 0x10000, PTE_R | PTE_W); // CLINT
        kvmmap(KERNBASE, KERNBASE, PHYSTOP - KERNBASE, PTE_R | PTE_W | PTE_X);
    }
    80206880:	70a2                	ld	ra,40(sp)
    80206882:	7402                	ld	s0,32(sp)
    80206884:	64e2                	ld	s1,24(sp)
    80206886:	6942                	ld	s2,16(sp)
    80206888:	69a2                	ld	s3,8(sp)
    8020688a:	6a02                	ld	s4,0(sp)
    8020688c:	6145                	addi	sp,sp,48
    8020688e:	8082                	ret

0000000080206890 <_ZN2VM11kvminithartEv>:

    void kvminithart()
    {
        w_satp(MAKE_SATP(kernel_pagetable));
    80206890:	00017797          	auipc	a5,0x17
    80206894:	3887b783          	ld	a5,904(a5) # 8021dc18 <_ZN2VM16kernel_pagetableE>
    80206898:	577d                	li	a4,-1
    8020689a:	177e                	slli	a4,a4,0x3f
    8020689c:	83b1                	srli	a5,a5,0xc
    8020689e:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    802068a0:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero");
    802068a4:	12000073          	sfence.vma
        sfence_vma();
        Drivers::uart_puts("[Boot] MMU ENABLED! Using virtual addresses.\n");
    802068a8:	0000b517          	auipc	a0,0xb
    802068ac:	44050513          	addi	a0,a0,1088 # 80211ce8 <initcode_end+0x5a0>
    802068b0:	4ba0206f          	j	80208d6a <_ZN7Drivers9uart_putsEPKc>

00000000802068b4 <_ZN2VM8walkaddrEPyy>:
    uint64 walkaddr(uint64 *pagetable, uint64 va)
    {
        uint64 *pte;
        uint64 pa;

        if (va >= MAXVA)
    802068b4:	57fd                	li	a5,-1
    802068b6:	83e9                	srli	a5,a5,0x1a
    802068b8:	00b7f463          	bgeu	a5,a1,802068c0 <_ZN2VM8walkaddrEPyy+0xc>
            return 0;
    802068bc:	4501                	li	a0,0
        if (pte == 0 || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0)
            return 0;

        pa = PTE2PA(*pte);
        return pa;
    }
    802068be:	8082                	ret
    {
    802068c0:	1141                	addi	sp,sp,-16
        pte = walk(pagetable, va, 0);
    802068c2:	4601                	li	a2,0
    {
    802068c4:	e406                	sd	ra,8(sp)
        pte = walk(pagetable, va, 0);
    802068c6:	c76ff0ef          	jal	80205d3c <_ZN2VML4walkEPyyi>
        if (pte == 0 || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0)
    802068ca:	cd01                	beqz	a0,802068e2 <_ZN2VM8walkaddrEPyy+0x2e>
    802068cc:	6108                	ld	a0,0(a0)
    802068ce:	47c5                	li	a5,17
    802068d0:	01157713          	andi	a4,a0,17
    802068d4:	00f71763          	bne	a4,a5,802068e2 <_ZN2VM8walkaddrEPyy+0x2e>
    }
    802068d8:	60a2                	ld	ra,8(sp)
        pa = PTE2PA(*pte);
    802068da:	8129                	srli	a0,a0,0xa
    802068dc:	0532                	slli	a0,a0,0xc
    }
    802068de:	0141                	addi	sp,sp,16
    802068e0:	8082                	ret
    802068e2:	60a2                	ld	ra,8(sp)
            return 0;
    802068e4:	4501                	li	a0,0
    }
    802068e6:	0141                	addi	sp,sp,16
    802068e8:	8082                	ret

00000000802068ea <_ZN4Slab4initEv>:

namespace Slab
{

    void init()
    {
    802068ea:	7139                	addi	sp,sp,-64
    802068ec:	f04a                	sd	s2,32(sp)
            caches[i].name = "kmalloc";

            // Calculate how many objects can fit on a page
            // Excluding the overhead of the SlabHeader
            uint64 available = PGSIZE - sizeof(struct SlabHeader);
            caches[i].obj_count_per_slab = available / caches[i].obj_size;
    802068ee:	6905                	lui	s2,0x1
    {
    802068f0:	f822                	sd	s0,48(sp)
    802068f2:	f426                	sd	s1,40(sp)
    802068f4:	ec4e                	sd	s3,24(sp)
    802068f6:	e852                	sd	s4,16(sp)
    802068f8:	e456                	sd	s5,8(sp)
    802068fa:	fc06                	sd	ra,56(sp)
    802068fc:	00017417          	auipc	s0,0x17
    80206900:	32440413          	addi	s0,s0,804 # 8021dc20 <caches>
    80206904:	0000c497          	auipc	s1,0xc
    80206908:	d0448493          	addi	s1,s1,-764 # 80212608 <_ZL13kmalloc_sizes>
    8020690c:	00017a97          	auipc	s5,0x17
    80206910:	4d4a8a93          	addi	s5,s5,1236 # 8021dde0 <_ZN3PMM11total_pagesE>
    80206914:	0000ba17          	auipc	s4,0xb
    80206918:	414a0a13          	addi	s4,s4,1044 # 80211d28 <initcode_end+0x5e0>
            caches[i].lock.init("slab_lock");
    8020691c:	0000b997          	auipc	s3,0xb
    80206920:	3fc98993          	addi	s3,s3,1020 # 80211d18 <initcode_end+0x5d0>
            caches[i].obj_count_per_slab = available / caches[i].obj_size;
    80206924:	1941                	addi	s2,s2,-16 # ff0 <_start-0x801ff010>
            caches[i].lock.init("slab_lock");
    80206926:	8522                	mv	a0,s0
    80206928:	85ce                	mv	a1,s3
    8020692a:	8b0ff0ef          	jal	802059da <_ZN8Spinlock4initEPKc>
            caches[i].obj_size = kmalloc_sizes[i];
    8020692e:	609c                	ld	a5,0(s1)
            caches[i].name = "kmalloc";
    80206930:	03443823          	sd	s4,48(s0)
            caches[i].slab_list = nullptr;
    80206934:	02043423          	sd	zero,40(s0)
            caches[i].obj_count_per_slab = available / caches[i].obj_size;
    80206938:	02f95733          	divu	a4,s2,a5
            caches[i].obj_size = kmalloc_sizes[i];
    8020693c:	ec1c                	sd	a5,24(s0)
        for (int i = 0; i < NUM_CACHES; i++)
    8020693e:	03840413          	addi	s0,s0,56
    80206942:	04a1                	addi	s1,s1,8
            caches[i].obj_count_per_slab = available / caches[i].obj_size;
    80206944:	fee43423          	sd	a4,-24(s0)
        for (int i = 0; i < NUM_CACHES; i++)
    80206948:	fd541fe3          	bne	s0,s5,80206926 <_ZN4Slab4initEv+0x3c>
        }
        Drivers::uart_puts("[Slab] Initialized kmalloc caches.\n");
    }
    8020694c:	7442                	ld	s0,48(sp)
    8020694e:	70e2                	ld	ra,56(sp)
    80206950:	74a2                	ld	s1,40(sp)
    80206952:	7902                	ld	s2,32(sp)
    80206954:	69e2                	ld	s3,24(sp)
    80206956:	6a42                	ld	s4,16(sp)
    80206958:	6aa2                	ld	s5,8(sp)
        Drivers::uart_puts("[Slab] Initialized kmalloc caches.\n");
    8020695a:	0000b517          	auipc	a0,0xb
    8020695e:	3d650513          	addi	a0,a0,982 # 80211d30 <initcode_end+0x5e8>
    }
    80206962:	6121                	addi	sp,sp,64
        Drivers::uart_puts("[Slab] Initialized kmalloc caches.\n");
    80206964:	4060206f          	j	80208d6a <_ZN7Drivers9uart_putsEPKc>

0000000080206968 <_ZN4Slab7kmallocEy>:

        return slab;
    }

    void *kmalloc(uint64 size)
    {
    80206968:	715d                	addi	sp,sp,-80
    8020696a:	e486                	sd	ra,72(sp)
    8020696c:	e0a2                	sd	s0,64(sp)
        if (size == 0)
    8020696e:	c915                	beqz	a0,802069a2 <_ZN4Slab7kmallocEy+0x3a>
            return nullptr;

        // Large objects go directly through PMM
        if (size > 2048)
    80206970:	6785                	lui	a5,0x1
    80206972:	fc26                	sd	s1,56(sp)
    80206974:	80078793          	addi	a5,a5,-2048 # 800 <_start-0x801ff800>
    80206978:	84aa                	mv	s1,a0
    8020697a:	02a7f663          	bgeu	a5,a0,802069a6 <_ZN4Slab7kmallocEy+0x3e>
        {
            // calculate order
            int order = 0;
            uint64 req = size;
            uint64 pages = (size + PGSIZE - 1) / PGSIZE;
    8020697e:	6705                	lui	a4,0x1
    80206980:	177d                	addi	a4,a4,-1 # fff <_start-0x801ff001>
    80206982:	972a                	add	a4,a4,a0
    80206984:	8331                	srli	a4,a4,0xc
            (void)req;

            // calculate order: 2^order >= pages
            while ((1UL << order) < pages)
    80206986:	4785                	li	a5,1
            int order = 0;
    80206988:	4501                	li	a0,0
            while ((1UL << order) < pages)
    8020698a:	0ce7f763          	bgeu	a5,a4,80206a58 <_ZN4Slab7kmallocEy+0xf0>
    8020698e:	4685                	li	a3,1
            {
                order++;
    80206990:	2505                	addiw	a0,a0,1
            while ((1UL << order) < pages)
    80206992:	00a697b3          	sll	a5,a3,a0
    80206996:	fee7ede3          	bltu	a5,a4,80206990 <_ZN4Slab7kmallocEy+0x28>
            }
            if (order > MAX_ORDER)
    8020699a:	47ad                	li	a5,11
    8020699c:	0aa7de63          	bge	a5,a0,80206a58 <_ZN4Slab7kmallocEy+0xf0>
    802069a0:	74e2                	ld	s1,56(sp)
            return nullptr;
    802069a2:	4401                	li	s0,0
    802069a4:	a06d                	j	80206a4e <_ZN4Slab7kmallocEy+0xe6>
    802069a6:	f84a                	sd	s2,48(sp)
    802069a8:	f44e                	sd	s3,40(sp)
    802069aa:	f052                	sd	s4,32(sp)
    802069ac:	ec56                	sd	s5,24(sp)
    802069ae:	e85a                	sd	s6,16(sp)
    802069b0:	e45e                	sd	s7,8(sp)
    802069b2:	0000c797          	auipc	a5,0xc
    802069b6:	c5678793          	addi	a5,a5,-938 # 80212608 <_ZL13kmalloc_sizes>
            // Here, page->flags defaults to PG_used, not PG_slab
            // kfree needs to be able to recognize it
            return p;
        }

        int idx = 0;
    802069ba:	4401                	li	s0,0
        while (idx < NUM_CACHES && kmalloc_sizes[idx] < size)
    802069bc:	46a1                	li	a3,8
    802069be:	6398                	ld	a4,0(a5)
    802069c0:	07a1                	addi	a5,a5,8
    802069c2:	0a977963          	bgeu	a4,s1,80206a74 <_ZN4Slab7kmallocEy+0x10c>
        {
            idx++;
    802069c6:	2405                	addiw	s0,s0,1
        while (idx < NUM_CACHES && kmalloc_sizes[idx] < size)
    802069c8:	fed41be3          	bne	s0,a3,802069be <_ZN4Slab7kmallocEy+0x56>
    802069cc:	1c000b93          	li	s7,448
    802069d0:	00341993          	slli	s3,s0,0x3
        }

        struct KmemCache *c = &caches[idx];
    802069d4:	00017a17          	auipc	s4,0x17
    802069d8:	24ca0a13          	addi	s4,s4,588 # 8021dc20 <caches>
        c->lock.acquire();

        if (!c->slab_list)
    802069dc:	40898b33          	sub	s6,s3,s0
        struct KmemCache *c = &caches[idx];
    802069e0:	017a0ab3          	add	s5,s4,s7
        if (!c->slab_list)
    802069e4:	0b0e                	slli	s6,s6,0x3
        c->lock.acquire();
    802069e6:	8556                	mv	a0,s5
        if (!c->slab_list)
    802069e8:	9b52                	add	s6,s6,s4
        c->lock.acquire();
    802069ea:	996ff0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        if (!c->slab_list)
    802069ee:	028b3903          	ld	s2,40(s6)
    802069f2:	08090763          	beqz	s2,80206a80 <_ZN4Slab7kmallocEy+0x118>

        struct SlabHeader *slab = c->slab_list;

        int obj_idx = slab->free_idx;
        char *base = (char *)(slab + 1);
        void *ptr = base + obj_idx * c->obj_size;
    802069f6:	408989b3          	sub	s3,s3,s0
    802069fa:	098e                	slli	s3,s3,0x3
    802069fc:	9a4e                	add	s4,s4,s3
    802069fe:	018a3703          	ld	a4,24(s4)
    80206a02:	00895403          	lhu	s0,8(s2)

        uint16 *link = (uint16 *)ptr;
        slab->free_idx = *link;
        slab->used_count++;
    80206a06:	00a95783          	lhu	a5,10(s2)
        void *ptr = base + obj_idx * c->obj_size;
    80206a0a:	02e40433          	mul	s0,s0,a4
        slab->free_idx = *link;
    80206a0e:	6741                	lui	a4,0x10
        slab->used_count++;
    80206a10:	2785                	addiw	a5,a5,1
        slab->free_idx = *link;
    80206a12:	177d                	addi	a4,a4,-1 # ffff <_start-0x801f0001>
    80206a14:	0107979b          	slliw	a5,a5,0x10
        void *ptr = base + obj_idx * c->obj_size;
    80206a18:	0441                	addi	s0,s0,16
    80206a1a:	944a                	add	s0,s0,s2
        slab->free_idx = *link;
    80206a1c:	00045603          	lhu	a2,0(s0)
    80206a20:	00e676b3          	and	a3,a2,a4
    80206a24:	8fd5                	or	a5,a5,a3
    80206a26:	00f92423          	sw	a5,8(s2)

        if (slab->free_idx == 0xFFFF)
    80206a2a:	02e60d63          	beq	a2,a4,80206a64 <_ZN4Slab7kmallocEy+0xfc>
            {
                c->slab_list = nullptr;
            }
        }

        c->lock.release();
    80206a2e:	8556                	mv	a0,s5
    80206a30:	8e8ff0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>

        memset(ptr, 0, size);
    80206a34:	0004861b          	sext.w	a2,s1
    80206a38:	4581                	li	a1,0
    80206a3a:	8522                	mv	a0,s0
    80206a3c:	beefe0ef          	jal	80204e2a <_Z6memsetPvij>
    80206a40:	74e2                	ld	s1,56(sp)
    80206a42:	7942                	ld	s2,48(sp)
    80206a44:	79a2                	ld	s3,40(sp)
    80206a46:	7a02                	ld	s4,32(sp)
    80206a48:	6ae2                	ld	s5,24(sp)
    80206a4a:	6b42                	ld	s6,16(sp)
    80206a4c:	6ba2                	ld	s7,8(sp)
        return ptr;
    }
    80206a4e:	60a6                	ld	ra,72(sp)
    80206a50:	8522                	mv	a0,s0
    80206a52:	6406                	ld	s0,64(sp)
    80206a54:	6161                	addi	sp,sp,80
    80206a56:	8082                	ret
    80206a58:	6406                	ld	s0,64(sp)
            void *p = PMM::alloc_pages(order);
    80206a5a:	74e2                	ld	s1,56(sp)
    }
    80206a5c:	60a6                	ld	ra,72(sp)
    80206a5e:	6161                	addi	sp,sp,80
            void *p = PMM::alloc_pages(order);
    80206a60:	2f00006f          	j	80206d50 <_ZN3PMM11alloc_pagesEi>
            if (slab->next)
    80206a64:	00093783          	ld	a5,0(s2)
    80206a68:	c7e9                	beqz	a5,80206b32 <_ZN4Slab7kmallocEy+0x1ca>
                c->slab_list = slab->next;
    80206a6a:	02fa3423          	sd	a5,40(s4)
                slab->next = nullptr;
    80206a6e:	00093023          	sd	zero,0(s2)
    80206a72:	bf75                	j	80206a2e <_ZN4Slab7kmallocEy+0xc6>
    80206a74:	00341993          	slli	s3,s0,0x3
    80206a78:	40898bb3          	sub	s7,s3,s0
    80206a7c:	0b8e                	slli	s7,s7,0x3
    80206a7e:	bf99                	j	802069d4 <_ZN4Slab7kmallocEy+0x6c>
        void *p = PMM::alloc_page();
    80206a80:	6e2000ef          	jal	80207162 <_ZN3PMM10alloc_pageEv>
    80206a84:	892a                	mv	s2,a0
        if (!p)
    80206a86:	c941                	beqz	a0,80206b16 <_ZN4Slab7kmallocEy+0x1ae>
    return PMM::pa_to_page(pa);
    80206a88:	20e000ef          	jal	80206c96 <_ZN3PMM10pa_to_pageEy>
        if (page)
    80206a8c:	cd0d                	beqz	a0,80206ac6 <_ZN4Slab7kmallocEy+0x15e>
            int cache_idx = c - caches;
    80206a8e:	06db7737          	lui	a4,0x6db7
    80206a92:	db770713          	addi	a4,a4,-585 # 6db6db7 <_start-0x79449249>
    80206a96:	0732                	slli	a4,a4,0xc
    80206a98:	db770713          	addi	a4,a4,-585
    80206a9c:	0732                	slli	a4,a4,0xc
    80206a9e:	db770713          	addi	a4,a4,-585
    80206aa2:	0732                	slli	a4,a4,0xc
    80206aa4:	db770713          	addi	a4,a4,-585
    80206aa8:	403bd793          	srai	a5,s7,0x3
    80206aac:	02e787b3          	mul	a5,a5,a4
            page->flags |= PG_slab;
    80206ab0:	00054703          	lbu	a4,0(a0)
    80206ab4:	00476713          	ori	a4,a4,4
    80206ab8:	0ff7f793          	zext.b	a5,a5
    80206abc:	0087979b          	slliw	a5,a5,0x8
    80206ac0:	8fd9                	or	a5,a5,a4
    80206ac2:	00f51023          	sh	a5,0(a0)
        for (uint i = 0; i < c->obj_count_per_slab - 1; i++)
    80206ac6:	408987b3          	sub	a5,s3,s0
    80206aca:	078e                	slli	a5,a5,0x3
        slab->free_idx = 0;
    80206acc:	00093423          	sd	zero,8(s2)
        for (uint i = 0; i < c->obj_count_per_slab - 1; i++)
    80206ad0:	97d2                	add	a5,a5,s4
    80206ad2:	7390                	ld	a2,32(a5)
        slab->next = nullptr;
    80206ad4:	00093023          	sd	zero,0(s2)
        uint16 *ptr = (uint16 *)(base + (c->obj_count_per_slab - 1) * c->obj_size);
    80206ad8:	6f88                	ld	a0,24(a5)
        for (uint i = 0; i < c->obj_count_per_slab - 1; i++)
    80206ada:	167d                	addi	a2,a2,-1 # fff <_start-0x801ff001>
        char *base = (char *)(slab + 1);
    80206adc:	01090593          	addi	a1,s2,16
        for (uint i = 0; i < c->obj_count_per_slab - 1; i++)
    80206ae0:	c20d                	beqz	a2,80206b02 <_ZN4Slab7kmallocEy+0x19a>
    80206ae2:	4785                	li	a5,1
    80206ae4:	4681                	li	a3,0
            uint16 *ptr = (uint16 *)(base + i * c->obj_size);
    80206ae6:	02a68733          	mul	a4,a3,a0
        for (uint i = 0; i < c->obj_count_per_slab - 1; i++)
    80206aea:	02079693          	slli	a3,a5,0x20
    80206aee:	9281                	srli	a3,a3,0x20
            *ptr = i + 1;
    80206af0:	972e                	add	a4,a4,a1
    80206af2:	00f71023          	sh	a5,0(a4)
        for (uint i = 0; i < c->obj_count_per_slab - 1; i++)
    80206af6:	2785                	addiw	a5,a5,1
    80206af8:	fec6e7e3          	bltu	a3,a2,80206ae6 <_ZN4Slab7kmallocEy+0x17e>
        uint16 *ptr = (uint16 *)(base + (c->obj_count_per_slab - 1) * c->obj_size);
    80206afc:	02a60633          	mul	a2,a2,a0
    80206b00:	95b2                	add	a1,a1,a2
            c->slab_list = grow_cache(c);
    80206b02:	408987b3          	sub	a5,s3,s0
    80206b06:	078e                	slli	a5,a5,0x3
        *ptr = 0xFFFF;
    80206b08:	577d                	li	a4,-1
    80206b0a:	00e59023          	sh	a4,0(a1)
            c->slab_list = grow_cache(c);
    80206b0e:	97d2                	add	a5,a5,s4
    80206b10:	0327b423          	sd	s2,40(a5)
            if (!c->slab_list)
    80206b14:	b5cd                	j	802069f6 <_ZN4Slab7kmallocEy+0x8e>
                c->lock.release();
    80206b16:	8556                	mv	a0,s5
            c->slab_list = grow_cache(c);
    80206b18:	020b3423          	sd	zero,40(s6)
            return nullptr;
    80206b1c:	4401                	li	s0,0
                c->lock.release();
    80206b1e:	ffbfe0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
    80206b22:	74e2                	ld	s1,56(sp)
    80206b24:	7942                	ld	s2,48(sp)
    80206b26:	79a2                	ld	s3,40(sp)
    80206b28:	7a02                	ld	s4,32(sp)
    80206b2a:	6ae2                	ld	s5,24(sp)
    80206b2c:	6b42                	ld	s6,16(sp)
    80206b2e:	6ba2                	ld	s7,8(sp)
    80206b30:	bf39                	j	80206a4e <_ZN4Slab7kmallocEy+0xe6>
                c->slab_list = nullptr;
    80206b32:	020a3423          	sd	zero,40(s4)
    80206b36:	bde5                	j	80206a2e <_ZN4Slab7kmallocEy+0xc6>

0000000080206b38 <_ZN4Slab5kfreeEPv>:

    void kfree(void *ptr)
    {
        if (!ptr)
    80206b38:	10050963          	beqz	a0,80206c4a <_ZN4Slab5kfreeEPv+0x112>
    {
    80206b3c:	7139                	addi	sp,sp,-64
    80206b3e:	f822                	sd	s0,48(sp)
    80206b40:	f426                	sd	s1,40(sp)
    80206b42:	fc06                	sd	ra,56(sp)
    80206b44:	842a                	mv	s0,a0
    return PMM::pa_to_page(pa);
    80206b46:	150000ef          	jal	80206c96 <_ZN3PMM10pa_to_pageEy>
    80206b4a:	84aa                	mv	s1,a0
            return;

        struct Page *page = virt_to_page(ptr);
        if (!page)
    80206b4c:	c54d                	beqz	a0,80206bf6 <_ZN4Slab5kfreeEPv+0xbe>
            return;

        if (!page || !(page->flags & PG_slab))
    80206b4e:	e456                	sd	s5,8(sp)
    80206b50:	00054783          	lbu	a5,0(a0)
        {
            PMM::free_pages(ptr, page->order);
    80206b54:	00154703          	lbu	a4,1(a0)
        if (!page || !(page->flags & PG_slab))
    80206b58:	8b91                	andi	a5,a5,4
            PMM::free_pages(ptr, page->order);
    80206b5a:	00070a9b          	sext.w	s5,a4
        if (!page || !(page->flags & PG_slab))
    80206b5e:	c3cd                	beqz	a5,80206c00 <_ZN4Slab5kfreeEPv+0xc8>
            return;
        }

        int cache_idx = page->order;
        if (cache_idx >= NUM_CACHES)
    80206b60:	479d                	li	a5,7
    80206b62:	0ce7e963          	bltu	a5,a4,80206c34 <_ZN4Slab5kfreeEPv+0xfc>
    80206b66:	f04a                	sd	s2,32(sp)
    80206b68:	00371913          	slli	s2,a4,0x3
    80206b6c:	40e90933          	sub	s2,s2,a4
    80206b70:	e852                	sd	s4,16(sp)
            Drivers::uart_puts("Slab: Corrupted page metadata\n");
            return;
        }

        struct KmemCache *c = &caches[cache_idx];
        c->lock.acquire();
    80206b72:	090e                	slli	s2,s2,0x3
    80206b74:	00017a17          	auipc	s4,0x17
    80206b78:	0aca0a13          	addi	s4,s4,172 # 8021dc20 <caches>
    80206b7c:	ec4e                	sd	s3,24(sp)
    80206b7e:	012a09b3          	add	s3,s4,s2
    80206b82:	854e                	mv	a0,s3
    80206b84:	ffdfe0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>

        struct SlabHeader *slab = (struct SlabHeader *)PGROUNDDOWN((uint64)ptr);
    80206b88:	757d                	lui	a0,0xfffff
    80206b8a:	8d61                	and	a0,a0,s0

        if ((uint64)ptr < (uint64)(slab + 1) || (uint64)ptr >= (uint64)slab + PGSIZE)
    80206b8c:	01050793          	addi	a5,a0,16 # fffffffffffff010 <kernel_end+0xffffffff7fdd8010>
    80206b90:	08f46163          	bltu	s0,a5,80206c12 <_ZN4Slab5kfreeEPv+0xda>
    80206b94:	6705                	lui	a4,0x1
    80206b96:	972a                	add	a4,a4,a0
    80206b98:	06e47d63          	bgeu	s0,a4,80206c12 <_ZN4Slab5kfreeEPv+0xda>
            c->lock.release();
            return;
        }

        char *base = (char *)(slab + 1);
        int obj_idx = ((uint64)ptr - (uint64)base) / c->obj_size;
    80206b9c:	003a9713          	slli	a4,s5,0x3
    80206ba0:	41570733          	sub	a4,a4,s5
    80206ba4:	070e                	slli	a4,a4,0x3
    80206ba6:	9752                	add	a4,a4,s4
    80206ba8:	6f10                	ld	a2,24(a4)
    80206baa:	40f407b3          	sub	a5,s0,a5

        uint16 *link = (uint16 *)ptr;
        *link = slab->free_idx;
    80206bae:	00855683          	lhu	a3,8(a0)
        int obj_idx = ((uint64)ptr - (uint64)base) / c->obj_size;
    80206bb2:	02c7d7b3          	divu	a5,a5,a2
        *link = slab->free_idx;
    80206bb6:	00d41023          	sh	a3,0(s0)
        slab->free_idx = (uint16)obj_idx;

        slab->used_count--;
    80206bba:	00a55683          	lhu	a3,10(a0)
    80206bbe:	36fd                	addiw	a3,a3,-1 # ffffffffffffefff <kernel_end+0xffffffff7fdd7fff>
        slab->free_idx = (uint16)obj_idx;
    80206bc0:	0106961b          	slliw	a2,a3,0x10
        slab->used_count--;
    80206bc4:	16c2                	slli	a3,a3,0x30
    80206bc6:	92c1                	srli	a3,a3,0x30
        slab->free_idx = (uint16)obj_idx;
    80206bc8:	17c2                	slli	a5,a5,0x30
    80206bca:	93c1                	srli	a5,a5,0x30
    80206bcc:	8fd1                	or	a5,a5,a2
    80206bce:	c51c                	sw	a5,8(a0)

        if (slab->used_count == 0)
    80206bd0:	eeb5                	bnez	a3,80206c4c <_ZN4Slab5kfreeEPv+0x114>
        {
            struct SlabHeader **pp = &c->slab_list;
    80206bd2:	771c                	ld	a5,40(a4)
            // bool found = false;
            while (*pp)
    80206bd4:	cb89                	beqz	a5,80206be6 <_ZN4Slab5kfreeEPv+0xae>
            {
                if (*pp == slab)
    80206bd6:	00a79563          	bne	a5,a0,80206be0 <_ZN4Slab5kfreeEPv+0xa8>
    80206bda:	a049                	j	80206c5c <_ZN4Slab5kfreeEPv+0x124>
    80206bdc:	08f50363          	beq	a0,a5,80206c62 <_ZN4Slab5kfreeEPv+0x12a>
                {
                    *pp = slab->next;
                    // found = true;
                    break;
                }
                pp = &(*pp)->next;
    80206be0:	8a3e                	mv	s4,a5
    80206be2:	639c                	ld	a5,0(a5)
            while (*pp)
    80206be4:	ffe5                	bnez	a5,80206bdc <_ZN4Slab5kfreeEPv+0xa4>
            }

            page->flags &= ~PG_slab;
    80206be6:	0004c783          	lbu	a5,0(s1)
    80206bea:	9bed                	andi	a5,a5,-5
    80206bec:	00f48023          	sb	a5,0(s1)
            PMM::free_page(slab);
    80206bf0:	594000ef          	jal	80207184 <_ZN3PMM9free_pageEPv>
    80206bf4:	a02d                	j	80206c1e <_ZN4Slab5kfreeEPv+0xe6>
                c->slab_list = slab;
            }
        }

        c->lock.release();
    }
    80206bf6:	70e2                	ld	ra,56(sp)
    80206bf8:	7442                	ld	s0,48(sp)
    80206bfa:	74a2                	ld	s1,40(sp)
    80206bfc:	6121                	addi	sp,sp,64
    80206bfe:	8082                	ret
            PMM::free_pages(ptr, page->order);
    80206c00:	8522                	mv	a0,s0
    }
    80206c02:	7442                	ld	s0,48(sp)
    80206c04:	70e2                	ld	ra,56(sp)
    80206c06:	74a2                	ld	s1,40(sp)
            PMM::free_pages(ptr, page->order);
    80206c08:	85d6                	mv	a1,s5
    80206c0a:	6aa2                	ld	s5,8(sp)
    }
    80206c0c:	6121                	addi	sp,sp,64
            PMM::free_pages(ptr, page->order);
    80206c0e:	26c0006f          	j	80206e7a <_ZN3PMM10free_pagesEPvi>
            Drivers::uart_puts("Slab: kfree invalid pointer\n");
    80206c12:	0000b517          	auipc	a0,0xb
    80206c16:	16650513          	addi	a0,a0,358 # 80211d78 <initcode_end+0x630>
    80206c1a:	150020ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
    }
    80206c1e:	7442                	ld	s0,48(sp)
        c->lock.release();
    80206c20:	7902                	ld	s2,32(sp)
    80206c22:	6a42                	ld	s4,16(sp)
    80206c24:	6aa2                	ld	s5,8(sp)
    }
    80206c26:	70e2                	ld	ra,56(sp)
    80206c28:	74a2                	ld	s1,40(sp)
        c->lock.release();
    80206c2a:	854e                	mv	a0,s3
    80206c2c:	69e2                	ld	s3,24(sp)
    }
    80206c2e:	6121                	addi	sp,sp,64
        c->lock.release();
    80206c30:	ee9fe06f          	j	80205b18 <_ZN8Spinlock7releaseEv>
    }
    80206c34:	7442                	ld	s0,48(sp)
            Drivers::uart_puts("Slab: Corrupted page metadata\n");
    80206c36:	6aa2                	ld	s5,8(sp)
    }
    80206c38:	70e2                	ld	ra,56(sp)
    80206c3a:	74a2                	ld	s1,40(sp)
            Drivers::uart_puts("Slab: Corrupted page metadata\n");
    80206c3c:	0000b517          	auipc	a0,0xb
    80206c40:	11c50513          	addi	a0,a0,284 # 80211d58 <initcode_end+0x610>
    }
    80206c44:	6121                	addi	sp,sp,64
            Drivers::uart_puts("Slab: Corrupted page metadata\n");
    80206c46:	1240206f          	j	80208d6a <_ZN7Drivers9uart_putsEPKc>
    80206c4a:	8082                	ret
            if (slab->used_count == c->obj_count_per_slab - 1)
    80206c4c:	731c                	ld	a5,32(a4)
    80206c4e:	17fd                	addi	a5,a5,-1
    80206c50:	fcf697e3          	bne	a3,a5,80206c1e <_ZN4Slab5kfreeEPv+0xe6>
                slab->next = c->slab_list;
    80206c54:	771c                	ld	a5,40(a4)
    80206c56:	e11c                	sd	a5,0(a0)
                c->slab_list = slab;
    80206c58:	f708                	sd	a0,40(a4)
    80206c5a:	b7d1                	j	80206c1e <_ZN4Slab5kfreeEPv+0xe6>
            struct SlabHeader **pp = &c->slab_list;
    80206c5c:	02890913          	addi	s2,s2,40
    80206c60:	9a4a                	add	s4,s4,s2
                    *pp = slab->next;
    80206c62:	611c                	ld	a5,0(a0)
    80206c64:	00fa3023          	sd	a5,0(s4)
                    break;
    80206c68:	bfbd                	j	80206be6 <_ZN4Slab5kfreeEPv+0xae>

0000000080206c6a <_GLOBAL__sub_I_caches>:
struct KmemCache caches[NUM_CACHES];
    80206c6a:	00017797          	auipc	a5,0x17
    80206c6e:	fb678793          	addi	a5,a5,-74 # 8021dc20 <caches>
    80206c72:	00017697          	auipc	a3,0x17
    80206c76:	16e68693          	addi	a3,a3,366 # 8021dde0 <_ZN3PMM11total_pagesE>
    80206c7a:	0000b717          	auipc	a4,0xb
    80206c7e:	b0e70713          	addi	a4,a4,-1266 # 80211788 <initcode_end+0x40>
    80206c82:	0007a023          	sw	zero,0(a5)
    80206c86:	e798                	sd	a4,8(a5)
    80206c88:	0007b823          	sd	zero,16(a5)
    80206c8c:	03878793          	addi	a5,a5,56
    80206c90:	fed799e3          	bne	a5,a3,80206c82 <_GLOBAL__sub_I_caches+0x18>
    80206c94:	8082                	ret

0000000080206c96 <_ZN3PMM10pa_to_pageEy>:
    // Protective lock
    Spinlock pmm_lock;

    struct Page *pa_to_page(uint64 pa)
    {
        if (pa < KERNBASE || pa >= PHYSTOP)
    80206c96:	800007b7          	lui	a5,0x80000
    80206c9a:	97aa                	add	a5,a5,a0
    80206c9c:	08000737          	lui	a4,0x8000
    80206ca0:	02e7f163          	bgeu	a5,a4,80206cc2 <_ZN3PMM10pa_to_pageEy+0x2c>
            return nullptr;
        uint64 pfn = (pa - KERNBASE) >> PGSHIFT;
        if (pfn >= total_pages)
    80206ca4:	00017717          	auipc	a4,0x17
    80206ca8:	13c70713          	addi	a4,a4,316 # 8021dde0 <_ZN3PMM11total_pagesE>
    80206cac:	6314                	ld	a3,0(a4)
        uint64 pfn = (pa - KERNBASE) >> PGSHIFT;
    80206cae:	83b1                	srli	a5,a5,0xc
        if (pfn >= total_pages)
    80206cb0:	00d7f963          	bgeu	a5,a3,80206cc2 <_ZN3PMM10pa_to_pageEy+0x2c>
            return nullptr;
        return &mem_map[pfn];
    80206cb4:	6708                	ld	a0,8(a4)
    80206cb6:	00179713          	slli	a4,a5,0x1
    80206cba:	97ba                	add	a5,a5,a4
    80206cbc:	078e                	slli	a5,a5,0x3
    80206cbe:	953e                	add	a0,a0,a5
    80206cc0:	8082                	ret
            return nullptr;
    80206cc2:	4501                	li	a0,0
    }
    80206cc4:	8082                	ret

0000000080206cc6 <_ZN3PMM10page_to_paEP4Page>:

    uint64 page_to_pa(struct Page *page)
    {
        uint64 pfn = page - mem_map;
    80206cc6:	faaab7b7          	lui	a5,0xfaaab
    80206cca:	aab78793          	addi	a5,a5,-1365 # fffffffffaaaaaab <kernel_end+0xffffffff7a883aab>
    80206cce:	07b2                	slli	a5,a5,0xc
    80206cd0:	aab78793          	addi	a5,a5,-1365
    80206cd4:	07b2                	slli	a5,a5,0xc
    80206cd6:	00017717          	auipc	a4,0x17
    80206cda:	11273703          	ld	a4,274(a4) # 8021dde8 <_ZN3PMM7mem_mapE>
    80206cde:	aab78793          	addi	a5,a5,-1365
    80206ce2:	8d19                	sub	a0,a0,a4
    80206ce4:	07b2                	slli	a5,a5,0xc
    80206ce6:	aab78793          	addi	a5,a5,-1365
    80206cea:	850d                	srai	a0,a0,0x3
    80206cec:	02f50533          	mul	a0,a0,a5
        return KERNBASE + (pfn << PGSHIFT);
    80206cf0:	4785                	li	a5,1
    80206cf2:	07fe                	slli	a5,a5,0x1f
    80206cf4:	0532                	slli	a0,a0,0xc
    }
    80206cf6:	953e                	add	a0,a0,a5
    80206cf8:	8082                	ret

0000000080206cfa <_ZN3PMM8list_addEP4Pagei>:

    void list_add(struct Page *page, int order)
    {
        page->order = order;
        page->flags = 0; // Mark as available
        page->next = free_area[order];
    80206cfa:	00017797          	auipc	a5,0x17
    80206cfe:	0e678793          	addi	a5,a5,230 # 8021dde0 <_ZN3PMM11total_pagesE>
    80206d02:	00359713          	slli	a4,a1,0x3
        page->order = order;
    80206d06:	00b500a3          	sb	a1,1(a0)
        page->flags = 0; // Mark as available
    80206d0a:	00050023          	sb	zero,0(a0)
        page->next = free_area[order];
    80206d0e:	00e786b3          	add	a3,a5,a4
    80206d12:	6a90                	ld	a2,16(a3)
        page->prev = nullptr;
    80206d14:	00053823          	sd	zero,16(a0)
        page->next = free_area[order];
    80206d18:	e510                	sd	a2,8(a0)

        if (free_area[order])
    80206d1a:	6a94                	ld	a3,16(a3)
    80206d1c:	c291                	beqz	a3,80206d20 <_ZN3PMM8list_addEP4Pagei+0x26>
        {
            free_area[order]->prev = page;
    80206d1e:	ea88                	sd	a0,16(a3)
        }
        free_area[order] = page;
    80206d20:	97ba                	add	a5,a5,a4
    80206d22:	eb88                	sd	a0,16(a5)
    }
    80206d24:	8082                	ret

0000000080206d26 <_ZN3PMM8list_delEP4Pagei>:

    void list_del(struct Page* page, int order)
    {
        if (page->prev)
    80206d26:	691c                	ld	a5,16(a0)
        {
            page->prev->next = page->next;
    80206d28:	6518                	ld	a4,8(a0)
        if (page->prev)
    80206d2a:	cb99                	beqz	a5,80206d40 <_ZN3PMM8list_delEP4Pagei+0x1a>
            page->prev->next = page->next;
    80206d2c:	e798                	sd	a4,8(a5)
        }
        else
        {
            free_area[order] = page->next;
        }
        if (page->next)
    80206d2e:	651c                	ld	a5,8(a0)
    80206d30:	c399                	beqz	a5,80206d36 <_ZN3PMM8list_delEP4Pagei+0x10>
        {
            page->next->prev = page->prev;
    80206d32:	6918                	ld	a4,16(a0)
    80206d34:	eb98                	sd	a4,16(a5)
        }
        page->next = nullptr;
    80206d36:	00053423          	sd	zero,8(a0)
        page->prev = nullptr;
    80206d3a:	00053823          	sd	zero,16(a0)
    }
    80206d3e:	8082                	ret
            free_area[order] = page->next;
    80206d40:	058e                	slli	a1,a1,0x3
    80206d42:	00017797          	auipc	a5,0x17
    80206d46:	09e78793          	addi	a5,a5,158 # 8021dde0 <_ZN3PMM11total_pagesE>
    80206d4a:	97ae                	add	a5,a5,a1
    80206d4c:	eb98                	sd	a4,16(a5)
    80206d4e:	b7c5                	j	80206d2e <_ZN3PMM8list_delEP4Pagei+0x8>

0000000080206d50 <_ZN3PMM11alloc_pagesEi>:
        
    }

    void *alloc_pages(int order)
    {
        if (order < 0 || order >= MAX_ORDER)
    80206d50:	47a9                	li	a5,10
    80206d52:	10a7e963          	bltu	a5,a0,80206e64 <_ZN3PMM11alloc_pagesEi+0x114>
    {
    80206d56:	1101                	addi	sp,sp,-32
    80206d58:	e426                	sd	s1,8(sp)
    80206d5a:	84aa                	mv	s1,a0
            return nullptr;
        
        pmm_lock.acquire();
    80206d5c:	00017517          	auipc	a0,0x17
    80206d60:	0ec50513          	addi	a0,a0,236 # 8021de48 <_ZN3PMM8pmm_lockE>
    {
    80206d64:	ec06                	sd	ra,24(sp)
    80206d66:	e822                	sd	s0,16(sp)
        pmm_lock.acquire();
    80206d68:	e19fe0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>

        int current_order = order;
        while (current_order < MAX_ORDER)
    80206d6c:	00017697          	auipc	a3,0x17
    80206d70:	08468693          	addi	a3,a3,132 # 8021ddf0 <_ZN3PMM9free_areaE>
    80206d74:	00349793          	slli	a5,s1,0x3
    80206d78:	97b6                	add	a5,a5,a3
        int current_order = order;
    80206d7a:	8726                	mv	a4,s1
        while (current_order < MAX_ORDER)
    80206d7c:	462d                	li	a2,11
    80206d7e:	a021                	j	80206d86 <_ZN3PMM11alloc_pagesEi+0x36>
                page->refcnt = 1;

                pmm_lock.release();
                return (void *)page_to_pa(page);
            }
            current_order++;
    80206d80:	2705                	addiw	a4,a4,1
        while (current_order < MAX_ORDER)
    80206d82:	0ac70f63          	beq	a4,a2,80206e40 <_ZN3PMM11alloc_pagesEi+0xf0>
            if (free_area[current_order])
    80206d86:	6380                	ld	s0,0(a5)
        while (current_order < MAX_ORDER)
    80206d88:	07a1                	addi	a5,a5,8
            if (free_area[current_order])
    80206d8a:	d87d                	beqz	s0,80206d80 <_ZN3PMM11alloc_pagesEi+0x30>
        if (page->prev)
    80206d8c:	681c                	ld	a5,16(s0)
    80206d8e:	e04a                	sd	s2,0(sp)
            page->prev->next = page->next;
    80206d90:	6410                	ld	a2,8(s0)
        if (page->prev)
    80206d92:	cbf9                	beqz	a5,80206e68 <_ZN3PMM11alloc_pagesEi+0x118>
            page->prev->next = page->next;
    80206d94:	e790                	sd	a2,8(a5)
    80206d96:	00017917          	auipc	s2,0x17
    80206d9a:	04a90913          	addi	s2,s2,74 # 8021dde0 <_ZN3PMM11total_pagesE>
        if (page->next)
    80206d9e:	641c                	ld	a5,8(s0)
    80206da0:	c399                	beqz	a5,80206da6 <_ZN3PMM11alloc_pagesEi+0x56>
            page->next->prev = page->prev;
    80206da2:	6810                	ld	a2,16(s0)
    80206da4:	eb90                	sd	a2,16(a5)
        page->next = nullptr;
    80206da6:	00371793          	slli	a5,a4,0x3
    80206daa:	17e1                	addi	a5,a5,-8
    80206dac:	00043423          	sd	zero,8(s0)
        page->prev = nullptr;
    80206db0:	00043823          	sd	zero,16(s0)
                while (current_order > order)
    80206db4:	96be                	add	a3,a3,a5
                    struct Page *buddy = page + (1 << current_order);
    80206db6:	4585                	li	a1,1
                while (current_order > order)
    80206db8:	02e4d963          	bge	s1,a4,80206dea <_ZN3PMM11alloc_pagesEi+0x9a>
                    current_order--;
    80206dbc:	377d                	addiw	a4,a4,-1
                    struct Page *buddy = page + (1 << current_order);
    80206dbe:	00e5963b          	sllw	a2,a1,a4
    80206dc2:	00161793          	slli	a5,a2,0x1
    80206dc6:	97b2                	add	a5,a5,a2
    80206dc8:	078e                	slli	a5,a5,0x3
    80206dca:	97a2                	add	a5,a5,s0
        page->order = order;
    80206dcc:	00e780a3          	sb	a4,1(a5)
        page->flags = 0; // Mark as available
    80206dd0:	00078023          	sb	zero,0(a5)
        page->next = free_area[order];
    80206dd4:	6290                	ld	a2,0(a3)
        page->prev = nullptr;
    80206dd6:	0007b823          	sd	zero,16(a5)
        page->next = free_area[order];
    80206dda:	e790                	sd	a2,8(a5)
        if (free_area[order])
    80206ddc:	6290                	ld	a2,0(a3)
    80206dde:	c211                	beqz	a2,80206de2 <_ZN3PMM11alloc_pagesEi+0x92>
            free_area[order]->prev = page;
    80206de0:	ea1c                	sd	a5,16(a2)
        free_area[order] = page;
    80206de2:	e29c                	sd	a5,0(a3)
                while (current_order > order)
    80206de4:	16e1                	addi	a3,a3,-8
    80206de6:	fce49be3          	bne	s1,a4,80206dbc <_ZN3PMM11alloc_pagesEi+0x6c>
                page->flags = PG_used;
    80206dea:	4785                	li	a5,1
    80206dec:	00f40023          	sb	a5,0(s0)
                page->order = order; // Record the orders that have been assigned
    80206df0:	009400a3          	sb	s1,1(s0)
                page->refcnt = 1;
    80206df4:	00f41123          	sh	a5,2(s0)
                pmm_lock.release();
    80206df8:	00017517          	auipc	a0,0x17
    80206dfc:	05050513          	addi	a0,a0,80 # 8021de48 <_ZN3PMM8pmm_lockE>
    80206e00:	d19fe0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
        uint64 pfn = page - mem_map;
    80206e04:	faaab7b7          	lui	a5,0xfaaab
    80206e08:	aab78793          	addi	a5,a5,-1365 # fffffffffaaaaaab <kernel_end+0xffffffff7a883aab>
    80206e0c:	07b2                	slli	a5,a5,0xc
    80206e0e:	00893503          	ld	a0,8(s2)
    80206e12:	aab78793          	addi	a5,a5,-1365
    80206e16:	07b2                	slli	a5,a5,0xc
    80206e18:	aab78793          	addi	a5,a5,-1365
    80206e1c:	40a40533          	sub	a0,s0,a0
    80206e20:	07b2                	slli	a5,a5,0xc
    80206e22:	aab78793          	addi	a5,a5,-1365
    80206e26:	850d                	srai	a0,a0,0x3
    80206e28:	02f50533          	mul	a0,a0,a5
        }
        pmm_lock.release();
        Drivers::uart_puts("PMM: OOM alloc_pages\n");
        return nullptr;
    }
    80206e2c:	60e2                	ld	ra,24(sp)
    80206e2e:	6442                	ld	s0,16(sp)
        return KERNBASE + (pfn << PGSHIFT);
    80206e30:	4785                	li	a5,1
    80206e32:	07fe                	slli	a5,a5,0x1f
                return (void *)page_to_pa(page);
    80206e34:	6902                	ld	s2,0(sp)
    }
    80206e36:	64a2                	ld	s1,8(sp)
    80206e38:	6105                	addi	sp,sp,32
        return KERNBASE + (pfn << PGSHIFT);
    80206e3a:	0532                	slli	a0,a0,0xc
    80206e3c:	953e                	add	a0,a0,a5
    }
    80206e3e:	8082                	ret
        pmm_lock.release();
    80206e40:	00017517          	auipc	a0,0x17
    80206e44:	00850513          	addi	a0,a0,8 # 8021de48 <_ZN3PMM8pmm_lockE>
    80206e48:	cd1fe0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
        Drivers::uart_puts("PMM: OOM alloc_pages\n");
    80206e4c:	0000b517          	auipc	a0,0xb
    80206e50:	f4c50513          	addi	a0,a0,-180 # 80211d98 <initcode_end+0x650>
    80206e54:	717010ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
    }
    80206e58:	60e2                	ld	ra,24(sp)
    80206e5a:	6442                	ld	s0,16(sp)
    80206e5c:	64a2                	ld	s1,8(sp)
            return nullptr;
    80206e5e:	4501                	li	a0,0
    }
    80206e60:	6105                	addi	sp,sp,32
    80206e62:	8082                	ret
            return nullptr;
    80206e64:	4501                	li	a0,0
    }
    80206e66:	8082                	ret
            free_area[order] = page->next;
    80206e68:	00017917          	auipc	s2,0x17
    80206e6c:	f7890913          	addi	s2,s2,-136 # 8021dde0 <_ZN3PMM11total_pagesE>
    80206e70:	00371793          	slli	a5,a4,0x3
    80206e74:	97ca                	add	a5,a5,s2
    80206e76:	eb90                	sd	a2,16(a5)
    80206e78:	b71d                	j	80206d9e <_ZN3PMM11alloc_pagesEi+0x4e>

0000000080206e7a <_ZN3PMM10free_pagesEPvi>:

    void free_pages(void *pa, int order)
    {
        if (!pa)
    80206e7a:	14050d63          	beqz	a0,80206fd4 <_ZN3PMM10free_pagesEPvi+0x15a>
        if (pa < KERNBASE || pa >= PHYSTOP)
    80206e7e:	800007b7          	lui	a5,0x80000
    80206e82:	953e                	add	a0,a0,a5
    80206e84:	080007b7          	lui	a5,0x8000
    80206e88:	14f57663          	bgeu	a0,a5,80206fd4 <_ZN3PMM10free_pagesEPvi+0x15a>
    {
    80206e8c:	1101                	addi	sp,sp,-32
    80206e8e:	e04a                	sd	s2,0(sp)
        if (pfn >= total_pages)
    80206e90:	00017917          	auipc	s2,0x17
    80206e94:	f5090913          	addi	s2,s2,-176 # 8021dde0 <_ZN3PMM11total_pagesE>
    80206e98:	00093783          	ld	a5,0(s2)
    {
    80206e9c:	ec06                	sd	ra,24(sp)
        uint64 pfn = (pa - KERNBASE) >> PGSHIFT;
    80206e9e:	8131                	srli	a0,a0,0xc
        if (pfn >= total_pages)
    80206ea0:	10f57563          	bgeu	a0,a5,80206faa <_ZN3PMM10free_pagesEPvi+0x130>
    80206ea4:	e426                	sd	s1,8(sp)
        return &mem_map[pfn];
    80206ea6:	00151793          	slli	a5,a0,0x1
    80206eaa:	00893483          	ld	s1,8(s2)
    80206eae:	97aa                	add	a5,a5,a0
    80206eb0:	078e                	slli	a5,a5,0x3
    80206eb2:	e822                	sd	s0,16(sp)
    80206eb4:	94be                	add	s1,s1,a5
            return;
        struct Page *page = pa_to_page((uint64)pa);
        if (!page)
    80206eb6:	c8e5                	beqz	s1,80206fa6 <_ZN3PMM10free_pagesEPvi+0x12c>
            return;
        pmm_lock.acquire();
    80206eb8:	00017517          	auipc	a0,0x17
    80206ebc:	f9050513          	addi	a0,a0,-112 # 8021de48 <_ZN3PMM8pmm_lockE>
    80206ec0:	842e                	mv	s0,a1
    80206ec2:	cbffe0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>

        if (!(page->flags & PG_used))
    80206ec6:	0004c783          	lbu	a5,0(s1)
    80206eca:	8b85                	andi	a5,a5,1
    80206ecc:	c3fd                	beqz	a5,80206fb2 <_ZN3PMM10free_pagesEPvi+0x138>
        // Mark as basic status
        page->flags = 0;
        page->refcnt = 0;

        // try merge
        uint64 page_idx = page - mem_map;
    80206ece:	faaab7b7          	lui	a5,0xfaaab
    80206ed2:	aab78793          	addi	a5,a5,-1365 # fffffffffaaaaaab <kernel_end+0xffffffff7a883aab>
        page->flags = 0;
    80206ed6:	00048023          	sb	zero,0(s1)
        uint64 page_idx = page - mem_map;
    80206eda:	07b2                	slli	a5,a5,0xc
    80206edc:	00893803          	ld	a6,8(s2)
    80206ee0:	aab78793          	addi	a5,a5,-1365
    80206ee4:	07b2                	slli	a5,a5,0xc
    80206ee6:	aab78793          	addi	a5,a5,-1365
    80206eea:	41048633          	sub	a2,s1,a6
    80206eee:	07b2                	slli	a5,a5,0xc
    80206ef0:	860d                	srai	a2,a2,0x3
    80206ef2:	aab78793          	addi	a5,a5,-1365
        page->refcnt = 0;
    80206ef6:	00049123          	sh	zero,2(s1)

        while (order < MAX_ORDER - 1)
    80206efa:	4725                	li	a4,9
        uint64 page_idx = page - mem_map;
    80206efc:	02f60633          	mul	a2,a2,a5
        while (order < MAX_ORDER - 1)
    80206f00:	06874663          	blt	a4,s0,80206f6c <_ZN3PMM10free_pagesEPvi+0xf2>
    80206f04:	00341793          	slli	a5,s0,0x3
    80206f08:	00017597          	auipc	a1,0x17
    80206f0c:	ee858593          	addi	a1,a1,-280 # 8021ddf0 <_ZN3PMM9free_areaE>

            // Check if the Buddy can be merged:
            // 1. Must be within the memory range
            // 2. Must be free (flags == 0)
            // 3. Must be at the current order (to prevent merging already split small blocks)
            if (buddy_idx >= total_pages || (buddy->flags & PG_used) || (buddy->flags & PG_reserved) || buddy->order != order)
    80206f10:	00093303          	ld	t1,0(s2)
    80206f14:	95be                	add	a1,a1,a5
            uint64 buddy_idx = page_idx ^ (1 << order);
    80206f16:	4885                	li	a7,1
        while (order < MAX_ORDER - 1)
    80206f18:	4e29                	li	t3,10
    80206f1a:	a015                	j	80206f3e <_ZN3PMM10free_pagesEPvi+0xc4>
            page->prev->next = page->next;
    80206f1c:	e688                	sd	a0,8(a3)
        if (page->next)
    80206f1e:	6794                	ld	a3,8(a5)
    80206f20:	c299                	beqz	a3,80206f26 <_ZN3PMM10free_pagesEPvi+0xac>
            page->next->prev = page->prev;
    80206f22:	6b88                	ld	a0,16(a5)
    80206f24:	ea88                	sd	a0,16(a3)
        page->next = nullptr;
    80206f26:	0007b423          	sd	zero,8(a5)
        page->prev = nullptr;
    80206f2a:	0007b823          	sd	zero,16(a5)
            // Remove Buddy from the free list
            list_del(buddy, order);

            // Update the current block to the merged block
            // The starting address of the merged block is the smaller one between index and buddy_index
            if (buddy_idx < page_idx)
    80206f2e:	00c77463          	bgeu	a4,a2,80206f36 <_ZN3PMM10free_pagesEPvi+0xbc>
            {
                page = buddy;
                page_idx = buddy_idx;
    80206f32:	863a                	mv	a2,a4
                page = buddy;
    80206f34:	84be                	mv	s1,a5
            }

            order++;
    80206f36:	2405                	addiw	s0,s0,1
        while (order < MAX_ORDER - 1)
    80206f38:	05a1                	addi	a1,a1,8
    80206f3a:	03c40963          	beq	s0,t3,80206f6c <_ZN3PMM10free_pagesEPvi+0xf2>
            uint64 buddy_idx = page_idx ^ (1 << order);
    80206f3e:	0088973b          	sllw	a4,a7,s0
    80206f42:	8f31                	xor	a4,a4,a2
            struct Page *buddy = &mem_map[buddy_idx];
    80206f44:	00171793          	slli	a5,a4,0x1
    80206f48:	97ba                	add	a5,a5,a4
    80206f4a:	078e                	slli	a5,a5,0x3
    80206f4c:	97c2                	add	a5,a5,a6
            if (buddy_idx >= total_pages || (buddy->flags & PG_used) || (buddy->flags & PG_reserved) || buddy->order != order)
    80206f4e:	00677f63          	bgeu	a4,t1,80206f6c <_ZN3PMM10free_pagesEPvi+0xf2>
    80206f52:	0007c683          	lbu	a3,0(a5)
    80206f56:	8a8d                	andi	a3,a3,3
    80206f58:	ea91                	bnez	a3,80206f6c <_ZN3PMM10free_pagesEPvi+0xf2>
    80206f5a:	0017c683          	lbu	a3,1(a5)
    80206f5e:	00869763          	bne	a3,s0,80206f6c <_ZN3PMM10free_pagesEPvi+0xf2>
        if (page->prev)
    80206f62:	6b94                	ld	a3,16(a5)
            page->prev->next = page->next;
    80206f64:	6788                	ld	a0,8(a5)
        if (page->prev)
    80206f66:	fadd                	bnez	a3,80206f1c <_ZN3PMM10free_pagesEPvi+0xa2>
            free_area[order] = page->next;
    80206f68:	e188                	sd	a0,0(a1)
    80206f6a:	bf55                	j	80206f1e <_ZN3PMM10free_pagesEPvi+0xa4>
        page->next = free_area[order];
    80206f6c:	00341793          	slli	a5,s0,0x3
        page->order = order;
    80206f70:	008480a3          	sb	s0,1(s1)
        page->flags = 0; // Mark as available
    80206f74:	00048023          	sb	zero,0(s1)
        page->next = free_area[order];
    80206f78:	00f90733          	add	a4,s2,a5
    80206f7c:	6b14                	ld	a3,16(a4)
        page->prev = nullptr;
    80206f7e:	0004b823          	sd	zero,16(s1)
        page->next = free_area[order];
    80206f82:	e494                	sd	a3,8(s1)
        if (free_area[order])
    80206f84:	6b18                	ld	a4,16(a4)
    80206f86:	c311                	beqz	a4,80206f8a <_ZN3PMM10free_pagesEPvi+0x110>
            free_area[order]->prev = page;
    80206f88:	eb04                	sd	s1,16(a4)
        }

        // Insert into the final order linked list
        list_add(page, order);

        pmm_lock.release();
    80206f8a:	6442                	ld	s0,16(sp)
        free_area[order] = page;
    80206f8c:	993e                	add	s2,s2,a5
    80206f8e:	00993823          	sd	s1,16(s2)
    }
    80206f92:	60e2                	ld	ra,24(sp)
        pmm_lock.release();
    80206f94:	64a2                	ld	s1,8(sp)
    }
    80206f96:	6902                	ld	s2,0(sp)
        pmm_lock.release();
    80206f98:	00017517          	auipc	a0,0x17
    80206f9c:	eb050513          	addi	a0,a0,-336 # 8021de48 <_ZN3PMM8pmm_lockE>
    }
    80206fa0:	6105                	addi	sp,sp,32
        pmm_lock.release();
    80206fa2:	b77fe06f          	j	80205b18 <_ZN8Spinlock7releaseEv>
    80206fa6:	6442                	ld	s0,16(sp)
    80206fa8:	64a2                	ld	s1,8(sp)
    }
    80206faa:	60e2                	ld	ra,24(sp)
    80206fac:	6902                	ld	s2,0(sp)
    80206fae:	6105                	addi	sp,sp,32
    80206fb0:	8082                	ret
            Drivers::uart_puts("PMM: Double free warning\n");
    80206fb2:	0000b517          	auipc	a0,0xb
    80206fb6:	dfe50513          	addi	a0,a0,-514 # 80211db0 <initcode_end+0x668>
    80206fba:	5b1010ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        pmm_lock.release();
    80206fbe:	6442                	ld	s0,16(sp)
    80206fc0:	64a2                	ld	s1,8(sp)
    }
    80206fc2:	60e2                	ld	ra,24(sp)
    80206fc4:	6902                	ld	s2,0(sp)
            pmm_lock.release();
    80206fc6:	00017517          	auipc	a0,0x17
    80206fca:	e8250513          	addi	a0,a0,-382 # 8021de48 <_ZN3PMM8pmm_lockE>
    }
    80206fce:	6105                	addi	sp,sp,32
        pmm_lock.release();
    80206fd0:	b49fe06f          	j	80205b18 <_ZN8Spinlock7releaseEv>
    80206fd4:	8082                	ret

0000000080206fd6 <_ZN3PMM4initEv>:
    {
    80206fd6:	715d                	addi	sp,sp,-80
        pmm_lock.init("pmm");
    80206fd8:	0000b597          	auipc	a1,0xb
    80206fdc:	df858593          	addi	a1,a1,-520 # 80211dd0 <initcode_end+0x688>
    80206fe0:	00017517          	auipc	a0,0x17
    80206fe4:	e6850513          	addi	a0,a0,-408 # 8021de48 <_ZN3PMM8pmm_lockE>
    {
    80206fe8:	e486                	sd	ra,72(sp)
    80206fea:	e0a2                	sd	s0,64(sp)
    80206fec:	fc26                	sd	s1,56(sp)
    80206fee:	f84a                	sd	s2,48(sp)
    80206ff0:	f44e                	sd	s3,40(sp)
    80206ff2:	f052                	sd	s4,32(sp)
    80206ff4:	ec56                	sd	s5,24(sp)
    80206ff6:	e85a                	sd	s6,16(sp)
    80206ff8:	e45e                	sd	s7,8(sp)
    80206ffa:	e062                	sd	s8,0(sp)
        pmm_lock.init("pmm");
    80206ffc:	9dffe0ef          	jal	802059da <_ZN8Spinlock4initEPKc>
    80207000:	00017997          	auipc	s3,0x17
    80207004:	de098993          	addi	s3,s3,-544 # 8021dde0 <_ZN3PMM11total_pagesE>
        total_pages = (PHYSTOP - KERNBASE) / PGSIZE;
    80207008:	67a1                	lui	a5,0x8
        Drivers::uart_puts(ANSI_GREEN "[PMM] Total RAM size: 128MB\n" ANSI_RESET);
    8020700a:	0000b517          	auipc	a0,0xb
    8020700e:	dce50513          	addi	a0,a0,-562 # 80211dd8 <initcode_end+0x690>
        total_pages = (PHYSTOP - KERNBASE) / PGSIZE;
    80207012:	00f9b023          	sd	a5,0(s3)
        Drivers::uart_puts(ANSI_GREEN "[PMM] Total RAM size: 128MB\n" ANSI_RESET);
    80207016:	555010ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        uint64 mem_map_size = total_pages * sizeof(struct Page);
    8020701a:	0009b783          	ld	a5,0(s3)
        uint64 kern_end_pa = PGROUNDUP((uint64)kernel_end);
    8020701e:	6905                	lui	s2,0x1
    80207020:	197d                	addi	s2,s2,-1 # fff <_start-0x801ff001>
    80207022:	0000e497          	auipc	s1,0xe
    80207026:	a864b483          	ld	s1,-1402(s1) # 80214aa8 <_GLOBAL_OFFSET_TABLE_+0x48>
    8020702a:	7a7d                	lui	s4,0xfffff
    8020702c:	94ca                	add	s1,s1,s2
        uint64 mem_map_size = total_pages * sizeof(struct Page);
    8020702e:	00179413          	slli	s0,a5,0x1
        uint64 kern_end_pa = PGROUNDUP((uint64)kernel_end);
    80207032:	0144f4b3          	and	s1,s1,s4
        Drivers::uart_puts(ANSI_GREEN "[PMM] MemMap placed at: " );
    80207036:	0000b517          	auipc	a0,0xb
    8020703a:	dca50513          	addi	a0,a0,-566 # 80211e00 <initcode_end+0x6b8>
        uint64 mem_map_size = total_pages * sizeof(struct Page);
    8020703e:	943e                	add	s0,s0,a5
        mem_map = (struct Page*)kern_end_pa;
    80207040:	0099b423          	sd	s1,8(s3)
        Drivers::uart_puts(ANSI_GREEN "[PMM] MemMap placed at: " );
    80207044:	527010ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        Drivers::print_hex((uint64)mem_map);
    80207048:	0089b503          	ld	a0,8(s3)
        uint64 mem_map_size = total_pages * sizeof(struct Page);
    8020704c:	040e                	slli	s0,s0,0x3
        uint64 free_mem_start = PGROUNDUP(kern_end_pa + mem_map_size);
    8020704e:	944a                	add	s0,s0,s2
        Drivers::print_hex((uint64)mem_map);
    80207050:	683010ef          	jal	80208ed2 <_ZN7Drivers9print_hexEy>
        Drivers::uart_puts("\n" ANSI_RESET);
    80207054:	0000b517          	auipc	a0,0xb
    80207058:	dcc50513          	addi	a0,a0,-564 # 80211e20 <initcode_end+0x6d8>
    8020705c:	50f010ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        Drivers::uart_puts(ANSI_GREEN "[PMM] Free memory starts at: ");
    80207060:	0000b517          	auipc	a0,0xb
    80207064:	dc850513          	addi	a0,a0,-568 # 80211e28 <initcode_end+0x6e0>
        uint64 free_mem_start = PGROUNDUP(kern_end_pa + mem_map_size);
    80207068:	9426                	add	s0,s0,s1
        Drivers::uart_puts(ANSI_GREEN "[PMM] Free memory starts at: ");
    8020706a:	501010ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        uint64 free_mem_start = PGROUNDUP(kern_end_pa + mem_map_size);
    8020706e:	01447433          	and	s0,s0,s4
        Drivers::print_hex(free_mem_start);
    80207072:	8522                	mv	a0,s0
    80207074:	65f010ef          	jal	80208ed2 <_ZN7Drivers9print_hexEy>
        Drivers::uart_puts("\n" ANSI_RESET);
    80207078:	0000b517          	auipc	a0,0xb
    8020707c:	da850513          	addi	a0,a0,-600 # 80211e20 <initcode_end+0x6d8>
    80207080:	4eb010ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        if (free_mem_start >= PHYSTOP)
    80207084:	47c5                	li	a5,17
    80207086:	07ee                	slli	a5,a5,0x1b
    80207088:	0cf47663          	bgeu	s0,a5,80207154 <_ZN3PMM4initEv+0x17e>
        for (uint64 i = 0; i < total_pages; i++)
    8020708c:	0009b683          	ld	a3,0(s3)
    80207090:	c685                	beqz	a3,802070b8 <_ZN3PMM4initEv+0xe2>
    80207092:	00169713          	slli	a4,a3,0x1
    80207096:	0089b783          	ld	a5,8(s3)
    8020709a:	9736                	add	a4,a4,a3
    8020709c:	070e                	slli	a4,a4,0x3
    8020709e:	973e                	add	a4,a4,a5
            mem_map[i].flags = PG_reserved;
    802070a0:	4689                	li	a3,2
    802070a2:	00d79023          	sh	a3,0(a5) # 8000 <_start-0x801f8000>
            mem_map[i].refcnt = 0;
    802070a6:	00079123          	sh	zero,2(a5)
            mem_map[i].next = nullptr;
    802070aa:	0007b423          	sd	zero,8(a5)
            mem_map[i].prev = nullptr;
    802070ae:	0007b823          	sd	zero,16(a5)
        for (uint64 i = 0; i < total_pages; i++)
    802070b2:	07e1                	addi	a5,a5,24
    802070b4:	fee797e3          	bne	a5,a4,802070a2 <_ZN3PMM4initEv+0xcc>
        for (int i = 0; i < MAX_ORDER; i++)
    802070b8:	00017797          	auipc	a5,0x17
    802070bc:	d3878793          	addi	a5,a5,-712 # 8021ddf0 <_ZN3PMM9free_areaE>
    802070c0:	00017717          	auipc	a4,0x17
    802070c4:	d8870713          	addi	a4,a4,-632 # 8021de48 <_ZN3PMM8pmm_lockE>
            free_area[i] = nullptr;
    802070c8:	0007b023          	sd	zero,0(a5)
        for (int i = 0; i < MAX_ORDER; i++)
    802070cc:	07a1                	addi	a5,a5,8
    802070ce:	fef71de3          	bne	a4,a5,802070c8 <_ZN3PMM4initEv+0xf2>
        uint64 dtb_pa_start = PGROUNDDOWN(g_dtb_addr);
    802070d2:	0000e797          	auipc	a5,0xe
    802070d6:	9fe7b783          	ld	a5,-1538(a5) # 80214ad0 <_GLOBAL_OFFSET_TABLE_+0x70>
    802070da:	0007bb03          	ld	s6,0(a5)
        uint64 dtb_pa_end = PGROUNDUP(g_dtb_addr + 0x10000);
    802070de:	6a45                	lui	s4,0x11
    802070e0:	1a7d                	addi	s4,s4,-1 # 10fff <_start-0x801ef001>
        uint64 dtb_pa_start = PGROUNDDOWN(g_dtb_addr);
    802070e2:	77fd                	lui	a5,0xfffff
        uint64 dtb_pa_end = PGROUNDUP(g_dtb_addr + 0x10000);
    802070e4:	9a5a                	add	s4,s4,s6
        while (p < PHYSTOP)
    802070e6:	4bc5                	li	s7,17
    802070e8:	800004b7          	lui	s1,0x80000
        uint64 dtb_pa_start = PGROUNDDOWN(g_dtb_addr);
    802070ec:	00fb7b33          	and	s6,s6,a5
        uint64 dtb_pa_end = PGROUNDUP(g_dtb_addr + 0x10000);
    802070f0:	00fa7a33          	and	s4,s4,a5
        while (p < PHYSTOP)
    802070f4:	94a2                	add	s1,s1,s0
        if (pa < KERNBASE || pa >= PHYSTOP)
    802070f6:	08000c37          	lui	s8,0x8000
                page->flags = PG_used;
    802070fa:	4a85                	li	s5,1
        while (p < PHYSTOP)
    802070fc:	6905                	lui	s2,0x1
    802070fe:	0bee                	slli	s7,s7,0x1b
        uint64 pfn = (pa - KERNBASE) >> PGSHIFT;
    80207100:	00c4d713          	srli	a4,s1,0xc
        return &mem_map[pfn];
    80207104:	00171793          	slli	a5,a4,0x1
    80207108:	97ba                	add	a5,a5,a4
    8020710a:	078e                	slli	a5,a5,0x3
                free_pages((void *)p, 0); // Release page by page, let Buddy merge automatically
    8020710c:	4581                	li	a1,0
    8020710e:	8522                	mv	a0,s0
            if (p >= dtb_pa_start && p < dtb_pa_end)
    80207110:	01646463          	bltu	s0,s6,80207118 <_ZN3PMM4initEv+0x142>
    80207114:	03446063          	bltu	s0,s4,80207134 <_ZN3PMM4initEv+0x15e>
        if (pa < KERNBASE || pa >= PHYSTOP)
    80207118:	0184fe63          	bgeu	s1,s8,80207134 <_ZN3PMM4initEv+0x15e>
        if (pfn >= total_pages)
    8020711c:	0009b683          	ld	a3,0(s3)
    80207120:	00d77a63          	bgeu	a4,a3,80207134 <_ZN3PMM4initEv+0x15e>
        return &mem_map[pfn];
    80207124:	0089b703          	ld	a4,8(s3)
    80207128:	97ba                	add	a5,a5,a4
            if (page)
    8020712a:	c789                	beqz	a5,80207134 <_ZN3PMM4initEv+0x15e>
                page->flags = PG_used;
    8020712c:	01578023          	sb	s5,0(a5) # fffffffffffff000 <kernel_end+0xffffffff7fdd8000>
                free_pages((void *)p, 0); // Release page by page, let Buddy merge automatically
    80207130:	d4bff0ef          	jal	80206e7a <_ZN3PMM10free_pagesEPvi>
        while (p < PHYSTOP)
    80207134:	944a                	add	s0,s0,s2
    80207136:	94ca                	add	s1,s1,s2
    80207138:	fd7464e3          	bltu	s0,s7,80207100 <_ZN3PMM4initEv+0x12a>
    }
    8020713c:	60a6                	ld	ra,72(sp)
    8020713e:	6406                	ld	s0,64(sp)
    80207140:	74e2                	ld	s1,56(sp)
    80207142:	7942                	ld	s2,48(sp)
    80207144:	79a2                	ld	s3,40(sp)
    80207146:	7a02                	ld	s4,32(sp)
    80207148:	6ae2                	ld	s5,24(sp)
    8020714a:	6b42                	ld	s6,16(sp)
    8020714c:	6ba2                	ld	s7,8(sp)
    8020714e:	6c02                	ld	s8,0(sp)
    80207150:	6161                	addi	sp,sp,80
    80207152:	8082                	ret
            Drivers::uart_puts(ANSI_RED "[PMM] Error - Kernel too large, no memory left!\n" ANSI_RESET);
    80207154:	0000b517          	auipc	a0,0xb
    80207158:	cfc50513          	addi	a0,a0,-772 # 80211e50 <initcode_end+0x708>
    8020715c:	40f010ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            while (1)
    80207160:	a001                	j	80207160 <_ZN3PMM4initEv+0x18a>

0000000080207162 <_ZN3PMM10alloc_pageEv>:

    void *alloc_page()
    {
    80207162:	1141                	addi	sp,sp,-16
        void *p = alloc_pages(0);
    80207164:	4501                	li	a0,0
    {
    80207166:	e022                	sd	s0,0(sp)
    80207168:	e406                	sd	ra,8(sp)
        void *p = alloc_pages(0);
    8020716a:	be7ff0ef          	jal	80206d50 <_ZN3PMM11alloc_pagesEi>
    8020716e:	842a                	mv	s0,a0
        if (p)
    80207170:	c509                	beqz	a0,8020717a <_ZN3PMM10alloc_pageEv+0x18>
        {
            memset(p, 0, PGSIZE);
    80207172:	6605                	lui	a2,0x1
    80207174:	4581                	li	a1,0
    80207176:	cb5fd0ef          	jal	80204e2a <_Z6memsetPvij>
        }
        return p;
    }
    8020717a:	60a2                	ld	ra,8(sp)
    8020717c:	8522                	mv	a0,s0
    8020717e:	6402                	ld	s0,0(sp)
    80207180:	0141                	addi	sp,sp,16
    80207182:	8082                	ret

0000000080207184 <_ZN3PMM9free_pageEPv>:

    void free_page(void *pa)
    {
        free_pages(pa, 0);
    80207184:	4581                	li	a1,0
    80207186:	cf5ff06f          	j	80206e7a <_ZN3PMM10free_pagesEPvi>

000000008020718a <_ZN3PMM16print_free_listsEv>:
    }

    void print_free_lists()
    {
    8020718a:	7179                	addi	sp,sp,-48
        // Debug print the number of free blocks at each level
        Drivers::uart_puts("PMM Stats: [ ");
    8020718c:	0000b517          	auipc	a0,0xb
    80207190:	d0450513          	addi	a0,a0,-764 # 80211e90 <initcode_end+0x748>
    {
    80207194:	f022                	sd	s0,32(sp)
    80207196:	ec26                	sd	s1,24(sp)
    80207198:	e84a                	sd	s2,16(sp)
    8020719a:	e44e                	sd	s3,8(sp)
    8020719c:	e052                	sd	s4,0(sp)
    8020719e:	f406                	sd	ra,40(sp)
    802071a0:	00017417          	auipc	s0,0x17
    802071a4:	c5040413          	addi	s0,s0,-944 # 8021ddf0 <_ZN3PMM9free_areaE>
        Drivers::uart_puts("PMM Stats: [ ");
    802071a8:	3c3010ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        for (int i = 0; i < MAX_ORDER; i++)
    802071ac:	00017917          	auipc	s2,0x17
    802071b0:	c9c90913          	addi	s2,s2,-868 # 8021de48 <_ZN3PMM8pmm_lockE>
                count++;
                p = p->next;
            }
            if (count > 0)
            {
                Drivers::uart_puts("Order");
    802071b4:	0000b497          	auipc	s1,0xb
    802071b8:	cec48493          	addi	s1,s1,-788 # 80211ea0 <initcode_end+0x758>
                // Drivers::uart_put_int(i);
                Drivers::uart_puts(":");
    802071bc:	0000ba17          	auipc	s4,0xb
    802071c0:	ceca0a13          	addi	s4,s4,-788 # 80211ea8 <initcode_end+0x760>
                // Drivers::uart_put_int(count);
                Drivers::uart_puts(" ");
    802071c4:	0000b997          	auipc	s3,0xb
    802071c8:	cec98993          	addi	s3,s3,-788 # 80211eb0 <initcode_end+0x768>
            while (p)
    802071cc:	601c                	ld	a5,0(s0)
                Drivers::uart_puts("Order");
    802071ce:	8526                	mv	a0,s1
            while (p)
    802071d0:	cb89                	beqz	a5,802071e2 <_ZN3PMM16print_free_listsEv+0x58>
                Drivers::uart_puts("Order");
    802071d2:	399010ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
                Drivers::uart_puts(":");
    802071d6:	8552                	mv	a0,s4
    802071d8:	393010ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
                Drivers::uart_puts(" ");
    802071dc:	854e                	mv	a0,s3
    802071de:	38d010ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        for (int i = 0; i < MAX_ORDER; i++)
    802071e2:	0421                	addi	s0,s0,8
    802071e4:	fe8914e3          	bne	s2,s0,802071cc <_ZN3PMM16print_free_listsEv+0x42>
            }
        }
        Drivers::uart_puts("]\n");
    }
    802071e8:	7402                	ld	s0,32(sp)
    802071ea:	70a2                	ld	ra,40(sp)
    802071ec:	64e2                	ld	s1,24(sp)
    802071ee:	6942                	ld	s2,16(sp)
    802071f0:	69a2                	ld	s3,8(sp)
    802071f2:	6a02                	ld	s4,0(sp)
        Drivers::uart_puts("]\n");
    802071f4:	0000b517          	auipc	a0,0xb
    802071f8:	cc450513          	addi	a0,a0,-828 # 80211eb8 <initcode_end+0x770>
    }
    802071fc:	6145                	addi	sp,sp,48
        Drivers::uart_puts("]\n");
    802071fe:	36d0106f          	j	80208d6a <_ZN7Drivers9uart_putsEPKc>

0000000080207202 <_GLOBAL__sub_I__ZN3PMM7mem_mapE>:
    80207202:	00017797          	auipc	a5,0x17
    80207206:	bde78793          	addi	a5,a5,-1058 # 8021dde0 <_ZN3PMM11total_pagesE>
    8020720a:	0000a717          	auipc	a4,0xa
    8020720e:	57e70713          	addi	a4,a4,1406 # 80211788 <initcode_end+0x40>
    80207212:	0607a423          	sw	zero,104(a5)
    80207216:	fbb8                	sd	a4,112(a5)
    80207218:	0607bc23          	sd	zero,120(a5)
} // namespace PMM
    8020721c:	8082                	ret

000000008020721e <_ZN5Timer8get_timeEv>:
    Spinlock tickslock;

    uint64 get_time()
    {
        uint64 time;
        asm volatile("rdtime %0" : "=r"(time));
    8020721e:	c0102573          	rdtime	a0
        return time;
    }
    80207222:	8082                	ret

0000000080207224 <_ZN5Timer16set_next_triggerEv>:
        asm volatile("rdtime %0" : "=r"(time));
    80207224:	c0102573          	rdtime	a0

    void set_next_trigger()
    {
        SBI::set_timer(get_time() + INTERVAL);
    80207228:	000f47b7          	lui	a5,0xf4
    8020722c:	24078793          	addi	a5,a5,576 # f4240 <_start-0x8010bdc0>
    80207230:	953e                	add	a0,a0,a5
    80207232:	d6dfd06f          	j	80204f9e <_ZN3SBI9set_timerEy>

0000000080207236 <_ZN5Timer4initEv>:
    }

    void init()
    {
    80207236:	1141                	addi	sp,sp,-16
    80207238:	e406                	sd	ra,8(sp)
        asm volatile("rdtime %0" : "=r"(time));
    8020723a:	c0102573          	rdtime	a0
        SBI::set_timer(get_time() + INTERVAL);
    8020723e:	000f47b7          	lui	a5,0xf4
    80207242:	24078793          	addi	a5,a5,576 # f4240 <_start-0x8010bdc0>
    80207246:	953e                	add	a0,a0,a5
    80207248:	d57fd0ef          	jal	80204f9e <_ZN3SBI9set_timerEy>
        set_next_trigger();

        uint64 sie;
        asm volatile("csrr %0, sie" : "=r"(sie));
    8020724c:	104027f3          	csrr	a5,sie
        sie |= (1L << 5);
    80207250:	0207e793          	ori	a5,a5,32
        asm volatile("csrw sie, %0" : : "r"(sie));
    80207254:	10479073          	csrw	sie,a5
    }
    80207258:	60a2                	ld	ra,8(sp)
    8020725a:	0141                	addi	sp,sp,16
    8020725c:	8082                	ret

000000008020725e <_ZN5Timer4tickEv>:

    void tick()
    {
    8020725e:	1141                	addi	sp,sp,-16
    80207260:	e022                	sd	s0,0(sp)
        tickslock.acquire();
    80207262:	00017417          	auipc	s0,0x17
    80207266:	bfe40413          	addi	s0,s0,-1026 # 8021de60 <_ZN5Timer9tickslockE>
    8020726a:	8522                	mv	a0,s0
    {
    8020726c:	e406                	sd	ra,8(sp)
        tickslock.acquire();
    8020726e:	913fe0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        ticks++;
    80207272:	6c1c                	ld	a5,24(s0)
        ProcManager::wakeup(&ticks);
    80207274:	00017517          	auipc	a0,0x17
    80207278:	c0450513          	addi	a0,a0,-1020 # 8021de78 <_ZN5Timer5ticksE>
        ticks++;
    8020727c:	0785                	addi	a5,a5,1
    8020727e:	ec1c                	sd	a5,24(s0)
        ProcManager::wakeup(&ticks);
    80207280:	5cb000ef          	jal	8020804a <_ZN11ProcManager6wakeupEPv>
        tickslock.release();
    80207284:	8522                	mv	a0,s0
    80207286:	893fe0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
        asm volatile("rdtime %0" : "=r"(time));
    8020728a:	c0102573          	rdtime	a0
        set_next_trigger();
    }
    8020728e:	6402                	ld	s0,0(sp)
    80207290:	60a2                	ld	ra,8(sp)
        SBI::set_timer(get_time() + INTERVAL);
    80207292:	000f47b7          	lui	a5,0xf4
    80207296:	24078793          	addi	a5,a5,576 # f4240 <_start-0x8010bdc0>
    8020729a:	953e                	add	a0,a0,a5
    }
    8020729c:	0141                	addi	sp,sp,16
        SBI::set_timer(get_time() + INTERVAL);
    8020729e:	d01fd06f          	j	80204f9e <_ZN3SBI9set_timerEy>

00000000802072a2 <_ZN5Timer9get_ticksEv>:

    uint64 get_ticks()
    {
    802072a2:	1141                	addi	sp,sp,-16
    802072a4:	e022                	sd	s0,0(sp)
        tickslock.acquire();
    802072a6:	00017417          	auipc	s0,0x17
    802072aa:	bba40413          	addi	s0,s0,-1094 # 8021de60 <_ZN5Timer9tickslockE>
    802072ae:	8522                	mv	a0,s0
    {
    802072b0:	e406                	sd	ra,8(sp)
        tickslock.acquire();
    802072b2:	8cffe0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        uint64 t = ticks;
        tickslock.release();
    802072b6:	8522                	mv	a0,s0
        uint64 t = ticks;
    802072b8:	6c00                	ld	s0,24(s0)
        tickslock.release();
    802072ba:	85ffe0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
        return t;
    }
    802072be:	60a2                	ld	ra,8(sp)
    802072c0:	8522                	mv	a0,s0
    802072c2:	6402                	ld	s0,0(sp)
    802072c4:	0141                	addi	sp,sp,16
    802072c6:	8082                	ret

00000000802072c8 <_ZN5Timer8get_lockEv>:

    Spinlock *get_lock()
    {
        return &tickslock;
    }
    802072c8:	00017517          	auipc	a0,0x17
    802072cc:	b9850513          	addi	a0,a0,-1128 # 8021de60 <_ZN5Timer9tickslockE>
    802072d0:	8082                	ret

00000000802072d2 <_ZN5Timer13get_tick_chanEv>:

    void *get_tick_chan()
    {
        return &ticks;
    }
    802072d2:	00017517          	auipc	a0,0x17
    802072d6:	ba650513          	addi	a0,a0,-1114 # 8021de78 <_ZN5Timer5ticksE>
    802072da:	8082                	ret

00000000802072dc <_GLOBAL__sub_I__ZN5Timer5ticksE>:
    802072dc:	00017797          	auipc	a5,0x17
    802072e0:	b8478793          	addi	a5,a5,-1148 # 8021de60 <_ZN5Timer9tickslockE>
    802072e4:	0000a717          	auipc	a4,0xa
    802072e8:	4a470713          	addi	a4,a4,1188 # 80211788 <initcode_end+0x40>
    802072ec:	0007a023          	sw	zero,0(a5)
    802072f0:	e798                	sd	a4,8(a5)
    802072f2:	0007b823          	sd	zero,16(a5)
    802072f6:	8082                	ret

00000000802072f8 <_ZN4Exec4execEPcPS0_>:
}

namespace Exec
{
    int exec(char *path, char **argv)
    {
    802072f8:	df010113          	addi	sp,sp,-528
    802072fc:	20113423          	sd	ra,520(sp)
    80207300:	ffa6                	sd	s1,504(sp)
    80207302:	ec2a                	sd	a0,24(sp)
    80207304:	e42e                	sd	a1,8(sp)
        // Get Inode
        Inode *raw_ip = VFS::namei(path);
    80207306:	8abfd0ef          	jal	80204bb0 <_ZN3VFS5nameiEPKc>
        if (!raw_ip)
    8020730a:	2c050563          	beqz	a0,802075d4 <_ZN4Exec4execEPcPS0_+0x2dc>
            return -1;
        InodeGuard iguard(raw_ip);
    8020730e:	20813023          	sd	s0,512(sp)
    80207312:	842a                	mv	s0,a0
            VFS::ilock(ip);
    80207314:	f4cfd0ef          	jal	80204a60 <_ZN3VFS5ilockEP5Inode>

        // Get ELF head
        struct elfhdr elf;
        if (raw_ip->read((char *)&elf, 0, sizeof(elf), 0) != sizeof(elf))
    80207318:	601c                	ld	a5,0(s0)
    8020731a:	4701                	li	a4,0
    8020731c:	04000693          	li	a3,64
    80207320:	6f9c                	ld	a5,24(a5)
    80207322:	4601                	li	a2,0
    80207324:	108c                	addi	a1,sp,96
    80207326:	8522                	mv	a0,s0
    80207328:	9782                	jalr	a5
    8020732a:	04000793          	li	a5,64
            return -1;
    8020732e:	54fd                	li	s1,-1
        if (raw_ip->read((char *)&elf, 0, sizeof(elf), 0) != sizeof(elf))
    80207330:	00f50e63          	beq	a0,a5,8020734c <_ZN4Exec4execEPcPS0_+0x54>
            VFS::iunlockput(ip); // Automatically unlock and release references
    80207334:	8522                	mv	a0,s0
    80207336:	f84fd0ef          	jal	80204aba <_ZN3VFS10iunlockputEP5Inode>
    }
    8020733a:	20013403          	ld	s0,512(sp)
        VM::uvmfree(oldpagetable, oldsz);

        asm volatile("fence.i");

        return 0; // iguard unlocks and releases IP upon destruction
    }
    8020733e:	20813083          	ld	ra,520(sp)
    80207342:	8526                	mv	a0,s1
    80207344:	74fe                	ld	s1,504(sp)
    80207346:	21010113          	addi	sp,sp,528
    8020734a:	8082                	ret
        if (elf.magic != ELF_MAGIC)
    8020734c:	5706                	lw	a4,96(sp)
    8020734e:	464c47b7          	lui	a5,0x464c4
    80207352:	57f78793          	addi	a5,a5,1407 # 464c457f <_start-0x39d3ba81>
    80207356:	fcf71fe3          	bne	a4,a5,80207334 <_ZN4Exec4execEPcPS0_+0x3c>
    8020735a:	f3d2                	sd	s4,480(sp)
    VmGuard() : pagetable(VM::uvmcreate()) {}
    8020735c:	e03fe0ef          	jal	8020615e <_ZN2VM9uvmcreateEv>
    80207360:	8a2a                	mv	s4,a0
        if (!vm_guard.pagetable)
    80207362:	c56d                	beqz	a0,8020744c <_ZN4Exec4execEPcPS0_+0x154>
        for (int i = 0; i < elf.phnum; i++)
    80207364:	09815783          	lhu	a5,152(sp)
    80207368:	fbca                	sd	s2,496(sp)
    8020736a:	f7ce                	sd	s3,488(sp)
    8020736c:	efd6                	sd	s5,472(sp)
    8020736e:	ebda                	sd	s6,464(sp)
    80207370:	e7de                	sd	s7,456(sp)
    80207372:	e3e2                	sd	s8,448(sp)
    80207374:	26078263          	beqz	a5,802075d8 <_ZN4Exec4execEPcPS0_+0x2e0>
        uint64 n = PGSIZE - (va + i) % PGSIZE;
    80207378:	6905                	lui	s2,0x1
    8020737a:	103c                	addi	a5,sp,40
    8020737c:	ff66                	sd	s9,440(sp)
    8020737e:	fb6a                	sd	s10,432(sp)
    80207380:	f76e                	sd	s11,424(sp)
        for (int i = 0; i < elf.phnum; i++)
    80207382:	4c01                	li	s8,0
    VmGuard() : pagetable(VM::uvmcreate()) {}
    80207384:	4481                	li	s1,0
        for (int i = 0; i < elf.phnum; i++)
    80207386:	4c81                	li	s9,0
    80207388:	e03e                	sd	a5,0(sp)
        uint64 n = PGSIZE - (va + i) % PGSIZE;
    8020738a:	fff90b93          	addi	s7,s2,-1 # fff <_start-0x801ff001>
            if (raw_ip->read((char *)&ph, off, sizeof(ph), 0) != sizeof(ph))
    8020738e:	601c                	ld	a5,0(s0)
    80207390:	660a                	ld	a2,128(sp)
    80207392:	6582                	ld	a1,0(sp)
    80207394:	6f9c                	ld	a5,24(a5)
    80207396:	4701                	li	a4,0
    80207398:	03800693          	li	a3,56
    8020739c:	00cc063b          	addw	a2,s8,a2
    802073a0:	8522                	mv	a0,s0
    802073a2:	9782                	jalr	a5
    802073a4:	03800793          	li	a5,56
    802073a8:	22f51163          	bne	a0,a5,802075ca <_ZN4Exec4execEPcPS0_+0x2d2>
            if (ph.type != ELF_PROG_LOAD)
    802073ac:	57a2                	lw	a5,40(sp)
    802073ae:	4705                	li	a4,1
    802073b0:	0ae79263          	bne	a5,a4,80207454 <_ZN4Exec4execEPcPS0_+0x15c>
            if (ph.memsz < ph.filesz)
    802073b4:	67c6                	ld	a5,80(sp)
    802073b6:	6726                	ld	a4,72(sp)
    802073b8:	20e7e963          	bltu	a5,a4,802075ca <_ZN4Exec4execEPcPS0_+0x2d2>
            if (ph.vaddr + ph.memsz < ph.vaddr)
    802073bc:	7662                	ld	a2,56(sp)
    802073be:	963e                	add	a2,a2,a5
    802073c0:	20f66563          	bltu	a2,a5,802075ca <_ZN4Exec4execEPcPS0_+0x2d2>
            uint64 sz1 = VM::uvmalloc(vm_guard.pagetable, vm_guard.sz, ph.vaddr + ph.memsz, PTE_W | PTE_X | PTE_R | PTE_U);
    802073c4:	46f9                	li	a3,30
    802073c6:	85a6                	mv	a1,s1
    802073c8:	8552                	mv	a0,s4
    802073ca:	e51fe0ef          	jal	8020621a <_ZN2VM8uvmallocEPyyyi>
    802073ce:	e82a                	sd	a0,16(sp)
    802073d0:	4d81                	li	s11,0
            if (sz1 == 0)
    802073d2:	1e050c63          	beqz	a0,802075ca <_ZN4Exec4execEPcPS0_+0x2d2>
            if (loadseg(vm_guard.pagetable, ph.vaddr, raw_ip, ph.off, ph.filesz) < 0)
    802073d6:	64a6                	ld	s1,72(sp)
    802073d8:	7ae2                	ld	s5,56(sp)
    802073da:	7b42                	ld	s6,48(sp)
    for (uint64 i = 0; i < sz; i += PGSIZE)
    802073dc:	c8bd                	beqz	s1,80207452 <_ZN4Exec4execEPcPS0_+0x15a>
        if (i + n > sz)
    802073de:	017af9b3          	and	s3,s5,s7
    802073e2:	413909b3          	sub	s3,s2,s3
    802073e6:	a805                	j	80207416 <_ZN4Exec4execEPcPS0_+0x11e>
        uint64 n = PGSIZE - (va + i) % PGSIZE;
    802073e8:	017d7833          	and	a6,s10,s7
        if (ip->read((char *)(pa + (va + i) % PGSIZE), offset + i, n, 0) != (int)n)
    802073ec:	010685b3          	add	a1,a3,a6
            n = sz - i;
    802073f0:	41b486b3          	sub	a3,s1,s11
        if (i + n > sz)
    802073f4:	0114e463          	bltu	s1,a7,802073fc <_ZN4Exec4execEPcPS0_+0x104>
        uint64 n = PGSIZE - (va + i) % PGSIZE;
    802073f8:	410906b3          	sub	a3,s2,a6
        if (ip->read((char *)(pa + (va + i) % PGSIZE), offset + i, n, 0) != (int)n)
    802073fc:	00043803          	ld	a6,0(s0)
    80207400:	00068d1b          	sext.w	s10,a3
    80207404:	86ea                	mv	a3,s10
    80207406:	01883803          	ld	a6,24(a6)
    for (uint64 i = 0; i < sz; i += PGSIZE)
    8020740a:	9dca                	add	s11,s11,s2
        if (ip->read((char *)(pa + (va + i) % PGSIZE), offset + i, n, 0) != (int)n)
    8020740c:	9802                	jalr	a6
    8020740e:	03a51263          	bne	a0,s10,80207432 <_ZN4Exec4execEPcPS0_+0x13a>
    for (uint64 i = 0; i < sz; i += PGSIZE)
    80207412:	049df063          	bgeu	s11,s1,80207452 <_ZN4Exec4execEPcPS0_+0x15a>
        uint64 pa = VM::walkaddr(pagetable, va + i);
    80207416:	01ba8d33          	add	s10,s5,s11
    8020741a:	85ea                	mv	a1,s10
    8020741c:	8552                	mv	a0,s4
    8020741e:	c96ff0ef          	jal	802068b4 <_ZN2VM8walkaddrEPyy>
    80207422:	86aa                	mv	a3,a0
        if (ip->read((char *)(pa + (va + i) % PGSIZE), offset + i, n, 0) != (int)n)
    80207424:	4701                	li	a4,0
    80207426:	01bb063b          	addw	a2,s6,s11
    8020742a:	8522                	mv	a0,s0
        if (i + n > sz)
    8020742c:	01b988b3          	add	a7,s3,s11
        if (pa == 0)
    80207430:	fec5                	bnez	a3,802073e8 <_ZN4Exec4execEPcPS0_+0xf0>
    80207432:	7cfa                	ld	s9,440(sp)
    80207434:	7d5a                	ld	s10,432(sp)
    80207436:	7dba                	ld	s11,424(sp)
            VM::uvmfree(pagetable, sz);
    80207438:	65c2                	ld	a1,16(sp)
    8020743a:	8552                	mv	a0,s4
    8020743c:	f03fe0ef          	jal	8020633e <_ZN2VM7uvmfreeEPyy>
    80207440:	795e                	ld	s2,496(sp)
    80207442:	79be                	ld	s3,488(sp)
    80207444:	6afe                	ld	s5,472(sp)
    80207446:	6b5e                	ld	s6,464(sp)
    80207448:	6bbe                	ld	s7,456(sp)
    8020744a:	6c1e                	ld	s8,448(sp)
    8020744c:	7a1e                	ld	s4,480(sp)
        size_t len = 0;
    8020744e:	54fd                	li	s1,-1
    80207450:	b5d5                	j	80207334 <_ZN4Exec4execEPcPS0_+0x3c>
            vm_guard.sz = sz1;
    80207452:	64c2                	ld	s1,16(sp)
        for (int i = 0; i < elf.phnum; i++)
    80207454:	09815783          	lhu	a5,152(sp)
    80207458:	2c85                	addiw	s9,s9,1
    8020745a:	038c0c13          	addi	s8,s8,56 # 8000038 <_start-0x781fffc8>
    8020745e:	f2fcc8e3          	blt	s9,a5,8020738e <_ZN4Exec4execEPcPS0_+0x96>
        uint64 sz = PGROUNDUP(vm_guard.sz);
    80207462:	6905                	lui	s2,0x1
    80207464:	197d                	addi	s2,s2,-1 # fff <_start-0x801ff001>
    80207466:	9926                	add	s2,s2,s1
    80207468:	77fd                	lui	a5,0xfffff
    8020746a:	7cfa                	ld	s9,440(sp)
    8020746c:	7d5a                	ld	s10,432(sp)
    8020746e:	7dba                	ld	s11,424(sp)
    80207470:	00f97933          	and	s2,s2,a5
        uint64 sz1 = VM::uvmalloc(vm_guard.pagetable, sz, sz + stack_total_pages * PGSIZE, PTE_W | PTE_R | PTE_U);
    80207474:	6645                	lui	a2,0x11
    80207476:	964a                	add	a2,a2,s2
    80207478:	46d9                	li	a3,22
    8020747a:	85ca                	mv	a1,s2
    8020747c:	8552                	mv	a0,s4
    8020747e:	d9dfe0ef          	jal	8020621a <_ZN2VM8uvmallocEPyyyi>
    80207482:	e82a                	sd	a0,16(sp)
    80207484:	8aaa                	mv	s5,a0
        if (sz1 == 0)
    80207486:	8b2a                	mv	s6,a0
    80207488:	c941                	beqz	a0,80207518 <_ZN4Exec4execEPcPS0_+0x220>
        VM::uvmunmap(vm_guard.pagetable, sz, 1, 0); // protected pagetable
    8020748a:	8552                	mv	a0,s4
    8020748c:	4681                	li	a3,0
    8020748e:	4605                	li	a2,1
    80207490:	85ca                	mv	a1,s2
    80207492:	ea1fe0ef          	jal	80206332 <_ZN2VM8uvmunmapEPyyyi>
        for (; argv[argc]; argc++)
    80207496:	67a2                	ld	a5,8(sp)
        uint64 stackbase = sp - stack_data_pages * PGSIZE;
    80207498:	79c1                	lui	s3,0xffff0
    8020749a:	99d6                	add	s3,s3,s5
        for (; argv[argc]; argc++)
    8020749c:	6388                	ld	a0,0(a5)
    8020749e:	14050163          	beqz	a0,802075e0 <_ZN4Exec4execEPcPS0_+0x2e8>
    802074a2:	1104                	addi	s1,sp,160
    802074a4:	19810a93          	addi	s5,sp,408
        uint64 argc = 0;
    802074a8:	4901                	li	s2,0
    802074aa:	a019                	j	802074b0 <_ZN4Exec4execEPcPS0_+0x1b8>
            if (argc >= 31)
    802074ac:	f89a86e3          	beq	s5,s1,80207438 <_ZN4Exec4execEPcPS0_+0x140>
            sp -= strlen(argv[argc]) + 1;
    802074b0:	a3dfd0ef          	jal	80204eec <_Z6strlenPKc>
    802074b4:	0015079b          	addiw	a5,a0,1
    802074b8:	40fb07b3          	sub	a5,s6,a5
            sp -= sp % 16;
    802074bc:	ff07fb13          	andi	s6,a5,-16
            if (sp < stackbase)
    802074c0:	f73b6ce3          	bltu	s6,s3,80207438 <_ZN4Exec4execEPcPS0_+0x140>
            if (VM::copyout(vm_guard.pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    802074c4:	6c22                	ld	s8,8(sp)
    802074c6:	000c3b83          	ld	s7,0(s8)
    802074ca:	855e                	mv	a0,s7
    802074cc:	a21fd0ef          	jal	80204eec <_Z6strlenPKc>
    802074d0:	0015069b          	addiw	a3,a0,1
    802074d4:	865e                	mv	a2,s7
    802074d6:	85da                	mv	a1,s6
    802074d8:	8552                	mv	a0,s4
    802074da:	9c8ff0ef          	jal	802066a2 <_ZN2VM7copyoutEPyyPcy>
        for (; argv[argc]; argc++)
    802074de:	008c0793          	addi	a5,s8,8
    802074e2:	e43e                	sd	a5,8(sp)
            if (VM::copyout(vm_guard.pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    802074e4:	f4054ae3          	bltz	a0,80207438 <_ZN4Exec4execEPcPS0_+0x140>
        for (; argv[argc]; argc++)
    802074e8:	008c3503          	ld	a0,8(s8)
            ustack[argc] = sp;
    802074ec:	0164b023          	sd	s6,0(s1)
        for (; argv[argc]; argc++)
    802074f0:	0905                	addi	s2,s2,1
            if (argc >= 31)
    802074f2:	04a1                	addi	s1,s1,8
        for (; argv[argc]; argc++)
    802074f4:	fd45                	bnez	a0,802074ac <_ZN4Exec4execEPcPS0_+0x1b4>
        sp -= (argc + 1) * sizeof(uint64);
    802074f6:	00190693          	addi	a3,s2,1
        ustack[argc] = 0;
    802074fa:	00391793          	slli	a5,s2,0x3
        sp -= (argc + 1) * sizeof(uint64);
    802074fe:	068e                	slli	a3,a3,0x3
        ustack[argc] = 0;
    80207500:	18078793          	addi	a5,a5,384 # fffffffffffff180 <kernel_end+0xffffffff7fdd8180>
    80207504:	1018                	addi	a4,sp,32
    80207506:	97ba                	add	a5,a5,a4
        sp -= (argc + 1) * sizeof(uint64);
    80207508:	40db04b3          	sub	s1,s6,a3
        ustack[argc] = 0;
    8020750c:	f007b023          	sd	zero,-256(a5)
        sp -= sp % 16;
    80207510:	98c1                	andi	s1,s1,-16
        if (sp < stackbase)
    80207512:	0134f563          	bgeu	s1,s3,8020751c <_ZN4Exec4execEPcPS0_+0x224>
        vm_guard.sz = sz1;
    80207516:	64c2                	ld	s1,16(sp)
        size_t len = 0;
    80207518:	e826                	sd	s1,16(sp)
    8020751a:	bf39                	j	80207438 <_ZN4Exec4execEPcPS0_+0x140>
        if (VM::copyout(vm_guard.pagetable, sp, (char *)ustack, (argc + 1) * sizeof(uint64)) < 0)
    8020751c:	1110                	addi	a2,sp,160
    8020751e:	85a6                	mv	a1,s1
    80207520:	8552                	mv	a0,s4
    80207522:	980ff0ef          	jal	802066a2 <_ZN2VM7copyoutEPyyPcy>
    80207526:	fe0548e3          	bltz	a0,80207516 <_ZN4Exec4execEPcPS0_+0x21e>
        struct Proc *p = myproc();
    8020752a:	d58fe0ef          	jal	80205a82 <_Z6myprocv>
        if (VM::mappages(vm_guard.pagetable, TRAPFRAME, PGSIZE, (uint64)p->tf, PTE_R | PTE_W) < 0)
    8020752e:	7934                	ld	a3,112(a0)
    80207530:	020005b7          	lui	a1,0x2000
    80207534:	15fd                	addi	a1,a1,-1 # 1ffffff <_start-0x7e200001>
        struct Proc *p = myproc();
    80207536:	89aa                	mv	s3,a0
        if (VM::mappages(vm_guard.pagetable, TRAPFRAME, PGSIZE, (uint64)p->tf, PTE_R | PTE_W) < 0)
    80207538:	4719                	li	a4,6
    8020753a:	6605                	lui	a2,0x1
    8020753c:	05b6                	slli	a1,a1,0xd
    8020753e:	8552                	mv	a0,s4
    80207540:	ba7fe0ef          	jal	802060e6 <_ZN2VM8mappagesEPyyyyi>
    80207544:	fc0549e3          	bltz	a0,80207516 <_ZN4Exec4execEPcPS0_+0x21e>
        p->tf->a0 = argc;
    80207548:	0709b783          	ld	a5,112(s3) # ffffffffffff0070 <kernel_end+0xffffffff7fdc9070>
        p->tf->epc = elf.entry;
    8020754c:	7766                	ld	a4,120(sp)
        while (*s)
    8020754e:	66e2                	ld	a3,24(sp)
        uint64 oldsz = p->sz;
    80207550:	0a09b583          	ld	a1,160(s3)
        uint64 *oldpagetable = p->pagetable;
    80207554:	0789b503          	ld	a0,120(s3)
        p->tf->a0 = argc;
    80207558:	0727b823          	sd	s2,112(a5)
        p->tf->a1 = sp;
    8020755c:	ffa4                	sd	s1,120(a5)
        p->tf->sp = sp;
    8020755e:	fb84                	sd	s1,48(a5)
        p->tf->epc = elf.entry;
    80207560:	ef98                	sd	a4,24(a5)
        while (*s)
    80207562:	0006c783          	lbu	a5,0(a3)
    80207566:	c3c1                	beqz	a5,802075e6 <_ZN4Exec4execEPcPS0_+0x2ee>
            if (*s == '/')
    80207568:	02f00713          	li	a4,47
                last = s + 1;
    8020756c:	6662                	ld	a2,24(sp)
    8020756e:	0605                	addi	a2,a2,1 # 1001 <_start-0x801fefff>
    80207570:	ec32                	sd	a2,24(sp)
            if (*s == '/')
    80207572:	00e79363          	bne	a5,a4,80207578 <_ZN4Exec4execEPcPS0_+0x280>
                last = s + 1;
    80207576:	86b2                	mv	a3,a2
        while (*s)
    80207578:	67e2                	ld	a5,24(sp)
    8020757a:	0007c783          	lbu	a5,0(a5)
    8020757e:	f7fd                	bnez	a5,8020756c <_ZN4Exec4execEPcPS0_+0x274>
        while (last[len] && len < sizeof(p->name) - 1)
    80207580:	0006c703          	lbu	a4,0(a3)
    80207584:	c32d                	beqz	a4,802075e6 <_ZN4Exec4execEPcPS0_+0x2ee>
    80207586:	463d                	li	a2,15
            p->name[len] = last[len];
    80207588:	00f98833          	add	a6,s3,a5
            len++;
    8020758c:	0785                	addi	a5,a5,1
            p->name[len] = last[len];
    8020758e:	08e80823          	sb	a4,144(a6)
        while (last[len] && len < sizeof(p->name) - 1)
    80207592:	00f68733          	add	a4,a3,a5
    80207596:	00074703          	lbu	a4,0(a4)
    8020759a:	c319                	beqz	a4,802075a0 <_ZN4Exec4execEPcPS0_+0x2a8>
    8020759c:	fec796e3          	bne	a5,a2,80207588 <_ZN4Exec4execEPcPS0_+0x290>
        p->name[len] = '\0';
    802075a0:	97ce                	add	a5,a5,s3
    802075a2:	08078823          	sb	zero,144(a5)
        p->sz = vm_guard.sz;
    802075a6:	67c2                	ld	a5,16(sp)
        p->pagetable = vm_guard.commit();
    802075a8:	0749bc23          	sd	s4,120(s3)
        p->sz = vm_guard.sz;
    802075ac:	0af9b023          	sd	a5,160(s3)
        VM::uvmfree(oldpagetable, oldsz);
    802075b0:	d8ffe0ef          	jal	8020633e <_ZN2VM7uvmfreeEPyy>
        asm volatile("fence.i");
    802075b4:	0000100f          	fence.i
        return 0; // iguard unlocks and releases IP upon destruction
    802075b8:	4481                	li	s1,0
    802075ba:	795e                	ld	s2,496(sp)
    802075bc:	79be                	ld	s3,488(sp)
    802075be:	7a1e                	ld	s4,480(sp)
    802075c0:	6afe                	ld	s5,472(sp)
    802075c2:	6b5e                	ld	s6,464(sp)
    802075c4:	6bbe                	ld	s7,456(sp)
    802075c6:	6c1e                	ld	s8,448(sp)
    802075c8:	b3b5                	j	80207334 <_ZN4Exec4execEPcPS0_+0x3c>
        size_t len = 0;
    802075ca:	7cfa                	ld	s9,440(sp)
    802075cc:	7d5a                	ld	s10,432(sp)
    802075ce:	7dba                	ld	s11,424(sp)
    802075d0:	e826                	sd	s1,16(sp)
        if (pagetable)
    802075d2:	b59d                	j	80207438 <_ZN4Exec4execEPcPS0_+0x140>
            return -1;
    802075d4:	54fd                	li	s1,-1
    802075d6:	b3a5                	j	8020733e <_ZN4Exec4execEPcPS0_+0x46>
        for (int i = 0; i < elf.phnum; i++)
    802075d8:	6645                	lui	a2,0x11
    802075da:	4901                	li	s2,0
    VmGuard() : pagetable(VM::uvmcreate()) {}
    802075dc:	4481                	li	s1,0
    802075de:	bd69                	j	80207478 <_ZN4Exec4execEPcPS0_+0x180>
        uint64 sp = sz1;
    802075e0:	6b42                	ld	s6,16(sp)
        uint64 argc = 0;
    802075e2:	4901                	li	s2,0
    802075e4:	bf09                	j	802074f6 <_ZN4Exec4execEPcPS0_+0x1fe>
        size_t len = 0;
    802075e6:	4781                	li	a5,0
    802075e8:	bf65                	j	802075a0 <_ZN4Exec4execEPcPS0_+0x2a8>

00000000802075ea <_ZL9allocprocv>:
}

//  ProcManager Implementation

static Proc *allocproc()
{
    802075ea:	1101                	addi	sp,sp,-32
    802075ec:	e426                	sd	s1,8(sp)
    struct Proc *p;
    proc_mem_lock.acquire();
    802075ee:	00017497          	auipc	s1,0x17
    802075f2:	89248493          	addi	s1,s1,-1902 # 8021de80 <proc_mem_lock>
    802075f6:	8526                	mv	a0,s1
{
    802075f8:	ec06                	sd	ra,24(sp)
    802075fa:	e822                	sd	s0,16(sp)
    proc_mem_lock.acquire();
    802075fc:	d84fe0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>

    p = (struct Proc *)Slab::kmalloc(sizeof(struct Proc));
    80207600:	17800513          	li	a0,376
    80207604:	b64ff0ef          	jal	80206968 <_ZN4Slab7kmallocEy>

    if (!p)
    80207608:	0e050e63          	beqz	a0,80207704 <_ZL9allocprocv+0x11a>
    {
        proc_mem_lock.release();
        return 0;
    }

    memset(p, 0, sizeof(struct Proc));
    8020760c:	17800613          	li	a2,376
    80207610:	4581                	li	a1,0
    80207612:	842a                	mv	s0,a0
    80207614:	817fd0ef          	jal	80204e2a <_Z6memsetPvij>

    p->all_next = proc_list_head;
    80207618:	6c9c                	ld	a5,24(s1)
    p->all_prev = nullptr;
    8020761a:	16043023          	sd	zero,352(s0)
    p->all_next = proc_list_head;
    8020761e:	14f43c23          	sd	a5,344(s0)
    if (proc_list_head)
    80207622:	c399                	beqz	a5,80207628 <_ZL9allocprocv+0x3e>
        proc_list_head->all_prev = p;
    80207624:	1687b023          	sd	s0,352(a5)
    proc_list_head = p;


    p->state = USED;
    p->pid = nextpid++;
    80207628:	0000d717          	auipc	a4,0xd
    8020762c:	42870713          	addi	a4,a4,1064 # 80214a50 <_ZL7nextpid>
    80207630:	431c                	lw	a5,0(a4)
    p->state = USED;
    80207632:	4605                	li	a2,1
    proc_list_head = p;
    80207634:	ec80                	sd	s0,24(s1)
    p->pid = nextpid++;
    80207636:	0017869b          	addiw	a3,a5,1
    p->state = USED;
    8020763a:	08c42023          	sw	a2,128(s0)
    p->pid = nextpid++;
    8020763e:	c314                	sw	a3,0(a4)
    80207640:	08f42223          	sw	a5,132(s0)
    p->priority = 0;
    80207644:	16042423          	sw	zero,360(s0)
    p->killed = 0;
    80207648:	0a042e23          	sw	zero,188(s0)
  asm volatile("mv %0, tp" : "=r" (x) );
    8020764c:	8712                	mv	a4,tp
    return &cpus[id];
    8020764e:	2701                	sext.w	a4,a4
    80207650:	00471793          	slli	a5,a4,0x4
    80207654:	97ba                	add	a5,a5,a4
    80207656:	078e                	slli	a5,a5,0x3
    80207658:	00017717          	auipc	a4,0x17
    8020765c:	84870713          	addi	a4,a4,-1976 # 8021dea0 <cpus>
    80207660:	97ba                	add	a5,a5,a4
    p->cpu = mycpu();
    80207662:	16f43823          	sd	a5,368(s0)
    p->cwd = nullptr;
    80207666:	0c043023          	sd	zero,192(s0)
    for (int i = 0; i < NOFILE; i++)
    8020766a:	0c840793          	addi	a5,s0,200
    8020766e:	14840713          	addi	a4,s0,328
        p->ofile[i] = nullptr;
    80207672:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < NOFILE; i++)
    80207676:	07a1                	addi	a5,a5,8
    80207678:	fee79de3          	bne	a5,a4,80207672 <_ZL9allocprocv+0x88>

    if ((p->tf = (struct Trapframe *)PMM::alloc_page()) == 0)
    8020767c:	ae7ff0ef          	jal	80207162 <_ZN3PMM10alloc_pageEv>
    80207680:	f828                	sd	a0,112(s0)
    80207682:	cd15                	beqz	a0,802076be <_ZL9allocprocv+0xd4>
        Slab::kfree(p);
        proc_mem_lock.release();
        return 0;
    }

    if ((p->kstack = PMM::alloc_page()) == 0)
    80207684:	adfff0ef          	jal	80207162 <_ZN3PMM10alloc_pageEv>
    80207688:	e448                	sd	a0,136(s0)
    8020768a:	c151                	beqz	a0,8020770e <_ZL9allocprocv+0x124>
        Slab::kfree(p);

        proc_mem_lock.release();
        return 0;
    }
    memset(p->kstack, 0, PGSIZE);
    8020768c:	6605                	lui	a2,0x1
    8020768e:	4581                	li	a1,0
    80207690:	f9afd0ef          	jal	80204e2a <_Z6memsetPvij>

    memset(&p->context, 0, sizeof(p->context));
    80207694:	8522                	mv	a0,s0
    80207696:	07000613          	li	a2,112
    8020769a:	4581                	li	a1,0
    8020769c:	f8efd0ef          	jal	80204e2a <_Z6memsetPvij>

    // Set the context so that the next time this process is scheduled, it starts executing directly from forkret
    p->context.ra = (uint64)forkret;
    p->context.sp = (uint64)p->kstack + PGSIZE;
    802076a0:	645c                	ld	a5,136(s0)
    802076a2:	6705                	lui	a4,0x1
    return p;
}
    802076a4:	60e2                	ld	ra,24(sp)
    p->context.sp = (uint64)p->kstack + PGSIZE;
    802076a6:	97ba                	add	a5,a5,a4
    p->context.ra = (uint64)forkret;
    802076a8:	00000717          	auipc	a4,0x0
    802076ac:	28c70713          	addi	a4,a4,652 # 80207934 <_Z7forkretv>
    802076b0:	e018                	sd	a4,0(s0)
    p->context.sp = (uint64)p->kstack + PGSIZE;
    802076b2:	e41c                	sd	a5,8(s0)
}
    802076b4:	8522                	mv	a0,s0
    802076b6:	6442                	ld	s0,16(sp)
    802076b8:	64a2                	ld	s1,8(sp)
    802076ba:	6105                	addi	sp,sp,32
    802076bc:	8082                	ret
        if (p->all_next)
    802076be:	15843783          	ld	a5,344(s0)
        p->state = UNUSED;
    802076c2:	08042023          	sw	zero,128(s0)
        if (p->all_next)
    802076c6:	c789                	beqz	a5,802076d0 <_ZL9allocprocv+0xe6>
            p->all_next->all_prev = p->all_prev;
    802076c8:	16043703          	ld	a4,352(s0)
    802076cc:	16e7b023          	sd	a4,352(a5)
        if (p->all_prev)
    802076d0:	16043783          	ld	a5,352(s0)
    802076d4:	c789                	beqz	a5,802076de <_ZL9allocprocv+0xf4>
            p->all_prev->all_next = p->all_next;
    802076d6:	15843703          	ld	a4,344(s0)
    802076da:	14e7bc23          	sd	a4,344(a5)
        if (p == proc_list_head)
    802076de:	6c9c                	ld	a5,24(s1)
    802076e0:	04878063          	beq	a5,s0,80207720 <_ZL9allocprocv+0x136>
        Slab::kfree(p);
    802076e4:	8522                	mv	a0,s0
    802076e6:	c52ff0ef          	jal	80206b38 <_ZN4Slab5kfreeEPv>
        proc_mem_lock.release();
    802076ea:	00016517          	auipc	a0,0x16
    802076ee:	79650513          	addi	a0,a0,1942 # 8021de80 <proc_mem_lock>
    802076f2:	c26fe0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
        return 0;
    802076f6:	4401                	li	s0,0
}
    802076f8:	60e2                	ld	ra,24(sp)
    802076fa:	8522                	mv	a0,s0
    802076fc:	6442                	ld	s0,16(sp)
    802076fe:	64a2                	ld	s1,8(sp)
    80207700:	6105                	addi	sp,sp,32
    80207702:	8082                	ret
        proc_mem_lock.release();
    80207704:	8526                	mv	a0,s1
    80207706:	c12fe0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
        return 0;
    8020770a:	4401                	li	s0,0
    8020770c:	b7f5                	j	802076f8 <_ZL9allocprocv+0x10e>
        PMM::free_page(p->tf);
    8020770e:	7828                	ld	a0,112(s0)
    80207710:	a75ff0ef          	jal	80207184 <_ZN3PMM9free_pageEPv>
        if (p->all_next)
    80207714:	15843783          	ld	a5,344(s0)
        p->state = UNUSED;
    80207718:	08042023          	sw	zero,128(s0)
        if (p->all_next)
    8020771c:	f7d5                	bnez	a5,802076c8 <_ZL9allocprocv+0xde>
    8020771e:	bf4d                	j	802076d0 <_ZL9allocprocv+0xe6>
            proc_list_head = p->all_next;
    80207720:	15843783          	ld	a5,344(s0)
    80207724:	ec9c                	sd	a5,24(s1)
    80207726:	bf7d                	j	802076e4 <_ZL9allocprocv+0xfa>

0000000080207728 <_ZL8freeprocP4Proc>:

static void freeproc(struct Proc *p)
{
    80207728:	1101                	addi	sp,sp,-32
    8020772a:	e04a                	sd	s2,0(sp)
    8020772c:	892a                	mv	s2,a0
    if (p->tf)
    8020772e:	7928                	ld	a0,112(a0)
{
    80207730:	ec06                	sd	ra,24(sp)
    80207732:	e822                	sd	s0,16(sp)
    80207734:	e426                	sd	s1,8(sp)
    if (p->tf)
    80207736:	c119                	beqz	a0,8020773c <_ZL8freeprocP4Proc+0x14>
        PMM::free_page(p->tf);
    80207738:	a4dff0ef          	jal	80207184 <_ZN3PMM9free_pageEPv>
    p->tf = 0;
    if (p->kstack)
    8020773c:	08893503          	ld	a0,136(s2)
    p->tf = 0;
    80207740:	06093823          	sd	zero,112(s2)
    if (p->kstack)
    80207744:	c119                	beqz	a0,8020774a <_ZL8freeprocP4Proc+0x22>
        PMM::free_page(p->kstack);
    80207746:	a3fff0ef          	jal	80207184 <_ZN3PMM9free_pageEPv>
    p->kstack = 0;
    if (p->pagetable)
    8020774a:	07893503          	ld	a0,120(s2)
    p->kstack = 0;
    8020774e:	08093423          	sd	zero,136(s2)
    if (p->pagetable)
    80207752:	c509                	beqz	a0,8020775c <_ZL8freeprocP4Proc+0x34>
        VM::uvmfree(p->pagetable, p->sz);
    80207754:	0a093583          	ld	a1,160(s2)
    80207758:	be7fe0ef          	jal	8020633e <_ZN2VM7uvmfreeEPyy>
    for (int i = 0; i < NOFILE; i++)
    8020775c:	0c890413          	addi	s0,s2,200
    80207760:	14890493          	addi	s1,s2,328
    {
        if (p->ofile[i])
    80207764:	6008                	ld	a0,0(s0)
    80207766:	c509                	beqz	a0,80207770 <_ZL8freeprocP4Proc+0x48>
        {
            FileTable::close(p->ofile[i]);
    80207768:	b2dfb0ef          	jal	80203294 <_ZN9FileTable5closeEP4file>
            p->ofile[i] = nullptr;
    8020776c:	00043023          	sd	zero,0(s0)
    for (int i = 0; i < NOFILE; i++)
    80207770:	0421                	addi	s0,s0,8
    80207772:	fe9419e3          	bne	s0,s1,80207764 <_ZL8freeprocP4Proc+0x3c>
        }
    }
    if (p->cwd)
    80207776:	0c093503          	ld	a0,192(s2)
    8020777a:	c509                	beqz	a0,80207784 <_ZL8freeprocP4Proc+0x5c>
    {
        VFS::iput(p->cwd);
    8020777c:	a60fd0ef          	jal	802049dc <_ZN3VFS4iputEP5Inode>
        p->cwd = nullptr;
    80207780:	0c093023          	sd	zero,192(s2)
    }

    if (p->all_prev)
    80207784:	16093703          	ld	a4,352(s2)
        p->all_prev->all_next = p->all_next;
    80207788:	15893783          	ld	a5,344(s2)
    if (p->all_prev)
    8020778c:	c305                	beqz	a4,802077ac <_ZL8freeprocP4Proc+0x84>
        p->all_prev->all_next = p->all_next;
    8020778e:	14f73c23          	sd	a5,344(a4)
    else
        proc_list_head = p->all_next;

    if (p->all_next)
    80207792:	c789                	beqz	a5,8020779c <_ZL8freeprocP4Proc+0x74>
        p->all_next->all_prev = p->all_prev;
    80207794:	16093703          	ld	a4,352(s2)
    80207798:	16e7b023          	sd	a4,352(a5)

    Slab::kfree(p);
}
    8020779c:	6442                	ld	s0,16(sp)
    8020779e:	60e2                	ld	ra,24(sp)
    802077a0:	64a2                	ld	s1,8(sp)
    Slab::kfree(p);
    802077a2:	854a                	mv	a0,s2
}
    802077a4:	6902                	ld	s2,0(sp)
    802077a6:	6105                	addi	sp,sp,32
    Slab::kfree(p);
    802077a8:	b90ff06f          	j	80206b38 <_ZN4Slab5kfreeEPv>
        proc_list_head = p->all_next;
    802077ac:	00016717          	auipc	a4,0x16
    802077b0:	6ef73623          	sd	a5,1772(a4) # 8021de98 <proc_list_head>
    802077b4:	bff9                	j	80207792 <_ZL8freeprocP4Proc+0x6a>

00000000802077b6 <_Z5mycpuv>:
    802077b6:	8712                	mv	a4,tp
    return &cpus[id];
    802077b8:	2701                	sext.w	a4,a4
    802077ba:	00471793          	slli	a5,a4,0x4
    802077be:	97ba                	add	a5,a5,a4
    802077c0:	078e                	slli	a5,a5,0x3
}
    802077c2:	00016517          	auipc	a0,0x16
    802077c6:	6de50513          	addi	a0,a0,1758 # 8021dea0 <cpus>
    802077ca:	953e                	add	a0,a0,a5
    802077cc:	8082                	ret

00000000802077ce <_ZN8RunQueue4initEPKc>:
{
    802077ce:	1141                	addi	sp,sp,-16
    802077d0:	e022                	sd	s0,0(sp)
    802077d2:	e406                	sd	ra,8(sp)
    802077d4:	842a                	mv	s0,a0
    lock.init(name);
    802077d6:	a04fe0ef          	jal	802059da <_ZN8Spinlock4initEPKc>
}
    802077da:	60a2                	ld	ra,8(sp)
    count = 0;
    802077dc:	04043c23          	sd	zero,88(s0)
        heads[i] = nullptr;
    802077e0:	00043c23          	sd	zero,24(s0)
        tails[i] = nullptr;
    802077e4:	02043c23          	sd	zero,56(s0)
        heads[i] = nullptr;
    802077e8:	02043023          	sd	zero,32(s0)
        tails[i] = nullptr;
    802077ec:	04043023          	sd	zero,64(s0)
        heads[i] = nullptr;
    802077f0:	02043423          	sd	zero,40(s0)
        tails[i] = nullptr;
    802077f4:	04043423          	sd	zero,72(s0)
        heads[i] = nullptr;
    802077f8:	02043823          	sd	zero,48(s0)
        tails[i] = nullptr;
    802077fc:	04043823          	sd	zero,80(s0)
}
    80207800:	6402                	ld	s0,0(sp)
    80207802:	0141                	addi	sp,sp,16
    80207804:	8082                	ret

0000000080207806 <_ZN8RunQueue7enqueueEP4Proc>:
    if (p->priority < 0 || p->priority >= N_PRIO)
    80207806:	1685a783          	lw	a5,360(a1)
    8020780a:	470d                	li	a4,3
    8020780c:	00f77563          	bgeu	a4,a5,80207816 <_ZN8RunQueue7enqueueEP4Proc+0x10>
        p->priority = PRIO_MIN;
    80207810:	16e5a423          	sw	a4,360(a1)
    80207814:	478d                	li	a5,3
    p->next = nullptr;
    80207816:	078e                	slli	a5,a5,0x3
    80207818:	1405b423          	sd	zero,328(a1)
    if (heads[p->priority] == nullptr)
    8020781c:	97aa                	add	a5,a5,a0
    8020781e:	6f98                	ld	a4,24(a5)
    80207820:	cb09                	beqz	a4,80207832 <_ZN8RunQueue7enqueueEP4Proc+0x2c>
        tails[p->priority]->next = p;
    80207822:	7f98                	ld	a4,56(a5)
    80207824:	14b73423          	sd	a1,328(a4)
        tails[p->priority] = p;
    80207828:	ff8c                	sd	a1,56(a5)
    count++;
    8020782a:	6d3c                	ld	a5,88(a0)
    8020782c:	0785                	addi	a5,a5,1
    8020782e:	ed3c                	sd	a5,88(a0)
}
    80207830:	8082                	ret
        heads[p->priority] = p;
    80207832:	ef8c                	sd	a1,24(a5)
        tails[p->priority] = p;
    80207834:	ff8c                	sd	a1,56(a5)
    count++;
    80207836:	6d3c                	ld	a5,88(a0)
    80207838:	0785                	addi	a5,a5,1
    8020783a:	ed3c                	sd	a5,88(a0)
}
    8020783c:	8082                	ret

000000008020783e <_ZN8RunQueue7dequeueEv>:
{
    8020783e:	86aa                	mv	a3,a0
    80207840:	01850713          	addi	a4,a0,24
    for (int i = 0; i < N_PRIO; i++)
    80207844:	4781                	li	a5,0
    80207846:	4611                	li	a2,4
        if (heads[i])
    80207848:	6308                	ld	a0,0(a4)
    for (int i = 0; i < N_PRIO; i++)
    8020784a:	0721                	addi	a4,a4,8
        if (heads[i])
    8020784c:	e509                	bnez	a0,80207856 <_ZN8RunQueue7dequeueEv+0x18>
    for (int i = 0; i < N_PRIO; i++)
    8020784e:	2785                	addiw	a5,a5,1
    80207850:	fec79ce3          	bne	a5,a2,80207848 <_ZN8RunQueue7dequeueEv+0xa>
}
    80207854:	8082                	ret
            heads[i] = p->next;
    80207856:	14853703          	ld	a4,328(a0)
    8020785a:	078e                	slli	a5,a5,0x3
    8020785c:	97b6                	add	a5,a5,a3
    8020785e:	ef98                	sd	a4,24(a5)
            if (!heads[i])
    80207860:	c719                	beqz	a4,8020786e <_ZN8RunQueue7dequeueEv+0x30>
            count--;
    80207862:	6ebc                	ld	a5,88(a3)
            p->next = nullptr;
    80207864:	14053423          	sd	zero,328(a0)
            count--;
    80207868:	17fd                	addi	a5,a5,-1
    8020786a:	eebc                	sd	a5,88(a3)
            return p;
    8020786c:	8082                	ret
                tails[i] = nullptr;
    8020786e:	0207bc23          	sd	zero,56(a5)
    80207872:	bfc5                	j	80207862 <_ZN8RunQueue7dequeueEv+0x24>

0000000080207874 <_ZN8RunQueue5stealEv>:
{
    80207874:	86aa                	mv	a3,a0
    80207876:	03050713          	addi	a4,a0,48
    for (int i = N_PRIO - 1; i >= 0; i--)
    8020787a:	478d                	li	a5,3
    8020787c:	567d                	li	a2,-1
        if (heads[i])
    8020787e:	6308                	ld	a0,0(a4)
    for (int i = N_PRIO - 1; i >= 0; i--)
    80207880:	1761                	addi	a4,a4,-8
        if (heads[i])
    80207882:	e509                	bnez	a0,8020788c <_ZN8RunQueue5stealEv+0x18>
    for (int i = N_PRIO - 1; i >= 0; i--)
    80207884:	37fd                	addiw	a5,a5,-1
    80207886:	fec79ce3          	bne	a5,a2,8020787e <_ZN8RunQueue5stealEv+0xa>
}
    8020788a:	8082                	ret
            heads[i] = p->next;
    8020788c:	14853703          	ld	a4,328(a0)
    80207890:	078e                	slli	a5,a5,0x3
    80207892:	97b6                	add	a5,a5,a3
    80207894:	ef98                	sd	a4,24(a5)
            if (!heads[i])
    80207896:	c719                	beqz	a4,802078a4 <_ZN8RunQueue5stealEv+0x30>
            count--;
    80207898:	6ebc                	ld	a5,88(a3)
            p->next = nullptr;
    8020789a:	14053423          	sd	zero,328(a0)
            count--;
    8020789e:	17fd                	addi	a5,a5,-1
    802078a0:	eebc                	sd	a5,88(a3)
            return p;
    802078a2:	8082                	ret
                tails[i] = nullptr;
    802078a4:	0207bc23          	sd	zero,56(a5)
    802078a8:	bfc5                	j	80207898 <_ZN8RunQueue5stealEv+0x24>

00000000802078aa <_Z11usertrapretv>:
{
    802078aa:	1141                	addi	sp,sp,-16
    802078ac:	e406                	sd	ra,8(sp)
    struct Proc *p = myproc();
    802078ae:	9d4fe0ef          	jal	80205a82 <_Z6myprocv>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    802078b2:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    802078b6:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    802078b8:	10079073          	csrw	sstatus,a5
    uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    802078bc:	040007b7          	lui	a5,0x4000
    802078c0:	0000d617          	auipc	a2,0xd
    802078c4:	1b063603          	ld	a2,432(a2) # 80214a70 <_GLOBAL_OFFSET_TABLE_+0x10>
    802078c8:	17fd                	addi	a5,a5,-1 # 3ffffff <_start-0x7c200001>
    802078ca:	0000d717          	auipc	a4,0xd
    802078ce:	1ee73703          	ld	a4,494(a4) # 80214ab8 <_GLOBAL_OFFSET_TABLE_+0x58>
    802078d2:	8f11                	sub	a4,a4,a2
    802078d4:	07b2                	slli	a5,a5,0xc
    802078d6:	973e                	add	a4,a4,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    802078d8:	10571073          	csrw	stvec,a4
    p->tf->kernel_satp = r_satp();
    802078dc:	7938                	ld	a4,112(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    802078de:	180025f3          	csrr	a1,satp
    p->tf->kernel_sp = (uint64)p->kstack + PGSIZE;
    802078e2:	6554                	ld	a3,136(a0)
    802078e4:	6805                	lui	a6,0x1
    p->tf->kernel_satp = r_satp();
    802078e6:	e30c                	sd	a1,0(a4)
    p->tf->kernel_sp = (uint64)p->kstack + PGSIZE;
    802078e8:	96c2                	add	a3,a3,a6
    802078ea:	e714                	sd	a3,8(a4)
    p->tf->kernel_trap = (uint64)usertrap;
    802078ec:	0000d697          	auipc	a3,0xd
    802078f0:	1c46b683          	ld	a3,452(a3) # 80214ab0 <_GLOBAL_OFFSET_TABLE_+0x50>
    802078f4:	eb14                	sd	a3,16(a4)
  asm volatile("mv %0, tp" : "=r" (x) );
    802078f6:	8692                	mv	a3,tp
    p->tf->kernel_hartid = r_tp();
    802078f8:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    802078fa:	100026f3          	csrr	a3,sstatus
    x &= ~SSTATUS_SPP;
    802078fe:	eff6f693          	andi	a3,a3,-257
    x |= SSTATUS_SPIE;
    80207902:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80207906:	10069073          	csrw	sstatus,a3
  asm volatile("csrw sepc, %0" : : "r" (x));
    8020790a:	6f18                	ld	a4,24(a4)
    8020790c:	14171073          	csrw	sepc,a4
    uint64 satp = MAKE_SATP(p->pagetable);
    80207910:	7d2c                	ld	a1,120(a0)
    uint64 fn = TRAMPOLINE + ((uint64)userret - (uint64)trampoline);
    80207912:	0000d717          	auipc	a4,0xd
    80207916:	17e73703          	ld	a4,382(a4) # 80214a90 <_GLOBAL_OFFSET_TABLE_+0x30>
}
    8020791a:	60a2                	ld	ra,8(sp)
    uint64 fn = TRAMPOLINE + ((uint64)userret - (uint64)trampoline);
    8020791c:	97ba                	add	a5,a5,a4
    ((void (*)(uint64, uint64))fn)(TRAPFRAME, satp);
    8020791e:	02000537          	lui	a0,0x2000
    80207922:	577d                	li	a4,-1
    uint64 satp = MAKE_SATP(p->pagetable);
    80207924:	81b1                	srli	a1,a1,0xc
    ((void (*)(uint64, uint64))fn)(TRAPFRAME, satp);
    80207926:	157d                	addi	a0,a0,-1 # 1ffffff <_start-0x7e200001>
    80207928:	177e                	slli	a4,a4,0x3f
    uint64 fn = TRAMPOLINE + ((uint64)userret - (uint64)trampoline);
    8020792a:	8f91                	sub	a5,a5,a2
    ((void (*)(uint64, uint64))fn)(TRAPFRAME, satp);
    8020792c:	8dd9                	or	a1,a1,a4
    8020792e:	0536                	slli	a0,a0,0xd
}
    80207930:	0141                	addi	sp,sp,16
    ((void (*)(uint64, uint64))fn)(TRAPFRAME, satp);
    80207932:	8782                	jr	a5

0000000080207934 <_Z7forkretv>:
{
    80207934:	1141                	addi	sp,sp,-16
    80207936:	e406                	sd	ra,8(sp)
  asm volatile("mv %0, tp" : "=r" (x) );
    80207938:	8712                	mv	a4,tp
    c->runqueue->lock.release();
    8020793a:	2701                	sext.w	a4,a4
    8020793c:	00471793          	slli	a5,a4,0x4
    80207940:	97ba                	add	a5,a5,a4
    80207942:	078e                	slli	a5,a5,0x3
    80207944:	00016717          	auipc	a4,0x16
    80207948:	53c70713          	addi	a4,a4,1340 # 8021de80 <proc_mem_lock>
    8020794c:	97ba                	add	a5,a5,a4
    8020794e:	73c8                	ld	a0,160(a5)
    80207950:	9c8fe0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
}
    80207954:	60a2                	ld	ra,8(sp)
    80207956:	0141                	addi	sp,sp,16
    usertrapret();
    80207958:	f53ff06f          	j	802078aa <_Z11usertrapretv>

000000008020795c <_Z4forkv>:

int fork()
{
    8020795c:	7179                	addi	sp,sp,-48
    8020795e:	e052                	sd	s4,0(sp)
    80207960:	f406                	sd	ra,40(sp)
    struct Proc *np;
    struct Proc *p = myproc();
    80207962:	920fe0ef          	jal	80205a82 <_Z6myprocv>
    80207966:	8a2a                	mv	s4,a0

    if ((np = allocproc()) == 0)
    80207968:	c83ff0ef          	jal	802075ea <_ZL9allocprocv>
    8020796c:	14050c63          	beqz	a0,80207ac4 <_Z4forkv+0x168>
        return -1;

    np->pagetable = VM::uvmcreate();
    80207970:	e84a                	sd	s2,16(sp)
    80207972:	892a                	mv	s2,a0
    80207974:	feafe0ef          	jal	8020615e <_ZN2VM9uvmcreateEv>
    np->sz = p->sz;
    80207978:	0a0a3603          	ld	a2,160(s4)
    np->pagetable = VM::uvmcreate();
    8020797c:	06a93c23          	sd	a0,120(s2)
    80207980:	85aa                	mv	a1,a0
    if (VM::uvmcopy(p->pagetable, np->pagetable, p->sz) < 0)
    80207982:	078a3503          	ld	a0,120(s4)
    np->sz = p->sz;
    80207986:	0ac93023          	sd	a2,160(s2)
    if (VM::uvmcopy(p->pagetable, np->pagetable, p->sz) < 0)
    8020798a:	a17fe0ef          	jal	802063a0 <_ZN2VM7uvmcopyEPyS0_y>
    8020798e:	12054163          	bltz	a0,80207ab0 <_Z4forkv+0x154>
        proc_mem_lock.release();
        return -1;
    }
    

    if (VM::mappages(np->pagetable, TRAPFRAME, PGSIZE, (uint64)np->tf, PTE_R | PTE_W) < 0)
    80207992:	020005b7          	lui	a1,0x2000
    80207996:	07093683          	ld	a3,112(s2)
    8020799a:	07893503          	ld	a0,120(s2)
    8020799e:	15fd                	addi	a1,a1,-1 # 1ffffff <_start-0x7e200001>
    802079a0:	4719                	li	a4,6
    802079a2:	6605                	lui	a2,0x1
    802079a4:	05b6                	slli	a1,a1,0xd
    802079a6:	f40fe0ef          	jal	802060e6 <_ZN2VM8mappagesEPyyyyi>
    802079aa:	10054363          	bltz	a0,80207ab0 <_Z4forkv+0x154>
        freeproc(np);
        proc_mem_lock.release();
        return -1;
    }

    *(np->tf) = *(p->tf);
    802079ae:	07093883          	ld	a7,112(s2)
    802079b2:	070a3783          	ld	a5,112(s4)
    802079b6:	f022                	sd	s0,32(sp)
    802079b8:	ec26                	sd	s1,24(sp)
    802079ba:	e44e                	sd	s3,8(sp)
    802079bc:	8746                	mv	a4,a7
    802079be:	12078813          	addi	a6,a5,288
    802079c2:	6388                	ld	a0,0(a5)
    802079c4:	678c                	ld	a1,8(a5)
    802079c6:	6b90                	ld	a2,16(a5)
    802079c8:	6f94                	ld	a3,24(a5)
    802079ca:	e308                	sd	a0,0(a4)
    802079cc:	e70c                	sd	a1,8(a4)
    802079ce:	eb10                	sd	a2,16(a4)
    802079d0:	ef14                	sd	a3,24(a4)
    802079d2:	02078793          	addi	a5,a5,32
    802079d6:	02070713          	addi	a4,a4,32
    802079da:	ff0794e3          	bne	a5,a6,802079c2 <_Z4forkv+0x66>
    np->tf->a0 = 0;
    802079de:	0608b823          	sd	zero,112(a7)
    strcpy(np->name, p->name);
    802079e2:	090a0593          	addi	a1,s4,144
    802079e6:	09090513          	addi	a0,s2,144
    802079ea:	ce8fd0ef          	jal	80204ed2 <_Z6strcpyPcPKc>
    np->parent = p;
    np->priority = p->priority;
    802079ee:	168a2783          	lw	a5,360(s4)
    802079f2:	0c8a0413          	addi	s0,s4,200
    np->parent = p;
    802079f6:	0b493423          	sd	s4,168(s2)
    np->priority = p->priority;
    802079fa:	16f92423          	sw	a5,360(s2)

    for (int i = 0; i < NOFILE; i++)
    802079fe:	0c890493          	addi	s1,s2,200
    80207a02:	148a0993          	addi	s3,s4,328
    {
        if (p->ofile[i])
    80207a06:	6008                	ld	a0,0(s0)
    80207a08:	c501                	beqz	a0,80207a10 <_Z4forkv+0xb4>
        {
            np->ofile[i] = FileTable::dup(p->ofile[i]);
    80207a0a:	849fb0ef          	jal	80203252 <_ZN9FileTable3dupEP4file>
    80207a0e:	e088                	sd	a0,0(s1)
    for (int i = 0; i < NOFILE; i++)
    80207a10:	0421                	addi	s0,s0,8
    80207a12:	04a1                	addi	s1,s1,8
    80207a14:	ff3419e3          	bne	s0,s3,80207a06 <_Z4forkv+0xaa>
        }
    }

    if (p->cwd)
    80207a18:	0c0a3503          	ld	a0,192(s4)
    80207a1c:	c509                	beqz	a0,80207a26 <_Z4forkv+0xca>
    {
        np->cwd = VFS::idup(p->cwd);
    80207a1e:	814fd0ef          	jal	80204a32 <_ZN3VFS4idupEP5Inode>
    80207a22:	0ca93023          	sd	a0,192(s2)
    }

    proc_mem_lock.release();
    80207a26:	00016997          	auipc	s3,0x16
    80207a2a:	45a98993          	addi	s3,s3,1114 # 8021de80 <proc_mem_lock>
    80207a2e:	854e                	mv	a0,s3
    80207a30:	8e8fe0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
    80207a34:	8a12                	mv	s4,tp
    int id = r_tp();
    80207a36:	2a01                	sext.w	s4,s4

    struct cpu *c = mycpu();
    c->runqueue->lock.acquire();
    80207a38:	004a1413          	slli	s0,s4,0x4
    80207a3c:	014404b3          	add	s1,s0,s4
    80207a40:	048e                	slli	s1,s1,0x3
    80207a42:	94ce                	add	s1,s1,s3
    80207a44:	70c8                	ld	a0,160(s1)
    80207a46:	93afe0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
    if (p->priority < 0 || p->priority >= N_PRIO)
    80207a4a:	16892783          	lw	a5,360(s2)
    np->state = RUNNABLE;
    80207a4e:	468d                	li	a3,3
    80207a50:	08d92023          	sw	a3,128(s2)
    c->runqueue->enqueue(np);
    80207a54:	70d8                	ld	a4,160(s1)
    if (p->priority < 0 || p->priority >= N_PRIO)
    80207a56:	04f6e163          	bltu	a3,a5,80207a98 <_Z4forkv+0x13c>
    p->next = nullptr;
    80207a5a:	078e                	slli	a5,a5,0x3
    80207a5c:	14093423          	sd	zero,328(s2)
    if (heads[p->priority] == nullptr)
    80207a60:	97ba                	add	a5,a5,a4
    80207a62:	6f94                	ld	a3,24(a5)
    80207a64:	c2b9                	beqz	a3,80207aaa <_Z4forkv+0x14e>
        tails[p->priority]->next = p;
    80207a66:	7f94                	ld	a3,56(a5)
    80207a68:	1526b423          	sd	s2,328(a3)
        tails[p->priority] = p;
    80207a6c:	0327bc23          	sd	s2,56(a5)
    c->runqueue->lock.release();
    80207a70:	9452                	add	s0,s0,s4
    count++;
    80207a72:	6f3c                	ld	a5,88(a4)
    c->runqueue->lock.release();
    80207a74:	040e                	slli	s0,s0,0x3
    80207a76:	99a2                	add	s3,s3,s0
    80207a78:	0a09b503          	ld	a0,160(s3)
    count++;
    80207a7c:	0785                	addi	a5,a5,1
    80207a7e:	ef3c                	sd	a5,88(a4)
    c->runqueue->lock.release();
    80207a80:	898fe0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>

    return np->pid;
    80207a84:	08492503          	lw	a0,132(s2)
    80207a88:	7402                	ld	s0,32(sp)
    80207a8a:	64e2                	ld	s1,24(sp)
    80207a8c:	6942                	ld	s2,16(sp)
    80207a8e:	69a2                	ld	s3,8(sp)
}
    80207a90:	70a2                	ld	ra,40(sp)
    80207a92:	6a02                	ld	s4,0(sp)
    80207a94:	6145                	addi	sp,sp,48
    80207a96:	8082                	ret
        p->priority = PRIO_MIN;
    80207a98:	478d                	li	a5,3
    p->next = nullptr;
    80207a9a:	078e                	slli	a5,a5,0x3
        p->priority = PRIO_MIN;
    80207a9c:	16d92423          	sw	a3,360(s2)
    p->next = nullptr;
    80207aa0:	14093423          	sd	zero,328(s2)
    if (heads[p->priority] == nullptr)
    80207aa4:	97ba                	add	a5,a5,a4
    80207aa6:	6f94                	ld	a3,24(a5)
    80207aa8:	fedd                	bnez	a3,80207a66 <_Z4forkv+0x10a>
        heads[p->priority] = p;
    80207aaa:	0127bc23          	sd	s2,24(a5)
        tails[p->priority] = p;
    80207aae:	bf7d                	j	80207a6c <_Z4forkv+0x110>
        freeproc(np);
    80207ab0:	854a                	mv	a0,s2
    80207ab2:	c77ff0ef          	jal	80207728 <_ZL8freeprocP4Proc>
        proc_mem_lock.release();
    80207ab6:	00016517          	auipc	a0,0x16
    80207aba:	3ca50513          	addi	a0,a0,970 # 8021de80 <proc_mem_lock>
    80207abe:	85afe0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
    80207ac2:	6942                	ld	s2,16(sp)
        return -1;
    80207ac4:	557d                	li	a0,-1
    80207ac6:	b7e9                	j	80207a90 <_Z4forkv+0x134>

0000000080207ac8 <_ZN11ProcManager4initEv>:

namespace ProcManager
{

    void init()
    {
    80207ac8:	7179                	addi	sp,sp,-48
        proc_mem_lock.init("proc_mem");
    80207aca:	0000a597          	auipc	a1,0xa
    80207ace:	3f658593          	addi	a1,a1,1014 # 80211ec0 <initcode_end+0x778>
    80207ad2:	00016517          	auipc	a0,0x16
    80207ad6:	3ae50513          	addi	a0,a0,942 # 8021de80 <proc_mem_lock>
    {
    80207ada:	f022                	sd	s0,32(sp)
    80207adc:	ec26                	sd	s1,24(sp)
    80207ade:	e84a                	sd	s2,16(sp)
    80207ae0:	e44e                	sd	s3,8(sp)
    80207ae2:	f406                	sd	ra,40(sp)
    80207ae4:	00016417          	auipc	s0,0x16
    80207ae8:	7fc40413          	addi	s0,s0,2044 # 8021e2e0 <runqueues>
        proc_mem_lock.init("proc_mem");
    80207aec:	eeffd0ef          	jal	802059da <_ZN8Spinlock4initEPKc>

        proc_list_head = nullptr;
    80207af0:	00016497          	auipc	s1,0x16
    80207af4:	3b048493          	addi	s1,s1,944 # 8021dea0 <cpus>
    80207af8:	00016797          	auipc	a5,0x16
    80207afc:	3a07b023          	sd	zero,928(a5) # 8021de98 <proc_list_head>

        for (int i = 0; i < NCPU; i++)
    80207b00:	00017997          	auipc	s3,0x17
    80207b04:	ae098993          	addi	s3,s3,-1312 # 8021e5e0 <initproc>
    lock.init(name);
    80207b08:	0000a917          	auipc	s2,0xa
    80207b0c:	3c890913          	addi	s2,s2,968 # 80211ed0 <initcode_end+0x788>
        {
            cpus[i].runqueue = &runqueues[i];
    80207b10:	e0c0                	sd	s0,128(s1)
    lock.init(name);
    80207b12:	8522                	mv	a0,s0
    80207b14:	85ca                	mv	a1,s2
    80207b16:	ec5fd0ef          	jal	802059da <_ZN8Spinlock4initEPKc>
        for (int i = 0; i < NCPU; i++)
    80207b1a:	06040413          	addi	s0,s0,96
    count = 0;
    80207b1e:	fe043c23          	sd	zero,-8(s0)
        heads[i] = nullptr;
    80207b22:	fa043c23          	sd	zero,-72(s0)
        tails[i] = nullptr;
    80207b26:	fc043c23          	sd	zero,-40(s0)
        heads[i] = nullptr;
    80207b2a:	fc043023          	sd	zero,-64(s0)
        tails[i] = nullptr;
    80207b2e:	fe043023          	sd	zero,-32(s0)
        heads[i] = nullptr;
    80207b32:	fc043423          	sd	zero,-56(s0)
        tails[i] = nullptr;
    80207b36:	fe043423          	sd	zero,-24(s0)
        heads[i] = nullptr;
    80207b3a:	fc043823          	sd	zero,-48(s0)
        tails[i] = nullptr;
    80207b3e:	fe043823          	sd	zero,-16(s0)
        for (int i = 0; i < NCPU; i++)
    80207b42:	08848493          	addi	s1,s1,136
    80207b46:	fd3415e3          	bne	s0,s3,80207b10 <_ZN11ProcManager4initEv+0x48>
            cpus[i].runqueue->init("runqueue");
        }
    }
    80207b4a:	70a2                	ld	ra,40(sp)
    80207b4c:	7402                	ld	s0,32(sp)
    80207b4e:	64e2                	ld	s1,24(sp)
    80207b50:	6942                	ld	s2,16(sp)
    80207b52:	69a2                	ld	s3,8(sp)
    80207b54:	6145                	addi	sp,sp,48
    80207b56:	8082                	ret

0000000080207b58 <_ZN11ProcManager9schedulerEv>:

    void scheduler()
    {
    80207b58:	715d                	addi	sp,sp,-80
    80207b5a:	e486                	sd	ra,72(sp)
    80207b5c:	e0a2                	sd	s0,64(sp)
    80207b5e:	fc26                	sd	s1,56(sp)
    80207b60:	f84a                	sd	s2,48(sp)
    80207b62:	f44e                	sd	s3,40(sp)
    80207b64:	f052                	sd	s4,32(sp)
    80207b66:	ec56                	sd	s5,24(sp)
    80207b68:	e85a                	sd	s6,16(sp)
    80207b6a:	e45e                	sd	s7,8(sp)
    80207b6c:	e062                	sd	s8,0(sp)
    80207b6e:	8792                	mv	a5,tp
    int id = r_tp();
    80207b70:	2781                	sext.w	a5,a5
        struct Proc *p;
        struct cpu *c = mycpu();
        c->proc = 0;
    80207b72:	00479b13          	slli	s6,a5,0x4
    80207b76:	9b3e                	add	s6,s6,a5
    80207b78:	0b0e                	slli	s6,s6,0x3
    80207b7a:	00016b97          	auipc	s7,0x16
    80207b7e:	306b8b93          	addi	s7,s7,774 # 8021de80 <proc_mem_lock>
    80207b82:	016b8933          	add	s2,s7,s6
        Drivers::uart_puts("[Proc] Scheduler started (Per-CPU).\n");
    80207b86:	0000a517          	auipc	a0,0xa
    80207b8a:	35a50513          	addi	a0,a0,858 # 80211ee0 <initcode_end+0x798>
        c->proc = 0;
    80207b8e:	02093023          	sd	zero,32(s2)
        Drivers::uart_puts("[Proc] Scheduler started (Per-CPU).\n");
    80207b92:	1d8010ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            {
                p->state = RUNNING;
                c->proc = p;

                c->runqueue->lock.acquire();
                swtch(&c->context, &p->context);
    80207b96:	00016797          	auipc	a5,0x16
    80207b9a:	31278793          	addi	a5,a5,786 # 8021dea8 <cpus+0x8>
    80207b9e:	9b3e                	add	s6,s6,a5
    for (int i = 0; i < N_PRIO; i++)
    80207ba0:	4991                	li	s3,4
                for (int i = 0; i < NCPU; i++)
    80207ba2:	4a21                	li	s4,8
    for (int i = N_PRIO - 1; i >= 0; i--)
    80207ba4:	5afd                	li	s5,-1
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80207ba6:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80207baa:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80207bae:	10079073          	csrw	sstatus,a5
            c->runqueue->lock.acquire();
    80207bb2:	0a093503          	ld	a0,160(s2)
    80207bb6:	fcbfd0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
            p = c->runqueue->dequeue();
    80207bba:	0a093683          	ld	a3,160(s2)
    for (int i = 0; i < N_PRIO; i++)
    80207bbe:	4781                	li	a5,0
    80207bc0:	01868713          	addi	a4,a3,24
        if (heads[i])
    80207bc4:	6300                	ld	s0,0(a4)
    for (int i = 0; i < N_PRIO; i++)
    80207bc6:	0721                	addi	a4,a4,8
        if (heads[i])
    80207bc8:	e041                	bnez	s0,80207c48 <_ZN11ProcManager9schedulerEv+0xf0>
    for (int i = 0; i < N_PRIO; i++)
    80207bca:	2785                	addiw	a5,a5,1
    80207bcc:	ff379ce3          	bne	a5,s3,80207bc4 <_ZN11ProcManager9schedulerEv+0x6c>
            c->runqueue->lock.release();
    80207bd0:	8536                	mv	a0,a3
    80207bd2:	f47fd0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
                for (int i = 0; i < NCPU; i++)
    80207bd6:	00016c17          	auipc	s8,0x16
    80207bda:	2cac0c13          	addi	s8,s8,714 # 8021dea0 <cpus>
            c->runqueue->lock.release();
    80207bde:	4481                	li	s1,0
    80207be0:	a809                	j	80207bf2 <_ZN11ProcManager9schedulerEv+0x9a>
                    victim->runqueue->lock.release();
    80207be2:	8536                	mv	a0,a3
    80207be4:	f35fd0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
                for (int i = 0; i < NCPU; i++)
    80207be8:	0485                	addi	s1,s1,1
    80207bea:	088c0c13          	addi	s8,s8,136
    80207bee:	fb448ce3          	beq	s1,s4,80207ba6 <_ZN11ProcManager9schedulerEv+0x4e>
  asm volatile("mv %0, tp" : "=r" (x) );
    80207bf2:	8792                	mv	a5,tp
                    if ((uint64)i == r_tp())
    80207bf4:	fe978ae3          	beq	a5,s1,80207be8 <_ZN11ProcManager9schedulerEv+0x90>
                    victim->runqueue->lock.acquire();
    80207bf8:	080c3503          	ld	a0,128(s8)
    80207bfc:	f85fd0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
                    if (victim->runqueue->count > 0)
    80207c00:	080c3683          	ld	a3,128(s8)
    80207c04:	6eb0                	ld	a2,88(a3)
    80207c06:	de71                	beqz	a2,80207be2 <_ZN11ProcManager9schedulerEv+0x8a>
        if (heads[i])
    80207c08:	7a80                	ld	s0,48(a3)
    80207c0a:	03068713          	addi	a4,a3,48
    for (int i = N_PRIO - 1; i >= 0; i--)
    80207c0e:	478d                	li	a5,3
    80207c10:	1761                	addi	a4,a4,-8
        if (heads[i])
    80207c12:	e419                	bnez	s0,80207c20 <_ZN11ProcManager9schedulerEv+0xc8>
    for (int i = N_PRIO - 1; i >= 0; i--)
    80207c14:	37fd                	addiw	a5,a5,-1
    80207c16:	fd5786e3          	beq	a5,s5,80207be2 <_ZN11ProcManager9schedulerEv+0x8a>
        if (heads[i])
    80207c1a:	6300                	ld	s0,0(a4)
    for (int i = N_PRIO - 1; i >= 0; i--)
    80207c1c:	1761                	addi	a4,a4,-8
        if (heads[i])
    80207c1e:	d87d                	beqz	s0,80207c14 <_ZN11ProcManager9schedulerEv+0xbc>
            heads[i] = p->next;
    80207c20:	14843703          	ld	a4,328(s0)
    80207c24:	078e                	slli	a5,a5,0x3
    80207c26:	97b6                	add	a5,a5,a3
    80207c28:	ef98                	sd	a4,24(a5)
            if (!heads[i])
    80207c2a:	c725                	beqz	a4,80207c92 <_ZN11ProcManager9schedulerEv+0x13a>
                    victim->runqueue->lock.release();
    80207c2c:	2481                	sext.w	s1,s1
    80207c2e:	00449793          	slli	a5,s1,0x4
    80207c32:	97a6                	add	a5,a5,s1
    80207c34:	078e                	slli	a5,a5,0x3
            p->next = nullptr;
    80207c36:	14043423          	sd	zero,328(s0)
                    victim->runqueue->lock.release();
    80207c3a:	97de                	add	a5,a5,s7
    80207c3c:	73c8                	ld	a0,160(a5)
            count--;
    80207c3e:	167d                	addi	a2,a2,-1 # fff <_start-0x801ff001>
    80207c40:	eeb0                	sd	a2,88(a3)
                    victim->runqueue->lock.release();
    80207c42:	ed7fd0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
            if (p)
    80207c46:	a005                	j	80207c66 <_ZN11ProcManager9schedulerEv+0x10e>
            heads[i] = p->next;
    80207c48:	14843703          	ld	a4,328(s0)
    80207c4c:	078e                	slli	a5,a5,0x3
    80207c4e:	97b6                	add	a5,a5,a3
    80207c50:	ef98                	sd	a4,24(a5)
            if (!heads[i])
    80207c52:	cf0d                	beqz	a4,80207c8c <_ZN11ProcManager9schedulerEv+0x134>
            count--;
    80207c54:	6ebc                	ld	a5,88(a3)
            p->next = nullptr;
    80207c56:	14043423          	sd	zero,328(s0)
            c->runqueue->lock.release();
    80207c5a:	0a093503          	ld	a0,160(s2)
            count--;
    80207c5e:	17fd                	addi	a5,a5,-1
    80207c60:	eebc                	sd	a5,88(a3)
            c->runqueue->lock.release();
    80207c62:	eb7fd0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
                c->runqueue->lock.acquire();
    80207c66:	0a093503          	ld	a0,160(s2)
                p->state = RUNNING;
    80207c6a:	09342023          	sw	s3,128(s0)
                c->proc = p;
    80207c6e:	02893023          	sd	s0,32(s2)
                c->runqueue->lock.acquire();
    80207c72:	f0ffd0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
                swtch(&c->context, &p->context);
    80207c76:	85a2                	mv	a1,s0
    80207c78:	855a                	mv	a0,s6
    80207c7a:	bd2f80ef          	jal	8020004c <swtch>
                c->runqueue->lock.release();
    80207c7e:	0a093503          	ld	a0,160(s2)
    80207c82:	e97fd0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>

                c->proc = 0;
    80207c86:	02093023          	sd	zero,32(s2)
    80207c8a:	bf31                	j	80207ba6 <_ZN11ProcManager9schedulerEv+0x4e>
                tails[i] = nullptr;
    80207c8c:	0207bc23          	sd	zero,56(a5)
    80207c90:	b7d1                	j	80207c54 <_ZN11ProcManager9schedulerEv+0xfc>
                tails[i] = nullptr;
    80207c92:	0207bc23          	sd	zero,56(a5)
    80207c96:	bf59                	j	80207c2c <_ZN11ProcManager9schedulerEv+0xd4>

0000000080207c98 <_ZN11ProcManager5yieldEv>:
            }
        }
    }

    void yield()
    {
    80207c98:	7179                	addi	sp,sp,-48
    80207c9a:	e84a                	sd	s2,16(sp)
    80207c9c:	f406                	sd	ra,40(sp)
    80207c9e:	f022                	sd	s0,32(sp)
    80207ca0:	ec26                	sd	s1,24(sp)
    80207ca2:	e44e                	sd	s3,8(sp)
        struct Proc *p = myproc();
    80207ca4:	ddffd0ef          	jal	80205a82 <_Z6myprocv>
    80207ca8:	892a                	mv	s2,a0
    80207caa:	8492                	mv	s1,tp
    int id = r_tp();
    80207cac:	2481                	sext.w	s1,s1
        struct cpu *c = mycpu();
        c->runqueue->lock.acquire();
    80207cae:	00449413          	slli	s0,s1,0x4
    80207cb2:	009407b3          	add	a5,s0,s1
    80207cb6:	00016997          	auipc	s3,0x16
    80207cba:	1ca98993          	addi	s3,s3,458 # 8021de80 <proc_mem_lock>
    80207cbe:	078e                	slli	a5,a5,0x3
    80207cc0:	97ce                	add	a5,a5,s3
    80207cc2:	73c8                	ld	a0,160(a5)
    80207cc4:	ebdfd0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        if (p && p->state == RUNNING)
    80207cc8:	00090763          	beqz	s2,80207cd6 <_ZN11ProcManager5yieldEv+0x3e>
    80207ccc:	08092703          	lw	a4,128(s2)
    80207cd0:	4791                	li	a5,4
    80207cd2:	00f70f63          	beq	a4,a5,80207cf0 <_ZN11ProcManager5yieldEv+0x58>
            if (p->priority < PRIO_MIN)
                p->priority++;
            c->runqueue->enqueue(p);
            swtch(&p->context, &c->context);
        }
        c->runqueue->lock.release();
    80207cd6:	9426                	add	s0,s0,s1
    80207cd8:	040e                	slli	s0,s0,0x3
    80207cda:	008987b3          	add	a5,s3,s0
    }
    80207cde:	7402                	ld	s0,32(sp)
    80207ce0:	70a2                	ld	ra,40(sp)
    80207ce2:	64e2                	ld	s1,24(sp)
    80207ce4:	6942                	ld	s2,16(sp)
    80207ce6:	69a2                	ld	s3,8(sp)
        c->runqueue->lock.release();
    80207ce8:	73c8                	ld	a0,160(a5)
    }
    80207cea:	6145                	addi	sp,sp,48
        c->runqueue->lock.release();
    80207cec:	e2dfd06f          	j	80205b18 <_ZN8Spinlock7releaseEv>
            if (p->priority < PRIO_MIN)
    80207cf0:	16892703          	lw	a4,360(s2)
            p->state = RUNNABLE;
    80207cf4:	478d                	li	a5,3
    80207cf6:	08f92023          	sw	a5,128(s2)
            if (p->priority < PRIO_MIN)
    80207cfa:	4789                	li	a5,2
    80207cfc:	00e7c563          	blt	a5,a4,80207d06 <_ZN11ProcManager5yieldEv+0x6e>
                p->priority++;
    80207d00:	2705                	addiw	a4,a4,1
    80207d02:	16e92423          	sw	a4,360(s2)
            c->runqueue->enqueue(p);
    80207d06:	009407b3          	add	a5,s0,s1
    80207d0a:	078e                	slli	a5,a5,0x3
    80207d0c:	97ce                	add	a5,a5,s3
    if (p->priority < 0 || p->priority >= N_PRIO)
    80207d0e:	460d                	li	a2,3
            c->runqueue->enqueue(p);
    80207d10:	73d4                	ld	a3,160(a5)
    if (p->priority < 0 || p->priority >= N_PRIO)
    80207d12:	00e67563          	bgeu	a2,a4,80207d1c <_ZN11ProcManager5yieldEv+0x84>
        p->priority = PRIO_MIN;
    80207d16:	16c92423          	sw	a2,360(s2)
    80207d1a:	470d                	li	a4,3
    p->next = nullptr;
    80207d1c:	070e                	slli	a4,a4,0x3
    80207d1e:	14093423          	sd	zero,328(s2)
    if (heads[p->priority] == nullptr)
    80207d22:	9736                	add	a4,a4,a3
    80207d24:	6f1c                	ld	a5,24(a4)
    80207d26:	c78d                	beqz	a5,80207d50 <_ZN11ProcManager5yieldEv+0xb8>
        tails[p->priority]->next = p;
    80207d28:	7f1c                	ld	a5,56(a4)
    80207d2a:	1527b423          	sd	s2,328(a5)
        tails[p->priority] = p;
    80207d2e:	03273c23          	sd	s2,56(a4)
    count++;
    80207d32:	6eb8                	ld	a4,88(a3)
            swtch(&p->context, &c->context);
    80207d34:	009407b3          	add	a5,s0,s1
    80207d38:	078e                	slli	a5,a5,0x3
    count++;
    80207d3a:	0705                	addi	a4,a4,1
            swtch(&p->context, &c->context);
    80207d3c:	00016597          	auipc	a1,0x16
    80207d40:	16c58593          	addi	a1,a1,364 # 8021dea8 <cpus+0x8>
    count++;
    80207d44:	eeb8                	sd	a4,88(a3)
            swtch(&p->context, &c->context);
    80207d46:	95be                	add	a1,a1,a5
    80207d48:	854a                	mv	a0,s2
    80207d4a:	b02f80ef          	jal	8020004c <swtch>
    80207d4e:	b761                	j	80207cd6 <_ZN11ProcManager5yieldEv+0x3e>
        heads[p->priority] = p;
    80207d50:	01273c23          	sd	s2,24(a4)
        tails[p->priority] = p;
    80207d54:	bfe9                	j	80207d2e <_ZN11ProcManager5yieldEv+0x96>

0000000080207d56 <_ZN11ProcManager9user_initEv>:

    void user_init()
    {
    80207d56:	711d                	addi	sp,sp,-96
    80207d58:	ec86                	sd	ra,88(sp)
        struct Proc *p = allocproc();
    80207d5a:	891ff0ef          	jal	802075ea <_ZL9allocprocv>
        if (!p)
    80207d5e:	10050863          	beqz	a0,80207e6e <_ZN11ProcManager9user_initEv+0x118>
            return;

        initproc = p;
    80207d62:	e8a2                	sd	s0,80(sp)
    80207d64:	e0ca                	sd	s2,64(sp)
    80207d66:	fc4e                	sd	s3,56(sp)
    80207d68:	f852                	sd	s4,48(sp)
    80207d6a:	f456                	sd	s5,40(sp)
    80207d6c:	f05a                	sd	s6,32(sp)
    80207d6e:	e466                	sd	s9,8(sp)
    80207d70:	00016c97          	auipc	s9,0x16
    80207d74:	110c8c93          	addi	s9,s9,272 # 8021de80 <proc_mem_lock>
    80207d78:	892a                	mv	s2,a0
    80207d7a:	76acb023          	sd	a0,1888(s9)

        p->pagetable = VM::uvmcreate();
    80207d7e:	be0fe0ef          	jal	8020615e <_ZN2VM9uvmcreateEv>
    80207d82:	06a93c23          	sd	a0,120(s2)

        uint64 initcode_sz = initcode_end - initcode_start;
    80207d86:	0000da17          	auipc	s4,0xd
    80207d8a:	d52a3a03          	ld	s4,-686(s4) # 80214ad8 <_GLOBAL_OFFSET_TABLE_+0x78>
        Drivers::uart_puts("[Proc] initcode size: ");
    80207d8e:	0000a517          	auipc	a0,0xa
    80207d92:	17a50513          	addi	a0,a0,378 # 80211f08 <initcode_end+0x7c0>
        uint64 initcode_sz = initcode_end - initcode_start;
    80207d96:	0000d997          	auipc	s3,0xd
    80207d9a:	ce29b983          	ld	s3,-798(s3) # 80214a78 <_GLOBAL_OFFSET_TABLE_+0x18>
        Drivers::uart_put_int(initcode_sz);
        Drivers::uart_puts(" bytes\n");

        uint64 code_pages = PGROUNDUP(initcode_sz) / PGSIZE;
    80207d9e:	6b05                	lui	s6,0x1
        uint64 initcode_sz = initcode_end - initcode_start;
    80207da0:	414989b3          	sub	s3,s3,s4
        Drivers::uart_puts("[Proc] initcode size: ");
    80207da4:	7c7000ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        uint64 code_pages = PGROUNDUP(initcode_sz) / PGSIZE;
    80207da8:	1b7d                	addi	s6,s6,-1 # fff <_start-0x801ff001>
        Drivers::uart_put_int(initcode_sz);
    80207daa:	0009851b          	sext.w	a0,s3
        uint64 code_pages = PGROUNDUP(initcode_sz) / PGSIZE;
    80207dae:	9b4e                	add	s6,s6,s3
        Drivers::uart_put_int(initcode_sz);
    80207db0:	018010ef          	jal	80208dc8 <_ZN7Drivers12uart_put_intEi>
        uint64 code_pages = PGROUNDUP(initcode_sz) / PGSIZE;
    80207db4:	00cb5b13          	srli	s6,s6,0xc
        Drivers::uart_puts(" bytes\n");
    80207db8:	0000a517          	auipc	a0,0xa
    80207dbc:	16850513          	addi	a0,a0,360 # 80211f20 <initcode_end+0x7d8>
    80207dc0:	001b0a93          	addi	s5,s6,1
    80207dc4:	7a7000ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>

        for (uint64 i = 0; i < code_pages; i++)
    80207dc8:	0ab2                	slli	s5,s5,0xc
    80207dca:	6405                	lui	s0,0x1
    80207dcc:	080b0663          	beqz	s6,80207e58 <_ZN11ProcManager9user_initEv+0x102>
    80207dd0:	e862                	sd	s8,16(sp)
    80207dd2:	6c05                	lui	s8,0x1
    80207dd4:	ec5e                	sd	s7,24(sp)
    80207dd6:	e4a6                	sd	s1,72(sp)
    80207dd8:	e06a                	sd	s10,0(sp)
                Drivers::uart_puts("user_init: out of memory for code\n");
                return;
            }
            memset(mem, 0, PGSIZE);

            uint64 src_offset = i * PGSIZE;
    80207dda:	7bfd                	lui	s7,0xfffff
    80207ddc:	013c0c3b          	addw	s8,s8,s3
            uint64 copy_len = PGSIZE;
            if (src_offset + copy_len > initcode_sz)
            {
                copy_len = initcode_sz - src_offset;
            }
            memmove(mem, (void *)(initcode_start + src_offset), copy_len);
    80207de0:	408a0a33          	sub	s4,s4,s0
    80207de4:	a82d                	j	80207e1e <_ZN11ProcManager9user_initEv+0xc8>
            memset(mem, 0, PGSIZE);
    80207de6:	844fd0ef          	jal	80204e2a <_Z6memsetPvij>
            memmove(mem, (void *)(initcode_start + src_offset), copy_len);
    80207dea:	008a05b3          	add	a1,s4,s0
    80207dee:	8526                	mv	a0,s1
    80207df0:	6605                	lui	a2,0x1
            uint64 src_offset = i * PGSIZE;
    80207df2:	01740d33          	add	s10,s0,s7
            if (src_offset + copy_len > initcode_sz)
    80207df6:	0089f463          	bgeu	s3,s0,80207dfe <_ZN11ProcManager9user_initEv+0xa8>
    80207dfa:	408c063b          	subw	a2,s8,s0
            memmove(mem, (void *)(initcode_start + src_offset), copy_len);
    80207dfe:	876fd0ef          	jal	80204e74 <_Z7memmovePvPKvj>

            if (VM::mappages(p->pagetable, i * PGSIZE, PGSIZE, (uint64)mem, PTE_R | PTE_W | PTE_X | PTE_U) < 0)
    80207e02:	07893503          	ld	a0,120(s2)
    80207e06:	4779                	li	a4,30
    80207e08:	86a6                	mv	a3,s1
    80207e0a:	6605                	lui	a2,0x1
    80207e0c:	85ea                	mv	a1,s10
    80207e0e:	ad8fe0ef          	jal	802060e6 <_ZN2VM8mappagesEPyyyyi>
        for (uint64 i = 0; i < code_pages; i++)
    80207e12:	6785                	lui	a5,0x1
    80207e14:	943e                	add	s0,s0,a5
            if (VM::mappages(p->pagetable, i * PGSIZE, PGSIZE, (uint64)mem, PTE_R | PTE_W | PTE_X | PTE_U) < 0)
    80207e16:	04054f63          	bltz	a0,80207e74 <_ZN11ProcManager9user_initEv+0x11e>
        for (uint64 i = 0; i < code_pages; i++)
    80207e1a:	03540b63          	beq	s0,s5,80207e50 <_ZN11ProcManager9user_initEv+0xfa>
            void *mem = PMM::alloc_page();
    80207e1e:	b44ff0ef          	jal	80207162 <_ZN3PMM10alloc_pageEv>
            memset(mem, 0, PGSIZE);
    80207e22:	6605                	lui	a2,0x1
    80207e24:	4581                	li	a1,0
            void *mem = PMM::alloc_page();
    80207e26:	84aa                	mv	s1,a0
            if (!mem)
    80207e28:	fd5d                	bnez	a0,80207de6 <_ZN11ProcManager9user_initEv+0x90>
                Drivers::uart_puts("user_init: out of memory for code\n");
    80207e2a:	0000a517          	auipc	a0,0xa
    80207e2e:	0fe50513          	addi	a0,a0,254 # 80211f28 <initcode_end+0x7e0>
            {
                Drivers::uart_puts("user_init: mappages code failed\n");
    80207e32:	6446                	ld	s0,80(sp)
    80207e34:	64a6                	ld	s1,72(sp)
    80207e36:	6906                	ld	s2,64(sp)
    80207e38:	79e2                	ld	s3,56(sp)
    80207e3a:	7a42                	ld	s4,48(sp)
    80207e3c:	7aa2                	ld	s5,40(sp)
    80207e3e:	7b02                	ld	s6,32(sp)
    80207e40:	6be2                	ld	s7,24(sp)
    80207e42:	6c42                	ld	s8,16(sp)
    80207e44:	6ca2                	ld	s9,8(sp)
    80207e46:	6d02                	ld	s10,0(sp)
        c->runqueue->enqueue(p);
        c->runqueue->lock.release();

        Drivers::uart_puts("[Proc] user_init success. PID: 1\n");
        asm volatile("fence.i");
    }
    80207e48:	60e6                	ld	ra,88(sp)
    80207e4a:	6125                	addi	sp,sp,96
                Drivers::uart_puts("user_init: mappages code failed\n");
    80207e4c:	71f0006f          	j	80208d6a <_ZN7Drivers9uart_putsEPKc>
    80207e50:	64a6                	ld	s1,72(sp)
    80207e52:	6be2                	ld	s7,24(sp)
    80207e54:	6c42                	ld	s8,16(sp)
    80207e56:	6d02                	ld	s10,0(sp)
        void *stack = PMM::alloc_page();
    80207e58:	b0aff0ef          	jal	80207162 <_ZN3PMM10alloc_pageEv>
    80207e5c:	842a                	mv	s0,a0
        if (!stack)
    80207e5e:	e105                	bnez	a0,80207e7e <_ZN11ProcManager9user_initEv+0x128>
    80207e60:	6446                	ld	s0,80(sp)
    80207e62:	6906                	ld	s2,64(sp)
    80207e64:	79e2                	ld	s3,56(sp)
    80207e66:	7a42                	ld	s4,48(sp)
    80207e68:	7aa2                	ld	s5,40(sp)
    80207e6a:	7b02                	ld	s6,32(sp)
    80207e6c:	6ca2                	ld	s9,8(sp)
    }
    80207e6e:	60e6                	ld	ra,88(sp)
    80207e70:	6125                	addi	sp,sp,96
    80207e72:	8082                	ret
                Drivers::uart_puts("user_init: mappages code failed\n");
    80207e74:	0000a517          	auipc	a0,0xa
    80207e78:	0dc50513          	addi	a0,a0,220 # 80211f50 <initcode_end+0x808>
    80207e7c:	bf5d                	j	80207e32 <_ZN11ProcManager9user_initEv+0xdc>
        memset(stack, 0, PGSIZE);
    80207e7e:	6605                	lui	a2,0x1
    80207e80:	4581                	li	a1,0
    80207e82:	fa9fc0ef          	jal	80204e2a <_Z6memsetPvij>
        uint64 stack_va = (code_pages + 1) * PGSIZE;
    80207e86:	0b05                	addi	s6,s6,1
        if (VM::mappages(p->pagetable, stack_va, PGSIZE, (uint64)stack, PTE_R | PTE_W | PTE_U) < 0)
    80207e88:	07893503          	ld	a0,120(s2)
        uint64 stack_va = (code_pages + 1) * PGSIZE;
    80207e8c:	0b32                	slli	s6,s6,0xc
        if (VM::mappages(p->pagetable, stack_va, PGSIZE, (uint64)stack, PTE_R | PTE_W | PTE_U) < 0)
    80207e8e:	4759                	li	a4,22
    80207e90:	86a2                	mv	a3,s0
    80207e92:	6605                	lui	a2,0x1
    80207e94:	85da                	mv	a1,s6
    80207e96:	a50fe0ef          	jal	802060e6 <_ZN2VM8mappagesEPyyyyi>
    80207e9a:	fc0543e3          	bltz	a0,80207e60 <_ZN11ProcManager9user_initEv+0x10a>
        if (VM::mappages(p->pagetable, TRAPFRAME, PGSIZE, (uint64)p->tf, PTE_R | PTE_W) < 0)
    80207e9e:	020005b7          	lui	a1,0x2000
    80207ea2:	07093683          	ld	a3,112(s2)
    80207ea6:	07893503          	ld	a0,120(s2)
    80207eaa:	15fd                	addi	a1,a1,-1 # 1ffffff <_start-0x7e200001>
    80207eac:	4719                	li	a4,6
    80207eae:	6605                	lui	a2,0x1
    80207eb0:	05b6                	slli	a1,a1,0xd
    80207eb2:	a34fe0ef          	jal	802060e6 <_ZN2VM8mappagesEPyyyyi>
    80207eb6:	fa0545e3          	bltz	a0,80207e60 <_ZN11ProcManager9user_initEv+0x10a>
        p->tf->epc = 0;
    80207eba:	07093783          	ld	a5,112(s2)
        p->tf->sp = stack_va + PGSIZE;
    80207ebe:	6705                	lui	a4,0x1
    80207ec0:	9b3a                	add	s6,s6,a4
        p->tf->epc = 0;
    80207ec2:	0007bc23          	sd	zero,24(a5) # 1018 <_start-0x801fefe8>
        p->tf->sp = stack_va + PGSIZE;
    80207ec6:	0367b823          	sd	s6,48(a5)
        strcpy(p->name, "initcode");
    80207eca:	0000a597          	auipc	a1,0xa
    80207ece:	0ae58593          	addi	a1,a1,174 # 80211f78 <initcode_end+0x830>
    80207ed2:	09090513          	addi	a0,s2,144
        p->sz = stack_va + PGSIZE;
    80207ed6:	0b693023          	sd	s6,160(s2)
        strcpy(p->name, "initcode");
    80207eda:	ff9fc0ef          	jal	80204ed2 <_Z6strcpyPcPKc>
        proc_mem_lock.release();
    80207ede:	00016517          	auipc	a0,0x16
    80207ee2:	fa250513          	addi	a0,a0,-94 # 8021de80 <proc_mem_lock>
        p->cwd = nullptr;
    80207ee6:	0c093023          	sd	zero,192(s2)
        proc_mem_lock.release();
    80207eea:	c2ffd0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
        c->runqueue->lock.acquire();
    80207eee:	0a0cb503          	ld	a0,160(s9)
    80207ef2:	c8ffd0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
    if (p->priority < 0 || p->priority >= N_PRIO)
    80207ef6:	16892783          	lw	a5,360(s2)
        p->state = RUNNABLE;
    80207efa:	470d                	li	a4,3
    80207efc:	08e92023          	sw	a4,128(s2)
        c->runqueue->enqueue(p);
    80207f00:	0a0cb503          	ld	a0,160(s9)
    if (p->priority < 0 || p->priority >= N_PRIO)
    80207f04:	00f77563          	bgeu	a4,a5,80207f0e <_ZN11ProcManager9user_initEv+0x1b8>
        p->priority = PRIO_MIN;
    80207f08:	16e92423          	sw	a4,360(s2)
    80207f0c:	478d                	li	a5,3
    p->next = nullptr;
    80207f0e:	078e                	slli	a5,a5,0x3
    80207f10:	14093423          	sd	zero,328(s2)
    if (heads[p->priority] == nullptr)
    80207f14:	97aa                	add	a5,a5,a0
    80207f16:	6f98                	ld	a4,24(a5)
    80207f18:	c705                	beqz	a4,80207f40 <_ZN11ProcManager9user_initEv+0x1ea>
        tails[p->priority]->next = p;
    80207f1a:	7f98                	ld	a4,56(a5)
    80207f1c:	15273423          	sd	s2,328(a4) # 1148 <_start-0x801feeb8>
        tails[p->priority] = p;
    80207f20:	0327bc23          	sd	s2,56(a5)
    count++;
    80207f24:	6d3c                	ld	a5,88(a0)
    80207f26:	0785                	addi	a5,a5,1
    80207f28:	ed3c                	sd	a5,88(a0)
        c->runqueue->lock.release();
    80207f2a:	beffd0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
        Drivers::uart_puts("[Proc] user_init success. PID: 1\n");
    80207f2e:	0000a517          	auipc	a0,0xa
    80207f32:	05a50513          	addi	a0,a0,90 # 80211f88 <initcode_end+0x840>
    80207f36:	635000ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        asm volatile("fence.i");
    80207f3a:	0000100f          	fence.i
    80207f3e:	b70d                	j	80207e60 <_ZN11ProcManager9user_initEv+0x10a>
        heads[p->priority] = p;
    80207f40:	0127bc23          	sd	s2,24(a5)
        tails[p->priority] = p;
    80207f44:	bff1                	j	80207f20 <_ZN11ProcManager9user_initEv+0x1ca>

0000000080207f46 <_ZN11ProcManager5sleepEPvP8Spinlock>:

    void sleep(void *chan, Spinlock *lk)
    {
    80207f46:	7139                	addi	sp,sp,-64
    80207f48:	f822                	sd	s0,48(sp)
    80207f4a:	f426                	sd	s1,40(sp)
    80207f4c:	ec4e                	sd	s3,24(sp)
    80207f4e:	fc06                	sd	ra,56(sp)
    80207f50:	f04a                	sd	s2,32(sp)
    80207f52:	89aa                	mv	s3,a0
    80207f54:	84ae                	mv	s1,a1
        struct Proc *p = myproc();
    80207f56:	b2dfd0ef          	jal	80205a82 <_Z6myprocv>
    80207f5a:	842a                	mv	s0,a0
    80207f5c:	8792                	mv	a5,tp
    int id = r_tp();
    80207f5e:	2781                	sext.w	a5,a5
        struct cpu *c = mycpu();

        if (lk && lk != &proc_mem_lock)
    80207f60:	ccd9                	beqz	s1,80207ffe <_ZN11ProcManager5sleepEPvP8Spinlock+0xb8>
            lk->release();

        c->runqueue->lock.acquire();
        p->chan = chan;
        p->state = SLEEPING;
        swtch(&p->context, &c->context);
    80207f62:	00479913          	slli	s2,a5,0x4
    80207f66:	993e                	add	s2,s2,a5
    80207f68:	e852                	sd	s4,16(sp)
    80207f6a:	e456                	sd	s5,8(sp)
    80207f6c:	090e                	slli	s2,s2,0x3
    80207f6e:	00016597          	auipc	a1,0x16
    80207f72:	f3a58593          	addi	a1,a1,-198 # 8021dea8 <cpus+0x8>
    80207f76:	00016a17          	auipc	s4,0x16
    80207f7a:	f0aa0a13          	addi	s4,s4,-246 # 8021de80 <proc_mem_lock>
    80207f7e:	00b90ab3          	add	s5,s2,a1
        if (lk && lk != &proc_mem_lock)
    80207f82:	05448463          	beq	s1,s4,80207fca <_ZN11ProcManager5sleepEPvP8Spinlock+0x84>
            lk->release();
    80207f86:	8526                	mv	a0,s1
    80207f88:	b91fd0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
        c->runqueue->lock.acquire();
    80207f8c:	9a4a                	add	s4,s4,s2
    80207f8e:	0a0a3503          	ld	a0,160(s4)
    80207f92:	beffd0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        p->state = SLEEPING;
    80207f96:	4789                	li	a5,2
        p->chan = chan;
    80207f98:	0b343823          	sd	s3,176(s0) # 10b0 <_start-0x801fef50>
        p->state = SLEEPING;
    80207f9c:	08f42023          	sw	a5,128(s0)
        swtch(&p->context, &c->context);
    80207fa0:	85d6                	mv	a1,s5
    80207fa2:	8522                	mv	a0,s0
    80207fa4:	8a8f80ef          	jal	8020004c <swtch>
        p->chan = 0;
    80207fa8:	0a043823          	sd	zero,176(s0)
        c->runqueue->lock.release();
    80207fac:	0a0a3503          	ld	a0,160(s4)
    80207fb0:	b69fd0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>

        if (lk && lk != &proc_mem_lock)
            lk->acquire();
    }
    80207fb4:	7442                	ld	s0,48(sp)
            lk->acquire();
    80207fb6:	6a42                	ld	s4,16(sp)
    80207fb8:	6aa2                	ld	s5,8(sp)
    }
    80207fba:	70e2                	ld	ra,56(sp)
    80207fbc:	7902                	ld	s2,32(sp)
    80207fbe:	69e2                	ld	s3,24(sp)
            lk->acquire();
    80207fc0:	8526                	mv	a0,s1
    }
    80207fc2:	74a2                	ld	s1,40(sp)
    80207fc4:	6121                	addi	sp,sp,64
            lk->acquire();
    80207fc6:	bbbfd06f          	j	80205b80 <_ZN8Spinlock7acquireEv>
        c->runqueue->lock.acquire();
    80207fca:	94ca                	add	s1,s1,s2
    80207fcc:	70c8                	ld	a0,160(s1)
    80207fce:	bb3fd0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        p->state = SLEEPING;
    80207fd2:	4789                	li	a5,2
        p->chan = chan;
    80207fd4:	0b343823          	sd	s3,176(s0)
        swtch(&p->context, &c->context);
    80207fd8:	8522                	mv	a0,s0
        p->state = SLEEPING;
    80207fda:	08f42023          	sw	a5,128(s0)
        swtch(&p->context, &c->context);
    80207fde:	85d6                	mv	a1,s5
    80207fe0:	86cf80ef          	jal	8020004c <swtch>
        p->chan = 0;
    80207fe4:	0a043823          	sd	zero,176(s0)
    }
    80207fe8:	7442                	ld	s0,48(sp)
        c->runqueue->lock.release();
    80207fea:	70c8                	ld	a0,160(s1)
    80207fec:	6a42                	ld	s4,16(sp)
    80207fee:	6aa2                	ld	s5,8(sp)
    }
    80207ff0:	70e2                	ld	ra,56(sp)
    80207ff2:	74a2                	ld	s1,40(sp)
    80207ff4:	7902                	ld	s2,32(sp)
    80207ff6:	69e2                	ld	s3,24(sp)
    80207ff8:	6121                	addi	sp,sp,64
        c->runqueue->lock.release();
    80207ffa:	b1ffd06f          	j	80205b18 <_ZN8Spinlock7releaseEv>
        c->runqueue->lock.acquire();
    80207ffe:	00479493          	slli	s1,a5,0x4
    80208002:	94be                	add	s1,s1,a5
    80208004:	048e                	slli	s1,s1,0x3
    80208006:	00016917          	auipc	s2,0x16
    8020800a:	e7a90913          	addi	s2,s2,-390 # 8021de80 <proc_mem_lock>
    8020800e:	9926                	add	s2,s2,s1
    80208010:	0a093503          	ld	a0,160(s2)
    80208014:	b6dfd0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        p->state = SLEEPING;
    80208018:	4789                	li	a5,2
        swtch(&p->context, &c->context);
    8020801a:	00016597          	auipc	a1,0x16
    8020801e:	e8e58593          	addi	a1,a1,-370 # 8021dea8 <cpus+0x8>
        p->chan = chan;
    80208022:	0b343823          	sd	s3,176(s0)
        swtch(&p->context, &c->context);
    80208026:	8522                	mv	a0,s0
        p->state = SLEEPING;
    80208028:	08f42023          	sw	a5,128(s0)
        swtch(&p->context, &c->context);
    8020802c:	95a6                	add	a1,a1,s1
    8020802e:	81ef80ef          	jal	8020004c <swtch>
        p->chan = 0;
    80208032:	0a043823          	sd	zero,176(s0)
    }
    80208036:	7442                	ld	s0,48(sp)
        c->runqueue->lock.release();
    80208038:	0a093503          	ld	a0,160(s2)
    }
    8020803c:	70e2                	ld	ra,56(sp)
    8020803e:	74a2                	ld	s1,40(sp)
    80208040:	7902                	ld	s2,32(sp)
    80208042:	69e2                	ld	s3,24(sp)
    80208044:	6121                	addi	sp,sp,64
        c->runqueue->lock.release();
    80208046:	ad3fd06f          	j	80205b18 <_ZN8Spinlock7releaseEv>

000000008020804a <_ZN11ProcManager6wakeupEPv>:

    void wakeup(void *chan)
    {
    8020804a:	7139                	addi	sp,sp,-64
    8020804c:	e456                	sd	s5,8(sp)
        for (struct Proc *p = proc_list_head; p != nullptr; p = p->all_next)
    8020804e:	00016a97          	auipc	s5,0x16
    80208052:	e32a8a93          	addi	s5,s5,-462 # 8021de80 <proc_mem_lock>
    {
    80208056:	f822                	sd	s0,48(sp)
        for (struct Proc *p = proc_list_head; p != nullptr; p = p->all_next)
    80208058:	018ab403          	ld	s0,24(s5)
    {
    8020805c:	fc06                	sd	ra,56(sp)
        for (struct Proc *p = proc_list_head; p != nullptr; p = p->all_next)
    8020805e:	c841                	beqz	s0,802080ee <_ZN11ProcManager6wakeupEPv+0xa4>
    80208060:	f426                	sd	s1,40(sp)
    80208062:	f04a                	sd	s2,32(sp)
    80208064:	4489                	li	s1,2
    80208066:	892a                	mv	s2,a0
    80208068:	a021                	j	80208070 <_ZN11ProcManager6wakeupEPv+0x26>
    8020806a:	15843403          	ld	s0,344(s0)
    8020806e:	cc35                	beqz	s0,802080ea <_ZN11ProcManager6wakeupEPv+0xa0>
        {
            if (p->state == SLEEPING && p->chan == chan)
    80208070:	08042783          	lw	a5,128(s0)
    80208074:	fe979be3          	bne	a5,s1,8020806a <_ZN11ProcManager6wakeupEPv+0x20>
    80208078:	785c                	ld	a5,176(s0)
    8020807a:	ff2798e3          	bne	a5,s2,8020806a <_ZN11ProcManager6wakeupEPv+0x20>
    8020807e:	ec4e                	sd	s3,24(sp)
    80208080:	e852                	sd	s4,16(sp)
    80208082:	e05a                	sd	s6,0(sp)
    80208084:	8b12                	mv	s6,tp
    int id = r_tp();
    80208086:	2b01                	sext.w	s6,s6
            {
                struct cpu *c = mycpu();
                c->runqueue->lock.acquire();
    80208088:	004b1993          	slli	s3,s6,0x4
    8020808c:	01698a33          	add	s4,s3,s6
    80208090:	0a0e                	slli	s4,s4,0x3
    80208092:	9a56                	add	s4,s4,s5
    80208094:	0a0a3503          	ld	a0,160(s4)
    80208098:	ae9fd0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
    if (p->priority < 0 || p->priority >= N_PRIO)
    8020809c:	16842783          	lw	a5,360(s0)
                p->state = RUNNABLE;
    802080a0:	468d                	li	a3,3
    802080a2:	08d42023          	sw	a3,128(s0)
                c->runqueue->enqueue(p);
    802080a6:	0a0a3703          	ld	a4,160(s4)
    if (p->priority < 0 || p->priority >= N_PRIO)
    802080aa:	00f6f563          	bgeu	a3,a5,802080b4 <_ZN11ProcManager6wakeupEPv+0x6a>
        p->priority = PRIO_MIN;
    802080ae:	16d42423          	sw	a3,360(s0)
    802080b2:	478d                	li	a5,3
    802080b4:	078e                	slli	a5,a5,0x3
    p->next = nullptr;
    802080b6:	14043423          	sd	zero,328(s0)
    if (heads[p->priority] == nullptr)
    802080ba:	97ba                	add	a5,a5,a4
    802080bc:	6f94                	ld	a3,24(a5)
    802080be:	ce8d                	beqz	a3,802080f8 <_ZN11ProcManager6wakeupEPv+0xae>
        tails[p->priority]->next = p;
    802080c0:	7f94                	ld	a3,56(a5)
    802080c2:	1486b423          	sd	s0,328(a3)
        tails[p->priority] = p;
    802080c6:	ff80                	sd	s0,56(a5)
                c->runqueue->lock.release();
    802080c8:	016987b3          	add	a5,s3,s6
    count++;
    802080cc:	6f34                	ld	a3,88(a4)
                c->runqueue->lock.release();
    802080ce:	078e                	slli	a5,a5,0x3
    802080d0:	97d6                	add	a5,a5,s5
    802080d2:	73c8                	ld	a0,160(a5)
    count++;
    802080d4:	00168793          	addi	a5,a3,1
    802080d8:	ef3c                	sd	a5,88(a4)
                c->runqueue->lock.release();
    802080da:	a3ffd0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
        for (struct Proc *p = proc_list_head; p != nullptr; p = p->all_next)
    802080de:	15843403          	ld	s0,344(s0)
                c->runqueue->lock.release();
    802080e2:	69e2                	ld	s3,24(sp)
    802080e4:	6a42                	ld	s4,16(sp)
    802080e6:	6b02                	ld	s6,0(sp)
        for (struct Proc *p = proc_list_head; p != nullptr; p = p->all_next)
    802080e8:	f441                	bnez	s0,80208070 <_ZN11ProcManager6wakeupEPv+0x26>
    802080ea:	74a2                	ld	s1,40(sp)
    802080ec:	7902                	ld	s2,32(sp)
            }
        }
    }
    802080ee:	70e2                	ld	ra,56(sp)
    802080f0:	7442                	ld	s0,48(sp)
    802080f2:	6aa2                	ld	s5,8(sp)
    802080f4:	6121                	addi	sp,sp,64
    802080f6:	8082                	ret
        heads[p->priority] = p;
    802080f8:	ef80                	sd	s0,24(a5)
        tails[p->priority] = p;
    802080fa:	b7f1                	j	802080c6 <_ZN11ProcManager6wakeupEPv+0x7c>

00000000802080fc <_ZN11ProcManager4exitEi>:

    void exit(int status)
    {
    802080fc:	7179                	addi	sp,sp,-48
    802080fe:	e84a                	sd	s2,16(sp)
    80208100:	e44e                	sd	s3,8(sp)
    80208102:	f406                	sd	ra,40(sp)
    80208104:	89aa                	mv	s3,a0
        struct Proc *p = myproc();
        if (p == initproc)
    80208106:	00016917          	auipc	s2,0x16
    8020810a:	d7a90913          	addi	s2,s2,-646 # 8021de80 <proc_mem_lock>
        struct Proc *p = myproc();
    8020810e:	975fd0ef          	jal	80205a82 <_Z6myprocv>
        if (p == initproc)
    80208112:	76093783          	ld	a5,1888(s2)
    80208116:	04a78d63          	beq	a5,a0,80208170 <_ZN11ProcManager4exitEi+0x74>
            while (1)
                ;

        wakeup(p->parent);
    8020811a:	ec26                	sd	s1,24(sp)
    8020811c:	84aa                	mv	s1,a0
    8020811e:	7548                	ld	a0,168(a0)
    80208120:	f022                	sd	s0,32(sp)
    80208122:	f29ff0ef          	jal	8020804a <_ZN11ProcManager6wakeupEPv>

        proc_mem_lock.acquire();
    80208126:	854a                	mv	a0,s2
    80208128:	a59fd0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>

        for (struct Proc *pp = proc_list_head; pp != nullptr; pp = pp->all_next)
    8020812c:	01893403          	ld	s0,24(s2)
    80208130:	e829                	bnez	s0,80208182 <_ZN11ProcManager4exitEi+0x86>
                pp->parent = initproc;
                wakeup(initproc);
            }
        }

        proc_mem_lock.release();
    80208132:	00016517          	auipc	a0,0x16
    80208136:	d4e50513          	addi	a0,a0,-690 # 8021de80 <proc_mem_lock>
    8020813a:	9dffd0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>

        p->xstate = status;
    8020813e:	0b34ac23          	sw	s3,184(s1)
    80208142:	8412                	mv	s0,tp

        struct cpu *c = mycpu();
        c->runqueue->lock.acquire();
    80208144:	08800793          	li	a5,136
    int id = r_tp();
    80208148:	2401                	sext.w	s0,s0
        c->runqueue->lock.acquire();
    8020814a:	02f40433          	mul	s0,s0,a5
    8020814e:	9922                	add	s2,s2,s0
    80208150:	0a093503          	ld	a0,160(s2)
    80208154:	a2dfd0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        p->state = ZOMBIE;
    80208158:	4795                	li	a5,5
        swtch(&p->context, &c->context);
    8020815a:	00016597          	auipc	a1,0x16
    8020815e:	d4e58593          	addi	a1,a1,-690 # 8021dea8 <cpus+0x8>
        p->state = ZOMBIE;
    80208162:	08f4a023          	sw	a5,128(s1)
        swtch(&p->context, &c->context);
    80208166:	95a2                	add	a1,a1,s0
    80208168:	8526                	mv	a0,s1
    8020816a:	ee3f70ef          	jal	8020004c <swtch>
        while (1)
    8020816e:	a001                	j	8020816e <_ZN11ProcManager4exitEi+0x72>
            while (1)
    80208170:	a001                	j	80208170 <_ZN11ProcManager4exitEi+0x74>
                pp->parent = initproc;
    80208172:	76093503          	ld	a0,1888(s2)
    80208176:	f448                	sd	a0,168(s0)
                wakeup(initproc);
    80208178:	ed3ff0ef          	jal	8020804a <_ZN11ProcManager6wakeupEPv>
        for (struct Proc *pp = proc_list_head; pp != nullptr; pp = pp->all_next)
    8020817c:	15843403          	ld	s0,344(s0)
    80208180:	d84d                	beqz	s0,80208132 <_ZN11ProcManager4exitEi+0x36>
            if (pp->parent == p)
    80208182:	745c                	ld	a5,168(s0)
    80208184:	fe979ce3          	bne	a5,s1,8020817c <_ZN11ProcManager4exitEi+0x80>
    80208188:	b7ed                	j	80208172 <_ZN11ProcManager4exitEi+0x76>

000000008020818a <_ZN11ProcManager4waitEy>:
            ;
    }

    int wait(uint64 addr)
    {
    8020818a:	715d                	addi	sp,sp,-80
    8020818c:	e486                	sd	ra,72(sp)
    8020818e:	e0a2                	sd	s0,64(sp)
    80208190:	fc26                	sd	s1,56(sp)
    80208192:	f84a                	sd	s2,48(sp)
    80208194:	f44e                	sd	s3,40(sp)
    80208196:	f052                	sd	s4,32(sp)
    80208198:	ec56                	sd	s5,24(sp)
    8020819a:	e45e                	sd	s7,8(sp)
    8020819c:	00016917          	auipc	s2,0x16
    802081a0:	ce490913          	addi	s2,s2,-796 # 8021de80 <proc_mem_lock>
    802081a4:	e85a                	sd	s6,16(sp)
    802081a6:	e062                	sd	s8,0(sp)
    802081a8:	89aa                	mv	s3,a0

        struct Proc *np;
        int havekids, pid;
        struct Proc *p = myproc();
    802081aa:	8d9fd0ef          	jal	80205a82 <_Z6myprocv>
    802081ae:	84aa                	mv	s1,a0
        for (;;)
        {
            havekids = 0;
            proc_mem_lock.acquire();
    802081b0:	854a                	mv	a0,s2
    802081b2:	9cffd0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>

            for (np = proc_list_head; np != nullptr; np = np->all_next)
    802081b6:	01893403          	ld	s0,24(s2)
            {
                if (np->parent == p)
                {
                    havekids = 1;
                    if (np->state == ZOMBIE)
    802081ba:	4b95                	li	s7,5
        p->state = SLEEPING;
    802081bc:	4a89                	li	s5,2
        swtch(&p->context, &c->context);
    802081be:	00016a17          	auipc	s4,0x16
    802081c2:	ce2a0a13          	addi	s4,s4,-798 # 8021dea0 <cpus>
            for (np = proc_list_head; np != nullptr; np = np->all_next)
    802081c6:	0e040963          	beqz	s0,802082b8 <_ZN11ProcManager4waitEy+0x12e>
            havekids = 0;
    802081ca:	4b01                	li	s6,0
    802081cc:	a021                	j	802081d4 <_ZN11ProcManager4waitEy+0x4a>
            for (np = proc_list_head; np != nullptr; np = np->all_next)
    802081ce:	15843403          	ld	s0,344(s0)
    802081d2:	c441                	beqz	s0,8020825a <_ZN11ProcManager4waitEy+0xd0>
                if (np->parent == p)
    802081d4:	745c                	ld	a5,168(s0)
    802081d6:	fe979ce3          	bne	a5,s1,802081ce <_ZN11ProcManager4waitEy+0x44>
                    if (np->state == ZOMBIE)
    802081da:	08042783          	lw	a5,128(s0)
                    havekids = 1;
    802081de:	4b05                	li	s6,1
                    if (np->state == ZOMBIE)
    802081e0:	ff7797e3          	bne	a5,s7,802081ce <_ZN11ProcManager4waitEy+0x44>
                    {

                        struct cpu *child_cpu = np->cpu;
    802081e4:	17043903          	ld	s2,368(s0)
                        if (child_cpu)
    802081e8:	02090663          	beqz	s2,80208214 <_ZN11ProcManager4waitEy+0x8a>
                        {
                            proc_mem_lock.release();
    802081ec:	00016517          	auipc	a0,0x16
    802081f0:	c9450513          	addi	a0,a0,-876 # 8021de80 <proc_mem_lock>
    802081f4:	925fd0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
                            child_cpu->runqueue->lock.acquire();
    802081f8:	08093503          	ld	a0,128(s2)
    802081fc:	985fd0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
                            child_cpu->runqueue->lock.release();
    80208200:	08093503          	ld	a0,128(s2)
    80208204:	915fd0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
                            proc_mem_lock.acquire();
    80208208:	00016517          	auipc	a0,0x16
    8020820c:	c7850513          	addi	a0,a0,-904 # 8021de80 <proc_mem_lock>
    80208210:	971fd0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
                        }

                        pid = np->pid;
    80208214:	08442903          	lw	s2,132(s0)
                        if (addr != 0 && VM::copyout(p->pagetable, addr, (char *)&np->xstate, sizeof(np->xstate)) < 0)
    80208218:	00098b63          	beqz	s3,8020822e <_ZN11ProcManager4waitEy+0xa4>
    8020821c:	7ca8                	ld	a0,120(s1)
    8020821e:	4691                	li	a3,4
    80208220:	0b840613          	addi	a2,s0,184
    80208224:	85ce                	mv	a1,s3
    80208226:	c7cfe0ef          	jal	802066a2 <_ZN2VM7copyoutEPyyPcy>
    8020822a:	08054763          	bltz	a0,802082b8 <_ZN11ProcManager4waitEy+0x12e>
                        {
                            proc_mem_lock.release();
                            return -1;
                        }
                        freeproc(np);
    8020822e:	8522                	mv	a0,s0
    80208230:	cf8ff0ef          	jal	80207728 <_ZL8freeprocP4Proc>
                        proc_mem_lock.release();
    80208234:	00016517          	auipc	a0,0x16
    80208238:	c4c50513          	addi	a0,a0,-948 # 8021de80 <proc_mem_lock>
    8020823c:	8ddfd0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>

            if (!havekids || p->state == ZOMBIE)
                return -1;
            sleep(p, &proc_mem_lock);
        }
    }
    80208240:	60a6                	ld	ra,72(sp)
    80208242:	6406                	ld	s0,64(sp)
    80208244:	74e2                	ld	s1,56(sp)
    80208246:	79a2                	ld	s3,40(sp)
    80208248:	7a02                	ld	s4,32(sp)
    8020824a:	6ae2                	ld	s5,24(sp)
    8020824c:	6b42                	ld	s6,16(sp)
    8020824e:	6ba2                	ld	s7,8(sp)
    80208250:	6c02                	ld	s8,0(sp)
    80208252:	854a                	mv	a0,s2
    80208254:	7942                	ld	s2,48(sp)
    80208256:	6161                	addi	sp,sp,80
    80208258:	8082                	ret
            proc_mem_lock.release();
    8020825a:	854a                	mv	a0,s2
    8020825c:	8bdfd0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
            if (!havekids || p->state == ZOMBIE)
    80208260:	060b0263          	beqz	s6,802082c4 <_ZN11ProcManager4waitEy+0x13a>
    80208264:	0804a783          	lw	a5,128(s1)
    80208268:	05778e63          	beq	a5,s7,802082c4 <_ZN11ProcManager4waitEy+0x13a>
        struct Proc *p = myproc();
    8020826c:	817fd0ef          	jal	80205a82 <_Z6myprocv>
    80208270:	8b2a                	mv	s6,a0
    80208272:	8792                	mv	a5,tp
    int id = r_tp();
    80208274:	2781                	sext.w	a5,a5
        c->runqueue->lock.acquire();
    80208276:	00479413          	slli	s0,a5,0x4
    8020827a:	943e                	add	s0,s0,a5
    8020827c:	040e                	slli	s0,s0,0x3
    8020827e:	00890c33          	add	s8,s2,s0
    80208282:	0a0c3503          	ld	a0,160(s8) # 10a0 <_start-0x801fef60>
    80208286:	8fbfd0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        swtch(&p->context, &c->context);
    8020828a:	00840593          	addi	a1,s0,8
    8020828e:	95d2                	add	a1,a1,s4
    80208290:	855a                	mv	a0,s6
        p->chan = chan;
    80208292:	0a9b3823          	sd	s1,176(s6)
        p->state = SLEEPING;
    80208296:	095b2023          	sw	s5,128(s6)
        swtch(&p->context, &c->context);
    8020829a:	db3f70ef          	jal	8020004c <swtch>
        p->chan = 0;
    8020829e:	0a0b3823          	sd	zero,176(s6)
        c->runqueue->lock.release();
    802082a2:	0a0c3503          	ld	a0,160(s8)
    802082a6:	873fd0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
            proc_mem_lock.acquire();
    802082aa:	854a                	mv	a0,s2
    802082ac:	8d5fd0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
            for (np = proc_list_head; np != nullptr; np = np->all_next)
    802082b0:	01893403          	ld	s0,24(s2)
    802082b4:	f0041be3          	bnez	s0,802081ca <_ZN11ProcManager4waitEy+0x40>
                            proc_mem_lock.release();
    802082b8:	00016517          	auipc	a0,0x16
    802082bc:	bc850513          	addi	a0,a0,-1080 # 8021de80 <proc_mem_lock>
    802082c0:	859fd0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
                            return -1;
    802082c4:	597d                	li	s2,-1
    802082c6:	bfad                	j	80208240 <_ZN11ProcManager4waitEy+0xb6>

00000000802082c8 <_ZN11ProcManager4killEi>:

    int kill(int pid)
    {
    802082c8:	7139                	addi	sp,sp,-64
    802082ca:	f04a                	sd	s2,32(sp)
        Proc* p;
        proc_mem_lock.acquire();
    802082cc:	00016917          	auipc	s2,0x16
    802082d0:	bb490913          	addi	s2,s2,-1100 # 8021de80 <proc_mem_lock>
    {
    802082d4:	f426                	sd	s1,40(sp)
    802082d6:	84aa                	mv	s1,a0
        proc_mem_lock.acquire();
    802082d8:	854a                	mv	a0,s2
    {
    802082da:	f822                	sd	s0,48(sp)
    802082dc:	fc06                	sd	ra,56(sp)
        proc_mem_lock.acquire();
    802082de:	8a3fd0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        for (p = proc_list_head; p != nullptr; p = p->all_next)
    802082e2:	01893403          	ld	s0,24(s2)
    802082e6:	e409                	bnez	s0,802082f0 <_ZN11ProcManager4killEi+0x28>
    802082e8:	a82d                	j	80208322 <_ZN11ProcManager4killEi+0x5a>
    802082ea:	15843403          	ld	s0,344(s0)
    802082ee:	c815                	beqz	s0,80208322 <_ZN11ProcManager4killEi+0x5a>
        {
            if (p->pid == pid)
    802082f0:	08442783          	lw	a5,132(s0)
    802082f4:	fe979be3          	bne	a5,s1,802082ea <_ZN11ProcManager4killEi+0x22>
            {
                p->killed = 1;

                if (p->state == SLEEPING)
    802082f8:	08042703          	lw	a4,128(s0)
                p->killed = 1;
    802082fc:	4785                	li	a5,1
    802082fe:	0af42e23          	sw	a5,188(s0)
                if (p->state == SLEEPING)
    80208302:	4789                	li	a5,2
    80208304:	02f70c63          	beq	a4,a5,8020833c <_ZN11ProcManager4killEi+0x74>
                    c->runqueue->lock.acquire();
                    c->runqueue->enqueue(p);
                    c->runqueue->lock.release();
                }

                proc_mem_lock.release();
    80208308:	00016517          	auipc	a0,0x16
    8020830c:	b7850513          	addi	a0,a0,-1160 # 8021de80 <proc_mem_lock>
    80208310:	809fd0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
                return 0;
            }
        }
        proc_mem_lock.release();
        return -1;
    }
    80208314:	70e2                	ld	ra,56(sp)
    80208316:	7442                	ld	s0,48(sp)
    80208318:	74a2                	ld	s1,40(sp)
    8020831a:	7902                	ld	s2,32(sp)
                return 0;
    8020831c:	4501                	li	a0,0
    }
    8020831e:	6121                	addi	sp,sp,64
    80208320:	8082                	ret
        proc_mem_lock.release();
    80208322:	00016517          	auipc	a0,0x16
    80208326:	b5e50513          	addi	a0,a0,-1186 # 8021de80 <proc_mem_lock>
    8020832a:	feefd0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
    }
    8020832e:	70e2                	ld	ra,56(sp)
    80208330:	7442                	ld	s0,48(sp)
    80208332:	74a2                	ld	s1,40(sp)
    80208334:	7902                	ld	s2,32(sp)
        return -1;
    80208336:	557d                	li	a0,-1
    }
    80208338:	6121                	addi	sp,sp,64
    8020833a:	8082                	ret
                    p->state = RUNNABLE;
    8020833c:	e456                	sd	s5,8(sp)
    8020833e:	ec4e                	sd	s3,24(sp)
    80208340:	e852                	sd	s4,16(sp)
    80208342:	4a8d                	li	s5,3
    80208344:	09542023          	sw	s5,128(s0)
    80208348:	8a12                	mv	s4,tp
    int id = r_tp();
    8020834a:	2a01                	sext.w	s4,s4
                    c->runqueue->lock.acquire();
    8020834c:	004a1493          	slli	s1,s4,0x4
    80208350:	014489b3          	add	s3,s1,s4
    80208354:	098e                	slli	s3,s3,0x3
    80208356:	99ca                	add	s3,s3,s2
    80208358:	0a09b503          	ld	a0,160(s3)
    8020835c:	825fd0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
    if (p->priority < 0 || p->priority >= N_PRIO)
    80208360:	16842783          	lw	a5,360(s0)
                    c->runqueue->enqueue(p);
    80208364:	0a09b703          	ld	a4,160(s3)
    if (p->priority < 0 || p->priority >= N_PRIO)
    80208368:	02faec63          	bltu	s5,a5,802083a0 <_ZN11ProcManager4killEi+0xd8>
    p->next = nullptr;
    8020836c:	078e                	slli	a5,a5,0x3
    8020836e:	14043423          	sd	zero,328(s0)
    if (heads[p->priority] == nullptr)
    80208372:	97ba                	add	a5,a5,a4
    80208374:	6f94                	ld	a3,24(a5)
    80208376:	ca8d                	beqz	a3,802083a8 <_ZN11ProcManager4killEi+0xe0>
        tails[p->priority]->next = p;
    80208378:	7f94                	ld	a3,56(a5)
    8020837a:	1486b423          	sd	s0,328(a3)
        tails[p->priority] = p;
    8020837e:	ff80                	sd	s0,56(a5)
                    c->runqueue->lock.release();
    80208380:	014487b3          	add	a5,s1,s4
    count++;
    80208384:	6f34                	ld	a3,88(a4)
                    c->runqueue->lock.release();
    80208386:	078e                	slli	a5,a5,0x3
    80208388:	993e                	add	s2,s2,a5
    8020838a:	0a093503          	ld	a0,160(s2)
    count++;
    8020838e:	00168793          	addi	a5,a3,1
    80208392:	ef3c                	sd	a5,88(a4)
                    c->runqueue->lock.release();
    80208394:	f84fd0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
    80208398:	69e2                	ld	s3,24(sp)
    8020839a:	6a42                	ld	s4,16(sp)
    8020839c:	6aa2                	ld	s5,8(sp)
    8020839e:	b7ad                	j	80208308 <_ZN11ProcManager4killEi+0x40>
        p->priority = PRIO_MIN;
    802083a0:	17542423          	sw	s5,360(s0)
    802083a4:	478d                	li	a5,3
    802083a6:	b7d9                	j	8020836c <_ZN11ProcManager4killEi+0xa4>
        heads[p->priority] = p;
    802083a8:	ef80                	sd	s0,24(a5)
        tails[p->priority] = p;
    802083aa:	bfd1                	j	8020837e <_ZN11ProcManager4killEi+0xb6>

00000000802083ac <_ZN11ProcManager8growprocEi>:

    int growproc(int n)
    {
    802083ac:	1101                	addi	sp,sp,-32
    802083ae:	e822                	sd	s0,16(sp)
    802083b0:	e426                	sd	s1,8(sp)
    802083b2:	ec06                	sd	ra,24(sp)
    802083b4:	84aa                	mv	s1,a0
        uint64 sz;
        struct Proc *p = myproc();
    802083b6:	eccfd0ef          	jal	80205a82 <_Z6myprocv>

        sz = p->sz;
    802083ba:	714c                	ld	a1,160(a0)
        struct Proc *p = myproc();
    802083bc:	842a                	mv	s0,a0

        if (n > 0)
    802083be:	00904a63          	bgtz	s1,802083d2 <_ZN11ProcManager8growprocEi+0x26>
            if ((sz = VM::uvmalloc(p->pagetable, sz, sz + n, PTE_W | PTE_R | PTE_U)) == 0)
            {
                return -1;
            }
        }
        else if (n < 0)
    802083c2:	e095                	bnez	s1,802083e6 <_ZN11ProcManager8growprocEi+0x3a>
        {
            sz = VM::uvmdealloc(p->pagetable, sz, sz + n);
        }

        p->sz = sz;
    802083c4:	f04c                	sd	a1,160(s0)
        return 0;
    802083c6:	4501                	li	a0,0
    }
    802083c8:	60e2                	ld	ra,24(sp)
    802083ca:	6442                	ld	s0,16(sp)
    802083cc:	64a2                	ld	s1,8(sp)
    802083ce:	6105                	addi	sp,sp,32
    802083d0:	8082                	ret
            if ((sz = VM::uvmalloc(p->pagetable, sz, sz + n, PTE_W | PTE_R | PTE_U)) == 0)
    802083d2:	7d28                	ld	a0,120(a0)
    802083d4:	00b48633          	add	a2,s1,a1
    802083d8:	46d9                	li	a3,22
    802083da:	e41fd0ef          	jal	8020621a <_ZN2VM8uvmallocEPyyyi>
    802083de:	85aa                	mv	a1,a0
    802083e0:	f175                	bnez	a0,802083c4 <_ZN11ProcManager8growprocEi+0x18>
                return -1;
    802083e2:	557d                	li	a0,-1
    802083e4:	b7d5                	j	802083c8 <_ZN11ProcManager8growprocEi+0x1c>
            sz = VM::uvmdealloc(p->pagetable, sz, sz + n);
    802083e6:	7d28                	ld	a0,120(a0)
    802083e8:	00b48633          	add	a2,s1,a1
    802083ec:	efffd0ef          	jal	802062ea <_ZN2VM10uvmdeallocEPyyy>
    802083f0:	85aa                	mv	a1,a0
    802083f2:	bfc9                	j	802083c4 <_ZN11ProcManager8growprocEi+0x18>

00000000802083f4 <_ZN11ProcManager20create_kernel_threadEPFvvEPKc>:

    void create_kernel_thread(void (*func)(), const char *name)
    {
        (void)func;
        (void)name;
    }
    802083f4:	8082                	ret

00000000802083f6 <_GLOBAL__sub_I_proc_list_head>:
    802083f6:	00009717          	auipc	a4,0x9
    802083fa:	39270713          	addi	a4,a4,914 # 80211788 <initcode_end+0x40>
    802083fe:	00016797          	auipc	a5,0x16
    80208402:	a807a123          	sw	zero,-1406(a5) # 8021de80 <proc_mem_lock>
    80208406:	00016797          	auipc	a5,0x16
    8020840a:	a8e7b123          	sd	a4,-1406(a5) # 8021de88 <proc_mem_lock+0x8>
    8020840e:	00016797          	auipc	a5,0x16
    80208412:	a807b123          	sd	zero,-1406(a5) # 8021de90 <proc_mem_lock+0x10>
struct RunQueue runqueues[NCPU];
    80208416:	00016797          	auipc	a5,0x16
    8020841a:	eca78793          	addi	a5,a5,-310 # 8021e2e0 <runqueues>
    8020841e:	00016697          	auipc	a3,0x16
    80208422:	1c268693          	addi	a3,a3,450 # 8021e5e0 <initproc>
    80208426:	0007a023          	sw	zero,0(a5)
    8020842a:	e798                	sd	a4,8(a5)
    8020842c:	0007b823          	sd	zero,16(a5)
    80208430:	06078793          	addi	a5,a5,96
    80208434:	fed799e3          	bne	a5,a3,80208426 <_GLOBAL__sub_I_proc_list_head+0x30>
    80208438:	8082                	ret

000000008020843a <_ZN11BufferCache4initEv>:
        struct Buf buf[NBUF];
        struct Buf head;
    } bcache;

    void init()
    {
    8020843a:	7179                	addi	sp,sp,-48
    8020843c:	ec26                	sd	s1,24(sp)
    8020843e:	e84a                	sd	s2,16(sp)
        bcache.lock.init("bcache");
        // Initialize LRU doubly circular linked list
        bcache.head.prev = &bcache.head;
    80208440:	0001e497          	auipc	s1,0x1e
    80208444:	1a848493          	addi	s1,s1,424 # 802265e8 <_ZN11BufferCache6bcacheE+0x8000>
    80208448:	0001e917          	auipc	s2,0x1e
    8020844c:	40890913          	addi	s2,s2,1032 # 80226850 <_ZN11BufferCache6bcacheE+0x8268>
        bcache.lock.init("bcache");
    80208450:	0000a597          	auipc	a1,0xa
    80208454:	b6058593          	addi	a1,a1,-1184 # 80211fb0 <initcode_end+0x868>
    80208458:	00016517          	auipc	a0,0x16
    8020845c:	19050513          	addi	a0,a0,400 # 8021e5e8 <_ZN11BufferCache6bcacheE>
    {
    80208460:	f022                	sd	s0,32(sp)
    80208462:	e44e                	sd	s3,8(sp)
    80208464:	f406                	sd	ra,40(sp)
        bcache.head.next = &bcache.head;
        for (struct Buf *b = bcache.buf; b < bcache.buf + NBUF; ++b)
    80208466:	00016417          	auipc	s0,0x16
    8020846a:	19a40413          	addi	s0,s0,410 # 8021e600 <_ZN11BufferCache6bcacheE+0x18>
        bcache.lock.init("bcache");
    8020846e:	d6cfd0ef          	jal	802059da <_ZN8Spinlock4initEPKc>
        {
            b->lock.init("buffer");
    80208472:	0000a997          	auipc	s3,0xa
    80208476:	b4698993          	addi	s3,s3,-1210 # 80211fb8 <initcode_end+0x870>
        bcache.head.prev = &bcache.head;
    8020847a:	2924b023          	sd	s2,640(s1)
        bcache.head.next = &bcache.head;
    8020847e:	2924b423          	sd	s2,648(s1)
            b->lock.init("buffer");
    80208482:	42840513          	addi	a0,s0,1064
    80208486:	85ce                	mv	a1,s3
    80208488:	d5efd0ef          	jal	802059e6 <_ZN5Mutex4initEPKc>
            b->next = bcache.head.next;
    8020848c:	2884b783          	ld	a5,648(s1)
            b->prev = &bcache.head;
    80208490:	01243c23          	sd	s2,24(s0)
            b->next = bcache.head.next;
    80208494:	f01c                	sd	a5,32(s0)
            bcache.head.next->prev = b;
    80208496:	2884b783          	ld	a5,648(s1)
    8020849a:	ef80                	sd	s0,24(a5)
            bcache.head.next = b;
    8020849c:	2884b423          	sd	s0,648(s1)
        for (struct Buf *b = bcache.buf; b < bcache.buf + NBUF; ++b)
    802084a0:	45840413          	addi	s0,s0,1112
    802084a4:	fd241fe3          	bne	s0,s2,80208482 <_ZN11BufferCache4initEv+0x48>
        }
        Drivers::uart_puts("[Bio] Buffer cache initialized.\n");
    }
    802084a8:	7402                	ld	s0,32(sp)
    802084aa:	70a2                	ld	ra,40(sp)
    802084ac:	64e2                	ld	s1,24(sp)
    802084ae:	6942                	ld	s2,16(sp)
    802084b0:	69a2                	ld	s3,8(sp)
        Drivers::uart_puts("[Bio] Buffer cache initialized.\n");
    802084b2:	0000a517          	auipc	a0,0xa
    802084b6:	b0e50513          	addi	a0,a0,-1266 # 80211fc0 <initcode_end+0x878>
    }
    802084ba:	6145                	addi	sp,sp,48
        Drivers::uart_puts("[Bio] Buffer cache initialized.\n");
    802084bc:	0af0006f          	j	80208d6a <_ZN7Drivers9uart_putsEPKc>

00000000802084c0 <_ZN11BufferCache5breadEjj>:
        while (1)
            ;
    }

    struct Buf* bread(uint32 dev, uint32 blockno)
    {
    802084c0:	1101                	addi	sp,sp,-32
    802084c2:	e426                	sd	s1,8(sp)
    802084c4:	84aa                	mv	s1,a0
        bcache.lock.acquire();
    802084c6:	00016517          	auipc	a0,0x16
    802084ca:	12250513          	addi	a0,a0,290 # 8021e5e8 <_ZN11BufferCache6bcacheE>
    {
    802084ce:	e822                	sd	s0,16(sp)
    802084d0:	e04a                	sd	s2,0(sp)
    802084d2:	ec06                	sd	ra,24(sp)
    802084d4:	892e                	mv	s2,a1
        bcache.lock.acquire();
    802084d6:	eaafd0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        for (b = bcache.head.next; b != &bcache.head; b = b->next)
    802084da:	0001e697          	auipc	a3,0x1e
    802084de:	10e68693          	addi	a3,a3,270 # 802265e8 <_ZN11BufferCache6bcacheE+0x8000>
    802084e2:	2886b403          	ld	s0,648(a3)
    802084e6:	0001e717          	auipc	a4,0x1e
    802084ea:	36a70713          	addi	a4,a4,874 # 80226850 <_ZN11BufferCache6bcacheE+0x8268>
    802084ee:	00e41663          	bne	s0,a4,802084fa <_ZN11BufferCache5breadEjj+0x3a>
    802084f2:	a889                	j	80208544 <_ZN11BufferCache5breadEjj+0x84>
    802084f4:	7000                	ld	s0,32(s0)
    802084f6:	04e40763          	beq	s0,a4,80208544 <_ZN11BufferCache5breadEjj+0x84>
            if (b->dev == dev && b->blockno == blockno)
    802084fa:	441c                	lw	a5,8(s0)
    802084fc:	fe979ce3          	bne	a5,s1,802084f4 <_ZN11BufferCache5breadEjj+0x34>
    80208500:	445c                	lw	a5,12(s0)
    80208502:	ff2799e3          	bne	a5,s2,802084f4 <_ZN11BufferCache5breadEjj+0x34>
                b->refcnt++;
    80208506:	481c                	lw	a5,16(s0)
                bcache.lock.release();
    80208508:	00016517          	auipc	a0,0x16
    8020850c:	0e050513          	addi	a0,a0,224 # 8021e5e8 <_ZN11BufferCache6bcacheE>
                b->refcnt++;
    80208510:	2785                	addiw	a5,a5,1
    80208512:	c81c                	sw	a5,16(s0)
                bcache.lock.release();
    80208514:	e04fd0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
                b->lock.acquire(); // Acquire Sleep Lock
    80208518:	42840513          	addi	a0,s0,1064
    8020851c:	f12fd0ef          	jal	80205c2e <_ZN5Mutex7acquireEv>
        struct Buf *b = bget(dev, blockno);

        if (!b->valid)
    80208520:	401c                	lw	a5,0(s0)
    80208522:	e3b5                	bnez	a5,80208586 <_ZN11BufferCache5breadEjj+0xc6>
        {
            VirtIO::rw(0, b->blockno, (char *)b->data);
    80208524:	00c46583          	lwu	a1,12(s0)
    80208528:	02840613          	addi	a2,s0,40
    8020852c:	4501                	li	a0,0
    8020852e:	7d5000ef          	jal	80209502 <_ZN6VirtIO2rwEiyPc>
            b->valid = 1;
    80208532:	4785                	li	a5,1
        }

        return b;
    }
    80208534:	60e2                	ld	ra,24(sp)
            b->valid = 1;
    80208536:	c01c                	sw	a5,0(s0)
    }
    80208538:	8522                	mv	a0,s0
    8020853a:	6442                	ld	s0,16(sp)
    8020853c:	64a2                	ld	s1,8(sp)
    8020853e:	6902                	ld	s2,0(sp)
    80208540:	6105                	addi	sp,sp,32
    80208542:	8082                	ret
        for (b = bcache.head.prev; b != &bcache.head; b = b->prev)
    80208544:	2806b403          	ld	s0,640(a3)
    80208548:	00e41663          	bne	s0,a4,80208554 <_ZN11BufferCache5breadEjj+0x94>
    8020854c:	a0a1                	j	80208594 <_ZN11BufferCache5breadEjj+0xd4>
    8020854e:	6c00                	ld	s0,24(s0)
    80208550:	04e40263          	beq	s0,a4,80208594 <_ZN11BufferCache5breadEjj+0xd4>
            if (b->refcnt == 0)
    80208554:	481c                	lw	a5,16(s0)
    80208556:	ffe5                	bnez	a5,8020854e <_ZN11BufferCache5breadEjj+0x8e>
                b->dev = dev;
    80208558:	02049793          	slli	a5,s1,0x20
    8020855c:	1902                	slli	s2,s2,0x20
    8020855e:	9381                	srli	a5,a5,0x20
    80208560:	0127e7b3          	or	a5,a5,s2
    80208564:	e41c                	sd	a5,8(s0)
                b->refcnt = 1;
    80208566:	4785                	li	a5,1
    80208568:	c81c                	sw	a5,16(s0)
                bcache.lock.release();
    8020856a:	00016517          	auipc	a0,0x16
    8020856e:	07e50513          	addi	a0,a0,126 # 8021e5e8 <_ZN11BufferCache6bcacheE>
                b->valid = 0;
    80208572:	00042023          	sw	zero,0(s0)
                bcache.lock.release();
    80208576:	da2fd0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
                b->lock.acquire();
    8020857a:	42840513          	addi	a0,s0,1064
    8020857e:	eb0fd0ef          	jal	80205c2e <_ZN5Mutex7acquireEv>
        if (!b->valid)
    80208582:	401c                	lw	a5,0(s0)
    80208584:	d3c5                	beqz	a5,80208524 <_ZN11BufferCache5breadEjj+0x64>
    }
    80208586:	60e2                	ld	ra,24(sp)
    80208588:	8522                	mv	a0,s0
    8020858a:	6442                	ld	s0,16(sp)
    8020858c:	64a2                	ld	s1,8(sp)
    8020858e:	6902                	ld	s2,0(sp)
    80208590:	6105                	addi	sp,sp,32
    80208592:	8082                	ret
        Drivers::uart_puts("panic: bget: no buffers\n");
    80208594:	0000a517          	auipc	a0,0xa
    80208598:	a5450513          	addi	a0,a0,-1452 # 80211fe8 <initcode_end+0x8a0>
    8020859c:	7ce000ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        while (1)
    802085a0:	a001                	j	802085a0 <_ZN11BufferCache5breadEjj+0xe0>

00000000802085a2 <_ZN11BufferCache6bwriteEP3Buf>:

    void bwrite(struct Buf *b)
    {
    802085a2:	1141                	addi	sp,sp,-16
    802085a4:	e022                	sd	s0,0(sp)
    802085a6:	842a                	mv	s0,a0
        if (!b->lock.holding())
    802085a8:	42850513          	addi	a0,a0,1064
    {
    802085ac:	e406                	sd	ra,8(sp)
        if (!b->lock.holding())
    802085ae:	f22fd0ef          	jal	80205cd0 <_ZN5Mutex7holdingEv>
    802085b2:	e901                	bnez	a0,802085c2 <_ZN11BufferCache6bwriteEP3Buf+0x20>
        { 
            Drivers::uart_puts("panic: bwrite\n");
    802085b4:	0000a517          	auipc	a0,0xa
    802085b8:	a5450513          	addi	a0,a0,-1452 # 80212008 <initcode_end+0x8c0>
    802085bc:	7ae000ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            while (1)
    802085c0:	a001                	j	802085c0 <_ZN11BufferCache6bwriteEP3Buf+0x1e>
                ;
        }
        VirtIO::rw(1, b->blockno, (char *)b->data);
    802085c2:	00c46583          	lwu	a1,12(s0)
    802085c6:	02840613          	addi	a2,s0,40
    }
    802085ca:	6402                	ld	s0,0(sp)
    802085cc:	60a2                	ld	ra,8(sp)
        VirtIO::rw(1, b->blockno, (char *)b->data);
    802085ce:	4505                	li	a0,1
    }
    802085d0:	0141                	addi	sp,sp,16
        VirtIO::rw(1, b->blockno, (char *)b->data);
    802085d2:	7310006f          	j	80209502 <_ZN6VirtIO2rwEiyPc>

00000000802085d6 <_ZN11BufferCache6brelseEP3Buf>:

    void brelse(struct Buf *b)
    {
    802085d6:	1101                	addi	sp,sp,-32
    802085d8:	e426                	sd	s1,8(sp)
        if (!b->lock.holding())
    802085da:	42850493          	addi	s1,a0,1064
    {
    802085de:	e822                	sd	s0,16(sp)
    802085e0:	842a                	mv	s0,a0
        if (!b->lock.holding())
    802085e2:	8526                	mv	a0,s1
    {
    802085e4:	ec06                	sd	ra,24(sp)
        if (!b->lock.holding())
    802085e6:	eeafd0ef          	jal	80205cd0 <_ZN5Mutex7holdingEv>
    802085ea:	e901                	bnez	a0,802085fa <_ZN11BufferCache6brelseEP3Buf+0x24>
        {
            Drivers::uart_puts("panic: brelse\n");
    802085ec:	0000a517          	auipc	a0,0xa
    802085f0:	a2c50513          	addi	a0,a0,-1492 # 80212018 <initcode_end+0x8d0>
    802085f4:	776000ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            while (1)
    802085f8:	a001                	j	802085f8 <_ZN11BufferCache6brelseEP3Buf+0x22>
                ;
        }
        b->lock.release();
    802085fa:	8526                	mv	a0,s1
    802085fc:	ea4fd0ef          	jal	80205ca0 <_ZN5Mutex7releaseEv>

        bcache.lock.acquire();
    80208600:	00016517          	auipc	a0,0x16
    80208604:	fe850513          	addi	a0,a0,-24 # 8021e5e8 <_ZN11BufferCache6bcacheE>
    80208608:	d78fd0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        b->refcnt--;
    8020860c:	481c                	lw	a5,16(s0)
    8020860e:	fff7871b          	addiw	a4,a5,-1
    80208612:	c818                	sw	a4,16(s0)

        if (b->refcnt == 0)
    80208614:	e71d                	bnez	a4,80208642 <_ZN11BufferCache6brelseEP3Buf+0x6c>
        {
            b->next->prev = b->prev;
    80208616:	7014                	ld	a3,32(s0)
    80208618:	6c18                	ld	a4,24(s0)
            b->prev->next = b->next;

            b->next = bcache.head.next;
    8020861a:	0001e797          	auipc	a5,0x1e
    8020861e:	fce78793          	addi	a5,a5,-50 # 802265e8 <_ZN11BufferCache6bcacheE+0x8000>
            b->next->prev = b->prev;
    80208622:	ee98                	sd	a4,24(a3)
            b->prev->next = b->next;
    80208624:	7014                	ld	a3,32(s0)
    80208626:	f314                	sd	a3,32(a4)
            b->next = bcache.head.next;
    80208628:	2887b703          	ld	a4,648(a5)
            b->prev = &bcache.head;
    8020862c:	0001e697          	auipc	a3,0x1e
    80208630:	22468693          	addi	a3,a3,548 # 80226850 <_ZN11BufferCache6bcacheE+0x8268>
    80208634:	ec14                	sd	a3,24(s0)
            b->next = bcache.head.next;
    80208636:	f018                	sd	a4,32(s0)
            bcache.head.next->prev = b;
    80208638:	2887b703          	ld	a4,648(a5)
    8020863c:	ef00                	sd	s0,24(a4)
            bcache.head.next = b;
    8020863e:	2887b423          	sd	s0,648(a5)
        }

        bcache.lock.release();
    }
    80208642:	6442                	ld	s0,16(sp)
    80208644:	60e2                	ld	ra,24(sp)
    80208646:	64a2                	ld	s1,8(sp)
        bcache.lock.release();
    80208648:	00016517          	auipc	a0,0x16
    8020864c:	fa050513          	addi	a0,a0,-96 # 8021e5e8 <_ZN11BufferCache6bcacheE>
    }
    80208650:	6105                	addi	sp,sp,32
        bcache.lock.release();
    80208652:	cc6fd06f          	j	80205b18 <_ZN8Spinlock7releaseEv>

0000000080208656 <_ZN11BufferCache4bpinEP3Buf>:

    void bpin(struct Buf *b)
    {
    80208656:	1141                	addi	sp,sp,-16
    80208658:	e022                	sd	s0,0(sp)
    8020865a:	842a                	mv	s0,a0
        bcache.lock.acquire();
    8020865c:	00016517          	auipc	a0,0x16
    80208660:	f8c50513          	addi	a0,a0,-116 # 8021e5e8 <_ZN11BufferCache6bcacheE>
    {
    80208664:	e406                	sd	ra,8(sp)
        bcache.lock.acquire();
    80208666:	d1afd0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        b->refcnt++;
    8020866a:	481c                	lw	a5,16(s0)
        bcache.lock.release();
    }
    8020866c:	60a2                	ld	ra,8(sp)
        bcache.lock.release();
    8020866e:	00016517          	auipc	a0,0x16
    80208672:	f7a50513          	addi	a0,a0,-134 # 8021e5e8 <_ZN11BufferCache6bcacheE>
        b->refcnt++;
    80208676:	2785                	addiw	a5,a5,1
    80208678:	c81c                	sw	a5,16(s0)
    }
    8020867a:	6402                	ld	s0,0(sp)
    8020867c:	0141                	addi	sp,sp,16
        bcache.lock.release();
    8020867e:	c9afd06f          	j	80205b18 <_ZN8Spinlock7releaseEv>

0000000080208682 <_ZN11BufferCache6bunpinEP3Buf>:

    void bunpin(struct Buf* b)
    {
    80208682:	1141                	addi	sp,sp,-16
    80208684:	e022                	sd	s0,0(sp)
    80208686:	842a                	mv	s0,a0
        bcache.lock.acquire();
    80208688:	00016517          	auipc	a0,0x16
    8020868c:	f6050513          	addi	a0,a0,-160 # 8021e5e8 <_ZN11BufferCache6bcacheE>
    {
    80208690:	e406                	sd	ra,8(sp)
        bcache.lock.acquire();
    80208692:	ceefd0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        b->refcnt --;
    80208696:	481c                	lw	a5,16(s0)
        bcache.lock.release();
    }
    80208698:	60a2                	ld	ra,8(sp)
        bcache.lock.release();
    8020869a:	00016517          	auipc	a0,0x16
    8020869e:	f4e50513          	addi	a0,a0,-178 # 8021e5e8 <_ZN11BufferCache6bcacheE>
        b->refcnt --;
    802086a2:	37fd                	addiw	a5,a5,-1
    802086a4:	c81c                	sw	a5,16(s0)
    }
    802086a6:	6402                	ld	s0,0(sp)
    802086a8:	0141                	addi	sp,sp,16
        bcache.lock.release();
    802086aa:	c6efd06f          	j	80205b18 <_ZN8Spinlock7releaseEv>

00000000802086ae <_GLOBAL__sub_I__ZN11BufferCache4initEv>:
    802086ae:	00009717          	auipc	a4,0x9
    802086b2:	0da70713          	addi	a4,a4,218 # 80211788 <initcode_end+0x40>
    802086b6:	00016797          	auipc	a5,0x16
    802086ba:	f207a923          	sw	zero,-206(a5) # 8021e5e8 <_ZN11BufferCache6bcacheE>
    802086be:	00016797          	auipc	a5,0x16
    802086c2:	f2e7b923          	sd	a4,-206(a5) # 8021e5f0 <_ZN11BufferCache6bcacheE+0x8>
    802086c6:	00016797          	auipc	a5,0x16
    802086ca:	f207b923          	sd	zero,-206(a5) # 8021e5f8 <_ZN11BufferCache6bcacheE+0x10>
    {
    802086ce:	00016797          	auipc	a5,0x16
    802086d2:	f3278793          	addi	a5,a5,-206 # 8021e600 <_ZN11BufferCache6bcacheE+0x18>
    802086d6:	0001e697          	auipc	a3,0x1e
    802086da:	17a68693          	addi	a3,a3,378 # 80226850 <_ZN11BufferCache6bcacheE+0x8268>
    802086de:	4407a023          	sw	zero,1088(a5)
    802086e2:	44e7b423          	sd	a4,1096(a5)
    802086e6:	4407b823          	sd	zero,1104(a5)
    802086ea:	45878793          	addi	a5,a5,1112
    802086ee:	fed798e3          	bne	a5,a3,802086de <_GLOBAL__sub_I__ZN11BufferCache4initEv+0x30>
    802086f2:	0001e797          	auipc	a5,0x1e
    802086f6:	5807af23          	sw	zero,1438(a5) # 80226c90 <_ZN11BufferCache6bcacheE+0x86a8>
    802086fa:	0001e797          	auipc	a5,0x1e
    802086fe:	58e7bf23          	sd	a4,1438(a5) # 80226c98 <_ZN11BufferCache6bcacheE+0x86b0>
    80208702:	0001e797          	auipc	a5,0x1e
    80208706:	5807bf23          	sd	zero,1438(a5) # 80226ca0 <_ZN11BufferCache6bcacheE+0x86b8>

} // namespace BufferCache
    8020870a:	8082                	ret

000000008020870c <_Z8fdt_inity>:
#define FDT_END 9


void fdt_init(uint64 dtb)
{
    if (dtb == 0) return;
    8020870c:	cd7d                	beqz	a0,8020880a <_Z8fdt_inity+0xfe>

    struct fdt_header* header = (struct fdt_header*)dtb;
    if (bswap(header->magic) != FDT_MAGIC)
    8020870e:	4118                	lw	a4,0(a0)
{
    80208710:	7159                	addi	sp,sp,-112
    80208712:	e0d2                	sd	s4,64(sp)
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
    80208714:	0187579b          	srliw	a5,a4,0x18
    return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) |
    80208718:	0187159b          	slliw	a1,a4,0x18
    8020871c:	0087169b          	slliw	a3,a4,0x8
    80208720:	00ff0637          	lui	a2,0xff0
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
    80208724:	6a41                	lui	s4,0x10
    80208726:	8fcd                	or	a5,a5,a1
    return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) |
    80208728:	8ef1                	and	a3,a3,a2
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
    8020872a:	0087571b          	srliw	a4,a4,0x8
    8020872e:	f00a0a13          	addi	s4,s4,-256 # ff00 <_start-0x801f0100>
    80208732:	01477733          	and	a4,a4,s4
    80208736:	8fd5                	or	a5,a5,a3
    80208738:	8fd9                	or	a5,a5,a4
    if (bswap(header->magic) != FDT_MAGIC)
    8020873a:	d00e0737          	lui	a4,0xd00e0
{
    8020873e:	f486                	sd	ra,104(sp)
    if (bswap(header->magic) != FDT_MAGIC)
    80208740:	2781                	sext.w	a5,a5
    80208742:	eed70713          	addi	a4,a4,-275 # ffffffffd00dfeed <kernel_end+0xffffffff4feb8eed>
    80208746:	0ae79e63          	bne	a5,a4,80208802 <_Z8fdt_inity+0xf6>
        return;
    
    uint8* struct_ptr = (uint8*)(dtb + bswap(header->off_dt_struct));
    8020874a:	4518                	lw	a4,8(a0)
    char* strings_ptr = (char *)(dtb + bswap(header->off_dt_strings));
    8020874c:	455c                	lw	a5,12(a0)
    8020874e:	f0a2                	sd	s0,96(sp)
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
    80208750:	0187589b          	srliw	a7,a4,0x18
    return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) |
    80208754:	0187141b          	slliw	s0,a4,0x18
    80208758:	0087159b          	slliw	a1,a4,0x8
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
    8020875c:	0187d81b          	srliw	a6,a5,0x18
    return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) |
    80208760:	0087969b          	slliw	a3,a5,0x8
    80208764:	eca6                	sd	s1,88(sp)
    80208766:	0187949b          	slliw	s1,a5,0x18
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
    8020876a:	01146433          	or	s0,s0,a7
    return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) |
    8020876e:	8df1                	and	a1,a1,a2
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
    80208770:	0087571b          	srliw	a4,a4,0x8
    80208774:	0104e4b3          	or	s1,s1,a6
    return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) |
    80208778:	8ef1                	and	a3,a3,a2
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
    8020877a:	0087d79b          	srliw	a5,a5,0x8
    8020877e:	8c4d                	or	s0,s0,a1
    80208780:	01477733          	and	a4,a4,s4
    80208784:	8cd5                	or	s1,s1,a3
    80208786:	0147f7b3          	and	a5,a5,s4
    8020878a:	8c59                	or	s0,s0,a4
    8020878c:	8cdd                	or	s1,s1,a5
    uint8* struct_ptr = (uint8*)(dtb + bswap(header->off_dt_struct));
    8020878e:	1402                	slli	s0,s0,0x20
    char* strings_ptr = (char *)(dtb + bswap(header->off_dt_strings));
    80208790:	1482                	slli	s1,s1,0x20
    uint8* struct_ptr = (uint8*)(dtb + bswap(header->off_dt_struct));
    80208792:	9001                	srli	s0,s0,0x20
    char* strings_ptr = (char *)(dtb + bswap(header->off_dt_strings));
    80208794:	9081                	srli	s1,s1,0x20
    80208796:	e8ca                	sd	s2,80(sp)
    80208798:	e4ce                	sd	s3,72(sp)
    8020879a:	f45e                	sd	s7,40(sp)
    8020879c:	f062                	sd	s8,32(sp)
    8020879e:	ec66                	sd	s9,24(sp)

    uint64 current_reg_addr = 0;
    802087a0:	4901                	li	s2,0
    uint8* struct_ptr = (uint8*)(dtb + bswap(header->off_dt_struct));
    802087a2:	942a                	add	s0,s0,a0
    char* strings_ptr = (char *)(dtb + bswap(header->off_dt_strings));
    802087a4:	94aa                	add	s1,s1,a0
    return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) |
    802087a6:	00ff0bb7          	lui	s7,0xff0
    802087aa:	4c0d                	li	s8,3
    802087ac:	4ca5                	li	s9,9
    802087ae:	4985                	li	s3,1

    while (1)
    {
        uint32 token = bswap(*(uint32*)struct_ptr);
    802087b0:	4018                	lw	a4,0(s0)
    return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) |
    802087b2:	0187179b          	slliw	a5,a4,0x18
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
    802087b6:	0187559b          	srliw	a1,a4,0x18
    return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) |
    802087ba:	0087169b          	slliw	a3,a4,0x8
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
    802087be:	8fcd                	or	a5,a5,a1
    return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) |
    802087c0:	0176f6b3          	and	a3,a3,s7
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
    802087c4:	0087571b          	srliw	a4,a4,0x8
    802087c8:	8fd5                	or	a5,a5,a3
    802087ca:	00ea7733          	and	a4,s4,a4
    802087ce:	8fd9                	or	a5,a5,a4
    802087d0:	2781                	sext.w	a5,a5
        struct_ptr += 4;

        if(token == FDT_END)break;
    802087d2:	03878d63          	beq	a5,s8,8020880c <_Z8fdt_inity+0x100>
    802087d6:	01978f63          	beq	a5,s9,802087f4 <_Z8fdt_inity+0xe8>
        struct_ptr += 4;
    802087da:	0411                	addi	s0,s0,4
    802087dc:	fd379ae3          	bne	a5,s3,802087b0 <_Z8fdt_inity+0xa4>
        if(token == FDT_NOP)continue;

        if(token == FDT_BEGIN_NODE)
        {
            while (*struct_ptr != 0)struct_ptr++;
    802087e0:	00044783          	lbu	a5,0(s0)
    802087e4:	c789                	beqz	a5,802087ee <_Z8fdt_inity+0xe2>
    802087e6:	00144783          	lbu	a5,1(s0)
    802087ea:	0405                	addi	s0,s0,1
    802087ec:	ffed                	bnez	a5,802087e6 <_Z8fdt_inity+0xda>
            struct_ptr++;
            struct_ptr = (uint8*)(((uint64)struct_ptr + 3) & ~3);
    802087ee:	0411                	addi	s0,s0,4
    802087f0:	9871                	andi	s0,s0,-4
    802087f2:	bf7d                	j	802087b0 <_Z8fdt_inity+0xa4>
    802087f4:	7406                	ld	s0,96(sp)
    802087f6:	64e6                	ld	s1,88(sp)
    802087f8:	6946                	ld	s2,80(sp)
    802087fa:	69a6                	ld	s3,72(sp)
    802087fc:	7ba2                	ld	s7,40(sp)
    802087fe:	7c02                	ld	s8,32(sp)
    80208800:	6ce2                	ld	s9,24(sp)

            }
        }
    }
    
    80208802:	70a6                	ld	ra,104(sp)
    80208804:	6a06                	ld	s4,64(sp)
    80208806:	6165                	addi	sp,sp,112
    80208808:	8082                	ret
    8020880a:	8082                	ret
            uint32 nameoff = bswap(*(uint32*)struct_ptr);
    8020880c:	4418                	lw	a4,8(s0)
            uint32 len = bswap(*(uint32*)struct_ptr);
    8020880e:	405c                	lw	a5,4(s0)
    return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) |
    80208810:	fc56                	sd	s5,56(sp)
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
    80208812:	0187551b          	srliw	a0,a4,0x18
    return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) |
    80208816:	01871a9b          	slliw	s5,a4,0x18
    8020881a:	0087169b          	slliw	a3,a4,0x8
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
    8020881e:	00aaeab3          	or	s5,s5,a0
    return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) |
    80208822:	0176f6b3          	and	a3,a3,s7
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
    80208826:	0087571b          	srliw	a4,a4,0x8
    8020882a:	00daeab3          	or	s5,s5,a3
    8020882e:	00ea7733          	and	a4,s4,a4
    80208832:	0187d51b          	srliw	a0,a5,0x18
    80208836:	f85a                	sd	s6,48(sp)
    return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) |
    80208838:	0087969b          	slliw	a3,a5,0x8
    8020883c:	01879b1b          	slliw	s6,a5,0x18
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
    80208840:	00eaeab3          	or	s5,s5,a4
    80208844:	00ab6b33          	or	s6,s6,a0
    return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) |
    80208848:	0176f733          	and	a4,a3,s7
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
    8020884c:	0087d79b          	srliw	a5,a5,0x8
            char* name = strings_ptr + nameoff;
    80208850:	1a82                	slli	s5,s5,0x20
    80208852:	020ada93          	srli	s5,s5,0x20
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
    80208856:	00eb6b33          	or	s6,s6,a4
    8020885a:	00fa77b3          	and	a5,s4,a5
    8020885e:	00fb6b33          	or	s6,s6,a5
            char* name = strings_ptr + nameoff;
    80208862:	9aa6                	add	s5,s5,s1
    80208864:	e46e                	sd	s11,8(sp)
            if(strcmp(name, "reg") == 0 && len >= 8)
    80208866:	00009597          	auipc	a1,0x9
    8020886a:	7c258593          	addi	a1,a1,1986 # 80212028 <initcode_end+0x8e0>
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
    8020886e:	000b0d9b          	sext.w	s11,s6
            if(strcmp(name, "reg") == 0 && len >= 8)
    80208872:	8556                	mv	a0,s5
            struct_ptr += len;
    80208874:	1b02                	slli	s6,s6,0x20
    80208876:	e86a                	sd	s10,16(sp)
    80208878:	020b5b13          	srli	s6,s6,0x20
            struct_ptr += 4;
    8020887c:	00c40d13          	addi	s10,s0,12
            if(strcmp(name, "reg") == 0 && len >= 8)
    80208880:	e8cfc0ef          	jal	80204f0c <_Z6strcmpPKcS0_>
    80208884:	ed29                	bnez	a0,802088de <_Z8fdt_inity+0x1d2>
    80208886:	479d                	li	a5,7
    80208888:	05b7fb63          	bgeu	a5,s11,802088de <_Z8fdt_inity+0x1d2>
                uint32 lo = bswap(*(uint32*)(data + 4));
    8020888c:	4818                	lw	a4,16(s0)
                uint32 hi = bswap(*(uint32*)data);
    8020888e:	4454                	lw	a3,12(s0)
    return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) |
    80208890:	0187179b          	slliw	a5,a4,0x18
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
    80208894:	0187581b          	srliw	a6,a4,0x18
    return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) |
    80208898:	0087159b          	slliw	a1,a4,0x8
    8020889c:	0186991b          	slliw	s2,a3,0x18
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
    802088a0:	0186d89b          	srliw	a7,a3,0x18
    return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) |
    802088a4:	0086951b          	slliw	a0,a3,0x8
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
    802088a8:	0107e7b3          	or	a5,a5,a6
    return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) |
    802088ac:	0175f5b3          	and	a1,a1,s7
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
    802088b0:	0087571b          	srliw	a4,a4,0x8
    802088b4:	01196933          	or	s2,s2,a7
    return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) |
    802088b8:	01757533          	and	a0,a0,s7
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
    802088bc:	0086d69b          	srliw	a3,a3,0x8
    802088c0:	8fcd                	or	a5,a5,a1
    802088c2:	00ea7733          	and	a4,s4,a4
    802088c6:	00a96933          	or	s2,s2,a0
    802088ca:	00da76b3          	and	a3,s4,a3
    802088ce:	8fd9                	or	a5,a5,a4
    802088d0:	00d96933          	or	s2,s2,a3
                current_reg_addr = ((uint64)hi << 32) | lo;
    802088d4:	1782                	slli	a5,a5,0x20
    802088d6:	1902                	slli	s2,s2,0x20
    802088d8:	9381                	srli	a5,a5,0x20
    802088da:	00f96933          	or	s2,s2,a5
            if(strcmp(name, "compatible") == 0)
    802088de:	00009597          	auipc	a1,0x9
    802088e2:	75258593          	addi	a1,a1,1874 # 80212030 <initcode_end+0x8e8>
    802088e6:	8556                	mv	a0,s5
    802088e8:	e24fc0ef          	jal	80204f0c <_Z6strcmpPKcS0_>
    802088ec:	e519                	bnez	a0,802088fa <_Z8fdt_inity+0x1ee>
                if (g_uart_base == 0)
    802088ee:	0000c517          	auipc	a0,0xc
    802088f2:	19253503          	ld	a0,402(a0) # 80214a80 <_GLOBAL_OFFSET_TABLE_+0x20>
    802088f6:	611c                	ld	a5,0(a0)
    802088f8:	cb91                	beqz	a5,8020890c <_Z8fdt_inity+0x200>
            struct_ptr += len;
    802088fa:	9b6a                	add	s6,s6,s10
            struct_ptr = (uint8*)(((uint64)struct_ptr + 3) & ~3);
    802088fc:	0b0d                	addi	s6,s6,3
    802088fe:	ffcb7413          	andi	s0,s6,-4
    80208902:	7ae2                	ld	s5,56(sp)
    80208904:	7b42                	ld	s6,48(sp)
    80208906:	6d42                	ld	s10,16(sp)
    80208908:	6da2                	ld	s11,8(sp)
    8020890a:	b55d                	j	802087b0 <_Z8fdt_inity+0xa4>
                    for(uint32 i = 0; i < len; i++)
    8020890c:	fe0d87e3          	beqz	s11,802088fa <_Z8fdt_inity+0x1ee>
                        if (data[i] == 'n' && data[i + 1] == 's' && data[i + 2] == '1')
    80208910:	4889                	li	a7,2
    80208912:	016d05b3          	add	a1,s10,s6
                    for(uint32 i = 0; i < len; i++)
    80208916:	87ea                	mv	a5,s10
                        if (data[i] == 'n' && data[i + 1] == 's' && data[i + 2] == '1')
    80208918:	06e00693          	li	a3,110
    8020891c:	07300813          	li	a6,115
    80208920:	41a888bb          	subw	a7,a7,s10
    80208924:	03100313          	li	t1,49
    80208928:	a021                	j	80208930 <_Z8fdt_inity+0x224>
                    for(uint32 i = 0; i < len; i++)
    8020892a:	0785                	addi	a5,a5,1
    8020892c:	fcf587e3          	beq	a1,a5,802088fa <_Z8fdt_inity+0x1ee>
                        if (data[i] == 'n' && data[i + 1] == 's' && data[i + 2] == '1')
    80208930:	0007c703          	lbu	a4,0(a5)
    80208934:	fed71be3          	bne	a4,a3,8020892a <_Z8fdt_inity+0x21e>
    80208938:	0017c703          	lbu	a4,1(a5)
    8020893c:	ff0717e3          	bne	a4,a6,8020892a <_Z8fdt_inity+0x21e>
    80208940:	00f8873b          	addw	a4,a7,a5
    80208944:	1702                	slli	a4,a4,0x20
    80208946:	9301                	srli	a4,a4,0x20
    80208948:	976a                	add	a4,a4,s10
    8020894a:	00074703          	lbu	a4,0(a4)
    8020894e:	fc671ee3          	bne	a4,t1,8020892a <_Z8fdt_inity+0x21e>
                            g_uart_base = current_reg_addr;
    80208952:	01253023          	sd	s2,0(a0)
                            break;
    80208956:	b755                	j	802088fa <_Z8fdt_inity+0x1ee>

0000000080208958 <_Z5panicPKc>:
extern "C" void kernelvec();

// Handle Function

void panic(const char *s)
{
    80208958:	1141                	addi	sp,sp,-16
    8020895a:	e022                	sd	s0,0(sp)
    8020895c:	842a                	mv	s0,a0
    Drivers::uart_puts("\n\n!!! KERNEL PANIC !!!\n");
    8020895e:	00009517          	auipc	a0,0x9
    80208962:	6e250513          	addi	a0,a0,1762 # 80212040 <initcode_end+0x8f8>
{
    80208966:	e406                	sd	ra,8(sp)
    Drivers::uart_puts("\n\n!!! KERNEL PANIC !!!\n");
    80208968:	402000ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
    Drivers::uart_puts(s);
    8020896c:	8522                	mv	a0,s0
    8020896e:	3fc000ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
    Drivers::uart_puts("\nSystem Halted.\n");
    80208972:	00009517          	auipc	a0,0x9
    80208976:	6e650513          	addi	a0,a0,1766 # 80212058 <initcode_end+0x910>
    8020897a:	3f0000ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
    while (1)
    8020897e:	a001                	j	8020897e <_Z5panicPKc+0x26>

0000000080208980 <_ZN4Trap4initEv>:

namespace Trap
{
    void init()
    {
        Drivers::uart_puts("[Trap] Global init done.\n");
    80208980:	00009517          	auipc	a0,0x9
    80208984:	6f050513          	addi	a0,a0,1776 # 80212070 <initcode_end+0x928>
    80208988:	3e20006f          	j	80208d6a <_ZN7Drivers9uart_putsEPKc>

000000008020898c <_ZN4Trap8inithartEv>:
  asm volatile("csrw stvec, %0" : : "r" (x));
    8020898c:	0000c797          	auipc	a5,0xc
    80208990:	10c7b783          	ld	a5,268(a5) # 80214a98 <_GLOBAL_OFFSET_TABLE_+0x38>
    80208994:	10579073          	csrw	stvec,a5
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80208998:	100027f3          	csrr	a5,sstatus
    {
        w_stvec((uint64)kernelvec);

        // Ensure that the S-Mode interrupt enable bit (SIE) is cleared during initialization
        // Interrupt enabling will be done by the scheduler when the first process runs
        w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    8020899c:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8020899e:	10079073          	csrw	sstatus,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    802089a2:	104027f3          	csrr	a5,sie

        // Enable the external interrupt, clock interrupt, and software interrupt bits in S-Mode (in SIE register)
        uint64 sie = r_sie();
        sie |= SIE_SEIE | SIE_STIE | SIE_SSIE;
    802089a6:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    802089aa:	10479073          	csrw	sie,a5
        w_sie(sie);

        Drivers::uart_puts("[Trap] Hart initialized (stvec set).\n");
    802089ae:	00009517          	auipc	a0,0x9
    802089b2:	6e250513          	addi	a0,a0,1762 # 80212090 <initcode_end+0x948>
    802089b6:	3b40006f          	j	80208d6a <_ZN7Drivers9uart_putsEPKc>

00000000802089ba <_ZN4Trap7devintrEv>:
  asm volatile("csrr %0, scause" : "=r" (x) );
    802089ba:	142027f3          	csrr	a5,scause
            Timer::tick();
            // w_sip(r_sip() & ~2);
            return 2;
        }

        return 0;
    802089be:	4501                	li	a0,0
        if (is_interrupt && code == 9)
    802089c0:	0007c363          	bltz	a5,802089c6 <_ZN4Trap7devintrEv+0xc>
    }
    802089c4:	8082                	ret
    {
    802089c6:	1101                	addi	sp,sp,-32
    802089c8:	ec06                	sd	ra,24(sp)
        uint64 code = scause & 0xff;
    802089ca:	0ff7f793          	zext.b	a5,a5
        if (is_interrupt && code == 9)
    802089ce:	4725                	li	a4,9
    802089d0:	00e78863          	beq	a5,a4,802089e0 <_ZN4Trap7devintrEv+0x26>
        else if (is_interrupt && code == 5)
    802089d4:	4715                	li	a4,5
    802089d6:	02e78563          	beq	a5,a4,80208a00 <_ZN4Trap7devintrEv+0x46>
    }
    802089da:	60e2                	ld	ra,24(sp)
    802089dc:	6105                	addi	sp,sp,32
    802089de:	8082                	ret
            int irq = PLIC::claim();
    802089e0:	75d000ef          	jal	8020993c <_ZN4PLIC5claimEv>
            if (irq == 10)
    802089e4:	47a9                	li	a5,10
    802089e6:	02f50663          	beq	a0,a5,80208a12 <_ZN4Trap7devintrEv+0x58>
            else if (irq >= 1 && irq <= 8)
    802089ea:	fff5079b          	addiw	a5,a0,-1
    802089ee:	471d                	li	a4,7
    802089f0:	00f77c63          	bgeu	a4,a5,80208a08 <_ZN4Trap7devintrEv+0x4e>
            if (irq > 0)
    802089f4:	00a05463          	blez	a0,802089fc <_ZN4Trap7devintrEv+0x42>
                PLIC::complete(irq);
    802089f8:	757000ef          	jal	8020994e <_ZN4PLIC8completeEi>
    {
    802089fc:	4505                	li	a0,1
    802089fe:	bff1                	j	802089da <_ZN4Trap7devintrEv+0x20>
            Timer::tick();
    80208a00:	85ffe0ef          	jal	8020725e <_ZN5Timer4tickEv>
            return 2;
    80208a04:	4509                	li	a0,2
    80208a06:	bfd1                	j	802089da <_ZN4Trap7devintrEv+0x20>
    80208a08:	e42a                	sd	a0,8(sp)
                VirtIO::intr();
    80208a0a:	4bf000ef          	jal	802096c8 <_ZN6VirtIO4intrEv>
            if (irq > 0)
    80208a0e:	6522                	ld	a0,8(sp)
    80208a10:	b7e5                	j	802089f8 <_ZN4Trap7devintrEv+0x3e>
    80208a12:	e42a                	sd	a0,8(sp)
                Drivers::uart_intr();
    80208a14:	588000ef          	jal	80208f9c <_ZN7Drivers9uart_intrEv>
            if (irq > 0)
    80208a18:	6522                	ld	a0,8(sp)
    80208a1a:	bff9                	j	802089f8 <_ZN4Trap7devintrEv+0x3e>

0000000080208a1c <kerneltrap>:
}

// Exception Handling Entry

extern "C" void kerneltrap(struct Trapframe *tf)
{
    80208a1c:	7179                	addi	sp,sp,-48
    80208a1e:	f406                	sd	ra,40(sp)
    80208a20:	f022                	sd	s0,32(sp)
    80208a22:	ec26                	sd	s1,24(sp)
    80208a24:	e84a                	sd	s2,16(sp)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80208a26:	141024f3          	csrr	s1,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80208a2a:	10002473          	csrr	s0,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80208a2e:	14202973          	csrr	s2,scause
    uint64 sepc = r_sepc();
    uint64 sstatus = r_sstatus();
    uint64 scause = r_scause();

    if ((sstatus & SSTATUS_SPP) == 0)
    80208a32:	10047793          	andi	a5,s0,256
    80208a36:	0e078863          	beqz	a5,80208b26 <kerneltrap+0x10a>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80208a3a:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80208a3e:	8b89                	andi	a5,a5,2
        panic("kerneltrap: not from supervisor mode");

    if (intr_get() != 0)
    80208a40:	0c079d63          	bnez	a5,80208b1a <kerneltrap+0xfe>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80208a44:	142027f3          	csrr	a5,scause
        if (is_interrupt && code == 9)
    80208a48:	0607cc63          	bltz	a5,80208ac0 <kerneltrap+0xa4>
        panic("kerneltrap: interrupts enabled");

    if (Trap::devintr() == 0)
    {
        Drivers::uart_puts("\n--- KERNEL EXCEPTION ---\n");
    80208a4c:	00009517          	auipc	a0,0x9
    80208a50:	6b450513          	addi	a0,a0,1716 # 80212100 <initcode_end+0x9b8>
    80208a54:	316000ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        Drivers::uart_puts("scause: ");
    80208a58:	00009517          	auipc	a0,0x9
    80208a5c:	6c850513          	addi	a0,a0,1736 # 80212120 <initcode_end+0x9d8>
    80208a60:	30a000ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        Drivers::print_hex(scause);
    80208a64:	854a                	mv	a0,s2
    80208a66:	46c000ef          	jal	80208ed2 <_ZN7Drivers9print_hexEy>
        Drivers::uart_puts("\n");
    80208a6a:	00009517          	auipc	a0,0x9
    80208a6e:	db650513          	addi	a0,a0,-586 # 80211820 <initcode_end+0xd8>
    80208a72:	2f8000ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        Drivers::uart_puts("sepc:   ");
    80208a76:	00009517          	auipc	a0,0x9
    80208a7a:	6ba50513          	addi	a0,a0,1722 # 80212130 <initcode_end+0x9e8>
    80208a7e:	2ec000ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        Drivers::print_hex(sepc);
    80208a82:	8526                	mv	a0,s1
    80208a84:	44e000ef          	jal	80208ed2 <_ZN7Drivers9print_hexEy>
        Drivers::uart_puts("\n");
    80208a88:	00009517          	auipc	a0,0x9
    80208a8c:	d9850513          	addi	a0,a0,-616 # 80211820 <initcode_end+0xd8>
    80208a90:	2da000ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        Drivers::uart_puts("stval:  ");
    80208a94:	00009517          	auipc	a0,0x9
    80208a98:	6ac50513          	addi	a0,a0,1708 # 80212140 <initcode_end+0x9f8>
    80208a9c:	2ce000ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
  asm volatile("csrr %0, stval" : "=r" (x) );
    80208aa0:	14302573          	csrr	a0,stval
        Drivers::print_hex(r_stval());
    80208aa4:	42e000ef          	jal	80208ed2 <_ZN7Drivers9print_hexEy>
        Drivers::uart_puts("\n");
    80208aa8:	00009517          	auipc	a0,0x9
    80208aac:	d7850513          	addi	a0,a0,-648 # 80211820 <initcode_end+0xd8>
    80208ab0:	2ba000ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        panic("kerneltrap exception");
    80208ab4:	00009517          	auipc	a0,0x9
    80208ab8:	69c50513          	addi	a0,a0,1692 # 80212150 <initcode_end+0xa08>
    80208abc:	e9dff0ef          	jal	80208958 <_Z5panicPKc>
        uint64 code = scause & 0xff;
    80208ac0:	0ff7f793          	zext.b	a5,a5
        if (is_interrupt && code == 9)
    80208ac4:	4725                	li	a4,9
    80208ac6:	02e78163          	beq	a5,a4,80208ae8 <kerneltrap+0xcc>
        else if (is_interrupt && code == 5)
    80208aca:	4715                	li	a4,5
    80208acc:	f8e790e3          	bne	a5,a4,80208a4c <kerneltrap+0x30>
            Timer::tick();
    80208ad0:	f8efe0ef          	jal	8020725e <_ZN5Timer4tickEv>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80208ad4:	14149073          	csrw	sepc,s1
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80208ad8:	10041073          	csrw	sstatus,s0
    }

    w_sepc(sepc);
    w_sstatus(sstatus);
}
    80208adc:	70a2                	ld	ra,40(sp)
    80208ade:	7402                	ld	s0,32(sp)
    80208ae0:	64e2                	ld	s1,24(sp)
    80208ae2:	6942                	ld	s2,16(sp)
    80208ae4:	6145                	addi	sp,sp,48
    80208ae6:	8082                	ret
            int irq = PLIC::claim();
    80208ae8:	655000ef          	jal	8020993c <_ZN4PLIC5claimEv>
            if (irq == 10)
    80208aec:	47a9                	li	a5,10
    80208aee:	02f50163          	beq	a0,a5,80208b10 <kerneltrap+0xf4>
            else if (irq >= 1 && irq <= 8)
    80208af2:	fff5079b          	addiw	a5,a0,-1
    80208af6:	471d                	li	a4,7
    80208af8:	00f77763          	bgeu	a4,a5,80208b06 <kerneltrap+0xea>
            if (irq > 0)
    80208afc:	fca05ce3          	blez	a0,80208ad4 <kerneltrap+0xb8>
                PLIC::complete(irq);
    80208b00:	64f000ef          	jal	8020994e <_ZN4PLIC8completeEi>
    80208b04:	bfc1                	j	80208ad4 <kerneltrap+0xb8>
    80208b06:	e42a                	sd	a0,8(sp)
                VirtIO::intr();
    80208b08:	3c1000ef          	jal	802096c8 <_ZN6VirtIO4intrEv>
            if (irq > 0)
    80208b0c:	6522                	ld	a0,8(sp)
    80208b0e:	bfcd                	j	80208b00 <kerneltrap+0xe4>
    80208b10:	e42a                	sd	a0,8(sp)
                Drivers::uart_intr();
    80208b12:	48a000ef          	jal	80208f9c <_ZN7Drivers9uart_intrEv>
            if (irq > 0)
    80208b16:	6522                	ld	a0,8(sp)
    80208b18:	b7e5                	j	80208b00 <kerneltrap+0xe4>
        panic("kerneltrap: interrupts enabled");
    80208b1a:	00009517          	auipc	a0,0x9
    80208b1e:	5c650513          	addi	a0,a0,1478 # 802120e0 <initcode_end+0x998>
    80208b22:	e37ff0ef          	jal	80208958 <_Z5panicPKc>
        panic("kerneltrap: not from supervisor mode");
    80208b26:	00009517          	auipc	a0,0x9
    80208b2a:	59250513          	addi	a0,a0,1426 # 802120b8 <initcode_end+0x970>
    80208b2e:	e2bff0ef          	jal	80208958 <_Z5panicPKc>

0000000080208b32 <usertrap>:

extern "C" void usertrap()
{
    80208b32:	1101                	addi	sp,sp,-32
    80208b34:	ec06                	sd	ra,24(sp)
    80208b36:	e822                	sd	s0,16(sp)
    80208b38:	e426                	sd	s1,8(sp)
    80208b3a:	e04a                	sd	s2,0(sp)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80208b3c:	100027f3          	csrr	a5,sstatus
    // Drivers::uart_puts("[Debug] Entered usertrap!\n");
    int which_dev = 0;

    if ((r_sstatus() & SSTATUS_SPP) != 0)
    80208b40:	1007f793          	andi	a5,a5,256
    80208b44:	14079763          	bnez	a5,80208c92 <usertrap+0x160>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80208b48:	0000c797          	auipc	a5,0xc
    80208b4c:	f507b783          	ld	a5,-176(a5) # 80214a98 <_GLOBAL_OFFSET_TABLE_+0x38>
    80208b50:	10579073          	csrw	stvec,a5
        panic("usertrap: not from user mode");

    w_stvec((uint64)kernelvec);

    struct Proc *p = myproc();
    80208b54:	f2ffc0ef          	jal	80205a82 <_Z6myprocv>
    80208b58:	842a                	mv	s0,a0
    if (!p)
    80208b5a:	14050263          	beqz	a0,80208c9e <usertrap+0x16c>
        panic("usertrap: no process");

    p->tf->epc = r_sepc();
    80208b5e:	7938                	ld	a4,112(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80208b60:	141027f3          	csrr	a5,sepc
    80208b64:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80208b66:	142024f3          	csrr	s1,scause
  asm volatile("csrr %0, stval" : "=r" (x) );
    80208b6a:	14302973          	csrr	s2,stval

    uint64 scause = r_scause();
    uint64 stval = r_stval();

    if (scause == 8) // Syscall
    80208b6e:	46a1                	li	a3,8
    80208b70:	04d48b63          	beq	s1,a3,80208bc6 <usertrap+0x94>
        p->tf->epc += 4;
        intr_on();
        syscall();
        intr_off();
    }
    else if (scause == 15) // Store Page Fault
    80208b74:	47bd                	li	a5,15
    80208b76:	02f48463          	beq	s1,a5,80208b9e <usertrap+0x6c>
            Drivers::uart_puts("\n");
            p->state = ZOMBIE;
            ProcManager::exit(-1);
        }
    }
    else if ((which_dev = Trap::devintr()) != 0)
    80208b7a:	e41ff0ef          	jal	802089ba <_ZN4Trap7devintrEv>
    80208b7e:	c559                	beqz	a0,80208c0c <usertrap+0xda>
    {
        if (which_dev == 2)
    80208b80:	4789                	li	a5,2
    80208b82:	0ef50e63          	beq	a0,a5,80208c7e <usertrap+0x14c>
        Drivers::uart_puts("\n");
        p->state = ZOMBIE;
        ProcManager::exit(-1);
    }

    if (p->state == ZOMBIE)
    80208b86:	08042703          	lw	a4,128(s0)
    80208b8a:	4795                	li	a5,5
    80208b8c:	06f70663          	beq	a4,a5,80208bf8 <usertrap+0xc6>
        ProcManager::exit(-1);

    usertrapret();
    80208b90:	6442                	ld	s0,16(sp)
    80208b92:	60e2                	ld	ra,24(sp)
    80208b94:	64a2                	ld	s1,8(sp)
    80208b96:	6902                	ld	s2,0(sp)
    80208b98:	6105                	addi	sp,sp,32
    usertrapret();
    80208b9a:	d11fe06f          	j	802078aa <_Z11usertrapretv>
        if (VM::handle_cow_fault(p->pagetable, PGROUNDDOWN(stval)) != 0)
    80208b9e:	7d28                	ld	a0,120(a0)
    80208ba0:	75fd                	lui	a1,0xfffff
    80208ba2:	00b975b3          	and	a1,s2,a1
    80208ba6:	a27fd0ef          	jal	802065cc <_ZN2VM16handle_cow_faultEPyy>
    80208baa:	dd71                	beqz	a0,80208b86 <usertrap+0x54>
            uint64 pa = VM::walkaddr(p->pagetable, stval);
    80208bac:	7c28                	ld	a0,120(s0)
    80208bae:	85ca                	mv	a1,s2
    80208bb0:	d05fd0ef          	jal	802068b4 <_ZN2VM8walkaddrEPyy>
            if (pa == 0)
    80208bb4:	0c051863          	bnez	a0,80208c84 <usertrap+0x152>
                Drivers::uart_puts("usertrap: Segmentation Fault (unmapped) at ");
    80208bb8:	00009517          	auipc	a0,0x9
    80208bbc:	5e850513          	addi	a0,a0,1512 # 802121a0 <initcode_end+0xa58>
    80208bc0:	1aa000ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
    80208bc4:	a079                	j	80208c52 <usertrap+0x120>
        if (p->state == ZOMBIE)
    80208bc6:	08052603          	lw	a2,128(a0)
    80208bca:	4695                	li	a3,5
    80208bcc:	0ad60363          	beq	a2,a3,80208c72 <usertrap+0x140>
        p->tf->epc += 4;
    80208bd0:	0791                	addi	a5,a5,4
    80208bd2:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80208bd4:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80208bd8:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80208bdc:	10079073          	csrw	sstatus,a5
        syscall();
    80208be0:	d08fc0ef          	jal	802050e8 <_Z7syscallv>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80208be4:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80208be8:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80208bea:	10079073          	csrw	sstatus,a5
    if (p->state == ZOMBIE)
    80208bee:	08042703          	lw	a4,128(s0)
    80208bf2:	4795                	li	a5,5
    80208bf4:	f8f71ee3          	bne	a4,a5,80208b90 <usertrap+0x5e>
        ProcManager::exit(-1);
    80208bf8:	557d                	li	a0,-1
    80208bfa:	d02ff0ef          	jal	802080fc <_ZN11ProcManager4exitEi>
    80208bfe:	6442                	ld	s0,16(sp)
    80208c00:	60e2                	ld	ra,24(sp)
    80208c02:	64a2                	ld	s1,8(sp)
    80208c04:	6902                	ld	s2,0(sp)
    80208c06:	6105                	addi	sp,sp,32
    usertrapret();
    80208c08:	ca3fe06f          	j	802078aa <_Z11usertrapretv>
        Drivers::uart_puts("\nusertrap(): unexpected scause ");
    80208c0c:	00009517          	auipc	a0,0x9
    80208c10:	5ec50513          	addi	a0,a0,1516 # 802121f8 <initcode_end+0xab0>
    80208c14:	156000ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        Drivers::print_hex(scause);
    80208c18:	8526                	mv	a0,s1
    80208c1a:	2b8000ef          	jal	80208ed2 <_ZN7Drivers9print_hexEy>
        Drivers::uart_puts(" pid=");
    80208c1e:	00009517          	auipc	a0,0x9
    80208c22:	5fa50513          	addi	a0,a0,1530 # 80212218 <initcode_end+0xad0>
    80208c26:	144000ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        Drivers::uart_put_int(p->pid);
    80208c2a:	08442503          	lw	a0,132(s0)
    80208c2e:	19a000ef          	jal	80208dc8 <_ZN7Drivers12uart_put_intEi>
        Drivers::uart_puts(" sepc=");
    80208c32:	00009517          	auipc	a0,0x9
    80208c36:	5ee50513          	addi	a0,a0,1518 # 80212220 <initcode_end+0xad8>
    80208c3a:	130000ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        Drivers::print_hex(p->tf->epc);
    80208c3e:	783c                	ld	a5,112(s0)
    80208c40:	6f88                	ld	a0,24(a5)
    80208c42:	290000ef          	jal	80208ed2 <_ZN7Drivers9print_hexEy>
        Drivers::uart_puts(" stval=");
    80208c46:	00009517          	auipc	a0,0x9
    80208c4a:	5e250513          	addi	a0,a0,1506 # 80212228 <initcode_end+0xae0>
    80208c4e:	11c000ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        Drivers::print_hex(stval);
    80208c52:	854a                	mv	a0,s2
    80208c54:	27e000ef          	jal	80208ed2 <_ZN7Drivers9print_hexEy>
        Drivers::uart_puts("\n");
    80208c58:	00009517          	auipc	a0,0x9
    80208c5c:	bc850513          	addi	a0,a0,-1080 # 80211820 <initcode_end+0xd8>
    80208c60:	10a000ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        p->state = ZOMBIE;
    80208c64:	4795                	li	a5,5
    80208c66:	08f42023          	sw	a5,128(s0)
        ProcManager::exit(-1);
    80208c6a:	557d                	li	a0,-1
    80208c6c:	c90ff0ef          	jal	802080fc <_ZN11ProcManager4exitEi>
    80208c70:	bf19                	j	80208b86 <usertrap+0x54>
            ProcManager::exit(-1);
    80208c72:	557d                	li	a0,-1
    80208c74:	c88ff0ef          	jal	802080fc <_ZN11ProcManager4exitEi>
        p->tf->epc += 4;
    80208c78:	7838                	ld	a4,112(s0)
    80208c7a:	6f1c                	ld	a5,24(a4)
    80208c7c:	bf91                	j	80208bd0 <usertrap+0x9e>
            ProcManager::yield();
    80208c7e:	81aff0ef          	jal	80207c98 <_ZN11ProcManager5yieldEv>
    80208c82:	b711                	j	80208b86 <usertrap+0x54>
                Drivers::uart_puts("usertrap: Protection Fault (or OOM) at ");
    80208c84:	00009517          	auipc	a0,0x9
    80208c88:	54c50513          	addi	a0,a0,1356 # 802121d0 <initcode_end+0xa88>
    80208c8c:	0de000ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
            Drivers::print_hex(stval);
    80208c90:	b7c9                	j	80208c52 <usertrap+0x120>
        panic("usertrap: not from user mode");
    80208c92:	00009517          	auipc	a0,0x9
    80208c96:	4d650513          	addi	a0,a0,1238 # 80212168 <initcode_end+0xa20>
    80208c9a:	cbfff0ef          	jal	80208958 <_Z5panicPKc>
        panic("usertrap: no process");
    80208c9e:	00009517          	auipc	a0,0x9
    80208ca2:	4ea50513          	addi	a0,a0,1258 # 80212188 <initcode_end+0xa40>
    80208ca6:	cb3ff0ef          	jal	80208958 <_Z5panicPKc>

0000000080208caa <_ZN7Drivers9uart_initEv>:
    } uart_rx;

    Spinlock uart_tx_lock;

    void uart_init()
    {
    80208caa:	1141                	addi	sp,sp,-16
    80208cac:	e022                	sd	s0,0(sp)
        uart_rx.lock.init("uart_rx");
    80208cae:	0001e417          	auipc	s0,0x1e
    80208cb2:	ffa40413          	addi	s0,s0,-6 # 80226ca8 <_ZN7Drivers7uart_rxE>
    80208cb6:	8522                	mv	a0,s0
    80208cb8:	00009597          	auipc	a1,0x9
    80208cbc:	57858593          	addi	a1,a1,1400 # 80212230 <initcode_end+0xae8>
    {
    80208cc0:	e406                	sd	ra,8(sp)
        uart_rx.lock.init("uart_rx");
    80208cc2:	d19fc0ef          	jal	802059da <_ZN8Spinlock4initEPKc>
        cons.lock.init("console");
    80208cc6:	00009597          	auipc	a1,0x9
    80208cca:	57258593          	addi	a1,a1,1394 # 80212238 <initcode_end+0xaf0>
    80208cce:	0001e517          	auipc	a0,0x1e
    80208cd2:	07a50513          	addi	a0,a0,122 # 80226d48 <_ZN7Drivers4consE>
    80208cd6:	d05fc0ef          	jal	802059da <_ZN8Spinlock4initEPKc>
        uart_tx_lock.init("uart_tx");
    80208cda:	00009597          	auipc	a1,0x9
    80208cde:	56658593          	addi	a1,a1,1382 # 80212240 <initcode_end+0xaf8>
    80208ce2:	0001e517          	auipc	a0,0x1e
    80208ce6:	10e50513          	addi	a0,a0,270 # 80226df0 <_ZN7Drivers12uart_tx_lockE>
    80208cea:	cf1fc0ef          	jal	802059da <_ZN8Spinlock4initEPKc>
        uart_rx.r = 0;
        uart_rx.w = 0;

        // Disable interrupts and configure
        *(volatile uint8 *)(UART0 + IER) = 0x00;
    80208cee:	100007b7          	lui	a5,0x10000
        uart_rx.r = 0;
    80208cf2:	08043c23          	sd	zero,152(s0)
        *(volatile uint8 *)(UART0 + IER) = 0x00;
    80208cf6:	000780a3          	sb	zero,1(a5) # 10000001 <_start-0x701fffff>

        // Enter baud rate setting mode (LCR_DLAB) = 0x80;
        *(volatile uint8 *)(UART0 + LCR) = 0x80;
    80208cfa:	10000737          	lui	a4,0x10000
    80208cfe:	f8000693          	li	a3,-128
    80208d02:	00d701a3          	sb	a3,3(a4) # 10000003 <_start-0x701ffffd>
        *(volatile uint8 *)(UART0 + 0) = 0x03; // DLL: 38.4K baud
    80208d06:	460d                	li	a2,3
        *(volatile uint8 *)(UART0 + IER) = 0x00;
    80208d08:	100006b7          	lui	a3,0x10000
        *(volatile uint8 *)(UART0 + 0) = 0x03; // DLL: 38.4K baud
    80208d0c:	00c68023          	sb	a2,0(a3) # 10000000 <_start-0x70200000>
        *(volatile uint8 *)(UART0 + 1) = 0x00; // DLM
    80208d10:	000780a3          	sb	zero,1(a5)

        // Exit baud rate setting, set 8-bit word length, no parity
        *(volatile uint8 *)(UART0 + LCR) = 0x03;
    80208d14:	00c701a3          	sb	a2,3(a4)

        // Reset and enable FIFO
        *(volatile uint8 *)(UART0 + FCR) = 0x07;
    80208d18:	471d                	li	a4,7
    80208d1a:	00e68123          	sb	a4,2(a3)

        // Enable Receive Data Available Interrupt
        *(volatile uint8 *)(UART0 + IER) = 0x01;
    80208d1e:	4705                	li	a4,1
    80208d20:	00e780a3          	sb	a4,1(a5)
    }
    80208d24:	60a2                	ld	ra,8(sp)
    80208d26:	6402                	ld	s0,0(sp)
    80208d28:	0141                	addi	sp,sp,16
    80208d2a:	8082                	ret

0000000080208d2c <_ZN7Drivers9uart_putcEc>:

    void uart_putc(char c)
    {
    80208d2c:	1141                	addi	sp,sp,-16
    80208d2e:	e022                	sd	s0,0(sp)
    80208d30:	842a                	mv	s0,a0
        uart_tx_lock.acquire();
    80208d32:	0001e517          	auipc	a0,0x1e
    80208d36:	0be50513          	addi	a0,a0,190 # 80226df0 <_ZN7Drivers12uart_tx_lockE>
    {
    80208d3a:	e406                	sd	ra,8(sp)
        uart_tx_lock.acquire();
    80208d3c:	e45fc0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        while ((*(volatile uint8 *)(UART0 + LSR) & LSR_TX_IDLE) == 0)
    80208d40:	10000737          	lui	a4,0x10000
    80208d44:	0715                	addi	a4,a4,5 # 10000005 <_start-0x701ffffb>
    80208d46:	00074783          	lbu	a5,0(a4)
    80208d4a:	0207f793          	andi	a5,a5,32
    80208d4e:	dfe5                	beqz	a5,80208d46 <_ZN7Drivers9uart_putcEc+0x1a>
            ;
        *(volatile uint8 *)(UART0 + THR) = c;
    80208d50:	100007b7          	lui	a5,0x10000
    80208d54:	00878023          	sb	s0,0(a5) # 10000000 <_start-0x70200000>
        uart_tx_lock.release();
    }
    80208d58:	6402                	ld	s0,0(sp)
    80208d5a:	60a2                	ld	ra,8(sp)
        uart_tx_lock.release();
    80208d5c:	0001e517          	auipc	a0,0x1e
    80208d60:	09450513          	addi	a0,a0,148 # 80226df0 <_ZN7Drivers12uart_tx_lockE>
    }
    80208d64:	0141                	addi	sp,sp,16
        uart_tx_lock.release();
    80208d66:	db3fc06f          	j	80205b18 <_ZN8Spinlock7releaseEv>

0000000080208d6a <_ZN7Drivers9uart_putsEPKc>:

    void uart_puts(const char *s)
    {
    80208d6a:	7179                	addi	sp,sp,-48
    80208d6c:	f406                	sd	ra,40(sp)
    80208d6e:	e84a                	sd	s2,16(sp)
        while (*s)
    80208d70:	00054903          	lbu	s2,0(a0)
    80208d74:	04090663          	beqz	s2,80208dc0 <_ZN7Drivers9uart_putsEPKc+0x56>
    80208d78:	f022                	sd	s0,32(sp)
        while ((*(volatile uint8 *)(UART0 + LSR) & LSR_TX_IDLE) == 0)
    80208d7a:	10000437          	lui	s0,0x10000
    80208d7e:	ec26                	sd	s1,24(sp)
    80208d80:	e44e                	sd	s3,8(sp)
    80208d82:	e052                	sd	s4,0(sp)
    80208d84:	84aa                	mv	s1,a0
        uart_tx_lock.acquire();
    80208d86:	0001e997          	auipc	s3,0x1e
    80208d8a:	06a98993          	addi	s3,s3,106 # 80226df0 <_ZN7Drivers12uart_tx_lockE>
        while ((*(volatile uint8 *)(UART0 + LSR) & LSR_TX_IDLE) == 0)
    80208d8e:	10000a37          	lui	s4,0x10000
    80208d92:	0415                	addi	s0,s0,5 # 10000005 <_start-0x701ffffb>
        uart_tx_lock.acquire();
    80208d94:	854e                	mv	a0,s3
            uart_putc(*s++);
    80208d96:	0485                	addi	s1,s1,1
        uart_tx_lock.acquire();
    80208d98:	de9fc0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        while ((*(volatile uint8 *)(UART0 + LSR) & LSR_TX_IDLE) == 0)
    80208d9c:	00044783          	lbu	a5,0(s0)
    80208da0:	0207f793          	andi	a5,a5,32
    80208da4:	dfe5                	beqz	a5,80208d9c <_ZN7Drivers9uart_putsEPKc+0x32>
        *(volatile uint8 *)(UART0 + THR) = c;
    80208da6:	012a0023          	sb	s2,0(s4) # 10000000 <_start-0x70200000>
        uart_tx_lock.release();
    80208daa:	854e                	mv	a0,s3
    80208dac:	d6dfc0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
        while (*s)
    80208db0:	0004c903          	lbu	s2,0(s1)
    80208db4:	fe0910e3          	bnez	s2,80208d94 <_ZN7Drivers9uart_putsEPKc+0x2a>
    80208db8:	7402                	ld	s0,32(sp)
    80208dba:	64e2                	ld	s1,24(sp)
    80208dbc:	69a2                	ld	s3,8(sp)
    80208dbe:	6a02                	ld	s4,0(sp)
    }
    80208dc0:	70a2                	ld	ra,40(sp)
    80208dc2:	6942                	ld	s2,16(sp)
    80208dc4:	6145                	addi	sp,sp,48
    80208dc6:	8082                	ret

0000000080208dc8 <_ZN7Drivers12uart_put_intEi>:

    void uart_put_int(int val)
    {
    80208dc8:	715d                	addi	sp,sp,-80
    80208dca:	e486                	sd	ra,72(sp)
        char buf[16];
        int i = 0;
        if (val == 0)
    80208dcc:	c579                	beqz	a0,80208e9a <_ZN7Drivers12uart_put_intEi+0xd2>
    80208dce:	e0a2                	sd	s0,64(sp)
    80208dd0:	fc26                	sd	s1,56(sp)
    80208dd2:	f84a                	sd	s2,48(sp)
    80208dd4:	f44e                	sd	s3,40(sp)
    80208dd6:	f052                	sd	s4,32(sp)
    80208dd8:	ec56                	sd	s5,24(sp)
    80208dda:	842a                	mv	s0,a0
        {
            uart_puts("0");
            return;
        }
        if (val < 0)
    80208ddc:	08054263          	bltz	a0,80208e60 <_ZN7Drivers12uart_put_intEi+0x98>
    80208de0:	848a                	mv	s1,sp
    {
    80208de2:	87a6                	mv	a5,s1
            uart_puts("-");
            val = -val;
        }
        while (val > 0)
        {
            buf[i++] = (val % 10) + '0';
    80208de4:	46a9                	li	a3,10
    80208de6:	02d4673b          	remw	a4,s0,a3
    80208dea:	863e                	mv	a2,a5
        while (val > 0)
    80208dec:	0785                	addi	a5,a5,1
            val /= 10;
    80208dee:	02d4443b          	divw	s0,s0,a3
            buf[i++] = (val % 10) + '0';
    80208df2:	0307071b          	addiw	a4,a4,48
    80208df6:	fee78fa3          	sb	a4,-1(a5)
        while (val > 0)
    80208dfa:	f475                	bnez	s0,80208de6 <_ZN7Drivers12uart_put_intEi+0x1e>
    80208dfc:	409607bb          	subw	a5,a2,s1
    80208e00:	0017871b          	addiw	a4,a5,1
    80208e04:	fff7079b          	addiw	a5,a4,-1
    80208e08:	fff48a13          	addi	s4,s1,-1
    80208e0c:	1782                	slli	a5,a5,0x20
    80208e0e:	9a3a                	add	s4,s4,a4
    80208e10:	9381                	srli	a5,a5,0x20
        while ((*(volatile uint8 *)(UART0 + LSR) & LSR_TX_IDLE) == 0)
    80208e12:	10000437          	lui	s0,0x10000
    80208e16:	94ba                	add	s1,s1,a4
    80208e18:	40fa0a33          	sub	s4,s4,a5
        uart_tx_lock.acquire();
    80208e1c:	0001e917          	auipc	s2,0x1e
    80208e20:	fd490913          	addi	s2,s2,-44 # 80226df0 <_ZN7Drivers12uart_tx_lockE>
        while ((*(volatile uint8 *)(UART0 + LSR) & LSR_TX_IDLE) == 0)
    80208e24:	10000ab7          	lui	s5,0x10000
    80208e28:	0415                	addi	s0,s0,5 # 10000005 <_start-0x701ffffb>
        uart_tx_lock.acquire();
    80208e2a:	854a                	mv	a0,s2
        }
        while (i > 0)
        {
            uart_putc(buf[--i]);
    80208e2c:	fff4c983          	lbu	s3,-1(s1)
        uart_tx_lock.acquire();
    80208e30:	d51fc0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        while ((*(volatile uint8 *)(UART0 + LSR) & LSR_TX_IDLE) == 0)
    80208e34:	00044783          	lbu	a5,0(s0)
    80208e38:	0207f793          	andi	a5,a5,32
    80208e3c:	dfe5                	beqz	a5,80208e34 <_ZN7Drivers12uart_put_intEi+0x6c>
        *(volatile uint8 *)(UART0 + THR) = c;
    80208e3e:	013a8023          	sb	s3,0(s5) # 10000000 <_start-0x70200000>
        uart_tx_lock.release();
    80208e42:	854a                	mv	a0,s2
        while (i > 0)
    80208e44:	14fd                	addi	s1,s1,-1
        uart_tx_lock.release();
    80208e46:	cd3fc0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
        while (i > 0)
    80208e4a:	fe9a10e3          	bne	s4,s1,80208e2a <_ZN7Drivers12uart_put_intEi+0x62>
    80208e4e:	6406                	ld	s0,64(sp)
        }
    }
    80208e50:	60a6                	ld	ra,72(sp)
    80208e52:	74e2                	ld	s1,56(sp)
    80208e54:	7942                	ld	s2,48(sp)
    80208e56:	79a2                	ld	s3,40(sp)
    80208e58:	7a02                	ld	s4,32(sp)
    80208e5a:	6ae2                	ld	s5,24(sp)
    80208e5c:	6161                	addi	sp,sp,80
    80208e5e:	8082                	ret
        uart_tx_lock.acquire();
    80208e60:	0001e517          	auipc	a0,0x1e
    80208e64:	f9050513          	addi	a0,a0,-112 # 80226df0 <_ZN7Drivers12uart_tx_lockE>
    80208e68:	d19fc0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        while ((*(volatile uint8 *)(UART0 + LSR) & LSR_TX_IDLE) == 0)
    80208e6c:	10000737          	lui	a4,0x10000
    80208e70:	0715                	addi	a4,a4,5 # 10000005 <_start-0x701ffffb>
    80208e72:	00074783          	lbu	a5,0(a4)
    80208e76:	0207f793          	andi	a5,a5,32
    80208e7a:	dfe5                	beqz	a5,80208e72 <_ZN7Drivers12uart_put_intEi+0xaa>
        *(volatile uint8 *)(UART0 + THR) = c;
    80208e7c:	100007b7          	lui	a5,0x10000
    80208e80:	02d00713          	li	a4,45
    80208e84:	00e78023          	sb	a4,0(a5) # 10000000 <_start-0x70200000>
        uart_tx_lock.release();
    80208e88:	0001e517          	auipc	a0,0x1e
    80208e8c:	f6850513          	addi	a0,a0,-152 # 80226df0 <_ZN7Drivers12uart_tx_lockE>
    80208e90:	c89fc0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
            val = -val;
    80208e94:	4080043b          	negw	s0,s0
        while (val > 0)
    80208e98:	b7a1                	j	80208de0 <_ZN7Drivers12uart_put_intEi+0x18>
        uart_tx_lock.acquire();
    80208e9a:	0001e517          	auipc	a0,0x1e
    80208e9e:	f5650513          	addi	a0,a0,-170 # 80226df0 <_ZN7Drivers12uart_tx_lockE>
    80208ea2:	cdffc0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        while ((*(volatile uint8 *)(UART0 + LSR) & LSR_TX_IDLE) == 0)
    80208ea6:	10000737          	lui	a4,0x10000
    80208eaa:	0715                	addi	a4,a4,5 # 10000005 <_start-0x701ffffb>
    80208eac:	00074783          	lbu	a5,0(a4)
    80208eb0:	0207f793          	andi	a5,a5,32
    80208eb4:	dfe5                	beqz	a5,80208eac <_ZN7Drivers12uart_put_intEi+0xe4>
        *(volatile uint8 *)(UART0 + THR) = c;
    80208eb6:	100007b7          	lui	a5,0x10000
    80208eba:	03000713          	li	a4,48
    80208ebe:	00e78023          	sb	a4,0(a5) # 10000000 <_start-0x70200000>
    }
    80208ec2:	60a6                	ld	ra,72(sp)
        uart_tx_lock.release();
    80208ec4:	0001e517          	auipc	a0,0x1e
    80208ec8:	f2c50513          	addi	a0,a0,-212 # 80226df0 <_ZN7Drivers12uart_tx_lockE>
    }
    80208ecc:	6161                	addi	sp,sp,80
        uart_tx_lock.release();
    80208ece:	c4bfc06f          	j	80205b18 <_ZN8Spinlock7releaseEv>

0000000080208ed2 <_ZN7Drivers9print_hexEy>:

    void print_hex(uint64 val)
    {
        char hex[] = "0123456789ABCDEF";
    80208ed2:	00009797          	auipc	a5,0x9
    80208ed6:	37e78793          	addi	a5,a5,894 # 80212250 <initcode_end+0xb08>
    80208eda:	6394                	ld	a3,0(a5)
    80208edc:	6798                	ld	a4,8(a5)
    80208ede:	0107c783          	lbu	a5,16(a5)
    {
    80208ee2:	711d                	addi	sp,sp,-96
    80208ee4:	e8a2                	sd	s0,80(sp)
        while ((*(volatile uint8 *)(UART0 + LSR) & LSR_TX_IDLE) == 0)
    80208ee6:	10000437          	lui	s0,0x10000
    {
    80208eea:	e4a6                	sd	s1,72(sp)
    80208eec:	e0ca                	sd	s2,64(sp)
    80208eee:	fc4e                	sd	s3,56(sp)
    80208ef0:	f852                	sd	s4,48(sp)
    80208ef2:	f456                	sd	s5,40(sp)
    80208ef4:	ec86                	sd	ra,88(sp)
    80208ef6:	f05a                	sd	s6,32(sp)
    80208ef8:	89aa                	mv	s3,a0
        char hex[] = "0123456789ABCDEF";
    80208efa:	e436                	sd	a3,8(sp)
    80208efc:	e83a                	sd	a4,16(sp)
    80208efe:	00f10c23          	sb	a5,24(sp)
        while (*s)
    80208f02:	03000913          	li	s2,48
        char hex[] = "0123456789ABCDEF";
    80208f06:	00009497          	auipc	s1,0x9
    80208f0a:	34248493          	addi	s1,s1,834 # 80212248 <initcode_end+0xb00>
        uart_tx_lock.acquire();
    80208f0e:	0001ea17          	auipc	s4,0x1e
    80208f12:	ee2a0a13          	addi	s4,s4,-286 # 80226df0 <_ZN7Drivers12uart_tx_lockE>
        while ((*(volatile uint8 *)(UART0 + LSR) & LSR_TX_IDLE) == 0)
    80208f16:	10000ab7          	lui	s5,0x10000
    80208f1a:	0415                	addi	s0,s0,5 # 10000005 <_start-0x701ffffb>
        uart_tx_lock.acquire();
    80208f1c:	8552                	mv	a0,s4
            uart_putc(*s++);
    80208f1e:	0485                	addi	s1,s1,1
        uart_tx_lock.acquire();
    80208f20:	c61fc0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        while ((*(volatile uint8 *)(UART0 + LSR) & LSR_TX_IDLE) == 0)
    80208f24:	00044783          	lbu	a5,0(s0)
    80208f28:	0207f793          	andi	a5,a5,32
    80208f2c:	dfe5                	beqz	a5,80208f24 <_ZN7Drivers9print_hexEy+0x52>
        *(volatile uint8 *)(UART0 + THR) = c;
    80208f2e:	012a8023          	sb	s2,0(s5) # 10000000 <_start-0x70200000>
        uart_tx_lock.release();
    80208f32:	8552                	mv	a0,s4
    80208f34:	be5fc0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
        while (*s)
    80208f38:	0004c903          	lbu	s2,0(s1)
    80208f3c:	fe0910e3          	bnez	s2,80208f1c <_ZN7Drivers9print_hexEy+0x4a>
        while ((*(volatile uint8 *)(UART0 + LSR) & LSR_TX_IDLE) == 0)
    80208f40:	10000437          	lui	s0,0x10000
        uart_puts("0x");
        for (int i = 60; i >= 0; i -= 4)
    80208f44:	03c00493          	li	s1,60
        uart_tx_lock.acquire();
    80208f48:	0001e917          	auipc	s2,0x1e
    80208f4c:	ea890913          	addi	s2,s2,-344 # 80226df0 <_ZN7Drivers12uart_tx_lockE>
        while ((*(volatile uint8 *)(UART0 + LSR) & LSR_TX_IDLE) == 0)
    80208f50:	10000b37          	lui	s6,0x10000
    80208f54:	0415                	addi	s0,s0,5 # 10000005 <_start-0x701ffffb>
        for (int i = 60; i >= 0; i -= 4)
    80208f56:	5af1                	li	s5,-4
        {
            uart_putc(hex[(val >> i) & 0xF]);
    80208f58:	0099d7b3          	srl	a5,s3,s1
    80208f5c:	8bbd                	andi	a5,a5,15
    80208f5e:	02078793          	addi	a5,a5,32
    80208f62:	978a                	add	a5,a5,sp
        uart_tx_lock.acquire();
    80208f64:	854a                	mv	a0,s2
            uart_putc(hex[(val >> i) & 0xF]);
    80208f66:	fe87ca03          	lbu	s4,-24(a5)
        uart_tx_lock.acquire();
    80208f6a:	c17fc0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        while ((*(volatile uint8 *)(UART0 + LSR) & LSR_TX_IDLE) == 0)
    80208f6e:	00044783          	lbu	a5,0(s0)
    80208f72:	0207f793          	andi	a5,a5,32
    80208f76:	dfe5                	beqz	a5,80208f6e <_ZN7Drivers9print_hexEy+0x9c>
        *(volatile uint8 *)(UART0 + THR) = c;
    80208f78:	014b0023          	sb	s4,0(s6) # 10000000 <_start-0x70200000>
        uart_tx_lock.release();
    80208f7c:	854a                	mv	a0,s2
        for (int i = 60; i >= 0; i -= 4)
    80208f7e:	34f1                	addiw	s1,s1,-4
        uart_tx_lock.release();
    80208f80:	b99fc0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
        for (int i = 60; i >= 0; i -= 4)
    80208f84:	fd549ae3          	bne	s1,s5,80208f58 <_ZN7Drivers9print_hexEy+0x86>
        }
    }
    80208f88:	60e6                	ld	ra,88(sp)
    80208f8a:	6446                	ld	s0,80(sp)
    80208f8c:	64a6                	ld	s1,72(sp)
    80208f8e:	6906                	ld	s2,64(sp)
    80208f90:	79e2                	ld	s3,56(sp)
    80208f92:	7a42                	ld	s4,48(sp)
    80208f94:	7aa2                	ld	s5,40(sp)
    80208f96:	7b02                	ld	s6,32(sp)
    80208f98:	6125                	addi	sp,sp,96
    80208f9a:	8082                	ret

0000000080208f9c <_ZN7Drivers9uart_intrEv>:

    void uart_intr()
    {
    80208f9c:	1101                	addi	sp,sp,-32
        uart_rx.lock.acquire();
    80208f9e:	0001e517          	auipc	a0,0x1e
    80208fa2:	d0a50513          	addi	a0,a0,-758 # 80226ca8 <_ZN7Drivers7uart_rxE>
    {
    80208fa6:	e426                	sd	s1,8(sp)
    80208fa8:	ec06                	sd	ra,24(sp)

        while (1)
        {
            if ((*(volatile uint8 *)(UART0 + LSR) & LSR_RX_READY) == 0)
    80208faa:	100004b7          	lui	s1,0x10000
        uart_rx.lock.acquire();
    80208fae:	bd3fc0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
            if ((*(volatile uint8 *)(UART0 + LSR) & LSR_RX_READY) == 0)
    80208fb2:	0054c783          	lbu	a5,5(s1) # 10000005 <_start-0x701ffffb>
    80208fb6:	8b85                	andi	a5,a5,1
    80208fb8:	cf9d                	beqz	a5,80208ff6 <_ZN7Drivers9uart_intrEv+0x5a>
    80208fba:	e822                	sd	s0,16(sp)
    80208fbc:	e04a                	sd	s2,0(sp)
    80208fbe:	0495                	addi	s1,s1,5
    80208fc0:	0001e417          	auipc	s0,0x1e
    80208fc4:	ce840413          	addi	s0,s0,-792 # 80226ca8 <_ZN7Drivers7uart_rxE>
                break;

            char c = *(volatile uint8 *)(UART0 + RHR);
    80208fc8:	10000937          	lui	s2,0x10000

            uart_rx.buf[uart_rx.w % UART_RX_BUF_SIZE] = c;
    80208fcc:	09c42783          	lw	a5,156(s0)
            char c = *(volatile uint8 *)(UART0 + RHR);
    80208fd0:	00094683          	lbu	a3,0(s2) # 10000000 <_start-0x70200000>
            uart_rx.w++;

            ProcManager::wakeup(&uart_rx);
    80208fd4:	8522                	mv	a0,s0
            uart_rx.buf[uart_rx.w % UART_RX_BUF_SIZE] = c;
    80208fd6:	07f7f713          	andi	a4,a5,127
    80208fda:	9722                	add	a4,a4,s0
            uart_rx.w++;
    80208fdc:	2785                	addiw	a5,a5,1
    80208fde:	08f42e23          	sw	a5,156(s0)
            uart_rx.buf[uart_rx.w % UART_RX_BUF_SIZE] = c;
    80208fe2:	00d70c23          	sb	a3,24(a4)
            ProcManager::wakeup(&uart_rx);
    80208fe6:	864ff0ef          	jal	8020804a <_ZN11ProcManager6wakeupEPv>
            if ((*(volatile uint8 *)(UART0 + LSR) & LSR_RX_READY) == 0)
    80208fea:	0004c783          	lbu	a5,0(s1)
    80208fee:	8b85                	andi	a5,a5,1
    80208ff0:	fff1                	bnez	a5,80208fcc <_ZN7Drivers9uart_intrEv+0x30>
    80208ff2:	6442                	ld	s0,16(sp)
    80208ff4:	6902                	ld	s2,0(sp)
        }

        uart_rx.lock.release();
    }
    80208ff6:	60e2                	ld	ra,24(sp)
    80208ff8:	64a2                	ld	s1,8(sp)
        uart_rx.lock.release();
    80208ffa:	0001e517          	auipc	a0,0x1e
    80208ffe:	cae50513          	addi	a0,a0,-850 # 80226ca8 <_ZN7Drivers7uart_rxE>
    }
    80209002:	6105                	addi	sp,sp,32
        uart_rx.lock.release();
    80209004:	b15fc06f          	j	80205b18 <_ZN8Spinlock7releaseEv>

0000000080209008 <_ZN7Drivers12console_readEyi>:

    // Modern console read: Line buffering + Editing Keys + Echo
    int console_read(uint64 target, int len)
    {
    80209008:	7159                	addi	sp,sp,-112
    8020900a:	f486                	sd	ra,104(sp)
    8020900c:	e4ce                	sd	s3,72(sp)
    8020900e:	f45e                	sd	s7,40(sp)
    80209010:	f062                	sd	s8,32(sp)
    80209012:	e86a                	sd	s10,16(sp)
    80209014:	8bae                	mv	s7,a1
    80209016:	8c2a                	mv	s8,a0
        struct Proc *p = myproc();
    80209018:	a6bfc0ef          	jal	80205a82 <_Z6myprocv>
    8020901c:	89aa                	mv	s3,a0
        int target_idx = 0;

        cons.lock.acquire();
    8020901e:	0001e517          	auipc	a0,0x1e
    80209022:	d2a50513          	addi	a0,a0,-726 # 80226d48 <_ZN7Drivers4consE>
    80209026:	b5bfc0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        int target_idx = 0;
    8020902a:	4d01                	li	s10,0

        while (target_idx < len)
    8020902c:	1d705363          	blez	s7,802091f2 <_ZN7Drivers12console_readEyi+0x1ea>
    80209030:	f0a2                	sd	s0,96(sp)
    80209032:	e8ca                	sd	s2,80(sp)
    80209034:	e0d2                	sd	s4,64(sp)
    80209036:	fc56                	sd	s5,56(sp)
    80209038:	f85a                	sd	s6,48(sp)
    8020903a:	eca6                	sd	s1,88(sp)
    8020903c:	ec66                	sd	s9,24(sp)
    8020903e:	0001e417          	auipc	s0,0x1e
    80209042:	c6a40413          	addi	s0,s0,-918 # 80226ca8 <_ZN7Drivers7uart_rxE>
    80209046:	000b8b1b          	sext.w	s6,s7
    8020904a:	00f10a13          	addi	s4,sp,15
        {
            while (cons.r < cons.w)
            {
                char c = cons.buf[cons.r++ % sizeof(cons.buf)];
                cons.lock.release();
    8020904e:	0001e917          	auipc	s2,0x1e
    80209052:	cfa90913          	addi	s2,s2,-774 # 80226d48 <_ZN7Drivers4consE>

                if (VM::copyout(p->pagetable, target + target_idx, &c, 1) < 0)
                    return -1;

                target_idx++;
                if (c == '\n')
    80209056:	4aa9                	li	s5,10
            while (cons.r < cons.w)
    80209058:	13842783          	lw	a5,312(s0)
    8020905c:	13c42703          	lw	a4,316(s0)
    80209060:	001d0c9b          	addiw	s9,s10,1
    80209064:	018d04b3          	add	s1,s10,s8
    80209068:	02e7e563          	bltu	a5,a4,80209092 <_ZN7Drivers12console_readEyi+0x8a>
    8020906c:	a89d                	j	802090e2 <_ZN7Drivers12console_readEyi+0xda>
                if (c == '\n')
    8020906e:	00f14783          	lbu	a5,15(sp)
                target_idx++;
    80209072:	000c8d1b          	sext.w	s10,s9
                if (c == '\n')
    80209076:	05578763          	beq	a5,s5,802090c4 <_ZN7Drivers12console_readEyi+0xbc>
                    return target_idx;
                if (target_idx == len)
    8020907a:	056c8563          	beq	s9,s6,802090c4 <_ZN7Drivers12console_readEyi+0xbc>
                    return target_idx;

                cons.lock.acquire();
    8020907e:	b03fc0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
            while (cons.r < cons.w)
    80209082:	13842783          	lw	a5,312(s0)
    80209086:	13c42703          	lw	a4,316(s0)
    8020908a:	2c85                	addiw	s9,s9,1
    8020908c:	0485                	addi	s1,s1,1
    8020908e:	04e7fa63          	bgeu	a5,a4,802090e2 <_ZN7Drivers12console_readEyi+0xda>
                char c = cons.buf[cons.r++ % sizeof(cons.buf)];
    80209092:	07f7f713          	andi	a4,a5,127
    80209096:	9722                	add	a4,a4,s0
    80209098:	0b874703          	lbu	a4,184(a4)
    8020909c:	2785                	addiw	a5,a5,1
                cons.lock.release();
    8020909e:	854a                	mv	a0,s2
                char c = cons.buf[cons.r++ % sizeof(cons.buf)];
    802090a0:	12f42c23          	sw	a5,312(s0)
    802090a4:	00e107a3          	sb	a4,15(sp)
                cons.lock.release();
    802090a8:	a71fc0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
                if (VM::copyout(p->pagetable, target + target_idx, &c, 1) < 0)
    802090ac:	0789b503          	ld	a0,120(s3)
    802090b0:	4685                	li	a3,1
    802090b2:	8652                	mv	a2,s4
    802090b4:	85a6                	mv	a1,s1
    802090b6:	decfd0ef          	jal	802066a2 <_ZN2VM7copyoutEPyyPcy>
    802090ba:	87aa                	mv	a5,a0
                cons.lock.acquire();
    802090bc:	854a                	mv	a0,s2
                if (VM::copyout(p->pagetable, target + target_idx, &c, 1) < 0)
    802090be:	fa07d8e3          	bgez	a5,8020906e <_ZN7Drivers12console_readEyi+0x66>
            {
                if (p->xstate)
                {
                    uart_rx.lock.release();
                    cons.lock.release();
                    return -1;
    802090c2:	5d7d                	li	s10,-1
    802090c4:	7406                	ld	s0,96(sp)
    802090c6:	64e6                	ld	s1,88(sp)
    802090c8:	6946                	ld	s2,80(sp)
    802090ca:	6a06                	ld	s4,64(sp)
    802090cc:	7ae2                	ld	s5,56(sp)
    802090ce:	7b42                	ld	s6,48(sp)
    802090d0:	6ce2                	ld	s9,24(sp)
            }
        }

        cons.lock.release();
        return target_idx;
    }
    802090d2:	70a6                	ld	ra,104(sp)
    802090d4:	69a6                	ld	s3,72(sp)
    802090d6:	7ba2                	ld	s7,40(sp)
    802090d8:	7c02                	ld	s8,32(sp)
    802090da:	856a                	mv	a0,s10
    802090dc:	6d42                	ld	s10,16(sp)
    802090de:	6165                	addi	sp,sp,112
    802090e0:	8082                	ret
            uart_rx.lock.acquire();
    802090e2:	0001e517          	auipc	a0,0x1e
    802090e6:	bc650513          	addi	a0,a0,-1082 # 80226ca8 <_ZN7Drivers7uart_rxE>
    802090ea:	a97fc0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
            while (uart_rx.r == uart_rx.w)
    802090ee:	09842783          	lw	a5,152(s0)
    802090f2:	09c42703          	lw	a4,156(s0)
    802090f6:	04f71f63          	bne	a4,a5,80209154 <_ZN7Drivers12console_readEyi+0x14c>
                cons.lock.release();
    802090fa:	0001e497          	auipc	s1,0x1e
    802090fe:	c4e48493          	addi	s1,s1,-946 # 80226d48 <_ZN7Drivers4consE>
                ProcManager::sleep(&uart_rx, &uart_rx.lock);
    80209102:	0001ec97          	auipc	s9,0x1e
    80209106:	ba6c8c93          	addi	s9,s9,-1114 # 80226ca8 <_ZN7Drivers7uart_rxE>
    8020910a:	a01d                	j	80209130 <_ZN7Drivers12console_readEyi+0x128>
                cons.lock.release();
    8020910c:	a0dfc0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
                ProcManager::sleep(&uart_rx, &uart_rx.lock);
    80209110:	85e6                	mv	a1,s9
    80209112:	0001e517          	auipc	a0,0x1e
    80209116:	b9650513          	addi	a0,a0,-1130 # 80226ca8 <_ZN7Drivers7uart_rxE>
    8020911a:	e2dfe0ef          	jal	80207f46 <_ZN11ProcManager5sleepEPvP8Spinlock>
                cons.lock.acquire();
    8020911e:	8526                	mv	a0,s1
    80209120:	a61fc0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
            while (uart_rx.r == uart_rx.w)
    80209124:	09842783          	lw	a5,152(s0)
    80209128:	09c42703          	lw	a4,156(s0)
    8020912c:	02f71463          	bne	a4,a5,80209154 <_ZN7Drivers12console_readEyi+0x14c>
                if (p->xstate)
    80209130:	0b89a783          	lw	a5,184(s3)
                cons.lock.release();
    80209134:	8526                	mv	a0,s1
                if (p->xstate)
    80209136:	dbf9                	beqz	a5,8020910c <_ZN7Drivers12console_readEyi+0x104>
                    uart_rx.lock.release();
    80209138:	0001e517          	auipc	a0,0x1e
    8020913c:	b7050513          	addi	a0,a0,-1168 # 80226ca8 <_ZN7Drivers7uart_rxE>
    80209140:	9d9fc0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
                    cons.lock.release();
    80209144:	0001e517          	auipc	a0,0x1e
    80209148:	c0450513          	addi	a0,a0,-1020 # 80226d48 <_ZN7Drivers4consE>
    8020914c:	9cdfc0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
                    return -1;
    80209150:	5d7d                	li	s10,-1
    80209152:	bf8d                	j	802090c4 <_ZN7Drivers12console_readEyi+0xbc>
            char c = uart_rx.buf[uart_rx.r++ % UART_RX_BUF_SIZE];
    80209154:	07f7f713          	andi	a4,a5,127
    80209158:	9722                	add	a4,a4,s0
    8020915a:	2785                	addiw	a5,a5,1
    8020915c:	01874483          	lbu	s1,24(a4)
            uart_rx.lock.release();
    80209160:	0001e517          	auipc	a0,0x1e
    80209164:	b4850513          	addi	a0,a0,-1208 # 80226ca8 <_ZN7Drivers7uart_rxE>
            char c = uart_rx.buf[uart_rx.r++ % UART_RX_BUF_SIZE];
    80209168:	08f42c23          	sw	a5,152(s0)
            uart_rx.lock.release();
    8020916c:	9adfc0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
            if (c == 127 || c == '\b')
    80209170:	07f00793          	li	a5,127
    80209174:	08f48663          	beq	s1,a5,80209200 <_ZN7Drivers12console_readEyi+0x1f8>
    80209178:	47a1                	li	a5,8
    8020917a:	08f48363          	beq	s1,a5,80209200 <_ZN7Drivers12console_readEyi+0x1f8>
                if (c == '\r')
    8020917e:	47b5                	li	a5,13
    80209180:	12f48863          	beq	s1,a5,802092b0 <_ZN7Drivers12console_readEyi+0x2a8>
        uart_tx_lock.acquire();
    80209184:	0001e517          	auipc	a0,0x1e
    80209188:	c6c50513          	addi	a0,a0,-916 # 80226df0 <_ZN7Drivers12uart_tx_lockE>
    8020918c:	9f5fc0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        while ((*(volatile uint8 *)(UART0 + LSR) & LSR_TX_IDLE) == 0)
    80209190:	10000737          	lui	a4,0x10000
    80209194:	0715                	addi	a4,a4,5 # 10000005 <_start-0x701ffffb>
    80209196:	00074783          	lbu	a5,0(a4)
    8020919a:	0207f793          	andi	a5,a5,32
    8020919e:	dfe5                	beqz	a5,80209196 <_ZN7Drivers12console_readEyi+0x18e>
        *(volatile uint8 *)(UART0 + THR) = c;
    802091a0:	100007b7          	lui	a5,0x10000
    802091a4:	00978023          	sb	s1,0(a5) # 10000000 <_start-0x70200000>
        uart_tx_lock.release();
    802091a8:	0001e517          	auipc	a0,0x1e
    802091ac:	c4850513          	addi	a0,a0,-952 # 80226df0 <_ZN7Drivers12uart_tx_lockE>
    802091b0:	969fc0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
                cons.buf[cons.e++ % sizeof(cons.buf)] = c;
    802091b4:	14042783          	lw	a5,320(s0)
                if (c == '\n' || cons.e == cons.w + sizeof(cons.buf))
    802091b8:	46a9                	li	a3,10
                cons.buf[cons.e++ % sizeof(cons.buf)] = c;
    802091ba:	07f7f713          	andi	a4,a5,127
    802091be:	9722                	add	a4,a4,s0
    802091c0:	2785                	addiw	a5,a5,1
    802091c2:	14f42023          	sw	a5,320(s0)
    802091c6:	0a970c23          	sb	s1,184(a4)
                if (c == '\n' || cons.e == cons.w + sizeof(cons.buf))
    802091ca:	0ed48563          	beq	s1,a3,802092b4 <_ZN7Drivers12console_readEyi+0x2ac>
    802091ce:	13c46703          	lwu	a4,316(s0)
    802091d2:	02079693          	slli	a3,a5,0x20
    802091d6:	9281                	srli	a3,a3,0x20
    802091d8:	08070713          	addi	a4,a4,128
    802091dc:	0ce68c63          	beq	a3,a4,802092b4 <_ZN7Drivers12console_readEyi+0x2ac>
        while (target_idx < len)
    802091e0:	e77d4ce3          	blt	s10,s7,80209058 <_ZN7Drivers12console_readEyi+0x50>
    802091e4:	7406                	ld	s0,96(sp)
    802091e6:	64e6                	ld	s1,88(sp)
    802091e8:	6946                	ld	s2,80(sp)
    802091ea:	6a06                	ld	s4,64(sp)
    802091ec:	7ae2                	ld	s5,56(sp)
    802091ee:	7b42                	ld	s6,48(sp)
    802091f0:	6ce2                	ld	s9,24(sp)
        cons.lock.release();
    802091f2:	0001e517          	auipc	a0,0x1e
    802091f6:	b5650513          	addi	a0,a0,-1194 # 80226d48 <_ZN7Drivers4consE>
    802091fa:	91ffc0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
        return target_idx;
    802091fe:	bdd1                	j	802090d2 <_ZN7Drivers12console_readEyi+0xca>
                if (cons.e != cons.w)
    80209200:	14042783          	lw	a5,320(s0)
    80209204:	13c42703          	lw	a4,316(s0)
    80209208:	fcf70ce3          	beq	a4,a5,802091e0 <_ZN7Drivers12console_readEyi+0x1d8>
                    cons.e--;
    8020920c:	37fd                	addiw	a5,a5,-1
        uart_tx_lock.acquire();
    8020920e:	0001e517          	auipc	a0,0x1e
    80209212:	be250513          	addi	a0,a0,-1054 # 80226df0 <_ZN7Drivers12uart_tx_lockE>
                    cons.e--;
    80209216:	14f42023          	sw	a5,320(s0)
        uart_tx_lock.acquire();
    8020921a:	967fc0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        while ((*(volatile uint8 *)(UART0 + LSR) & LSR_TX_IDLE) == 0)
    8020921e:	10000737          	lui	a4,0x10000
    80209222:	0715                	addi	a4,a4,5 # 10000005 <_start-0x701ffffb>
    80209224:	00074783          	lbu	a5,0(a4)
    80209228:	0207f793          	andi	a5,a5,32
    8020922c:	dfe5                	beqz	a5,80209224 <_ZN7Drivers12console_readEyi+0x21c>
        *(volatile uint8 *)(UART0 + THR) = c;
    8020922e:	4721                	li	a4,8
    80209230:	100007b7          	lui	a5,0x10000
    80209234:	00e78023          	sb	a4,0(a5) # 10000000 <_start-0x70200000>
        uart_tx_lock.release();
    80209238:	0001e517          	auipc	a0,0x1e
    8020923c:	bb850513          	addi	a0,a0,-1096 # 80226df0 <_ZN7Drivers12uart_tx_lockE>
    80209240:	8d9fc0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
        uart_tx_lock.acquire();
    80209244:	0001e517          	auipc	a0,0x1e
    80209248:	bac50513          	addi	a0,a0,-1108 # 80226df0 <_ZN7Drivers12uart_tx_lockE>
    8020924c:	935fc0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        while ((*(volatile uint8 *)(UART0 + LSR) & LSR_TX_IDLE) == 0)
    80209250:	10000737          	lui	a4,0x10000
    80209254:	0715                	addi	a4,a4,5 # 10000005 <_start-0x701ffffb>
    80209256:	00074783          	lbu	a5,0(a4)
    8020925a:	0207f793          	andi	a5,a5,32
    8020925e:	dfe5                	beqz	a5,80209256 <_ZN7Drivers12console_readEyi+0x24e>
        *(volatile uint8 *)(UART0 + THR) = c;
    80209260:	02000713          	li	a4,32
    80209264:	100007b7          	lui	a5,0x10000
    80209268:	00e78023          	sb	a4,0(a5) # 10000000 <_start-0x70200000>
        uart_tx_lock.release();
    8020926c:	0001e517          	auipc	a0,0x1e
    80209270:	b8450513          	addi	a0,a0,-1148 # 80226df0 <_ZN7Drivers12uart_tx_lockE>
    80209274:	8a5fc0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
        uart_tx_lock.acquire();
    80209278:	0001e517          	auipc	a0,0x1e
    8020927c:	b7850513          	addi	a0,a0,-1160 # 80226df0 <_ZN7Drivers12uart_tx_lockE>
    80209280:	901fc0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
        while ((*(volatile uint8 *)(UART0 + LSR) & LSR_TX_IDLE) == 0)
    80209284:	10000737          	lui	a4,0x10000
    80209288:	0715                	addi	a4,a4,5 # 10000005 <_start-0x701ffffb>
    8020928a:	00074783          	lbu	a5,0(a4)
    8020928e:	0207f793          	andi	a5,a5,32
    80209292:	dfe5                	beqz	a5,8020928a <_ZN7Drivers12console_readEyi+0x282>
        *(volatile uint8 *)(UART0 + THR) = c;
    80209294:	100007b7          	lui	a5,0x10000
    80209298:	4721                	li	a4,8
    8020929a:	00e78023          	sb	a4,0(a5) # 10000000 <_start-0x70200000>
        uart_tx_lock.release();
    8020929e:	0001e517          	auipc	a0,0x1e
    802092a2:	b5250513          	addi	a0,a0,-1198 # 80226df0 <_ZN7Drivers12uart_tx_lockE>
    802092a6:	873fc0ef          	jal	80205b18 <_ZN8Spinlock7releaseEv>
        while (target_idx < len)
    802092aa:	db7d47e3          	blt	s10,s7,80209058 <_ZN7Drivers12console_readEyi+0x50>
    802092ae:	bf1d                	j	802091e4 <_ZN7Drivers12console_readEyi+0x1dc>
                    c = '\n';
    802092b0:	44a9                	li	s1,10
    802092b2:	bdc9                	j	80209184 <_ZN7Drivers12console_readEyi+0x17c>
                    ProcManager::wakeup(&cons);
    802092b4:	0001e517          	auipc	a0,0x1e
    802092b8:	a9450513          	addi	a0,a0,-1388 # 80226d48 <_ZN7Drivers4consE>
                    cons.w = cons.e;
    802092bc:	12f42e23          	sw	a5,316(s0)
                    ProcManager::wakeup(&cons);
    802092c0:	d8bfe0ef          	jal	8020804a <_ZN11ProcManager6wakeupEPv>
        while (target_idx < len)
    802092c4:	d97d4ae3          	blt	s10,s7,80209058 <_ZN7Drivers12console_readEyi+0x50>
    802092c8:	bf31                	j	802091e4 <_ZN7Drivers12console_readEyi+0x1dc>

00000000802092ca <_GLOBAL__sub_I__ZN7Drivers12uart_tx_lockE>:
    802092ca:	0001e797          	auipc	a5,0x1e
    802092ce:	9de78793          	addi	a5,a5,-1570 # 80226ca8 <_ZN7Drivers7uart_rxE>
    802092d2:	0a07a023          	sw	zero,160(a5)
    802092d6:	00008717          	auipc	a4,0x8
    802092da:	4b270713          	addi	a4,a4,1202 # 80211788 <initcode_end+0x40>
    802092de:	0007a023          	sw	zero,0(a5)
    802092e2:	f7d8                	sd	a4,168(a5)
    802092e4:	0a07b823          	sd	zero,176(a5)
    802092e8:	e798                	sd	a4,8(a5)
    802092ea:	0007b823          	sd	zero,16(a5)
    802092ee:	1407a423          	sw	zero,328(a5)
    802092f2:	14e7b823          	sd	a4,336(a5)
    802092f6:	1407bc23          	sd	zero,344(a5)
    802092fa:	8082                	ret

00000000802092fc <_ZN6VirtIO4initEv>:

        Spinlock lock;
    } disk;

    void init()
    {
    802092fc:	1101                	addi	sp,sp,-32
        disk.lock.init("virtio_disk");
    802092fe:	00009597          	auipc	a1,0x9
    80209302:	f6a58593          	addi	a1,a1,-150 # 80212268 <initcode_end+0xb20>
    80209306:	0001e517          	auipc	a0,0x1e
    8020930a:	c1250513          	addi	a0,a0,-1006 # 80226f18 <_ZN6VirtIO4diskE+0x110>
    {
    8020930e:	e822                	sd	s0,16(sp)
    80209310:	e426                	sd	s1,8(sp)
    80209312:	ec06                	sd	ra,24(sp)
        disk.lock.init("virtio_disk");
    80209314:	ec6fc0ef          	jal	802059da <_ZN8Spinlock4initEPKc>
        for (uint64 addr = 0x10001000; addr < 0x10009000; addr += 0x1000)
        {
            volatile uint32 *magic = (volatile uint32 *)(addr + VIRTIO_MMIO_MAGIC_VALUE);
            volatile uint32 *dev_id = (volatile uint32 *)(addr + VIRTIO_MMIO_DEVICE_ID);

            if (*magic == 0x74726976 && *dev_id == 2) // ID 2 = Block Device
    80209318:	74727737          	lui	a4,0x74727
        for (uint64 addr = 0x10001000; addr < 0x10009000; addr += 0x1000)
    8020931c:	10001437          	lui	s0,0x10001
            if (*magic == 0x74726976 && *dev_id == 2) // ID 2 = Block Device
    80209320:	97670713          	addi	a4,a4,-1674 # 74726976 <_start-0xbad968a>
    80209324:	4489                	li	s1,2
        for (uint64 addr = 0x10001000; addr < 0x10009000; addr += 0x1000)
    80209326:	6605                	lui	a2,0x1
    80209328:	100096b7          	lui	a3,0x10009
    8020932c:	a021                	j	80209334 <_ZN6VirtIO4initEv+0x38>
    8020932e:	9432                	add	s0,s0,a2
    80209330:	1ad40663          	beq	s0,a3,802094dc <_ZN6VirtIO4initEv+0x1e0>
            if (*magic == 0x74726976 && *dev_id == 2) // ID 2 = Block Device
    80209334:	401c                	lw	a5,0(s0)
    80209336:	fee79ce3          	bne	a5,a4,8020932e <_ZN6VirtIO4initEv+0x32>
    8020933a:	441c                	lw	a5,8(s0)
    8020933c:	fe9799e3          	bne	a5,s1,8020932e <_ZN6VirtIO4initEv+0x32>
            {
                virtio_base = addr;
    80209340:	e04a                	sd	s2,0(sp)
                found = true;
                Drivers::uart_puts(ANSI_GREEN "[VirtIO] Found Block Device @ ");
    80209342:	00009517          	auipc	a0,0x9
    80209346:	f3650513          	addi	a0,a0,-202 # 80212278 <initcode_end+0xb30>
                virtio_base = addr;
    8020934a:	0000b917          	auipc	s2,0xb
    8020934e:	70e90913          	addi	s2,s2,1806 # 80214a58 <_ZL11virtio_base>
    80209352:	00893023          	sd	s0,0(s2)
                Drivers::uart_puts(ANSI_GREEN "[VirtIO] Found Block Device @ ");
    80209356:	a15ff0ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
                Drivers::print_hex(addr);
    8020935a:	8522                	mv	a0,s0
    8020935c:	b77ff0ef          	jal	80208ed2 <_ZN7Drivers9print_hexEy>
                Drivers::uart_puts(ANSI_RESET "\n");
    80209360:	00009517          	auipc	a0,0x9
    80209364:	f4050513          	addi	a0,a0,-192 # 802122a0 <initcode_end+0xb58>
    80209368:	a03ff0ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
    return reinterpret_cast<volatile uint32 *>(virtio_base + offset);
    8020936c:	00093783          	ld	a5,0(s2)
            Drivers::uart_puts(ANSI_RED "[VirtIO] Fatal - No Block Device found.\n" ANSI_RESET);
            return;
        }

        // 2. Check Device Version (We want Modern v2)
        if (*REG(VIRTIO_MMIO_VERSION) != 2)
    80209370:	43d8                	lw	a4,4(a5)
    80209372:	00970a63          	beq	a4,s1,80209386 <_ZN6VirtIO4initEv+0x8a>
        {
            Drivers::uart_puts(ANSI_YELLOW "[VirtIO] Warning: Legacy device detected (expected v2).\n" ANSI_RESET);
    80209376:	00009517          	auipc	a0,0x9
    8020937a:	f6a50513          	addi	a0,a0,-150 # 802122e0 <initcode_end+0xb98>
    8020937e:	9edff0ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
    return reinterpret_cast<volatile uint32 *>(virtio_base + offset);
    80209382:	00093783          	ld	a5,0(s2)
        }

        // 3. Reset Device
        *REG(VIRTIO_MMIO_STATUS) = 0;
    80209386:	0607a823          	sw	zero,112(a5)

        // 4. Set ACKNOWLEDGE & DRIVER status
        uint32 status = *REG(VIRTIO_MMIO_STATUS);
    8020938a:	5bb4                	lw	a3,112(a5)
        // 5. Feature Negotiation
        *REG(VIRTIO_MMIO_DEVICE_FEATURES_SEL) = 0;
        uint32 device_features_lo = *REG(VIRTIO_MMIO_DEVICE_FEATURES);
        (void)device_features_lo;

        *REG(VIRTIO_MMIO_DEVICE_FEATURES_SEL) = 1;
    8020938c:	4705                	li	a4,1
        status |= VIRTIO_CONFIG_S_FEATURES_OK;
        *REG(VIRTIO_MMIO_STATUS) = status;

        if (!(*REG(VIRTIO_MMIO_STATUS) & VIRTIO_CONFIG_S_FEATURES_OK))
        {
            Drivers::uart_puts("VirtIO: Feature negotiation failed.\n");
    8020938e:	00009517          	auipc	a0,0x9
    80209392:	f9a50513          	addi	a0,a0,-102 # 80212328 <initcode_end+0xbe0>
        status |= VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER;
    80209396:	0036e613          	ori	a2,a3,3
        *REG(VIRTIO_MMIO_STATUS) = status;
    8020939a:	dbb0                	sw	a2,112(a5)
        *REG(VIRTIO_MMIO_DEVICE_FEATURES_SEL) = 0;
    8020939c:	0007aa23          	sw	zero,20(a5)
        uint32 device_features_lo = *REG(VIRTIO_MMIO_DEVICE_FEATURES);
    802093a0:	4b90                	lw	a2,16(a5)
        *REG(VIRTIO_MMIO_DEVICE_FEATURES_SEL) = 1;
    802093a2:	cbd8                	sw	a4,20(a5)
        uint32 device_features_hi = *REG(VIRTIO_MMIO_DEVICE_FEATURES);
    802093a4:	4b90                	lw	a2,16(a5)
        *REG(VIRTIO_MMIO_DRIVER_FEATURES_SEL) = 0;
    802093a6:	0207a223          	sw	zero,36(a5)
        *REG(VIRTIO_MMIO_DRIVER_FEATURES) = 0;
    802093aa:	0207a023          	sw	zero,32(a5)
        *REG(VIRTIO_MMIO_DRIVER_FEATURES_SEL) = 1;
    802093ae:	d3d8                	sw	a4,36(a5)
        *REG(VIRTIO_MMIO_DRIVER_FEATURES) = 1;
    802093b0:	d398                	sw	a4,32(a5)
        status |= VIRTIO_CONFIG_S_FEATURES_OK;
    802093b2:	00b6e713          	ori	a4,a3,11
        *REG(VIRTIO_MMIO_STATUS) = status;
    802093b6:	dbb8                	sw	a4,112(a5)
        if (!(*REG(VIRTIO_MMIO_STATUS) & VIRTIO_CONFIG_S_FEATURES_OK))
    802093b8:	5bb8                	lw	a4,112(a5)
        uint32 status = *REG(VIRTIO_MMIO_STATUS);
    802093ba:	0006849b          	sext.w	s1,a3
        if (!(*REG(VIRTIO_MMIO_STATUS) & VIRTIO_CONFIG_S_FEATURES_OK))
    802093be:	8b21                	andi	a4,a4,8
    802093c0:	10070763          	beqz	a4,802094ce <_ZN6VirtIO4initEv+0x1d2>
            return;
        }

        // 6. Queue Configuration
        *REG(VIRTIO_MMIO_QUEUE_SEL) = 0;
    802093c4:	0207a823          	sw	zero,48(a5)
        if (*REG(VIRTIO_MMIO_QUEUE_READY))
    802093c8:	43f8                	lw	a4,68(a5)
    802093ca:	12071363          	bnez	a4,802094f0 <_ZN6VirtIO4initEv+0x1f4>
        {
            Drivers::uart_puts("VirtIO: Queue 0 not ready.\n");
        }

        uint32 max_queue = *REG(VIRTIO_MMIO_QUEUE_NUM_MAX);
    802093ce:	5bd4                	lw	a3,52(a5)
        if (max_queue < NUM_DESCS)
    802093d0:	471d                	li	a4,7
        {
            Drivers::uart_puts("VirtIO: Queue size too small.\n");
    802093d2:	00009517          	auipc	a0,0x9
    802093d6:	f9e50513          	addi	a0,a0,-98 # 80212370 <initcode_end+0xc28>
        if (max_queue < NUM_DESCS)
    802093da:	0ed77a63          	bgeu	a4,a3,802094ce <_ZN6VirtIO4initEv+0x1d2>
            return;
        }

        *REG(VIRTIO_MMIO_QUEUE_NUM) = NUM_DESCS;
    802093de:	4721                	li	a4,8
    802093e0:	df98                	sw	a4,56(a5)

        // Allocate Memory for VirtQueues
        void *ptr = PMM::alloc_pages(1); // 4KB is enough for small rings
    802093e2:	4505                	li	a0,1
    802093e4:	96dfd0ef          	jal	80206d50 <_ZN3PMM11alloc_pagesEi>
        memset(ptr, 0, PGSIZE);
    802093e8:	6605                	lui	a2,0x1
    802093ea:	4581                	li	a1,0
        void *ptr = PMM::alloc_pages(1); // 4KB is enough for small rings
    802093ec:	842a                	mv	s0,a0
        memset(ptr, 0, PGSIZE);
    802093ee:	a3dfb0ef          	jal	80204e2a <_Z6memsetPvij>

        uint64 base_addr = (uint64)ptr;
        disk.desc = reinterpret_cast<struct VRingDesc *>(base_addr);
        disk.avail = reinterpret_cast<struct VRingAvail *>(base_addr + NUM_DESCS * 16);
        disk.used = reinterpret_cast<struct VRingUsed *>(base_addr + PGSIZE / 2);
    802093f2:	6785                	lui	a5,0x1
    return reinterpret_cast<volatile uint32 *>(virtio_base + offset);
    802093f4:	00093603          	ld	a2,0(s2)
        disk.used = reinterpret_cast<struct VRingUsed *>(base_addr + PGSIZE / 2);
    802093f8:	80078793          	addi	a5,a5,-2048 # 800 <_start-0x801ff800>
        disk.desc = reinterpret_cast<struct VRingDesc *>(base_addr);
    802093fc:	0001e697          	auipc	a3,0x1e
    80209400:	a0c68693          	addi	a3,a3,-1524 # 80226e08 <_ZN6VirtIO4diskE>
        disk.avail = reinterpret_cast<struct VRingAvail *>(base_addr + NUM_DESCS * 16);
    80209404:	08040713          	addi	a4,s0,128 # 10001080 <_start-0x701fef80>
        disk.used = reinterpret_cast<struct VRingUsed *>(base_addr + PGSIZE / 2);
    80209408:	97a2                	add	a5,a5,s0
        disk.desc = reinterpret_cast<struct VRingDesc *>(base_addr);
    8020940a:	e280                	sd	s0,0(a3)
        disk.avail = reinterpret_cast<struct VRingAvail *>(base_addr + NUM_DESCS * 16);
    8020940c:	e698                	sd	a4,8(a3)
        disk.used = reinterpret_cast<struct VRingUsed *>(base_addr + PGSIZE / 2);
    8020940e:	ea9c                	sd	a5,16(a3)

        *REG(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint32)base_addr;
    80209410:	0004059b          	sext.w	a1,s0
    80209414:	08b62023          	sw	a1,128(a2) # 1080 <_start-0x801fef80>
        *REG(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint32)(base_addr >> 32);
    80209418:	9401                	srai	s0,s0,0x20
    8020941a:	08862223          	sw	s0,132(a2)

        uint64 avail_addr = (uint64)disk.avail;
        *REG(VIRTIO_MMIO_QUEUE_DRIVER_LOW) = (uint32)avail_addr;
    8020941e:	0007059b          	sext.w	a1,a4
    80209422:	08b62823          	sw	a1,144(a2)
        *REG(VIRTIO_MMIO_QUEUE_DRIVER_HIGH) = (uint32)(avail_addr >> 32);
    80209426:	9701                	srai	a4,a4,0x20
    80209428:	08e62a23          	sw	a4,148(a2)

        uint64 used_addr = (uint64)disk.used;
        *REG(VIRTIO_MMIO_QUEUE_DEVICE_LOW) = (uint32)used_addr;
    8020942c:	0007871b          	sext.w	a4,a5
    80209430:	0ae62023          	sw	a4,160(a2)
        *REG(VIRTIO_MMIO_QUEUE_DEVICE_HIGH) = (uint32)(used_addr >> 32);
    80209434:	9781                	srai	a5,a5,0x20
    80209436:	0af62223          	sw	a5,164(a2)

        *REG(VIRTIO_MMIO_QUEUE_READY) = 1;
    8020943a:	4705                	li	a4,1

        // 7. Initialize Internal Structures
        disk.free_head = 0;
    8020943c:	4785                	li	a5,1
        *REG(VIRTIO_MMIO_QUEUE_READY) = 1;
    8020943e:	c278                	sw	a4,68(a2)
        disk.free_head = 0;
    80209440:	178e                	slli	a5,a5,0x23
    80209442:	ee9c                	sd	a5,24(a3)
        disk.num_free = NUM_DESCS;
        disk.used_idx = 0;
    80209444:	0001e797          	auipc	a5,0x1e
    80209448:	a0079223          	sh	zero,-1532(a5) # 80226e48 <_ZN6VirtIO4diskE+0x40>
        for (int i = 0; i < NUM_DESCS; i++)
    8020944c:	8736                	mv	a4,a3
    8020944e:	4781                	li	a5,0
    80209450:	45a1                	li	a1,8
        {
            disk.free_chain[i] = i + 1;
    80209452:	2785                	addiw	a5,a5,1
    80209454:	d31c                	sw	a5,32(a4)
            disk.info[i].busy = 0;
    80209456:	0406a223          	sw	zero,68(a3)
        for (int i = 0; i < NUM_DESCS; i++)
    8020945a:	0711                	addi	a4,a4,4
    8020945c:	06a1                	addi	a3,a3,8
    8020945e:	feb79ae3          	bne	a5,a1,80209452 <_ZN6VirtIO4initEv+0x156>
        }

        // 8. Finalize Setup
        status |= VIRTIO_CONFIG_S_DRIVER_OK;
    80209462:	00f4e693          	ori	a3,s1,15
        *REG(VIRTIO_MMIO_STATUS) = status;
    80209466:	da34                	sw	a3,112(a2)

        // === [Feature] Read Capacity ===
        volatile struct virtio_blk_config *config = (volatile struct virtio_blk_config *)(virtio_base + VIRTIO_MMIO_CONFIG);
        uint64 capacity_sectors = config->capacity;
    80209468:	10064703          	lbu	a4,256(a2)
    8020946c:	10164803          	lbu	a6,257(a2)
    80209470:	10264503          	lbu	a0,258(a2)
    80209474:	10364583          	lbu	a1,259(a2)
        volatile struct virtio_blk_config *config = (volatile struct virtio_blk_config *)(virtio_base + VIRTIO_MMIO_CONFIG);
    80209478:	10060793          	addi	a5,a2,256
        uint64 capacity_sectors = config->capacity;
    8020947c:	0822                	slli	a6,a6,0x8
    8020947e:	10464603          	lbu	a2,260(a2)
    80209482:	00e86833          	or	a6,a6,a4
    80209486:	0057c683          	lbu	a3,5(a5)
    8020948a:	0542                	slli	a0,a0,0x10
    8020948c:	0067c703          	lbu	a4,6(a5)
    80209490:	01056533          	or	a0,a0,a6
    80209494:	05e2                	slli	a1,a1,0x18
    80209496:	8dc9                	or	a1,a1,a0
    80209498:	0077c403          	lbu	s0,7(a5)
    8020949c:	02061793          	slli	a5,a2,0x20
    802094a0:	8fcd                	or	a5,a5,a1
    802094a2:	16a2                	slli	a3,a3,0x28
    802094a4:	8edd                	or	a3,a3,a5
    802094a6:	03071793          	slli	a5,a4,0x30
    802094aa:	8fd5                	or	a5,a5,a3
        uint64 size_mb = (capacity_sectors * 512) / (1024 * 1024);

        Drivers::uart_puts(ANSI_GREEN "[VirtIO] Initialized. Capacity: ");
    802094ac:	00009517          	auipc	a0,0x9
    802094b0:	ee450513          	addi	a0,a0,-284 # 80212390 <initcode_end+0xc48>
        uint64 capacity_sectors = config->capacity;
    802094b4:	1462                	slli	s0,s0,0x38
    802094b6:	8c5d                	or	s0,s0,a5
        Drivers::uart_puts(ANSI_GREEN "[VirtIO] Initialized. Capacity: ");
    802094b8:	8b3ff0ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        uint64 size_mb = (capacity_sectors * 512) / (1024 * 1024);
    802094bc:	01541513          	slli	a0,s0,0x15
        Drivers::uart_put_int(size_mb);
    802094c0:	9501                	srai	a0,a0,0x20
    802094c2:	907ff0ef          	jal	80208dc8 <_ZN7Drivers12uart_put_intEi>
        Drivers::uart_puts(" MB\n" ANSI_RESET);
    802094c6:	00009517          	auipc	a0,0x9
    802094ca:	ef250513          	addi	a0,a0,-270 # 802123b8 <initcode_end+0xc70>
    }
    802094ce:	6442                	ld	s0,16(sp)
        Drivers::uart_puts(" MB\n" ANSI_RESET);
    802094d0:	6902                	ld	s2,0(sp)
    }
    802094d2:	60e2                	ld	ra,24(sp)
    802094d4:	64a2                	ld	s1,8(sp)
    802094d6:	6105                	addi	sp,sp,32
        Drivers::uart_puts(" MB\n" ANSI_RESET);
    802094d8:	893ff06f          	j	80208d6a <_ZN7Drivers9uart_putsEPKc>
    }
    802094dc:	6442                	ld	s0,16(sp)
    802094de:	60e2                	ld	ra,24(sp)
    802094e0:	64a2                	ld	s1,8(sp)
            Drivers::uart_puts(ANSI_RED "[VirtIO] Fatal - No Block Device found.\n" ANSI_RESET);
    802094e2:	00009517          	auipc	a0,0x9
    802094e6:	dc650513          	addi	a0,a0,-570 # 802122a8 <initcode_end+0xb60>
    }
    802094ea:	6105                	addi	sp,sp,32
        Drivers::uart_puts(" MB\n" ANSI_RESET);
    802094ec:	87fff06f          	j	80208d6a <_ZN7Drivers9uart_putsEPKc>
            Drivers::uart_puts("VirtIO: Queue 0 not ready.\n");
    802094f0:	00009517          	auipc	a0,0x9
    802094f4:	e6050513          	addi	a0,a0,-416 # 80212350 <initcode_end+0xc08>
    802094f8:	873ff0ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
    return reinterpret_cast<volatile uint32 *>(virtio_base + offset);
    802094fc:	00093783          	ld	a5,0(s2)
    80209500:	b5f9                	j	802093ce <_ZN6VirtIO4initEv+0xd2>

0000000080209502 <_ZN6VirtIO2rwEiyPc>:
                break;
        }
    }

    void rw(int write, uint64 blockno, char *buf)
    {
    80209502:	715d                	addi	sp,sp,-80
    80209504:	e85a                	sd	s6,16(sp)
    80209506:	8b2a                	mv	s6,a0
        uint64 sector = blockno * (1024 / 512); // Assume 1KB blocks

        disk.lock.acquire();
    80209508:	0001e517          	auipc	a0,0x1e
    8020950c:	a1050513          	addi	a0,a0,-1520 # 80226f18 <_ZN6VirtIO4diskE+0x110>
    {
    80209510:	e0a2                	sd	s0,64(sp)
    80209512:	ec56                	sd	s5,24(sp)
    80209514:	e45e                	sd	s7,8(sp)
    80209516:	e486                	sd	ra,72(sp)
    80209518:	fc26                	sd	s1,56(sp)
    8020951a:	f84a                	sd	s2,48(sp)
    8020951c:	f44e                	sd	s3,40(sp)
    8020951e:	f052                	sd	s4,32(sp)
    80209520:	8bb2                	mv	s7,a2
        uint64 sector = blockno * (1024 / 512); // Assume 1KB blocks
    80209522:	00159a93          	slli	s5,a1,0x1
        disk.lock.acquire();
    80209526:	0001e417          	auipc	s0,0x1e
    8020952a:	8e240413          	addi	s0,s0,-1822 # 80226e08 <_ZN6VirtIO4diskE>
    8020952e:	e52fc0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>

        // Wait for enough descriptors
        while (disk.num_free < 3)
    80209532:	4c5c                	lw	a5,28(s0)
    80209534:	4709                	li	a4,2
    80209536:	02f74263          	blt	a4,a5,8020955a <_ZN6VirtIO2rwEiyPc+0x58>
        {
            ProcManager::sleep(&disk.free_head, &disk.lock);
    8020953a:	0001e997          	auipc	s3,0x1e
    8020953e:	9de98993          	addi	s3,s3,-1570 # 80226f18 <_ZN6VirtIO4diskE+0x110>
    80209542:	0001e917          	auipc	s2,0x1e
    80209546:	8de90913          	addi	s2,s2,-1826 # 80226e20 <_ZN6VirtIO4diskE+0x18>
        while (disk.num_free < 3)
    8020954a:	4489                	li	s1,2
            ProcManager::sleep(&disk.free_head, &disk.lock);
    8020954c:	85ce                	mv	a1,s3
    8020954e:	854a                	mv	a0,s2
    80209550:	9f7fe0ef          	jal	80207f46 <_ZN11ProcManager5sleepEPvP8Spinlock>
        while (disk.num_free < 3)
    80209554:	4c5c                	lw	a5,28(s0)
    80209556:	fef4dbe3          	bge	s1,a5,8020954c <_ZN6VirtIO2rwEiyPc+0x4a>
        int id = disk.free_head;
    8020955a:	01842a03          	lw	s4,24(s0)
        disk.free_head = disk.free_chain[id];
    8020955e:	56fd                	li	a3,-1
        struct BlockRequest *req = &disk.reqs[idx[0]];
        req->type = write ? VIRTIO_BLK_T_OUT : VIRTIO_BLK_T_IN;
        req->reserved = 0;
        req->sector = sector;

        disk.desc[idx[0]].addr = (uint64)req;
    80209560:	6010                	ld	a2,0(s0)
        disk.free_head = disk.free_chain[id];
    80209562:	008a0493          	addi	s1,s4,8
    80209566:	00249713          	slli	a4,s1,0x2
    8020956a:	9722                	add	a4,a4,s0
    8020956c:	00072803          	lw	a6,0(a4)
    80209570:	9281                	srli	a3,a3,0x20
        disk.num_free--;
    80209572:	37f5                	addiw	a5,a5,-3
        disk.free_head = disk.free_chain[id];
    80209574:	00880713          	addi	a4,a6,8 # 1008 <_start-0x801feff8>
    80209578:	070a                	slli	a4,a4,0x2
    8020957a:	9722                	add	a4,a4,s0
    8020957c:	430c                	lw	a1,0(a4)
        disk.num_free--;
    8020957e:	004a1993          	slli	s3,s4,0x4
        disk.free_head = disk.free_chain[id];
    80209582:	1782                	slli	a5,a5,0x20
    80209584:	00858713          	addi	a4,a1,8
    80209588:	070a                	slli	a4,a4,0x2
    8020958a:	9722                	add	a4,a4,s0
    8020958c:	00076503          	lwu	a0,0(a4)
        req->type = write ? VIRTIO_BLK_T_OUT : VIRTIO_BLK_T_IN;
    80209590:	00449713          	slli	a4,s1,0x4
    80209594:	9722                	add	a4,a4,s0
        disk.free_head = disk.free_chain[id];
    80209596:	8d75                	and	a0,a0,a3
    80209598:	8fc9                	or	a5,a5,a0
        req->sector = sector;
    8020959a:	00daf6b3          	and	a3,s5,a3
        req->type = write ? VIRTIO_BLK_T_OUT : VIRTIO_BLK_T_IN;
    8020959e:	016038b3          	snez	a7,s6
        req->sector = sector;
    802095a2:	020ada93          	srli	s5,s5,0x20
        struct BlockRequest *req = &disk.reqs[idx[0]];
    802095a6:	08498513          	addi	a0,s3,132
        disk.free_head = disk.free_chain[id];
    802095aa:	ec1c                	sd	a5,24(s0)
        req->sector = sector;
    802095ac:	c754                	sw	a3,12(a4)
        req->type = write ? VIRTIO_BLK_T_OUT : VIRTIO_BLK_T_IN;
    802095ae:	01172223          	sw	a7,4(a4)
        req->reserved = 0;
    802095b2:	00072423          	sw	zero,8(a4)
        req->sector = sector;
    802095b6:	01572823          	sw	s5,16(a4)
        struct BlockRequest *req = &disk.reqs[idx[0]];
    802095ba:	00a406b3          	add	a3,s0,a0
        disk.desc[idx[0]].addr = (uint64)req;
    802095be:	01360733          	add	a4,a2,s3
    802095c2:	e314                	sd	a3,0(a4)
        disk.desc[idx[0]].len = sizeof(struct BlockRequest);
    802095c4:	46c1                	li	a3,16
    802095c6:	c714                	sw	a3,8(a4)
        disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
        disk.desc[idx[0]].next = idx[1];

        // 2. Data Buffer
        disk.desc[idx[1]].addr = (uint64)buf;
    802095c8:	00481793          	slli	a5,a6,0x4
        disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    802095cc:	4685                	li	a3,1
    802095ce:	00d71623          	sh	a3,12(a4)
        disk.desc[idx[0]].next = idx[1];
    802095d2:	01071723          	sh	a6,14(a4)
        disk.desc[idx[1]].addr = (uint64)buf;
    802095d6:	97b2                	add	a5,a5,a2
        disk.desc[idx[1]].len = 1024; // Fixed 1KB for this test
    802095d8:	40000713          	li	a4,1024
        disk.desc[idx[1]].addr = (uint64)buf;
    802095dc:	0177b023          	sd	s7,0(a5)
        disk.desc[idx[1]].len = 1024; // Fixed 1KB for this test
    802095e0:	c798                	sw	a4,8(a5)
        disk.desc[idx[1]].flags = VRING_DESC_F_NEXT;
        if (!write)
    802095e2:	000b1363          	bnez	s6,802095e8 <_ZN6VirtIO2rwEiyPc+0xe6>
            disk.desc[idx[1]].flags |= VRING_DESC_F_WRITE;
    802095e6:	468d                	li	a3,3
        disk.desc[idx[1]].next = idx[2];
    802095e8:	0105951b          	slliw	a0,a1,0x10

        // 3. Status Byte
        disk.desc[idx[2]].addr = (uint64)&disk.req_status[idx[0]];
        disk.desc[idx[2]].len = 1;
    802095ec:	4705                	li	a4,1
    802095ee:	8ec9                	or	a3,a3,a0
        disk.desc[idx[2]].addr = (uint64)&disk.req_status[idx[0]];
    802095f0:	0592                	slli	a1,a1,0x4
        disk.desc[idx[2]].len = 1;
    802095f2:	1706                	slli	a4,a4,0x21
    802095f4:	c7d4                	sw	a3,12(a5)
    802095f6:	0705                	addi	a4,a4,1
        disk.desc[idx[2]].addr = (uint64)&disk.req_status[idx[0]];
    802095f8:	00b607b3          	add	a5,a2,a1
        disk.desc[idx[2]].len = 1;
    802095fc:	e798                	sd	a4,8(a5)
        disk.desc[idx[2]].next = 0;

        disk.info[idx[0]].busy = 1;

        // Submit to Avail Ring
        disk.avail->ring[disk.avail->idx % NUM_DESCS] = idx[0];
    802095fe:	6414                	ld	a3,8(s0)
        disk.desc[idx[2]].addr = (uint64)&disk.req_status[idx[0]];
    80209600:	104a0613          	addi	a2,s4,260
    80209604:	9622                	add	a2,a2,s0
        disk.avail->ring[disk.avail->idx % NUM_DESCS] = idx[0];
    80209606:	0026d703          	lhu	a4,2(a3)
        disk.info[idx[0]].busy = 1;
    8020960a:	048e                	slli	s1,s1,0x3
        disk.desc[idx[2]].addr = (uint64)&disk.req_status[idx[0]];
    8020960c:	e390                	sd	a2,0(a5)
        disk.avail->ring[disk.avail->idx % NUM_DESCS] = idx[0];
    8020960e:	00777793          	andi	a5,a4,7
        disk.info[idx[0]].busy = 1;
    80209612:	94a2                	add	s1,s1,s0
        disk.avail->ring[disk.avail->idx % NUM_DESCS] = idx[0];
    80209614:	0786                	slli	a5,a5,0x1
        disk.info[idx[0]].busy = 1;
    80209616:	4705                	li	a4,1
    80209618:	c0d8                	sw	a4,4(s1)
        disk.avail->ring[disk.avail->idx % NUM_DESCS] = idx[0];
    8020961a:	96be                	add	a3,a3,a5
    8020961c:	01469223          	sh	s4,4(a3)
        __sync_synchronize();
    80209620:	0330000f          	fence	rw,rw
        disk.avail->idx++;
    80209624:	6418                	ld	a4,8(s0)
    80209626:	00275783          	lhu	a5,2(a4)
    8020962a:	2785                	addiw	a5,a5,1
    8020962c:	00f71123          	sh	a5,2(a4)
        __sync_synchronize();
    80209630:	0330000f          	fence	rw,rw
    return reinterpret_cast<volatile uint32 *>(virtio_base + offset);
    80209634:	0000b797          	auipc	a5,0xb
    80209638:	4247b783          	ld	a5,1060(a5) # 80214a58 <_ZL11virtio_base>

        // Notify Device
        *REG(VIRTIO_MMIO_QUEUE_NOTIFY) = 0;
    8020963c:	0407a823          	sw	zero,80(a5)

        // Wait for Completion
        while (disk.info[idx[0]].busy)
    80209640:	40dc                	lw	a5,4(s1)
        {
            ProcManager::sleep(&disk.info[idx[0]], &disk.lock);
    80209642:	003a1913          	slli	s2,s4,0x3
    80209646:	04490913          	addi	s2,s2,68
    8020964a:	9922                	add	s2,s2,s0
    8020964c:	0001ea97          	auipc	s5,0x1e
    80209650:	8cca8a93          	addi	s5,s5,-1844 # 80226f18 <_ZN6VirtIO4diskE+0x110>
        while (disk.info[idx[0]].busy)
    80209654:	c799                	beqz	a5,80209662 <_ZN6VirtIO2rwEiyPc+0x160>
            ProcManager::sleep(&disk.info[idx[0]], &disk.lock);
    80209656:	85d6                	mv	a1,s5
    80209658:	854a                	mv	a0,s2
    8020965a:	8edfe0ef          	jal	80207f46 <_ZN11ProcManager5sleepEPvP8Spinlock>
        while (disk.info[idx[0]].busy)
    8020965e:	40dc                	lw	a5,4(s1)
    80209660:	fbfd                	bnez	a5,80209656 <_ZN6VirtIO2rwEiyPc+0x154>
        disk.free_head = id;
    80209662:	54fd                	li	s1,-1
    80209664:	9081                	srli	s1,s1,0x20
        ProcManager::wakeup(&disk.free_head);
    80209666:	0001d917          	auipc	s2,0x1d
    8020966a:	7ba90913          	addi	s2,s2,1978 # 80226e20 <_ZN6VirtIO4diskE+0x18>
    8020966e:	a019                	j	80209674 <_ZN6VirtIO2rwEiyPc+0x172>
    80209670:	004a1993          	slli	s3,s4,0x4
            int flag = disk.desc[curr].flags;
    80209674:	6010                	ld	a2,0(s0)
        disk.num_free++;
    80209676:	4c54                	lw	a3,28(s0)
        disk.free_chain[id] = disk.free_head;
    80209678:	4c0c                	lw	a1,24(s0)
            int flag = disk.desc[curr].flags;
    8020967a:	964e                	add	a2,a2,s3
    8020967c:	00c65983          	lhu	s3,12(a2)
        disk.free_chain[id] = disk.free_head;
    80209680:	008a0713          	addi	a4,s4,8
        disk.num_free++;
    80209684:	2685                	addiw	a3,a3,1
        disk.free_head = id;
    80209686:	1682                	slli	a3,a3,0x20
    80209688:	009a77b3          	and	a5,s4,s1
        disk.free_chain[id] = disk.free_head;
    8020968c:	070a                	slli	a4,a4,0x2
    8020968e:	9722                	add	a4,a4,s0
        disk.free_head = id;
    80209690:	8fd5                	or	a5,a5,a3
        ProcManager::wakeup(&disk.free_head);
    80209692:	854a                	mv	a0,s2
            if (flag & VRING_DESC_F_NEXT)
    80209694:	0019f993          	andi	s3,s3,1
            int next = disk.desc[curr].next;
    80209698:	00e65a03          	lhu	s4,14(a2)
        disk.free_chain[id] = disk.free_head;
    8020969c:	c30c                	sw	a1,0(a4)
        disk.free_head = id;
    8020969e:	ec1c                	sd	a5,24(s0)
        ProcManager::wakeup(&disk.free_head);
    802096a0:	9abfe0ef          	jal	8020804a <_ZN11ProcManager6wakeupEPv>
            if (flag & VRING_DESC_F_NEXT)
    802096a4:	fc0996e3          	bnez	s3,80209670 <_ZN6VirtIO2rwEiyPc+0x16e>
        }

        free_chain_soft(idx[0]);
        disk.lock.release();
    }
    802096a8:	6406                	ld	s0,64(sp)
    802096aa:	60a6                	ld	ra,72(sp)
    802096ac:	74e2                	ld	s1,56(sp)
    802096ae:	7942                	ld	s2,48(sp)
    802096b0:	79a2                	ld	s3,40(sp)
    802096b2:	7a02                	ld	s4,32(sp)
    802096b4:	6ae2                	ld	s5,24(sp)
    802096b6:	6b42                	ld	s6,16(sp)
    802096b8:	6ba2                	ld	s7,8(sp)
        disk.lock.release();
    802096ba:	0001e517          	auipc	a0,0x1e
    802096be:	85e50513          	addi	a0,a0,-1954 # 80226f18 <_ZN6VirtIO4diskE+0x110>
    }
    802096c2:	6161                	addi	sp,sp,80
        disk.lock.release();
    802096c4:	c54fc06f          	j	80205b18 <_ZN8Spinlock7releaseEv>

00000000802096c8 <_ZN6VirtIO4intrEv>:

    void intr()
    {
    802096c8:	1101                	addi	sp,sp,-32
        disk.lock.acquire();
    802096ca:	0001e517          	auipc	a0,0x1e
    802096ce:	84e50513          	addi	a0,a0,-1970 # 80226f18 <_ZN6VirtIO4diskE+0x110>
    {
    802096d2:	e822                	sd	s0,16(sp)
    802096d4:	e426                	sd	s1,8(sp)
    802096d6:	ec06                	sd	ra,24(sp)
        disk.lock.acquire();
    802096d8:	ca8fc0ef          	jal	80205b80 <_ZN8Spinlock7acquireEv>
    return reinterpret_cast<volatile uint32 *>(virtio_base + offset);
    802096dc:	0000b697          	auipc	a3,0xb
    802096e0:	37c6b683          	ld	a3,892(a3) # 80214a58 <_ZL11virtio_base>

        uint32 status = *REG(VIRTIO_MMIO_INTERRUPT_STATUS);
    802096e4:	52b8                	lw	a4,96(a3)
        disk.lock.acquire();
    802096e6:	0001d417          	auipc	s0,0x1d
    802096ea:	72240413          	addi	s0,s0,1826 # 80226e08 <_ZN6VirtIO4diskE>
        *REG(VIRTIO_MMIO_INTERRUPT_ACK) = status & 0x3;

        volatile struct VRingUsed *used_ring = (volatile struct VRingUsed *)disk.used;
    802096ee:	6804                	ld	s1,16(s0)
        *REG(VIRTIO_MMIO_INTERRUPT_ACK) = status & 0x3;
    802096f0:	8b0d                	andi	a4,a4,3

        while (disk.used_idx != used_ring->idx)
    802096f2:	04045783          	lhu	a5,64(s0)
        *REG(VIRTIO_MMIO_INTERRUPT_ACK) = status & 0x3;
    802096f6:	d2f8                	sw	a4,100(a3)
        while (disk.used_idx != used_ring->idx)
    802096f8:	0024d703          	lhu	a4,2(s1)
    802096fc:	00e79e63          	bne	a5,a4,80209718 <_ZN6VirtIO4intrEv+0x50>
    80209700:	a889                	j	80209752 <_ZN6VirtIO4intrEv+0x8a>
            if (disk.info[id].busy)
            {
                disk.info[id].busy = 0;
                ProcManager::wakeup(&disk.info[id]);
            }
            disk.used_idx++;
    80209702:	04045783          	lhu	a5,64(s0)
    80209706:	2785                	addiw	a5,a5,1
    80209708:	17c2                	slli	a5,a5,0x30
    8020970a:	93c1                	srli	a5,a5,0x30
    8020970c:	04f41023          	sh	a5,64(s0)
        while (disk.used_idx != used_ring->idx)
    80209710:	0024d703          	lhu	a4,2(s1)
    80209714:	02e78f63          	beq	a5,a4,80209752 <_ZN6VirtIO4intrEv+0x8a>
            int id = used_ring->ring[disk.used_idx % NUM_DESCS].id;
    80209718:	8b9d                	andi	a5,a5,7
    8020971a:	078e                	slli	a5,a5,0x3
    8020971c:	97a6                	add	a5,a5,s1
    8020971e:	43c8                	lw	a0,4(a5)
            if (disk.info[id].busy)
    80209720:	00850793          	addi	a5,a0,8
    80209724:	078e                	slli	a5,a5,0x3
    80209726:	97a2                	add	a5,a5,s0
    80209728:	43d8                	lw	a4,4(a5)
    8020972a:	df61                	beqz	a4,80209702 <_ZN6VirtIO4intrEv+0x3a>
                ProcManager::wakeup(&disk.info[id]);
    8020972c:	050e                	slli	a0,a0,0x3
    8020972e:	04450513          	addi	a0,a0,68
    80209732:	9522                	add	a0,a0,s0
                disk.info[id].busy = 0;
    80209734:	0007a223          	sw	zero,4(a5)
                ProcManager::wakeup(&disk.info[id]);
    80209738:	913fe0ef          	jal	8020804a <_ZN11ProcManager6wakeupEPv>
            disk.used_idx++;
    8020973c:	04045783          	lhu	a5,64(s0)
    80209740:	2785                	addiw	a5,a5,1
    80209742:	17c2                	slli	a5,a5,0x30
    80209744:	93c1                	srli	a5,a5,0x30
    80209746:	04f41023          	sh	a5,64(s0)
        while (disk.used_idx != used_ring->idx)
    8020974a:	0024d703          	lhu	a4,2(s1)
    8020974e:	fce795e3          	bne	a5,a4,80209718 <_ZN6VirtIO4intrEv+0x50>
        }

        disk.lock.release();
    }
    80209752:	6442                	ld	s0,16(sp)
    80209754:	60e2                	ld	ra,24(sp)
    80209756:	64a2                	ld	s1,8(sp)
        disk.lock.release();
    80209758:	0001d517          	auipc	a0,0x1d
    8020975c:	7c050513          	addi	a0,a0,1984 # 80226f18 <_ZN6VirtIO4diskE+0x110>
    }
    80209760:	6105                	addi	sp,sp,32
        disk.lock.release();
    80209762:	bb6fc06f          	j	80205b18 <_ZN8Spinlock7releaseEv>

0000000080209766 <_ZN6VirtIO7test_rwEv>:

    void test_rw()
    {
    80209766:	1141                	addi	sp,sp,-16
        Drivers::uart_puts(ANSI_BLUE "[VirtIO] Disk Test Start...\n" ANSI_RESET);
    80209768:	00009517          	auipc	a0,0x9
    8020976c:	c6050513          	addi	a0,a0,-928 # 802123c8 <initcode_end+0xc80>
    {
    80209770:	e406                	sd	ra,8(sp)
        Drivers::uart_puts(ANSI_BLUE "[VirtIO] Disk Test Start...\n" ANSI_RESET);
    80209772:	df8ff0ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>

        char *buf = (char *)PMM::alloc_page();
    80209776:	9edfd0ef          	jal	80207162 <_ZN3PMM10alloc_pageEv>
        if (!buf)
    8020977a:	c925                	beqz	a0,802097ea <_ZN6VirtIO7test_rwEv+0x84>
            return;

        const char *msg = "Lume OS Disk Driver Test Pattern";
        strcpy(buf, msg);
    8020977c:	00009597          	auipc	a1,0x9
    80209780:	c7458593          	addi	a1,a1,-908 # 802123f0 <initcode_end+0xca8>
    80209784:	e022                	sd	s0,0(sp)
    80209786:	842a                	mv	s0,a0
    80209788:	f4afb0ef          	jal	80204ed2 <_Z6strcpyPcPKc>

        rw(1, 0, buf); // Write
    8020978c:	8622                	mv	a2,s0
    8020978e:	4581                	li	a1,0
    80209790:	4505                	li	a0,1
    80209792:	d71ff0ef          	jal	80209502 <_ZN6VirtIO2rwEiyPc>
        memset(buf, 0, PGSIZE);
    80209796:	6605                	lui	a2,0x1
    80209798:	4581                	li	a1,0
    8020979a:	8522                	mv	a0,s0
    8020979c:	e8efb0ef          	jal	80204e2a <_Z6memsetPvij>
        rw(0, 0, buf); // Read
    802097a0:	4581                	li	a1,0
    802097a2:	4501                	li	a0,0
    802097a4:	8622                	mv	a2,s0
    802097a6:	d5dff0ef          	jal	80209502 <_ZN6VirtIO2rwEiyPc>

        if (strcmp(buf, msg) == 0)
    802097aa:	00009597          	auipc	a1,0x9
    802097ae:	c4658593          	addi	a1,a1,-954 # 802123f0 <initcode_end+0xca8>
    802097b2:	8522                	mv	a0,s0
    802097b4:	f58fb0ef          	jal	80204f0c <_Z6strcmpPKcS0_>
    802097b8:	cd09                	beqz	a0,802097d2 <_ZN6VirtIO7test_rwEv+0x6c>
        {
            Drivers::uart_puts(ANSI_GREEN "[VirtIO] Test PASSED (R/W Verified).\n" ANSI_RESET);
        }
        else
        {
            Drivers::uart_puts(ANSI_RED "[VirtIO] Test FAILED.\n" ANSI_RESET);
    802097ba:	00009517          	auipc	a0,0x9
    802097be:	c8e50513          	addi	a0,a0,-882 # 80212448 <initcode_end+0xd00>
    802097c2:	da8ff0ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        }

        PMM::free_page(buf);
    802097c6:	8522                	mv	a0,s0
    802097c8:	6402                	ld	s0,0(sp)
    }
    802097ca:	60a2                	ld	ra,8(sp)
    802097cc:	0141                	addi	sp,sp,16
        PMM::free_page(buf);
    802097ce:	9b7fd06f          	j	80207184 <_ZN3PMM9free_pageEPv>
            Drivers::uart_puts(ANSI_GREEN "[VirtIO] Test PASSED (R/W Verified).\n" ANSI_RESET);
    802097d2:	00009517          	auipc	a0,0x9
    802097d6:	c4650513          	addi	a0,a0,-954 # 80212418 <initcode_end+0xcd0>
    802097da:	d90ff0ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        PMM::free_page(buf);
    802097de:	8522                	mv	a0,s0
    802097e0:	6402                	ld	s0,0(sp)
    }
    802097e2:	60a2                	ld	ra,8(sp)
    802097e4:	0141                	addi	sp,sp,16
        PMM::free_page(buf);
    802097e6:	99ffd06f          	j	80207184 <_ZN3PMM9free_pageEPv>
    }
    802097ea:	60a2                	ld	ra,8(sp)
    802097ec:	0141                	addi	sp,sp,16
    802097ee:	8082                	ret

00000000802097f0 <_ZN6VirtIO8test_bioEv>:

    void test_bio()
    {
    802097f0:	1141                	addi	sp,sp,-16
        Drivers::uart_puts(ANSI_BLUE "[Bio] Starting Buffer Cache Test...\n" ANSI_RESET);
    802097f2:	00009517          	auipc	a0,0x9
    802097f6:	c7650513          	addi	a0,a0,-906 # 80212468 <initcode_end+0xd20>
    {
    802097fa:	e406                	sd	ra,8(sp)
    802097fc:	e022                	sd	s0,0(sp)
        Drivers::uart_puts(ANSI_BLUE "[Bio] Starting Buffer Cache Test...\n" ANSI_RESET);
    802097fe:	d6cff0ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>

        struct Buf *b = BufferCache::bread(0, 100);
    80209802:	06400593          	li	a1,100
    80209806:	4501                	li	a0,0
    80209808:	cb9fe0ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
    8020980c:	842a                	mv	s0,a0

        Drivers::uart_puts("[Bio] Bread block 100 (1st time).\n");
    8020980e:	00009517          	auipc	a0,0x9
    80209812:	c8a50513          	addi	a0,a0,-886 # 80212498 <initcode_end+0xd50>
    80209816:	d54ff0ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>

        b->data[0] = 'L';
    8020981a:	656d77b7          	lui	a5,0x656d7
    8020981e:	54c78793          	addi	a5,a5,1356 # 656d754c <_start-0x1ab28ab4>
    80209822:	d41c                	sw	a5,40(s0)
        b->data[1] = 'u';
        b->data[2] = 'm';
        b->data[3] = 'e';
        b->data[4] = '\0';

        BufferCache::bwrite(b);
    80209824:	8522                	mv	a0,s0
        b->data[4] = '\0';
    80209826:	02040623          	sb	zero,44(s0)
        BufferCache::bwrite(b);
    8020982a:	d79fe0ef          	jal	802085a2 <_ZN11BufferCache6bwriteEP3Buf>
        Drivers::uart_puts("[Bio] Bwrite block 100.\n");
    8020982e:	00009517          	auipc	a0,0x9
    80209832:	c9250513          	addi	a0,a0,-878 # 802124c0 <initcode_end+0xd78>
    80209836:	d34ff0ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>

        BufferCache::brelse(b);
    8020983a:	8522                	mv	a0,s0
    8020983c:	d9bfe0ef          	jal	802085d6 <_ZN11BufferCache6brelseEP3Buf>
        Drivers::uart_puts("[Bio] Brelease block 100.\n");
    80209840:	00009517          	auipc	a0,0x9
    80209844:	ca050513          	addi	a0,a0,-864 # 802124e0 <initcode_end+0xd98>
    80209848:	d22ff0ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>

        struct Buf *b2 = BufferCache::bread(0, 100);
    8020984c:	06400593          	li	a1,100
    80209850:	4501                	li	a0,0
    80209852:	c6ffe0ef          	jal	802084c0 <_ZN11BufferCache5breadEjj>
    80209856:	842a                	mv	s0,a0
        Drivers::uart_puts("[Bio] Bread block 100 (2nd time).\n");
    80209858:	00009517          	auipc	a0,0x9
    8020985c:	ca850513          	addi	a0,a0,-856 # 80212500 <initcode_end+0xdb8>
    80209860:	d0aff0ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>

        if (b2->data[0] == 'L' && b2->data[1] == 'u' && b2->data[3] == 'e')
    80209864:	7414                	ld	a3,40(s0)
    80209866:	0ff017b7          	lui	a5,0xff01
    8020986a:	0792                	slli	a5,a5,0x4
    8020986c:	17fd                	addi	a5,a5,-1 # ff00fff <_start-0x702ff001>
    8020986e:	65007737          	lui	a4,0x65007
    80209872:	8ff5                	and	a5,a5,a3
    80209874:	54c70713          	addi	a4,a4,1356 # 6500754c <_start-0x1b1f8ab4>
    80209878:	00e78e63          	beq	a5,a4,80209894 <_ZN6VirtIO8test_bioEv+0xa4>
        {
            Drivers::uart_puts(ANSI_GREEN "[Bio] Data verification PASSED.\n" ANSI_RESET);
        }
        else
        {
            Drivers::uart_puts(ANSI_RED "[Bio] Data verification FAILED.\n" ANSI_RESET);
    8020987c:	00009517          	auipc	a0,0x9
    80209880:	cdc50513          	addi	a0,a0,-804 # 80212558 <initcode_end+0xe10>
    80209884:	ce6ff0ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        }

        BufferCache::brelse(b2);
    80209888:	8522                	mv	a0,s0
    }
    8020988a:	6402                	ld	s0,0(sp)
    8020988c:	60a2                	ld	ra,8(sp)
    8020988e:	0141                	addi	sp,sp,16
        BufferCache::brelse(b2);
    80209890:	d47fe06f          	j	802085d6 <_ZN11BufferCache6brelseEP3Buf>
            Drivers::uart_puts(ANSI_GREEN "[Bio] Data verification PASSED.\n" ANSI_RESET);
    80209894:	00009517          	auipc	a0,0x9
    80209898:	c9450513          	addi	a0,a0,-876 # 80212528 <initcode_end+0xde0>
    8020989c:	cceff0ef          	jal	80208d6a <_ZN7Drivers9uart_putsEPKc>
        BufferCache::brelse(b2);
    802098a0:	8522                	mv	a0,s0
    }
    802098a2:	6402                	ld	s0,0(sp)
    802098a4:	60a2                	ld	ra,8(sp)
    802098a6:	0141                	addi	sp,sp,16
        BufferCache::brelse(b2);
    802098a8:	d2ffe06f          	j	802085d6 <_ZN11BufferCache6brelseEP3Buf>

00000000802098ac <_GLOBAL__sub_I__ZN6VirtIO4diskE>:
    802098ac:	0001d797          	auipc	a5,0x1d
    802098b0:	55c78793          	addi	a5,a5,1372 # 80226e08 <_ZN6VirtIO4diskE>
    802098b4:	00008717          	auipc	a4,0x8
    802098b8:	ed470713          	addi	a4,a4,-300 # 80211788 <initcode_end+0x40>
    802098bc:	1007a823          	sw	zero,272(a5)
    802098c0:	10e7bc23          	sd	a4,280(a5)
    802098c4:	1207b023          	sd	zero,288(a5)
    802098c8:	8082                	ret

00000000802098ca <_ZN4PLIC4initEv>:
{
    void init()
    {
        // Set Priority for UART (IRQ 10) and VirtIO (IRQ 1)
        // Must use volatile write
        *REG32(PLIC_PRIORITY + 10 * 4) = 1;
    802098ca:	4785                	li	a5,1
    802098cc:	0c000e37          	lui	t3,0xc000
    802098d0:	02fe2423          	sw	a5,40(t3) # c000028 <_start-0x741fffd8>
        for (int i = 1; i <= 8; i++)
        {
            *REG32(PLIC_PRIORITY + i * 4) = 1;
    802098d4:	0c000337          	lui	t1,0xc000
    802098d8:	00f32223          	sw	a5,4(t1) # c000004 <_start-0x741ffffc>
    802098dc:	0c0008b7          	lui	a7,0xc000
    802098e0:	00f8a423          	sw	a5,8(a7) # c000008 <_start-0x741ffff8>
    802098e4:	0c000837          	lui	a6,0xc000
    802098e8:	00f82623          	sw	a5,12(a6) # c00000c <_start-0x741ffff4>
    802098ec:	0c000537          	lui	a0,0xc000
    802098f0:	c91c                	sw	a5,16(a0)
    802098f2:	0c0005b7          	lui	a1,0xc000
    802098f6:	c9dc                	sw	a5,20(a1)
    802098f8:	0c000637          	lui	a2,0xc000
    802098fc:	ce1c                	sw	a5,24(a2)
    802098fe:	0c0006b7          	lui	a3,0xc000
    80209902:	0c000737          	lui	a4,0xc000
    80209906:	cedc                	sw	a5,28(a3)
    80209908:	d31c                	sw	a5,32(a4)
        }
    }
    8020990a:	8082                	ret

000000008020990c <_ZN4PLIC8inithartEv>:
  asm volatile("mv %0, tp" : "=r" (x) );
    8020990c:	8792                	mv	a5,tp
    void inithart()
    {
        int hart = static_cast<int>(r_tp());

        // Enable UART(10) and VirtIO(1) for this Hart (S-Mode)
        *REG32(PLIC_SENABLE_ADDR(hart)) = (1 << 10) | 0x1FE;
    8020990e:	0c0026b7          	lui	a3,0xc002
    80209912:	0087971b          	slliw	a4,a5,0x8
    80209916:	08068693          	addi	a3,a3,128 # c002080 <_start-0x741fdf80>
    8020991a:	9736                	add	a4,a4,a3
    8020991c:	5fe00693          	li	a3,1534
    80209920:	c314                	sw	a3,0(a4)

        // Set Priority Threshold to 0 (Allow all)
        *REG32(PLIC_STHRESHOLD_ADDR(hart)) = 0;
    80209922:	00d7979b          	slliw	a5,a5,0xd
    80209926:	0c201737          	lui	a4,0xc201
    8020992a:	97ba                	add	a5,a5,a4
    8020992c:	0007a023          	sw	zero,0(a5)

        Drivers::uart_puts("[PLIC] Hart Init Done.\n");
    80209930:	00009517          	auipc	a0,0x9
    80209934:	c5850513          	addi	a0,a0,-936 # 80212588 <initcode_end+0xe40>
    80209938:	c32ff06f          	j	80208d6a <_ZN7Drivers9uart_putsEPKc>

000000008020993c <_ZN4PLIC5claimEv>:
    8020993c:	8792                	mv	a5,tp
    }

    int claim()
    {
        int hart = static_cast<int>(r_tp());
        return *REG32(PLIC_SCLAIM_ADDR(hart));
    8020993e:	0c201737          	lui	a4,0xc201
    80209942:	0711                	addi	a4,a4,4 # c201004 <_start-0x73ffeffc>
    80209944:	00d7979b          	slliw	a5,a5,0xd
    80209948:	97ba                	add	a5,a5,a4
    8020994a:	4388                	lw	a0,0(a5)
    }
    8020994c:	8082                	ret

000000008020994e <_ZN4PLIC8completeEi>:
    8020994e:	8792                	mv	a5,tp

    void complete(int irq)
    {
        int hart = static_cast<int>(r_tp());
        *REG32(PLIC_SCLAIM_ADDR(hart)) = static_cast<uint32>(irq);
    80209950:	0c201737          	lui	a4,0xc201
    80209954:	00d7979b          	slliw	a5,a5,0xd
    80209958:	0711                	addi	a4,a4,4 # c201004 <_start-0x73ffeffc>
    8020995a:	2501                	sext.w	a0,a0
    8020995c:	97ba                	add	a5,a5,a4
    8020995e:	c388                	sw	a0,0(a5)
    }
    80209960:	8082                	ret
	...
