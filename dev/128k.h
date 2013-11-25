// 128K stuff

void SetRAMBank(void) {
#asm
	.SetRAMBank
			ld	a, ($5b5c)
			and f8h
			or	b
			ld	bc, $7ffd
			ld	($5b5c), a
			out (C), a
#endasm
}
