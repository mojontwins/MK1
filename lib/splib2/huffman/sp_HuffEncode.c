/*
 *      Sprite Pack V2.1
 *      Alvin Albrecht 03.2003
 */

#include "spritepack.h"

void sp_HuffEncode(struct sp_HuffmanCodec *hc, uchar c)
{
#asm
   LIB SPHuffEncode

   ld hl,2
   add hl,sp
   ld c,(hl)
   inc hl
   inc hl
   ld a,(hl)
   inc hl
   ld h,(hl)
   ld l,a
   inc hl
   inc hl
   push hl
   ld e,(hl)
   inc hl
   ld d,(hl)
   inc hl
   ld a,(hl)
   inc hl
   inc hl
   inc hl
   ld b,(hl)
   inc hl
   ld h,(hl)
   ld l,b
   call SPHuffEncode
   pop de
   ex de,hl
   ld (hl),e
   inc hl
   ld (hl),d
   inc hl
   ld (hl),c
#endasm
}

/*
; enter: hl = addr of encoder array (array indexed by symbols pointing at decoder tree leaves)
;         c = symbol to encode
;        de = memory address to write encoded symbol to
;         a = next bit in de to write to (bit mask)
; exit : hl = memory address to write next encoded symbol to
;         c = next bit in hl to write to (bit mask)
*/
