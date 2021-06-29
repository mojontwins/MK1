
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

void *sp_ListTrim(struct sp_List *list)
{
#asm
   LIB SPListTrim

   pop bc
   pop hl
   push hl
   push bc
   call SPListTrim
   ccf
   ex de,hl
   ret nc
   ld hl,0
#endasm
}

/*
; enter: hl = LIST *
; exit : no carry = list empty
;        de = last item in list
;        last item removed from list and current points to new last item
*/
