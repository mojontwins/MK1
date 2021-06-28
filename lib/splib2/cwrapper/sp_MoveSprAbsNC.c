
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

void sp_MoveSprAbsNC(struct sp_SS *sprite, struct sp_Rect *clip, int animate, uchar row, uchar col, uchar hpix, uchar vpix)
{
#asm
   LIB sp_moveabshelp, SPMoveSprAbs
   XREF SPMoveSprAbsNC

   call sp_moveabshelp   ; parse parameters
   call SPMoveSprAbsNC
   pop hl                ; deallocate 4-byte clip struct on stack
   pop hl                ; that was allocated by sp_moveabshelp
#endasm
}

#asm
   defw SPMoveSprAbs
#endasm
