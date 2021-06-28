
/*
 *      Sprite Pack V2.2
 *
 *      Spectrum and Timex Computers Game Engine
 *      Visit http://justme895.tripod.com/main.htm
 *
 *      Alvin Albrecht 09.2003
 */

#define _SPLIB
#include "spritepack.h"

uchar sp_JoyTimexEither(void)
{
#asm
   LIB SPJoyTimexEither

   call SPJoyTimexEither
   ld l,a
   ld h,0
#endasm
}

/*
  exit:   a = FxxxRLDU active low 
*/
