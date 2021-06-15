// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// 128K stuff

void SetRAMBank(void) {
#asm
	.SetRAMBank
			ld	a, b
			or	a
			jp	z, restISR
			xor	a
			ld	i, a
			jp	keepGoing
	.restISR
			ld	a, $f0
			ld	i, a
	.keepGoing
			ld	a, 16
			or	b
			ld	bc, $7ffd
			out (C), a
#endasm
}
