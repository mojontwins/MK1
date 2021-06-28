;
; MoveSprAbs
; Alvin Albrecht 2002
; AA: Fixed 08.2003: Displacement not added to null sprite ptr.
;

INCLUDE "SPconfig.def"

XLIB SPMoveSprAbs
XDEF SPMoveSprAbsC, SPMoveSprAbsNC
LIB SPInvalidate, SPDisplayList, SPNullSprPtr, SPCompNullSprPtr
XREF SPInvalidateP
defw SPInvalidate

; MoveSprAbs 
;
; Moves the sprite to a new absolute position.  Portions of the sprite that are 
; outside the clipping rectangle will not be displayed.  The sprite is automatically 
; invalidated so that it and the space it left will be redrawn in the next update. 
; Only enters sprite into the display list if its character coordinate changes. 
;
; enter: IX = sprite structure address 
;        BC = animate bitdef displacement (0 for no animation) 
;         H = new row coord in chars 
;         L = new col coord in chars 
;         D = new horizontal rotation (0..7) ie horizontal pixel position 
;         E = new vertical rotation (0..7) ie vertical pixel position 
;        IY = clipping rectangle, set it to "ClipStruct" for full screen 

.SPMoveSprAbs
   ld a,h
   cp (ix+0)            ; avoid changing coords if we can to avoid expensive
   jp nz, SPMoveSprAbsC ; insertions and deletions in the display list
   ld a,l
   cp (ix+1)
   jp nz, SPMoveSprAbsC

.SPMoveSprAbsNC
   call computedisp     ; bc' = bitdef displacement, d' = msb horizontal rotate table
   defb $dd
   ld c,l
   defb $dd
   ld b,h               ; bc = ix
   ld hl,6
   add hl,bc            ; hl = ix+6 = ptr to ptr to first char struct in sprite

.adjloop
   ld a,(hl)
   or a
   jp z, invalidate     ; no more char structs in sprite
   inc hl
   ld l,(hl)
   ld h,a               ; hl = char struct + 0
   call adjustgraphics  ; apply bitdef displacement and vertical rotation to graphic ptrs
   jp adjloop


.SPMoveSprAbsC
   exx
   call invalidate      ; invalidate area currently occupied by sprite
   exx

   ld (ix+0),h          ; store new row coord
   ld (ix+1),l          ; store new col coord
   call computedisp     ; bc' = bitdef displacement, d' = msb horizontal rotate table

   ; compute address in display list for top left corner of sprite

   ld h,0
   ld a,(ix+0)          ;  a = row coordinate top left corner
   cp SP_ROWEND-SP_ROWSTART
   jr c, yinscreen
   dec h

.yinscreen
   ld l,a               ; hl = signed row disp from start of screen
   add hl,hl
   add hl,hl
   add hl,hl
   add hl,hl
   add hl,hl
IF DISP_HIRES
   add hl,hl
ENDIF                   ; hl = (row coordinate)*(COLEND-COLSTART)
   ld d,0
   ld a,(ix+1)          ;  a = col coordinate of top left corner
IF DISP_HIRES
   cp 64
ELSE
   cp 32
ENDIF
   jr c, xinscreen
   dec d

.xinscreen
   ld e,a               ; de = signed column disp from start of row
   add hl,de            ; hl = row*(COLEND-COLSTART)+col
   add hl,hl            ; four bytes per display list entry
   add hl,hl            ; hl = (row*(COLEND-COLSTART)+col)*4
   ld de,SPDisplayList
   add hl,de
   ex de,hl             ; de = display list address, top left corner of sprite
   inc de
   inc de               ; point at linked list of sprites

   defb $dd
   ld c,l
   defb $dd
   ld b,h               ; bc = ix
   ld hl,6
   add hl,bc            ; hl = ix+6 = ptr to ptr to first char struct in sprite

   ld c,(ix+1)          ; c = current col coord
   push de              ; save display list address, top row of sprite

.mvcolloop
   ld b,(ix+0)          ; b = current row coord
   ld a,(ix+2)          ; a = sprite row height

.mvrowloop
   ex af,af'            ; a ' = row height
   ld a,(hl)
   or a
   jp nz, notdone       ; still more char structs in sprite
   pop de               ; pop off saved display list address
   jp invalidate        ; invalidate area sprite moved to

