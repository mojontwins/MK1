;
; Simulated Mouse Position
; Alvin Albrecht 06.2003
;

INCLUDE "SPconfig.def"

XLIB SPSetMousePosSim

; Set Position for Simulated Mouse
;
; enter: h = y coord 0..191
;        l = x coord 0.255, hi-res: carry set adds 256
;       de = struct sp_UDM
; used : (af'),af,bc,de,hl

.SPSetMousePosSim
   ex de,hl               ; hl = UDM, d = y coord, e = x coord
IF DISP_HIRES
   ex af,af'              ; save carry flag
ENDIF
   ld bc,6
   add hl,bc              ; hl = UDM.state
   xor a
   ld (hl),a              ; state = 0
   inc hl
   ld (hl),a              ; count = 0
   inc hl
   ld (hl),a
   inc hl
   ld (hl),d              ; set y coord
   inc hl
IF DISP_HIRES
   ex af,af'
   rr e
   rra
ENDIF
   ld (hl),a
   inc hl
   ld (hl),e              ; set x coord
   ret
