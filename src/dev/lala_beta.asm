;* * * * *  Small-C/Plus z88dk * * * * *
;  Version: 20100416.1
;
;	Reconstructed for z80 Module Assembler
;
;	Module compile time: Tue Oct 20 06:54:43 2020



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

;	SECTION	text

._behs
	defm	""
	defb	0

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	1

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	10

	defm	""
	defb	10

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

;	SECTION	code


	.vpClipStruct defb 2, 2 + 20, 1, 1 + 30
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


	defw 0

._ISR
	ld	hl,(_isrc)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_isrc),a
	ret


	.playsfx
	;di
	ld l,a
	ld h,0
	add hl,hl
	ld de,proclist
	add hl,de
	ld a,(hl)
	inc hl
	ld h,(hl)
	ld l,a
	ld de,0
	jp (hl)
	.sound1 ;enemy destroyed
	ex de,hl
	ld bc,500
	.sound1l0
	ld a,(hl)
	and 16
	out ($FE),a
	ld e,a
	inc a
	sla a
	sla a
	.sound1l1
	dec a
	jr nz,sound1l1
	out ($FE),a
	ld a,e
	inc a
	add a,a
	add a,a
	add a,a
	.sound1l2
	dec a
	jr nz,sound1l2
	ld a,b
	inc hl
	dec bc
	ld a,b
	or c
	jr nz,sound1l0
	;ei
	ret
	.sound2 ;enemy hit
	ex de,hl
	ld bc,40*256+100
	.sound2l0
	ld a,(hl)
	and 16
	out ($FE),a
	inc hl
	ld a,c
	.sound2l1
	dec a
	jr nz,sound2l1
	out ($FE),a
	ld a,c
	.sound2l2
	dec a
	jr nz,sound2l2
	djnz sound2l0
	;ei
	ret
	.sound3 ;something
	ex de,hl
	ld b,100
	ld de,$1020
	.sound3l0
	ld a,(hl)
	and d
	out ($FE),a
	inc hl
	ld a,e
	.sound3l0a
	dec a
	jr nz,sound3l0a
	djnz sound3l0
	ld b,250
	.sound3l1
	ld a,(hl)
	and d
	out ($FE),a
	inc hl
	ld a,2
	.sound3l2
	dec a
	jr nz,sound3l2
	xor a
	out ($FE),a
	ld a,e
	.sound3l3
	dec a
	jr nz,sound3l3
	djnz sound3l1
	;ei
	ret
	.sound4 ;jump
	ld bc,20*256+250
	.sound4l0
	ld a,16
	out ($FE),a
	ld a,4
	.sound4l1
	dec a
	jr nz,sound4l1
	out ($FE),a
	ld a,c
	.sound4l2
	dec a
	jr nz,sound4l2
	dec c
	dec c
	djnz sound4l0
	;ei
	ret
	.sound5 ;player hit
	ex de,hl
	ld bc,100*256+16
	.sound5l0
	ld a,(hl)
	and c
	out ($FE),a
	inc hl
	ld a,110
	sub b
	ld e,a
	and c
	out ($FE),a
	.sound5l1
	dec e
	jr nz,sound5l1
	djnz sound5l0
	;ei
	ret
	.sound6 ;enemy destroyed 2
	ex de,hl
	ld bc,20*256+16
	.sound6l0
	ld a,(hl)
	inc hl
	and c
	out ($FE),a
	xor a
	.sound6l0a
	dec a
	jr nz,sound6l0a
	djnz sound6l0
	.sound6l1
	ld a,(hl)
	inc hl
	and c
	out ($FE),a
	.sound6l2
	dec a
	jr nz,sound6l2
	djnz sound6l1
	;ei
	ret
	.sound7 ;shot
	ex de,hl
	ld bc,100*256
	.sound7l0
	ld a,(hl)
	inc hl
	or c
	and 16
	out ($FE),a
	ld a,(hl)
	srl a
	srl a
	.sound7l1
	dec a
	jr nz,sound7l1
	ld a,c
	add a,4
	ld c,a
	djnz sound7l0
	;ei
	ret
	.sound8 ;take item
	ld a,200
	jr soundItem
	.sound9
	ld a,175
	jr soundItem
	.sound10
	ld a,100
	.soundItem
	ld (frq),a
	ld b,4
	ld d,128
	.sound8l2
	push bc
	;.frq=$+1
	; ld bc,2*256+200
	defb #01 ;ld bc
	.frq
	defb 200 ;+200
	defb 2 ;2*256
	.sound8l0
	push bc
	ld b,50
	.sound8l1
	xor 16
	and 16
	out ($FE),a
	ld e,a
	ld a,d
	.sound8l2b
	dec a
	jr nz,sound8l2b
	out ($FE),a
	ld a,129
	sub d
	.sound8l3
	dec a
	jr nz,sound8l3
	ld a,e
	ld e,c
	.sound8l4
	dec e
	jr nz,sound8l4
	djnz sound8l1
	pop bc
	ld a,c
	sub 16
	ld c,a
	djnz sound8l0
	pop bc
	srl d
	srl d
	djnz sound8l2
	;ei
	ret
	.proclist
	defw sound1
	defw sound2
	defw sound3
	defw sound4
	defw sound5
	defw sound6
	defw sound7
	defw sound8
	defw sound9
	defw sound10

._beep_fx
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	(_asm_int),hl
	ld a, (_asm_int)
	call playsfx
	ret


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
	._s_title
	BINARY "title.bin"
	._s_marco
	BINARY "marco.bin"
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


;	SECTION	text

