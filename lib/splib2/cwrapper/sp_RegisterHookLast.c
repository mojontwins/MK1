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

/* void sp_RegisterHookLast(uchar vector, void (*hook)(void)) */
void sp_RegisterHookLast(uchar vector, void *hook)
{
#asm
   LIB SPRegisterHookLast

   ld hl,2
   add hl,sp
   ld c,(hl)
   inc hl
   ld b,(hl)
   inc hl
   ld l,(hl)
   call SPRegisterHookLast
#endasm
}

/* THERE MUST BE TWO FREE BYTES PRIOR TO YOUR HOOK !!! */

/*
; enter: bc = address of hook
;         l = interrupt vector
*/

