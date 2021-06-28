
/*
 *      Sprite Pack V2.1
 *
 *      Spectrum and Timex Computers Game Engine
 *      Visit http://justme895.tripod.com/main.htm
 *
 *      Alvin Albrecht 06.2003
 */

#define _SPLIB
#include "spritepack.h"

void sp_IterateDList(struct sp_Rect *r, void *hook)
{
#asm
   LIB SPIterateDList

   pop hl
   pop iy
   pop de
   push de
   push iy
   push hl
   ex de,hl
   ld a,(hl)
   inc hl
   ld c,(hl)
   inc hl
   ld e,(hl)
   inc hl
   ld d,(hl)
   call SPIterateDList
#endasm
}

/*
; enter: IY = user supplied hook address
;         A = row top left corner
;         C = col top left corner
;         D = width
;         E = height
*/
