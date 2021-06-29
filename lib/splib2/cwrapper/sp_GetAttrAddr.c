
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

void *sp_GetAttrAddr(void *scrnaddr)
{
#asm
   LIB SPGetAttrAddr

   ld hl,2
   add hl,sp
   ld e,(hl)
   inc hl
   ld d,(hl)
   ex de,hl
   call SPGetAttrAddr
   ex de,hl
#endasm
}

/*
  enter: hl = screen address 
  exit : de = address of attribute square 
*/
