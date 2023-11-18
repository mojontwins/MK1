	org 60000

;BeepFX player by Shiru
;You are free to do whatever you want with this code



playBasic:
	ld a,19
play:
	ld hl,sfxData		;address of sound effects data

	di
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
	pop ix				;put it into ix

	ld a,(23624)		;get border color from BASIC vars to keep it unchanged
	rra
	rra
	rra
	and 7
	ld (sfxRoutineToneBorder  +1),a
	ld (sfxRoutineNoiseBorder +1),a
	ld (sfxRoutineSampleBorder+1),a


readData:
	ld a,(ix+0)			;read block type
	ld c,(ix+1)			;read duration 1
	ld b,(ix+2)
	ld e,(ix+3)			;read duration 2
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
	ei
	ret

	

;play sample

sfxRoutineSample:
	ex de,hl
sfxRS0:
	ld e,8				;7
	ld d,(hl)			;7
	inc hl				;6
sfxRS1:
	ld a,(ix+5)			;19
sfxRS2:
	dec a				;4
	jr nz,sfxRS2		;7/12
	rl d				;8
	sbc a,a				;4
	and 16				;7
	and 16				;7	dummy
sfxRoutineSampleBorder:
	or 0				;7
	out (254),a			;11
	dec e				;4
	jp nz,sfxRS1		;10=88t
	dec bc				;6
	ld a,b				;4
	or c				;4
	jp nz,sfxRS0		;10=132t

	ld c,6
	
nextData:
	add ix,bc		;skip to the next block
	jr readData



;generate tone with many parameters

sfxRoutineTone:
	ld e,(ix+5)			;freq
	ld d,(ix+6)
	ld a,(ix+9)			;duty
	ld (sfxRoutineToneDuty+1),a
	ld hl,0

sfxRT0:
	push bc
	push iy
	pop bc
sfxRT1:
	add hl,de			;11
	ld a,h				;4
sfxRoutineToneDuty:
	cp 0				;7
	sbc a,a				;4
	and 16				;7
sfxRoutineToneBorder:
	or 0				;7
	out (254),a			;11
	ld a,(0)			;13	dummy
	dec bc				;6
	ld a,b				;4
	or c				;4
	jp nz,sfxRT1		;10=88t

	ld a,(sfxRoutineToneDuty+1)	 ;duty change
	add a,(ix+10)
	ld (sfxRoutineToneDuty+1),a

	ld c,(ix+7)			;slide
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

sfxRoutineNoise:
	ld e,(ix+5)			;pitch

	ld d,1
	ld h,d
	ld l,d
sfxRN0:
	push bc
	push iy
	pop bc
sfxRN1:
	ld a,(hl)			;7
	and 16				;7
sfxRoutineNoiseBorder:
	or 0				;7
	out (254),a			;11
	dec d				;4
	jp z,sfxRN2			;10
	nop					;4	dummy
	jp sfxRN3			;10	dummy
sfxRN2:
	ld d,e				;4
	inc hl				;6
	ld a,h				;4
	and 31				;7
	ld h,a				;4
	ld a,(0)			;13 dummy
sfxRN3:
	nop					;4	dummy
	dec bc				;6
	ld a,b				;4
	or c				;4
	jp nz,sfxRN1		;10=88 or 112t

	ld a,e
	add a,(ix+6)		;slide
	ld e,a

	pop bc
	dec bc
	ld a,b
	or c
	jr nz,sfxRN0

	ld c,7
	jr nextData


sfxData:

SoundEffectsData:
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
	defw SoundEffect10Data

SoundEffect0Data:
	defb 2 ;noise
	defw 1,1000,4
	defb 1 ;tone
	defw 4,1000,400,65436,128
	defb 2 ;noise
	defw 1,5000,150
	defb 0
SoundEffect1Data:
	defb 1 ;tone
	defw 4,1000,1000,65136,128
	defb 0
SoundEffect2Data:
	defb 2 ;noise
	defw 20,100,2561
	defb 1 ;tone
	defw 30,100,1000,65446,257
	defb 0
