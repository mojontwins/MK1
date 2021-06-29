
/*
 *      Sprite Pack V2.1
 *      Alvin Albrecht 03.2003
 */

#include "spritepack.h"

void sp_Swap(void *addr1, void *addr2, uint bytes)
{
#asm
   LIB SPSwap

   ld hl,2
   add hl,sp
   ld c,(hl)
   inc hl
   ld b,(hl)
   inc hl
   ld e,(hl)
   inc hl
   ld d,(hl)
   inc hl
   ld a,(hl)
   inc hl
   ld h,(hl)
   ld l,a
   call SPSwap
#endasm
}

/*
; An overlap-safe swap of two memory blocks.
;
; enter:  bc = # bytes to swap
;         hl = address of block 1
;         de = address of block 2
*/
