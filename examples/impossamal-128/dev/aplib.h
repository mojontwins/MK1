// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

#asm

	; aPPack decompressor
	; original source by dwedit
	; very slightly adapted by utopian
	; optimized by Metalbrain

	;hl = source
	;de = dest

	.depack		ld	ixl,128
	.apbranch1	ldi
	.aploop0	ld	ixh,1		;LWM = 0
	.aploop		call 	ap_getbit
			jr 	nc,apbranch1
			call 	ap_getbit
			jr 	nc,apbranch2
			ld 	b,0
			call 	ap_getbit
			jr 	nc,apbranch3
			ld	c,16		;get an offset
	.apget4bits	call 	ap_getbit
			rl 	c
			jr	nc,apget4bits
			jr 	nz,apbranch4
			ld 	a,b
	.apwritebyte	ld 	(de),a		;write a 0
			inc 	de
			jr	aploop0
	.apbranch4	and	a
			ex 	de,hl 		;write a previous byte (1-15 away from dest)
			sbc 	hl,bc
			ld 	a,(hl)
			add	hl,bc
			ex 	de,hl
			jr	apwritebyte
	.apbranch3	ld 	c,(hl)		;use 7 bit offset, length = 2 or 3
			inc 	hl
			rr 	c
			ret 	z		;if a zero is encountered here, it is EOF
			ld	a,2
			adc	a,b
			push 	hl
			ld	iyh,b
			ld	iyl,c
			ld 	h,d
			ld 	l,e
			sbc 	hl,bc
			ld 	c,a
			jr	ap_finishup2
	.apbranch2	call 	ap_getgamma	;use a gamma code * 256 for offset, another gamma code for length
			dec 	c
			ld	a,c
			sub	ixh
			jr 	z,ap_r0_gamma		;if gamma code is 2, use old r0 offset,
			dec 	a
			;do I even need this code?
			;bc=bc*256+(hl), lazy 16bit way
			ld 	b,a
			ld 	c,(hl)
			inc 	hl
			ld	iyh,b
			ld	iyl,c

			push 	bc
			
			call 	ap_getgamma

			ex 	(sp),hl		;bc = len, hl=offs
			push 	de
			ex 	de,hl

			ld	a,4
			cp	d
			jr 	nc,apskip2
			inc 	bc
			or	a
	.apskip2	ld 	hl,127
			sbc 	hl,de
			jr 	c,apskip3
			inc 	bc
			inc 	bc
	.apskip3		pop 	hl		;bc = len, de = offs, hl=junk
			push 	hl
			or 	a
	.ap_finishup	sbc 	hl,de
			pop 	de		;hl=dest-offs, bc=len, de = dest
	.ap_finishup2	ldir
			pop 	hl
			ld	ixh,b
			jr 	aploop

	.ap_r0_gamma	call 	ap_getgamma		;and a new gamma code for length
			push 	hl
			push 	de
			ex	de,hl

			ld	d,iyh
			ld	e,iyl
			jr 	ap_finishup


	.ap_getbit	ld	a,ixl
			add	a,a
			ld	ixl,a
			ret	nz
			ld	a,(hl)
			inc	hl
			rla
			ld	ixl,a
			ret

	.ap_getgamma	ld 	bc,1
	.ap_getgammaloop	call 	ap_getbit
			rl 	c
			rl 	b
			call 	ap_getbit
			jr 	c,ap_getgammaloop
			ret

#endasm

#ifdef MODE_128K
	void get_resource (unsigned char n, unsigned int destination) {
		ram_page = resources [n].ramPage; 
		ram_address = resources [n].ramOffset;
		ram_destination = destination;
		#asm	
			di
			ld a, (_ram_page)
			ld b, a
			call SetRAMBank
			
			ld hl, (_ram_address)
			ld de, (_ram_destination)
			call depack
			
			ld b, 0
			call SetRAMBank
			ei
		#endasm
	}
#else
	#ifdef COMPRESSED_LEVELS	
		void unpack (unsigned int address, unsigned int destination) {
			ram_address = address; ram_destination = destination;
			#asm
				ld hl, (_ram_address)
				ld de, (_ram_destination)
				call depack
			#endasm
		}
	#endif
#endif
		