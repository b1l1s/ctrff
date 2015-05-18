@ ---------------------------------------------------------------------------
@.section	.itcm,"ax",%progbits

emmc_cmd = 0x10006000
emmc_cmdarg0 = 0x10006004
emmc_cmdarg1 = 0x10006006
emmc_stop = 0x10006008
emmc_blkcount = 0x1000600A
emmc_resp0 = 0x1000600C
emmc_status0 = 0x1000601C
emmc_status1 = 0x1000601E
emmc_unk20 = 0x10006020
emmc_unk22 = 0x10006022
emmc_clkctl = 0x10006024
emmc_blklen	= 0x10006026
emmc_opt = 0x10006028
emmc_fifo = 0x10006030
emmc_reset = 0x100060E0

.thumb

@ int __cdecl sdmmc_send_command(unsigned int *ctx, unsigned int cmd, unsigned int args)
.align 4
.thumb_func
.global sdmmc_send_command
sdmmc_send_command:
	push    {r0-r2,r4-r7,lr}
	mov     r5, #0
	str     r5, [r0,#8]
	ldr     r4, [r0,#4]
	mov     r5, #0x80
	ldr     r3, [r0]
	ldr     r7, =emmc_cmd
	lsl     r5, r5, #7
loc_80A3700:
	ldrh    r6, [r7, #0x1E]
	and     r6, r5
	bne     loc_80A3700
	ldr     r5, =emmc_cmd
	strh    r6, [r7, #0x20]
	strh    r6, [r7, #0x22]
	strh    r6, [r7, #0x1C]
	strh    r6, [r7, #0x1E]
	ldr     r6, =0x10006100
	ldr     r7, =0xFFFFE7FF
	ldrh    r5, [r6]
	and     r7, r5
	strh    r7, [r6]
	lsl     r6, r2, #0x10
	ldr     r7, =emmc_cmd
	lsr     r6, r6, #0x10
	strh    r6, [r7, #4]
	lsr     r2, r2, #0x10
	strh    r2, [r7,#6]
	lsl     r2, r1, #0x10
	lsr     r2, r2, #0x10
	strh    r2, [r7]
	mov     r5, #0xC0
	lsl     r6, r1, #0xF
	lsr     r6, r6, #0x1F
	mov     r7, #4
	lsl     r5, r5, #0xB
	orr     r7, r6
	mov     r2, r6
	tst     r1, r5
	beq     loc_80A374A
	add     r2, r7, #0
loc_80A374A:
	lsl     r2, r2, #0x10
	lsr     r2, r2, #0x10
	mov     r12, r2
	@MOV     r2, 0x20000
	mov     r2, #0x80
	lsl     r2, r2, #0xA
	and     r2, r1
	str     r2, [sp]
	@MOV     r2, 0x40000
	mov     r2, #0x80
	lsl     r2, r2, #0xB
	and     r1, r2
	str     r1, [sp,#4]
loc_80A3760:
	ldr     r7, =emmc_status1
	ldrh    r2, [r7]
	lsl     r1, r2, #0x17
	bpl     loc_80A3792
	ldr     r5, [sp]
	cmp     r5, #0
	beq     loc_80A3792
	cmp     r3, #0
	beq     loc_80A3792
	ldr     r5, =0xFFFFFEFF
	ldr     r1, =0x1FF
	strh    r5, [r7]
	cmp     r4, r1
	bls     loc_80A3792
	@MOV     r7, 0x200
	mov     r7, #0x80
	lsl     r7, r7, #2
	add     r1, r3, r7
	ldr     r7, =emmc_fifo
loc_80A3784:
	ldrh    r5, [r7]
	strh    r5, [r3]
	add     r3, #2
	cmp     r3, r1
	bne     loc_80A3784
	ldr     r1, =0xFFFFFE00
	add     r4, r4, r1
loc_80A3792:
	lsl     r5, r2, #0x16
	bpl     loc_80A37C2
	ldr     r7, [sp,#4]
	cmp     r7, #0
	beq     loc_80A37C2
	cmp     r3, #0
	beq     loc_80A37C2
	ldr     r1, =0xFFFFFDFF
	ldr     r5, =emmc_status1
	strh    r1, [r5]
	ldr     r1, =0x1FF
	cmp     r4, r1
	bls     loc_80A37C2
	@MOV     r7, 0x200
	mov     r7, #0x80
	lsl     r7, r7, #2
	ldr     r5, =emmc_fifo
	add     r1, r3, r7
loc_80A37B4:
	ldrh    r7, [r3]
	add     r3, #2
	strh    r7, [r5]
	cmp     r3, r1
	bne     loc_80A37B4
	ldr     r1, =0xFFFFFE00
	add     r4, r4, r1
loc_80A37C2:
	ldr     r1, =0xFFFF807F
	tst     r2, r1
	beq     loc_80A37D2
	ldr     r2, [r0,#8]
	mov     r3, #4
	orr     r3, r2
	str     r3, [r0,#8]
	b       loc_80A37FA
loc_80A37D2:
	ldr     r5, =emmc_status0
	ldrh    r1, [r5]
	lsl     r7, r2, #0x11
	bmi     loc_80A3760
	mov     r2, #1
	tst     r1, r2
	beq     loc_80A37E6
	ldr     r5, [r0,#8]
	orr     r2, r5
	str     r2, [r0,#8]
loc_80A37E6:
	lsl     r7, r1, #0x1D
	bpl     loc_80A37F2
	ldr     r5, [r0,#8]
	mov     r2, #2
	orr     r2, r5
	str     r2, [r0,#8]
loc_80A37F2:
	mov     r7, r12
	and     r1, r7
	cmp     r1, r12
	bne     loc_80A3760
loc_80A37FA:
	ldr     r1, =emmc_status0
	mov     r3, #0
	strh    r3, [r1]
	strh    r3, [r1,#2]
	cmp     r6, r3
	beq     locret_80A3840
	ldr     r5, =emmc_cmd
	ldrh    r2, [r5,#0x0C]
	ldrh    r3, [r5,#0x0E]
	lsl     r3, r3, #0x10
	orr     r3, r2
	str     r3, [r0,#0xC]
	ldrh    r2, [r5,#0x10]
	ldrh    r3, [r5,#0x12]
	lsl     r3, r3, #0x10
	orr     r3, r2
	str     r3, [r0,#0x10]
	ldrh    r2, [r5,#0x14]
	ldrh    r3, [r5,#0x16]
	lsl     r3, r3, #0x10
	orr     r3, r2
	str     r3, [r0,#0x14]
	ldrh    r2, [r5,#0x18]
	ldrh    r3, [r5,#0x1A]
	lsl     r3, r3, #0x10
	orr     r3, r2
	str     r3, [r0,#0x18]
locret_80A3840:
	pop     {r0-r2,r4-r7,pc}
.pool

.align 4
sub_80A38A0:
	ldr     r3, =emmc_clkctl
	ldr     r2, =0xFFFFFEFF
	ldrh    r1, [r3]
	and     r2, r1
	strh    r2, [r3]
	ldrh    r1, [r3]
	ldr     r2, =0xFFFFFD00
	and     r2, r1
	ldr     r1, =0x2FF
	and     r0, r1
	orr     r0, r2
	strh    r0, [r3]
	ldrh    r1, [r3]
	mov     r2, #0x80
	lsl     r2, r2, #1
	orr     r2, r1
	strh    r2, [r3]
	bx      lr
.pool

.align 4
.thumb_func
sub_80A38D4:
	push    {r4,lr}
	ldr     r3, =0x10006002
	mov     r1, #3
	ldrh    r2, [r3]
	add     r4, r0, #0
	bic     r2, r1
	ldrh    r1, [r0,#0x2C]
	orr     r2, r1
	strh    r2, [r3]
	ldr     r0, [r0,#0x24]
	bl      sub_80A38A0
	ldr     r2, [r4,#0x28]
	ldr     r3, =emmc_opt
	cmp     r2, #0
	bne     loc_80A38FE
	ldrh    r1, [r3]
	mov     r2, #0x80
	lsl     r2, r2, #8
	orr     r2, r1
	b       loc_80A3904
loc_80A38FE:
	ldrh    r2, [r3]
	lsl     r2, r2, #0x11
	lsr     r2, r2, #0x11
loc_80A3904:
	strh    r2, [r3]
	pop     {r4,pc}
.pool

.align 4
delay:
	push    {r0-r2,lr}
	lsl     r0, r0, #2
	str     r0, [sp,#4]
loc_80A3916:
	ldr     r3, [sp,#4]
	sub     r2, r3, #1
	str     r2, [sp,#4]
	cmp     r3, #0
	bne     loc_80A3916
	pop     {r0-r2,pc}
.pool

.align 4
.thumb_func
.global InitSD
InitSD:
	push    {r3-r7,lr}
	ldr     r2, =dword_80A6F20
	mov     r3, #0
	ldr     r0, =dword_80A6F58
	mov     r1, #1
	mov     r4, #0x80
	str     r3, [r2,#0x20]
	str     r3, [r2,#0x28]
	str     r3, [r2,#0x34]
	strh    r1, [r2,#0x1C]
	str     r4, [r2,#0x24]
	str     r1, [r2,#0x2C]
	ldr     r2, =0x10006100
	str     r4, [r0,#0x24]
	strh    r3, [r0,#0x1C]
	str     r3, [r0,#0x20]	@ is_not_sdhc
	str     r3, [r0,#0x28]
	str     r3, [r0,#0x2C]
	str     r3, [r0,#0x34]
	ldrh    r5, [r2]
	ldr     r4, =0xFFFFF7FF
	mov     r6, #2
	and     r4, r5
	strh    r4, [r2]
	ldrh    r5, [r2]
	ldr     r4, =0xFFFFEFFF
	and     r4, r5
	strh    r4, [r2]
	ldrh    r4, [r2]
	ldr     r5, =0x402
	orr     r4, r5
	strh    r4, [r2]
	ldr     r4, =0x100060D8
	mov     r5, #0x22
	ldrh    r7, [r4]
	bic     r7, r5
	orr     r7, r6
	strh    r7, [r4]
	ldrh    r7, [r2]
	bic     r7, r6
	strh    r7, [r2]
	ldrh    r2, [r4]
	bic     r2, r5
	strh    r2, [r4]
	ldr     r2, =0x10006104
	ldr     r5, =emmc_clkctl
	strh    r3, [r2]
	ldr     r2, =0x10006108
	strh    r1, [r2]
	ldr     r2, =emmc_reset
	ldrh    r4, [r2]
	bic     r4, r1
	strh    r4, [r2]
	ldrh    r4, [r2]
	orr     r1, r4
	strh    r1, [r2]
	ldr     r2, =emmc_unk20
	ldr     r4, =0x31D
	ldrh    r1, [r2]
	orr     r1, r4
	strh    r1, [r2]
	ldr     r2, =emmc_unk22
	ldr     r1, =0x837F
	ldrh    r4, [r2]
	orr     r1, r4
	strh    r1, [r2]
	ldr     r2, =0x100060FC
	mov     r1, #0xDB
	ldrh    r4, [r2]
	orr     r4, r1
	strh    r4, [r2]
	ldr     r2, =0x100060FE
	ldrh    r4, [r2]
	orr     r1, r4
	strh    r1, [r2]
	mov     r2, #0x20
	strh    r2, [r5]
	ldr     r4, =emmc_opt
	ldr     r2, =0x40EE
	mov     r1, #3
	strh    r2, [r4]
	ldr     r2, =0x10006002
	ldrh    r6, [r2]
	bic     r6, r1
	strh    r6, [r2]
	mov     r6, #0x40
	strh    r6, [r5]
	ldr     r5, =0x40EB
	strh    r5, [r4]
	ldrh    r4, [r2]
	bic     r4, r1
	strh    r4, [r2]
	mov     r1, #0x80
	ldr     r2, =emmc_blklen
	lsl     r1, r1, #2
	strh    r1, [r2]
	ldr     r2, =emmc_stop
	strh    r3, [r2]
	bl      sub_80A38D4
	pop     {r3-r7,pc}
.pool

.align 4
sub_80A3A4C:
	ldr     r0, [r0,#8]
	lsl     r0, r0, #0x1D
	asr     r0, r0, #0x1F
	bx      lr
.pool

.align 4
sub_80A3A54:
	push    {r4-r6,lr}
	add     r4, r0, #0
	ldrb    r3, [r0,#0xE]
	add     r2, r1, #1
	bne     loc_80A3A60
	lsr     r1, r3, #6
loc_80A3A60:
	cmp     r1, #0
	bne     loc_80A3AB0
	ldrb    r6, [r4,#7]
	ldrb    r0, [r4,#8]
	lsl     r6, r6, #2
	lsl     r0, r0, #0xA
	orr     r0, r6
	ldrb    r6, [r4,#6]
	ldrb    r2, [r4,#9]
	lsr     r6, r6, #6
	mov     r5, #1
	mov     r3, #0xF
	orr     r0, r6
	and     r2, r3
	lsl     r0, r0, #0x14
	add     r3, r5, #0
	lsl     r3, r2
	lsr     r0, r0, #0x14
	add     r2, r3, #0
	add     r0, r0, r5
	asr     r3, r3, #0x1F
	bl      sub_80A6754
	ldrb    r2, [r4,#4]
	ldrb    r3, [r4,#5]
	lsr     r2, r2, #7
	lsl     r3, r5
	orr     r2, r3
	mov     r3, #7
	and     r2, r3
	add     r2, #2
	lsl     r5, r2
	add     r2, r5, #0
	asr     r3, r5, #0x1F
	bl      sub_80A6754
	lsl     r1, r1, #0x17
	lsr     r0, r0, #9
	orr     r0, r1
	b       locret_80A3ACC
loc_80A3AB0:
	mov     r0, #0
	cmp     r1, #1
	bne     locret_80A3ACC
	ldrb    r0, [r4,#6]
	ldrb    r3, [r4,#5]
	lsl     r0, r0, #8
	ldrb    r2, [r4,#7]
	orr     r0, r3
	mov     r3, #0x3F
	and     r3, r2
	lsl     r3, r3, #0x10
	orr     r0, r3
	add     r0, #1
	lsl     r0, r0, #0xA
locret_80A3ACC:
	pop     {r4-r6,pc}
.pool

.align 4
.thumb_func
.global SD_Init
SD_Init:
	push    {r4-r6,lr}
	ldr     r4, =dword_80A6F58
	add     r0, r4, #0
	bl      sub_80A38D4
	mov     r0, #0xF0		@ MOV     r0, #0xFA original
	lsl     r0, r0, #8		@ LSL     r0, r0, #2
	bl      delay			@ delay
	mov     r1, #0          @ cmd
	add     r2, r1, #0      @ args
	add     r0, r4, #0      @ ctx
	bl      sdmmc_send_command
	mov     r2, #0xD5
	add     r0, r4, #0      @ ctx
	ldr     r1, =0x10408    @ cmd
	lsl     r2, r2, #1
	bl      sdmmc_send_command
	ldr     r5, [r4,#8]
	mov     r3, #1
	and     r5, r3
	lsl     r5, r5, #0x1E
loc_80A3B00:
	ldr     r4, =dword_80A6F58
	ldr     r1, =0x10437    @ cmd
	ldrh    r2, [r4,#0x1C]
	add     r0, r4, #0      @ ctx
	lsl     r2, r2, #0x10
	bl      sdmmc_send_command
	ldr     r2, =0xFF8000
	add     r0, r4, #0      @ ctx
	orr     r2, r5          @ args
	ldr     r1, =0x10769    @ cmd
	bl      sdmmc_send_command
	ldr     r2, [r4,#8]
	mov     r3, #1
	tst     r2, r3
	beq     loc_80A3B00
	ldr     r2, [r4,#0xC]
	cmp     r2, #0
	bge     loc_80A3B00
	lsr     r2, r2, #0x1E
	tst     r2, r3
	beq     loc_80A3B34
	cmp     r5, #0
	beq     loc_80A3B34
	b       loc_80A3B36
loc_80A3B34:
	mov     r3, #0
loc_80A3B36:
	mov     r2, #0          @ args
	add     r0, r4, #0      @ ctx
	ldr     r1, =0x10602    @ cmd
	str     r3, [r4,#0x20]	@ is_not_sdhc
	bl      sdmmc_send_command
	ldr     r2, [r4,#8]
	mov     r5, #4
	and     r2, r5
	beq     loc_80A3B50
loc_80A3B4A:
	mov     r0, #1
	neg     r0, r0
	b       locret_80A3BEE
loc_80A3B50:
	add     r0, r4, #0      @ ctx
	ldr     r1, =0x10403    @ cmd
	bl      sdmmc_send_command
	ldr     r3, [r4,#8]
	tst     r3, r5
	bne     loc_80A3B4A
	ldrh    r2, [r4,#0xE]
	add     r0, r4, #0      @ ctx
	strh    r2, [r4,#0x1C]
	ldr     r1, =0x10609    @ cmd
	lsl     r2, r2, #0x10
	bl      sdmmc_send_command
	ldr     r2, [r4,#8]
	tst     r2, r5
	bne     loc_80A3B4A
	add     r0, r4, #0
	mov     r1, #1
	neg     r1, r1
	add     r0, #0xC
	bl      sub_80A3A54
	mov     r6, #1
	str     r0, [r4,#0x30]
	add     r0, r6, #0
	str     r6, [r4,#0x24]
	bl      sub_80A38A0
	ldrh    r2, [r4,#0x1C]
	add     r0, r4, #0      @ ctx
	lsl     r2, r2, #0x10
	ldr     r1, =0x10507    @ cmd
	bl      sdmmc_send_command
	ldr     r3, [r4,#8]
	tst     r3, r5
	bne     loc_80A3B4A
	ldrh    r2, [r4,#0x1C]
	add     r0, r4, #0      @ ctx
	lsl     r2, r2, #0x10
	ldr     r1, =0x10437    @ cmd
	bl      sdmmc_send_command
	ldr     r2, [r4,#8]
	tst     r2, r5
	bne     loc_80A3B4A
	add     r0, r4, #0      @ ctx
	ldr     r1, =0x10446    @ cmd
	mov     r2, #2          @ args
	str     r6, [r4,#0x28]
	bl      sdmmc_send_command
	ldr     r3, [r4,#8]
	tst     r3, r5
	bne     loc_80A3B4A
	ldrh    r2, [r4,#0x1C]
	add     r0, r4, #0      @ ctx
	lsl     r2, r2, #0x10
	ldr     r1, =0x1040D    @ cmd
	bl      sdmmc_send_command
	ldr     r2, [r4,#8]
	tst     r2, r5
	bne     loc_80A3B4A
	mov     r6, #0x80
	lsl     r6, r6, #2
	add     r0, r4, #0      @ ctx
	ldr     r1, =0x10410    @ cmd
	add     r2, r6, #0      @ args
	bl      sdmmc_send_command
	ldr     r3, [r4,#8]
	and     r5, r3
	bne     loc_80A3B4A
	ldr     r2, [r4,#0x24]
	add     r0, r5, #0
	orr     r6, r2
	str     r6, [r4,#0x24]
locret_80A3BEE:
	pop     {r4-r6,pc}
.pool

.align 4
.thumb_func
.global sdmmc_sdcard_sectorcount
sdmmc_sdcard_sectorcount:
	ldr     r3, =dword_80A6F58
	ldr     r0, [r3,#0x30]
	bx      lr
.pool

.align 4
.thumb_func
.global sdmmc_sdcard_readsector
sdmmc_sdcard_readsector:
	push    {r4-r6,lr}
	ldr     r4, =dword_80A6F58
	add     r5, r0, #0
	ldr     r3, [r4,#0x20]
	add     r6, r1, #0
	cmp     r3, #0
	bne     sdmmc_sdcard_readsector_
	lsl     r5, r0, #9		@SDMC works with raw addresses not sectors
sdmmc_sdcard_readsector_:
	bl      sub_80A38D4
	mov     r3, #0x80
	lsl     r3, r3, #2		@ 0x200
	add     r2, r5, #0      @ args
	add     r0, r4, #0      @ ctx
	ldr     r1, =0x31C11    @ cmd
	str     r6, [r4]
	str     r3, [r4,#4]
	bl      sdmmc_send_command
	add     r0, r4, #0
	bl      sub_80A3A4C
	pop     {r4-r6,pc}
.pool

.align 4
.thumb_func
.global sdmmc_sdcard_readsectors
sdmmc_sdcard_readsectors:
	push    {r3-r7,lr}
	ldr     r4, =dword_80A6F58
	add     r5, r0, #0
	ldr     r3, [r4,#0x20]
	add     r7, r2, #0
	add     r6, r1, #0
	cmp     r3, #0
	bne     loc_80A3C3E
	lsl     r5, r0, #9
loc_80A3C3E:
	add     r0, r4, #0
	bl      sub_80A38D4
	ldr     r3, =emmc_stop
	mov     r2, #0x80
	lsl     r2, r2, #1
	strh    r2, [r3]
	lsl     r3, r6, #0x10
	ldr     r2, =emmc_blkcount
	lsr     r3, r3, #0x10
	strh    r3, [r2]
	lsl     r6, r6, #9
	add     r2, r5, #0      @ args
	add     r0, r4, #0      @ ctx
	ldr     r1, =0x33C12    @ cmd
	str     r7, [r4]
	str     r6, [r4,#4]
	bl      sdmmc_send_command
	add     r0, r4, #0
	bl      sub_80A3A4C
	pop     {r3-r7,pc}
.pool

.align 4
.thumb_func
.global sdmmc_sdcard_writesector
sdmmc_sdcard_writesector:
	push    {r4-r6,lr}
	ldr     r4, =dword_80A6F58
	add     r5, r0, #0
	ldr     r3, [r4,#0x20]
	add     r6, r1, #0
	cmp     r3, #0
	bne     sdmmc_sdcard_writesector_
	lsl     r5, r0, #9		@SDMC works with raw addresses not sectors
loc_80A3C8E_:
	ldr     r3, [r4,#0x2C]
	cmp     r3, #0
	beq     sdmmc_sdcard_writesector_
loc_80A3C94_:
	b       loc_80A3C94_
sdmmc_sdcard_writesector_:
	bl      sub_80A38D4
	mov     r3, #0x80
	lsl     r3, r3, #2		@ 0x200
	add     r2, r5, #0      @ args
	add     r0, r4, #0      @ ctx
	ldr     r1, =0x50C18    @ cmd
	str     r6, [r4]
	str     r3, [r4,#4]
	bl      sdmmc_send_command
	add     r0, r4, #0
	bl      sub_80A3A4C
	pop     {r4-r6,pc}
.pool

.align 4
.thumb_func
.global sdmmc_sdcard_writesectors
sdmmc_sdcard_writesectors:
	push    {r3-r7,lr}
	ldr     r4, =dword_80A6F58
	add     r5, r0, #0
	ldr     r3, [r4,#0x20]
	add     r7, r2, #0
	add     r6, r1, #0
	cmp     r3, #0
	bne     loc_80A3C8E
	lsl     r5, r0, #9
loc_80A3C8E:
	ldr     r3, [r4,#0x2C]
	cmp     r3, #0
	beq     loc_80A3C96
loc_80A3C94:
	b       loc_80A3C94
loc_80A3C96:
	add     r0, r4, #0
	bl      sub_80A38D4
	ldr     r3, =emmc_stop
	mov     r2, #0x80
	lsl     r2, r2, #1
	strh    r2, [r3]
	lsl     r3, r6, #0x10
	ldr     r2, =emmc_blkcount
	lsr     r3, r3, #0x10
	strh    r3, [r2]
	lsl     r6, r6, #9
	add     r2, r5, #0      @ args
	add     r0, r4, #0      @ ctx
	ldr     r1, =0x52C19    @ cmd
	str     r7, [r4]
	str     r6, [r4,#4]
	bl      sdmmc_send_command
	add     r0, r4, #0
	bl      sub_80A3A4C
	pop     {r3-r7,pc}
.pool

.align 4
.thumb_func
.global Nand_Init
Nand_Init:
	push    {r4-r6,lr}
	ldr     r4, =dword_80A6F20
	add     r0, r4, #0
	bl      sub_80A38D4
	mov     r0, #0xF0		@ MOV     r0, #0xFA
	lsl     r0, r0, #8		@ LSL     r0, r0, #2
	bl      delay
	mov     r1, #0          @ cmd
	add     r0, r4, #0      @ ctx
	add     r2, r1, #0      @ args
	bl      sdmmc_send_command
loc_80A3CF0:
	ldr     r4, =dword_80A6F20
	mov     r2, #0x80
	ldr     r1, =0x10701    @ cmd
	add     r0, r4, #0      @ ctx
	lsl     r2, r2, #0xD
	bl      sdmmc_send_command
	ldr     r1, [r4,#8]
	mov     r6, #1
	tst     r1, r6
	beq     loc_80A3CF0
	ldr     r2, [r4,#0xC]
	cmp     r2, #0
	bge     loc_80A3CF0
	add     r0, r4, #0      @ ctx
	ldr     r1, =0x10602    @ cmd
	mov     r2, #0          @ args
	bl      sdmmc_send_command
	ldr     r3, [r4,#8]
	mov     r5, #4
	tst     r3, r5
	beq     loc_80A3D24
loc_80A3D1E:
	mov     r0, #1
	neg     r0, r0
	b       locret_80A3DC6
loc_80A3D24:
	ldrh    r2, [r4,#0x1C]
	ldr     r1, =0x10403    @ cmd
	lsl     r2, r2, #0x10
	add     r0, r4, #0      @ ctx
	bl      sdmmc_send_command
	ldr     r1, [r4,#8]
	tst     r1, r5
	bne     loc_80A3D1E
	ldrh    r2, [r4,#0x1C]
	ldr     r1, =0x10609    @ cmd
	lsl     r2, r2, #0x10
	add     r0, r4, #0      @ ctx
	bl      sdmmc_send_command
	ldr     r1, [r4,#8]
	and     r1, r5
	bne     loc_80A3D1E
	add     r0, r4, #0
	add     r0, #0xC
	bl      sub_80A3A54
	str     r0, [r4,#0x30]
	add     r0, r6, #0
	str     r6, [r4,#0x24]
	bl      sub_80A38A0
	ldrh    r2, [r4,#0x1C]
	add     r0, r4, #0      @ ctx
	lsl     r2, r2, #0x10
	ldr     r1, =0x10407    @ cmd
	bl      sdmmc_send_command
	ldr     r2, [r4,#8]
	tst     r2, r5
	bne     loc_80A3D1E
	add     r0, r4, #0      @ ctx
	ldr     r1, =0x10506    @ cmd
	ldr     r2, =0x3B70100  @ args
	str     r6, [r4,#0x28]
	bl      sdmmc_send_command
	ldr     r3, [r4,#8]
	tst     r3, r5
	bne     loc_80A3D1E
	ldr     r1, =0x10506    @ cmd
	add     r0, r4, #0      @ ctx
	ldr     r2, =0x3B90100  @ args
	bl      sdmmc_send_command
	ldr     r1, [r4,#8]
	tst     r1, r5
	bne     loc_80A3D1E
	ldrh    r2, [r4,#0x1C]
	add     r0, r4, #0      @ ctx
	lsl     r2, r2, #0x10
	ldr     r1, =0x1040D    @ cmd
	bl      sdmmc_send_command
	ldr     r2, [r4,#8]
	tst     r2, r5
	bne     loc_80A3D1E
	mov     r2, #0x80
	add     r0, r4, #0      @ ctx
	ldr     r1, =0x10410    @ cmd
	lsl     r2, r2, #2
	bl      sdmmc_send_command
	ldr     r3, [r4,#8]
	tst     r3, r5
	bne     loc_80A3D1E
	ldr     r3, =dword_80A6F20
	mov     r2, #0x80
	ldr     r1, [r3,#0x24]
	lsl     r2, r2, #2
	orr     r2, r1
	ldr     r0, =dword_80A6F58
	str     r2, [r3,#0x24]
	bl      sub_80A38D4
	mov     r0, #0
locret_80A3DC6:
	pop     {r4-r6,pc}
.pool

.align 4
.thumb_func
.global sdmmc_nand_readsectors
sdmmc_nand_readsectors:
	push    {r3-r7,lr}
	ldr     r4, =dword_80A6F20
	add     r5, r0, #0
	ldr     r3, [r4,#0x20]
	add     r7, r2, #0
	add     r6, r1, #0
	cmp     r3, #0
	bne     loc_80A3E0A
	lsl     r5, r0, #9
loc_80A3E0A:
	add     r0, r4, #0
	bl      sub_80A38D4
	ldr     r3, =emmc_stop
	mov     r2, #0x80
	lsl     r2, r2, #1
	strh    r2, [r3]
	lsl     r3, r6, #0x10
	ldr     r2, =emmc_blkcount
	lsr     r3, r3, #0x10
	strh    r3, [r2]
	ldr     r1, =0x33C12    @ cmd
	add     r2, r5, #0      @ args
	lsl     r6, r6, #9
	add     r0, r4, #0      @ ctx
	str     r7, [r4]
	str     r6, [r4,#4]
	bl      sdmmc_send_command
	ldr     r0, =dword_80A6F58
	bl      sub_80A38D4
	add     r0, r4, #0
	bl      sub_80A3A4C
	pop     {r3-r7,pc}
.pool

.align 4
sub_80A6754:
	push    {r4-r7,lr}
	mov     r12, r3
	lsl     r7, r2, #0x10
	lsl     r3, r0, #0x10
	lsr     r3, r3, #0x10
	lsr     r7, r7, #0x10
	lsr     r5, r2, #0x10
	add     r4, r0, #0
	lsr     r0, r0, #0x10
	add     r6, r3, #0
	mul     r6, r7
	mul     r3, r5
	mul     r7, r0
	mul     r5, r0
	add     r3, r7, r3
	lsr     r0, r6, #0x10
	add     r0, r3, r0
	cmp     r7, r0
	bls     loc_80A6780
	movs    r3, #0x80
	lsl     r3, r3, #9
	add     r5, r5, r3
loc_80A6780:
	lsr     r3, r0, #0x10
	add     r5, r5, r3
	add     r3, r4, #0
	mov     r4, r12
	mul     r4, r3
	mul     r2, r1
	lsl     r6, r6, #0x10
	lsr     r6, r6, #0x10
	add     r1, r4, r2
	lsl     r0, r0, #0x10
	add     r0, r0, r6
	add     r1, r1, r5
	pop     {r4-r7}
	pop     {r2}
	bx      r2
.pool

.align 4
.thumb_func
.global sdmmc_sdcard_init
sdmmc_sdcard_init:
	push    {lr}
	bl      InitSD
	bl      Nand_Init
	bl      SD_Init
	pop     {pc}

.align 4
.global dword_80A6F20
dword_80A6F20:
	.long 0
dword_80A6F24:
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
dword_80A6F3C:
	.long 0
dword_80A6F40:
	.long 0		@ is_not_sdhc
dword_80A6F44:
	.long 0
dword_80A6F48:
	.long 0
dword_80A6F4C:
	.long 0
dword_80A6F50:
	.long 0		@ size (sector)
dword_80A6F54:
	.long 0
.global dword_80A6F58
dword_80A6F58:
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
dword_80A6F74:
	.long 0
dword_80A6F78:
	.long 0		@ is_not_sdhc
dword_80A6F7C:
	.long 0
dword_80A6F80:
	.long 0
dword_80A6F84:
	.long 0
dword_80A6F88:
	.long 0		@ size (sector)
dword_80A6F8C:
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