._mapa
	defm	""
	defb	18

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"UUQ"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"UUU"
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"UUUR"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	224

	defm	""
	defb	21

	defm	"UUU"
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	226

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	208

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	25

	defm	""
	defb	208

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	3

	defm	"331"
	defb	153

	defm	""
	defb	208

	defm	""
	defb	0

	defm	""
	defb	21

	defm	"UUU"
	defb	0

	defm	""
	defb	192

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	11

	defm	""
	defb	203

	defm	""
	defb	176

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"UUU"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	5

	defm	"U"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"@UPUU"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	6

	defm	"eU"
	defb	5

	defm	"UQ"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	17

	defm	""
	defb	16

	defm	""
	defb	18

	defm	""
	defb	17

	defm	""
	defb	16

	defm	""
	defb	4

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	0

	defm	"`"
	defb	0

	defm	"3333$"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	5

	defm	"UUUQ`"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	6

	defm	"`"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	6

	defm	"`"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"`"
	defb	0

	defm	"@"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	4

	defm	""
	defb	0

	defm	"`"
	defb	0

	defm	""
	defb	6

	defm	"`"
	defb	0

	defm	""
	defb	0

	defm	"f"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	4

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"f"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"f"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	6

	defm	"`"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	192

	defm	""
	defb	0

	defm	""
	defb	176

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	203

	defm	""
	defb	192

	defm	""
	defb	188

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"UUU["
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"UUUUP"
	defb	0

	defm	""
	defb	0

	defm	"UUUUUP"
	defb	0

	defm	"UUUUUUP"
	defb	1

	defm	""
	defb	18

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	"!"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	3

	defm	"1"
	defb	17

	defm	" 333"
	defb	0

	defm	"1"
	defb	16

	defm	""
	defb	0

	defm	""
	defb	3

	defm	"33 "
	defb	0

	defm	"3333"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	3

	defm	"3330"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"31"
	defb	3

	defm	"3"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	3

	defm	"3"
	defb	0

	defm	"30"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"3333"
	defb	0

	defm	""
	defb	0

	defm	"P"
	defb	1

	defm	""
	defb	3

	defm	"33$"
	defb	0

	defm	""
	defb	5

	defm	""
	defb	0

	defm	"'wwq`"
	defb	0

	defm	""
	defb	16

	defm	""
	defb	1

	defm	""
	defb	17

	defm	"!"
	defb	17

	defm	""
	defb	16

	defm	""
	defb	0

	defm	"A"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	6

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	12

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"UUUUP"
	defb	0

	defm	""
	defb	0

	defm	"UUUUUP"
	defb	0

	defm	"UUUUUUPUUUUUUUUUUUUUUU"
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	240

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	2

	defm	""
	defb	26

	defm	""
	defb	153

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	9

	defm	""
	defb	157

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	" "
	defb	154

	defm	""
	defb	157

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	10

	defm	""
	defb	9

	defm	""
	defb	157

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	17

	defm	" "
	defb	0

	defm	""
	defb	154

	defm	""
	defb	145

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	0

	defm	""
	defb	10

	defm	""
	defb	9

	defm	" "
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	145

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	9

	defm	""
	defb	16

	defm	""
	defb	1

	defm	""
	defb	0

	defm	""
	defb	17

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	161

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	30

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"32"
	defb	0

	defm	""
	defb	4

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	3

	defm	"3"
	defb	16

	defm	""
	defb	4

	defm	"`"
	defb	1

	defm	""
	defb	0

	defm	""
	defb	16

	defm	"31"
	defb	0

	defm	"`"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	3

	defm	"<"
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"3"
	defb	17

	defm	""
	defb	224

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	2

	defm	""
	defb	19

	defm	"0"
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	2

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"31"
	defb	0

	defm	"@"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	3

	defm	"3"
	defb	16

	defm	""
	defb	6

	defm	"`"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"31"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"@"
	defb	0

	defm	""
	defb	0

	defm	"f"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"f"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	4

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"@"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"f"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	6

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	12

	defm	""
	defb	12

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	6

	defm	"`"
	defb	0

	defm	""
	defb	176

	defm	""
	defb	176

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	13

	defm	""
	defb	13

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	160

	defm	""
	defb	160

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	16

	defm	""
	defb	3

	defm	"3331"
	defb	0

	defm	" "
	defb	3

	defm	"3331"
	defb	16

	defm	""
	defb	1

	defm	""
	defb	3

	defm	"33"
	defb	16

	defm	"3"
	defb	1

	defm	""
	defb	0

	defm	""
	defb	16

	defm	"330"
	defb	3

	defm	"3 "
	defb	1

	defm	""
	defb	3

	defm	""
	defb	16

	defm	"3330"
	defb	0

	defm	""
	defb	16

	defm	"0"
	defb	3

	defm	"3330"
	defb	1

	defm	""
	defb	192

	defm	"33"
	defb	16

	defm	"33p"
	defb	21

	defm	"P30"
	defb	3

	defm	"3"
	defb	17

	defm	""
	defb	2

	defm	""
	defb	18

	defm	""
	defb	3

	defm	"33"
	defb	16

	defm	"2"
	defb	0

	defm	""
	defb	16

	defm	""
	defb	0

	defm	"330"
	defb	3

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	16

	defm	""
	defb	4

	defm	""
	defb	132

	defm	"D"
	defb	132

	defm	"D"
	defb	132

	defm	"A"
	defb	4

	defm	""
	defb	221

	defm	""
	defb	221

	defm	""
	defb	221

	defm	""
	defb	221

	defm	""
	defb	221

	defm	""
	defb	221

	defm	""
	defb	16

	defm	""
	defb	217

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	145

	defm	""
	defb	10

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	16

	defm	""
	defb	1

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"w"
	defb	16

	defm	"33"
	defb	0

	defm	""
	defb	3

	defm	"31"
	defb	17

	defm	""
	defb	3

	defm	"30"
	defb	0

	defm	"33"
	defb	0

	defm	""
	defb	16

	defm	"33"
	defb	0

	defm	""
	defb	3

	defm	"3"
	defb	16

	defm	""
	defb	1

	defm	""
	defb	3

	defm	"30"
	defb	0

	defm	"30"
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	17

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	16

	defm	"33"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"!"
	defb	192

	defm	"30"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	17

	defm	""
	defb	16

	defm	"3"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	12

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	3

	defm	"0"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	12

	defm	""
	defb	177

	defm	"333"
	defb	0

	defm	""
	defb	0

	defm	"1"
	defb	17

	defm	""
	defb	19

	defm	"330"
	defb	0

	defm	""
	defb	3

	defm	""
	defb	0

	defm	""
	defb	2

	defm	""
	defb	16

	defm	"33"
	defb	0

	defm	""
	defb	0

	defm	"33"
	defb	16

	defm	""
	defb	3

	defm	"30"
	defb	0

	defm	""
	defb	3

	defm	"31 "
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"!"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	23

	defm	"w "
	defb	0

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	0

	defm	""
	defb	2

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"1"
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	2

	defm	""
	defb	3

	defm	"33"
	defb	2

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	16

	defm	"333"
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	3

	defm	"331"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	16

	defm	"3"
	defb	18

	defm	""
	defb	17

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	3

	defm	"3"
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"31"
	defb	224

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	3

	defm	"3 `"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	16

	defm	"31"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	3

	defm	";"
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	2

	defm	""
	defb	3

	defm	"31"
	defb	17

	defm	""
	defb	0

	defm	""
	defb	224

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"33"
	defb	0

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	3

	defm	"3332"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"2www"
	defb	22

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	17

	defm	""
	defb	18

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	7

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	215

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	9

	defm	""
	defb	215

	defm	""
	defb	7

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"p"
	defb	0

	defm	""
	defb	170

	defm	""
	defb	215

	defm	""
	defb	212

	defm	"p"
	defb	0

	defm	"}"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	9

	defm	""
	defb	217

	defm	""
	defb	221

	defm	""
	defb	0

	defm	""
	defb	13

	defm	""
	defb	160

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	169

	defm	""
	defb	170

	defm	""
	defb	157

	defm	""
	defb	13

	defm	""
	defb	144

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	160

	defm	""
	defb	10

	defm	""
	defb	160

	defm	""
	defb	170

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	3

	defm	"33331"
	defb	0

	defm	" 33333"
	defb	16

	defm	""
	defb	1

	defm	""
	defb	3

	defm	"33332"
	defb	0

	defm	""
	defb	18

	defm	""
	defb	3

	defm	"3333"
	defb	16

	defm	""
	defb	1

	defm	""
	defb	0

	defm	"33331"
	defb	0

	defm	""
	defb	16

	defm	"33333"
	defb	16

	defm	""
	defb	1

	defm	""
	defb	3

	defm	"33331"
	defb	0

	defm	""
	defb	16

	defm	"33333"
	defb	16

	defm	""
	defb	1

	defm	"wwww"
	defb	16

	defm	"1"
	defb	0

	defm	""
	defb	17

	defm	"!"
	defb	17

	defm	"!"
	defb	17

	defm	""
	defb	3

	defm	" "
	defb	0

	defm	""
	defb	16

	defm	"33"
	defb	0

	defm	""
	defb	3

	defm	"30"
	defb	1

	defm	""
	defb	16

	defm	"30"
	defb	0

	defm	"33"
	defb	0

	defm	""
	defb	27

	defm	""
	defb	3

	defm	"3"
	defb	0

	defm	""
	defb	3

	defm	"30"
	defb	1

	defm	""
	defb	17

	defm	""
	defb	3

	defm	"0"
	defb	0

	defm	"3"
	defb	17

	defm	""
	defb	0

	defm	""
	defb	16

	defm	""
	defb	0

	defm	"3"
	defb	0

	defm	""
	defb	3

	defm	"0"
	defb	0

	defm	""
	defb	1

	defm	""
	defb	3

	defm	"30"
	defb	0

	defm	"33"
	defb	0

	defm	""
	defb	16

	defm	"33"
	defb	0

	defm	""
	defb	3

	defm	"30"
	defb	1

	defm	""
	defb	3

	defm	"30"
	defb	0

	defm	"33"
	defb	0

	defm	""
	defb	23

	defm	"www"
	defb	183

	defm	"wp"
	defb	1

	defm	""
	defb	18

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	"333"
	defb	0

	defm	""
	defb	0

	defm	"33#330"
	defb	0

	defm	""
	defb	3

	defm	"31333"
	defb	0

	defm	""
	defb	0

	defm	"3<"
	defb	17

	defm	""
	defb	16

	defm	"30"
	defb	0

	defm	""
	defb	3

	defm	"3"
	defb	17

	defm	""
	defb	0

	defm	""
	defb	3

	defm	"3"
	defb	0

	defm	""
	defb	0

	defm	"30"
	defb	19

	defm	"330"
	defb	0

	defm	""
	defb	3

	defm	"31333"
	defb	3

	defm	"31"
	defb	3

	defm	"#33033"
	defb	0

	defm	"1wwww"
	defb	16

	defm	"33"
	defb	17

	defm	""
	defb	17

	defm	""
	defb	18

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	16

	defm	"31"
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	3

	defm	"1"
	defb	18

	defm	""
	defb	17

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	16

	defm	"3"
	defb	0

	defm	""
	defb	0

	defm	" "
	defb	0

	defm	""
	defb	0

	defm	""
	defb	3

	defm	"3"
	defb	224

	defm	"31"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"30"
	defb	3

	defm	"3"
	defb	17

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	17

	defm	""
	defb	3

	defm	"331"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	30

	defm	""
	defb	3

	defm	"33"
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	0

	defm	"3>"
	defb	1

	defm	""
	defb	7

	defm	"w"
	defb	0

	defm	""
	defb	16

	defm	"33"
	defb	0

	defm	""
	defb	16

	defm	"UP"
	defb	1

	defm	"wuUR"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	18

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"3333"
	defb	16

	defm	""
	defb	14

	defm	""
	defb	0

	defm	""
	defb	3

	defm	"0"
	defb	0

	defm	""
	defb	0

	defm	"1"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"3"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	3

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	3

	defm	"0"
	defb	14

	defm	""
	defb	0

	defm	"2"
	defb	224

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"3"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	3

	defm	""
	defb	16

	defm	"`"
	defb	0

	defm	""
	defb	3

	defm	"0"
	defb	0

	defm	""
	defb	0

	defm	"1"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"U"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	5

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	17

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	17

	defm	""
	defb	0

	defm	""
	defb	6

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"@"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	12

	defm	""
	defb	0

	defm	""
	defb	6

	defm	""
	defb	192

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	4

	defm	"`"
	defb	0

	defm	""
	defb	6

	defm	"@"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	4

	defm	"`"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	6

	defm	"LD"
	defb	180

	defm	"`"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	6

	defm	"ff`"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	17

	defm	""
	defb	18

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	16

	defm	"1"
	defb	0

	defm	" "
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	3

	defm	""
	defb	16

	defm	""
	defb	1

	defm	""
	defb	3

	defm	"33331"
	defb	0

	defm	""
	defb	16

	defm	"33333 "
	defb	2

	defm	""
	defb	17

	defm	"!"
	defb	3

	defm	""
	defb	17

	defm	"!"
	defb	17

	defm	""
	defb	0

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"0"
	defb	0

	defm	""
	defb	0

	defm	" "
	defb	1

	defm	""
	defb	3

	defm	"33331"
	defb	0

	defm	""
	defb	16

	defm	"33333"
	defb	16

	defm	""
	defb	2

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	18

	defm	""
	defb	17

	defm	""
	defb	3

	defm	"1"
	defb	0

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"3"
	defb	16

	defm	""
	defb	0

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	18

	defm	""
	defb	17

	defm	""
	defb	18

	defm	""
	defb	17

	defm	""
	defb	16

	defm	""
	defb	1

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	3

	defm	"0"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"3"
	defb	0

	defm	"0"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	3

	defm	"0"
	defb	1

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"3"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	12

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	3

	defm	"0"
	defb	3

	defm	""
	defb	0

	defm	""
	defb	11

	defm	""
	defb	187

	defm	""
	defb	203

	defm	"{"
	defb	199

	defm	"wp"
	defb	1

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	18

	defm	""
	defb	17

	defm	""
	defb	3

	defm	"3"
	defb	17

	defm	"!"
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	16

	defm	"3"
	defb	17

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	3

	defm	"0 "
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	"3"
	defb	0

	defm	"30330"
	defb	18

	defm	""
	defb	0

	defm	""
	defb	3

	defm	"3"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	2

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"30"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	19

	defm	"0"
	defb	3

	defm	"3"
	defb	3

	defm	"331ww"
	defb	188

	defm	""
	defb	0

	defm	"333"
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	3

	defm	"31 "
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	18

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	188

	defm	"331"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	3

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"2"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"3333"
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	3

	defm	"331"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	4

	defm	""
	defb	28

	defm	"8"
	defb	8

	defm	""
	defb	3

	defm	"$"
	defb	132

	defm	""
	defb	132

	defm	""
	defb	221

	defm	""
	defb	221

	defm	""
	defb	221

	defm	""
	defb	221

	defm	""
	defb	209

	defm	""
	defb	221

	defm	""
	defb	221

	defm	""
	defb	218

	defm	""
	defb	169

	defm	""
	defb	153

	defm	""
	defb	170

	defm	""
	defb	169

	defm	""
	defb	17

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	17

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	224

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	224

	defm	""
	defb	1

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	30

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"`"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	224

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	15

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	22

	defm	""
	defb	0

	defm	""
	defb	4

	defm	""
	defb	128

	defm	""
	defb	1

	defm	""
	defb	188

	defm	""
	defb	0

	defm	""
	defb	1

	defm	""
	defb	0

	defm	""
	defb	4

	defm	""
	defb	221

	defm	""
	defb	221

	defm	""
	defb	221

	defm	""
	defb	221

	defm	""
	defb	12

	defm	""
	defb	20

	defm	"D"
	defb	217

	defm	""
	defb	154

	defm	""
	defb	169

	defm	""
	defb	153

	defm	""
	defb	157

	defm	""
	defb	221

	defm	""
	defb	221

	defm	""
	defb	217

	defm	""
	defb	153

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	6

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"HD"
	defb	132

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"M"
	defb	221

	defm	""
	defb	221

	defm	""
	defb	212

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"M"
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	212

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"M"
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	212

	defm	""
	defb	132

	defm	"-"
	defb	153

	defm	""
	defb	153

	defm	""
	defb	154

	defm	""
	defb	170

	defm	""
	defb	153

	defm	""
	defb	221

	defm	""
	defb	221

	defm	""
	defb	153

	defm	""
	defb	154

	defm	""
	defb	170

	defm	""
	defb	0

	defm	""
	defb	10

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	154

	defm	""
	defb	170

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	10

	defm	""
	defb	169

	defm	""
	defb	153

	defm	""
	defb	1

	defm	""
	defb	3

	defm	"33331"
	defb	0

	defm	""
	defb	16

	defm	"3330"
	defb	17

	defm	" "
	defb	1

	defm	""
	defb	3

	defm	"333 "
	defb	1

	defm	""
	defb	0

	defm	" 3"
	defb	192

	defm	"30"
	defb	3

	defm	""
	defb	16

	defm	""
	defb	1

	defm	""
	defb	3

	defm	";"
	defb	3

	defm	""
	defb	192

	defm	"31"
	defb	0

	defm	""
	defb	240

	defm	"<"
	defb	188

	defm	""
	defb	11

	defm	""
	defb	3

	defm	"3"
	defb	240

	defm	""
	defb	17

	defm	""
	defb	27

	defm	""
	defb	188

	defm	""
	defb	188

	defm	""
	defb	187

	defm	""
	defb	3

	defm	""
	defb	17

	defm	""
	defb	29

	defm	""
	defb	221

	defm	""
	defb	221

	defm	""
	defb	221

	defm	""
	defb	221

	defm	""
	defb	221

	defm	""
	defb	220

	defm	""
	defb	17

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	170

	defm	""
	defb	169

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	221

	defm	""
	defb	217

	defm	""
	defb	154

	defm	""
	defb	160

	defm	""
	defb	0

	defm	""
	defb	170

	defm	""
	defb	170

	defm	""
	defb	170

	defm	""
	defb	153

	defm	""
	defb	0

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"3333330"
	defb	3

	defm	""
	defb	3

	defm	"30303"
	defb	0

	defm	""
	defb	0

	defm	"0"
	defb	3

	defm	""
	defb	3

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	"0"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	" D"
	defb	132

	defm	"D"
	defb	132

	defm	"D"
	defb	132

	defm	"A-"
	defb	221

	defm	""
	defb	221

	defm	""
	defb	221

	defm	""
	defb	221

	defm	""
	defb	221

	defm	""
	defb	221

	defm	""
	defb	221

	defm	""
	defb	154

	defm	""
	defb	169

	defm	""
	defb	153

	defm	""
	defb	153

	defm	""
	defb	154

	defm	""
	defb	169

	defm	""
	defb	153

	defm	""
	defb	154

	defm	""
	defb	0

	defm	""
	defb	169

	defm	""
	defb	153

	defm	""
	defb	154

	defm	""
	defb	0

	defm	""
	defb	169

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	""
	defb	16

	defm	"33"
	defb	16

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	3

	defm	"1"
	defb	17

	defm	"333331"
	defb	17

	defm	"#3"
	defb	3

	defm	"03"
	defb	17

	defm	""
	defb	17

	defm	""
	defb	17

	defm	"0"
	defb	0

	defm	""
	defb	0

	defm	""
	defb	3

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	16

	defm	""
	defb	0

	defm	""
	defb	4

	defm	"HD@31HD"
	defb	221

	defm	""
	defb	221

	defm	""
	defb	221

	defm	"D"
	defb	3

	defm	""
	defb	29

	defm	""
	defb	221

	defm	""
	defb	217

	defm	""
	defb	169

	defm	""
	defb	153

	defm	""
	defb	157

	defm	""
	defb	212

	defm	""
	defb	2

	defm	""
	defb	154

	defm	""
	defb	153

	defm	""
	defb	160

	defm	""
	defb	169

	defm	""
	defb	169

	defm	""
	defb	153

	defm	""
	defb	212

	defm	""
	defb	26

	defm	""
	defb	10

	defm	""
	defb	160

	defm	""
	defb	0

	defm	""
	defb	160

	defm	""
	defb	170

	defm	""
	defb	154

	defm	""
	defb	209

