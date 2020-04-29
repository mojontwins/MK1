;* * * * *  Small-C/Plus z88dk * * * * *
;  Version: 20100416.1
;
;	Reconstructed for z80 Module Assembler
;
;	Module compile time: Wed Apr 29 16:30:38 2020



	MODULE	mk1.c


	INCLUDE "z80_crt0.hdr"


	LIB SPMoveSprAbs
	LIB SPPrintAtInv
	LIB SPTileArray
	LIB SPInvalidate
	LIB SPCompDListAddr
;	SECTION	text

._keys
	defw	383
	defw	479
	defw	735
	defw	509
	defw	507

;	SECTION	code

	.vpClipStruct defb 1, 1 + 20, 1, 1 + 30
	.fsClipStruct defb 0, 24, 0, 32
;	SECTION	text

._joyfunc
	defw	sp_JoyKeyboard

;	SECTION	code

;	SECTION	text

._joyfuncs
	defw	sp_JoyKeyboard
	defw	sp_JoyKempston
	defw	sp_JoySinclair1

;	SECTION	code


._my_malloc
	ld	hl,0 % 256	;const
	push	hl
	call	sp_BlockAlloc
	pop	bc
	ret


;	SECTION	text

._u_malloc
	defw	_my_malloc

;	SECTION	code

;	SECTION	text

._u_free
	defw	sp_FreeBlock

;	SECTION	code

;	SECTION	text

._spacer
	defw	i_1+0
;	SECTION	code

;	SECTION	text

._warp_to_level
	defm	""
	defb	0

;	SECTION	code


;	SECTION	text

._level_str
	defw	i_1+13
;	SECTION	code

;	SECTION	text

.__dx
	defm	""
	defb	0

	defm	""
	defb	8

	defm	""
	defb	0

	defm	""
	defb	248

;	SECTION	code


;	SECTION	text

.__dy
	defm	""
	defb	248

	defm	""
	defb	0

	defm	""
	defb	8

	defm	""
	defb	0

;	SECTION	code


	; aPPack decompressor
	; original source by dwedit
	; very slightly adapted by utopian
	; optimized by Metalbrain
	;hl = source
	;de = dest
	.depack ld ixl,128
	.apbranch1 ldi
	.aploop0 ld ixh,1 ;LWM = 0
	.aploop call ap_getbit
	jr nc,apbranch1
	call ap_getbit
	jr nc,apbranch2
	ld b,0
	call ap_getbit
	jr nc,apbranch3
	ld c,16 ;get an offset
	.apget4bits call ap_getbit
	rl c
	jr nc,apget4bits
	jr nz,apbranch4
	ld a,b
	.apwritebyte ld (de),a ;write a 0
	inc de
	jr aploop0
	.apbranch4 and a
	ex de,hl ;write a previous byte (1-15 away from dest)
	sbc hl,bc
	ld a,(hl)
	add hl,bc
	ex de,hl
	jr apwritebyte
	.apbranch3 ld c,(hl) ;use 7 bit offset, length = 2 or 3
	inc hl
	rr c
	ret z ;if a zero is encountered here, it is EOF
	ld a,2
	adc a,b
	push hl
	ld iyh,b
	ld iyl,c
	ld h,d
	ld l,e
	sbc hl,bc
	ld c,a
	jr ap_finishup2
	.apbranch2 call ap_getgamma ;use a gamma code * 256 for offset, another gamma code for length
	dec c
	ld a,c
	sub ixh
	jr z,ap_r0_gamma ;if gamma code is 2, use old r0 offset,
	dec a
	;do I even need this code?
	;bc=bc*256+(hl), lazy 16bit way
	ld b,a
	ld c,(hl)
	inc hl
	ld iyh,b
	ld iyl,c
	push bc
	call ap_getgamma
	ex (sp),hl ;bc = len, hl=offs
	push de
	ex de,hl
	ld a,4
	cp d
	jr nc,apskip2
	inc bc
	or a
	.apskip2 ld hl,127
	sbc hl,de
	jr c,apskip3
	inc bc
	inc bc
	.apskip3 pop hl ;bc = len, de = offs, hl=junk
	push hl
	or a
	.ap_finishup sbc hl,de
	pop de ;hl=dest-offs, bc=len, de = dest
	.ap_finishup2 ldir
	pop hl
	ld ixh,b
	jr aploop
	.ap_r0_gamma call ap_getgamma ;and a new gamma code for length
	push hl
	push de
	ex de,hl
	ld d,iyh
	ld e,iyl
	jr ap_finishup
	.ap_getbit ld a,ixl
	add a,a
	ld ixl,a
	ret nz
	ld a,(hl)
	inc hl
	rla
	ld ixl,a
	ret
	.ap_getgamma ld bc,1
	.ap_getgammaloop call ap_getbit
	rl c
	rl b
	call ap_getbit
	jr c,ap_getgammaloop
	ret

._unpack
	ld	hl,4	;const
	add	hl,sp
	call	l_gint	;
	ld	(_ram_address),hl
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(_ram_destination),hl
	ld hl, (_ram_address)
	ld de, (_ram_destination)
	call depack
	ret


	._s_title
	BINARY "title.bin"
	._s_marco
	._s_ending
	BINARY "ending.bin"

._blackout
	ld hl, 22528
	ld (hl), 0
	push hl
	pop de
	inc de
	ld bc, 767
	ldir
	ret


	._font BINARY "font.bin"
	._level_data defs 16
	._mapa defs 1 * 24 * 75
	._cerrojos defs 128 ; 32 * 4
	._tileset defs 1792 ; 192 * 8 + 256
	._malotes defs 1 * 24 * 3 * 10
	._hotspots defs 1 * 24 * 3
	._behs defs 48
	._sprites
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_1_a
	defb 0, 224
	defb 15, 192
	defb 30, 192
	defb 31, 192
	defb 31, 192
	defb 28, 192
	defb 5, 0
	defb 58, 0
	defb 96, 0
	defb 118, 0
	defb 52, 0
	defb 1, 0
	defb 5, 224
	defb 5, 224
	defb 0, 224
	defb 5, 224
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_1_b
	defb 0, 63
	defb 128, 31
	defb 192, 31
	defb 64, 7
	defb 240, 7
	defb 0, 7
	defb 192, 7
	defb 0, 0
	defb 254, 0
	defb 194, 0
	defb 24, 0
	defb 0, 0
	defb 128, 31
	defb 128, 31
	defb 0, 31
	defb 192, 31
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_1_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_2_a
	defb 0, 255
	defb 0, 224
	defb 15, 192
	defb 30, 192
	defb 31, 192
	defb 31, 192
	defb 4, 128
	defb 27, 128
	defb 48, 128
	defb 59, 128
	defb 26, 128
	defb 1, 128
	defb 44, 128
	defb 44, 128
	defb 32, 128
	defb 0, 128
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_2_b
	defb 0, 255
	defb 0, 63
	defb 128, 31
	defb 192, 15
	defb 64, 7
	defb 240, 7
	defb 0, 7
	defb 128, 0
	defb 127, 0
	defb 97, 0
	defb 12, 0
	defb 192, 0
	defb 192, 15
	defb 0, 15
	defb 224, 15
	defb 0, 15
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_2_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_3_a
	defb 0, 252
	defb 1, 248
	defb 3, 248
	defb 2, 224
	defb 15, 224
	defb 0, 224
	defb 3, 224
	defb 0, 0
	defb 127, 0
	defb 67, 0
	defb 24, 0
	defb 0, 0
	defb 1, 248
	defb 1, 248
	defb 0, 248
	defb 3, 248
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_3_b
	defb 0, 7
	defb 240, 3
	defb 120, 3
	defb 248, 3
	defb 248, 3
	defb 56, 3
	defb 160, 0
	defb 92, 0
	defb 6, 0
	defb 110, 0
	defb 44, 0
	defb 128, 0
	defb 160, 7
	defb 160, 7
	defb 0, 7
	defb 160, 7
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_3_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_4_a
	defb 0, 255
	defb 0, 252
	defb 1, 248
	defb 3, 240
	defb 2, 224
	defb 15, 224
	defb 0, 224
	defb 1, 0
	defb 254, 0
	defb 134, 0
	defb 48, 0
	defb 3, 0
	defb 3, 240
	defb 0, 240
	defb 7, 240
	defb 0, 240
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_4_b
	defb 0, 255
	defb 0, 7
	defb 240, 3
	defb 120, 3
	defb 248, 3
	defb 248, 3
	defb 32, 1
	defb 216, 1
	defb 12, 1
	defb 220, 1
	defb 88, 1
	defb 128, 1
	defb 52, 1
	defb 52, 1
	defb 4, 1
	defb 0, 1
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_4_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_5_a
	defb 0, 240
	defb 7, 224
	defb 13, 224
	defb 11, 224
	defb 15, 224
	defb 7, 128
	defb 40, 0
	defb 111, 0
	defb 110, 0
	defb 53, 0
	defb 0, 128
	defb 6, 240
	defb 0, 240
	defb 0, 254
	defb 0, 254
	defb 0, 254
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_5_b
	defb 0, 31
	defb 192, 15
	defb 224, 1
	defb 236, 1
	defb 236, 1
	defb 204, 0
	defb 50, 0
	defb 126, 0
	defb 236, 0
	defb 192, 1
	defb 12, 1
	defb 204, 1
	defb 192, 1
	defb 0, 31
	defb 192, 31
	defb 0, 31
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_5_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_6_a
	defb 0, 240
	defb 7, 224
	defb 13, 224
	defb 11, 224
	defb 15, 224
	defb 7, 128
	defb 40, 0
	defb 111, 0
	defb 110, 0
	defb 53, 0
	defb 0, 128
	defb 6, 240
	defb 6, 240
	defb 0, 240
	defb 6, 240
	defb 0, 240
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_6_b
	defb 0, 31
	defb 192, 15
	defb 224, 1
	defb 236, 1
	defb 236, 1
	defb 204, 0
	defb 50, 0
	defb 126, 0
	defb 236, 0
	defb 192, 0
	defb 12, 1
	defb 204, 1
	defb 0, 1
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_6_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_7_a
	defb 0, 248
	defb 3, 240
	defb 6, 240
	defb 5, 240
	defb 7, 192
	defb 16, 192
	defb 27, 192
	defb 24, 0
	defb 89, 0
	defb 91, 0
	defb 88, 0
	defb 27, 0
	defb 3, 192
	defb 24, 192
	defb 3, 192
	defb 0, 248
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_7_b
	defb 0, 15
	defb 224, 7
	defb 240, 7
	defb 240, 7
	defb 240, 7
	defb 0, 3
	defb 232, 1
	defb 12, 1
	defb 124, 1
	defb 120, 1
	defb 0, 3
	defb 96, 15
	defb 0, 15
	defb 0, 127
	defb 0, 127
	defb 0, 127
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_7_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_8_a
	defb 0, 248
	defb 3, 240
	defb 6, 240
	defb 5, 240
	defb 7, 192
	defb 16, 192
	defb 27, 192
	defb 24, 0
	defb 89, 0
	defb 91, 0
	defb 88, 0
	defb 27, 0
	defb 0, 192
	defb 24, 195
	defb 0, 195
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_8_b
	defb 0, 15
	defb 224, 7
	defb 240, 7
	defb 240, 7
	defb 240, 7
	defb 0, 3
	defb 232, 1
	defb 12, 1
	defb 124, 1
	defb 120, 1
	defb 0, 3
	defb 96, 15
	defb 96, 15
	defb 0, 15
	defb 96, 15
	defb 0, 15
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_8_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_9_a
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 224
	defb 14, 192
	defb 31, 128
	defb 59, 128
	defb 49, 128
	defb 0, 132
	defb 0, 254
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_9_b
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 225
	defb 12, 65
	defb 28, 1
	defb 184, 1
	defb 240, 3
	defb 224, 7
	defb 0, 15
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_9_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_10_a
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 135
	defb 48, 130
	defb 56, 128
	defb 29, 128
	defb 15, 192
	defb 7, 224
	defb 0, 240
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_10_b
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 7
	defb 112, 3
	defb 248, 1
	defb 220, 1
	defb 140, 1
	defb 0, 33
	defb 0, 127
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_10_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_11_a
	defb 0, 255
	defb 0, 248
	defb 3, 248
	defb 3, 248
	defb 1, 248
	defb 0, 252
	defb 0, 254
	defb 0, 252
	defb 1, 248
	defb 3, 248
	defb 3, 248
	defb 3, 248
	defb 1, 248
	defb 0, 252
	defb 0, 254
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_11_b
	defb 0, 255
	defb 0, 127
	defb 0, 63
	defb 128, 31
	defb 192, 15
	defb 224, 15
	defb 96, 15
	defb 224, 15
	defb 192, 15
	defb 128, 31
	defb 0, 63
	defb 128, 31
	defb 192, 31
	defb 192, 31
	defb 0, 31
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_11_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_12_a
	defb 0, 255
	defb 0, 254
	defb 0, 252
	defb 1, 248
	defb 3, 240
	defb 3, 240
	defb 3, 240
	defb 1, 240
	defb 0, 240
	defb 0, 248
	defb 0, 252
	defb 1, 248
	defb 3, 248
	defb 3, 248
	defb 0, 248
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_12_b
	defb 0, 255
	defb 0, 31
	defb 192, 31
	defb 192, 31
	defb 128, 31
	defb 0, 63
	defb 128, 127
	defb 192, 63
	defb 224, 31
	defb 96, 31
	defb 224, 31
	defb 192, 31
	defb 128, 31
	defb 0, 63
	defb 0, 127
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_12_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_13_a
	defb 0, 255
	defb 0, 248
	defb 3, 240
	defb 5, 240
	defb 7, 192
	defb 20, 128
	defb 49, 128
	defb 34, 128
	defb 53, 128
	defb 48, 128
	defb 7, 128
	defb 3, 240
	defb 0, 248
	defb 3, 248
	defb 0, 248
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_13_b
	defb 0, 255
	defb 0, 31
	defb 192, 15
	defb 224, 3
	defb 232, 1
	defb 44, 1
	defb 68, 1
	defb 172, 1
	defb 76, 1
	defb 0, 1
	defb 96, 15
	defb 0, 15
	defb 0, 127
	defb 0, 127
	defb 0, 127
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_13_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_14_a
	defb 0, 255
	defb 0, 248
	defb 3, 240
	defb 5, 192
	defb 23, 128
	defb 52, 128
	defb 34, 128
	defb 53, 128
	defb 50, 128
	defb 0, 128
	defb 6, 240
	defb 0, 240
	defb 0, 254
	defb 0, 254
	defb 0, 254
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_14_b
	defb 0, 255
	defb 0, 31
	defb 192, 15
	defb 224, 15
	defb 224, 3
	defb 40, 1
	defb 140, 1
	defb 68, 1
	defb 172, 1
	defb 12, 1
	defb 224, 1
	defb 192, 15
	defb 0, 31
	defb 192, 31
	defb 0, 31
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_14_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_15_a
	defb 0, 240
	defb 7, 224
	defb 13, 224
	defb 14, 224
	defb 15, 224
	defb 0, 128
	defb 55, 0
	defb 112, 0
	defb 100, 0
	defb 83, 0
	defb 48, 0
	defb 6, 128
	defb 6, 240
	defb 0, 240
	defb 6, 240
	defb 0, 240
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_15_b
	defb 0, 31
	defb 192, 15
	defb 96, 15
	defb 224, 15
	defb 224, 15
	defb 0, 15
	defb 192, 3
	defb 24, 1
	defb 92, 1
	defb 140, 1
	defb 20, 1
	defb 216, 1
	defb 0, 3
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_15_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_16_a
	defb 0, 248
	defb 3, 240
	defb 6, 240
	defb 7, 240
	defb 7, 240
	defb 0, 240
	defb 3, 192
	defb 24, 128
	defb 58, 128
	defb 49, 128
	defb 40, 128
	defb 27, 128
	defb 0, 192
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_16_b
	defb 0, 15
	defb 224, 7
	defb 176, 7
	defb 112, 7
	defb 240, 7
	defb 0, 1
	defb 236, 0
	defb 14, 0
	defb 38, 0
	defb 202, 0
	defb 12, 0
	defb 96, 1
	defb 96, 15
	defb 0, 15
	defb 96, 15
	defb 0, 15
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_16_c
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._sprite_17_a
	BINARY "sprites_extra.bin"
	._sprite_18_a
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	._sprite_18_b
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	._sprite_18_c
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255
	._sprite_19_a
	BINARY "sprites_bullet.bin"
	._map_bolts_0
	BINARY "../bin/mapa_bolts0c.bin"
	._map_bolts_1
	BINARY "../bin/mapa_bolts1c.bin"
	._map_bolts_2
	BINARY "../bin/mapa_bolts2c.bin"
	._tileset_0
	BINARY "../bin/tileset0c.bin"
	._tileset_1
	BINARY "../bin/tileset1c.bin"
	._tileset_2
	BINARY "../bin/tileset2c.bin"
	._enems_hotspots_0
	BINARY "../bin/enems_hotspots0c.bin"
	._enems_hotspots_1
	BINARY "../bin/enems_hotspots1c.bin"
	._enems_hotspots_2
	BINARY "../bin/enems_hotspots2c.bin"
	._behs_0_1
	BINARY "../bin/behs0_1c.bin"
	._behs_2
	BINARY "../bin/behs2c.bin"
;	SECTION	text

._levels
	defb	1
	defb	24
	defb	23
	defb	12
	defb	7
	defb	99
	defw	_map_bolts_0
	defw	_tileset_0
	defw	_enems_hotspots_0
	defw	_behs_0_1
	defb	1
	defb	24
	defb	23
	defb	12
	defb	7
	defb	99
	defw	_map_bolts_1
	defw	_tileset_1
	defw	_enems_hotspots_1
	defw	_behs_0_1
	defb	1
	defb	24
	defb	23
	defb	6
	defb	8
	defb	99
	defw	_map_bolts_2
	defw	_tileset_2
	defw	_enems_hotspots_2
	defw	_behs_2

;	SECTION	code

;	SECTION	text

._decos_computer
	defm	"c s!"
	defb	131

	defm	""
	defb	34

	defm	"d$t%"
	defb	132

	defm	"&"
	defb	255

;	SECTION	code


;	SECTION	text

._decos_bombs
	defm	"D"
	defb	17

	defm	"B"
	defb	17

	defm	"q"
	defb	17

	defm	""
	defb	162

	defm	""
	defb	17

	defm	""
	defb	164

	defm	""
	defb	17

	defm	""
	defb	255

;	SECTION	code


;	SECTION	text

._decos_moto
	defm	""
	defb	19

	defm	"(#)"
	defb	255

;	SECTION	code


	;org 60000
	;BeepFX player by Shiru
	;You are free to do whatever you want with this code
	.playBasic
	ld a,0
	.sound_play
	ld hl,sfxData ;address of sound effects data
	;di
	push ix
	push iy
	ld b,0
	ld c,a
	add hl,bc
	add hl,bc
	ld e,(hl)
	inc hl
	ld d,(hl)
	push de
	pop ix ;put it into ix
	ld a,(23624) ;get border color from BASIC vars to keep it unchanged
	rra
	rra
	rra
	and 7
	ld (sfxRoutineToneBorder +1),a
	ld (sfxRoutineNoiseBorder +1),a
	ld (sfxRoutineSampleBorder+1),a
	.readData
	ld a,(ix+0) ;read block type
	ld c,(ix+1) ;read duration 1
	ld b,(ix+2)
	ld e,(ix+3) ;read duration 2
	ld d,(ix+4)
	push de
	pop iy
	dec a
	jr z,sfxRoutineTone
	dec a
	jr z,sfxRoutineNoise
	dec a
	jr z,sfxRoutineSample
	pop iy
	pop ix
	;ei
	ret
	;play sample
	.sfxRoutineSample
	ex de,hl
	.sfxRS0
	ld e,8
	ld d,(hl)
	inc hl
	.sfxRS1
	ld a,(ix+5)
	.sfxRS2
	dec a
	jr nz,sfxRS2
	rl d
	sbc a,a
	and 16
	.sfxRoutineSampleBorder
	or 0
	out (254),a
	dec e
	jr nz,sfxRS1
	dec bc
	ld a,b
	or c
	jr nz,sfxRS0
	ld c,6
	.nextData
	add ix,bc ;skip to the next block
	jr readData
	;generate tone with many parameters
	.sfxRoutineTone
	ld e,(ix+5) ;freq
	ld d,(ix+6)
	ld a,(ix+9) ;duty
	ld (sfxRoutineToneDuty+1),a
	ld hl,0
	.sfxRT0
	push bc
	push iy
	pop bc
	.sfxRT1
	add hl,de
	ld a,h
	.sfxRoutineToneDuty
	cp 0
	sbc a,a
	and 16
	.sfxRoutineToneBorder
	or 0
	out (254),a
	dec bc
	ld a,b
	or c
	jr nz,sfxRT1
	ld a,(sfxRoutineToneDuty+1) ;duty change
	add a,(ix+10)
	ld (sfxRoutineToneDuty+1),a
	ld c,(ix+7) ;slide
	ld b,(ix+8)
	ex de,hl
	add hl,bc
	ex de,hl
	pop bc
	dec bc
	ld a,b
	or c
	jr nz,sfxRT0
	ld c,11
	jr nextData
	;generate noise with two parameters
	.sfxRoutineNoise
	ld e,(ix+5) ;pitch
	ld d,1
	ld h,d
	ld l,d
	.sfxRN0
	push bc
	push iy
	pop bc
	.sfxRN1
	ld a,(hl)
	and 16
	.sfxRoutineNoiseBorder
	or 0
	out (254),a
	dec d
	jr nz,sfxRN2
	ld d,e
	inc hl
	ld a,h
	and 31
	ld h,a
	.sfxRN2
	dec bc
	ld a,b
	or c
	jr nz,sfxRN1
	ld a,e
	add a,(ix+6) ;slide
	ld e,a
	pop bc
	dec bc
	ld a,b
	or c
	jr nz,sfxRN0
	ld c,7
	jr nextData
	.sfxData
	.SoundEffectsData
	defw SoundEffect0Data
	defw SoundEffect1Data
	defw SoundEffect2Data
	defw SoundEffect3Data
	defw SoundEffect4Data
	defw SoundEffect5Data
	defw SoundEffect6Data
	defw SoundEffect7Data
	defw SoundEffect8Data
	defw SoundEffect9Data
	.SoundEffect0Data
	defb 2 ;noise
	defw 8,200,20
	defb 2 ;noise
	defw 4,2000,5220
	defb 0
	.SoundEffect1Data
	defb 2 ;noise
	defw 1,1000,10
	defb 2 ;noise
	defw 1,1000,1
	defb 0
	.SoundEffect2Data
	defb 1 ;tone
	defw 50,100,200,65531,128
	defb 0
	.SoundEffect3Data
	defb 1 ;tone
	defw 100,20,500,2,128
	defb 0
	.SoundEffect4Data
	defb 2 ;noise
	defw 1,1000,20
	defb 1 ;pause
	defw 1,1000,0,0,0
	defb 2 ;noise
	defw 1,1000,1
	defb 0
	.SoundEffect5Data
	defb 1 ;tone
	defw 50,200,500,65516,128
	defb 0
	.SoundEffect6Data
	defb 2 ;noise
	defw 20,50,257
	defb 0
	.SoundEffect7Data
	defb 1 ;tone
	defw 1,1000,2000,0,64
	defb 1 ;pause
	defw 1,1000,0,0,0
	defb 1 ;tone
	defw 1,1000,1500,0,64
	defb 0
	.SoundEffect8Data
	defb 2 ;noise
	defw 2,2000,32776
	defb 0
	.SoundEffect9Data
	defb 1 ;tone
	defw 4,1000,1000,400,128
	defb 0

