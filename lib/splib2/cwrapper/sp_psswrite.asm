
;
;      Sprite Pack V2.2
;
;      Spectrum and Timex Computers Game Engine
;      Visit http://justme895.tripod.com/main.htm
;
;      Alvin Albrecht 06.2003
;

XLIB sp_psswrite

; Store registers into "struct sp_PSS" pointed at by hl

.sp_psswrite
   inc hl
   inc hl
   ld (hl),e
   inc hl
   ld (hl),b
   inc hl
   ld (hl),c
   inc hl
   push hl
   exx
   ex (sp),hl
   ld (hl),c
   inc hl
   ld a,b
   pop bc
   ld (hl),c
   inc hl
   ld (hl),b
   inc hl
   ld (hl),e
   inc hl
   ld (hl),d
   inc hl
   ld (hl),a
   exx
   ret
