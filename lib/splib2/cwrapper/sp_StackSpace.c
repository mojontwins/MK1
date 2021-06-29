
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

int sp_StackSpace(void *addr)
{
#asm
   ld hl,3
   add hl,sp
   ld d,(hl)
   dec hl
   ld e,(hl)
   or a
   sbc hl,de
#endasm
}