SoundEffect3Data:
	defb 1 ;tone
	defw 100,20,500,2,16
	defb 0
SoundEffect4Data:
	defb 1 ;tone
	defw 150,100,50,4,63552
	defb 1 ;tone
	defw 300,100,650,0,2056
	defb 0
SoundEffect5Data:
	defb 2 ;noise
	defw 8,200,20
	defb 2 ;noise
	defw 4,2000,5220
	defb 0
SoundEffect6Data:
	defb 2 ;noise
	defw 5,1000,5130
	defb 1 ;tone
	defw 20,100,200,65526,128
	defb 2 ;noise
	defw 1,10000,200
	defb 0
SoundEffect7Data:
	defb 1 ;tone
	defw 4,1000,400,100,128
	defb 1 ;tone
	defw 4,1000,400,100,64
	defb 1 ;tone
	defw 4,1000,400,100,32
	defb 1 ;tone
	defw 4,1000,400,100,16
	defb 0
SoundEffect8Data:
	defb 1 ;tone
	defw 50,50,1000,65526,128
	defb 1 ;tone
	defw 50,50,1100,65526,64
	defb 1 ;tone
	defw 50,50,1200,65526,32
	defb 1 ;tone
	defw 50,50,1300,65526,16
	defb 1 ;tone
	defw 50,50,1400,65526,8
	defb 0
SoundEffect9Data:
	defb 1 ;tone
	defw 10,1000,200,65336,128
	defb 0
SoundEffect10Data:
	defb 3 ;sample
	defw 3982
	defw Sample0Data+0
	defb 3
	defb 0