._beep_fx
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	(_asm_int),hl
	push ix
	push iy
	ld a, (_asm_int)
	call sound_play
	pop ix
	pop iy
	ret



._attr
	ld	hl,4	;const
	add	hl,sp
	ld	e,(hl)
	ld	d,0
	ld	hl,14	;const
	call	l_uge
	jp	c,i_18
	ld	hl,2	;const
	add	hl,sp
	ld	e,(hl)
	ld	d,0
	ld	hl,10	;const
	call	l_uge
	jp	nc,i_17
.i_18
	ld	hl,0 % 256	;const
	ret


.i_17
	ld	hl,_map_attr
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	e,(hl)
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	pop	de
	add	hl,de
	ex	de,hl
	ld	hl,6-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ex	de,hl
	and	a
	sbc	hl,de
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ret



._qtile
	ld	hl,_map_buff
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	e,(hl)
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	pop	de
	add	hl,de
	ex	de,hl
	ld	hl,6-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ex	de,hl
	and	a
	sbc	hl,de
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ret



._draw_coloured_tile
	ld a, (__x)
	ld c, a
	ld a, (__y)
	call SPCompDListAddr
	ex de, hl
	ld a, (__t)
	sla a
	sla a
	add 64
	ld hl, _tileset + 1536
	ld b, 0
	ld c, a
	add hl, bc
	ld c, a
	ld a, (hl)
	ld (de), a
	inc de
	inc hl
	ld a, c
	ld (de), a
	inc de
	inc a
	ld c, a
	inc de
	inc de
	ld a, (hl)
	ld (de), a
	inc de
	inc hl
	ld a, c
	ld (de), a
	inc a
	ex de, hl
	ld bc, 123
	add hl, bc
	ex de, hl
	ld c, a
	ld a, (hl)
	ld (de), a
	inc de
	inc hl
	ld a, c
	ld (de), a
	inc de
	inc a
	ld c, a
	inc de
	inc de
	ld a, (hl)
	ld (de), a
	inc de
	ld a, c
	ld (de), a
	ret



._invalidate_tile
	; Invalidate Rectangle
	;
	; enter: B = row coord top left corner
	; C = col coord top left corner
	; D = row coord bottom right corner
	; E = col coord bottom right corner
	; IY = clipping rectangle, set it to "ClipStruct" for full screen
	ld a, (__x)
	ld c, a
	inc a
	ld e, a
	ld a, (__y)
	ld b, a
	inc a
	ld d, a
	ld iy, fsClipStruct
	call SPInvalidate
	ret



._invalidate_viewport
	; Invalidate Rectangle
	;
	; enter: B = row coord top left corner
	; C = col coord top left corner
	; D = row coord bottom right corner
	; E = col coord bottom right corner
	; IY = clipping rectangle, set it to "ClipStruct" for full screen
	ld b, 1
	ld c, 1
	ld d, 1+19
	ld e, 1+29
	ld iy, vpClipStruct
	call SPInvalidate
	ret



._draw_invalidate_coloured_tile_g
	call	_draw_coloured_tile_gamearea
	call	_invalidate_tile
	ret



._draw_coloured_tile_gamearea
	ld	a,(__x)
	ld	e,a
	ld	d,0
	ld	l,#(1 % 256)
	call	l_asl
	ld	de,1
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(__x),a
	ld	a,(__y)
	ld	e,a
	ld	d,0
	ld	l,#(1 % 256)
	call	l_asl
	ld	de,1
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(__y),a
	call	_draw_coloured_tile
	ret



._draw_decorations
	ld hl, (__gp_gen)
	._draw_decorations_loop
	ld a, (hl)
	cp 0xff
	ret z
	ld a, (hl)
	inc hl
	ld c, a
	and 0x0f
	ld (__y), a
	ld a, c
	srl a
	srl a
	srl a
	srl a
	ld (__x), a
	ld a, (hl)
	inc hl
	ld (__t), a
	push hl
	ld b, 0
	ld c, a
	ld hl, _behs
	add hl, bc
	ld a, (hl)
	ld (__n), a
	call _update_tile
	pop hl
	jr _draw_decorations_loop
	ret


;	SECTION	text

._utaux
	defm	""
	defb	0

;	SECTION	code



._update_tile
	ld a, (__x)
	ld c, a
	ld a, (__y)
	ld b, a
	sla a
	sla a
	sla a
	sla a
	sub b
	add c
	ld b, 0
	ld c, a
	ld hl, _map_attr
	add hl, bc
	ld a, (__n)
	ld (hl), a
	ld hl, _map_buff
	add hl, bc
	ld a, (__t)
	ld (hl), a
	call _draw_coloured_tile_gamearea
	ld a, (_is_rendering)
	or a
	ret nz
	call _invalidate_tile
	ret



._print_number2
	ld	a,(__t)
	ld	e,a
	ld	d,0
	ld	hl,10	;const
	call	l_div_u
	ld	de,16
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_rda),a
	ld	a,(__t)
	ld	e,a
	ld	d,0
	ld	hl,10	;const
	call	l_div_u
	ex	de,hl
	ld	de,16
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_rdb),a
	; enter: A = row position (0..23)
	; C = col position (0..31/63)
	; D = pallette #
	; E = graphic #
	ld a, (_rda)
	ld e, a
	ld d, 7
	ld a, (__x)
	ld c, a
	ld a, (__y)
	call SPPrintAtInv
	ld a, (_rdb)
	ld e, a
	ld d, 7
	ld a, (__x)
	inc a
	ld c, a
	ld a, (__y)
	call SPPrintAtInv
	ret



._draw_objs
	ld	a,#(27 % 256 % 256)
	ld	(__x),a
	ld	a,#(23 % 256 % 256)
	ld	(__y),a
	ld	hl,(_p_objs)
	ld	h,0
	ld	a,l
	ld	(__t),a
	call	_print_number2
	ret



._print_str
	ld hl, (__gp_gen)
	.print_str_loop
	ld a, (hl)
	or a
	ret z
	inc hl
	sub 32
	ld e, a
	ld a, (__t)
	ld d, a
	ld a, (__x)
	ld c, a
	cp 31
	jr z, print_str_no_inc_a
	inc a
	.print_str_no_inc_a
	ld (__x), a
	ld a, (__y)
	push hl
	call SPPrintAtInv
	pop hl
	jr print_str_loop
	ret



._blackout_area
	ld de, 22528 + 32 * 1 + 1
	ld b, 20
	.bal1
	push bc
	ld h, d
	ld l, e
	ld (hl), 0
	inc de
	ld bc, 29
	ldir
	inc de
	inc de
	pop bc
	djnz bal1
	ret



._clear_sprites
	ld ix, (_sp_player)
	ld iy, vpClipStruct
	ld bc, 0
	ld hl, 0xdede
	ld de, 0
	call SPMoveSprAbs
	xor a
	.hide_sprites_enems_loop
	ld (_gpit), a
	sla a
	ld c, a
	ld b, 0
	ld hl, _sp_moviles
	add hl, bc
	ld e, (hl)
	inc hl
	ld d, (hl)
	push de
	pop ix
	ld iy, vpClipStruct
	ld bc, 0
	ld hl, 0xfefe
	ld de, 0
	call SPMoveSprAbs
	ld a, (_gpit)
	inc a
	cp 3
	jr nz, hide_sprites_enems_loop
	xor a
	.hide_sprites_bullets_loop
	ld (_gpit), a
	sla a
	ld c, a
	ld b, 0
	ld hl, _sp_bullets
	add hl, bc
	ld e, (hl)
	inc hl
	ld d, (hl)
	push de
	pop ix
	ld iy, vpClipStruct
	ld bc, 0
	ld hl, 0xfefe
	ld de, 0
	call SPMoveSprAbs
	ld a, (_gpit)
	inc a
	cp 3
	jr nz, hide_sprites_bullets_loop
	ret



._collide
	ld	hl,(_gpx)
	ld	h,0
	ld	bc,13
	add	hl,bc
	ex	de,hl
	ld	hl,(_cx2)
	ld	h,0
	call	l_uge
	jp	nc,i_21
	ld	hl,(_gpx)
	ld	h,0
	push	hl
	ld	hl,(_cx2)
	ld	h,0
	ld	bc,13
	add	hl,bc
	pop	de
	call	l_ule
	jp	nc,i_21
	ld	hl,(_gpy)
	ld	h,0
	ld	bc,12
	add	hl,bc
	ex	de,hl
	ld	hl,(_cy2)
	ld	h,0
	call	l_uge
	jp	nc,i_21
	ld	hl,(_gpy)
	ld	h,0
	push	hl
	ld	hl,(_cy2)
	ld	h,0
	ld	bc,12
	add	hl,bc
	pop	de
	call	l_ule
	jp	nc,i_21
	ld	hl,1	;const
	jr	i_22
.i_21
	ld	hl,0	;const
.i_22
	ld	h,0
	ret



._cm_two_points
	ld a, (_cx1)
	cp 15
	jr nc, _cm_two_points_at1_reset
	ld a, (_cy1)
	cp 10
	jr c, _cm_two_points_at1_do
	._cm_two_points_at1_reset
	xor a
	jr _cm_two_points_at1_done
	._cm_two_points_at1_do
	ld a, (_cy1)
	ld b, a
	sla a
	sla a
	sla a
	sla a
	sub b
	ld b, a
	ld a, (_cx1)
	add b
	ld e, a
	ld d, 0
	ld hl, _map_attr
	add hl, de
	ld a, (hl)
	._cm_two_points_at1_done
	ld (_at1), a
	ld a, (_cx2)
	cp 15
	jr nc, _cm_two_points_at2_reset
	ld a, (_cy2)
	cp 10
	jr c, _cm_two_points_at2_do
	._cm_two_points_at2_reset
	xor a
	jr _cm_two_points_at2_done
	._cm_two_points_at2_do
	ld a, (_cy2)
	ld b, a
	sla a
	sla a
	sla a
	sla a
	sub b
	ld b, a
	ld a, (_cx2)
	add b
	ld e, a
	ld d, 0
	ld hl, _map_attr
	add hl, de
	ld a, (hl)
	._cm_two_points_at2_done
	ld (_at2), a
	ret



._rand
	.rand16
	ld hl, _seed
	ld a, (hl)
	ld e, a
	inc hl
	ld a, (hl)
	ld d, a
	;; Ahora DE = [SEED]
	ld a, d
	ld h, e
	ld l, 253
	or a
	sbc hl, de
	sbc a, 0
	sbc hl, de
	ld d, 0
	sbc a, d
	ld e, a
	sbc hl, de
	jr nc, nextrand
	inc hl
	.nextrand
	ld d, h
	ld e, l
	ld hl, _seed
	ld a, e
	ld (hl), a
	inc hl
	ld a, d
	ld (hl), a
	;; Ahora [SEED] = HL
	ld l, e
	ret
	ret



._abs
	pop	bc
	pop	hl
	push	hl
	push	bc
	xor	a
	or	h
	jp	p,i_23
	pop	bc
	pop	hl
	push	hl
	push	bc
	call	l_neg
	ret


.i_23
	pop	bc
	pop	hl
	push	hl
	push	bc
	ret


.i_24
	ret



._cortina
	;; Antes que nada vamos a limpiar el PAPER de toda la pantalla
	;; para que no queden artefactos feos
	ld de, 22528 ; Apuntamos con DE a la zona de atributos
	ld b, 3 ; Procesamos 3 tercios
	.clearb1
	push bc
	ld b, 0 ; Procesamos los 256 atributos de cada tercio
	.clearb2
	ld a, (de) ; Nos traemos un atributo
	and 199 ; Le hacemos la máscara 11000111 y dejamos PAPER a 0
	ld (de), a ; Y lo volvemos a poner
	inc de ; Siguiente atributo
	djnz clearb2
	pop bc
	djnz clearb1
	;; Y ahora el código original que escribí para UWOL:
	ld a, 8
	.repitatodo
	ld c, a ; Salvamos el contador de "repitatodo" en 'c'
	ld hl, 16384
	ld a, 12
	.bucle
	ld b, a ; Salvamos el contador de "bucle" en 'b'
	ld a, 0
	.bucle1
	sla (hl)
	inc hl
	dec a
	jr nz, bucle1
	ld a, 0
	.bucle2
	srl (hl)
	inc hl
	dec a
	jr nz, bucle2
	ld a, b ; Restituimos el contador de "bucle" a 'a'
	dec a
	jr nz, bucle
	ld a, c ; Restituimos el contador de "repitatodo" a 'a'
	dec a
	jr nz, repitatodo
	ret



._break_wall
	ld	hl,(__x)
	ld	h,0
	push	hl
	ld	a,(__y)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	pop	de
	add	hl,de
	ex	de,hl
	ld	hl,(__y)
	ld	h,0
	ex	de,hl
	and	a
	sbc	hl,de
	ld	h,0
	ld	a,l
	ld	(_gpaux),a
	ld	de,_brk_buff
	ld	hl,(_gpaux)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	cp	#(1 % 256)
	jp	z,i_25
	jp	nc,i_25
	ld	de,_brk_buff
	ld	hl,(_gpaux)
	ld	h,0
	add	hl,de
	inc	(hl)
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_26
.i_25
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(__t),a
	ld	h,0
	ld	a,l
	ld	(__n),a
	call	_update_tile
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_26
	call	sp_UpdateNow
	ld	hl,(_gpit)
	ld	h,0
	push	hl
	call	_beep_fx
	pop	bc
	ret



._bullets_init
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_b_it),a
.i_27
	ld	a,(_b_it)
	cp	#(3 % 256)
	jp	z,i_28
	jp	nc,i_28
	ld	de,_bullets_estado
	ld	hl,(_b_it)
	ld	h,0
	add	hl,de
	ld	(hl),#(0 % 256 % 256)
	ld	hl,(_b_it)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_b_it),a
	jp	i_27
.i_28
	ret



._bullets_update
	ld de, (_b_it)
	ld d, 0
	ld hl, _bullets_estado
	add hl, de
	ld a, (__b_estado)
	ld (hl), a
	ld hl, _bullets_x
	add hl, de
	ld a, (__b_x)
	ld (hl), a
	ld hl, _bullets_y
	add hl, de
	ld a, (__b_y)
	ld (hl), a
	ld hl, _bullets_mx
	add hl, de
	ld a, (__b_mx)
	ld (hl), a
	ld hl, _bullets_my
	add hl, de
	ld a, (__b_my)
	ld (hl), a
	ret


;	SECTION	text

.__bxo
	defm	""
	defb	12

	defm	""
	defb	252

	defm	""
	defb	8

	defm	""
	defb	0

;	SECTION	code


;	SECTION	text

.__byo
	defm	""
	defb	6

	defm	""
	defb	6

	defm	""
	defb	252

	defm	""
	defb	12

;	SECTION	code


;	SECTION	text

.__bmxo
	defm	""
	defb	8

	defm	""
	defb	248

	defm	""
	defb	0

	defm	""
	defb	0

;	SECTION	code


;	SECTION	text

.__bmyo
	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	248

	defm	""
	defb	8

;	SECTION	code



._bullets_fire
	ld	hl,(_p_ammo)
	ld	h,0
	call	l_lneg
	jp	nc,i_33
	ret


.i_33
	ld	hl,(_p_ammo)
	ld	h,0
	dec	hl
	ld	a,l
	ld	(_p_ammo),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_b_it),a
	jp	i_36
.i_34
	ld	hl,(_b_it)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_b_it),a
.i_36
	ld	a,(_b_it)
	cp	#(3 % 256)
	jp	z,i_35
	jp	nc,i_35
	ld	de,_bullets_estado
	ld	hl,(_b_it)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	and	a
	jp	nz,i_37
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(__b_estado),a
	ld a, (_p_facing)
	srl a
	ld c, a
	ld b, 0
	ld hl, __bxo
	add hl, bc
	ld d, (hl)
	ld a, (_gpx)
	add d
	ld (__b_x),a
	ld hl, __byo
	add hl, bc
	ld d, (hl)
	ld a, (_gpy)
	add d
	ld (__b_y),a
	ld hl, __bmxo
	add hl, bc
	ld a, (hl)
	ld (__b_mx),a
	ld hl, __bmyo
	add hl, bc
	ld a, (hl)
	ld (__b_my),a
	ld	hl,6 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
	call	_bullets_update
	jp	i_35
.i_37
	jp	i_34
.i_35
	ret



._bullets_move
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_b_it),a
	jp	i_40
.i_38
	ld	hl,_b_it
	ld	a,(hl)
	inc	(hl)
.i_40
	ld	a,(_b_it)
	cp	#(3 % 256)
	jp	z,i_39
	jp	nc,i_39
	ld	de,_bullets_estado
	ld	hl,(_b_it)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,h
	or	l
	jp	z,i_41
	ld de, (_b_it)
	ld d, 0
	ld hl, _bullets_x
	add hl, de
	ld a, (hl)
	ld (__b_x), a
	ld hl, _bullets_y
	add hl, de
	ld a, (hl)
	ld (__b_y), a
	ld hl, _bullets_mx
	add hl, de
	ld a, (hl)
	ld (__b_mx), a
	ld hl, _bullets_my
	add hl, de
	ld a, (hl)
	ld (__b_my), a
	ld a, 1
	ld (__b_estado), a
	ld	hl,__b_mx
	call	l_gchar
	ld	a,h
	or	l
	jp	z,i_42
	ld	hl,(__b_x)
	ld	h,0
	push	hl
	ld	hl,__b_mx
	call	l_gchar
	pop	de
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(__b_x),a
	cp	#(240 % 256)
	jp	z,i_43
	jp	c,i_43
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(__b_estado),a
.i_43
.i_42
	ld	hl,__b_my
	call	l_gchar
	ld	a,h
	or	l
	jp	z,i_44
	ld	hl,(__b_y)
	ld	h,0
	push	hl
	ld	hl,__b_my
	call	l_gchar
	pop	de
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(__b_y),a
	cp	#(160 % 256)
	jp	z,i_45
	jp	c,i_45
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(__b_estado),a
.i_45
.i_44
	ld	hl,(__b_x)
	ld	h,0
	inc	hl
	inc	hl
	inc	hl
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(__x),a
	ld	hl,(__b_y)
	ld	h,0
	inc	hl
	inc	hl
	inc	hl
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(__y),a
	ld	hl,(__x)
	ld	h,0
	push	hl
	ld	hl,(__y)
	ld	h,0
	push	hl
	call	_attr
	pop	bc
	pop	bc
	ld	h,0
	ld	a,l
	ld	(_rda),a
	ld	hl,_rda
	ld	a,(hl)
	and	#(16 % 256)
	jp	z,i_46
	ld	l,a
	ld	h,0
	call	_break_wall
.i_46
	ld	a,(_rda)
	cp	#(7 % 256)
	jp	z,i_47
	jp	c,i_47
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(__b_estado),a
.i_47
	call	_bullets_update
.i_41
	jp	i_38
.i_39
	ret



._simple_coco_init
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_enit),a
	jp	i_50
.i_48
	ld	hl,(_enit)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_enit),a
.i_50
	ld	a,(_enit)
	cp	#(3 % 256)
	jp	z,i_49
	jp	nc,i_49
	ld	de,_cocos_y
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	ld	(hl),#(255 % 256 % 256)
	ld	l,(hl)
	ld	h,0
	jp	i_48
