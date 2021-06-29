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

void *sp_TileArray(uchar c, void *addr)
{
#asm
   LIB SPTileEntry

   ld hl,2
   add hl,sp
   ld e,(hl)
   inc hl
   ld d,(hl)
   inc hl
   ld a,(hl)
   call SPTileEntry
   ex de,hl
#endasm
}

/*
; enter : de = address of graphic to associate with character code
;          a = character code
; exit  : de = old graphic address
*/
