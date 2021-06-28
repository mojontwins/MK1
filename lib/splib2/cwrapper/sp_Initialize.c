
/*
 *      Sprite Pack V2.0
 *
 *      Spectrum and Timex Computers Game Engine
 *      Visit http://justme895.tripod.com/main.htm
 *
 *      Alvin Albrecht 05.2003
 */

#define _SPLIB
#include "spritepack.h"

void sp_Initialize(uchar colour, uchar graphic)
{
#asm
   LIB SPInitialize

   ld hl,2
   add hl,sp
   ld e,(hl)
   inc hl
   inc hl
   ld d,(hl)
   call SPInitialize
#endasm
}

/*
; enter:  e = default background tile # (graphic)
;         d = default background pallette # (colour)
*/
