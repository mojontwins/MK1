
/*
 *      Sprite Pack V2.0
 *
 *      Spectrum and Timex Computers Game Engine
 *      Visit http://justme895.tripod.com/main.htm
 *
 *      Alvin Albrecht 01.2003, 06.2003
 */

#define _SPLIB
#include "spritepack.h"

void sp_ClearRect(struct sp_Rect *area, uchar colour, uchar graphic, uchar affect)
{
#asm
   LIB SPClearRect
   XREF SPClearRectP

   ld hl,2
   add hl,sp
   ld a,(hl)
   inc hl
   inc hl
   ex af,af
   ld e,(hl)
   inc hl
   inc hl
   ld d,(hl)
   inc hl
   inc hl

   ld a,(hl)
   inc hl
   ld h,(hl)
   ld l,a        ; hl = area

   ld b,(hl)
   inc hl
   ld c,(hl)
   inc hl
   ld a,(hl)
   inc hl
   ld l,(hl)
   ld h,b
   ld b,a
   ld a,c
   ld c,l
   ld l,a

   call SPClearRectP
#endasm
}
#asm
   defw SPClearRect
#endasm

/*
  enter:  H = row coord top left corner 
          L = col coord top left corner 
          B = row height in characters 
          C = col width in characters 
          D = background tile pallette # (colour)
          E = background tile graphic #
         A' = bit 0 is 1 to affect background tile
              bit 1 is 1 to affect sprites
*/