;	SECTION	code


;	SECTION	text

._cerrojos
	defb	5
	defb	6
	defb	8
	defb	0
	defb	25
	defb	8
	defb	5
	defb	0
	defb	27
	defb	1
	defb	5
	defb	0
	defb	27
	defb	13
	defb	5
	defb	0

;	SECTION	code

	._tileset
	BINARY "tileset.bin"
;	SECTION	text

._malotes
	defb	64
	defb	16
	defb	64
	defb	16
	defb	64
	defb	128
	defb	0
	defb	4
	defb	3
	defs	1
	defb	208
	defb	16
	defb	208
	defb	16
	defb	96
	defb	16
	defb	-2
	defb	0
	defb	0
	defs	1
	defb	192
	defb	0
	defb	192
	defb	0
	defb	112
	defb	0
	defb	-2
	defb	0
	defb	0
	defs	1
	defb	128
	defb	0
	defb	128
	defb	0
	defb	128
	defb	64
	defb	0
	defb	1
	defb	2
	defs	1
	defb	144
	defb	16
	defb	144
	defb	16
	defb	176
	defb	96
	defb	2
	defb	2
	defb	2
	defs	1
	defb	48
	defb	64
	defb	48
	defb	64
	defb	48
	defb	128
	defb	0
	defb	1
	defb	4
	defs	1
	defb	16
	defb	32
	defb	16
	defb	32
	defb	96
	defb	32
	defb	2
	defb	0
	defb	1
	defs	1
	defb	144
	defb	96
	defb	144
	defb	96
	defb	144
	defb	0
	defb	0
	defb	-1
	defb	3
	defs	1
	defb	176
	defb	0
	defb	176
	defb	0
	defb	176
	defb	80
	defb	0
	defb	1
	defb	2
	defs	1
	defb	96
	defb	112
	defb	96
	defb	112
	defb	48
	defb	112
	defb	-1
	defb	0
	defb	3
	defs	1
	defb	48
	defb	0
	defb	48
	defb	0
	defb	48
	defb	32
	defb	0
	defb	1
	defb	1
	defs	1
	defb	208
	defb	0
	defb	208
	defb	0
	defb	208
	defb	64
	defb	0
	defb	2
	defb	1
	defs	1
	defb	64
	defb	0
	defb	64
	defb	0
	defb	64
	defb	80
	defb	0
	defb	1
	defb	1
	defs	1
	defb	96
	defb	0
	defb	96
	defb	0
	defb	96
	defb	64
	defb	0
	defb	1
	defb	1
	defs	1
	defb	160
	defb	0
	defb	160
	defb	0
	defb	208
	defb	80
	defb	2
	defb	2
	defb	2
	defs	1
	defb	80
	defb	112
	defb	80
	defb	112
	defb	16
	defb	112
	defb	-2
	defb	0
	defb	2
	defs	1
	defb	96
	defb	0
	defb	96
	defb	0
	defb	0
	defb	0
	defb	-1
	defb	0
	defb	2
	defs	1
	defb	224
	defb	0
	defb	224
	defb	0
	defb	224
	defb	48
	defb	0
	defb	1
	defb	2
	defs	1
	defb	192
	defb	48
	defb	192
	defb	48
	defb	128
	defb	48
	defb	-1
	defb	0
	defb	4
	defs	1
	defb	160
	defb	16
	defb	160
	defb	16
	defb	160
	defb	96
	defb	0
	defb	2
	defb	1
	defs	1
	defb	16
	defb	96
	defb	16
	defb	96
	defb	80
	defb	128
	defb	4
	defb	4
	defb	2
	defs	1
	defb	16
	defb	80
	defb	16
	defb	80
	defb	96
	defb	48
	defb	1
	defb	-1
	defb	1
	defs	1
	defb	16
	defb	16
	defb	16
	defb	16
	defb	96
	defb	16
	defb	2
	defb	0
	defb	2
	defs	1
	defb	160
	defb	0
	defb	160
	defb	0
	defb	160
	defb	144
	defb	0
	defb	2
	defb	3
	defs	1
	defb	48
	defb	32
	defb	48
	defb	32
	defb	144
	defb	32
	defb	2
	defb	0
	defb	3
	defs	1
	defb	112
	defb	48
	defb	112
	defb	48
	defb	112
	defb	128
	defb	0
	defb	1
	defb	2
	defs	1
	defb	160
	defb	96
	defb	160
	defb	96
	defb	160
	defb	0
	defb	0
	defb	-2
	defb	3
	defs	1
	defb	96
	defb	128
	defb	96
	defb	128
	defb	96
	defb	16
	defb	0
	defb	-2
	defb	4
	defs	1
	defb	144
	defb	16
	defb	144
	defb	16
	defb	176
	defb	112
	defb	2
	defb	2
	defb	3
	defs	1
	defb	112
	defb	48
	defb	112
	defb	48
	defb	32
	defb	16
	defb	-2
	defb	-2
	defb	1
	defs	1
	defb	64
	defb	128
	defb	64
	defb	128
	defb	208
	defb	128
	defb	1
	defb	0
	defb	4
	defs	1
	defb	208
	defb	112
	defb	208
	defb	112
	defb	112
	defb	112
	defb	-1
	defb	0
	defb	1
	defs	1
	defb	64
	defb	16
	defb	64
	defb	16
	defb	96
	defb	16
	defb	1
	defb	0
	defb	3
	defs	1
	defb	16
	defb	128
	defb	16
	defb	128
	defb	160
	defb	128
	defb	1
	defb	0
	defb	4
	defs	1
	defb	48
	defb	112
	defb	48
	defb	112
	defb	48
	defb	64
	defb	0
	defb	-1
	defb	4
	defs	1
	defb	80
	defb	48
	defb	80
	defb	48
	defb	160
	defb	96
	defb	2
	defb	2
	defb	2
	defs	1
	defb	208
	defb	112
	defb	208
	defb	112
	defb	128
	defb	112
	defb	-1
	defb	0
	defb	3
	defs	1
	defb	208
	defb	80
	defb	208
	defb	80
	defb	208
	defb	16
	defb	0
	defb	-1
	defb	2
	defs	1
	defb	16
	defb	16
	defb	16
	defb	16
	defb	96
	defb	128
	defb	4
	defb	4
	defb	3
	defs	1
	defb	64
	defb	0
	defb	64
	defb	0
	defb	112
	defb	48
	defb	2
	defb	2
	defb	1
	defs	1
	defb	16
	defb	64
	defb	16
	defb	64
	defb	80
	defb	112
	defb	1
	defb	1
	defb	2
	defs	1
	defb	208
	defb	16
	defb	208
	defb	16
	defb	192
	defb	128
	defb	-2
	defb	2
	defb	3
	defs	1
	defb	16
	defb	0
	defb	16
	defb	0
	defb	112
	defb	32
	defb	1
	defb	1
	defb	2
	defs	1
	defb	208
	defb	0
	defb	208
	defb	0
	defb	176
	defb	48
	defb	-2
	defb	2
	defb	3
	defs	1
	defb	64
	defb	64
	defb	64
	defb	64
	defb	96
	defb	0
	defb	1
	defb	-1
	defb	1
	defs	1
	defb	160
	defb	112
	defb	160
	defb	112
	defb	160
	defb	64
	defb	0
	defb	-1
	defb	4
	defs	1
	defb	192
	defb	32
	defb	192
	defb	32
	defb	48
	defb	32
	defb	-1
	defb	0
	defb	4
	defs	1
	defb	64
	defb	0
	defb	64
	defb	0
	defb	176
	defb	16
	defb	1
	defb	1
	defb	3
	defs	1
	defb	192
	defb	48
	defb	192
	defb	48
	defb	80
	defb	48
	defb	-1
	defb	0
	defb	4
	defs	1
	defb	112
	defb	32
	defb	112
	defb	32
	defb	176
	defb	32
	defb	1
	defb	0
	defb	3
	defs	1
	defb	64
	defb	80
	defb	64
	defb	80
	defb	192
	defb	112
	defb	2
	defb	2
	defb	2
	defs	1
	defb	192
	defb	48
	defb	192
	defb	48
	defb	32
	defb	48
	defb	-1
	defb	0
	defb	4
	defs	1
	defb	16
	defb	32
	defb	16
	defb	32
	defb	128
	defb	32
	defb	1
	defb	0
	defb	1
	defs	1
	defb	16
	defb	64
	defb	16
	defb	64
	defb	112
	defb	112
	defb	2
	defb	2
	defb	2
	defs	1
	defb	208
	defb	64
	defb	208
	defb	64
	defb	128
	defb	64
	defb	-1
	defb	0
	defb	2
	defs	1
	defb	48
	defb	16
	defb	48
	defb	16
	defb	48
	defb	80
	defb	0
	defb	2
	defb	1
	defs	1
	defb	64
	defb	32
	defb	64
	defb	32
	defb	64
	defb	80
	defb	0
	defb	2
	defb	3
	defs	1
	defb	16
	defb	112
	defb	16
	defb	112
	defb	112
	defb	112
	defb	1
	defb	0
	defb	1
	defs	1
	defb	192
	defb	128
	defb	192
	defb	128
	defb	192
	defb	16
	defb	0
	defb	-1
	defb	4
	defs	1
	defb	112
	defb	48
	defb	112
	defb	48
	defb	16
	defb	48
	defb	-2
	defb	0
	defb	3
	defs	1
	defb	176
	defb	48
	defb	176
	defb	48
	defb	32
	defb	48
	defb	-1
	defb	0
	defb	1
	defs	1
	defb	176
	defb	64
	defb	176
	defb	64
	defb	48
	defb	64
	defb	-1
	defb	0
	defb	1
	defs	1
	defb	16
	defb	0
	defb	16
	defb	0
	defb	192
	defb	32
	defb	2
	defb	2
	defb	2
	defs	1
	defb	32
	defb	112
	defb	32
	defb	112
	defb	192
	defb	112
	defb	2
	defb	0
	defb	4
	defs	1
	defb	192
	defb	32
	defb	192
	defb	32
	defb	48
	defb	32
	defb	-2
	defb	0
	defb	4
	defs	1
	defb	176
	defb	80
	defb	176
	defb	80
	defb	48
	defb	80
	defb	-1
	defb	0
	defb	1
	defs	1
	defb	208
	defb	80
	defb	208
	defb	80
	defb	32
	defb	80
	defb	-1
	defb	0
	defb	4
	defs	1
	defb	64
	defb	64
	defb	64
	defb	64
	defb	176
	defb	64
	defb	1
	defb	0
	defb	2
	defs	1
	defb	16
	defb	0
	defb	16
	defb	0
	defb	0
	defb	144
	defb	-3
	defb	3
	defb	2
	defs	1
	defb	16
	defb	48
	defb	16
	defb	48
	defb	208
	defb	48
	defb	1
	defb	0
	defb	4
	defs	1
	defb	96
	defb	64
	defb	96
	defb	64
	defb	96
	defb	128
	defb	0
	defb	1
	defb	1
	defs	1
	defb	208
	defb	80
	defb	208
	defb	80
	defb	128
	defb	128
	defb	-2
	defb	2
	defb	3
	defs	1
	defb	96
	defb	32
	defb	96
	defb	32
	defb	96
	defb	96
	defb	0
	defb	2
	defb	6
	defs	1
	defb	128
	defb	80
	defb	128
	defb	80
	defb	192
	defb	96
	defb	2
	defb	2
	defb	4
	defs	1
	defb	96
	defb	112
	defb	96
	defb	112
	defb	16
	defb	112
	defb	-1
	defb	0
	defb	3
	defs	1
	defb	112
	defb	16
	defb	112
	defb	16
	defb	112
	defb	80
	defb	0
	defb	1
	defb	2
	defs	1
	defb	48
	defb	96
	defb	48
	defb	96
	defb	48
	defb	0
	defb	0
	defb	-2
	defb	1
	defs	1
	defb	176
	defb	48
	defb	176
	defb	48
	defb	176
	defb	128
	defb	0
	defb	2
	defb	3
	defs	1
	defb	160
	defb	32
	defb	160
	defb	32
	defb	192
	defb	80
	defb	2
	defb	2
	defb	1
	defs	1
	defb	96
	defb	48
	defb	96
	defb	48
	defb	96
	defb	0
	defb	0
	defb	-1
	defb	2
	defs	1
	defb	144
	defb	144
	defb	144
	defb	144
	defb	48
	defb	144
	defb	-1
	defb	0
	defb	3
	defs	1
	defb	32
	defb	80
	defb	32
	defb	80
	defb	32
	defb	16
	defb	0
	defb	-2
	defb	1
	defs	1
	defb	192
	defb	80
	defb	192
	defb	80
	defb	192
	defb	32
	defb	0
	defb	-2
	defb	2
	defs	1
	defb	112
	defb	80
	defb	112
	defb	80
	defb	112
	defb	32
	defb	0
	defb	-1
	defb	3
	defs	1
	defb	208
	defb	48
	defb	208
	defb	48
	defb	32
	defb	48
	defb	-1
	defb	0
	defb	4
	defs	1
	defb	64
	defb	32
	defb	64
	defb	32
	defb	192
	defb	32
	defb	1
	defb	0
	defb	2
	defs	1
	defb	80
	defb	96
	defb	80
	defb	96
	defb	112
	defb	96
	defb	1
	defb	0
	defb	1
	defs	1
	defb	112
	defb	16
	defb	112
	defb	16
	defb	16
	defb	80
	defb	-2
	defb	2
	defb	3
	defs	1
	defb	176
	defb	64
	defb	176
	defb	64
	defb	176
	defb	96
	defb	0
	defb	1
	defb	1
	defs	1
	defb	208
	defb	80
	defb	208
	defb	80
	defb	208
	defb	128
	defb	0
	defb	1
	defb	1
	defs	1