.i_49
	ret



._simple_coco_shoot
	ld de, (_enit)
	ld d, 0
	ld hl, _cocos_y
	add hl, de
	ld a, (hl)
	cp 160
	ret c
	ld a, (__en_y)
	add 4
	ld (hl), a
	ld hl, _cocos_x
	add hl, de
	ld a, (__en_x)
	add 4
	ld (hl), a
	ld a, (_rda)
	ld e, a
	ld d, 0
	ld hl, __dx
	add hl, de
	ld b, (hl)
	ld hl, __dy
	add hl, de
	ld c, (hl)
	ld de, (_enit)
	ld d, 0
	ld hl, _cocos_mx
	add hl, de
	ld (hl), b
	ld hl, _cocos_my
	add hl, de
	ld (hl), c
	ret



._simple_coco_update
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_enit),a
	jp	i_53
.i_51
	ld	hl,(_enit)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_enit),a
.i_53
	ld	a,(_enit)
	cp	#(3 % 256)
	jp	z,i_52
	jp	nc,i_52
	ld	de,_cocos_y
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	ld	e,(hl)
	ld	d,0
	ld	hl,160	;const
	call	l_ult
	jp	nc,i_54
	._simple_coco_update_do
	ld de, (_enit)
	ld d, 0
	ld hl, _cocos_y
	add hl, de
	ld b, (hl)
	ld hl, _cocos_x
	add hl, de
	ld c, (hl)
	ld hl, _cocos_my
	add hl, de
	ld a, (hl)
	add b
	ld (_rdy), a
	ld hl, _cocos_mx
	add hl, de
	ld a, (hl)
	add c
	ld (_rdx), a
	cp 240
	jr c, _simple_coco_update_keep_going
	ld a, 0xff
	ld (_rdy), a
	jr _simple_coco_update_continue
	._simple_coco_update_keep_going
	ld a, (_p_estado)
	or a
	jr nz, _simple_coco_update_continue
	ld a, (_gpx)
	ld c, a
	ld a, (_rdx)
	add 3
	cp c
	jr c, _simple_coco_update_collpl_done
	ld a, (_rdx)
	ld c, a
	ld a, (_gpx)
	add 12
	cp c
	jr c, _simple_coco_update_collpl_done
	ld a, (_gpy)
	ld c, a
	ld a, (_rdy)
	add 3
	cp c
	jr c, _simple_coco_update_collpl_done
	ld a, (_rdy)
	ld c, a
	ld a, (_gpy)
	add 12
	cp c
	jr c, _simple_coco_update_collpl_done
	ld a, 0xff
	ld (_rdy), a
	ld a, 4
	ld (_p_killme), a
	jr _simple_coco_update_continue
	._simple_coco_update_collpl_done
	ld	hl,(_rdx)
	ld	h,0
	inc	hl
	inc	hl
	inc	hl
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	push	hl
	ld	hl,(_rdy)
	ld	h,0
	inc	hl
	inc	hl
	inc	hl
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	push	hl
	call	_attr
	pop	bc
	pop	bc
	ld	de,12	;const
	ex	de,hl
	call	l_and
	ld	a,h
	or	l
	jp	z,i_55
	ld	hl,255 % 256	;const
	ld	a,l
	ld	(_rdy),a
.i_55
	._simple_coco_update_continue
	ld de, (_enit)
	ld d, 0
	ld hl, _cocos_y
	add hl, de
	ld a, (_rdy)
	ld (hl), a
	ld hl, _cocos_x
	add hl, de
	ld a, (_rdx)
	ld (hl), a
	._simple_coco_update_done
.i_54
	jp	i_51
.i_52
	ret



._prepare_level
	ld	hl,_levels
	push	hl
	ld	hl,(_level)
	ld	h,0
	add	hl,hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	add	hl,hl
	add	hl,bc
	pop	de
	add	hl,de
	ld	bc,6
	add	hl,bc
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_mapa
	push	hl
	call	_unpack
	pop	bc
	pop	bc
	ld	hl,_levels
	push	hl
	ld	hl,(_level)
	ld	h,0
	add	hl,hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	add	hl,hl
	add	hl,bc
	pop	de
	add	hl,de
	ld	bc,8
	add	hl,bc
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_tileset
	push	hl
	call	_unpack
	pop	bc
	pop	bc
	ld	hl,_levels
	push	hl
	ld	hl,(_level)
	ld	h,0
	add	hl,hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	add	hl,hl
	add	hl,bc
	pop	de
	add	hl,de
	ld	bc,10
	add	hl,bc
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_malotes
	push	hl
	call	_unpack
	pop	bc
	pop	bc
	ld	hl,_levels
	push	hl
	ld	hl,(_level)
	ld	h,0
	add	hl,hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	add	hl,hl
	add	hl,bc
	pop	de
	add	hl,de
	ld	bc,12
	add	hl,bc
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_behs
	push	hl
	call	_unpack
	pop	bc
	pop	bc
	ld	hl,_level_data
	push	hl
	ld	hl,_levels
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	hl,_level_data+1
	push	hl
	ld	hl,_levels+1
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	a,(_warp_to_level)
	and	a
	jp	nz,i_56
	ld	hl,_levels
	push	hl
	ld	hl,(_level)
	ld	h,0
	add	hl,hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	add	hl,hl
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_n_pant),a
	ld	hl,_levels
	push	hl
	ld	hl,(_level)
	ld	h,0
	add	hl,hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	add	hl,hl
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	inc	hl
	ld	e,(hl)
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	h,0
	ld	a,l
	ld	(_gpx),a
	ld	e,a
	ld	d,0
	ld	l,#(6 % 256)
	call	l_asl
	ld	(_p_x),hl
	ld	hl,_levels
	push	hl
	ld	hl,(_level)
	ld	h,0
	add	hl,hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	add	hl,hl
	add	hl,bc
	pop	de
	add	hl,de
	ld	bc,4
	add	hl,bc
	ld	e,(hl)
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	h,0
	ld	a,l
	ld	(_gpy),a
	ld	e,a
	ld	d,0
	ld	l,#(6 % 256)
	call	l_asl
	ld	(_p_y),hl
.i_56
	ret


;	SECTION	text

._player_cells
	defw	_sprite_1_a
	defw	_sprite_2_a
	defw	_sprite_3_a
	defw	_sprite_4_a
	defw	_sprite_5_a
	defw	_sprite_6_a
	defw	_sprite_7_a
	defw	_sprite_8_a

;	SECTION	code

;	SECTION	text

._enem_cells
	defw	_sprite_9_a
	defw	_sprite_10_a
	defw	_sprite_11_a
	defw	_sprite_12_a
	defw	_sprite_13_a
	defw	_sprite_14_a
	defw	_sprite_15_a
	defw	_sprite_16_a

;	SECTION	code


._lame_sound
	ld	hl,4 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_61
	ld	hl,(_rda)
	ld	h,0
	push	hl
	call	_beep_fx
	pop	bc
	ld	hl,(_rdb)
	ld	h,0
	push	hl
	call	_beep_fx
	pop	bc
.i_59
	ld	hl,(_gpit)
	ld	h,0
	dec	hl
	ld	a,l
	ld	(_gpit),a
	ld	a,h
	or	l
	jp	nz,i_61
.i_60
	ld	hl,9 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
	ret



._game_ending
	call	sp_UpdateNow
	call	_blackout
	ld hl, _s_ending
	ld de, 16384
	call depack
	ld	a,#(7 % 256 % 256)
	ld	(_rda),a
	ld	hl,2 % 256	;const
	ld	a,l
	ld	(_rdb),a
	call	_lame_sound
	ld	a,#(7 % 256 % 256)
	ld	(__x),a
	ld	a,#(7 % 256 % 256)
	ld	(__y),a
	ld	a,#(70 % 256 % 256)
	ld	(__t),a
	ld	hl,i_1+22
	ld	(__gp_gen),hl
	call	_print_str
	ld	a,#(1 % 256 % 256)
	ld	(__x),a
	ld	a,#(9 % 256 % 256)
	ld	(__y),a
	ld	a,#(71 % 256 % 256)
	ld	(__t),a
	ld	hl,i_1+39
	ld	(__gp_gen),hl
	call	_print_str
	ld	a,#(3 % 256 % 256)
	ld	(__x),a
	ld	a,#(10 % 256 % 256)
	ld	(__y),a
	ld	hl,i_1+69
	ld	(__gp_gen),hl
	call	_print_str
	ld	a,#(4 % 256 % 256)
	ld	(__x),a
	ld	a,#(11 % 256 % 256)
	ld	(__y),a
	ld	hl,i_1+94
	ld	(__gp_gen),hl
	call	_print_str
	ld	hl,500	;const
	push	hl
	call	_espera_activa
	pop	bc
	ret



._game_over
	ld	a,#(10 % 256 % 256)
	ld	(__x),a
	ld	a,#(11 % 256 % 256)
	ld	(__y),a
	ld	a,#(79 % 256 % 256)
	ld	(__t),a
	ld	hl,(_spacer)
	ld	(__gp_gen),hl
	call	_print_str
	ld	a,#(10 % 256 % 256)
	ld	(__x),a
	ld	a,#(12 % 256 % 256)
	ld	(__y),a
	ld	a,#(79 % 256 % 256)
	ld	(__t),a
	ld	hl,i_1+117
	ld	(__gp_gen),hl
	call	_print_str
	ld	a,#(10 % 256 % 256)
	ld	(__x),a
	ld	a,#(13 % 256 % 256)
	ld	(__y),a
	ld	a,#(79 % 256 % 256)
	ld	(__t),a
	ld	hl,(_spacer)
	ld	(__gp_gen),hl
	call	_print_str
	call	sp_UpdateNow
	ld	a,#(7 % 256 % 256)
	ld	(_rda),a
	ld	hl,2 % 256	;const
	ld	a,l
	ld	(_rdb),a
	call	_lame_sound
	ld	hl,500	;const
	push	hl
	call	_espera_activa
	pop	bc
	ret



._zone_clear
	ld	a,#(10 % 256 % 256)
	ld	(__x),a
	ld	a,#(11 % 256 % 256)
	ld	(__y),a
	ld	a,#(79 % 256 % 256)
	ld	(__t),a
	ld	hl,(_spacer)
	ld	(__gp_gen),hl
	call	_print_str
	ld	a,#(10 % 256 % 256)
	ld	(__x),a
	ld	a,#(12 % 256 % 256)
	ld	(__y),a
	ld	a,#(79 % 256 % 256)
	ld	(__t),a
	ld	hl,i_1+130
	ld	(__gp_gen),hl
	call	_print_str
	ld	a,#(10 % 256 % 256)
	ld	(__x),a
	ld	a,#(13 % 256 % 256)
	ld	(__y),a
	ld	a,#(79 % 256 % 256)
	ld	(__t),a
	ld	hl,(_spacer)
	ld	(__gp_gen),hl
	call	_print_str
	ld	hl,0 % 256	;const
	push	hl
	call	sp_UpdateNowEx
	pop	bc
	ld	hl,250	;const
	push	hl
	call	_espera_activa
	pop	bc
	ret



._addsign
	ld	hl,4	;const
	add	hl,sp
	call	l_gint	;
	xor	a
	or	h
	jp	m,i_62
	pop	bc
	pop	hl
	push	hl
	push	bc
	ret


.i_62
	pop	bc
	pop	hl
	push	hl
	push	bc
	call	l_neg
	ret


.i_63
	ret



._espera_activa
.i_64
	call	sp_GetKey
	ld	a,h
	or	l
	jp	nz,i_64
.i_65
.i_68
	ld	hl,250 % 256	;const
	ld	a,l
	ld	(_gpjt),a
.i_71
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_69
	ld	hl,(_gpjt)
	ld	h,0
	dec	hl
	ld	a,l
	ld	(_gpjt),a
	ld	a,h
	or	l
	jp	nz,i_71
.i_70
	call	sp_GetKey
	ld	a,h
	or	l
	jp	nz,i_67
.i_72
.i_66
	pop	de
	pop	hl
	dec	hl
	push	hl
	push	de
	ld	a,h
	or	l
	jp	nz,i_68
.i_67
	ret



._process_tile
	ld	hl,_pad0
	ld	a,(hl)
	rlca
	jp	c,i_73
	ld	a,#(1 % 256 % 256)
	ld	(_p_disparando),a
	ld	hl,(_x0)
	ld	h,0
	push	hl
	ld	hl,(_y0)
	ld	h,0
	push	hl
	call	_qtile
	pop	bc
	pop	bc
	ld	de,14	;const
	ex	de,hl
	call	l_eq
	jp	nc,i_75
	ld	hl,(_x1)
	ld	h,0
	push	hl
	ld	hl,(_y1)
	ld	h,0
	push	hl
	call	_attr
	pop	bc
	pop	bc
	ld	de,0	;const
	ex	de,hl
	call	l_eq
	jp	nc,i_75
	ld	a,(_x1)
	cp	#(15 % 256)
	jp	z,i_75
	jp	nc,i_75
	ld	a,(_y1)
	cp	#(10 % 256)
	jp	z,i_75
	jr	c,i_76_i_75
.i_75
	jp	i_74
.i_76_i_75
	ld	hl,_map_buff
	push	hl
	ld	hl,(_x1)
	ld	h,0
	push	hl
	ld	a,(_y1)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	pop	de
	add	hl,de
	ex	de,hl
	ld	hl,(_y1)
	ld	h,0
	ex	de,hl
	and	a
	sbc	hl,de
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_rda),a
	ld	hl,(_x0)
	ld	h,0
	ld	a,l
	ld	(__x),a
	ld	hl,(_y0)
	ld	h,0
	ld	a,l
	ld	(__y),a
	ld	a,#(0 % 256 % 256)
	ld	(__t),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(__n),a
	call	_update_tile
	ld	hl,(_x1)
	ld	h,0
	ld	a,l
	ld	(__x),a
	ld	hl,(_y1)
	ld	h,0
	ld	a,l
	ld	(__y),a
	ld	a,#(14 % 256 % 256)
	ld	(__t),a
	ld	hl,10 % 256	;const
	ld	a,l
	ld	(__n),a
	call	_update_tile
	ld	hl,2 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
.i_74
.i_73
	ld	hl,(_x0)
	ld	h,0
	push	hl
	ld	hl,(_y0)
	ld	h,0
	push	hl
	call	_qtile
	pop	bc
	pop	bc
	ld	de,15	;const
	ex	de,hl
	call	l_eq
	jp	nc,i_78
	ld	a,(_p_keys)
	and	a
	jr	nz,i_79_i_78
.i_78
	jp	i_77
.i_79_i_78
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_82
.i_80
	ld	hl,(_gpit)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_gpit),a
.i_82
	ld	a,(_gpit)
	cp	#(32 % 256)
	jp	z,i_81
	jp	nc,i_81
	ld	hl,_cerrojos
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	inc	hl
	ld	a,(_x0)
	cp	(hl)
	jp	nz,i_84
	ld	hl,_cerrojos
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	ld	a,(_y0)
	cp	(hl)
	jp	nz,i_84
	ld	hl,_cerrojos
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	a,(_n_pant)
	cp	(hl)
	jr	z,i_85_i_84
.i_84
	jp	i_83
.i_85_i_84
	ld	hl,_cerrojos
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	inc	hl
	ld	(hl),#(0 % 256 % 256)
	ld	l,(hl)
	ld	h,0
	jp	i_81
.i_83
	jp	i_80
.i_81
	ld	hl,(_x0)
	ld	h,0
	ld	a,l
	ld	(__x),a
	ld	hl,(_y0)
	ld	h,0
	ld	a,l
	ld	(__y),a
	ld	a,#(0 % 256 % 256)
	ld	(__t),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(__n),a
	call	_update_tile
	ld	hl,(_p_keys)
	ld	h,0
	dec	hl
	ld	a,l
	ld	(_p_keys),a
	ld	hl,8 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
.i_77
	ret



._draw_scr_background
	ld	hl,_mapa
	push	hl
	ld	hl,(_n_pant)
	ld	h,0
	ld	de,75
	call	l_mult
	pop	de
	add	hl,de
	ld	(_map_pointer),hl
	ld	hl,(_n_pant)
	ld	h,0
	ld	(_seed),hl
	ld	a,#(1 % 256 % 256)
	ld	(__x),a
	ld	a,#(1 % 256 % 256)
	ld	(__y),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_88
.i_86
	ld	hl,(_gpit)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_gpit),a
.i_88
	ld	a,(_gpit)
	ld	e,a
	ld	d,0
	ld	hl,150	;const
	call	l_ult
	jp	nc,i_87
	ld a, (_gpit)
	and 1
	jr nz, _draw_scr_packed_existing
	._draw_scr_packed_new
	ld hl, (_map_pointer)
	ld a, (hl)
	ld (_gpc), a
	inc hl
	ld (_map_pointer), hl
	srl a
	srl a
	srl a
	srl a
	jr _draw_scr_packed_done
	._draw_scr_packed_existing
	ld a, (_gpc)
	and 15
	._draw_scr_packed_done
	ld (__t), a
	ld b, 0
	ld c, a
	ld hl, _behs
	add hl, bc
	ld a, (hl)
	ld bc, (_gpit)
	ld b, 0
	ld hl, _map_attr
	add hl, bc
	ld (hl), a
	ld a, (__t)
	or a
	jr nz, _draw_scr_packed_noalt
	._draw_scr_packed_alt
	call _rand
	ld a, l
	and 15
	cp 1
	jr z, _draw_scr_packed_alt_subst
	ld a, (__t)
	jr _draw_scr_packed_noalt
	._draw_scr_packed_alt_subst
	ld a, 19
	ld (__t), a
	._draw_scr_packed_noalt
	ld hl, _map_buff
	add hl, bc
	ld (hl), a
	ld hl, _brk_buff
	add hl, bc
	xor a
	ld (hl), a
	call	_draw_coloured_tile
	ld a, (__x)
	add 2
	cp 30 + 1
	jr c, _advance_worm_no_inc_y
	ld a, (__y)
	add 2
	ld (__y), a
	ld a, 1
	._advance_worm_no_inc_y
	ld (__x), a
	jp	i_86
.i_87
	ret



._draw_scr
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_is_rendering),a
	call	_draw_scr_background
	call	_enems_load
	ld	a,(_flags+1)
	and	a
	jp	z,i_89
	ld	hl,i_1+143
	ld	(__gp_gen),hl
	jp	i_90
.i_89
	ld	hl,i_1+174
	ld	(__gp_gen),hl
.i_90
	ld	a,#(1 % 256 % 256)
	ld	(__x),a
	ld	a,#(0 % 256 % 256)
	ld	(__y),a
	ld	hl,71 % 256	;const
	ld	a,l
	ld	(__t),a
	call	_print_str
	ld	a,(_n_pant)
	and	a
	jp	nz,i_91
	ld	hl,_decos_computer
	ld	(__gp_gen),hl
	call	_draw_decorations
	ld	a,(_flags+1)
	and	a
	jp	z,i_92
	ld	hl,_decos_bombs
	ld	(__gp_gen),hl
	call	_draw_decorations
	jp	i_93
.i_92
	ld	hl,i_1+204
	ld	(__gp_gen),hl
	ld	a,#(1 % 256 % 256)
	ld	(__x),a
	ld	a,#(0 % 256 % 256)
	ld	(__y),a
	ld	hl,71 % 256	;const
	ld	a,l
	ld	(__t),a
	call	_print_str
.i_93
.i_91
	ld	a,(_n_pant)
	cp	#(21 % 256)
	jp	nz,i_95
	ld	a,(_level)
	cp	#(0 % 256)
	jr	z,i_96_i_95
.i_95
	jp	i_94
.i_96_i_95
	ld	hl,_decos_moto
	ld	(__gp_gen),hl
	call	_draw_decorations
	ld	hl,_flags
	ld	(hl),#(1 % 256 % 256)
.i_94
	ld	a,(_n_pant)
	cp	#(23 % 256)
	jp	nz,i_98
	ld	a,(_flags+1)
	and	a
	jr	nz,i_99_i_98
.i_98
	jp	i_97
.i_99_i_98
	ld	hl,0 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
	ld	a,#(1 % 256 % 256)
	ld	(_success),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_playing),a
.i_97
	ld a, 240
	ld (_hotspot_y), a
	ld a, (_n_pant)
	ld b, a
	sla a
	add b
	ld c, a
	ld b, 0
	ld hl, _hotspots
	add hl, bc
	ld a, (hl)
	ld b, a
	srl a
	srl a
	srl a
	srl a
	ld (__x), a
	ld a, b
	and 15
	ld (__y), a
	inc hl
	ld b, (hl)
	inc hl
	ld c, (hl)
	xor a
	or b
	jr z, _hotspots_setup_done
	xor a
	or c
	jr z, _hotspots_setup_done
	._hotspots_setup_do
	ld a, (__x)
	ld e, a
	sla a
	sla a
	sla a
	sla a
	ld (_hotspot_x), a
	ld a, (__y)
	ld d, a
	sla a
	sla a
	sla a
	sla a
	ld (_hotspot_y), a
	sub d
	add e
	ld e, a
	ld d, 0
	ld hl, _map_buff
	add hl, de
	ld a, (hl)
	ld (_orig_tile), a
	ld a, b
	cp 3
	jp nz, _hotspots_setup_set
	._hotspots_setup_set_refill
	xor a
	._hotspots_setup_set
	add 16
	ld (__t), a
	call _draw_coloured_tile_gamearea
	._hotspots_setup_done
	ld hl, _cerrojos
	ld b, 32
	._open_locks_loop
	push bc
	ld a, (_n_pant)
	ld c, a
	ld b, (hl)
	inc hl
	ld d, (hl)
	inc hl
	ld e, (hl)
	inc hl
	ld a, (hl)
	inc hl
	or a
	jr nz, _open_locks_done
	ld a, b
	cp c
	jr nz, _open_locks_done
	._open_locks_do
	ld a, d
	ld (__x), a
	ld a, e
	ld (__y), a
	sla a
	sla a
	sla a
	sla a
	sub e
	add d
	ld b, 0
	ld c, a
	xor a
	push hl
	ld hl, _map_attr
	add hl, bc
	ld (hl), a
	ld hl, _map_buff
	add hl, bc
	ld (hl), a
	ld (__t), a
	call _draw_coloured_tile_gamearea
	pop hl
	._open_locks_done
	pop bc
	dec b
	jr nz, _open_locks_loop
	call	_bullets_init
	call	_simple_coco_init
	call	_invalidate_viewport
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_is_rendering),a
	ret



