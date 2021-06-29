
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

void *sp_BlockFit(uchar queue, uchar numcheck)
{
#asm
   LIB SPBlockFit

   ld hl,2
   add hl,sp
   ld b,(hl)
   inc hl
   inc hl
   ld a,(hl)
   call SPBlockFit
   ccf
   ret nc
   ld hl,0
#endasm
}

/*  enter:  A     = Pool #, 0..MAXBLKS-1 
            B     = # Pools to check, 1..MAXBLKS-A 
    exit :  DE=HL = Address of memory block 
            Carry = Success 
*/