;	SECTION	code

;	SECTION	text

._hotspots
	defb	22
	defb	2
	defb	0
	defb	120
	defb	2
	defb	0
	defb	113
	defb	1
	defb	0
	defb	216
	defb	1
	defb	0
	defb	81
	defb	1
	defb	0
	defb	24
	defb	1
	defb	0
	defb	98
	defb	1
	defb	0
	defb	115
	defb	1
	defb	0
	defb	69
	defb	1
	defb	0
	defb	129
	defb	2
	defb	0
	defb	209
	defb	2
	defb	0
	defb	18
	defb	1
	defb	0
	defb	200
	defb	1
	defb	0
	defb	100
	defb	1
	defb	0
	defb	148
	defb	1
	defb	0
	defb	34
	defb	1
	defb	0
	defb	66
	defb	1
	defb	0
	defb	209
	defb	1
	defb	0
	defb	19
	defb	1
	defb	0
	defb	113
	defb	1
	defb	0
	defb	133
	defb	1
	defb	0
	defb	35
	defb	1
	defb	0
	defb	70
	defb	1
	defb	0
	defb	87
	defb	1
	defb	0
	defb	129
	defb	1
	defb	0
	defb	87
	defb	1
	defb	0
	defb	114
	defb	1
	defb	0
	defb	100
	defb	1
	defb	0
	defb	129
	defb	1
	defb	0
	defb	212
	defb	1
	defb	0

;	SECTION	code

	defb 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255
	._sprites_player
	BINARY "../bin/sprites_player.bin"
	._player_cells
	defw _sprites_player + 0x0000, _sprites_player + 0x0090, _sprites_player + 0x0120, _sprites_player + 0x01B0
	defw _sprites_player + 0x0240, _sprites_player + 0x02D0, _sprites_player + 0x0360, _sprites_player + 0x03F0
	defb 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255
	._sprites_enems
	BINARY "../bin/sprites_enems.bin"
	._enem_cells
	defw _sprites_enems + 0x0000, _sprites_enems + 0x0090, _sprites_enems + 0x0120, _sprites_enems + 0x01B0
	defw _sprites_enems + 0x0240, _sprites_enems + 0x02D0, _sprites_enems + 0x0360, _sprites_enems + 0x03F0
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

._attr
	ld	hl,4	;const
	add	hl,sp
	ld	e,(hl)
	ld	d,0
	ld	hl,15	;const
	call	l_uge
	jp	c,i_16
	ld	hl,2	;const
	add	hl,sp
	ld	e,(hl)
	ld	d,0
	ld	hl,10	;const
	call	l_uge
	jp	nc,i_15
.i_16
	ld	hl,0 % 256	;const
	ret


.i_15
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
	ld hl, _tileset + 2048
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
	ld b, 2
	ld c, 1
	ld d, 2+19
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
	ld	de,2
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
	._pn2
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
	ld	a,#(30 % 256 % 256)
	ld	(__x),a
	ld	a,#(0 % 256 % 256)
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
	ld	bc,8
	add	hl,bc
	ex	de,hl
	ld	hl,(_cx2)
	ld	h,0
	call	l_uge
	jp	nc,i_19
	ld	hl,(_gpx)
	ld	h,0
	push	hl
	ld	hl,(_cx2)
	ld	h,0
	ld	bc,8
	add	hl,bc
	pop	de
	call	l_ule
	jp	nc,i_19
	ld	hl,(_gpy)
	ld	h,0
	ld	bc,8
	add	hl,bc
	ex	de,hl
	ld	hl,(_cy2)
	ld	h,0
	call	l_uge
	jp	nc,i_19
	ld	hl,(_gpy)
	ld	h,0
	push	hl
	ld	hl,(_cy2)
	ld	h,0
	ld	bc,8
	add	hl,bc
	pop	de
	call	l_ule
	jp	nc,i_19
	ld	hl,1	;const
	jr	i_20
.i_19
	ld	hl,0	;const
.i_20
	ld	h,0
	ret



._cm_hb_collision
	ld a, (_cx1)
	cp 15
	jr nc, _cm_hb_collision_at1_reset
	ld a, (_cy1)
	cp 10
	jr c, _cm_hb_collision_at1_do
	._cm_hb_collision_at1_reset
	xor a
	jr _cm_hb_collision_at1_done
	._cm_hb_collision_at1_do
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
	._cm_hb_collision_at1_done
	ld (_at1), a
	ld a, (_cx2)
	cp 15
	jr nc, _cm_hb_collision_at2_reset
	ld a, (_cy2)
	cp 10
	jr c, _cm_hb_collision_at2_do
	._cm_hb_collision_at2_reset
	xor a
	jr _cm_hb_collision_at2_done
	._cm_hb_collision_at2_do
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
	._cm_hb_collision_at2_done
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
	jp	p,i_21
	pop	bc
	pop	hl
	push	hl
	push	bc
	call	l_neg
	ret


.i_21
	pop	bc
	pop	hl
	push	hl
	push	bc
	ret


.i_22
	ret



._step
	ld a, 16
	out (254), a
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	xor 16
	out (254), a
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



._bullets_init
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_b_it),a
.i_23
	ld	a,(_b_it)
	cp	#(3 % 256)
	jp	z,i_24
	jp	nc,i_24
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
	jp	i_23
.i_24
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



._bullets_fire
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_b_it),a
	jp	i_27
.i_25
	ld	hl,(_b_it)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_b_it),a
.i_27
	ld	a,(_b_it)
	cp	#(3 % 256)
	jp	z,i_26
	jp	nc,i_26
	ld	de,_bullets_estado
	ld	hl,(_b_it)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	and	a
	jp	nz,i_28
	ld	a,#(1 % 256 % 256)
	ld	(__b_estado),a
	ld	hl,(_gpy)
	ld	h,0
	ld	bc,6
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(__b_y),a
	xor	a
	ld	(__b_my),a
	ld	a,(_p_facing)
	and	a
	jp	nz,i_29
	ld	hl,(_gpx)
	ld	h,0
	ld	bc,-4
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(__b_x),a
	ld	hl,65528	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(__b_mx),a
	jp	i_30
.i_29
	ld	hl,(_gpx)
	ld	h,0
	ld	bc,12
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(__b_x),a
	ld	hl,8	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(__b_mx),a
.i_30
	ld	hl,6 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
	call	_bullets_update
	jp	i_26
.i_28
	jp	i_25
.i_26
	ret



._bullets_move
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_b_it),a
	jp	i_33
.i_31
	ld	hl,_b_it
	ld	a,(hl)
	inc	(hl)
.i_33
	ld	a,(_b_it)
	cp	#(3 % 256)
	jp	z,i_32
	jp	nc,i_32
	ld	de,_bullets_estado
	ld	hl,(_b_it)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,h
	or	l
	jp	z,i_34
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
	jp	z,i_35
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
	jp	z,i_36
	jp	c,i_36
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(__b_estado),a
.i_36
.i_35
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
	cp	#(7 % 256)
	jp	z,i_37
	jp	c,i_37
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(__b_estado),a
.i_37
	call	_bullets_update
.i_34
	jp	i_31
.i_32
	ret



._lame_sound
	ld	hl,4 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_40
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
.i_38
	ld	hl,(_gpit)
	ld	h,0
	dec	hl
	ld	a,l
	ld	(_gpit),a
	ld	a,h
	or	l
	jp	nz,i_40
