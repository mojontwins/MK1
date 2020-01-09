// MTE MK1 (la Churrera) v3.99.99 (final)
// Copyleft 2010-2017 by the Mojon Twins

// enengine.h

unsigned char collide (void) {
	#ifdef SMALL_COLLISION
		return (gpx + 8 >= cx2 && gpx <= cx2 + 8 && gpy + 8 >= cy2 && gpy <= cy2 + 8);
	#else
		return (gpx + 13 >= cx2 && gpx <= cx2 + 13 && gpy + 12 >= cy2 && gpy <= cy2 + 12);
	#endif
}

unsigned char rand (void) {
	#asm
		.rand16
			ld	hl, _seed
			ld	a, (hl)
			ld	e, a
			inc	hl
			ld	a, (hl)
			ld	d, a
			
			;; Ahora DE = [SEED]
						
			ld	a,	d
			ld	h,	e
			ld	l,	253
			or	a
			sbc	hl,	de
			sbc	a, 	0
			sbc	hl,	de
			ld	d, 	0
			sbc	a, 	d
			ld	e,	a
			sbc	hl,	de
			jr	nc,	nextrand
			inc	hl
		.nextrand
			ld	d,	h
			ld	e,	l
			ld	hl, _seed
			ld	a,	e
			ld	(hl), a
			inc	hl
			ld	a,	d
			ld	(hl), a
			
			;; Ahora [SEED] = HL
		
			ld 	a, (_asm_int)
			ld  l, a
			ret
	#endasm
}

unsigned int abs (int n) {
	if (n < 0)
		return (unsigned int) (-n);
	else 
		return (unsigned int) n;
}

#ifdef PLAYER_STEP_SOUND
	void step (void) {
		#asm
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
		#endasm	
	}
#endif

void cortina (void) {
	#asm
		;; Antes que nada vamos a limpiar el PAPER de toda la pantalla
		;; para que no queden artefactos feos
		
		ld	de, 22528			; Apuntamos con DE a la zona de atributos
		ld	b,	3				; Procesamos 3 tercios
	.clearb1
		push bc
		
		ld	b, 0				; Procesamos los 256 atributos de cada tercio
	.clearb2
	
		ld	a, (de)				; Nos traemos un atributo
		and	199					; Le hacemos la máscara 11000111 y dejamos PAPER a 0
		ld	(de), a				; Y lo volvemos a poner
		
		inc de					; Siguiente atributo
	
		djnz clearb2
		
		pop bc
		djnz clearb1
		
		;; Y ahora el código original que escribí para UWOL:	
	
		ld	a,	8
	
	.repitatodo
		ld	c,	a			; Salvamos el contador de "repitatodo" en 'c'
	
		ld	hl, 16384
		ld	a,	12
	
	.bucle
		ld	b,	a			; Salvamos el contador de "bucle" en 'b'
		ld	a,	0
	
	.bucle1
		sla (hl)
		inc hl
		dec a
		jr	nz, bucle1
			
		ld	a,	0
	.bucle2
		srl (hl)
		inc hl
		dec a
		jr	nz, bucle2
			
		ld	a,	b			; Restituimos el contador de "bucle" a 'a'
		dec a
		jr	nz, bucle
	
		ld	a,	c			; Restituimos el contador de "repitatodo" a 'a'
		dec a
		jr	nz, repitatodo
	#endasm
}
