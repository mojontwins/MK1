;
; AMX Mouse
; Alvin Albrecht 01.2003
; 08.2003: Read buttons fixed.

INCLUDE "SPconfig.def"

XLIB SPMouseAMX
LIB SPMouseAMXInit, SPtbllookup
XREF SPAMXxcoord, SPAMXycoord
defw SPMouseAMXInit

; Mouse AMX
;
; Don't forget to initialize the AMX interface.
;
; exit : a = h = y coord 0..191
;        l = x coord 0.255, hi-res: carry set adds 256
;        e = 11111MRL active low button press
; used : af,de,hl

.SPMouseAMX
   ld e,$1f
   in a,($df)      ; mouse button state will randomly
   or e            ; fluctuate except when the mouse
   ld e,a          ; buttons are really pressed!
   in a,($df)
   or e
   ld e,a
   in a,($df)
   or e
   ld e,a
   in a,($df)
   or e
   ld e,a
   in a,($df)
   or e
   ld e,a
   in a,($df)
   or e
   ld e,a
   in a,($df)
   or e
   ld e,a
   in a,($df)
   or e
   rlca
   rlca
   rlca
   and $07
   ld de,AMXButTbl
   call SPtbllookup
   ld e,a

   ld a,(SPAMXycoord+1)
   cp 8*(SP_ROWEND - SP_ROWSTART)        ; keep it in spritepack's row range
   jp c, notoutofrange
   ld a,8*(SP_ROWEND - SP_ROWSTART) - 1
   ld (SPAMXycoord+1),a
.notoutofrange
   ld h,a
IF DISP_HIRES
   ld a,(SPAMXxcoord)
   rla
   ld a,(SPAMXxcoord+1)
   rla
ELSE
   ld a,(SPAMXxcoord+1)
ENDIF
   ld l,a
   ld a,h
   ret

.AMXButTbl
   defb $f8, $fc, $fa, $fe, $f9, $fd, $fb, $ff
