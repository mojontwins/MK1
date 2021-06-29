
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

void sp_MoveSprRel(struct sp_SS *sprite, struct sp_Rect *clip, int animate, char rel_row, char rel_col, char rel_hpix, char rel_vpix)
{
#asm
   LIB sp_moveabshelp, SPMoveSprRel

   call sp_moveabshelp   ; parse parameters -- cheat: same parameter order as MoveSprAbs
   call SPMoveSprRel
   pop hl                ; deallocate 4-byte clip struct on stack
   pop hl                ; that was allocated by sp_moveabshelp
#endasm
}

/*
  enter: IX = sprite structure address 
         BC = animate bitdef displacement (0 for no animation) 
          H = relative row coord in chars (signed byte) 
          L = relative col coord in chars (signed byte) 
          D = relative horizontal pixel movement (signed byte) 
          E = relative vertical pixel movement (signed byte) 
         IY = clipping rectangle, set it to "ClipStruct" for full screen 
*/
