
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

void *sp_GetCharAddr(uchar row, uchar col)
{
#asm
   LIB SPGetCharAddr

   ld hl,2
   add hl,sp
   ld a,(hl)
   inc hl
   inc hl
   ld h,(hl)
   ld l,a
   call SPGetCharAddr
#endasm
}

/*
  enter: h = y coord 0..23, l = x coord 0..31/63 
  exit : hl = screen address 
*/
