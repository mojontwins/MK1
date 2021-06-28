
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

void sp_DeleteSpr(struct sp_SS *sprite)
{
#asm
   LIB SPDeleteSpr

   ld hl,2
   add hl,sp
   ld e,(hl)
   inc hl
   ld d,(hl)
   call SPDeleteSpr
#endasm
}

/*
  enter: DE = sprite structure address 
*/

