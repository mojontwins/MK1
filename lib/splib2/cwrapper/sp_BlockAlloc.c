
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

void *sp_BlockAlloc(uchar queue)
{
#asm
   LIB SPBlockAlloc

   ld hl,2
   add hl,sp
   ld a,(hl)
   call SPBlockAlloc
   ccf
   ret nc
   ld hl,0
#endasm
}

/*  enter:  A     = Pool #, 0..MAXBLKS-1 
    exit :  DE=HL = Address of memory block 
            Carry = Success 
*/
