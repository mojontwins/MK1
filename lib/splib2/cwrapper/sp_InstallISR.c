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

/* void (*old_isr)(void) sp_InstallISR(uchar vector, void (*isr)(void)) */
void *sp_InstallISR(uchar vector, void *isr)
{
#asm
   LIB SPInstallISR

   ld hl,2
   add hl,sp
   ld e,(hl)
   inc hl
   ld d,(hl)
   inc hl
   ld l,(hl)
   call SPInstallISR
   ex de,hl
#endasm
}

/*
; INTERRUPTS SHOULD BE DISABLED PRIOR TO CALLING!
;
; enter:  l = vector to install on (even, 0..254)
;        de = ISR address
; exit : de = old ISR address
*/
