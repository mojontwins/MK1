/*
 *      Sprite Pack V2.1
 *      Alvin Albrecht 03.2003
 */

#include "spritepack.h"

uchar sp_HuffDecode(struct sp_HuffmanCodec *hc)
{
#asm
   LIB SPHuffDecode

   ld hl,2
   add hl,sp
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
   ld c,(hl)
   inc hl
   ld a,(hl)
   inc hl
   ld h,(hl)
   ld l,a
   call SPHuffDecode
   pop hl
   ld (hl),e
   inc hl
   ld (hl),d
   inc hl
   ld (hl),c
   ld l,a
   ld h,0
#endasm
}

/*
; enter: hl = root of decoder tree
;        de = memory address of encoded message
;         c = next bit in de's byte to interpret (bit mask)
; exit :  a = next decoded symbol
;        de and c are updated for decoding the next symbol
*/
