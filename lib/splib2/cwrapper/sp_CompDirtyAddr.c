
/*
 *      Sprite Pack V2.0
 *
 *      Spectrum and Timex Computers Game Engine
 *      Visit http://justme895.tripod.com/main.htm
 *
 *      Alvin Albrecht 01.2003
 */

#define _SPLIB
#include "spritepack.h"

void *sp_CompDirtyAddr(uchar row, uchar col, uchar *mask)
{
#asm
   LIB SPCompDirtyAddr

   ld hl,6
   add hl,sp
   ld a,(hl)
   dec hl
   dec hl
   ld c,(hl)
   dec hl
   push hl
   call SPCompDirtyAddr
   pop de
   ex de,hl
   ld b,(hl)
   dec hl
   ld c,(hl)
   ex de,hl
   ld (bc),a
#endasm
}

/*
; enter:  A = row position (0..23)
;         C = col position (0..31/63)
; exit : HL = dirty char address
;         A = bit position of char within dirty byte
*/
