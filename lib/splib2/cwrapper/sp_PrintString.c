
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

void sp_PrintString(struct sp_PSS *ps, uchar *s)
{
#asm
   LIB SPPrintString, sp_pssread, sp_psswrite

   ld hl,2
   add hl,sp
   ld e,(hl)
   inc hl
   ld d,(hl)
   inc hl
   ld a,(hl)
   inc hl
   ld h,(hl)
   ld l,a
   push hl
   push de
   call sp_pssread
   pop hl
   call SPPrintString
   pop hl
   call sp_psswrite
#endasm
}
