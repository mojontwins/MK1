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

/* void sp_RegisterHookFirst(uchar vector, void (*hook)(void)) */
void sp_RegisterHookFirst(uchar vector, void *hook)
{
#asm
   LIB SPRegisterHookFirst

   ld hl,2
   add hl,sp
   ld e,(hl)
   inc hl
   ld d,(hl)
   inc hl
   ld l,(hl)
   call SPRegisterHookFirst
#endasm
}

/* THERE MUST BE TWO FREE BYTES PRIOR TO YOUR HOOK !!! */

/*
; enter: de = address of hook
;         l = interrupt vector
*/
