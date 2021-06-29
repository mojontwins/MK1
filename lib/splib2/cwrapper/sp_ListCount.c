
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

uint sp_ListCount(struct sp_List *list)
{
#asm
   LIB SPListCount

   ld hl,2
   add hl,sp
   ld a,(hl)
   inc hl
   ld h,(hl)
   ld l,a
   call SPListCount
   ex de,hl
#endasm
}

/*
; enter: hl = LIST *
; exit : de = # items in list
*/
