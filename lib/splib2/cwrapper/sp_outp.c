
/*
 *      Sprite Pack V2.2
 *      Alvin Albrecht 09.2003
 */

#define _SPLIB
#include "spritepack.h"

void sp_outp(uint port, uchar value)
{
#asm
   ld hl,2
   add hl,sp
   ld a,(hl)
   inc hl
   inc hl
   ld c,(hl)
   inc hl
   ld b,(hl)
   out (c),a
#endasm
}