._select_joyfunc
	; Music generated by beepola
	call musicstart
.i_100
	call	sp_GetKey
	ld	h,0
	ld	a,l
	ld	(_gpjt),a
	cp	#(49 % 256)
	jr	z,i_103_uge
	jp	c,i_103
.i_103_uge
	ld	a,(_gpjt)
	cp	#(51 % 256)
	jr	z,i_104_i_103
	jr	c,i_104_i_103
.i_103
	jp	i_102
.i_104_i_103
	ld	hl,_joyfuncs
	push	hl
	ld	hl,(_gpjt)
	ld	h,0
	ld	bc,-49
	add	hl,bc
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	ld	(_joyfunc),hl
	jp	i_101
.i_102
	jp	i_100
.i_101
	ret



._mons_col_sc_x
	ld	hl,__en_mx
	call	l_gchar
	ld	de,0	;const
	ex	de,hl
	call	l_gt
	jp	nc,i_105
	ld	hl,(__en_x)
	ld	h,0
	ld	bc,15
	add	hl,bc
	jp	i_106
.i_105
	ld	hl,(__en_x)
	ld	h,0
.i_106
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_cx2),a
	ld	h,0
	ld	a,l
	ld	(_cx1),a
	ld	a,(__en_y)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_cy1),a
	ld	hl,(__en_y)
	ld	h,0
	ld	bc,15
	add	hl,bc
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_cy2),a
	call	_cm_two_points
	ld	a,(_at1)
	and	a
	jp	nz,i_107
	ld	a,(_at2)
	and	a
	jp	nz,i_107
	ld	hl,0	;const
	jr	i_108
.i_107
	ld	hl,1	;const
.i_108
	ld	h,0
	ret



._mons_col_sc_y
	ld	hl,__en_my
	call	l_gchar
	ld	de,0	;const
	ex	de,hl
	call	l_gt
	jp	nc,i_109
	ld	hl,(__en_y)
	ld	h,0
	ld	bc,15
	add	hl,bc
	jp	i_110
.i_109
	ld	hl,(__en_y)
	ld	h,0
.i_110
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_cy2),a
	ld	h,0
	ld	a,l
	ld	(_cy1),a
	ld	a,(__en_x)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_cx1),a
	ld	hl,(__en_x)
	ld	h,0
	ld	bc,15
	add	hl,bc
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_cx2),a
	call	_cm_two_points
	ld	a,(_at1)
	and	a
	jp	nz,i_111
	ld	a,(_at2)
	and	a
	jp	nz,i_111
	ld	hl,0	;const
	jr	i_112
.i_111
	ld	hl,1	;const
.i_112
	ld	h,0
	ret



._player_init
	ld	hl,0	;const
	ld	(_p_vy),hl
	ld	(_p_vx),hl
	ld	a,#(1 % 256 % 256)
	ld	(_p_cont_salto),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_saltando),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_frame),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_subframe),a
	ld	a,#(6 % 256 % 256)
	ld	(_p_facing),a
	ld	hl,255 % 256	;const
	ld	a,l
	ld	(_p_facing_h),a
	ld	h,0
	ld	a,l
	ld	(_p_facing_v),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_estado),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_ct_estado),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_objs),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_keys),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_killed),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_disparando),a
	ld	hl,99 % 256	;const
	ld	a,l
	ld	(_p_ammo),a
	ret



._player_calc_bounding_box
	ld a, (_gpx)
	add 4
	srl a
	srl a
	srl a
	srl a
	ld (_ptx1), a
	ld a, (_gpx)
	add 11
	srl a
	srl a
	srl a
	srl a
	ld (_ptx2), a
	ld a, (_gpy)
	add 8
	srl a
	srl a
	srl a
	srl a
	ld (_pty1), a
	ld a, (_gpy)
	add 15
	srl a
	srl a
	srl a
	srl a
	ld (_pty2), a
	ret



._player_move
	ld	a,(_pad0)
	ld	e,a
	ld	d,0
	ld	hl,1	;const
	call	l_and
	ld	de,0	;const
	ex	de,hl
	call	l_eq
	jp	c,i_114
	ld	a,(_pad0)
	ld	e,a
	ld	d,0
	ld	hl,2	;const
	call	l_and
	ld	de,0	;const
	ex	de,hl
	call	l_eq
	jp	c,i_114
	ld	hl,0	;const
	jr	i_115
.i_114
	ld	hl,1	;const
.i_115
	call	l_lneg
	jp	nc,i_113
	ld	a,#(255 % 256 % 256)
	ld	(_p_facing_v),a
	ld	a,#(0 % 256 % 256)
	ld	(_wall_v),a
	ld	hl,(_p_vy)
	xor	a
	or	h
	jp	m,i_116
	or	l
	jp	z,i_116
	ld	hl,(_p_vy)
	ld	bc,-64
	add	hl,bc
	ld	(_p_vy),hl
	xor	a
	or	h
	jp	p,i_117
	ld	hl,0	;const
	ld	(_p_vy),hl
.i_117
	jp	i_118
.i_116
	ld	hl,(_p_vy)
	xor	a
	or	h
	jp	p,i_119
	ld	hl,(_p_vy)
	ld	bc,64
	add	hl,bc
	ld	(_p_vy),hl
	xor	a
	or	h
	jp	m,i_120
	or	l
	jp	z,i_120
	ld	hl,0	;const
	ld	(_p_vy),hl
.i_120
.i_119
.i_118
.i_113
	ld	hl,_pad0
	ld	a,(hl)
	rrca
	jp	c,i_121
	ld	a,#(4 % 256 % 256)
	ld	(_p_facing_v),a
	ld	hl,(_p_vy)
	ld	de,65280	;const
	ex	de,hl
	call	l_gt
	jp	nc,i_122
	ld	hl,(_p_vy)
	ld	bc,-48
	add	hl,bc
	ld	(_p_vy),hl
.i_122
.i_121
	ld	hl,_pad0
	ld	a,(hl)
	and	#(2 % 256)
	jp	nz,i_123
	ld	a,#(6 % 256 % 256)
	ld	(_p_facing_v),a
	ld	hl,(_p_vy)
	ld	de,256	;const
	ex	de,hl
	call	l_lt
	jp	nc,i_124
	ld	hl,(_p_vy)
	ld	bc,48
	add	hl,bc
	ld	(_p_vy),hl
.i_124
.i_123
	ld	de,(_p_y)
	ld	hl,(_p_vy)
	add	hl,de
	ld	(_p_y),hl
	xor	a
	or	h
	jp	p,i_125
	ld	hl,0	;const
	ld	(_p_y),hl
.i_125
	ld	hl,(_p_y)
	ld	de,9216	;const
	ex	de,hl
	call	l_gt
	jp	nc,i_126
	ld	hl,9216	;const
	ld	(_p_y),hl
.i_126
	ld	hl,(_p_y)
	ex	de,hl
	ld	l,#(6 % 256)
	call	l_asr
	ld	h,0
	ld	a,l
	ld	(_gpy),a
	call	_player_calc_bounding_box
	ld	a,#(0 % 256 % 256)
	ld	(_hit_v),a
	ld	hl,(_ptx1)
	ld	h,0
	ld	a,l
	ld	(_cx1),a
	ld	hl,(_ptx2)
	ld	h,0
	ld	a,l
	ld	(_cx2),a
	ld	hl,(_p_vy)
	xor	a
	or	h
	jp	p,i_127
	ld	hl,(_pty1)
	ld	h,0
	ld	a,l
	ld	(_cy2),a
	ld	h,0
	ld	a,l
	ld	(_cy1),a
	call	_cm_two_points
	ld	hl,_at1
	ld	a,(hl)
	and	#(8 % 256)
	jp	nz,i_129
	ld	hl,_at2
	ld	a,(hl)
	and	#(8 % 256)
	jp	z,i_128
.i_129
	ld	hl,0	;const
	ld	(_p_vy),hl
	ld	hl,(_pty1)
	ld	h,0
	inc	hl
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asl
	ld	bc,-8
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_gpy),a
	ld	e,a
	ld	d,0
	ld	l,#(6 % 256)
	call	l_asl
	ld	(_p_y),hl
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_wall_v),a
.i_128
.i_127
	ld	hl,(_p_vy)
	xor	a
	or	h
	jp	m,i_131
	or	l
	jp	z,i_131
	ld	hl,(_pty2)
	ld	h,0
	ld	a,l
	ld	(_cy2),a
	ld	h,0
	ld	a,l
	ld	(_cy1),a
	call	_cm_two_points
	ld	hl,_at1
	ld	a,(hl)
	and	#(8 % 256)
	jp	nz,i_133
	ld	hl,_at2
	ld	a,(hl)
	and	#(8 % 256)
	jp	z,i_132
.i_133
	ld	hl,0	;const
	ld	(_p_vy),hl
	ld	hl,(_pty2)
	ld	h,0
	dec	hl
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asl
	ld	h,0
	ld	a,l
	ld	(_gpy),a
	ld	e,a
	ld	d,0
	ld	l,#(6 % 256)
	call	l_asl
	ld	(_p_y),hl
	ld	hl,2 % 256	;const
	ld	a,l
	ld	(_wall_v),a
.i_132
.i_131
	ld	hl,(_p_vy)
	ld	a,h
	or	l
	jp	z,i_135
	ld	hl,_at1
	ld	a,(hl)
	rrca
	jp	c,i_136
	ld	hl,_at2
	ld	a,(hl)
	rrca
	jp	c,i_136
	ld	hl,0	;const
	jr	i_137
.i_136
	ld	hl,1	;const
.i_137
	ld	h,0
	ld	a,l
	ld	(_hit_v),a
.i_135
	ld	a,(_gpx)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_gpxx),a
	ld	a,(_gpy)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_gpyy),a
	ld	a,(_pad0)
	ld	e,a
	ld	d,0
	ld	hl,4	;const
	call	l_and
	ld	de,0	;const
	ex	de,hl
	call	l_eq
	jp	c,i_139
	ld	a,(_pad0)
	ld	e,a
	ld	d,0
	ld	hl,8	;const
	call	l_and
	ld	de,0	;const
	ex	de,hl
	call	l_eq
	jp	c,i_139
	ld	hl,0	;const
	jr	i_140
.i_139
	ld	hl,1	;const
.i_140
	call	l_lneg
	jp	nc,i_138
	ld	a,#(255 % 256 % 256)
	ld	(_p_facing_h),a
	ld	hl,(_p_vx)
	xor	a
	or	h
	jp	m,i_141
	or	l
	jp	z,i_141
	ld	hl,(_p_vx)
	ld	bc,-64
	add	hl,bc
	ld	(_p_vx),hl
	xor	a
	or	h
	jp	p,i_142
	ld	hl,0	;const
	ld	(_p_vx),hl
.i_142
	jp	i_143
.i_141
	ld	hl,(_p_vx)
	xor	a
	or	h
	jp	p,i_144
	ld	hl,(_p_vx)
	ld	bc,64
	add	hl,bc
	ld	(_p_vx),hl
	xor	a
	or	h
	jp	m,i_145
	or	l
	jp	z,i_145
	ld	hl,0	;const
	ld	(_p_vx),hl
.i_145
.i_144
.i_143
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_wall_h),a
.i_138
	ld	hl,_pad0
	ld	a,(hl)
	and	#(4 % 256)
	jp	nz,i_146
	ld	a,#(2 % 256 % 256)
	ld	(_p_facing_h),a
	ld	hl,(_p_vx)
	ld	de,65280	;const
	ex	de,hl
	call	l_gt
	jp	nc,i_147
	ld	hl,(_p_vx)
	ld	bc,-48
	add	hl,bc
	ld	(_p_vx),hl
.i_147
.i_146
	ld	hl,_pad0
	ld	a,(hl)
	and	#(8 % 256)
	jp	nz,i_148
	ld	a,#(0 % 256 % 256)
	ld	(_p_facing_h),a
	ld	hl,(_p_vx)
	ld	de,256	;const
	ex	de,hl
	call	l_lt
	jp	nc,i_149
	ld	hl,(_p_vx)
	ld	bc,48
	add	hl,bc
	ld	(_p_vx),hl
.i_149
.i_148
	ld	de,(_p_x)
	ld	hl,(_p_vx)
	add	hl,de
	ld	(_p_x),hl
	xor	a
	or	h
	jp	p,i_150
	ld	hl,0	;const
	ld	(_p_x),hl
.i_150
	ld	hl,(_p_x)
	ld	de,14336	;const
	ex	de,hl
	call	l_gt
	jp	nc,i_151
	ld	hl,14336	;const
	ld	(_p_x),hl
.i_151
	ld	hl,(_gpx)
	ld	h,0
	ld	a,l
	ld	(_gpox),a
	ld	hl,(_p_x)
	ex	de,hl
	ld	l,#(6 % 256)
	call	l_asr
	ld	h,0
	ld	a,l
	ld	(_gpx),a
	call	_player_calc_bounding_box
	ld	a,#(0 % 256 % 256)
	ld	(_hit_h),a
	ld	hl,(_pty1)
	ld	h,0
	ld	a,l
	ld	(_cy1),a
	ld	hl,(_pty2)
	ld	h,0
	ld	a,l
	ld	(_cy2),a
	ld	hl,(_p_vx)
	xor	a
	or	h
	jp	p,i_152
	ld	hl,(_ptx1)
	ld	h,0
	ld	a,l
	ld	(_cx2),a
	ld	h,0
	ld	a,l
	ld	(_cx1),a
	call	_cm_two_points
	ld	hl,_at1
	ld	a,(hl)
	and	#(8 % 256)
	jp	nz,i_154
	ld	hl,_at2
	ld	a,(hl)
	and	#(8 % 256)
	jp	z,i_153
.i_154
	ld	hl,0	;const
	ld	(_p_vx),hl
	ld	hl,(_ptx1)
	ld	h,0
	inc	hl
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asl
	ld	bc,-4
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_gpx),a
	ld	e,a
	ld	d,0
	ld	l,#(6 % 256)
	call	l_asl
	ld	(_p_x),hl
	ld	hl,3 % 256	;const
	ld	a,l
	ld	(_wall_h),a
	jp	i_156
.i_153
	ld	hl,_at1
	ld	a,(hl)
	rrca
	jp	c,i_157
	ld	hl,_at2
	ld	a,(hl)
	rrca
	jp	c,i_157
	ld	hl,0	;const
	jr	i_158
.i_157
	ld	hl,1	;const
.i_158
	ld	h,0
	ld	a,l
	ld	(_hit_h),a
.i_156
.i_152
	ld	hl,(_p_vx)
	xor	a
	or	h
	jp	m,i_159
	or	l
	jp	z,i_159
	ld	hl,(_ptx2)
	ld	h,0
	ld	a,l
	ld	(_cx2),a
	ld	h,0
	ld	a,l
	ld	(_cx1),a
	call	_cm_two_points
	ld	hl,_at1
	ld	a,(hl)
	and	#(8 % 256)
	jp	nz,i_161
	ld	hl,_at2
	ld	a,(hl)
	and	#(8 % 256)
	jp	z,i_160
.i_161
	ld	hl,0	;const
	ld	(_p_vx),hl
	ld	a,(_ptx1)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	bc,4
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_gpx),a
	ld	e,a
	ld	d,0
	ld	l,#(6 % 256)
	call	l_asl
	ld	(_p_x),hl
	ld	hl,4 % 256	;const
	ld	a,l
	ld	(_wall_h),a
	jp	i_163
.i_160
	ld	hl,_at1
	ld	a,(hl)
	rrca
	jp	c,i_164
	ld	hl,_at2
	ld	a,(hl)
	rrca
	jp	c,i_164
	ld	hl,0	;const
	jr	i_165
.i_164
	ld	hl,1	;const
.i_165
	ld	h,0
	ld	a,l
	ld	(_hit_h),a
.i_163
.i_159
	ld	a,(_p_facing_v)
	cp	#(255 % 256)
	jp	z,i_166
	ld	hl,(_p_facing_v)
	ld	h,0
	ld	a,l
	ld	(_p_facing),a
	jp	i_167
.i_166
	ld	a,(_p_facing_h)
	cp	#(255 % 256)
	jp	z,i_168
	ld	hl,(_p_facing_h)
	ld	h,0
	ld	a,l
	ld	(_p_facing),a
.i_168
.i_167
	ld	hl,(_gpx)
	ld	h,0
	ld	bc,8
	add	hl,bc
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_p_tx),a
	ld	h,0
	ld	a,l
	ld	(_cx1),a
	ld	hl,(_gpy)
	ld	h,0
	ld	bc,8
	add	hl,bc
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_p_ty),a
	ld	h,0
	ld	a,l
	ld	(_cy1),a
	ld	hl,(_cx1)
	ld	h,0
	push	hl
	ld	hl,(_cy1)
	ld	h,0
	push	hl
	call	_attr
	pop	bc
	pop	bc
	ld	h,0
	ld	a,l
	ld	(_rdb),a
	ld	hl,_rdb
	ld	a,(hl)
	rlca
	jp	nc,i_169
.i_169
	ld	a,(_wall_v)
	cp	#(1 % 256)
	jp	nz,i_170
	ld	hl,(_gpy)
	ld	h,0
	ld	bc,7
	add	hl,bc
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_cy1),a
	ld	hl,(_cx1)
	ld	h,0
	push	hl
	ld	hl,(_cy1)
	ld	h,0
	push	hl
	call	_attr
	pop	bc
	pop	bc
	ld	de,10	;const
	ex	de,hl
	call	l_eq
	jp	nc,i_171
	ld	hl,(_cx1)
	ld	h,0
	ld	a,l
	ld	(_x1),a
	ld	h,0
	ld	a,l
	ld	(_x0),a
	ld	hl,(_cy1)
	ld	h,0
	ld	a,l
	ld	(_y0),a
	ld	hl,(_cy1)
	ld	h,0
	dec	hl
	ld	h,0
	ld	a,l
	ld	(_y1),a
	call	_process_tile
.i_171
	jp	i_172
.i_170
	ld	a,(_wall_v)
	cp	#(2 % 256)
	jp	nz,i_173
	ld	hl,(_gpy)
	ld	h,0
	ld	bc,16
	add	hl,bc
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_cy1),a
	ld	hl,(_cx1)
	ld	h,0
	push	hl
	ld	hl,(_cy1)
	ld	h,0
	push	hl
	call	_attr
	pop	bc
	pop	bc
	ld	de,10	;const
	ex	de,hl
	call	l_eq
	jp	nc,i_174
	ld	hl,(_cx1)
	ld	h,0
	ld	a,l
	ld	(_x1),a
	ld	h,0
	ld	a,l
	ld	(_x0),a
	ld	hl,(_cy1)
	ld	h,0
	ld	a,l
	ld	(_y0),a
	ld	hl,(_cy1)
	ld	h,0
	inc	hl
	ld	h,0
	ld	a,l
	ld	(_y1),a
	call	_process_tile
.i_174
	jp	i_175
.i_173
	ld	a,(_wall_h)
	cp	#(3 % 256)
	jp	nz,i_176
	ld	hl,(_gpx)
	ld	h,0
	inc	hl
	inc	hl
	inc	hl
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_cx1),a
	ld	hl,(_cx1)
	ld	h,0
	push	hl
	ld	hl,(_cy1)
	ld	h,0
	push	hl
	call	_attr
	pop	bc
	pop	bc
	ld	de,10	;const
	ex	de,hl
	call	l_eq
	jp	nc,i_177
	ld	hl,(_cy1)
	ld	h,0
	ld	a,l
	ld	(_y1),a
	ld	h,0
	ld	a,l
	ld	(_y0),a
	ld	hl,(_cx1)
	ld	h,0
	ld	a,l
	ld	(_x0),a
	ld	hl,(_cx1)
	ld	h,0
	dec	hl
	ld	h,0
	ld	a,l
	ld	(_x1),a
	call	_process_tile
.i_177
	jp	i_178
.i_176
	ld	a,(_wall_h)
	cp	#(4 % 256)
	jp	nz,i_179
	ld	hl,(_gpx)
	ld	h,0
	ld	bc,12
	add	hl,bc
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_cx1),a
	ld	hl,(_cx1)
	ld	h,0
	push	hl
	ld	hl,(_cy1)
	ld	h,0
	push	hl
	call	_attr
	pop	bc
	pop	bc
	ld	de,10	;const
	ex	de,hl
	call	l_eq
	jp	nc,i_180
	ld	hl,(_cy1)
	ld	h,0
	ld	a,l
	ld	(_y1),a
	ld	h,0
	ld	a,l
	ld	(_y0),a
	ld	hl,(_cx1)
	ld	h,0
	ld	a,l
	ld	(_x0),a
	ld	hl,(_cx1)
	ld	h,0
	inc	hl
	ld	h,0
	ld	a,l
	ld	(_x1),a
	call	_process_tile
