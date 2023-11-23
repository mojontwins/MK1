;
; Initialize Sprite Pack's Background Tile & Sprite Module
; Alvin Albrecht 06.2003
;

INCLUDE "SPconfig.def"
XLIB SPInitialize
LIB SPDisplayList, SPDirtyChars, SPTileArray

; Initialize
;
; Performs the following sequence:
;
; 1. Clears display list to the "default background tile"
; 2. Marks the entire display list dirty so that it
;    will be redrawn on the next update.
; 3. Creates the horizontal rotation tables.

;
; enter:  e = default background tile # (graphic)
;         d = default background pallette # (colour)
;

.SPInitialize

   ; initialize display list

   ld hl,SPDisplayList
   ld (hl),d
   inc hl
   ld (hl),e
   inc hl
   ld (hl),0
   inc hl
   ld (hl),0
   ld hl,SPDisplayList
   ld de,SPDisplayList+4
IF DISP_HIRES
   ld bc,4*(64*(SP_ROWEND-SP_ROWSTART)-1)
ELSE
   ld bc,4*(32*(SP_ROWEND-SP_ROWSTART)-1)
ENDIF
   ldir

   ; mark entire screen dirty

   ld hl,SPDirtyChars
   ld de,SPDirtyChars+1
   ld (hl),$ff
IF DISP_HIRES
   ld bc,8*(SP_ROWEND-SP_ROWSTART)-1
ELSE
   ld bc,4*(SP_ROWEND-SP_ROWSTART)-1
ENDIF
   ldir

   ; set up horizontal rotate table

   ld c,7              ; rotate by C
.rottbllp
   ld a,c
   add a,a
   or SProtatetbl/256
   ld h,a
   ld l,0
.entrylp
   ld b,c
   ld e,l
   xor a
.rotlp
   srl e
   rra
   djnz rotlp
   ld (hl),e
   inc h
   ld (hl),a
   dec h
   inc l
   jp nz, entrylp
   dec c
   jp nz, rottbllp

   ; set display mode

IF DISP_HIRES
   ld a,$86
   out ($ff),a          ; video mode 512x192, black on white, int enable
ENDIF
IF DISP_HICOLOUR
   ld a,$82
   out ($ff),a          ; hi-colour video mode, int enable
ENDIF


   ret


IF DISP_HICOLOUR
.BONW
   defb 56,56,56,56,56,56,56,56
ENDIF
