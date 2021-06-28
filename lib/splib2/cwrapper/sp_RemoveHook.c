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

/* int sp_RemoveHook(uchar vector, void (*hook)(void)) */
int sp_RemoveHook(uchar vector, void *hook)
{
#asm
   LIB SPRemoveHook

   ld hl,2
   add hl,sp
   ld c,(hl)
   inc hl
   ld b,(hl)
   inc hl
   ld l,(hl)
   call SPRemoveHook
   ld hl,1
   ccf
   ret nc
   dec l
#endasm
}

/*
; enter: bc = address of hook
;         l = interrupt vector
; exit : Carry flag reset if hook not found
*/