.i_180
.i_179
.i_178
.i_175
.i_172
	ld	hl,_pad0
	ld	a,(hl)
	and	#(128 % 256)
	cp	#(0 % 256)
	ld	hl,0
	jp	nz,i_182
	inc	hl
	ld	a,(_p_disparando)
	cp	#(0 % 256)
	jr	z,i_183_i_182
.i_182
	jp	i_181
.i_183_i_182
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_p_disparando),a
	call	_bullets_fire
.i_181
	ld	hl,_pad0
	ld	a,(hl)
	rlca
	jp	nc,i_184
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_p_disparando),a
.i_184
	ld	a,#(0 % 256 % 256)
	ld	(_hit),a
	ld	a,(_hit_v)
	and	a
	jp	z,i_185
	ld	a,#(1 % 256 % 256)
	ld	(_hit),a
	ld	hl,(_p_vy)
	call	l_neg
	push	hl
	ld	hl,256	;const
	push	hl
	call	_addsign
	pop	bc
	pop	bc
	ld	(_p_vy),hl
	jp	i_186
.i_185
	ld	a,(_hit_h)
	and	a
	jp	z,i_187
	ld	a,#(1 % 256 % 256)
	ld	(_hit),a
	ld	hl,(_p_vx)
	call	l_neg
	push	hl
	ld	hl,256	;const
	push	hl
	call	_addsign
	pop	bc
	pop	bc
	ld	(_p_vx),hl
.i_187
.i_186
	ld	a,(_hit)
	and	a
	jp	z,i_188
	ld	a,(_p_estado)
	and	a
	jp	nz,i_189
	ld	hl,4 % 256	;const
	ld	a,l
	ld	(_p_killme),a
.i_189
.i_188
	ld	hl,(_p_vx)
	ld	a,h
	or	l
	jp	nz,i_191
	ld	hl,(_p_vy)
	ld	a,h
	or	l
	jp	nz,i_191
	jr	i_192
.i_191
	ld	hl,1	;const
.i_192
	ld	a,h
	or	l
	jp	z,i_190
	ld	hl,(_p_subframe)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_p_subframe),a
	cp	#(4 % 256)
	jp	nz,i_193
	ld	a,#(0 % 256 % 256)
	ld	(_p_subframe),a
	ld	hl,(_p_frame)
	ld	h,0
	call	l_lneg
	ld	hl,0	;const
	rl	l
	ld	h,0
	ld	a,l
	ld	(_p_frame),a
.i_193
.i_190
	ld	hl,_player_cells
	push	hl
	ld	hl,(_p_facing)
	ld	h,0
	ex	de,hl
	ld	hl,(_p_frame)
	ld	h,0
	add	hl,de
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	ld	(_p_next_frame),hl
	ret



._player_deplete
	ld	hl,(_p_life)
	ld	h,0
	ex	de,hl
	ld	hl,(_p_kill_amt)
	ld	h,0
	call	l_ugt
	jp	nc,i_194
	ld	hl,(_p_life)
	ld	h,0
	ex	de,hl
	ld	hl,(_p_kill_amt)
	ld	h,0
	ex	de,hl
	and	a
	sbc	hl,de
	jp	i_195
.i_194
	ld	hl,0	;const
.i_195
	ld	h,0
	ld	a,l
	ld	(_p_life),a
	ret



._player_kill
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_p_killme),a
	call	_player_deplete
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	call	_beep_fx
	pop	bc
	ld	a,#(2 % 256 % 256)
	ld	(_p_estado),a
	ld	hl,50 % 256	;const
	ld	a,l
	ld	(_p_ct_estado),a
	ret



._enems_pursuers_init
	ld	de,_en_an_alive
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	ld	(hl),#(0 % 256 % 256)
	ld	de,_en_an_dead_row
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	push	hl
	call	_rand
	ld	de,7	;const
	ex	de,hl
	call	l_and
	ld	de,11
	add	hl,de
	pop	de
	ld	a,l
	ld	(de),a
	ret



._enems_draw_current
	ld	hl,_malotes
	push	hl
	ld	hl,(_enoffsmasi)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,hl
	add	hl,hl
	add	hl,bc
	add	hl,hl
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(__en_x),a
	ld	hl,_malotes
	push	hl
	ld	hl,(_enoffsmasi)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,hl
	add	hl,hl
	add	hl,bc
	add	hl,hl
	pop	de
	add	hl,de
	inc	hl
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(__en_y),a
	; enter: IX = sprite structure address
	; IY = clipping rectangle, set it to "ClipStruct" for full screen
	; BC = animate bitdef displacement (0 for no animation)
	; H = new row coord in chars
	; L = new col coord in chars
	; D = new horizontal rotation (0..7) ie horizontal pixel position
	; E = new vertical rotation (0..7) ie vertical pixel position
	ld a, (_enit)
	sla a
	ld c, a
	ld b, 0
	ld hl, _sp_moviles
	add hl, bc
	ld e, (hl)
	inc hl
	ld d, (hl)
	push de
	pop ix
	ld iy, vpClipStruct
	ld hl, _en_an_current_frame
	add hl, bc
	ld e, (hl)
	inc hl
	ld d, (hl)
	ld hl, _en_an_next_frame
	add hl, bc
	ld a, (hl)
	inc hl
	ld h, (hl)
	ld l, a
	or a
	sbc hl, de
	push bc
	ld b, h
	ld c, l
	ld a, (__en_y)
	srl a
	srl a
	srl a
	add 1
	ld h, a
	ld a, (__en_x)
	srl a
	srl a
	srl a
	add 1
	ld l, a
	ld a, (__en_x)
	and 7
	ld d, a
	ld a, (__en_y)
	and 7
	ld e, a
	call SPMoveSprAbs
	pop bc
	ld hl, _en_an_current_frame
	add hl, bc
	ex de, hl
	ld hl, _en_an_next_frame
	add hl, bc
	ldi
	ldi
	ret



._enems_load
	ld	hl,(_n_pant)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_enoffs),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_enit),a
	jp	i_198
.i_196
	ld	hl,(_enit)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_enit),a
.i_198
	ld	a,(_enit)
	cp	#(3 % 256)
	jp	z,i_197
	jp	nc,i_197
	ld	de,_en_an_frame
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	ld	(hl),#(0 % 256 % 256)
	ld	de,_en_an_state
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	ld	(hl),#(0 % 256 % 256)
	ld	de,_en_an_count
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	ld	(hl),#(3 % 256 % 256)
	ld	hl,(_enoffs)
	ld	h,0
	ex	de,hl
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_enoffsmasi),a
	ld	hl,_malotes
	push	hl
	ld	hl,(_enoffsmasi)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,hl
	add	hl,hl
	add	hl,bc
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,8
	add	hl,bc
	push	hl
	ld	a,(hl)
	and	#(239 % 256)
	pop	de
	ld	(de),a
	ld	hl,_malotes
	push	hl
	ld	hl,(_enoffsmasi)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,hl
	add	hl,hl
	add	hl,bc
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,9
	add	hl,bc
	ld	(hl),#(2 % 256 % 256)
	ld	hl,_en_an_next_frame
	push	hl
	ld	hl,(_enit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_sprite_18_a
	pop	de
	call	l_pint
	ld	hl,_malotes
	push	hl
	ld	hl,(_enoffsmasi)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,hl
	add	hl,hl
	add	hl,bc
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,8
	add	hl,bc
	ld	a,(hl)
	and	#(31 % 256)
	ld	l,a
	ld	h,0
.i_201
	ld	a,l
	cp	#(1% 256)
	jp	z,i_202
	cp	#(2% 256)
	jp	z,i_203
	cp	#(3% 256)
	jp	z,i_204
	cp	#(4% 256)
	jp	z,i_205
	cp	#(5% 256)
	jp	z,i_206
	cp	#(7% 256)
	jp	z,i_207
	jp	i_200
.i_202
.i_203
.i_204
.i_205
	ld	de,_en_an_base_frame
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	push	hl
	ld	hl,_malotes
	push	hl
	ld	hl,(_enoffsmasi)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,hl
	add	hl,hl
	add	hl,bc
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,8
	add	hl,bc
	ld	l,(hl)
	ld	h,0
	dec	hl
	add	hl,hl
	pop	de
	ld	a,l
	ld	(de),a
	jp	i_200
.i_206
	ld	de,_en_an_base_frame
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	ld	(hl),#(6 % 256 % 256)
	ld	de,_en_an_state
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	push	hl
	ld	hl,_malotes
	push	hl
	ld	hl,(_enoffsmasi)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,hl
	add	hl,hl
	add	hl,bc
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,8
	add	hl,bc
	ld	e,(hl)
	ld	d,0
	ld	l,#(6 % 256)
	call	l_asr_u
	pop	de
	ld	a,l
	ld	(de),a
	jp	i_200
.i_207
	call	_enems_pursuers_init
.i_200
	jp	i_196
.i_197
	ret



._enems_kill
	ld	hl,__en_t
	call	l_gchar
	ld	de,7	;const
	ex	de,hl
	call	l_ne
	jp	nc,i_208
	ld	hl,__en_t
	call	l_gchar
	ld	de,16	;const
	ex	de,hl
	call	l_or
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(__en_t),a
.i_208
	ld	hl,(_p_killed)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_p_killed),a
	ret



._enems_move
	ld	hl,0	;const
	ld	(_ptgmy),hl
	ld	(_ptgmx),hl
	ld	h,0
	ld	a,l
	ld	(_p_gotten),a
	ld	h,0
	ld	a,l
	ld	(_tocado),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_enit),a
	jp	i_211
.i_209
	ld	hl,_enit
	ld	a,(hl)
	inc	(hl)
.i_211
	ld	a,(_enit)
	cp	#(3 % 256)
	jp	z,i_210
	jp	nc,i_210
	ld	a,#(0 % 256 % 256)
	ld	(_active),a
	ld	hl,(_enoffs)
	ld	h,0
	ex	de,hl
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_enoffsmasi),a
	ld hl, (_enoffsmasi)
	ld h, 0
	add hl, hl
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, de
	ld de, _malotes
	add hl, de
	ld (__baddies_pointer), hl
	ld a, (hl)
	ld (__en_x), a
	inc hl
	ld a, (hl)
	ld (__en_y), a
	inc hl
	ld a, (hl)
	ld (__en_x1), a
	inc hl
	ld a, (hl)
	ld (__en_y1), a
	inc hl
	ld a, (hl)
	ld (__en_x2), a
	inc hl
	ld a, (hl)
	ld (__en_y2), a
	inc hl
	ld a, (hl)
	ld (__en_mx), a
	inc hl
	ld a, (hl)
	ld (__en_my), a
	inc hl
	ld a, (hl)
	ld (__en_t), a
	and 0x1f
	ld (_rdt), a
	inc hl
	ld a, (hl)
	ld (__en_life), a
	ld	hl,(__en_x)
	ld	h,0
	ld	a,l
	ld	(__en_cx),a
	ld	hl,(__en_y)
	ld	h,0
	ld	a,l
	ld	(__en_cy),a
	ld	hl,(_rdt)
	ld	h,0
.i_214
	ld	a,l
	cp	#(1% 256)
	jp	z,i_215
	cp	#(2% 256)
	jp	z,i_216
	cp	#(3% 256)
	jp	z,i_217
	cp	#(4% 256)
	jp	z,i_218
	cp	#(5% 256)
	jp	z,i_219
	cp	#(7% 256)
	jp	z,i_222
	jp	i_213
.i_215
.i_216
.i_217
.i_218
.i_219
	ld a, 1
	ld (_active), a
	ld a, (__en_mx)
	ld c, a
	ld a, (__en_x)
	add a, c
	ld (__en_x), a
	ld c, a
	ld a, (__en_x1)
	cp c
	jr z, _enems_lm_change_axis_x
	ld a, (__en_x2)
	cp c
	jr z, _enems_lm_change_axis_x
	call _mons_col_sc_x
	xor a
	or l
	jr z, _enems_lm_change_axis_x_done
	._enems_lm_change_axis_x
	ld a, (__en_mx)
	neg
	ld (__en_mx), a
	._enems_lm_change_axis_x_done
	ld a, (__en_my)
	ld c, a
	ld a, (__en_y)
	add a, c
	ld (__en_y), a
	ld c, a
	ld a, (__en_y1)
	cp c
	jr z, _enems_lm_change_axis_y
	ld a, (__en_y2)
	cp c
	jr z, _enems_lm_change_axis_y
	call _mons_col_sc_y
	xor a
	or l
	jr z, _enems_lm_change_axis_y_done
	._enems_lm_change_axis_y
	ld a, (__en_my)
	neg
	ld (__en_my), a
	._enems_lm_change_axis_y_done
	ld	a,(_rdt)
	ld	e,a
	ld	d,0
	ld	hl,5	;const
	call	l_eq
	jp	nc,i_220
	call	_rand
	ld	de,15	;const
	ex	de,hl
	call	l_and
	dec	hl
	ld	a,h
	or	l
	jp	nz,i_221
	ld	de,_en_an_state
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_rda),a
	call	_simple_coco_shoot
.i_221
.i_220
	jp	i_213
.i_222
	ld bc, (_enit)
	ld b, 0
	ld hl, _en_an_alive
	add hl, bc
	ld a, (hl)
	cp 1
	jp z, _eij_state_appearing
	cp 2
	jp z, _eij_state_moving
	._eij_state_idle
	ld hl, _en_an_dead_row
	add hl, bc
	ld a, (hl)
	or a
	jr nz, _eij_state_still_idle
	ld a, (__en_x1)
	ld (__en_x), a
	ld a, (__en_y1)
	ld (__en_y), a
	ld hl, _en_an_alive
	add hl, bc
	ld a, 1
	ld (hl), a
	push bc
	call _rand
	ld de, 5
	ex de, hl
	call l_div
	ex de, hl
	ld de, 1
	call l_asl
	ld a, l
	pop bc
	cp 5
	jr c, _eij_rawv_set
	ld a, 2
	._eij_rawv_set
	ld hl, _en_an_rawv
	add hl, bc
	ld (hl), a
	call _rand
	ld a, l
	and 7
	add 11
	ld hl, _en_an_dead_row
	add hl, bc
	ld (hl), a
	ld a, 2
	ld (__en_life), a
	jp _eij_state_done
	._eij_state_still_idle
	dec a
	ld (hl), a
	jp _eij_state_done
	._eij_state_appearing
	ld hl, _en_an_dead_row
	add hl, bc
	ld a, (hl)
	or a
	jr nz, _eij_state_still_appearing
	ld a, 3*2
	ld hl, _en_an_base_frame
	add hl, bc
	ld (hl), a
	ld a, 2
	ld hl, _en_an_alive
	add hl, bc
	ld (hl), a
	jp _eij_state_done
	._eij_state_still_appearing
	dec a
	ld (hl), a
	ld hl, _en_an_next_frame
	add hl, bc
	add hl, bc
	ld de, _sprite_17_a
	ex de, hl
	call l_pint
	jp _eij_state_done
	._eij_state_moving
	ld a, 1
	ld (_active), a
	ld hl, _en_an_rawv
	add hl, bc
	ld a, (hl)
	ld (_rda), a
	ld a, (_p_estado)
	or a
	jr nz, _eij_state_done
	._eij_state_moving_x
	call _rand
	ld a, l
	and 3
	jr z, _eij_state_moving_y
	ld a, (__en_x)
	ld d, a
	ld a, (_gpx)
	cp d
	jr z, _eij_state_moving_y
	jr c, _eij_state_moving_x_left
	._eij_state_moving_x_right
	ld a, (_rda)
	ld (__en_mx), a
	jr _eij_state_moving_x_set
	._eij_state_moving_x_left
	ld a, (_rda)
	neg
	ld (__en_mx), a
	._eij_state_moving_x_set
	add d
	ld (__en_x), a
	call _mons_col_sc_x
	xor a
	or l
	jr z, _eij_state_moving_y
	ld a, (__en_cx)
	ld (__en_x), a
	._eij_state_moving_y
	call _rand
	ld a, l
	and 3
	jr z, _eij_state_done
	ld a, (__en_y)
	ld d, a
	ld a, (_gpy)
	cp d
	jr z, _eij_state_done
	jr c, _eij_state_moving_y_up
	._eij_state_moving_y_down
	ld a, (_rda)
	ld (__en_my), a
	jr _eij_state_moving_y_set
	._eij_state_moving_y_up
	ld a, (_rda)
	neg
	ld (__en_my), a
	._eij_state_moving_y_set
	add d
	ld (__en_y), a
	call _mons_col_sc_y
	xor a
	or l
	jr z, _eij_state_done
	ld a, (__en_cy)
	ld (__en_y), a
	._eij_state_done
.i_213
	ld	a,(_active)
	and	a
	jp	z,i_223
	ld	de,_en_an_base_frame
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	ld	e,(hl)
	ld	d,0
	ld	hl,99	;const
	call	l_ne
	jp	nc,i_224
	ld bc, (_enit)
	ld b, 0
	ld hl, _en_an_count
	add hl, bc
	ld a, (hl)
	inc a
	ld (hl), a
	cp 4
	jr nz, _enems_move_update_frame_done
	xor a
	ld (hl), a
	ld hl, _en_an_frame
	add hl, bc
	ld a, (hl)
	xor 1
	ld (hl), a
	ld hl, _en_an_base_frame
	add hl, bc
	ld d, (hl)
	add d ; A = en_an_base_frame [enit] + en_an_frame [enit]]
	sla c ; Index 16 bits; it never overflows.
	ld hl, _en_an_next_frame
	add hl, bc
	ex de, hl ; DE -> en_an_next_frame [enit]
	sla a
	ld c, a
	ld b, 0
	ld hl, _enem_cells
	add hl, bc ; HL -> enem_cells [en_an_base_frame [enit] + en_an_frame [enit]]
	ldi
	ldi ; Copy 16 bit
	._enems_move_update_frame_done
.i_224
	ld	hl,(__en_x)
	ld	h,0
	ld	a,l
	ld	(_cx2),a
	ld	hl,(__en_y)
	ld	h,0
	ld	a,l
	ld	(_cy2),a
	ld	hl,(_tocado)
	ld	h,0
	call	l_lneg
	jp	nc,i_226
	call	_collide
	ld	a,h
	or	l
	jp	z,i_226
	ld	a,(_p_estado)
	cp	#(0 % 256)
	jr	z,i_227_i_226
.i_226
	jp	i_225
.i_227_i_226
	ld	a,#(1 % 256 % 256)
	ld	(_tocado),a
	ld	hl,4 % 256	;const
	ld	a,l
	ld	(_p_killme),a
.i_225
.i_228
	ld	a,(_rdt)
	cp	#(3 % 256)
	jr	z,i_229_uge
	jp	c,i_229
.i_229_uge
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpjt),a
	jp	i_232
.i_230
	ld	hl,_gpjt
	ld	a,(hl)
	inc	(hl)
.i_232
	ld	a,(_gpjt)
	cp	#(3 % 256)
	jp	z,i_231
	jp	nc,i_231
	ld	de,_bullets_estado
	ld	hl,(_gpjt)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	cp	#(1 % 256)
	jp	nz,i_233
	ld	de,_bullets_x
	ld	hl,(_gpjt)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	inc	hl
	inc	hl
	inc	hl
	ld	h,0
	ld	a,l
	ld	(_blx),a
	ld	de,_bullets_y
	ld	hl,(_gpjt)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	inc	hl
	inc	hl
	inc	hl
	ld	h,0
	ld	a,l
	ld	(_bly),a
	ld	hl,(_blx)
	ld	h,0
	ex	de,hl
	ld	hl,(__en_x)
	ld	h,0
	call	l_uge
	jp	nc,i_235
	ld	hl,(_blx)
	ld	h,0
	push	hl
	ld	hl,(__en_x)
	ld	h,0
	ld	bc,15
	add	hl,bc
	pop	de
	call	l_ule
	jp	nc,i_235
	ld	hl,(_bly)
	ld	h,0
	ex	de,hl
	ld	hl,(__en_y)
	ld	h,0
	call	l_uge
	jp	nc,i_235
	ld	hl,(_bly)
	ld	h,0
	push	hl
	ld	hl,(__en_y)
	ld	h,0
	ld	bc,15
	add	hl,bc
	pop	de
	call	l_ule
	jr	c,i_236_i_235
.i_235
	jp	i_234
