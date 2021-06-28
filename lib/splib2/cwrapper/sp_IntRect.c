
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

int sp_IntRect(struct sp_Rect *r1, struct sp_Rect *r2, struct sp_Rect *result)
/* zero return = no overlap or use "iferror(...)" */
{
#asm
   LIB sp_fixcliprect, SPIntRect

   ld hl,7
   add hl,sp

   ld iy,-4             ; allocate a ClipStruct on stack
   add iy,sp
   ld sp,iy
   
   ld d,(hl)
   dec hl
   ld e,(hl)            ; de = r1
   dec hl
   call sp_fixcliprect  ; converted to clip rect and stored at iy

   ld d,(hl)
   dec hl
   ld e,(hl)            ; de = r2
   dec hl
   push hl
   ex de,hl
   ld b,(hl)
   inc hl
   ld c,(hl)
   inc hl
   ld d,(hl)
   inc hl
   ld e,(hl)

   call SPIntRect
   pop hl
   ld a,(hl)
   dec hl
   ld l,(hl)
   ld h,a     ; hl = result
   ld (hl),b
   inc hl
   ld (hl),c
   inc hl
   ld (hl),d
   inc hl
   ld (hl),e

   pop hl
   pop hl

   ld hl,1
   ret nc
   dec l
#endasm
}

/*
  enter:  Rectangle #1: 

          B = row coord top left corner 
          C = col coord top left corner 
          D = row height in chars 
          E = col width in chars 

          Rectangle #2 (aka clipping rectangle): 

          (iy+0) = row coord top left corner 
          (iy+1) = row coord bottom right corner + 1 
          (iy+2) = col coord top left corner 
          (iy+3) = col coord bottom right corner + 1 

  exit :  carry = resulting rectangle is empty 
          B = row coord top left corner of intersection 
          C = col coord top left corner of intersection 
          D = row height in chars of intersection 
          E = col width in chars of intersection 
*/
