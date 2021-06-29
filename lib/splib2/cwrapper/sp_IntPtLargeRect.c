
/*
 *      Sprite Pack V2.1
 *
 *      Spectrum and Timex Computers Game Engine
 *      Visit http://justme895.tripod.com/main.htm
 *
 *      Alvin Albrecht 03.2003
 */

#define _SPLIB
#include "spritepack.h"

int sp_IntPtLargeRect(uint x, uint y, struct sp_LargeRect *r)
{
#asm
   LIB SPPtInLargeRect

   pop bc
   pop ix
   pop hl
   pop de
   push de
   push hl
   push hl
   push bc
   call SPPtInLargeRect
   ld hl,0
   ret c
   inc l
#endasm
}

/*
; enter:  Rectangle #1:
;
;         ix+0/1   xtop
;         ix+2/3   xbot
;         ix+4/5   xleft
;         ix+6/7   xright
;
;         hl = y coordinate
;         de = x coordinate
;
; exit :  carry = not in rectangle
*/
