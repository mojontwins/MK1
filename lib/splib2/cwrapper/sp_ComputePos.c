
/*
 *      Sprite Pack V2.2
 *
 *      Spectrum and Timex Computers Game Engine
 *      Visit http://justme895.tripod.com/main.htm
 *
 *      Alvin Albrecht 06.2003
 */

#define _SPLIB
#include "spritepack.h"

void sp_ComputePos(struct sp_PSS *ps, uchar x, uchar y)
{
#asm
   LIB SPPrintString, sp_pssread, sp_psswrite

   ld hl,2
   add hl,sp
   ld d,(hl)
   ld e,22
   inc hl
   inc hl
   ld c,(hl)
   ld b,0
   inc hl
   inc hl
   ld a,(hl)
   inc hl
   ld h,(hl)
   ld l,a
   push hl
   push bc
   push de
   call sp_pssread
   ld hl,0
   add hl,sp
   call SPPrintString
   pop hl
   pop hl
   pop hl
   call sp_psswrite
#endasm
}
