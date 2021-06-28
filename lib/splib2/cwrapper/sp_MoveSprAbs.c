
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

void sp_MoveSprAbs(struct sp_SS *sprite, struct sp_Rect *clip, int animate, uchar row, uchar col, uchar hpix, uchar vpix)
{
#asm
   LIB sp_moveabshelp, SPMoveSprAbs

   call sp_moveabshelp   ; parse parameters
   call SPMoveSprAbs
   pop hl                ; deallocate 4-byte clip struct on stack
   pop hl                ; that was allocated by sp_moveabshelp
#endasm
}

/*
  enter: IX = sprite structure address 
         BC = animate bitdef displacement (0 for no animation) 
          H = new row coord in chars 
          L = new col coord in chars 
          D = new horizontal rotation (0..7) ie horizontal pixel position 
          E = new vertical rotation (0..7) ie vertical pixel position 
         IY = clipping rectangle, set it to "ClipStruct" for full screen 
*/