.i_236_i_235
	ld	hl,(__en_cx)
	ld	h,0
	ld	a,l
	ld	(__en_x),a
	ld	hl,(__en_cy)
	ld	h,0
	ld	a,l
	ld	(__en_y),a
	ld	hl,_en_an_next_frame
	push	hl
	ld	hl,(_enit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_sprite_17_a
	pop	de
	call	l_pint
	ld	de,_bullets_estado
	ld	hl,(_gpjt)
	ld	h,0
	add	hl,de
	ld	(hl),#(0 % 256 % 256)
	ld	hl,__en_life
	call	l_gchar
	dec	hl
	ld	a,l
	ld	(__en_life),a
	ld	hl,__en_life
	call	l_gchar
	ld	a,h
	or	l
	jp	nz,i_237
	call	_enems_draw_current
	call	sp_UpdateNow
	ld	hl,5 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
	ld	hl,_en_an_next_frame
	push	hl
	ld	hl,(_enit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_sprite_18_a
	pop	de
	call	l_pint
	call	_enems_pursuers_init
	call	_enems_kill
.i_237
	ld	hl,1 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
.i_234
.i_233
	jp	i_230
.i_231
.i_229
.i_223
	ld hl, (__baddies_pointer)
	ld a, (__en_x)
	ld (hl), a
	inc hl
	ld a, (__en_y)
	ld (hl), a
	inc hl
	ld a, (__en_x1)
	ld (hl), a
	inc hl
	ld a, (__en_y1)
	ld (hl), a
	inc hl
	ld a, (__en_x2)
	ld (hl), a
	inc hl
	ld a, (__en_y2)
	ld (hl), a
	inc hl
	ld a, (__en_mx)
	ld (hl), a
	inc hl
	ld a, (__en_my)
	ld (hl), a
	inc hl
	ld a, (__en_t)
	ld (hl), a
	inc hl
	ld a, (__en_life)
	ld (hl), a
	jp	i_209
.i_210
	ret



._hotspots_do
	ld	hl,_hotspots
	push	hl
	ld	hl,(_n_pant)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	ld	l,(hl)
	ld	h,0
	ld	a,h
	or	l
	jp	nz,i_238
	ret


.i_238
	ld	hl,(_hotspot_x)
	ld	h,0
	ld	a,l
	ld	(_cx2),a
	ld	hl,(_hotspot_y)
	ld	h,0
	ld	a,l
	ld	(_cy2),a
	call	_collide
	ld	a,h
	or	l
	jp	z,i_239
	ld	a,#(1 % 256 % 256)
	ld	(_hotspot_destroy),a
	ld	hl,_hotspots
	push	hl
	ld	hl,(_n_pant)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	ld	l,(hl)
	ld	h,0
.i_242
	ld	a,l
	cp	#(1% 256)
	jp	z,i_243
	cp	#(2% 256)
	jp	z,i_244
	cp	#(3% 256)
	jp	z,i_245
	cp	#(4% 256)
	jp	z,i_247
	jp	i_241
.i_243
	ld	hl,(_p_objs)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_p_objs),a
	ld	hl,9 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
	jp	i_241
.i_244
	ld	hl,_p_keys
	ld	a,(hl)
	inc	(hl)
	ld	hl,7 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
	jp	i_241
.i_245
	ld	hl,(_p_life)
	ld	h,0
	ld	bc,5
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_p_life),a
	cp	#(30 % 256)
	jp	z,i_246
	jp	c,i_246
	ld	hl,30 % 256	;const
	ld	a,l
	ld	(_p_life),a
.i_246
	ld	hl,8 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
	jp	i_241
.i_247
	ld	hl,(_p_ammo)
	ld	h,0
	ld	de,99
	ex	de,hl
	and	a
	sbc	hl,de
	ld	de,50	;const
	ex	de,hl
	call	l_gt
	jp	nc,i_248
	ld	hl,(_p_ammo)
	ld	h,0
	ld	bc,50
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_p_ammo),a
	jp	i_249
.i_248
	ld	hl,99 % 256	;const
	ld	a,l
	ld	(_p_ammo),a
.i_249
	ld	hl,9 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
.i_241
	ld	a,(_hotspot_destroy)
	and	a
	jp	z,i_250
	ld	hl,_hotspots
	push	hl
	ld	hl,(_n_pant)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	ld	(hl),#(0 % 256 % 256)
	ld	a,(_hotspot_x)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(__x),a
	ld	a,(_hotspot_y)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(__y),a
	ld	hl,(_orig_tile)
	ld	h,0
	ld	a,l
	ld	(__t),a
	call	_draw_invalidate_coloured_tile_g
	ld	hl,240 % 256	;const
	ld	a,l
	ld	(_hotspot_y),a
.i_250
.i_239
	ret



._main
	di
	call	_cortina
	ld	hl,0 % 256	;const
	push	hl
	push	hl
	call	sp_Initialize
	pop	bc
	pop	bc
	ld	hl,0 % 256	;const
	push	hl
	call	sp_Border
	pop	bc
	ld	hl,0 % 256	;const
	push	hl
	ld	hl,70 % 256	;const
	push	hl
	ld	hl,14	;const
	push	hl
	ld	hl,_AD_FREE
	push	hl
	call	sp_AddMemory
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,_font
	ld	(_gen_pt),hl
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_253
	ld	hl,(_gpit)
	ld	h,0
	push	hl
	ld	hl,(_gen_pt)
	push	hl
	call	sp_TileArray
	pop	bc
	pop	bc
	ld	hl,(_gen_pt)
	ld	bc,8
	add	hl,bc
	ld	(_gen_pt),hl
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
	ld	a,(_gpit)
	cp	#(64 % 256)
	jp	nz,i_254
	ld	hl,_tileset
	ld	(_gen_pt),hl
.i_254
.i_251
	ld	hl,(_gpit)
	ld	h,0
	ld	a,h
	or	l
	jp	nz,i_253
.i_252
	ld	hl,0 % 256	;const
	push	hl
	ld	hl,3 % 256	;const
	push	hl
	ld	hl,_sprite_2_a
	push	hl
	call	sp_CreateSpr
	pop	bc
	pop	bc
	pop	bc
	ld	(_sp_player),hl
	push	hl
	ld	hl,_sprite_2_b
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	ld	hl,(_sp_player)
	push	hl
	ld	hl,_sprite_2_c
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	ld	hl,_sprite_2_a
	ld	(_p_next_frame),hl
	ld	(_p_current_frame),hl
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_257
.i_255
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
.i_257
	ld	a,(_gpit)
	cp	#(3 % 256)
	jp	z,i_256
	jp	nc,i_256
	ld	hl,_sp_moviles
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,0 % 256	;const
	push	hl
	ld	hl,3 % 256	;const
	push	hl
	ld	hl,_sprite_9_a
	push	hl
	call	sp_CreateSpr
	pop	bc
	pop	bc
	pop	bc
	pop	de
	call	l_pint
	ld	hl,_sp_moviles
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_sprite_9_b
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	ld	hl,_sp_moviles
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_sprite_9_c
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	ld	hl,_en_an_current_frame
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_en_an_next_frame
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_sprite_9_a
	pop	de
	call	l_pint
	pop	de
	call	l_pint
	jp	i_255
.i_256
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_260
.i_258
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
.i_260
	ld	a,(_gpit)
	cp	#(3 % 256)
	jp	z,i_259
	jp	nc,i_259
	ld	hl,_sp_bullets
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,64 % 256	;const
	push	hl
	ld	hl,2 % 256	;const
	push	hl
	ld	hl,_sprite_19_a
	push	hl
	call	sp_CreateSpr
	pop	bc
	pop	bc
	pop	bc
	pop	de
	call	l_pint
	ld	hl,_sp_bullets
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_sprite_19_a+32
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	jp	i_258
.i_259
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_263
.i_261
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
.i_263
	ld	a,(_gpit)
	cp	#(3 % 256)
	jp	z,i_262
	jp	nc,i_262
	ld	hl,_sp_cocos
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,64 % 256	;const
	push	hl
	ld	hl,2 % 256	;const
	push	hl
	ld	hl,_sprite_19_a
	push	hl
	call	sp_CreateSpr
	pop	bc
	pop	bc
	pop	bc
	pop	de
	call	l_pint
	ld	hl,_sp_cocos
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_sprite_19_a+32
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	jp	i_261
.i_262
.i_264
	ld	hl,2 % 256	;const
	ld	a,l
	ld	(_level),a
	call	sp_UpdateNow
	call	_blackout
	ld hl, _s_title
	ld de, 16384
	call depack
	call	_select_joyfunc
	ld	a,#(30 % 256 % 256)
	ld	(_p_life),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_warp_to_level),a
.i_266
	call	_blackout_area
	ld	hl,(_level_str)
	ld	bc,7
	add	hl,bc
	push	hl
	ld	hl,(_level)
	ld	h,0
	ld	de,49
	add	hl,de
	pop	de
	ld	a,l
	ld	(de),a
	ld	a,#(12 % 256 % 256)
	ld	(__x),a
	ld	a,#(12 % 256 % 256)
	ld	(__y),a
	ld	a,#(71 % 256 % 256)
	ld	(__t),a
	ld	hl,(_level_str)
	ld	(__gp_gen),hl
	call	_print_str
	call	sp_UpdateNow
	ld	hl,1 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
	ld	hl,100	;const
	push	hl
	call	_espera_activa
	pop	bc
	ld	hl,(_level)
	ld	h,0
	push	hl
	call	_prepare_level
	pop	bc
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_playing),a
	call	_player_init
	ld	a,#(0 % 256 % 256)
	ld	(_maincounter),a
	ld	hl,_flags
	push	hl
	inc	hl
	ld	(hl),#(0 % 256 % 256)
	ld	l,(hl)
	ld	h,0
	pop	de
	ld	a,l
	ld	(de),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_half_life),a
	ld	h,0
	ld	a,l
	ld	(_success),a
	ld	h,0
	ld	a,l
	ld	(_p_killme),a
	ld	hl,255 % 256	;const
	ld	a,l
	ld	(_killed_old),a
	ld	h,0
	ld	a,l
	ld	(_life_old),a
	ld	h,0
	ld	a,l
	ld	(_keys_old),a
	ld	h,0
	ld	a,l
	ld	(_objs_old),a
	ld	a,#(255 % 256 % 256)
	ld	(_ammo_old),a
	ld	hl,255 % 256	;const
	ld	a,l
	ld	(_o_pant),a
.i_268
	ld	a,(_playing)
	and	a
	jp	z,i_269
	ld	a,#(1 % 256 % 256)
	ld	(_p_kill_amt),a
	ld	hl,(_joyfunc)
	push	hl
	ld	hl,_keys
	pop	de
	ld	bc,i_270
	push	hl
	push	bc
	push	de
	ld	a,1
	ret
.i_270
	pop	bc
	ld	h,0
	ld	a,l
	ld	(_pad0),a
	ld	hl,(_o_pant)
	ld	h,0
	ex	de,hl
	ld	hl,(_n_pant)
	ld	h,0
	call	l_ne
	jp	nc,i_271
	call	_draw_scr
	ld	hl,(_n_pant)
	ld	h,0
	ld	a,l
	ld	(_o_pant),a
.i_271
	ld	hl,(_p_objs)
	ld	h,0
	ex	de,hl
	ld	hl,(_objs_old)
	ld	h,0
	call	l_ne
	jp	nc,i_272
	call	_draw_objs
	ld	hl,(_p_objs)
	ld	h,0
	ld	a,l
	ld	(_objs_old),a
.i_272
	ld	hl,(_p_life)
	ld	h,0
	ex	de,hl
	ld	hl,(_life_old)
	ld	h,0
	call	l_ne
	jp	nc,i_273
	ld	a,#(3 % 256 % 256)
	ld	(__x),a
	ld	a,#(23 % 256 % 256)
	ld	(__y),a
	ld	hl,(_p_life)
	ld	h,0
	ld	a,l
	ld	(__t),a
	call	_print_number2
	ld	hl,(_p_life)
	ld	h,0
	ld	a,l
	ld	(_life_old),a
.i_273
	ld	hl,(_p_keys)
	ld	h,0
	ex	de,hl
	ld	hl,(_keys_old)
	ld	h,0
	call	l_ne
	jp	nc,i_274
	ld	a,#(22 % 256 % 256)
	ld	(__x),a
	ld	a,#(23 % 256 % 256)
	ld	(__y),a
	ld	hl,(_p_keys)
	ld	h,0
	ld	a,l
	ld	(__t),a
	call	_print_number2
	ld	hl,(_p_keys)
	ld	h,0
	ld	a,l
	ld	(_keys_old),a
.i_274
	ld	hl,(_p_ammo)
	ld	h,0
	ex	de,hl
	ld	hl,(_ammo_old)
	ld	h,0
	call	l_ne
	jp	nc,i_275
	ld	a,#(8 % 256 % 256)
	ld	(__x),a
	ld	a,#(23 % 256 % 256)
	ld	(__y),a
	ld	hl,(_p_ammo)
	ld	h,0
	ld	a,l
	ld	(__t),a
	call	_print_number2
	ld	hl,(_p_ammo)
	ld	h,0
	ld	a,l
	ld	(_ammo_old),a
.i_275
	ld	hl,_maincounter
	ld	a,(hl)
	inc	(hl)
	ld	hl,(_half_life)
	ld	h,0
	call	l_lneg
	ld	hl,0	;const
	rl	l
	ld	h,0
	ld	a,l
	ld	(_half_life),a
	call	_player_move
	call	_enems_move
	call	_simple_coco_update
	ld	a,(_p_killme)
	and	a
	jp	z,i_276
	ld	hl,(_p_killme)
	ld	h,0
	push	hl
	call	_player_kill
	pop	bc
.i_276
	call	_bullets_move
	ld	hl,(_o_pant)
	ld	h,0
	ex	de,hl
	ld	hl,(_n_pant)
	ld	h,0
	call	l_eq
	jp	nc,i_277
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_enit),a
	jp	i_280
.i_278
	ld	hl,_enit
	ld	a,(hl)
	inc	(hl)
.i_280
	ld	a,(_enit)
	cp	#(3 % 256)
	jp	z,i_279
	jp	nc,i_279
	ld	hl,(_enoffs)
	ld	h,0
	ex	de,hl
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_enoffsmasi),a
	call	_enems_draw_current
	jp	i_278
.i_279
	ld	a,(_p_estado)
	ld	e,a
	ld	d,0
	ld	hl,2	;const
	call	l_and
	ld	de,0	;const
	ex	de,hl
	call	l_eq
	jp	c,i_282
	ld	a,(_half_life)
	cp	#(0 % 256)
	jp	nz,i_281
.i_282
	ld ix, (_sp_player)
	ld iy, vpClipStruct
	ld hl, (_p_next_frame)
	ld de, (_p_current_frame)
	or a
	sbc hl, de
	ld b, h
	ld c, l
	ld a, (_gpy)
	srl a
	srl a
	srl a
	add 1
	ld h, a
	ld a, (_gpx)
	srl a
	srl a
	srl a
	add 1
	ld l, a
	ld a, (_gpx)
	and 7
	ld d, a
	ld a, (_gpy)
	and 7
	ld e, a
	call SPMoveSprAbs
	jp	i_284
.i_281
	ld ix, (_sp_player)
	ld iy, vpClipStruct
	ld hl, (_p_next_frame)
	ld de, (_p_current_frame)
	or a
	sbc hl, de
	ld b, h
	ld c, l
	ld hl, 0xfefe
	ld de, 0
	call SPMoveSprAbs
.i_284
	ld	hl,(_p_next_frame)
	ld	(_p_current_frame),hl
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_287
.i_285
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
.i_287
	ld	a,(_gpit)
	cp	#(3 % 256)
	jp	z,i_286
	jp	nc,i_286
	ld	de,_bullets_estado
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	cp	#(1 % 256)
	jp	nz,i_288
	ld	de,_bullets_x
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_rdx),a
	ld	de,_bullets_y
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_rdy),a
	ld a, (_gpit)
	sla a
	ld c, a
	ld b, 0
	ld hl, _sp_bullets
	add hl, bc
	ld e, (hl)
	inc hl
	ld d, (hl)
	push de
	pop ix
	ld iy, vpClipStruct
	ld bc, 0
	ld a, (_rdy)
	srl a
	srl a
	srl a
	add 1
	ld h, a
	ld a, (_rdx)
	srl a
	srl a
	srl a
	add 1
	ld l, a
	ld a, (_rdx)
	and 7
	ld d, a
	ld a, (_rdy)
	and 7
	ld e, a
	call SPMoveSprAbs
	jp	i_289
.i_288
	ld a, (_gpit)
	sla a
	ld c, a
	ld b, 0
	ld hl, _sp_bullets
	add hl, bc
	ld e, (hl)
	inc hl
	ld d, (hl)
	push de
	pop ix
	ld iy, vpClipStruct
	ld bc, 0
	ld hl, 0xfefe
	ld de, 0
	call SPMoveSprAbs
.i_289
	jp	i_285
.i_286
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_292
.i_290
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
.i_292
	ld	a,(_gpit)
	cp	#(3 % 256)
	jp	z,i_291
	jp	nc,i_291
	ld	de,_cocos_y
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	cp	#(160 % 256)
	jp	z,i_293
	jp	nc,i_293
	ld	de,_cocos_x
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_rdx),a
	ld	de,_cocos_y
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_rdy),a
	ld a, (_gpit)
	sla a
	ld c, a
	ld b, 0
	ld hl, _sp_cocos
	add hl, bc
	ld e, (hl)
	inc hl
	ld d, (hl)
	push de
	pop ix
	ld iy, vpClipStruct
	ld bc, 0
	ld a, (_rdy)
	srl a
	srl a
	srl a
	add 1
	ld h, a
	ld a, (_rdx)
	srl a
	srl a
	srl a
	add 1
	ld l, a
	ld a, (_rdx)
	and 7
	ld d, a
	ld a, (_rdy)
	and 7
	ld e, a
	call SPMoveSprAbs
	jp	i_294
.i_293
	ld a, (_gpit)
	sla a
	ld c, a
	ld b, 0
	ld hl, _sp_cocos
	add hl, bc
	ld e, (hl)
	inc hl
	ld d, (hl)
	push de
	pop ix
	ld iy, vpClipStruct
	ld bc, 0
	ld hl, 0xfefe
	ld de, 0
	call SPMoveSprAbs
.i_294
	jp	i_290
.i_291
	call	sp_UpdateNow
.i_277
	ld	a,(_p_estado)
	cp	#(2 % 256)
	jp	nz,i_295
	ld	hl,_p_ct_estado
	ld	a,(hl)
	dec	(hl)
	ld	a,(_p_ct_estado)
	and	a
	jp	nz,i_296
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_p_estado),a
.i_296
.i_295
	call	_hotspots_do
	ld	a,(_gpy)
	cp	#(0 % 256)
	jp	nz,i_298
	ld	hl,(_p_vy)
	ld	de,0	;const
	ex	de,hl
	call	l_lt
	jp	nc,i_298
	ld	hl,(_n_pant)
	ld	h,0
	ex	de,hl
	ld	hl,(_level_data)
	ld	h,0
	call	l_uge
	jr	c,i_299_i_298
.i_298
	jp	i_297
.i_299_i_298
	ld	hl,(_n_pant)
	ld	h,0
	ex	de,hl
	ld	hl,(_level_data)
	ld	h,0
	ex	de,hl
	and	a
	sbc	hl,de
	ld	h,0
	ld	a,l
	ld	(_n_pant),a
	ld	a,#(144 % 256 % 256)
	ld	(_gpy),a
	ld	hl,9216	;const
	ld	(_p_y),hl
.i_297
	ld	a,(_gpy)
	cp	#(144 % 256)
	jp	nz,i_301
	ld	hl,(_p_vy)
	ld	de,0	;const
	ex	de,hl
	call	l_gt
	jr	c,i_302_i_301
.i_301
	jp	i_300
.i_302_i_301
	ld	hl,(_n_pant)
	ld	h,0
	push	hl
	ld	hl,(_level_data)
	ld	h,0
	push	hl
	ld	hl,(_level_data+1)
	ld	h,0
	dec	hl
	pop	de
	call	l_mult
	pop	de
	call	l_ult
	jp	nc,i_303
	ld	hl,(_n_pant)
	ld	h,0
	ex	de,hl
	ld	hl,(_level_data)
	ld	h,0
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_n_pant),a
	ld	hl,0	;const
	ld	(_p_y),hl
	ld	h,0
	ld	a,l
	ld	(_gpy),a
	ld	hl,(_p_vy)
	ld	de,256	;const
	ex	de,hl
	call	l_gt
	jp	nc,i_304
	ld	hl,256	;const
	ld	(_p_vy),hl
.i_304
.i_303
.i_300
	jp	i_305
	ld	a,#(1 % 256 % 256)
	ld	(_success),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_playing),a
.i_305
	ld	a,(_p_life)
	and	a
	jp	nz,i_306
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_playing),a
.i_306
	ld	a,(_n_pant)
	cp	#(0 % 256)
	jp	nz,i_308
	ld	a,(_flags+1)
	cp	#(0 % 256)
	jp	nz,i_308
	ld	a,(_gpy)
	cp	#(96 % 256)
	jp	z,i_308
	jp	nc,i_308
	ld	a,(_p_objs)
	cp	#(5 % 256)
	jr	z,i_309_i_308
.i_308
	jp	i_307
.i_309_i_308
	ld	hl,_flags+1
	ld	(hl),#(1 % 256 % 256)
	ld	hl,_decos_bombs
	ld	(__gp_gen),hl
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_312
.i_310
	ld	hl,(_gpit)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_gpit),a
.i_312
	ld	a,(_gpit)
	cp	#(5 % 256)
	jp	z,i_311
	jp	nc,i_311
	ld	hl,(__gp_gen)
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_rda),a
	ld	hl,(__gp_gen)
	inc	hl
	inc	hl
	ld	(__gp_gen),hl
	ld	a,(_rda)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(__x),a
	ld	a,(_rda)
	ld	e,a
	ld	d,0
	ld	hl,15	;const
	call	l_and
	ld	h,0
	ld	a,l
	ld	(__y),a
	ld	hl,17 % 256	;const
	ld	a,l
	ld	(__t),a
	call	_update_tile
	call	sp_UpdateNow
	ld	hl,0 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
	jp	i_310
