;
; PrintString
; Alvin Albrecht 06.2003
;

INCLUDE "SPconfig.def"

XLIB SPPrintString
LIB SPCompDListAddr, SPCompDirtyAddr, SPbit2mask, SPtbllookup

; A Complex Print String Implementation
;
; The string to print is pointed at by HL and terminates with a 0 byte.
; Characters are printed as background tiles (ie a tile# and colour/pallette)
; with the following special character codes understood:
;
; code     meaning
; ----     -------
;   0      terminate string
;   5      NOP (ignored)
;   6      goto N* (goto x coordinate on same line)
;   7      print string at address W*
;   8      left
;   9      right
;  10      up
;  11      down
;  12      home (to top left of bounds rectangle)
;  13      carriage return (move to start of next line in bounds rectangle)
;  14      repeat N*
;  15      endrepeat
;  16      ink N*
;  17      paper N*
;  18      flash N*
;  19      bright N*
;  20      attribute N*
;  21      invalidate N*
;  22      AT y(N*),x(N*) (relative to bounds rectangle)
;  23      AT dy(N*), dx(N*)  (relative to current position in bounds rectangle)
;  24      xwrap N*
;  25      yinc N*
;  26      push state
;  27      escape, next char is literal not special code
;  28      pop state
;  29      transparent char
;
; * N is a single byte parameter following the code.
; * W is a 16-bit parameter following the code.
;
; All printing is done within a bounds rectangle.  No printing outside this
; bounds rectangle will occur.  To print full screen, use a bounds rectangle
; that encompasses the full screen (eg ClipStruct).
;
; enter:  HL = address of string to print
;          E = flags (bit 0 = invalidate?, bit 1 = xwrap?, bit 2 = yinc?, bit3 = onscreen?)
;          B = current x coordinate (relative to bounds rect IY)
;          C = current y coordinate (relative to bounds rect IY)
;        HL' = DList Address
;        DE' = Dirty Chars Array Address
;         B' = Dirty Chars Bit
;         C' = current colour
;       IY+0 = row coordinate   \
;       IY+1 = col coordinate   |  Bounds Rectangle
;       IY+2 = height in chars  |  Must Fit On Screen
;       IY+3 = width in chars   /
;
; The C API maintains a structure to retain the print state between calls.
; Doing something similar from assembly language may be helpful.

.SPPrintString
.psloop
   ld a,(hl)
   or a
   ret z              ; return on end of string character
   inc hl
   cp 30
   jp nc, printable
   cp 5
   jp c, printable

   ; here we have a special code [5,29]

   push hl
   ld d,a
   add a,a            ; get address of handler from jump table
   ld h,jumptbl/256
   add a,jumptbl%256
   ld l,a
   jp nc, nospill
   inc h
.nospill
   ld a,(hl)
   inc hl
   ld h,(hl)
   ld l,a
   ld a,d             ; restore A to code
   ex (sp),hl
   ret

.jumptbl
   defw printable, printable, printable, printable
   defw printable, codeNOP, codeGotoX, codePString
   defw codeLeft, codeRight, codeUp, codeDown
   defw codeHome, codeReturn, codeRepeat, codeEndRepeat
   defw codeInk, codePaper, codeFlash, codeBright
   defw codeAttribute, codeInvalidate, codeAt, codeAtRel
   defw codeXWrap, codeYInc, codePush, codeEscape
   defw codePop, codeTransparent

.printable            ; a = tile#
   bit 3,e            ; currently on screen?
   jp z, codeRight
   exx
   ld (hl),c
   inc hl
   ld (hl),a
   dec hl
   exx
   bit 0,e            ; invalidate?
   jp z, codeRight
   exx
   ld a,(de)
   or b               ; invalidate this char cell
   ld (de),a
   exx
   jp codeRight

.codeLeft
   dec b
   exx
   dec hl
   dec hl
   dec hl
   dec hl            ; move DList left one char
   rrc b             ; move dirty chars left one char
   jp nc, noadjcl
   dec de
.noadjcl
   exx
   jp checkbounds

.codeRight
   inc b
   exx
   inc hl
   inc hl
   inc hl
   inc hl             ; move DList one char right
   rlc b              ; move Dirty Char one char right
   jp nc, noadjcr
   inc de
.noadjcr
   exx
   jp checkbounds

.codeUp
   exx
   push bc
IF DISP_HIRES
   ld bc,-256
ELSE
   ld bc,-128
ENDIF
   add hl,bc           ; move DList up one char
IF DISP_HIRES
   ld bc,-8
ELSE
   ld bc,-4
ENDIF
   ex de,hl
   add hl,bc           ; move dirty chars up one char
   ex de,hl
   pop bc
   exx
   dec c
   jp checkbounds

.codeDown
   exx
   push bc
IF DISP_HIRES
   ld bc,256
ELSE
   ld bc,128
ENDIF
   add hl,bc           ; move DList down one char
IF DISP_HIRES
   ld bc,8
ELSE
   ld bc,4
ENDIF
   ex de,hl
   add hl,bc           ; move dirty chars down one char
   ex de,hl
   pop bc
   exx
   inc c
   jp checkbounds

.checkbounds
   bit 3,e
   jp z, computepos
   ld a,b
   cp (iy+3)
   jp c, cb1
   jp computepos
.cb1
   ld a,c
   cp (iy+2)
   jp c, psloop
.gooff
   res 3,e
   jp psloop

.computepos
   res 3,e
   bit 1,e
   jr nz, wrapmode
   ld a,b
   cp (iy+3)
   jp nc, psloop
   ld a,c
   cp (iy+2)
   jp nc, psloop
.computepos2
   set 3,e
   push bc
   exx
   pop hl
   ld a,h
   add a,(iy+1)
   push bc
   ld c,a
   ld a,l
   add a,(iy+0)
   call SPCompDListAddr
   push hl
   call SPCompDirtyAddr
   ld de,SPbit2mask
   call SPtbllookup
   ex de,hl
   pop hl
   pop bc
   ld b,a
   exx
   jp psloop
.correctrightwrap
   sub (iy+3)
   cp (iy+3)
   jp nc, correctrightwrap
   ld b,a
   ld a,1
   jp endcorrect
.wrapmode
   ld a,b
   cp (iy+3)
   jp c, wy
   or a
   jp p, correctrightwrap
.correctleftwrap
   add a,(iy+3)
   jp m, correctleftwrap
   ld b,a
   ld a,255
.endcorrect
   bit 2,e
   jp z, wy
   add a,c
   ld c,a
.wy
   ld a,c
   cp (iy+2)
   jp c, computepos2
   jp psloop

.codeHome
   ld bc,0             ; top left corner of bounds rect
   jp computepos2

.codeReturn
   inc c               ; y++
   ld b,0              ; x = 0
   jp computepos

.codeRepeat
   ld a,(hl)           ; # times to repeat
   inc hl
.reploop
   push hl             ; save string position at start of repeat block
   push af             ; save # remaining iterations
   call psloop         ; returns after endrepeat or 0 terminator
   pop af
   dec a               ; any more iterations?
   jr z, nomoreiter
   pop hl              ; restore string pointer for next repeat
   jp reploop
.nomoreiter
   pop af              ; trash saved string position
   jp psloop

.codeEndRepeat
   ret

.codeInk
   ld a,(hl)           ; parameter following INK (0-7)
   and $07
   inc hl
   exx
   ex af,af'           ; save ink colour
   ld a,c              ; get current attribute
   and $f8             ; clear current ink
   ld c,a
   ex af,af'           ; get new ink colour
   or c
   ld c,a              ; set new ink colour
   exx
   jp psloop

.codePaper
   ld a,(hl)           ; parameter following PAPER (0-7)
   inc hl
   rla
   rla
   rla
   and $38             ; move paper to bits 5:3
   exx
   ex af,af'
   ld a,c              ; get current attribute
   and $c7             ; throw away current paper colour
   ld c,a
   ex af,af'           ; get new paper colour
   or c
   ld c,a              ; set new attribute
   exx
   jp psloop

.codeFlash
   ld a,(hl)           ; parameter following FLASH (0/1)
   inc hl
   exx
   rl c
   rra
   rr c
   exx
   jp psloop

.codeBright
   ld a,(hl)           ; parameter following BRIGHT (0/1)
   inc hl
   exx
   rra
   jp nc,nobright
   set 6,c
   exx
   jp psloop
.nobright
   res 6,c
   exx
   jp psloop

.codeAttribute
   ld a,(hl)           ; parameter following ATTRIBUTE
   inc hl
   exx
   ld c,a
   exx
   jp psloop

.codeInvalidate
   ld a,(hl)           ; parameter following INVALIDATE (0/1)
   inc hl
   rr e
   rra
   rl e
   jp psloop

.codeAt
   ld c,(hl)
   inc hl
   ld b,(hl)
   inc hl
   jp computepos

.codeAtRel
   ld a,(hl)
   add a,c
   ld c,a
   inc hl
   ld a,(hl)
   add a,b
   ld b,a
   inc hl
   jp computepos

.codeXWrap
   ld a,(hl)           ; parameter following XWRAP (0/1)
   inc hl
   rra
   jp nc, noxwrap
   set 1,e
   jp computepos
.noxwrap
   res 1,e
   jp psloop

.codeYInc
   ld a,(hl)           ; parameter following YINC (0/1)
   inc hl
   rra
   jp nc, noywrap
   set 2,e
   jp psloop
.noywrap
   res 2,e
   jp psloop

.codePush
   push bc
   push de
   exx
   push bc
   push de
   push hl
   exx
   jp psloop

.codePop
   exx
   pop hl
   pop de
   pop bc
   exx
   pop de
   pop bc
   jp psloop

.codeEscape
   ld a,(hl)          ; char following ESCAPE
   inc hl
   jp printable

.codeTransparent
   ld a,e
   and $09
   cp $09             ; on screen and invalidate?
   jp nz, codeRight
   exx
   ld a,(de)
   or b
   ld (de),a          ; invalidate char
   ld a,c
   cp $80
   jr z, noclr2
   ld (hl),a
.noclr2
   exx
   jp codeRight

.codePString
   ld a,(hl)
   inc hl
   ld d,(hl)
   inc hl
   push hl
   ld h,d
   ld l,a
   call psloop
   pop hl
   jp psloop

.codeGotoX
   ld b,(hl)
   inc hl
   jp computepos

.codeNOP
   jp computepos
