; loader.asm
; loads the loader
; by na_th_an - Thanks to Antonio Villena for his tutorials and utilities.

	org $5ccb
	ld  sp, 23999
	di
	db	$de, $c0, $37, $0e, $8f, $39, $96 ;OVER USR 7 ($5ccb)
	
	call blackout

; load screen
	scf
	ld	a, $ff
	ld	ix, $4000
	ld	de, 6912
	call $0556
	di

; RAM1
	ld	a, $11 		; ROM 1, RAM 1
	ld	bc, $7ffd
	out (C), a

	scf
	ld	a, $ff
	ld	ix, $C000
	ld	de, 5720
	call $0556
	di

; RAM3
	ld	a, $13 		; ROM 1, RAM 3
	ld	bc, $7ffd
	out (C), a

	scf
	ld	a, $ff
	ld	ix, $C000
	ld	de, 16201
	call $0556
	di

; RAM4
	ld	a, $14 		; ROM 1, RAM 4
	ld	bc, $7ffd
	out (C), a

	scf
	ld	a, $ff
	ld	ix, $C000
	ld	de, 16348
	call $0556
	di

; RAM6
	ld	a, $16 		; ROM 1, RAM 6
	ld	bc, $7ffd
	out (C), a

	scf
	ld	a, $ff
	ld	ix, $C000
	ld	de, 2247
	call $0556
	di

; Main binary
	ld	a, $10 		; ROM 1, RAM 0
	ld	bc, $7ffd
	out (C), a

	scf
	ld	a, $ff
	ld	ix, 24000
	ld	de, 30237
	call $0556
	di
	
; run game!
	jp 24000

blackout:
	; screen 0
		ld  bc, 767
		ld	hl, $5800
		ld	de, $5801
		ld	(hl), l
		ldir
		ret
		
