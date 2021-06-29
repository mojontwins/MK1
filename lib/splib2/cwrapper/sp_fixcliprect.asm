
;
;      Sprite Pack V2.0
;
;      Spectrum and Timex Computers Game Engine
;      Visit http://justme895.tripod.com/main.htm
;
;      Alvin Albrecht 01.2003
;

XLIB sp_fixcliprect

; Converts a sp_Rect pointed at by de into a ClipStruct point at by iy,
; the latter is expected by the assembly API.

.sp_fixcliprect
   ld a,(de)
   ld (iy+0),a
   inc de
   ld a,(de)
   ld (iy+2),a
   inc de
   ld a,(de)
   add a,(iy+0)
   ld (iy+1),a
   inc de
   ld a,(de)
   add a,(iy+2)
   ld (iy+3),a
   ret
