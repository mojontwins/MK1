
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

int sp_KeyPressed(uint scancode)
{
#asm
   LIB SPKeyPressed

   ld hl,2
   add hl,sp
   ld c,(hl)
   inc hl
   ld b,(hl)
   call SPKeyPressed
   ld hl,0
   ret nc
   inc l
#endasm
}

/*
; enter : c = scan row
;         b = key mask
; exit  : carry = key is pressed
*/
