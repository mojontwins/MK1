
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

void sp_MouseAMXInit(uchar xvector, uchar yvector)
{
#asm
   LIB SPMouseAMXInit

   ld hl,2
   add hl,sp
   ld c,(hl)
   inc hl
   inc hl
   ld b,(hl)
   call SPMouseAMXInit
#endasm
}

/*
; DISABLE INTERRUPTS BEFORE CALLING!
;
; enter: 
;        b  = im 2 vector for X interrupts (even, 0..254)
;        c  = im 2 vector for Y interrupts (even, 0..254)
*/
