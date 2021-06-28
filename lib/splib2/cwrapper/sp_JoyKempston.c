
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

uchar sp_JoyKempston(void)
{
#asm
   LIB SPJoyKempston

   call SPJoyKempston
   ld l,a
   ld h,0
#endasm
}

/*
  exit:   a = FxxxRLDU active low 
*/
