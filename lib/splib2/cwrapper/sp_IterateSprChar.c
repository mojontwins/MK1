
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

/*void sp_IterateSprChar(struct sp_SS *sprite, void (*hook)(sp_CS *cs))*/
void sp_IterateSprChar(struct sp_SS *sprite, void *hook)
{
#asm
   LIB SPIterateSprChar

   pop hl
   pop iy
   pop ix
   push ix
   push iy
   push hl
   call SPIterateSprChar
#endasm
}

/*
  enter: IX = sprite structure address 
         IY = user supplied subroutine address 
              user hook can use all registers safely 
                (af & hl change between calls) 
              hook routine entered with hl = char struct + 0 
*/