.i_39
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
	ld	hl,i_1+13
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



._addsign
	ld	hl,4	;const
	add	hl,sp
	call	l_gint	;
	xor	a
	or	h
	jp	m,i_41
	pop	bc
	pop	hl
	push	hl
	push	bc
	ret


.i_41
	pop	bc
	pop	hl
	push	hl
	push	bc
	call	l_neg
	ret


.i_42
	ret



._espera_activa
.i_43
	call	sp_GetKey
	ld	a,h
	or	l
	jp	nz,i_43
.i_44
.i_47
	ld	hl,250 % 256	;const
	ld	a,l
	ld	(_gpjt),a
.i_50
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_48
	ld	hl,(_gpjt)
	ld	h,0
	dec	hl
	ld	a,l
	ld	(_gpjt),a
	ld	a,h
	or	l
	jp	nz,i_50
.i_49
	call	sp_GetKey
	ld	a,h
	or	l
	jp	nz,i_46
.i_51
.i_45
	pop	de
	pop	hl
	dec	hl
	push	hl
	push	de
	ld	a,h
	or	l
	jp	nz,i_47
.i_46
	ret



._locks_init
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_54
.i_52
	ld	hl,(_gpit)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_gpit),a
.i_54
	ld	a,(_gpit)
	cp	#(4 % 256)
	jp	z,i_53
	jp	nc,i_53
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
	ld	(hl),#(1 % 256 % 256)
	ld	l,(hl)
	ld	h,0
	jp	i_52
.i_53
	ret



._process_tile
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
	jp	nc,i_56
	ld	a,(_p_keys)
	and	a
	jr	nz,i_57_i_56
.i_56
	jp	i_55
.i_57_i_56
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_60
.i_58
	ld	hl,(_gpit)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_gpit),a
.i_60
	ld	a,(_gpit)
	cp	#(4 % 256)
	jp	z,i_59
	jp	nc,i_59
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
	jp	nz,i_62
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
	jp	nz,i_62
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
	jr	z,i_63_i_62
.i_62
	jp	i_61
.i_63_i_62
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
	jp	i_59
.i_61
	jp	i_58
.i_59
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
.i_55
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
	ld	a,#(2 % 256 % 256)
	ld	(__y),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_66
.i_64
	ld	hl,(_gpit)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_gpit),a
.i_66
	ld	a,(_gpit)
	ld	e,a
	ld	d,0
	ld	hl,150	;const
	call	l_ult
	jp	nc,i_65
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
	jp	i_64
.i_65
	ret



._draw_scr
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_is_rendering),a
	call	_draw_scr_background
	call	_enems_load
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
	ld b, 4
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
	call	_invalidate_viewport
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_is_rendering),a
	ret



._select_joyfunc
	; Music generated by beepola
	call musicstart
.i_67
	call	sp_GetKey
	ld	h,0
	ld	a,l
	ld	(_gpjt),a
	cp	#(49 % 256)
	jr	z,i_70_uge
	jp	c,i_70
.i_70_uge
	ld	a,(_gpjt)
	cp	#(51 % 256)
	jr	z,i_71_i_70
	jr	c,i_71_i_70
.i_70
	jp	i_69
.i_71_i_70
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
	jp	i_68
.i_69
	jp	i_67
.i_68
	ret



._player_init
	ld	a,#(32 % 256 % 256)
	ld	(_gpx),a
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	(_p_x),hl
	ld	a,#(32 % 256 % 256)
	ld	(_gpy),a
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	(_p_y),hl
	xor	a
	ld	(_p_vy),a
	xor	a
	ld	(_p_vx),a
	ld	a,#(1 % 256 % 256)
	ld	(_p_cont_salto),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_saltando),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_frame),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_subframe),a
	ld	a,#(1 % 256 % 256)
	ld	(_p_facing),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_estado),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_ct_estado),a
	ld	a,#(99 % 256 % 256)
	ld	(_p_life),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_objs),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_keys),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_killed),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_p_disparando),a
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
	; Signed comparisons are hard
	; p_vy <= 127 - 8
	; We are going to take a shortcut.
	; If p_vy < 0, just add 8.
	; If p_vy > 0, we can use unsigned comparition anyway.
	ld a, (_p_vy)
	bit 7, a
	jr nz, _player_gravity_add ; < 0
	; > 0, compare unsigned p_vy <= 127 - 8
	; 127 - 8 >= p_vy
	ld c, a
	ld a, 127 - 8
	cp c
	ld a, c
	jr nc, _player_gravity_add
	ld a, 127
	jr _player_gravity_vy_set
	._player_gravity_add
	add 8
	._player_gravity_vy_set
	ld (_p_vy), a
	ld a, (_p_gotten)
	or a
	jr z, _player_gravity_p_gotten_done
	ld a, (_p_vy)
	bit 7, a
	jr nz, _player_gravity_p_gotten_done
	xor a
	ld (_p_vy), a
	._player_gravity_p_gotten_done
	ld	hl,(_p_y)
	push	hl
	ld	hl,_p_vy
	call	l_gchar
	pop	de
	add	hl,de
	ld	(_p_y),hl
	ld	a,(_p_gotten)
	and	a
	jp	z,i_72
	ld	hl,(_p_y)
	push	hl
	ld	hl,_ptgmy
	call	l_gchar
	pop	de
	add	hl,de
	ld	(_p_y),hl
.i_72
	ld	hl,(_p_y)
	xor	a
	or	h
	jp	p,i_73
	ld	hl,0	;const
	ld	(_p_y),hl
.i_73
	ld	hl,(_p_y)
	ld	de,2304	;const
	ex	de,hl
	call	l_gt
	jp	nc,i_74
	ld	hl,2304	;const
	ld	(_p_y),hl
.i_74
	ld	hl,(_p_y)
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr
	ld	h,0
	ld	a,l
	ld	(_gpy),a
	call _player_calc_bounding_box
	xor a
	ld (_hit_v), a
	ld a, (_ptx1)
	ld (_cx1), a
	ld a, (_ptx2)
	ld (_cx2), a
	ld a, (_p_vy)
	ld c, a
	ld a, (_ptgmy)
	add c
	or a
	jp z, _va_collision_done
	bit 7, a
	jp z, _va_collision_vy_positive
	._va_collision_vy_negative
	ld a, (_pty1)
	ld (_cy1), a
	ld (_cy2), a
	call _cm_hb_collision
	ld a, (_at1)
	and 8
	jp nz, _va_col_vy_neg_do
	ld a, (_at2)
	and 8
	jp z, _va_collision_checkevil
	._va_col_vy_neg_do
	xor a
	ld (_p_vy), a
	ld a, (_pty1)
	inc a
	sla a
	sla a
	sla a
	sla a
	sub 8
	ld (_gpy), a
	ld d, 0
	ld e, a
	ld l, 4
	call l_asl
	ld (_p_y), hl
	jp _va_collision_checkevil
	._va_collision_vy_positive
	ld a, (_pty2)
	ld (_cy1), a
	ld (_cy2), a
	call _cm_hb_collision
	ld a, (_at1)
	and 8
	jr nz, _va_col_vy_pos_do
	ld a, (_at2)
	and 8
	jr nz, _va_col_vy_pos_do
	ld a, (_gpy)
	dec a
	and 15
	cp 8
	jp nc, _va_collision_checkevil
	ld a, (_at1)
	and 4
	jr nz, _va_col_vy_pos_do
	ld a, (_at2)
	and 4
	jp z, _va_collision_checkevil
	._va_col_vy_pos_do
	xor a
	ld (_p_vy), a
	ld a, (_pty2)
	dec a
	sla a
	sla a
	sla a
	sla a
	ld (_gpy), a
	ld d, 0
	ld e, a
	ld l, 4
	call l_asl
	ld (_p_y), hl
	jr _va_collision_done
	._va_collision_checkevil
	ld	hl,_at1
	ld	a,(hl)
	rrca
	jp	c,i_75
	ld	hl,_at2
	ld	a,(hl)
	rrca
	jp	c,i_75
	ld	hl,0	;const
	jr	i_76
.i_75
	ld	hl,1	;const
.i_76
	ld	h,0
	ld	a,l
	ld	(_hit_v),a
	._va_collision_done
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
	ld	hl,(_gpy)
	ld	h,0
	ld	bc,16
	add	hl,bc
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_cy2),a
	ld	h,0
	ld	a,l
	ld	(_cy1),a
	ld	hl,(_ptx1)
	ld	h,0
	ld	a,l
	ld	(_cx1),a
	ld	hl,(_ptx2)
	ld	h,0
	ld	a,l
	ld	(_cx2),a
	call	_cm_hb_collision
	ld	hl,_at1
	ld	a,(hl)
	and	#(12 % 256)
	jp	nz,i_77
	ld	hl,_at2
	ld	a,(hl)
	and	#(12 % 256)
	jp	z,i_79
.i_77
	ld	a,(_gpy)
	ld	e,a
	ld	d,0
	ld	hl,15	;const
	call	l_and
	ld	de,8	;const
	ex	de,hl
	call	l_ult
	jp	nc,i_79
	ld	hl,1	;const
	jr	i_80
.i_79
	ld	hl,0	;const
.i_80
	ld	h,0
	ld	a,l
	ld	(_possee),a
	ld	a,(_pad0)
	ld	e,a
	ld	d,0
	ld	hl,1	;const
	call	l_and
	ld	de,0	;const
	ex	de,hl
	call	l_eq
	ld	hl,0	;const
	rl	l
	ld	h,0
	ld	a,l
	ld	(_rda),a
	and	a
	jp	z,i_81
	ld	a,(_p_saltando)
	and	a
	jp	nz,i_82
	ld	a,(_possee)
	and	a
	jp	nz,i_84
	ld	a,(_p_gotten)
	and	a
	jp	nz,i_84
	ld	a,(_hit_v)
	and	a
	jp	z,i_83
.i_84
	ld	a,#(1 % 256 % 256)
	ld	(_p_saltando),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_cont_salto),a
	ld	hl,3 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
.i_83
	jp	i_86
.i_82
	ld	hl,_p_vy
	call	l_gchar
	push	hl
	ld	a,(_p_cont_salto)
	ld	e,a
	ld	d,0
	ld	l,#(1 % 256)
	call	l_asr_u
	ld	de,56
	ex	de,hl
	and	a
	sbc	hl,de
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vy),a
	ld	hl,_p_vy
	call	l_gchar
	ld	de,65456	;const
	ex	de,hl
	call	l_lt
	jp	nc,i_87
	ld	hl,65456	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vy),a
.i_87
	ld	hl,(_p_cont_salto)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_p_cont_salto),a
	cp	#(9 % 256)
	jp	nz,i_88
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_p_saltando),a
.i_88
.i_86
	jp	i_89
.i_81
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_p_saltando),a
.i_89
	ld	a,(_pad0)
	ld	e,a
	ld	d,0
	ld	hl,4	;const
	call	l_and
	ld	de,0	;const
	ex	de,hl
	call	l_eq
	jp	c,i_91
	ld	a,(_pad0)
	ld	e,a
	ld	d,0
	ld	hl,8	;const
	call	l_and
	ld	de,0	;const
	ex	de,hl
	call	l_eq
	jp	c,i_91
	ld	hl,0	;const
	jr	i_92
.i_91
	ld	hl,1	;const
.i_92
	call	l_lneg
	jp	nc,i_90
	ld	hl,_p_vx
	call	l_gchar
	xor	a
	or	h
	jp	m,i_93
	or	l
	jp	z,i_93
	ld	hl,_p_vx
	call	l_gchar
	ld	bc,-8
	add	hl,bc
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vx),a
	ld	hl,_p_vx
	call	l_gchar
	xor	a
	or	h
	jp	p,i_94
	ld	hl,0	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vx),a
