
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

/* returns no carry if success */
struct sp_SS *sp_CreateSpr(uchar type, uchar rows, void *graphic)
{
#asm
   LIB SPCreateSpr

   ld hl,2
   add hl,sp         ; hl points past ret address
   ;ld a,(hl)         ; 'extra' parameter is colour or threshold info
   ;ex af,af'         ; a' = extra
   ;inc hl
   ;inc hl
   ;ld c,(hl)         ; c = plane
   ld c, 0
   ;inc hl
   ;inc hl
   ld e,(hl)
   inc hl
   ld d,(hl)         ; de = sprite graphic
   inc hl
   ld b,(hl)         ; b = # rows in sprite
   inc hl
   inc hl
   ld a,(hl)         ; sprite type
   or c
   ld c,a            ; c = sprite attribute

   call SPCreateSpr  ; carry = success, ix = sprite struct address

   push ix
   pop hl            ; hl = sprite struct
   ccf               ; no carry indicates success, compatible with C "iferror(..)"
#endasm
}

/*
  enter:  B = #rows 
          C = sprite attribute 
              bits 7..6 = 00 (mask-type), 01 (or-type), 10 (xor-type), 11 (load-type) 
              bits 5..0 = sprite plane 0..63, lower means closer to viewer 
         DE = sprite column definition (bitdef) 
         A' = (spectrum )  colour attribute for column 
            = (hi-colour)  colour threshold (0..7) 
            = (hi-res   )  unused 
  exit : IX = sprite structure address 
         carry for success 
*/
