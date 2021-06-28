
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

uint sp_ScreenStr(uchar row, uchar col)
{
#asm
   LIB SPScreenStr

   ld hl,2
   add hl,sp
   ld c,(hl)
   inc hl
   inc hl
   ld a,(hl)
   call SPScreenStr
   ex de,hl
#endasm
}

/*
  enter:  A = row position (0..23) 
          C = col position (0..31) or (0..63 for sprites-hires) 
  exit : HL = address of (A,L) in display list struct background bitmap LO 
          D = pallette #
          E = graphic #
*/