.notdone
   inc hl
   ld l,(hl)
   ld h,a               ; hl = char struct + 0

   ; first remove char struct from display list

   push de              ; save current display list position
   push hl              ; save current char struct + 0
   inc hl
   inc hl
   ld a,(hl)            ; can't remove char struct from display list
   or a                 ;   if it's not there now!
   jr z, notinDList
   ld (hl),0            ; mark it not in display list
   inc hl
   ld e,(hl)
   ld d,a               ; de = previous char struct + 11
   ld a,l
   add a,8
   ld l,a
   jp nc, noinc1
   inc h

.noinc1                 ; hl = current char struct + 11
   ld a,(hl)
   ld (hl),0            ; mark not in display list
   inc hl
   ld l,(hl)
   ld h,a               ; hl = next char struct + 4
   ex de,hl             ; de = next char struct + 4, hl = previous char struct + 11
   ld (hl),d
   inc hl
   ld (hl),e            ; previous char struct next ptr = next char struct + 4
   dec hl               ; hl = previous char struct + 11
   ex de,hl             ; de = previous char struct + 11, hl = next char struct + 4
   ld a,h
   or a
   jr z, nonext1        ; if msb = 0, there is no next char struct
   dec hl
   ld (hl),e
   dec hl
   ld (hl),d            ; next char struct's previous ptr = previous char struct + 11

   ; next add char struct to new position in display list

.nonext1
.notinDList
   ld a,c               ;  a = current column coordinate
   cp (iy+2)            ; left column of clipping rectangle
   jr c, notdisplayed
   cp (iy+3)            ; right column + 1 of clipping rectangle
   jr nc, notdisplayed
   ld a,b               ;  a = current row coordinate
   cp (iy+0)            ; top row of clipping rectangle
   jr c, notdisplayed
   cp (iy+1)            ; bottom row + 1 of clipping rectangle
   jr nc, notdisplayed

   pop de
   pop hl               ; hl = current display list address, linked list
   push hl
   push de
   jp noinc2

.pdloop
   ld a,7
   add a,l
   ld l,a
   jp nc, noinc2
   inc h                ; hl = char struct + 11

.noinc2
   ld e,l
   ld d,h               ; de = tentative previous char struct + 11
   ld a,(hl)
   or a
   jr z, puthere        ; at end of list, attach current char struct to end
   inc hl
   ld l,(hl)
   ld h,a               ; hl = next char struct + 4
IF USEPLANES
   ld a,(hl)
   and $3f              ;  a = sprite plane
   cp (ix+12)
   jp nc,pdloop         ; if the next char struct is lower priority
ENDIF

.puthere
   pop hl               ; de = previous char struct + 11
   push hl              ; hl = current char struct + 0
   inc hl
   inc hl
   ld (hl),d
   inc hl
   ld (hl),e            ; current's previous char struct + 11 pointer updated
   ld a,8
   add a,l
   ld l,a
   jp nc, noinc3
   inc h

.noinc3                 ; hl = current char struct + 11
   ld a,(de)
   ld (hl),a
   inc hl               ; hl = current char struct + 12
   inc de               ; de = previous char struct + 12
   ld a,(de)
   ld (hl),a            ; current's next char struct ptr = previous's next char struct + 4
   ld a,l
   sub 8
   ld l,a
   jp nc, nodec1
   dec h

.nodec1                 ; hl = current char struct + 4
   ex de,hl             ; de = current char struct + 4, hl = previous char struct + 12
   ld (hl),e
   dec hl
   ld (hl),d            ; previous's next ptr = current char struct + 4
   ld a,7
   add a,e
   ld e,a
   jp nc, noinc4
   inc d

.noinc4                 ; de = current char struct + 11
   ld a,(de)
   or a
   jr z, nonext2        ; no next char struct to update
   ld h,a
   inc de
   ld a,(de)
   ld l,a
   dec hl               ; hl = next char struct + 3
   dec de               ; de = current char struct + 11
   ld (hl),e
   dec hl
   ld (hl),d            ; next's previous ptr = current char struct + 11

