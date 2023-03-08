// MTE MK1 (la Churrera) v5.10
// Copyleft 2010-2014, 2020-2023 by the Mojon Twins

// mtasmlib.h

#asm
	.HLshr6_A
		// HL shr 6 -> CCBBBBBB AAxxxxxx -> BBBBBBAA
		sla h 
		sla h 			// BBBBBB00

		ld  a, l 
		rlca
		rlca 
		and 0x03 		// 000000AA

		or  h 			// BBBBBBAA
		ret 

	.Ashl16_HL
		// A shl 6 -> BBBBBBAA -> 00BBBBBB AA000000
		ld  l, 0

		ld  h, a
		srl h 			// H = 0BBBBBBA, C = A
		rr  l 			// L = A0000000
		srl h 			// H = 00BBBBBB, C = A
		rr  l 			// L = AA000000
		ret

	.withSign
		// To be called after Ashl16_HL to copy sign & extend
		bit 7, a
		ret z
		ld  a, $C0 		// 11000000
		or  h
		ld  h, a 
		ret
#endasm
		