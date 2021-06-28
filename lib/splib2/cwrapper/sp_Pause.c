
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

uint sp_Pause(uint ticks)
{
#asm
   LIB SPPause

   ld hl,2
   add hl,sp
   ld c,(hl)
   inc hl
   ld b,(hl)
   call SPPause
   ld l,c
   ld h,b
#endasm
}

/*
; enter : bc = ticks
; exit  : carry = exited early because of key press, bc=remaining time
*/
