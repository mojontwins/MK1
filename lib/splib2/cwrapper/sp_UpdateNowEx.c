
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

void sp_UpdateNowEx(unsigned char a)
{
#asm
   LIB SPUpdateNow
   
   ld  hl, 2
   add hl, sp
   ld  a, (hl)

   call SPUpdateNow
#endasm
}
