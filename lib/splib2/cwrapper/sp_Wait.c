
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

void sp_Wait(uint ticks)
{
#asm
   LIB SPWait

   pop hl
   pop bc
   push bc
   push hl
   call SPWait
#endasm
}

/*
; enter : bc = ticks
; used  : af, bc
*/