.i_94
	jp	i_95
.i_93
	ld	hl,_p_vx
	call	l_gchar
	xor	a
	or	h
	jp	p,i_96
	ld	hl,_p_vx
	call	l_gchar
	ld	bc,8
	add	hl,bc
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vx),a
	ld	hl,_p_vx
	call	l_gchar
	xor	a
	or	h
	jp	m,i_97
	or	l
	jp	z,i_97
	ld	hl,0	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vx),a
.i_97
.i_96
.i_95
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_wall_h),a
.i_90
	ld	hl,_pad0
	ld	a,(hl)
	and	#(4 % 256)
	jp	nz,i_98
	ld	hl,_p_vx
	call	l_gchar
	ld	de,65488	;const
	ex	de,hl
	call	l_gt
	jp	nc,i_99
	ld	a,#(0 % 256 % 256)
	ld	(_p_facing),a
	ld	hl,_p_vx
	call	l_gchar
	ld	bc,-6
	add	hl,bc
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vx),a
.i_99
.i_98
	ld	hl,_pad0
	ld	a,(hl)
	and	#(8 % 256)
	jp	nz,i_100
	ld	hl,_p_vx
	call	l_gchar
	ld	de,48	;const
	ex	de,hl
	call	l_lt
	jp	nc,i_101
	ld	hl,_p_vx
	call	l_gchar
	ld	bc,6
	add	hl,bc
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vx),a
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_p_facing),a
.i_101
.i_100
	ld	hl,(_p_x)
	push	hl
	ld	hl,_p_vx
	call	l_gchar
	pop	de
	add	hl,de
	ld	(_p_x),hl
	push	hl
	ld	hl,_ptgmx
	call	l_gchar
	pop	de
	add	hl,de
	ld	(_p_x),hl
	xor	a
	or	h
	jp	p,i_102
	ld	hl,0	;const
	ld	(_p_x),hl
.i_102
	ld	hl,(_p_x)
	ld	de,3584	;const
	ex	de,hl
	call	l_gt
	jp	nc,i_103
	ld	hl,3584	;const
	ld	(_p_x),hl
.i_103
	ld	hl,(_gpx)
	ld	h,0
	ld	a,l
	ld	(_gpox),a
	ld	hl,(_p_x)
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr
	ld	h,0
	ld	a,l
	ld	(_gpx),a
	call _player_calc_bounding_box
	xor a
	ld (_hit_h), a
	ld a, (_pty1)
	ld (_cy1), a
	ld a, (_pty2)
	ld (_cy2), a
	ld a, (_p_vx)
	ld c, a
	ld a, (_ptgmx)
	add c
	or a
	jp z, _ha_collision_done
	bit 7, a
	jp z, _ha_collision_vx_positive
	._ha_collision_vx_negative
	ld a, (_ptx1)
	ld (_cx1), a
	ld (_cx2), a
	call _cm_hb_collision
	ld a, (_at1)
	and 8
	jr nz, _ha_col_vx_neg_do
	ld a, (_at2)
	and 8
	jp z, _ha_collision_checkevil
	._ha_col_vx_neg_do
	xor a
	ld (_p_vx), a
	ld a, (_ptx1)
	inc a
	sla a
	sla a
	sla a
	sla a
	sub 4
	ld (_gpx), a
	ld d, 0
	ld e, a
	ld l, 4
	call l_asl
	ld (_p_x), hl
	ld a, 3
	ld (_wall_h), a
	jp _ha_collision_checkevil
	._ha_collision_vx_positive
	ld a, (_ptx2)
	ld (_cx1), a
	ld (_cx2), a
	call _cm_hb_collision
	ld a, (_at1)
	and 8
	jr nz, _ha_col_vx_pos_do
	ld a, (_at2)
	and 8
	jp z, _ha_collision_checkevil
	._ha_col_vx_pos_do
	xor a
	ld (_p_vx), a
	ld a, (_ptx2)
	dec a
	sla a
	sla a
	sla a
	sla a
	add 4
	ld (_gpx), a
	ld d, 0
	ld e, a
	ld l, 4
	call l_asl
	ld (_p_x), hl
	ld a, 4
	ld (_wall_h), a
	._ha_collision_checkevil
	._ha_collision_done
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
	jp	nc,i_104
.i_104
	ld	a,(_wall_h)
	cp	#(3 % 256)
	jp	nz,i_105
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
	jp	nc,i_106
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
.i_106
	jp	i_107
.i_105
	ld	a,(_wall_h)
	cp	#(4 % 256)
	jp	nz,i_108
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
	jp	nc,i_109
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
.i_109
.i_108
.i_107
	ld	hl,_pad0
	ld	a,(hl)
	and	#(128 % 256)
	cp	#(0 % 256)
	ld	hl,0
	jp	nz,i_111
	inc	hl
	ld	a,(_p_disparando)
	cp	#(0 % 256)
	jr	z,i_112_i_111
.i_111
	jp	i_110
.i_112_i_111
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_p_disparando),a
	call	_bullets_fire
.i_110
	ld	hl,_pad0
	ld	a,(hl)
	rlca
	jp	nc,i_113
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_p_disparando),a
.i_113
	ld	a,#(0 % 256 % 256)
	ld	(_hit),a
	ld	a,(_hit_v)
	and	a
	jp	z,i_114
	ld	a,#(1 % 256 % 256)
	ld	(_hit),a
	ld	hl,_p_vy
	call	l_gchar
	call	l_neg
	push	hl
	ld	hl,48	;const
	push	hl
	call	_addsign
	pop	bc
	pop	bc
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vy),a
	jp	i_115
.i_114
	ld	a,(_hit_h)
	and	a
	jp	z,i_116
	ld	a,#(1 % 256 % 256)
	ld	(_hit),a
	ld	hl,_p_vx
	call	l_gchar
	call	l_neg
	push	hl
	ld	hl,48	;const
	push	hl
	call	_addsign
	pop	bc
	pop	bc
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vx),a
.i_116
.i_115
	ld	a,(_hit)
	and	a
	jp	z,i_117
	ld	hl,4 % 256	;const
	ld	a,l
	ld	(_p_killme),a
.i_117
	ld a, (_p_facing)
	dec a
	jr z, _player_cell_sel_set_rda
	ld a, 4
	._player_cell_sel_set_rda
	ld (_rda), a
	ld	hl,(_possee)
	ld	h,0
	call	l_lneg
	jp	nc,i_119
	ld	hl,(_p_gotten)
	ld	h,0
	call	l_lneg
	jr	c,i_120_i_119
.i_119
	jp	i_118
.i_120_i_119
	ld	hl,3 % 256	;const
	ld	a,l
	ld	(_rdb),a
	jp	i_121
.i_118
	ld	hl,_p_vx
	call	l_gchar
	ld	a,h
	or	l
	jp	nz,i_122
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_rdb),a
	jp	i_123
.i_122
	ld	hl,(_gpx)
	ld	h,0
	ld	bc,4
	add	hl,bc
	ex	de,hl
	ld	l,#(3 % 256)
	call	l_asr_u
	ld	de,3	;const
	ex	de,hl
	call	l_and
	ld	h,0
	ld	a,l
	ld	(_rdb),a
	cp	#(3 % 256)
	jp	nz,i_124
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_rdb),a
.i_124
.i_123
.i_121
	ld	hl,_player_cells
	push	hl
	ld	hl,(_rdb)
	ld	h,0
	ex	de,hl
	ld	hl,(_rda)
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
	jp	nc,i_125
	ld	hl,(_p_life)
	ld	h,0
	ex	de,hl
	ld	hl,(_p_kill_amt)
	ld	h,0
	ex	de,hl
	and	a
	sbc	hl,de
	jp	i_126
.i_125
	ld	hl,0	;const
.i_126
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
	ret



._enems_init
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_enit),a
.i_127
	ld	a,(_enit)
	cp	#(90 % 256)
	jp	z,i_128
	jp	nc,i_128
	ld	hl,_malotes
	push	hl
	ld	hl,(_enit)
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
	ld	hl,_malotes
	push	hl
	ld	hl,(_enit)
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
	call	l_gchar
	ld	de,239	;const
	ex	de,hl
	call	l_and
	ld	a,l
	call	l_sxt
	pop	de
	ld	a,l
	ld	(de),a
	ld	hl,_malotes
	push	hl
	ld	hl,(_enit)
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
	ld	(hl),#(4 % 256 % 256)
	ld	hl,_enit
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
	jp	i_127
.i_128
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
	add 2
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
	jp	i_131
.i_129
	ld	hl,(_enit)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_enit),a
.i_131
	ld	a,(_enit)
	cp	#(3 % 256)
	jp	z,i_130
	jp	nc,i_130
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
	call	l_gchar
	ld	de,239	;const
	ex	de,hl
	call	l_and
	ld	a,l
	call	l_sxt
	pop	de
	ld	a,l
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
	ld	(hl),#(4 % 256 % 256)
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
	call	l_gchar
	ld	de,31	;const
	ex	de,hl
	call	l_and
.i_134
	ld	a,l
	cp	#(1% 256)
	jp	z,i_135
	cp	#(2% 256)
	jp	z,i_136
	cp	#(3% 256)
	jp	z,i_137
	cp	#(4% 256)
	jp	z,i_138
	jp	i_133
.i_135
.i_136
.i_137
.i_138
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
	call	l_gchar
	dec	hl
	add	hl,hl
	pop	de
	ld	a,l
	ld	(de),a
.i_133
	jp	i_129
.i_130
	ret



._enems_kill
	ld	hl,__en_t
	call	l_gchar
	ld	de,7	;const
	ex	de,hl
	call	l_ne
	jp	nc,i_139
	ld	hl,__en_t
	call	l_gchar
	ld	de,16	;const
	ex	de,hl
	call	l_or
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(__en_t),a
.i_139
	ld	hl,(_p_killed)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_p_killed),a
	ret



._enems_move
	ld	hl,0	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_ptgmy),a
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_ptgmx),a
	ld	h,0
	ld	a,l
	ld	(_p_gotten),a
	ld	h,0
	ld	a,l
	ld	(_tocado),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_enit),a
	jp	i_142
.i_140
	ld	hl,_enit
	ld	a,(hl)
	inc	(hl)
.i_142
	ld	a,(_enit)
	cp	#(3 % 256)
	jp	z,i_141
	jp	nc,i_141
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
	ld	hl,(_gpx)
	ld	h,0
	ld	bc,12
	add	hl,bc
	ex	de,hl
	ld	hl,(__en_x)
	ld	h,0
	call	l_uge
	jp	nc,i_143
	ld	hl,(_gpx)
	ld	h,0
	push	hl
	ld	hl,(__en_x)
	ld	h,0
	ld	bc,12
	add	hl,bc
	pop	de
	call	l_ule
	jp	nc,i_143
	ld	hl,1	;const
	jr	i_144
.i_143
	ld	hl,0	;const
.i_144
	ld	h,0
	ld	a,l
	ld	(_pregotten),a
	ld	hl,(_rdt)
	ld	h,0
.i_147
	ld	a,l
	cp	#(1% 256)
	jp	z,i_148
	cp	#(2% 256)
	jp	z,i_149
	cp	#(3% 256)
	jp	z,i_150
	cp	#(4% 256)
	jp	z,i_151
	jp	i_146
.i_148
.i_149
.i_150
.i_151
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
	jr nz, _enems_lm_change_axis_x_done
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
	jr nz, _enems_lm_change_axis_y_done
	._enems_lm_change_axis_y
	ld a, (__en_my)
	neg
	ld (__en_my), a
	._enems_lm_change_axis_y_done