.i_311
	ld	a,#(1 % 256 % 256)
	ld	(__x),a
	ld	a,#(0 % 256 % 256)
	ld	(__y),a
	ld	a,#(71 % 256 % 256)
	ld	(__t),a
	ld	hl,i_1+233
	ld	(__gp_gen),hl
	call	_print_str
.i_307
	ld	a,(_flags)
	and	a
	jp	z,i_313
	ld	a,(_gpx)
	cp	#(64 % 256)
	jp	z,i_315
	jp	nc,i_315
	ld	a,(_gpy)
	cp	#(16 % 256)
	jr	z,i_315_uge
	jp	c,i_315
.i_315_uge
	ld	a,(_gpy)
	cp	#(80 % 256)
	jp	z,i_315
	jr	c,i_316_i_315
.i_315
	jp	i_314
.i_316_i_315
	ld	hl,_flags
	ld	(hl),#(0 % 256 % 256)
	ld	hl,9 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
	ld	a,#(1 % 256 % 256)
	ld	(__x),a
	ld	a,#(0 % 256 % 256)
	ld	(__y),a
	ld	a,#(71 % 256 % 256)
	ld	(__t),a
	ld	hl,i_1+264
	ld	(__gp_gen),hl
	call	_print_str
.i_314
.i_313
	jp	i_268
.i_269
	call	sp_UpdateNow
	call	sp_WaitForNoKey
	ld	a,#(1 % 256 % 256)
	ld	(__x),a
	ld	a,#(0 % 256 % 256)
	ld	(__y),a
	ld	a,#(71 % 256 % 256)
	ld	(__t),a
	ld	hl,i_1+295
	ld	(__gp_gen),hl
	call	_print_str
	ld	hl,(_success)
	ld	h,0
	ld	a,h
	or	l
	jp	z,i_317
	call	_zone_clear
	ld	a,(_warp_to_level)
	and	a
	jp	nz,i_318
	ld	hl,(_level)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_level),a
.i_318
	ld	a,(_level)
	ld	e,a
	ld	d,0
	ld	hl,3	;const
	call	l_uge
	jp	nc,i_319
	call	_game_ending
	jp	i_267
.i_319
	jp	i_320
.i_317
	call	_game_over
	jp	i_267
.i_320
	jp	i_266
.i_267
	call	_clear_sprites
	jp	i_264
