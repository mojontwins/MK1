;
; AddColSpr
; Alvin Albrecht 2002
;

INCLUDE "SPconfig.def"

XLIB SPAddColSpr
LIB SPBlockAlloc, SPDeleteSpr
XREF SPdsloop, _u_malloc
defw SPDeleteSpr

; AddColSpr 
;
; Adds a column to an existing sprite.  The column is not in the display list 
; and will not be displayed until the sprite is moved. 
;
; enter: IX = sprite structure address 
;        DE = sprite column definition 
;        A' = (spectrum )  colour attribute for entire column 
;             (hi-colour)  colour threshold
;             (hi-res   )  unused 
; exit : carry for success 
;
; The call will only fail if sufficient memory is unavailable. 

.SPAddColSpr
   ld a,(ix+5)          ; adjust sprite column address
; ******** POSSIBLE BUG FOR COMPRESS SPRITES?
   add a,a              ; for existing vertical rotation
IF DISP_HICOLOUR
   add a,(ix+5)
ENDIF
   neg
   add a,e
   jp nc, acnocry
   dec d

.acnocry
   ld e,a
   ld c,(ix+8)          ; bc = first char struct in last
   ld b,(ix+9)          ;      column of this sprite
   ld l,(ix+10)         ; hl = last char struct in sprite
   ld h,(ix+11)
   exx
   ld b,(ix+2)          ; b' = row height in chars

.acloop
   exx
   push de
   push hl

   push bc
   push ix
   ld de,14
   push de
   ld hl,(_u_malloc)
   call JPHL            ; get memory for new char struct
   pop de
   pop ix
   pop bc
   ld a,h
   or l
   jr z, acfail
   ex de,hl

   pop hl               ; hl = last char struct in sprite (next ptr)
   ld (hl),d            ; store address of new char struct
   inc hl
   ld (hl),e
   pop hl               ; hl = sprite column bitdef
   ex de,hl             ; de = spr col bitdef, hl = char struct (next ptr)
   push hl
   push bc
   xor a
   ld (hl),a            ; no next char struct in sprite
   inc hl
   ld (hl),a
   inc hl
   ld (hl),a            ; no previous char struct in display list
   inc hl
   ld (hl),a
   inc hl
   ld a,(ix+13)
   and $c0              ; sprite type
   or (ix+12)           ; OR in sprite plane
   ld (hl),a            ; sprite attribute
   inc hl               ; hl = char struct bitdef left
   ld a,7
   add a,c
   ld c,a               ; bc = last column char struct bitdef
   jp nc, noinc1
   inc b

.noinc1
   ld a,(bc)            ; store bitdef left in char struct
   ld (hl),a
   inc bc
   inc hl
   ld a,(bc)
   ld (hl),a
   inc hl
   inc bc
   ld (hl),e            ; store bitdef in char struct
   inc hl
   ld (hl),d
   inc hl
IF COMPRESS
   ld a,(ix+13)
   and $c0
ENDIF
IF DISP_HICOLOUR
   ld a,24
ELSE
   ld a,16
ENDIF
IF COMPRESS
   jr z, nochange
IF DISP_HICOLOUR
   ld a,16
ELSE
   ld a,8
ENDIF
.nochange
ENDIF
   add a,e
   ld e,a               ; next char in sprite column definition
   jp nc, acnocry3
   inc d

.acnocry3
   ld a,(bc)            ; store current horizontal rotation in char struct
   ld (hl),a
   inc hl
;IF !DISP_HIRES
;   ex af,af'
;   ld (hl),a
;   ex af,af'
;ENDIF
   inc hl
   ld (hl),0            ; no next char struct in display list
   pop hl               ; hl = last column char struct
   ld b,(hl)
   inc hl
   ld c,(hl)            ; bc = next char struct in last column
   pop hl               ; hl = last char struct in sprite
   exx
   djnz acloop          ; add char for all rows
   exx
   ld e,(ix+10)         ; de = old last char struct in sprite
   ld d,(ix+11)
   ld (ix+10),l         ; store new last char struct
   ld (ix+11),h
   ex de,hl
   ld d,(hl)
   inc hl
   ld e,(hl)            ; de = char struct following old last char struct
   ld (ix+8),e          ; becomes last column in sprite
   ld (ix+9),d
   inc (ix+3)           ; sprite width increases by 1
   scf                  ; success
   ret

.acfail
   pop hl
   pop de
   ld l,(ix+10)
   ld h,(ix+11)
   ld d,(hl)
   ld (hl),0
   inc hl
   ld e,(hl)
   ex de,hl
   jp SPdsloop

.JPHL
   jp (hl)
