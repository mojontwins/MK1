
;
;      Sprite Pack V2.0
;
;      Spectrum and Timex Computers Game Engine
;      Visit http://justme895.tripod.com/main.htm
;
;      Alvin Albrecht 01.2003
;

XLIB sp_moveabshelp
LIB sp_fixcliprect

; Parse this C parameter list for MoveSprAbs functions:
; sp_SS *sprite, sp_Rect *clip, int animate, uchar row, uchar col, uchar hpix, uchar vpix

.sp_moveabshelp
   pop hl         ; get return address
   ld iy,-4
   add iy,sp
   ld sp,iy       ; allocate 4 bytes on stack for ClipStruct, pointed at by iy
   push hl        ; restore return address

   ld hl,21
   add hl,sp      ; hl = top of parameter list

   ld d,(hl)
   dec hl
   ld e,(hl)      ; de = sprite
   dec hl
   defb $dd
   ld l,e
   defb $dd
   ld h,d         ; ix = sprite structure

   ld d,(hl)
   dec hl
   ld e,(hl)      ; de = clip
   dec hl
   call sp_fixcliprect

   ld b,(hl)
   dec hl
   ld c,(hl)      ; bc = animate displacement
   dec hl

   dec hl
   ld d,(hl)      ; d = row coord
   dec hl
   dec hl
   ld e,(hl)      ; e = col coord
   dec hl
   dec hl
   ld a,(hl)
   dec hl
   dec hl
   ld l,(hl)      ; l = vertical pixel rotation
   ld h,a         ; h = horizontal pixel rotation

   ex de,hl
   ret