.i_265
	ret


	; *****************************************************************************
	; * Phaser1 Engine, with synthesised drums
	; *
	; * Original code by Shiru - .http
	; * Modified by Chris Cowley
	; *
	; * Produced by Beepola v1.05.01
	; ******************************************************************************
	.musicstart
	LD HL,MUSICDATA ; <- Pointer to Music Data. Change
	; this to play a different song
	LD A,(HL) ; Get the loop start pointer
	LD (PATTERN_LOOP_BEGIN),A
	INC HL
	LD A,(HL) ; Get the song end pointer
	LD (PATTERN_LOOP_END),A
	INC HL
	LD E,(HL)
	INC HL
	LD D,(HL)
	INC HL
	LD (INSTRUM_TBL),HL
	LD (CURRENT_INST),HL
	ADD HL,DE
	LD (PATTERN_ADDR),HL
	XOR A
	LD (PATTERN_PTR),A ; Set the pattern pointer to zero
	LD H,A
	LD L,A
	LD (NOTE_PTR),HL ; Set the note offset (within this pattern) to 0
	.player
	PUSH IY
	;LD A,BORDER_COL
	xor a
	LD H,$00
	LD L,A
	LD (CNT_1A),HL
	LD (CNT_1B),HL
	LD (DIV_1A),HL
	LD (DIV_1B),HL
	LD (CNT_2),HL
	LD (DIV_2),HL
	LD (OUT_1),A
	LD (OUT_2),A
	JR MAIN_LOOP
	; ********************************************************************************************************
	; * NEXT_PATTERN
	; *
	; * Select the next pattern in sequence (and handle looping if weve reached PATTERN_LOOP_END
	; * Execution falls through to PLAYNOTE to play the first note from our next pattern
	; ********************************************************************************************************
	.next_pattern
	LD A,(PATTERN_PTR)
	INC A
	INC A
	DEFB $FE ; CP n
	.pattern_loop_end DEFB 0
	JR NZ,NO_PATTERN_LOOP
	; Handle Pattern Looping at and of song
	DEFB $3E ; LD A,n
	.pattern_loop_begin DEFB 0
	.no_pattern_loop LD (PATTERN_PTR),A
	LD HL,$0000
	LD (NOTE_PTR),HL ; Start of pattern (NOTE_PTR = 0)
	.main_loop
	LD IYL,0 ; Set channel = 0
	.read_loop
	LD HL,(PATTERN_ADDR)
	LD A,(PATTERN_PTR)
	LD E,A
	LD D,0
	ADD HL,DE
	LD E,(HL)
	INC HL
	LD D,(HL) ; Now DE = Start of Pattern data
	LD HL,(NOTE_PTR)
	INC HL ; Increment the note pointer and...
	LD (NOTE_PTR),HL ; ..store it
	DEC HL
	ADD HL,DE ; Now HL = address of note data
	LD A,(HL)
	OR A
	JR Z,NEXT_PATTERN ; select next pattern
	BIT 7,A
	JP Z,RENDER ; Play the currently defined note(S) and drum
	LD IYH,A
	AND $3F
	CP $3C
	JP NC,OTHER ; Other parameters
	ADD A,A
	LD B,0
	LD C,A
	LD HL,FREQ_TABLE
	ADD HL,BC
	LD E,(HL)
	INC HL
	LD D,(HL)
	LD A,IYL ; IYL = 0 for channel 1, or = 1 for channel 2
	OR A
	JR NZ,SET_NOTE2
	LD (DIV_1A),DE
	EX DE,HL
	DEFB $DD,$21 ; LD IX,nn
	.current_inst
	DEFW $0000
	LD A,(IX+$00)
	OR A
	JR Z,L809B ; Original code jumps into byte 2 of the DJNZ (invalid opcode FD)
	LD B,A
	.l8098 ADD HL,HL
	DJNZ L8098
	.l809b LD E,(IX+$01)
	LD D,(IX+$02)
	ADD HL,DE
	LD (DIV_1B),HL
	LD IYL,1 ; Set channel = 1
	LD A,IYH
	AND $40
	JR Z,READ_LOOP ; No phase reset
	LD HL,OUT_1 ; Reset phaser
	RES 4,(HL)
	LD HL,$0000
	LD (CNT_1A),HL
	LD H,(IX+$03)
	LD (CNT_1B),HL
	JR READ_LOOP
	.set_note2
	LD (DIV_2),DE
	LD A,IYH
	LD HL,OUT_2
	RES 4,(HL)
	LD HL,$0000
	LD (CNT_2),HL
	JP READ_LOOP
	.set_stop
	LD HL,$0000
	LD A,IYL
	OR A
	JR NZ,SET_STOP2
	; Stop channel 1 note
	LD (DIV_1A),HL
	LD (DIV_1B),HL
	LD HL,OUT_1
	RES 4,(HL)
	LD IYL,1
	JP READ_LOOP
	.set_stop2
	; Stop channel 2 note
	LD (DIV_2),HL
	LD HL,OUT_2
	RES 4,(HL)
	JP READ_LOOP
	.other CP $3C
	JR Z,SET_STOP ; Stop note
	CP $3E
	JR Z,SKIP_CH1 ; No changes to channel 1
	INC HL ; Instrument change
	LD L,(HL)
	LD H,$00
	ADD HL,HL
	LD DE,(NOTE_PTR)
	INC DE
	LD (NOTE_PTR),DE ; Increment the note pointer
	DEFB $01 ; LD BC,nn
	.instrum_tbl
	DEFW $0000
	ADD HL,BC
	LD (CURRENT_INST),HL
	JP READ_LOOP
	.skip_ch1
	LD IYL,$01
	JP READ_LOOP
	.exit_player
	LD HL,$2758
	EXX
	POP IY
	RET
	.render
	AND $7F ; L813A
	CP $76
	JP NC,DRUMS
	LD D,A
	EXX
	DEFB $21 ; LD HL,nn
	.cnt_1a DEFW $0000
	DEFB $DD,$21 ; LD IX,nn
	.cnt_1b DEFW $0000
	DEFB $01 ; LD BC,nn
	.div_1a DEFW $0000
	DEFB $11 ; LD DE,nn
	.div_1b DEFW $0000
	DEFB $3E ; LD A,n
	.out_1 DEFB $0
	EXX
	EX AF,AF ; beware!
	DEFB $21 ; LD HL,nn
	.cnt_2 DEFW $0000
	DEFB $01 ; LD BC,nn
	.div_2 DEFW $0000
	DEFB $3E ; LD A,n
	.out_2 DEFB $00
	.play_note
	; Read keyboard
	LD E,A
	XOR A
	IN A,($FE)
	OR $E0
	INC A
	.player_wait_key
	JR NZ,EXIT_PLAYER
	LD A,E
	LD E,0
	.l8168 EXX
	EX AF,AF ; beware!
	ADD HL,BC
	OUT ($FE),A
	JR C,L8171
	JR L8173
	.l8171 XOR $10
	.l8173 ADD IX,DE
	JR C,L8179
	JR L817B
	.l8179 XOR $10
	.l817b EX AF,AF ; beware!
	OUT ($FE),A
	EXX
	ADD HL,BC
	JR C,L8184
	JR L8186
	.l8184 XOR $10
	.l8186 NOP
	JP L818A
	.l818a EXX
	EX AF,AF ; beware!
	ADD HL,BC
	OUT ($FE),A
	JR C,L8193
	JR L8195
	.l8193 XOR $10
	.l8195 ADD IX,DE
	JR C,L819B
	JR L819D
	.l819b XOR $10
	.l819d EX AF,AF ; beware!
	OUT ($FE),A
	EXX
	ADD HL,BC
	JR C,L81A6
	JR L81A8
	.l81a6 XOR $10
	.l81a8 NOP
	JP L81AC
	.l81ac EXX
	EX AF,AF ; beware!
	ADD HL,BC
	OUT ($FE),A
	JR C,L81B5
	JR L81B7
	.l81b5 XOR $10
	.l81b7 ADD IX,DE
	JR C,L81BD
	JR L81BF
	.l81bd XOR $10
	.l81bf EX AF,AF ; beware!
	OUT ($FE),A
	EXX
	ADD HL,BC
	JR C,L81C8
	JR L81CA
	.l81c8 XOR $10
	.l81ca NOP
	JP L81CE
	.l81ce EXX
	EX AF,AF ; beware!
	ADD HL,BC
	OUT ($FE),A
	JR C,L81D7
	JR L81D9
	.l81d7 XOR $10
	.l81d9 ADD IX,DE
	JR C,L81DF
	JR L81E1
	.l81df XOR $10
	.l81e1 EX AF,AF ; beware!
	OUT ($FE),A
	EXX
	ADD HL,BC
	JR C,L81EA
	JR L81EC
	.l81ea XOR $10
	.l81ec DEC E
	JP NZ,L8168
	EXX
	EX AF,AF ; beware!
	ADD HL,BC
	OUT ($FE),A
	JR C,L81F9
	JR L81FB
	.l81f9 XOR $10
	.l81fb ADD IX,DE
	JR C,L8201
	JR L8203
	.l8201 XOR $10
	.l8203 EX AF,AF ; beware!
	OUT ($FE),A
	EXX
	ADD HL,BC
	JR C,L820C
	JR L820E
	.l820c XOR $10
	.l820e DEC D
	JP NZ,PLAY_NOTE
	LD (CNT_2),HL
	LD (OUT_2),A
	EXX
	EX AF,AF ; beware!
	LD (CNT_1A),HL
	LD (CNT_1B),IX
	LD (OUT_1),A
	JP MAIN_LOOP
	; ************************************************************
	; * DRUMS - Synthesised
	; ************************************************************
	.drums
	ADD A,A ; On entry A=$75+Drum number (i.e. $76 to $7E)
	LD B,0
	LD C,A
	LD HL,DRUM_TABLE - 236
	ADD HL,BC
	LD E,(HL)
	INC HL
	LD D,(HL)
	EX DE,HL
	JP (HL)
	.drum_tone1 LD L,16
	JR DRUM_TONE
	.drum_tone2 LD L,12
	JR DRUM_TONE
	.drum_tone3 LD L,8
	JR DRUM_TONE
	.drum_tone4 LD L,6
	JR DRUM_TONE
	.drum_tone5 LD L,4
	JR DRUM_TONE
	.drum_tone6 LD L,2
	.drum_tone
	LD DE,3700
	LD BC,$0101
	xor a
	.dt_loop0 OUT ($FE),A
	DEC B
	JR NZ,DT_LOOP1
	XOR 16
	LD B,C
	EX AF,AF ; beware!
	LD A,C
	ADD A,L
	LD C,A
	EX AF,AF ; beware!
	.dt_loop1 DEC E
	JR NZ,DT_LOOP0
	DEC D
	JR NZ,DT_LOOP0
	JP MAIN_LOOP
	.drum_noise1 LD DE,2480
	LD IXL,1
	JR DRUM_NOISE
	.drum_noise2 LD DE,1070
	LD IXL,10
	JR DRUM_NOISE
	.drum_noise3 LD DE,365
	LD IXL,101
	.drum_noise
	LD H,D
	LD L,E
	xor a
	LD C,A
	.dn_loop0 LD A,(HL)
	AND 16
	OR C
	OUT ($FE),A
	LD B,IXL
	.dn_loop1 DJNZ DN_LOOP1
	INC HL
	DEC E
	JR NZ,DN_LOOP0
	DEC D
	JR NZ,DN_LOOP0
	JP MAIN_LOOP
	.pattern_addr DEFW $0000
	.pattern_ptr DEFB 0
	.note_ptr DEFW $0000
	; **************************************************************
	; * Frequency Table
	; **************************************************************
	.freq_table
	DEFW 178,189,200,212,225,238,252,267,283,300,318,337
	DEFW 357,378,401,425,450,477,505,535,567,601,637,675
	DEFW 715,757,802,850,901,954,1011,1071,1135,1202,1274,1350
	DEFW 1430,1515,1605,1701,1802,1909,2023,2143,2270,2405,2548,2700
	DEFW 2860,3030,3211,3402,3604,3818,4046,4286,4541,4811,5097,5400
	; *****************************************************************
	; * Synth Drum Lookup Table
	; *****************************************************************
	.drum_table
	DEFW DRUM_TONE1,DRUM_TONE2,DRUM_TONE3,DRUM_TONE4,DRUM_TONE5,DRUM_TONE6
	DEFW DRUM_NOISE1,DRUM_NOISE2,DRUM_NOISE3
	.musicdata
	DEFB 0 ; Pattern loop begin * 2
	DEFB 8 ; Song length * 2
	DEFW 12 ; Offset to start of song (length of instrument table)
	DEFB 1 ; Multiple
	DEFW 5 ; Detune
	DEFB 1 ; Phase
	DEFB 0 ; Multiple
	DEFW 20 ; Detune
	DEFB 0 ; Phase
	DEFB 1 ; Multiple
	DEFW 15 ; Detune
	DEFB 0 ; Phase
	.patterndata DEFW PAT0
	DEFW PAT0
	DEFW PAT1
	DEFW PAT1
	; *** Pattern data - $00 marks the end of a pattern ***
	.pat0
	DEFB $BD,0
	DEFB 171
	DEFB 152
	DEFB 126
	DEFB 3
	DEFB 188
	DEFB 188
	DEFB 4
	DEFB 171
	DEFB 126
	DEFB 3
	DEFB 168
	DEFB 152
	DEFB 125
	DEFB 3
	DEFB 188
	DEFB 188
	DEFB 4
	DEFB 190
	DEFB 126
	DEFB 3
	DEFB 171
	DEFB 152
	DEFB 126
	DEFB 3
	DEFB 171
	DEFB 188
	DEFB 126
	DEFB 3
	DEFB 190
	DEFB 126
	DEFB 3
	DEFB 168
	DEFB 159
	DEFB 125
	DEFB 3
	DEFB 188
	DEFB 157
	DEFB 4
	DEFB 190
	DEFB 156
	DEFB 126
	DEFB 3
	DEFB 171
	DEFB 152
	DEFB 126
	DEFB 3
	DEFB 188
	DEFB 188
	DEFB 4
	DEFB 171
	DEFB 126
	DEFB 3
	DEFB 168
	DEFB 152
	DEFB 125
	DEFB 3
	DEFB 188
	DEFB 188
	DEFB 4
	DEFB 168
	DEFB 124
	DEFB 3
	DEFB 166
	DEFB 152
	DEFB 125
	DEFB 3
	DEFB 166
	DEFB 188
	DEFB 124
	DEFB 3
	DEFB 190
	DEFB 126
	DEFB 3
	DEFB 168
	DEFB 159
	DEFB 124
	DEFB 3
	DEFB 188
	DEFB 157
	DEFB 121
	DEFB 3
	DEFB 190
	DEFB 156
	DEFB 122
	DEFB 3
	DEFB 168
	DEFB 154
	DEFB 123
	DEFB 3
	DEFB 169
	DEFB 188
	DEFB 4
	DEFB 171
	DEFB 126
	DEFB 3
	DEFB 169
	DEFB 154
	DEFB 125
	DEFB 3
	DEFB 188
	DEFB 188
	DEFB 4
	DEFB 190
	DEFB 126
	DEFB 3
	DEFB 190
	DEFB 154
	DEFB 126
	DEFB 3
	DEFB 190
	DEFB 188
	DEFB 126
	DEFB 3
	DEFB 190
	DEFB 126
	DEFB 3
	DEFB 190
	DEFB 159
	DEFB 125
	DEFB 3
	DEFB 190
	DEFB 157
	DEFB 4
	DEFB 190
	DEFB 156
	DEFB 126
	DEFB 3
	DEFB $BD,4
	DEFB 164
	DEFB 157
	DEFB 126
	DEFB 3
	DEFB 188
	DEFB 188
	DEFB 4
	DEFB 164
	DEFB 126
	DEFB 3
	DEFB 188
	DEFB 157
	DEFB 125
	DEFB 3
	DEFB 159
	DEFB 188
	DEFB 126
	DEFB 3
	DEFB 161
	DEFB 125
	DEFB 3
	DEFB 164
	DEFB 157
	DEFB 126
	DEFB 3
	DEFB 188
	DEFB 188
	DEFB 4
	DEFB 166
	DEFB 126
	DEFB 3
	DEFB 188
	DEFB 159
	DEFB 126
	DEFB 3
	DEFB 164
	DEFB 157
	DEFB 126
	DEFB 3
	DEFB 190
	DEFB 156
	DEFB 125
	DEFB 3
	DEFB $00
	.pat1
	DEFB $BD,2
	DEFB 159
	DEFB 152
	DEFB 126
	DEFB 3
	DEFB 161
	DEFB 152
	DEFB 124
	DEFB 3
	DEFB 159
	DEFB 152
	DEFB 126
	DEFB 3
	DEFB 164
	DEFB 152
	DEFB 125
	DEFB 3
	DEFB 166
	DEFB 152
	DEFB 4
	DEFB 171
	DEFB 152
	DEFB 126
	DEFB 3
	DEFB 169
	DEFB 152
	DEFB 126
	DEFB 3
	DEFB 168
	DEFB 152
	DEFB 126
	DEFB 3
	DEFB 164
	DEFB 152
	DEFB 126
	DEFB 3
	DEFB 166
	DEFB 152
	DEFB 125
	DEFB 3
	DEFB 190
	DEFB 152
	DEFB 4
	DEFB 168
	DEFB 152
	DEFB 126
	DEFB 3
	DEFB $BD,0
	DEFB 159
	DEFB 154
	DEFB 126
	DEFB 3
	DEFB 161
	DEFB 154
	DEFB 4
	DEFB 159
	DEFB 154
	DEFB 126
	DEFB 3
	DEFB 164
	DEFB 154
	DEFB 125
	DEFB 3
	DEFB 166
	DEFB 154
	DEFB 4
	DEFB 171
	DEFB 154
	DEFB 124
	DEFB 3
	DEFB 169
	DEFB 154
	DEFB 125
	DEFB 3
	DEFB 168
	DEFB 154
	DEFB 124
	DEFB 3
	DEFB 164
	DEFB 154
	DEFB 126
	DEFB 3
	DEFB 166
	DEFB 154
	DEFB 124
	DEFB 3
	DEFB 190
	DEFB 154
	DEFB 121
	DEFB 3
	DEFB 164
	DEFB 154
	DEFB 122
	DEFB 3
	DEFB 190
	DEFB 157
	DEFB 123
	DEFB 3
	DEFB 190
	DEFB 157
	DEFB 4
	DEFB 190
	DEFB 157
	DEFB 126
	DEFB 3
	DEFB 190
	DEFB 157
	DEFB 125
	DEFB 3
	DEFB 190
	DEFB 157
	DEFB 4
	DEFB 190
	DEFB 157
	DEFB 126
	DEFB 3
	DEFB 190
	DEFB 157
	DEFB 126
	DEFB 3
	DEFB 190
	DEFB 157
	DEFB 126
	DEFB 3
	DEFB 190
	DEFB 157
	DEFB 126
	DEFB 3
	DEFB 190
	DEFB 157
	DEFB 125
	DEFB 3
	DEFB 190
	DEFB 157
	DEFB 4
	DEFB 190
	DEFB 157
	DEFB 126
	DEFB 3
	DEFB $BD,2
	DEFB 173
	DEFB 159
	DEFB 126
	DEFB 3
	DEFB 190
	DEFB 159
	DEFB 4
	DEFB 171
	DEFB 159
	DEFB 126
	DEFB 3
	DEFB 190
	DEFB 159
	DEFB 125
	DEFB 3
	DEFB 164
	DEFB 159
	DEFB 126
	DEFB 3
	DEFB 190
	DEFB 159
	DEFB 125
	DEFB 3
	DEFB 159
	DEFB 159
	DEFB 126
	DEFB 3
	DEFB 190
	DEFB 159
	DEFB 4
	DEFB 161
	DEFB 159
	DEFB 126
	DEFB 3
	DEFB 161
	DEFB 159
	DEFB 126
	DEFB 3
	DEFB 164
	DEFB 159
	DEFB 126
	DEFB 3
	DEFB 190
	DEFB 159
	DEFB 125
	DEFB 3
	DEFB $00
;	SECTION	text

.i_1
	defm	"            "
	defb	0

	defm	"LEVEL 0X"
	defb	0

	defm	"CONGRATULATIONS!"
	defb	0

	defm	"YOU MANAGED TO SET THE BOMBS!"
	defb	0

	defm	"AND DESTROY THE COMPUTER"
	defb	0

	defm	"MISSION ACCOMPLISHED!!"
	defb	0

	defm	" GAME OVER! "
	defb	0

	defm	" ZONE CLEAR "
	defb	0

	defm	"BOMBS ARE SET! RETURN TO BASE!"
	defm	""
	defb	0

	defm	" SET 5 BOMBS IN EVIL COMPUTER"
	defb	0

	defm	" SET BOMBS IN EVIL COMPUTER "
	defb	0

	defm	"  DONE! NOW GO BACK TO BASE!  "
	defm	""
	defb	0

	defm	" HALF NEW MOTORBIKE FOR SALE! "
	defm	""
	defb	0

	defm	"                              "
	defm	""
	defb	0

;	SECTION	code



; --- Start of Static Variables ---

;	SECTION	bss

.__en_t	defs	1
.__en_x	defs	1
.__en_y	defs	1
._sp_moviles	defs	6
._gpen_cx	defs	1
._gpen_cy	defs	1
.__en_x1	defs	1
.__en_y1	defs	1
.__en_x2	defs	1
.__en_y2	defs	1
._bullets_mx	defs	3
._bullets_my	defs	3
._en_an_base_frame	defs	3
.__en_cx	defs	1
.__en_cy	defs	1
._hotspot_x	defs	1
._hotspot_y	defs	1
._half_life	defs	1
.__en_mx	defs	1
.__en_my	defs	1
._map_pointer	defs	2
._en_an_state	defs	3
._flags	defs	2
._p_facing	defs	1
._p_frame	defs	1
._pregotten	defs	1
._hit_h	defs	1
._p_kill_amt	defs	1
._hit_v	defs	1
._killed_old	defs	1
._gpaux	defs	1
._map_attr	defs	150
._active	defs	1
._p_ct_estado	defs	1
._level	defs	1
._hotspot_destroy	defs	1
._x0	defs	1
._y0	defs	1
._x1	defs	1
._y1	defs	1
.__n	defs	1
.__t	defs	1
.__x	defs	1
.__y	defs	1
._life_old	defs	1
._bullets_estado	defs	3
.__gp_gen	defs	2
._gen_pt	defs	2
._p_current_frame	defs	2
._ptgmx	defs	2
._ptgmy	defs	2
._en_an_current_frame	defs	6
._sp_player	defs	2
._sp_bullets	defs	6
.__b_x	defs	1
.__b_y	defs	1
._enoffs	defs	1
._b_it	defs	1
._sp_cocos	defs	6
._en_an_rawv	defs	3
._p_estado	defs	1
.__b_estado	defs	1
._p_killed	defs	1
._bullets_x	defs	3
._bullets_y	defs	3
._p_ammo	defs	1
._gpen_x	defs	1
._gpen_y	defs	1
._pad0	defs	1
._p_killme	defs	1
._n_pant	defs	1
._p_cont_salto	defs	1
._o_pant	defs	1
._p_life	defs	1
._enit	defs	1
._p_fuel	defs	1
._p_objs	defs	1
._p_gotten	defs	1
._gpcx	defs	1
._gpcy	defs	1
._gpit	defs	1
._gpjt	defs	1
._p_keys	defs	1
._ammo_old	defs	1
._playing	defs	1
._gpox	defs	1
._seed	defs	2
._p_tx	defs	1
._p_ty	defs	1
._asm_int_2	defs	2
._p_vx	defs	2
._p_vy	defs	2
._gpxx	defs	1
._gpyy	defs	1
._objs_old	defs	1
._maincounter	defs	1
._ptx1	defs	1
._ptx2	defs	1
._pty1	defs	1
._pty2	defs	1
._asm_number	defs	1
._p_next_frame	defs	2
._en_an_next_frame	defs	6
._at1	defs	1
._at2	defs	1
.__en_life	defs	1
._cx1	defs	1
._cx2	defs	1
._cy1	defs	1
._cy2	defs	1
._p_subframe	defs	1
._en_an_dead_row	defs	3
._blx	defs	1
._bly	defs	1
._gpc	defs	1
._gpd	defs	1
._hit	defs	1
._rda	defs	1
._rdb	defs	1
._rdc	defs	1
._p_x	defs	2
._AD_FREE	defs	1050
._p_y	defs	2
._cocos_mx	defs	3
._cocos_my	defs	3
._gpx	defs	1
._gpy	defs	1
._rdd	defs	1
._rdn	defs	1
._rdt	defs	1
._itj	defs	2
._keys_old	defs	1
._rdx	defs	1
._rdy	defs	1
._wall_h	defs	1
._enoffsmasi	defs	1
._wall_v	defs	1
._tocado	defs	1
._en_an_alive	defs	3
._is_rendering	defs	1
._cocos_x	defs	3
._cocos_y	defs	3
._slevel	defs	1
._asm_int	defs	2
._p_facing_h	defs	1
.__baddies_pointer	defs	2
._p_facing_v	defs	1
._p_saltando	defs	1
._possee	defs	1
._orig_tile	defs	1
._en_an_frame	defs	3
._success	defs	1
._ram_destination	defs	2
._en_an_count	defs	3
._p_disparando	defs	1
.__b_mx	defs	1
.__b_my	defs	1
._ram_address	defs	2
;	SECTION	code



; --- Start of Scope Defns ---

	LIB	sp_GetKey
	LIB	sp_BlockAlloc
	XDEF	__en_t
	LIB	sp_ScreenStr
	XDEF	__en_x
	XDEF	__en_y
	XDEF	_hotspots
	XDEF	_mons_col_sc_x
	XDEF	_mons_col_sc_y
	XDEF	_draw_scr
	LIB	sp_PixelUp
	XDEF	__bmxo
	XDEF	__bmyo
	XDEF	_prepare_level
	XDEF	_wyz_play_music
	LIB	sp_JoyFuller
	LIB	sp_MouseAMXInit
	XDEF	_blackout_area
	LIB	sp_MouseAMX
	XDEF	_sp_moviles
	XDEF	_sprites
	XDEF	_gpen_cx
	XDEF	_gpen_cy
	XDEF	__en_x1
	LIB	sp_SetMousePosAMX
	XDEF	__en_y1
	XDEF	_u_malloc
	LIB	sp_Validate
	LIB	sp_HashAdd
	XDEF	_cortina
	XDEF	__en_x2
	XDEF	__en_y2
	XDEF	_bullets_mx
	XDEF	_bullets_my
	LIB	sp_Border
	XDEF	_sg_submenu
	LIB	sp_Inkey
	XDEF	_enems_kill
	XDEF	_enems_load
	XDEF	_en_an_base_frame
	XDEF	_enems_init
	XDEF	_draw_objs
	XDEF	__en_cx
	XDEF	__en_cy
	XDEF	_wyz_play_sound
	XDEF	_hotspot_x
	XDEF	_hotspot_y
	LIB	sp_CreateSpr
	LIB	sp_MoveSprAbs
	LIB	sp_BlockCount
	LIB	sp_AddMemory
	XDEF	_half_life
	XDEF	__en_mx
	XDEF	__en_my
	XDEF	_map_pointer
	XDEF	_en_an_state
	XDEF	_enems_move
	LIB	sp_PrintAt
	LIB	sp_Pause
	XDEF	_flags
	LIB	sp_ListFirst
	LIB	sp_HeapSiftUp
	LIB	sp_ListCount
	XDEF	_behs_2
	XDEF	_p_facing
	XDEF	_invalidate_tile
	XDEF	_p_frame
	XDEF	_enems_pursuers_init
	LIB	sp_Heapify
	XDEF	_malotes
	LIB	sp_MoveSprRel
	XDEF	_pregotten
	XDEF	_hit_h
	XDEF	_blackout
	LIB	sp_TileArray
	LIB	sp_MouseSim
	LIB	sp_BlockFit
	XDEF	_map_buff
	defc	_map_buff	=	61697
	XDEF	_p_kill_amt
	XDEF	_hit_v
	LIB	sp_HeapExtract
	LIB	sp_HuffExtract
	XDEF	_killed_old
	LIB	sp_SetMousePosSim
	XDEF	_gpaux
	XDEF	_joyfuncs
	XDEF	_time_over
	LIB	sp_ClearRect
	LIB	sp_HuffGetState
	XDEF	_map_attr
	XDEF	_invalidate_viewport
	XDEF	_active
	XDEF	_p_ct_estado
	LIB	sp_ListAppend
	XDEF	_level
	LIB	sp_ListCreate
	LIB	sp_ListConcat
	XDEF	_limit
	XDEF	_map_bolts_0
	XDEF	_map_bolts_1
	XDEF	_map_bolts_2
	XDEF	_enems_hotspots_0
	XDEF	_enems_hotspots_1
	XDEF	_hotspot_destroy
	XDEF	_enems_hotspots_2
	XDEF	_decos_moto
	LIB	sp_JoyKempston
	LIB	sp_UpdateNow
	LIB	sp_MouseKempston
	LIB	sp_PrintString
	LIB	sp_PixelDown
	LIB	sp_MoveSprAbsC
	LIB	sp_PixelLeft
	XDEF	_hotspots_init
	XDEF	_x0
	LIB	sp_InitAlloc
	XDEF	_espera_activa
	XDEF	_y0
	XDEF	_x1
	XDEF	_y1
	LIB	sp_DeleteSpr
	XDEF	_get_resource
	LIB	sp_JoyTimexEither
	XDEF	__n
	XDEF	_player_kill
	XDEF	__t
	XDEF	_player_init
	XDEF	_wyz_init
	XDEF	_player_hidden
	XDEF	__x
	XDEF	__y
	XDEF	_tileset_0
	XDEF	_tileset_1
	XDEF	_tileset_2
	XDEF	_life_old
	LIB	sp_Invalidate
	LIB	sp_CreateGenericISR
	LIB	sp_JoyKeyboard
	LIB	sp_FreeBlock
	XDEF	_tape_load
	LIB	sp_PrintAtDiff
	LIB	sp_UpdateNowEx
	XDEF	_run_fire_script
	XDEF	_player_move
	XDEF	_bullets_estado
	XDEF	__gp_gen
	XDEF	_gen_pt
	XDEF	_enems_draw_current
	XDEF	_s_marco
	XDEF	_sprite_10_a
	XDEF	_addsign
	XDEF	_sprite_10_b
	XDEF	_sprite_10_c
	XDEF	_sprite_11_a
	XDEF	_sprite_11_b
	XDEF	_tape_save
	XDEF	_level_str
	XDEF	_sprite_11_c
	XDEF	_sprite_12_a
	XDEF	_sprite_12_b
	XDEF	_sprite_12_c
	XDEF	_sprite_13_a
	XDEF	_sprite_13_b
	XDEF	_sprite_13_c
	XDEF	_sprite_14_a
	XDEF	_sprite_14_b
	XDEF	_sprite_14_c
	XDEF	_cm_two_points
	XDEF	_sprite_15_a
	XDEF	_sprite_15_b
	LIB	sp_RegisterHookLast
	LIB	sp_IntLargeRect
	LIB	sp_IntPtLargeRect
	LIB	sp_HashDelete
	LIB	sp_GetCharAddr
	XDEF	_qtile
	XDEF	_mem_load
	LIB	sp_RemoveHook
	XDEF	_p_current_frame
	XDEF	_ptgmx
	XDEF	_ptgmy
	XDEF	_en_an_current_frame
	XDEF	_warp_to_level
	XDEF	_sprite_15_c
	XDEF	_sprite_16_a
	XDEF	_sprite_16_b
	XDEF	_sprite_16_c
	LIB	sp_MoveSprRelC
	LIB	sp_InitIM2
	XDEF	_sprite_17_a
	XDEF	_sprite_18_a
	XDEF	_sprite_19_a
	XREF	_sprite_19_b
	XDEF	_decos_computer
	XDEF	_decos_bombs
	XDEF	_sp_player
	XDEF	_sp_bullets
	XDEF	_beep_fx
	LIB	sp_GetTiles
	XDEF	__b_x
	XDEF	__b_y
	XDEF	_mem_save
	LIB	sp_Pallette
	LIB	sp_WaitForNoKey
	XDEF	_enoffs
	XDEF	_safe_byte
	defc	_safe_byte	=	23296
	XDEF	_b_it
	XDEF	_locks_init
	XDEF	_utaux
	XDEF	__bxo
	LIB	sp_JoySinclair1
	LIB	sp_JoySinclair2
	XDEF	__byo
	LIB	sp_ListPrepend
	XDEF	_sp_cocos
	XDEF	_behs
	XDEF	_en_an_rawv
	XDEF	_draw_invalidate_coloured_tile_g
	XDEF	_p_estado
	XDEF	__b_estado
	XDEF	_bullets_fire
	XDEF	_p_killed
	LIB	sp_GetAttrAddr
	XDEF	_bullets_x
	XDEF	_bullets_y
	XDEF	_p_ammo
	XDEF	_gpen_x
	XDEF	_gpen_y
	XDEF	_enem_cells
	LIB	sp_HashCreate
	XDEF	_pad0
	XDEF	_p_killme
	LIB	sp_Random32
	LIB	sp_ListInsert
	XDEF	_n_pant
	LIB	sp_ListFree
	XDEF	_bullets_init
	XDEF	_ISR
	LIB	sp_IntRect
	LIB	sp_ListLast
	XDEF	_p_cont_salto
	LIB	sp_ListCurr
	XDEF	_o_pant
	XDEF	_p_life
	XDEF	_enit
	XDEF	_print_number2
	XDEF	_p_fuel
	XDEF	_pause_screen
	XDEF	_mapa
	LIB	sp_ListSearch
	LIB	sp_WaitForKey
	XDEF	_main
	XDEF	_draw_coloured_tile
	LIB	sp_Wait
	LIB	sp_GetScrnAddr
	XDEF	_attr
	LIB	sp_PutTiles
	XDEF	_joyfunc
	XDEF	_p_objs
	XDEF	_p_gotten
	XDEF	_gpcx
	XDEF	_gpcy
	XDEF	_s_title
	XDEF	_font
	LIB	sp_RemoveDList
	XDEF	_gpit
	XDEF	_gpjt
	XDEF	_p_keys
	XDEF	_ammo_old
	XDEF	_playing
	XDEF	_player_cells
	XDEF	_bullets_move
	XDEF	_player_calc_bounding_box
	LIB	sp_ListNext
	XDEF	_gpox
	LIB	sp_HuffDecode
	XDEF	_keys
	XDEF	_rand
	LIB	sp_Swap
	XDEF	_seed
	XDEF	_p_tx
	XDEF	_p_ty
	XDEF	_print_str
	XDEF	_add_tilanim
	XDEF	_asm_int_2
	XDEF	_player_deplete
	XDEF	_p_vx
	XDEF	_p_vy
	XDEF	_gpxx
	XDEF	_gpyy
	XDEF	_objs_old
	XDEF	_levels
	LIB	sp_ListPrev
	XDEF	_lame_sound
	XDEF	_maincounter
	XDEF	_ptx1
	XDEF	_ptx2
	XDEF	_pty1
	XDEF	_pty2
	XDEF	_asm_number
	LIB	sp_RegisterHook
	LIB	sp_ListRemove
	LIB	sp_ListTrim
	LIB	sp_MoveSprAbsNC
	XDEF	_break_wall
	LIB	sp_HuffDelete
	XDEF	_update_tile
	XDEF	_p_next_frame
	XDEF	_en_an_next_frame
	XDEF	_cerrojos
	XDEF	_at1
	XDEF	_at2
	XDEF	_level_data
	LIB	sp_ListAdd
	LIB	sp_KeyPressed
	XDEF	_step
	XDEF	__en_life
	LIB	sp_PrintAtInv
	XDEF	_draw_coloured_tile_gamearea
	XDEF	_cx1
	XDEF	_cx2
	XDEF	_cy1
	XDEF	_cy2
	LIB	sp_CompDListAddr
	XDEF	_draw_decorations
	XDEF	_p_subframe
	XDEF	_en_an_dead_row
	XDEF	_u_free
	XDEF	_abs
	XDEF	__dx
	XDEF	__dy
	XDEF	_game_ending
	LIB	sp_CharRight
	XDEF	_s_ending
	XDEF	_bullets_update
	XDEF	_blx
	XDEF	_bly
	LIB	sp_InstallISR
	XDEF	_gpc
	XDEF	_gpd
	LIB	sp_HuffAccumulate
	LIB	sp_HuffSetState
	XDEF	_brk_buff
	defc	_brk_buff	=	23297
	XDEF	_hit
	XDEF	_hotspots_do
	XDEF	_sprite_1_a
	XDEF	_sprite_1_b
	XDEF	_sprite_1_c
	XDEF	_sprite_2_a
	XDEF	_sprite_2_b
	XDEF	_rda
	XDEF	_rdb
	XDEF	_rdc
	LIB	sp_SwapEndian
	LIB	sp_CharLeft
	XDEF	_p_x
	XDEF	_AD_FREE
	LIB	sp_CharDown
	LIB	sp_HeapSiftDown
	LIB	sp_HuffCreate
	XDEF	_p_y
	XDEF	_cocos_mx
	XDEF	_cocos_my
	XDEF	_gpx
	XDEF	_gpy
	XDEF	_rdd
	LIB	sp_HuffEncode
	XDEF	_rdn
	XDEF	_rdt
	XDEF	_itj
	XDEF	_keys_old
	XDEF	_sprite_2_c
	LIB	sp_JoyTimexRight
	LIB	sp_PixelRight
	XDEF	_rdx
	XDEF	_rdy
	XDEF	_sprite_3_a
	LIB	sp_Initialize
	XDEF	_sprite_3_b
	XDEF	_sprite_3_c
	XDEF	_sprite_4_a
	XDEF	_process_tile
	XDEF	_tileset
	XDEF	_sprite_4_b
	LIB	sp_JoyTimexLeft
	LIB	sp_SetMousePosKempston
	XDEF	_sprite_4_c
	XDEF	_sprite_5_a
	XDEF	_sprite_5_b
	LIB	sp_ComputePos
	XDEF	_sprite_5_c
	XDEF	_sprite_6_a
	XDEF	_wyz_stop_sound
	XDEF	_sprite_6_b
	XDEF	_sprite_6_c
	XDEF	_sprite_7_a
	XDEF	_sprite_7_b
	XDEF	_sprite_7_c
	XDEF	_sprite_8_a
	XDEF	_sprite_8_b
	XDEF	_sprite_8_c
	XDEF	_sprite_9_a
	XDEF	_wall_h
	XDEF	_sprite_9_b
	XDEF	_sprite_9_c
	XDEF	_behs_0_1
	XDEF	_enoffsmasi
	XDEF	_spacer
	XDEF	_do_tilanims
	XDEF	_wall_v
	LIB	sp_IntIntervals
	XDEF	_my_malloc
	XDEF	_tocado
	XDEF	_en_an_alive
	XDEF	_is_rendering
	LIB	sp_inp
	XDEF	_cocos_x
	XDEF	_SetRAMBank
	LIB	sp_IterateSprChar
	XDEF	_cocos_y
	LIB	sp_AddColSpr
	LIB	sp_outp
	XDEF	_simple_coco_init
	XDEF	_slevel
	XDEF	_asm_int
	XDEF	_p_facing_h
	LIB	sp_IntPtInterval
	LIB	sp_RegisterHookFirst
	XDEF	__baddies_pointer
	LIB	sp_HashLookup
	XDEF	_p_facing_v
	XDEF	_p_saltando
	LIB	sp_PFill
	XDEF	_zone_clear
	XDEF	_possee
	LIB	sp_HashRemove
	LIB	sp_CharUp
	XDEF	_collide
	XDEF	_orig_tile
	XDEF	_en_an_frame
	XDEF	_success
	LIB	sp_MoveSprRelNC
	XDEF	_simple_coco_shoot
	XDEF	_ram_destination
	XDEF	_en_an_count
	XDEF	_select_joyfunc
	XDEF	_unpack
	XDEF	_clear_sprites
	XDEF	_p_disparando
	LIB	sp_IterateDList
	XDEF	_distance
	XDEF	_draw_scr_background
	XDEF	__b_mx
	XDEF	__b_my
	XDEF	_simple_coco_update
	XDEF	_game_over
	LIB	sp_LookupKey
	LIB	sp_HeapAdd
	LIB	sp_CompDirtyAddr
	LIB	sp_EmptyISR
	XDEF	_ram_address
	LIB	sp_StackSpace


; --- End of Scope Defns ---


; --- End of Compilation ---