.i_146
	ld	a,(_active)
	and	a
	jp	z,i_152
	ld	de,_en_an_base_frame
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	ld	e,(hl)
	ld	d,0
	ld	hl,99	;const
	call	l_ne
	jp	nc,i_153
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
.i_153
	ld	hl,__en_t
	call	l_gchar
	ld	de,4	;const
	ex	de,hl
	call	l_eq
	jp	nc,i_154
	._enems_plats_horz
	ld a, (_p_saltando)
	or a
	jp nz, _enems_platforms_done
	ld a, (_pregotten)
	or a
	jp z, _enems_platforms_done
	ld a, (__en_mx)
	or a
	jr z, _enems_plats_horz_done
	ld a, (__en_y)
	ld c, a
	ld a, (_gpy)
	add 18
	cp c
	jr c, _enems_plats_horz_done
	ld a, (_gpy)
	add 8
	ld c, a
	ld a, (__en_y)
	cp c
	jr c, _enems_plats_horz_done
	._enems_plats_horz_do
	ld a, 1
	ld (_p_gotten), a
	ld a, (__en_mx)
	sla a
	sla a
	sla a
	sla a ; times 4
	ld (_ptgmx), a
	call _enems_plats_gpy_set
	._enems_plats_horz_done
	._enems_plats_vert
	._enems_plats_vert_check_1
	ld a, (_gpy)
	add 8
	ld c, a
	ld a, (__en_y)
	cp c
	jr c, _enems_plats_vert_done
	ld a, (__en_my)
	bit 7, a
	jr z, _enems_plats_vert_check_2 ; _en_my is positive
	ld a, (__en_y)
	ld c, a
	ld a, (_gpy)
	add 17
	cp c
	jr nc, _enems_plats_vert_do
	._enems_plats_vert_check_2
	ld a, (__en_y)
	ld c, a
	ld a, (__en_my)
	ld b, a
	ld a, (_gpy)
	add 17
	add b
	cp c
	;jr c, _enems_plats_vert_done
	jr c, _enems_platforms_done
	._enems_plats_vert_do
	ld a, 1
	ld (_p_gotten), a
	ld a, (__en_my)
	sla a
	sla a
	sla a
	sla a ; times 4
	ld (_ptgmy), a
	xor a
	ld (_p_vy), a
	call _enems_plats_gpy_set
	._enems_plats_vert_done
	jp _enems_platforms_done
	._enems_plats_gpy_set
	ld a, (__en_y)
	sub 16
	ld (_gpy), a
	ld d, 0
	ld e, a
	ld l, 4
	call l_asl
	ld (_p_y), hl
	ret
	._enems_platforms_done
	jp	i_155
.i_154
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
	jp	nc,i_157
	call	_collide
	ld	a,h
	or	l
	jp	z,i_157
	ld	a,(_p_estado)
	cp	#(0 % 256)
	jr	z,i_158_i_157
.i_157
	jp	i_156
.i_158_i_157
	ld	a,#(1 % 256 % 256)
	ld	(_tocado),a
	ld	a,#(4 % 256 % 256)
	ld	(_p_killme),a
	ld	hl,__en_mx
	call	l_gchar
	push	hl
	ld	hl,48	;const
	push	hl
	call	_addsign
	pop	bc
	pop	bc
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vx),a
	ld	hl,__en_my
	call	l_gchar
	push	hl
	ld	hl,48	;const
	push	hl
	call	_addsign
	pop	bc
	pop	bc
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vy),a
.i_156
.i_155
.i_159
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpjt),a
	jp	i_162
.i_160
	ld	hl,_gpjt
	ld	a,(hl)
	inc	(hl)
.i_162
	ld	a,(_gpjt)
	cp	#(3 % 256)
	jp	z,i_161
	jp	nc,i_161
	ld	de,_bullets_estado
	ld	hl,(_gpjt)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	cp	#(1 % 256)
	jp	nz,i_163
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
	jp	nc,i_165
	ld	hl,(_blx)
	ld	h,0
	push	hl
	ld	hl,(__en_x)
	ld	h,0
	ld	bc,15
	add	hl,bc
	pop	de
	call	l_ule
	jp	nc,i_165
	ld	hl,(_bly)
	ld	h,0
	ex	de,hl
	ld	hl,(__en_y)
	ld	h,0
	call	l_uge
	jp	nc,i_165
	ld	hl,(_bly)
	ld	h,0
	push	hl
	ld	hl,(__en_y)
	ld	h,0
	ld	bc,15
	add	hl,bc
	pop	de
	call	l_ule
	jr	c,i_166_i_165
.i_165
	jp	i_164
.i_166_i_165
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
	ld	hl,__en_t
	call	l_gchar
	ld	de,4	;const
	ex	de,hl
	call	l_ne
	jp	nc,i_167
	ld	hl,__en_life
	call	l_gchar
	dec	hl
	ld	a,l
	ld	(__en_life),a
.i_167
	ld	hl,__en_life
	call	l_gchar
	ld	a,h
	or	l
	jp	nz,i_168
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
	call	_enems_kill
.i_168
	ld	hl,1 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
.i_164
.i_163
	jp	i_160
.i_161
.i_152
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
	jp	i_140
.i_141
	ret



._hotspots_init
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_169
	ld	a,(_gpit)
	cp	#(30 % 256)
	jp	z,i_170
	jp	nc,i_170
	ld	hl,_hotspots
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	ld	(hl),#(1 % 256 % 256)
	ld	hl,(_gpit)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_gpit),a
	jp	i_169
.i_170
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
	jp	nz,i_171
	ret


.i_171
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
	jp	z,i_172
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
.i_175
	ld	a,l
	cp	#(1% 256)
	jp	z,i_176
	cp	#(2% 256)
	jp	z,i_177
	cp	#(3% 256)
	jp	z,i_178
	jp	i_174
.i_176
	ld	hl,(_p_objs)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_p_objs),a
	ld	hl,9 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
	jp	i_174
.i_177
	ld	hl,_p_keys
	ld	a,(hl)
	inc	(hl)
	ld	hl,7 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
	jp	i_174
.i_178
	ld	hl,(_p_life)
	ld	h,0
	ld	bc,10
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_p_life),a
	cp	#(99 % 256)
	jp	z,i_179
	jp	c,i_179
	ld	hl,99 % 256	;const
	ld	a,l
	ld	(_p_life),a
.i_179
	ld	hl,8 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
.i_174
	ld	a,(_hotspot_destroy)
	and	a
	jp	z,i_180
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
.i_180
.i_172
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
	ld	hl,55 % 256	;const
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
	ld	hl,_tileset
	ld	(_gen_pt),hl
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_183
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
.i_181
	ld	hl,(_gpit)
	ld	h,0
	ld	a,h
	or	l
	jp	nz,i_183
.i_182
	ld	hl,0 % 256	;const
	push	hl
	ld	hl,3 % 256	;const
	push	hl
	ld	hl,_sprites_player
	push	hl
	call	sp_CreateSpr
	pop	bc
	pop	bc
	pop	bc
	ld	(_sp_player),hl
	push	hl
	ld	hl,_sprites_player+48
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	ld	hl,(_sp_player)
	push	hl
	ld	hl,_sprites_player+96
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	ld	hl,_sprites_player
	ld	(_p_next_frame),hl
	ld	(_p_current_frame),hl
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_186
.i_184
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
.i_186
	ld	a,(_gpit)
	cp	#(3 % 256)
	jp	z,i_185
	jp	nc,i_185
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
	ld	hl,_sprites_enems
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
	ld	hl,_sprites_enems+48
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
	ld	hl,_sprites_enems+96
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
	ld	hl,_sprites_enems
	pop	de
	call	l_pint
	pop	de
	call	l_pint
	jp	i_184
.i_185
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_189
.i_187
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
.i_189
	ld	a,(_gpit)
	cp	#(3 % 256)
	jp	z,i_188
	jp	nc,i_188
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
	jp	i_187
.i_188
.i_190
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_level),a
	call	sp_UpdateNow
	call	_blackout
	ld hl, _s_title
	ld de, 16384
	call depack
	call	_select_joyfunc
	call	_cortina
	call	sp_UpdateNow
	ld hl, _s_marco
	ld de, 16384
	call depack
	; Makes debugging easier
	._game_loop_init
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_playing),a
	call	_player_init
	call	_hotspots_init
	call	_locks_init
	call	_enems_init
	ld	a,#(24 % 256 % 256)
	ld	(_n_pant),a
	ld	a,#(0 % 256 % 256)
	ld	(_maincounter),a
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
	ld	hl,255 % 256	;const
	ld	a,l
	ld	(_o_pant),a
.i_192
	ld	hl,(_playing)
	ld	h,0
	ld	a,h
	or	l
	jp	z,i_193
	; Makes debugging easier
	._game_loop_do
	ld	a,#(1 % 256 % 256)
	ld	(_p_kill_amt),a
	ld	hl,(_joyfunc)
	push	hl
	ld	hl,_keys
	pop	de
	ld	bc,i_194
	push	hl
	push	bc
	push	de
	ld	a,1
	ret
.i_194
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
	jp	nc,i_195
	call	_draw_scr
	ld	hl,(_n_pant)
	ld	h,0
	ld	a,l
	ld	(_o_pant),a
.i_195
	ld	hl,(_p_objs)
	ld	h,0
	ex	de,hl
	ld	hl,(_objs_old)
	ld	h,0
	call	l_ne
	jp	nc,i_196
	call	_draw_objs
	ld	hl,(_p_objs)
	ld	h,0
	ld	a,l
	ld	(_objs_old),a
.i_196
	ld	hl,(_p_life)
	ld	h,0
	ex	de,hl
	ld	hl,(_life_old)
	ld	h,0
	call	l_ne
	jp	nc,i_197
	ld	a,#(5 % 256 % 256)
	ld	(__x),a
	ld	a,#(0 % 256 % 256)
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
.i_197
	ld	hl,(_p_keys)
	ld	h,0
	ex	de,hl
	ld	hl,(_keys_old)
	ld	h,0
	call	l_ne
	jp	nc,i_198
	ld	a,#(16 % 256 % 256)
	ld	(__x),a
	ld	a,#(0 % 256 % 256)
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
.i_198
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
	ld	a,(_p_killme)
	and	a
	jp	z,i_199
	ld	a,(_p_life)
	and	a
	jp	z,i_200
	ld	hl,(_p_killme)
	ld	h,0
	push	hl
	call	_player_kill
	pop	bc
	jp	i_201
.i_200
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_playing),a
.i_201
.i_199
	call	_bullets_move
	ld	hl,(_o_pant)
	ld	h,0
	ex	de,hl
	ld	hl,(_n_pant)
	ld	h,0
	call	l_eq
	jp	nc,i_202
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_enit),a
	jp	i_205
.i_203
	ld	hl,_enit
	ld	a,(hl)
	inc	(hl)
.i_205
	ld	a,(_enit)
	cp	#(3 % 256)
	jp	z,i_204
	jp	nc,i_204
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
	jp	i_203
.i_204
	ld	a,(_p_estado)
	ld	e,a
	ld	d,0
	ld	hl,2	;const
	call	l_and
	ld	de,0	;const
	ex	de,hl
	call	l_eq
	jp	c,i_207
	ld	a,(_half_life)
	cp	#(0 % 256)
	jp	nz,i_206
.i_207
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
	add 2
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
	jp	i_209
.i_206
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
.i_209
	ld	hl,(_p_next_frame)
	ld	(_p_current_frame),hl
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_212
.i_210
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
.i_212
	ld	a,(_gpit)
	cp	#(3 % 256)
	jp	z,i_211
	jp	nc,i_211
	ld	de,_bullets_estado
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	cp	#(1 % 256)
	jp	nz,i_213
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
	add 2
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
	jp	i_214
.i_213
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
.i_214
	jp	i_210
.i_211
	call	sp_UpdateNow
