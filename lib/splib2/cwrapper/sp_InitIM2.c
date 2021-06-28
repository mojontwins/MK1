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

/* void sp_InitIM2(void (*isr)(void)) */
void sp_InitIM2(void *isr)
{
#asm
   LIB SPInitIM2

   ld hl,2
   add hl,sp
   ld c,(hl)
   inc hl
   ld b,(hl)
   call SPInitIM2
#endasm
}

/*
; Selects IM2.  Interrupts should be disabled prior to calling.
; enter:  bc = address of default interrupt handler
*/
