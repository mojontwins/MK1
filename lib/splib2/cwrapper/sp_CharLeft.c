
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

void *sp_CharLeft(void *scrnaddr)
{
#asm
   LIB SPCharLeft

   ld hl,2
   add hl,sp
   ld e,(hl)
   inc hl
   ld d,(hl)
   ex de,hl
   or a
   call SPCharLeft
#endasm
}

/*  enter: HL = valid screen address, carry reset 
    exit : Carry = moved off screen 
           HL = moves one character left, with line wrap 
*/
