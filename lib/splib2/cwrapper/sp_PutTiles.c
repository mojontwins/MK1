
/*
 *      Sprite Pack V2.2
 *
 *      Spectrum and Timex Computers Game Engine
 *      Visit http://justme895.tripod.com/main.htm
 *
 *      Alvin Albrecht 07.2003
 */

#define _SPLIB
#include "spritepack.h"

void sp_PutTiles(struct sp_Rect *r, void *src)
{
#asm
   LIB SPPutTiles

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
   ld b,(hl)
   inc hl
   ld c,(hl)
   inc hl
   ld a,(hl)
   inc hl
   ld h,(hl)
   ld l,a
   ld a,b
   ex de,hl
   call SPPutTiles
#endasm
}

/*
; enter : hl = source address (buffer)
;          A = row coord of top left corner of rectangle
;          C = col coord of top left corner of rectangle
;          D = width of rectangle
;          E = height of rectangle
*/