Sample0Data:
	defb 255,255,255,255,255,254,0,255,255,255,255,224,28,0,0,0
	defb 95,160,32,0,12,0,0,0,0,0,10,96,0,127,255,199
	defb 255,255,255,255,255,252,127,255,255,255,255,255,255,255,255,255
	defb 207,255,255,255,255,255,255,191,255,227,1,255,255,129,209,255
	defb 255,255,255,255,132,0,0,0,0,16,0,28,24,63,15,15
	defb 7,225,227,241,241,224,240,254,120,120,56,60,48,0,16,31
	defb 220,6,0,4,121,193,240,254,255,127,126,127,255,240,31,255
	defb 255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0
	defb 0,0,0,0,15,191,255,252,238,15,255,192,0,0,1,207
	defb 255,255,255,255,255,255,254,196,0,3,128,1,159,83,238,32
	defb 6,0,0,0,0,0,0,0,0,29,255,232,15,240,0,0
	defb 0,54,2,128,0,31,255,255,255,255,255,255,255,255,255,255
	defb 255,255,247,215,255,255,255,255,255,255,255,255,248,3,255,255
	defb 243,168,0,0,0,255,58,0,0,0,7,128,0,96,0,0
	defb 0,0,0,1,239,255,184,31,1,252,0,0,0,0,0,79
	defb 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	defb 255,255,255,255,255,255,255,127,207,179,253,252,231,238,63,222
	defb 227,56,0,0,16,3,128,29,216,12,192,48,7,255,255,244
	defb 118,0,48,4,247,31,224,28,0,31,115,255,15,224,24,0
	defb 56,31,255,255,255,252,0,0,0,1,128,255,159,254,127,129
	defb 184,3,240,127,255,255,255,248,0,0,0,0,0,0,31,255
	defb 255,255,255,252,0,0,0,0,127,255,255,255,255,240,0,0
	defb 0,0,0,31,255,255,255,255,255,224,0,0,0,0,255,255
	defb 255,255,255,192,0,0,0,0,0,127,255,255,255,255,240,0
	defb 0,0,1,255,255,255,255,255,192,0,0,0,0,0,255,255
	defb 255,255,255,192,0,0,0,15,255,255,255,255,248,0,0,0
	defb 0,0,31,255,255,255,255,248,0,0,0,0,63,255,255,255
	defb 254,0,0,0,0,0,0,255,255,255,255,254,0,0,0,0
	defb 31,255,255,255,255,0,0,0,0,0,1,255,255,255,255,255
	defb 0,0,0,0,31,255,255,255,254,0,0,0,0,0,0,127
	defb 255,255,255,255,128,0,0,0,31,255,255,255,254,0,0,0
	defb 0,0,0,255,255,255,255,255,192,0,0,0,31,255,255,255
	defb 255,0,0,0,0,0,0,63,255,255,255,255,0,0,0,0
	defb 15,255,255,255,255,128,0,0,0,0,0,31,255,255,255,255
	defb 224,0,0,0,63,255,255,255,255,248,0,0,0,0,0,1
	defb 255,255,255,255,255,224,0,0,0,31,255,255,255,255,240,0
	defb 0,0,0,0,7,255,255,255,255,255,247,0,0,0,0,63
	defb 255,255,255,255,224,0,0,0,0,0,7,255,255,255,255,255
	defb 254,0,0,0,31,255,255,255,255,240,0,0,0,0,0,0
	defb 31,255,255,255,255,255,248,0,0,0,63,255,255,255,254,0
	defb 0,0,0,0,0,0,127,255,255,255,255,255,255,0,0,0
	defb 1,255,255,255,255,192,0,0,0,0,0,0,3,255,255,255
	defb 255,255,255,255,224,0,0,0,63,255,255,255,240,0,0,0
	defb 0,0,0,1,255,255,255,255,255,255,255,255,255,254,0,0
	defb 12,3,255,63,192,0,0,0,0,0,0,0,0,127,255,255
	defb 255,255,255,255,255,248,0,0,0,0,0,15,252,0,0,0
	defb 0,0,0,0,0,15,255,255,255,255,255,255,255,255,255,255
	defb 255,251,255,255,0,0,0,0,0,0,0,0,0,0,0,0
	defb 127,255,255,255,255,255,255,255,255,255,255,255,255,255,128,0
	defb 0,0,0,0,0,0,0,0,63,199,240,0,1,252,127,255
	defb 255,255,255,255,255,255,255,255,255,255,128,0,0,0,0,0
	defb 0,3,255,255,255,192,0,0,0,0,0,0,7,255,255,255
	defb 255,255,255,255,255,255,255,255,255,255,255,255,192,0,0,0
	defb 0,0,0,0,0,0,0,0,0,0,0,3,255,255,255,255
	defb 255,255,255,255,255,255,255,255,255,239,0,0,63,255,255,255
	defb 254,126,0,0,0,0,0,0,3,255,255,252,0,0,0,0
	defb 0,0,0,127,255,255,255,255,254,0,0,0,0,63,255,255
	defb 255,255,255,255,255,255,252,31,128,0,7,192,127,0,0,0
	defb 0,0,0,0,0,0,0,0,0,0,31,255,224,0,0,0
	defb 0,63,255,255,255,255,255,255,128,0,0,0,0,0,1,255
	defb 255,255,255,255,255,255,255,255,255,255,255,255,254,7,0,8
	defb 15,255,255,255,252,0,0,0,0,0,0,0,0,1,254,63
	defb 225,248,0,0,0,7,255,255,255,255,255,255,248,0,0,0
	defb 0,3,255,255,248,0,0,0,0,0,63,255,255,255,255,255
	defb 255,255,255,255,255,255,128,0,0,0,0,0,0,0,0,0
	defb 0,0,0,0,0,31,255,255,255,255,255,255,255,255,255,255
	defb 254,127,195,248,0,0,0,0,0,0,0,0,0,1,192,0
	defb 0,0,0,0,63,255,255,255,255,255,255,248,112,0,0,63
	defb 255,255,255,255,240,0,0,0,0,0,0,3,255,255,255,255
	defb 255,255,255,7,255,255,255,255,255,255,248,0,0,0,7,131
	defb 248,127,195,252,126,0,0,14,3,255,255,255,255,255,224,0
	defb 0,0,0,0,0,60,15,255,255,255,255,255,255,255,255,255
	defb 255,255,255,0,0,0,0,0,0,0,63,192,248,3,192,0
	defb 0,0,0,0,0,63,255,255,255,255,128,0,0,0,15,255
	defb 255,255,255,255,255,255,255,128,0,0,0,0,0,0,0,0
	defb 0,0,0,0,0,0,1,255,255,255,255,255,255,255,255,255
	defb 255,255,255,252,0,0,0,0,0,0,0,0,0,0,0,0
	defb 0,0,63,255,255,255,255,255,255,255,255,255,240,0,1,240
	defb 0,0,0,0,0,0,0,0,3,255,255,255,255,255,255,255
	defb 0,0,0,0,127,255,255,255,255,248,0,0,0,0,0,0
	defb 31,255,255,255,255,255,159,255,255,248,12,255,195,255,255,223
	defb 248,31,248,124,7,255,255,247,192,127,136,127,255,255,255,128
	defb 0,0,0,31,231,255,128,1,254,0,0,63,255,255,255,224
	defb 0,0,0,0,63,255,255,255,255,192,0,0,0,3,255,255
	defb 224,0,0,7,255,128,0,3,255,255,255,255,254,0,0,0
	defb 3,255,224,0,7,255,255,255,255,248,0,0,7,255,255,255
	defb 254,0,0,0,0,63,255,255,0,3,255,255,255,224,0,0
	defb 1,255,255,255,255,0,0,0,0,127,255,255,0,0,31,255
	defb 255,248,0,0,0,255,255,255,254,0,0,0,0,255,255,254
	defb 0,0,31,255,255,255,0,0,0,15,255,255,255,128,0,0
	defb 0,63,255,255,128,0,3,255,255,255,248,0,0,0,127,255
	defb 255,192,0,0,0,1,255,255,252,0,0,63,255,255,193,255
	defb 0,0,0,127,255,255,192,0,0,0,1,255,255,248,0,0
	defb 63,255,255,240,31,224,0,0,15,255,255,252,0,0,0,0
	defb 31,255,255,128,0,3,255,255,255,192,3,128,0,0,15,255
	defb 255,255,128,0,0,0,3,255,255,240,0,0,63,255,255,224
	defb 0,31,224,0,0,255,255,255,254,48,0,0,0,31,255,255
	defb 0,0,7,255,255,255,255,252,0,0,127,224,0,63,255,255
	defb 248,0,0,0,0,127,255,252,0,15,255,192,127,255,252,0
	defb 63,255,240,0,7,255,255,240,0,0,0,0,31,255,248,0
	defb 3,255,248,0,63,255,255,128,0,127,243,255,255,248,0,0
	defb 31,255,255,255,128,0,0,0,0,1,255,255,255,255,255,255
	defb 254,0,0,255,255,255,255,255,255,0,0,0,0,0,63,255
	defb 252,0,0,0,0,15,255,255,255,255,255,240,127,255,255,255
	defb 255,240,63,248,0,0,0,0,0,0,3,255,255,240,7,255
	defb 255,192,0,3,255,255,1,255,255,252,0,0,255,255,0,7
	defb 255,255,0,0,0,127,240,127,195,248,0,0,0,31,255,248
	defb 31,255,128,112,48,1,248,31,128,7,255,255,255,223,255,239
	defb 3,240,63,191,240,127,207,224,60,1,248,0,0,3,241,224
	defb 127,1,7,128,0,127,255,255,143,128,3,192,0,15,255,143
	defb 254,0,3,252,127,136,31,127,248,7,28,15,254,63,128,124
	defb 7,240,30,0,124,63,128,28,3,248,63,192,127,129,248,7
	defb 240,127,129,255,255,240,15,248,127,128,63,7,252,63,128,252
	defb 63,0,120,15,224,120,7,128,16,127,7,248,31,128,124,15
	defb 225,254,7,240,62,15,244,127,224,248,7,224,252,15,252,15
	defb 224,248,31,192,15,7,240,30,7,224,7,195,240,63,131,240
	defb 60,30,63,7,193,240,63,192,7,195,252,63,128,16,24,0
	defb 231,255,3,195,15,192,31,131,255,199,240,63,255,255,129,252
	defb 25,248,127,0,120,31,224,127,192,224,31,128,15,131,255,0
	defb 255,7,243,252,0,255,255,193,252,15,252,63,192,255,255,255
	defb 15,128,127,128,240,7,129,252,16,0,15,240,0,24,14,31
	defb 240,255,255,255,15,192,62,62,0,3,252,255,255,255,231,255
	defb 255,128,127,248,128,0,0,0,240,252,0,0,0,0,0,0
	defb 1,255,255,255,255,255,255,255,255,255,255,255,255,255,240,0
	defb 0,0,63,255,240,0,0,0,0,0,0,0,127,255,255,255
	defb 255,255,255,255,255,255,255,255,224,0,15,255,255,255,128,0
	defb 0,0,0,0,48,0,1,255,255,255,255,255,255,192,15,255
	defb 255,252,0,7,255,255,255,254,0,0,0,0,0,0,0,224
	defb 0,63,255,255,255,224,0,0,7,255,255,252,0,15,255,255
	defb 255,224,0,0,0,0,0,0,1,255,240,0,255,255,255,128
	defb 0,127,240,3,255,224,0,127,255,255,254,0,0,0,0,0
	defb 0,0,255,255,192,1,255,255,224,0,7,255,240,255,252,0
	defb 7,255,255,255,240,0,0,248,0,0,0,63,255,255,0,3
	defb 255,254,0,254,0,127,199,255,224,0,63,255,255,255,0,0
	defb 3,192,0,0,0,127,255,254,0,7,255,254,0,31,255,248
	defb 7,255,224,0,63,255,255,255,224,0,0,64,0,0,3,255
	defb 255,255,128,3,255,255,128,1,255,254,1,255,240,0,15,255
	defb 255,254,0,0,0,0,0,0,0,255,255,255,192,0,255,255
	defb 240,0,63,255,0,63,254,0,1,255,255,248,0,0,0,0
	defb 0,0,0,3,255,255,128,0,255,255,255,254,0,0,1,255
	defb 254,0,0,127,255,255,192,0,0,0,0,0,0,0,0,255
	defb 240,31,255,252,15,255,224,0,127,255,240,0,0,0,1,255
	defb 255,255,255,255,252,0,0,0,0,31,255,255,255,255,255,255
	defb 255,0,63,252,0,0,0,0,63,255,255,224,0,0,0,0
	defb 0,0,0,127,255,255,255,255,255,255,254,0,0,0,0,0
	defb 127,255,255,255,255,224,0,0,0,0,0,0,7,255,255,255
	defb 255,255,255,248,0,0,0,0,15,255,255,255,255,254,0,0
	defb 0,0,0,0,63,255,255,255,255,255,255,224,0,0,0,0
	defb 15,255,255,255,255,252,0,0,0,0,0,0,63,255,255,255
	defb 255,255,248,0,0,0,0,1,255,255,255,255,254,0,0,0
	defb 0,0,0,15,255,255,255,255,255,255,0,0,0,0,127,255
	defb 255,255,254,0,0,0,0,0,0,0,31,255,255,255,255,255
	defb 255,128,3,255,255,255,255,240,0,0,0,0,0,0,0,31
	defb 255,255,255,255,248,0,1,255,255,255,255,255,240,0,0,0
	defb 0,0,0,7,255,255,255,255,254,0,0,0,15,255,255,255
	defb 255,224,0,0,0,0,0,0,63,255,255,255,255,255,240,0
	defb 255,255,255,240,0,0,0,0,0,0,63,255,255,128,0,0
	defb 127,255,255,255,224,0,0,0,0,0,0,127,255,254,0,0
	defb 15,255,255,248,0,15,255,248,0,0,3,252,0,15,255,255
	defb 128,0,15,255,255,255,255,255,255,252,0,0,0,0,3,255
	defb 128,0,0,0,255,255,240,15,255,252,0,0,0,0,0,3
	defb 255,224,0,0,0,255,255,192,63,255,255,127,248,0,0,3
	defb 255,240,0,0,0,63,255,252,127,255,240,7,255,0,0,15
	defb 255,192,0,0,1,255,255,255,255,255,192,0,31,240,3,255
	defb 248,0,0,0,7,255,240,63,255,240,0,63,192,1,255,252
	defb 0,7,64,3,255,240,31,255,192,3,255,0,7,255,224,0
	defb 254,0,15,254,0,127,255,0,31,248,0,63,255,0,15,240
	defb 0,255,240,1,255,240,1,255,128,7,255,224,3,255,0,15
	defb 252,0,127,252,0,127,224,0,255,248,0,255,0,15,255,0
	defb 31,255,0,31,248,0,63,254,0,63,224,3,255,192,7,255
	defb 224,7,255,0,15,255,128,31,240,0,255,240,0,255,240,3
	defb 255,192,3,255,192,15,248,0,127,252,0,127,252,1,255,224
	defb 1,255,240,3,252,0,63,254,0,63,254,0,255,248,0,127
	defb 248,1,255,0,15,255,0,31,255,1,255,252,0,63,252,1
	defb 255,0,15,255,128,15,255,199,255,254,0,31,255,0,255,128
	defb 7,255,192,7,255,255,255,143,128,3,255,224,63,192,1,255
	defb 248,0,255,255,255,240,0,0,127,255,31,128,0,31,255,128
	defb 0,255,255,255,0,0,1,255,255,240,0,0,255,255,192,0
	defb 255,255,252,0,252,1,255,255,192,0,0,255,255,128,7,7
	defb 255,248,0,252,0,255,255,240,0,0,255,255,220,0,1,255
	defb 254,0,248,0,127,255,248,0,0,63,255,255,192,0,63,255
	defb 240,126,0,63,255,255,248,0,1,255,255,255,192,0,31,255
	defb 255,224,0,3,255,255,240,0,0,15,255,255,240,0,0,7
	defb 255,131,252,254,3,248,0,7,255,255,255,255,240,48,0,255
	defb 0,127,255,255,254,0,0,0,63,255,255,255,0,0,7,248
	defb 3,255,255,255,240,0,0,0,127,255,255,254,0,0,127,128
	defb 127,255,7,255,0,1,192,0,255,255,255,252,0,0,0,3
	defb 255,248,63,240,0,62,0,7,255,255,255,240,0,0,0,31
	defb 255,255,255,255,128,0,0,1,255,255,255,248,0,0,0,0
	defb 3,255,255,255,240,0,0,0,255,255,255,252,15,240,0,0
	defb 0,63,255,255,248,0,0,0,63,255,255,255,255,248,0,0
	defb 0,63,247,255,254,0,192,0,31,248,255,255,255,255,0,0
	defb 0,7,248,63,255,0,254,0,15,248,15,255,255,255,192,0
	defb 0,3,255,1,255,192,31,224,1,252,3,255,240,255,240,3
	defb 248,0,127,192,31,252,3,254,0,63,192,127,252,31,254,0
	defb 255,0,7,224,15,248,1,255,128,63,240,7,254,3,255,255
	defb 253,200,0,0,0,12,0,127,252,255,252,0,31,0,127,255
	defb 127,254,15,224,0,0,0,255,255,255,252,63,0,0,192,15
	defb 255,255,255,128,0,0,0,0,127,255,255,254,0,252,0,15
	defb 251,255,255,255,255,0,0,0,0,1,255,255,255,248,25,0
	defb 0,0,31,255,255,255,248,0,0,0,0,7,255,255,255,255
	defb 248,0,0,0,127,31,255,249,255,240,3,224,0,0,0,255
	defb 255,255,254,3,128,0,62,0,255,255,255,255,128,120,0,0
	defb 0,31,255,255,255,255,224,0,0,0,0,15,255,255,255,192
	defb 56,0,0,0,3,255,255,255,255,255,128,0,0,0,0,255
	defb 255,255,255,255,128,0,0,0,0,3,255,207,255,255,255,128
	defb 0,0,3,224,31,255,255,255,255,248,0,0,0,31,128,255
	defb 255,255,224,63,240,7,248,3,240,31,240,127,254,7,252,0
	defb 126,0,255,248,31,224,188,240,3,128,0,127,3,254,63,255
	defb 192,254,1,255,128,255,0,255,192,31,224,31,248,7,248,1
	defb 252,1,255,1,255,3,255,129,255,64,0,0,31,224,127,254
	defb 15,240,0,14,1,255,255,255,241,255,0,0,0,6,0,127
	defb 254,255,255,223,252,3,240,0,252,3,252,31,255,192,255,0
	defb 127,224,63,192,15,240,15,192,0,96,15,193,255,255,3,252
	defb 28,127,128,255,252,31,240,63,252,1,248,0,255,131,255,255
	defb 255,192,30,0,0,0,15,224,63,254,127,255,255,254,0,192
	defb 0,3,1,255,255,255,240,127,0,0,0,31,255,255,255,255
	defb 248,0,0,0,24,0,127,253,255,255,255,248,15,128,0,126
	defb 7,252,63,255,255,254,0,0,0,0,0,15,248,63,255,128
	defb 252,0,3,224,255,255,255,248,0,0,0,0,15,255,255,255
	defb 255,248,0,0,0,252,7,195,254,255,255,241,254,15,192,96
	defb 14,1,224,255,127,255,252,62,0,0,0,7,3,252,255,255
	defb 241,252,14,0,0,24,7,241,255,255,255,248,124,15,128,56
	defb 14,7,252,31,255,193,254,0,1,192,127,15,255,252,127,248
	defb 0,0,0,0,96,127,199,255,255,191,224,48,0,0,112,15
	defb 255,255,255,255,255,224,0,0,0,48,15,199,255,255,255,255
	defb 252,15,128,7,192,1,252,31,255,255,255,255,241,240,0,0
	defb 0,7,143,255,255,255,248,0,0,0,0,63,255,255,255,240
	defb 0,0,0,0,7,255,255,255,255,254,0,0,0,0,127,255
	defb 255,255,248,0,0,0,0,1,255,255,255,255,255,128,0,0
	defb 0,0,255,255,255,255,224,0,0,0,0,31,255,255,255,255
	defb 0,0,0,0,127,255,255,255,240,0,0,0,0,0,127,255
	defb 255,255,255,224,0,0,0,0,127,255,255,255,254,0,0,0
	defb 0,7,255,255,255,248,124,0,0,0,15,255,255,255,255,240
	defb 0,0,0,7,131,255,255,255,255,143,128,0,0,31,7,240
	defb 127,131,252,31,128,240,30,7,255,255,255,254,124,0,0,0
	defb 0,255,255,255,255,255,240,0,0,0,0,63,255,255,248,192
	defb 0,0,0,0,248,63,15,240,63,0,0,0,7,128,255,255
	defb 255,255,135,192,0,0,3,224,124,255,255,255,255,195,255,252
	defb 0,255,131,255,15,255,248,15,240,0,63,224,127,135,255,143
	defb 15,240,11,224,0,120,128,15,255,255,255,225,248,0,7,224
	defb 248,255,255,255,248,0,7,0,240,127,247,240,63,199,5,255
	defb 0,11,240,31,248,255,255,255,63,248,252,31,128,1,248,7
	defb 255,227,255,255,247,128,163,248,31,255,131,255,135,255,255,249
	defb 224,7,128,3,193,248,24,15,129,245,255,15,255,252,255,239
	defb 224,120,31,192,126,255,255,255,255,255,231,255,252,7,253,252
	defb 63,131,192,0,8,3,255,255,63,255,255,253,238,191,247,111
	defb 254,190,255,253,252,3,230,255,255,255,255,255,255,255,253,255
	defb 255,224,107,255,255,255,255,255,255,248,0,63,0,31