.i_202
	call	_hotspots_do
	ld	a,(_gpx)
	cp	#(0 % 256)
	jp	nz,i_216
	ld	hl,_p_vx
	call	l_gchar
	ld	de,0	;const
	ex	de,hl
	call	l_lt
	jr	c,i_217_i_216
.i_216
	jp	i_215
.i_217_i_216
	ld	hl,(_n_pant)
	ld	h,0
	dec	hl
	ld	a,l
	ld	(_n_pant),a
	ld	a,#(224 % 256 % 256)
	ld	(_gpx),a
	ld	hl,3584	;const
	ld	(_p_x),hl
.i_215
	ld	a,(_gpx)
	cp	#(224 % 256)
	jp	nz,i_219
	ld	hl,_p_vx
	call	l_gchar
	ld	de,0	;const
	ex	de,hl
	call	l_gt
	jr	c,i_220_i_219
.i_219
	jp	i_218
.i_220_i_219
	ld	hl,(_n_pant)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_n_pant),a
	ld	hl,0	;const
	ld	(_p_x),hl
	ld	h,0
	ld	a,l
	ld	(_gpx),a
.i_218
	ld	a,(_gpy)
	cp	#(0 % 256)
	jp	nz,i_222
	ld	hl,_p_vy
	call	l_gchar
	ld	de,0	;const
	ex	de,hl
	call	l_lt
	jp	nc,i_222
	ld	a,(_n_pant)
	cp	#(6 % 256)
	jr	z,i_222_uge
	jp	c,i_222
.i_222_uge
	jr	i_223_i_222
.i_222
	jp	i_221
.i_223_i_222
	ld	hl,(_n_pant)
	ld	h,0
	ld	bc,-6
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_n_pant),a
	ld	a,#(144 % 256 % 256)
	ld	(_gpy),a
	ld	hl,2304	;const
	ld	(_p_y),hl
.i_221
	ld	a,(_gpy)
	cp	#(144 % 256)
	jp	nz,i_225
	ld	hl,_p_vy
	call	l_gchar
	ld	de,0	;const
	ex	de,hl
	call	l_gt
	jr	c,i_226_i_225
.i_225
	jp	i_224
.i_226_i_225
	ld	a,(_n_pant)
	cp	#(24 % 256)
	jp	z,i_227
	jp	nc,i_227
	ld	hl,(_n_pant)
	ld	h,0
	ld	bc,6
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_n_pant),a
	ld	hl,0	;const
	ld	(_p_y),hl
	ld	h,0
	ld	a,l
	ld	(_gpy),a
	ld	hl,_p_vy
	call	l_gchar
	ld	de,256	;const
	ex	de,hl
	call	l_gt
	jp	nc,i_228
	ld	hl,256	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vy),a
.i_228
.i_227
.i_224
	ld	hl,0	;const
	ld	a,h
	or	l
	jp	nz,i_230
	ld	a,(_p_objs)
	cp	#(25 % 256)
	jp	nz,i_229
.i_230
	ld	a,#(1 % 256 % 256)
	ld	(_success),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_playing),a
.i_229
	jp	i_192
.i_193
	call	sp_UpdateNow
	call	sp_WaitForNoKey
	ld	hl,(_success)
	ld	h,0
	ld	a,h
	or	l
	jp	z,i_232
	call	_game_ending
	jp	i_233
.i_232
	call	_game_over
.i_233
	call	_cortina
	call	_clear_sprites
	jp	i_190
.i_191
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
	;DI
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
	;EI
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
	DEFB 16 ; Song length * 2
	DEFW 8 ; Offset to start of song (length of instrument table)
	DEFB 1 ; Multiple
	DEFW 10 ; Detune
	DEFB 0 ; Phase
	DEFB 1 ; Multiple
	DEFW 5 ; Detune
	DEFB 1 ; Phase
	.patterndata
	DEFW PAT0
	DEFW PAT1
	DEFW PAT0
	DEFW PAT1
	DEFW PAT2
	DEFW PAT3
	DEFW PAT2
	DEFW PAT3
	; *** Pattern data - $00 marks the end of a pattern ***
	.pat0
	DEFB $BD,0
	DEFB 152
	DEFB 140
	DEFB 6
	DEFB 157
	DEFB 140
	DEFB 6
	DEFB 159
	DEFB 188
	DEFB 6
	DEFB 152
	DEFB 140
	DEFB 6
	DEFB 157
	DEFB 6
	DEFB 159
	DEFB 6
	DEFB 152
	DEFB 6
	DEFB 159
	DEFB 6
	DEFB 151
	DEFB 139
	DEFB 6
	DEFB 157
	DEFB 139
	DEFB 6
	DEFB 159
	DEFB 188
	DEFB 6
	DEFB 151
	DEFB 139
	DEFB 6
	DEFB 157
	DEFB 6
	DEFB 159
	DEFB 6
	DEFB 151
	DEFB 6
	DEFB 159
	DEFB 6
	DEFB $00
	.pat1
	DEFB $BD,0
	DEFB 150
	DEFB 138
	DEFB 6
	DEFB 157
	DEFB 138
	DEFB 6
	DEFB 159
	DEFB 188
	DEFB 6
	DEFB 150
	DEFB 138
	DEFB 6
	DEFB 157
	DEFB 6
	DEFB 159
	DEFB 6
	DEFB 150
	DEFB 6
	DEFB 159
	DEFB 6
	DEFB 149
	DEFB 137
	DEFB 6
	DEFB 159
	DEFB 137
	DEFB 6
	DEFB 157
	DEFB 188
	DEFB 6
	DEFB 149
	DEFB 137
	DEFB 6
	DEFB 159
	DEFB 6
	DEFB 157
	DEFB 145
	DEFB 6
	DEFB 149
	DEFB 6
	DEFB 159
	DEFB 6
	DEFB $00
	.pat2
	DEFB $BD,2
	DEFB 140
	DEFB 152
	DEFB 24
	DEFB 140
	DEFB 6
	DEFB 141
	DEFB 6
	DEFB 140
	DEFB 12
	DEFB 139
	DEFB 163
	DEFB 24
	DEFB 139
	DEFB 6
	DEFB 140
	DEFB 6
	DEFB 139
	DEFB 12
	DEFB $00
	.pat3
	DEFB 138
	DEFB 150
	DEFB 24
	DEFB 138
	DEFB 6
	DEFB 139
	DEFB 6
	DEFB 138
	DEFB 12
	DEFB 137
	DEFB 161
	DEFB 30
	DEFB 133
	DEFB 145
	DEFB 18
	DEFB $00
;	SECTION	text

.i_1
	defm	"            "
	defb	0

	defm	" GAME OVER! "
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
._flags	defs	32
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
._ptgmx	defs	1
._ptgmy	defs	1
._en_an_current_frame	defs	6
._sp_player	defs	2
._sp_bullets	defs	6
.__b_x	defs	1
.__b_y	defs	1
._enoffs	defs	1
._b_it	defs	1
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
._playing	defs	1
._gpox	defs	1
._seed	defs	2
._isrc	defs	1
._p_tx	defs	1
._p_ty	defs	1
._asm_int_2	defs	2
._p_vx	defs	1
._p_vy	defs	1
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
._blx	defs	1
._bly	defs	1
._gpc	defs	1
._gpd	defs	1
._hit	defs	1
._rda	defs	1
._rdb	defs	1
._rdc	defs	1
._p_x	defs	2
._AD_FREE	defs	825
._p_y	defs	2
._gpx	defs	1
._gpy	defs	1
._rdd	defs	1
._rdn	defs	1
._itj	defs	2
._keys_old	defs	1
._rdt	defs	1
._rdx	defs	1
._rdy	defs	1
._wall_h	defs	1
._enoffsmasi	defs	1
._wall_v	defs	1
._tocado	defs	1
._is_rendering	defs	1
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
._en_an_count	defs	3
._p_disparando	defs	1
.__b_mx	defs	1
.__b_my	defs	1
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
	XDEF	_prepare_level
	XDEF	_wyz_play_music
	LIB	sp_JoyFuller
	LIB	sp_MouseAMXInit
	XDEF	_blackout_area
	LIB	sp_MouseAMX
	XDEF	_sp_moviles
	XDEF	_gpen_cx
	XDEF	_tilanims_do
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
	XDEF	_p_facing
	XDEF	_invalidate_tile
	XDEF	_p_frame
	LIB	sp_Heapify
	XDEF	_malotes
	LIB	sp_MoveSprRel
	XDEF	_tilanims_add
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
	XDEF	_hotspot_destroy
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
	XDEF	_sprites_player
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
	XDEF	_tilanims_reset
	XDEF	_enems_draw_current
	XDEF	_s_marco
	XDEF	_addsign
	XDEF	_tape_save
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
	XDEF	_sprite_17_a
	XDEF	_sprite_18_a
	XDEF	_sprite_19_a
	XREF	_sprite_19_b
	LIB	sp_MoveSprRelC
	LIB	sp_InitIM2
	XDEF	_sp_player
	XDEF	_sp_bullets
	XDEF	_beep_fx
	LIB	sp_GetTiles
	XDEF	__b_x
	XDEF	__b_y
	XDEF	_mem_save
	XDEF	_sprites_enems
	LIB	sp_Pallette
	LIB	sp_WaitForNoKey
	XDEF	_enoffs
	XDEF	_safe_byte
	defc	_safe_byte	=	23296
	XDEF	_b_it
	XDEF	_locks_init
	XDEF	_utaux
	LIB	sp_JoySinclair1
	LIB	sp_JoySinclair2
	LIB	sp_ListPrepend
	XDEF	_behs
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
	XDEF	_cm_hb_collision
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
	XDEF	_player_cells
	LIB	sp_RemoveDList
	XDEF	_gpit
	XDEF	_gpjt
	XDEF	_p_keys
	XDEF	_playing
	XDEF	_bullets_move
	XDEF	_player_calc_bounding_box
	LIB	sp_ListNext
	XDEF	_gpox
	LIB	sp_HuffDecode
	XDEF	_keys
	XDEF	_rand
	LIB	sp_Swap
	XDEF	_seed
	XDEF	_isrc
	XDEF	_p_tx
	XDEF	_p_ty
	XDEF	_print_str
	XDEF	_lame_sound
	XDEF	_asm_int_2
	XDEF	_player_deplete
	XDEF	_p_vx
	XDEF	_p_vy
	XDEF	_gpxx
	XDEF	_gpyy
	XDEF	_objs_old
	LIB	sp_ListPrev
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
	XDEF	_u_free
	XDEF	_abs
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
	XDEF	_hit
	XDEF	_hotspots_do
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
	XDEF	_gpx
	XDEF	_gpy
	XDEF	_rdd
	XDEF	_rdn
	XDEF	_itj
	LIB	sp_HuffEncode
	XDEF	_keys_old
	XDEF	_rdt
	LIB	sp_JoyTimexRight
	LIB	sp_PixelRight
	XDEF	_rdx
	XDEF	_rdy
	LIB	sp_Initialize
	XDEF	_process_tile
	XDEF	_tileset
	LIB	sp_JoyTimexLeft
	LIB	sp_SetMousePosKempston
	LIB	sp_ComputePos
	XDEF	_wyz_stop_sound
	XDEF	_wall_h
	XDEF	_enoffsmasi
	XDEF	_spacer
	XDEF	_wall_v
	LIB	sp_IntIntervals
	XDEF	_my_malloc
	XDEF	_tocado
	XDEF	_is_rendering
	LIB	sp_inp
	XDEF	_SetRAMBank
	LIB	sp_IterateSprChar
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
	defc	_ram_destination	=	23299
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
	defc	_ram_address	=	23297
	LIB	sp_StackSpace


; --- End of Scope Defns ---


; --- End of Compilation ---
