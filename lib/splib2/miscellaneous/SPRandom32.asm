
; 32-Bit Random Number Generator
; Thanks to Nick Fleming for the code.

;	Routine 		: random_number
;
;	Before calling		: n/a
;
;	after calling		: de,hl = 32 bit "random" number.
;
;	registers changed	: de, a, hl, flags.
;
;	 Notes:
;	--------
;	generates a 32 bit pseudo-random number from a seed
;	variable.
;
;	Uses the formula i(new) = a * i + c	(mod 2^32)
;
;	to generate some numbers. a and c are constants, and
;	i is the 'seed' for the new number. 
;
;	IMPORTANT: I've not checked it for distributions or 
;	the period before it repeats.
;
;	One of the problems is that most modern random number
;	examples use 32 bits (even Knuth !!) so there isn't a lot
;	of good data available for 16 bit generators.
;
;	Ref : See the book 'numerical recipes in C' 
;	or online at http://lib-www.lanl.gov/numerical/bookcpdf.html
;	for more info on random numbers.

XLIB SPRandom32
XDEF SPRand32Seed
LIB SPMultUnsigned

.SPRand32Seed
   defw 31415                    ; chose 'pi' as starting seed :-)

.SPRandom32
   ld bc,(SPRand32Seed)
   ld de,16807                   ; 7^5
   call SPMultUnsigned
   ld bc,8343
   add hl,bc
   ld (SPRand32Seed),hl          ; store high word of result as new seed.
   ret
