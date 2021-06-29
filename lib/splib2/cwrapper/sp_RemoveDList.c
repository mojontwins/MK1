
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

void sp_RemoveDList(struct sp_SS *sprite)
{
#asm
   LIB SPRemoveDList

   ld hl,2
   add hl,sp
   ld e,(hl)
   inc hl
   ld d,(hl)
   defb $dd
   ld l,e
   defb $dd
   ld h,d
   call SPRemoveDList
#endasm
}

/*
  enter: IX = sprite structure address 
*/
