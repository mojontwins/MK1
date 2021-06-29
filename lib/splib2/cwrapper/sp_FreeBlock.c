
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

void sp_FreeBlock(void *addr)
{
#asm
   LIB SPFreeBlock

   ld hl,2
   add hl,sp
   ld e,(hl)
   inc hl
   ld d,(hl)
   call SPFreeBlock
#endasm
}

/*
  enter:  DE    = address of a block, as returned by BlockAlloc or BlockFit 
*/