.nonext2
.notdisplayed
   pop hl               ; hl = current char struct + 0, stack: disp list address, linked list
   call adjustgraphics  ; apply bitdef displacement and vertical rotation to graphic ptrs

   ; hl = current char struct + 0, on stack = display list address, linked list
   ; b = current row coordinate, c = current col coordinate, a' = height

   inc b                ; next row coord
   ex (sp),hl           ; hl = display list address
IF DISP_HIRES
   ld de,4*64
ELSE
   ld de,4*32
ENDIF
   add hl,de
   ex de,hl             ; de = next row in display list address
   pop hl               ; hl = char struct + 0
   ex af,af'            ; a = row height count
   dec a
   jp nz, mvrowloop     ; more rows in this column
   inc c                ; row done, move to next column
   pop de               ; de = display list address, top of row
   inc de
   inc de
   inc de
   inc de               ; move display list right one column
   push de
   jp mvcolloop


.invalidate
   ld b,(ix+0)
   ld c,(ix+1)
   ld e,(ix+3)
   ld d,(ix+2)
   jp SPInvalidateP     ; invalidate area currently occupied by sprite


.computedisp
   ld a,d
   and $07              ; a = new horizontal pixel rotation 0..7
   ld (ix+4),a          ; store new horizontal rotation
   rla                  ; next find rotation table address for this rotation
   or SProtatetbl/256
   ld d,a               ; d = msb hor rotation table address

   ld a,e
   and $07
   ld e,a               ; a = e = new vertical pixel rotation 0..7
   sub (ix+5)           ; compute the change from the old vertical rotation
   ld (ix+5),e          ; store new vertical rotation
IF !COMPRESS
IF DISP_HICOLOUR
   ld e,a
   add a,a
   add a,e              ; triple change to get byte displacement (1 graphic, 1 mask, 1 colour)
ELSE
   add a,a              ; double change to get byte displacement (1 graphic, 1 mask)
ENDIF
ELSE
   ld e,a               ; some clumsiness added after-the-fact to cope with COMPRESS sprites
   ld a,(ix+13)         ; first find out if this is a masked sprite
   and $c0
   ld a,e
IF DISP_HICOLOUR
   rla
ENDIF
   jp nz, notmask
IF DISP_HICOLOUR
   add a,e
ELSE
   add a,a
ENDIF
.notmask
ENDIF
   neg
   ld l,a
   ld h,0               ; sign extend a into hl
   jp p, notnegative
   dec h

.notnegative
   add hl,bc            ; add this vertical rotation displacement to animation displacement
   ld c,l
   ld b,h
   exx                  ; bc' = bitdef displacement, d' = msb horizontal rotate table
   ret


.adjustgraphics
   push hl
   exx                  ; bc = bitdef displacement, d = msb of hor rotate table
   pop hl               ; hl = current char struct + 0
   push de
   ld a,9
   add a,l
   ld l,a
   jp nc, noinc5
   inc h

.noinc5                 ; hl = current char struct + 9
   ld (hl),d            ; store msb horizontal rotate tbl
   dec hl               ; hl = current char struct + 8
   ld a,(hl)
   cp SPNullSprPtr/256
   jr z, skip1
IF COMPRESS
   cp SPCompNullSprPtr/256
   jr z, skip1
ENDIF
   ld d,a
   dec hl               ; hl = current char struct + 7
   ld e,(hl)
   ex de,hl             ; de = curr char struct + 7, hl = sprite bitdef
   add hl,bc            ; add animate + vertical rotate displacement
   ex de,hl             ; hl = curr char struct + 7, de = new bitdef
   ld (hl),e
   inc hl
   ld (hl),d            ; store new bitdef
.skip1
   dec hl
   dec hl               ; hl = current char struct + 6
   ld a,(hl)
   cp SPNullSprPtr/256
   jr z, skip2
IF COMPRESS
   cp SPCompNullSprPtr/256
   jr z, skip2
ENDIF
   ld d,a
   dec hl               ; hl = current char struct + 5
   ld e,(hl)            ; de = sprite bitdef left
   ex de,hl
   add hl,bc            ; add animate + vert rot disp
   ex de,hl             ; de = new bitdef left, hl = current char struct + 5
   ld (hl),e
   inc hl
   ld (hl),d            ; store new bitdef left
.skip2
   pop de               ; restore d
   exx
   ret
