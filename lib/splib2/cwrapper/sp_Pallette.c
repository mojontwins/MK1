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

void *sp_Pallette(uchar c, void *addr)
{
#asm
   LIB SPPallette

   ld hl,2
   add hl,sp
   ld e,(hl)
   inc hl
   ld d,(hl)
   inc hl
   ld a,(hl)
   call SPPallette
   ex de,hl
#endasm
}

/*
; enter : de = address of colour array to associate with pallette entry
;          a = pallette entry code
; exit  : de = old colour array
*/

