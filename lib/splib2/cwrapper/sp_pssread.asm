
;
;      Sprite Pack V2.2
;
;      Spectrum and Timex Computers Game Engine
;      Visit http://justme895.tripod.com/main.htm
;
;      Alvin Albrecht 06.2003
;

XLIB sp_pssread

; Set up registers from "struct sp_PSS" pointed at by hl

.sp_pssread
   ld e,(hl)
   inc hl
   ld d,(hl)
   inc hl
   defb $fd
   ld l,e
   defb $fd
   ld h,d
   ld e,(hl)
   inc hl
   ld b,(hl)
   inc hl
   ld c,(hl)
   inc hl
   push hl
   exx
   pop hl
   ld c,(hl)
   inc hl
   ld e,(hl)
   inc hl
   ld d,(hl)
   inc hl
   ld a,(hl)
   inc hl
   ex af,af'
   ld a,(hl)
   inc hl
   ld b,(hl)
   ld h,a
   ex af,af'
   ld l,a
   ex de,hl
   exx
   ret
