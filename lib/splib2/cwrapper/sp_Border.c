
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

void sp_Border(uchar colour)
{
#asm
   LIB SPBorder

   ld hl,2
   add hl,sp
   ld a,(hl)
   call SPBorder
#endasm
}

/*
; enter:   a = border colour 0..7
*/
