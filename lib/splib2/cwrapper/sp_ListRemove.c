
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

void *sp_ListRemove(struct sp_List *list)
{
#asm
   LIB SPListRemove

   pop bc
   pop hl
   push hl
   push bc
   call SPListRemove
   ccf
   ex de,hl
   ret nc
   ld hl,0
#endasm
}

/*
; enter: hl = LIST *
; exit : no carry = list empty or current is not INLIST
;        de = item removed
;        remove current item from list, current moves to next item
*/
