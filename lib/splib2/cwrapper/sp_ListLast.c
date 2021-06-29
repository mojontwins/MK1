
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

void *sp_ListLast(struct sp_List *list)
{
#asm
   LIB SPListLast

   ld hl,2
   add hl,sp
   ld a,(hl)
   inc hl
   ld h,(hl)
   ld l,a
   call SPListLast
   ccf
   ex de,hl
   ret nc
   ld hl,0
#endasm
}

/*
; enter: hl = LIST *
; exit : no carry = list empty
;        de = item at end of list
;        current pointer changed to point at last item in list
*/
