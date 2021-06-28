
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

void *sp_ListPrev(struct sp_List *list)
{
#asm
   LIB SPListPrev

   ld hl,2
   add hl,sp
   ld a,(hl)
   inc hl
   ld h,(hl)
   ld l,a
   call SPListPrev
   ccf
   ex de,hl
   ret nc
   ld hl,0
#endasm
}

/*
; enter: hl = LIST *
; exit : no carry = list empty or current pointer is before start of list
;        de = prev item before current in list
;        current pointer changed to point at prev item in list
*/
