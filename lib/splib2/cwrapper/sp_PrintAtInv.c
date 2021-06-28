
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

void sp_PrintAtInv(uchar row, uchar col, uchar colour, uchar graphic)
{
#asm
   LIB SPPrintAtInv

   ld hl,2
   add hl,sp
   ld e,(hl)
   inc hl
   inc hl
   ld d,(hl)
   inc hl
   inc hl
   ld c,(hl)
   inc hl
   inc hl
   ld a,(hl)
   call SPPrintAtInv
#endasm
}

/*
  enter:  A = row position (0..23) 
          C = col position (0..31) or (0..63 for sprites-hires) 
          D = pallette #
          E = graphic #
*/
