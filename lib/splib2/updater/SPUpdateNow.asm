;
; Update Now
; Alvin Albrecht 07.2003
;
; Sprite Pack's screen updater.  The updater supports four different
; screen modes with one chosen by defining the corresponding variable
; true and the others false:
;
; DISP_SPECTRUM
;   256x192 pixel, 32x24 colour Spectrum resolution
; DISP_HICOLOUR
;   256x192 pixel, 32x192 colour Timex hi-colour resolution
; DISP_HIRES
;   512x192 monochrome Timex hi-res resolution
; DISP_TMXDUAL
;   uses second display file as spectrum resolution double buffer (Timex only)
;   (also define DISP_SPECTRUM for this mode)
;
; The updater manages a portion of the screen defined by the row range.
; Sprite Pack will not touch the area outside this row range.
;
; SP_ROWSTART
;   Starting row 0..23
; SP_ROWEND
;   Last row, non-inclusive.
;
; The updater performs a differential screen refresh.  It divides the
; screen into character size tiles and only redraws those chars that
; have changed from the previous update.  Keeping track of which chars
; change is a cooperative effort with Sprite Pack's drawing functions.
; The "Dirty Chars Array" stores this information: one bit is reserved
; per char with a set bit indicating the char is changed.  As changes
; are made to the screen, Sprite Pack's functions set these bits and
; as the updater draws the screen, it resets the bits.  The dirty chars
; array is mapped to the screen characters in left to right, top to
; bottom order.  Each byte stores the status of 8 character tiles.
;
; Sprite Pack keeps track of what's on screen in a "Display List Array".
; Each character on screen is composed of a single background tile (first
; byte is attribute (spec) / pallette # (hi-colour) / ignored (hi-res),
; second byte is tile #) and a linked list of sprite char structures
; (a 2-byte pointer).  Each character therefore needs a 4-byte entry in
; this array.  Each character's 4-byte struct is mapped into the display
; list array in left to right, top to bottom order.
;
; Two additional modes are available: NOFLICKER mode and SCROLLER mode.
; You can turn either or both on by defining them true.  NOFLICKER mode
; causes each screen character to be completely drawn in a background
; buffer before being copied to the screen.  The penalty is a slower
; update rate.  SCROLLER mode causes the first sprite in each character
; to be drawn as load-type regardless of the sprite's actual designated
; type.
;
; By defining COMPRESS true, or/xor/load sprite graphic definitions
; have their mask bytes removed, halving the space they occupy in memory.
; Doing this means that mask sprite graphic definitions will no longer
; be useable as or/xor/load sprite definitions.

; Modified by na_th_an - A = update attrs or not

INCLUDE "SPconfig.def"
XLIB SPUpdateNow
LIB SPDisplayList, SPDirtyChars, SPTileArray

IF DISP_TMXDUAL
XDEF SPScreen
.SPScreen
   defb $20          ; indicates which display file to draw into ($20=secondary, 0=primary)
ENDIF

;
; Private Static Variables
;

IF NOFLICKER
.tempgraphic
IF DISP_HICOLOUR
   defs 16
ELSE
   defs 8
ENDIF
ENDIF

IF DISP_SPECTRUM
.tempcolour
   defb 0
XDEF update_attrs
.update_attrs
   defb 0
ENDIF

.dosprites
   defb 1

;
; The screen draw subroutine.
;

.SPUpdateNow
   ld (dosprites), a
   ld de,$4000 + (256 * (SP_ROWSTART & $18)) + (32 * (SP_ROWSTART & 7))   ; de = screen address
IF DISP_TMXDUAL
   ld a,(SPScreen)
   add a,d
   ld d,a
   ld bc,SPDisplayList           ; start of display list
   ld hl,SPDirtyChars            ; start of dirty chars array
ELSE
   ld hl,SPDisplayList
   ld bc,SPDirtyChars
ENDIF

.dirtyloop
IF DISP_TMXDUAL
   ld a,(hl)                     ; examine dirty byte, one bit per 8 chars
   inc h
   or (hl)                       ; or in old dirty byte
   dec h
ELSE
   ld a,(bc)
   or a
ENDIF
   jp nz, dirtyarea              ; if one of the chars is dirty, need to redraw
IF DISP_HIRES
   ld a,4
ELSE
   ld a,8                        ; otherwise advance screen address 8 chars to right
ENDIF
   add a,e
   ld e,a
   jp nz, notacrossblk1          ; check if a screen block is crossed
   ld a,8                        ; and adjust if necessary
   add a,d
   ld d,a

.notacrossblk1
   ld a,32                       ; advance display list 8 chars (32 bytes)
IF DISP_TMXDUAL
   add a,c
   ld c,a
   jp nc, noinc1
   inc b
ELSE
   add a,l
   ld l,a
   jp nc, noinc1
   inc h
ENDIF

.noinc1
.reenter
IF DISP_TMXDUAL
   inc hl                        ; advance dirty chars pointer
   ld a,h                        ; are we done yet?
ELSE
   inc bc
   ld a,b
ENDIF
IF DISP_HIRES
   cp 0 + (SPDirtyChars + 8 * (SP_ROWEND - SP_ROWSTART)) / 256
ELSE
   cp 0 + (SPDirtyChars + 4 * (SP_ROWEND - SP_ROWSTART)) / 256
ENDIF
   jp c,dirtyloop
IF DISP_TMXDUAL
   ld a,l
ELSE
   ld a,c
ENDIF
IF DISP_HIRES
   cp 0 + (SPDirtyChars + 8 * (SP_ROWEND - SP_ROWSTART)) % 256
ELSE
   cp 0 + (SPDirtyChars + 4 * (SP_ROWEND - SP_ROWSTART)) % 256
ENDIF
   jp c,dirtyloop
IF DISP_TMXDUAL
   ld a,(SPScreen)
   xor $20
   ld (SPScreen),a               ; draw into other display file next time
ENDIF
   ret


.dirtyarea
IF DISP_TMXDUAL
   push hl
   ld l,c
   ld h,b                        ; hl = display list
ELSE
   push bc
ENDIF
   ld bc,4
   rrca                          ; now must check each of the 8 chars in dirty byte
   call c, drawchar              ; if first char is dirty, redraw
IF DISP_HIRES
   set 5,d
ELSE
   inc e                         ; move screen address right one char
ENDIF
   add hl,bc                     ; advance display list one char (4 bytes)
   rrca                          ; repeat a total of 8 times
   call c, drawchar
IF DISP_HIRES
   res 5,d
ENDIF
   inc e
   add hl,bc
   rrca                          ; repeat
   call c, drawchar
IF DISP_HIRES
   set 5,d
ELSE
   inc e
ENDIF
   add hl,bc
   rrca                          ; repeat
   call c, drawchar
IF DISP_HIRES
   res 5,d
ENDIF
   inc e
   add hl,bc
   rrca                          ; repeat
   call c, drawchar
IF DISP_HIRES
   set 5,d
ELSE
   inc e
ENDIF
   add hl,bc
   rrca                          ; repeat
   call c, drawchar
IF DISP_HIRES
   res 5,d
ENDIF
   inc e
   add hl,bc
   rrca                          ; repeat
   call c, drawchar
IF DISP_HIRES
   set 5,d
ELSE
   inc e
ENDIF
   add hl,bc
   rrca                          ; repeat
   call c, drawchar
IF DISP_HIRES
   res 5,d
ENDIF
   inc e                         ; move screen address right one char --
   jp nz, notacrossblk2          ; might cross a screen block here
   ld a,8                        ; adjust screen address if necessary
   add a,d
   ld d,a

.notacrossblk2
   add hl,bc                     ; advance display list one char (4 bytes)
IF DISP_TMXDUAL
   ld c,l
   ld b,h                        ; bc = display list
   pop hl                        ; hl = dirty chars array
   ld a,(hl)
   inc h
   ld (hl),a                     ; copy new dirty chars byte to old dirty chars byte
   dec h
   ld (hl),0                     ; clear new dirty byte
ELSE
   pop bc
   xor a
   ld (bc),a
ENDIF
   jp reenter                    ; check the next dirty byte


.tileonly
IF NOFLICKER
   pop de                        ; pop screen address
IF DISP_HICOLOUR
   ld a,$27
   add a,d
   ld d,a
ENDIF
ENDIF

IF DISP_HICOLOUR
   ld a,(bc)                     ; copy tile colour to screen
   ld (de),a
   inc bc
   dec d
   ld a,(bc)
   ld (de),a
   inc bc
   dec d
   ld a,(bc)
   ld (de),a
   inc bc
   dec d
   ld a,(bc)
   ld (de),a
   inc bc
   dec d
   ld a,(bc)
   ld (de),a
   inc bc
   dec d
   ld a,(bc)
   ld (de),a
   inc bc
   dec d
   ld a,(bc)
   ld (de),a
   inc bc
   dec d
   ld a,(bc)
   ld (de),a
   res 5,d
ENDIF

   ex af,af'                     ; a = tile #
   add a,SPTileArray%256
   ld l,a
   ld h,SPTileArray/256
   jp nc, noinc11
   inc h
.noinc11
   ld c,(hl)
   inc h
   ld b,(hl)                     ; bc = tile graphic

   ld a,(bc)                     ; copy background tile graphics to screen
   ld (de),a
   inc bc
   inc d
   ld a,(bc)                     ; repeat 8 times total for entire char
   ld (de),a
   inc bc
   inc d
   ld a,(bc)                     ; repeat
   ld (de),a
   inc bc
   inc d
   ld a,(bc)                     ; repeat
   ld (de),a
   inc bc
   inc d
   ld a,(bc)                     ; repeat
   ld (de),a
   inc bc
   inc d
   ld a,(bc)                     ; repeat
   ld (de),a
   inc bc
   inc d
   ld a,(bc)                     ; repeat
   ld (de),a
   inc bc
   inc d
   ld a,(bc)                     ; repeat
   ld (de),a
   jp nomoresprites              ; do colour


.drawchar
   push af                       ; save dirty byte
   push de                       ; store screen address
   push hl                       ; store display list pointer
   exx
   pop hl
IF NOFLICKER
IF DISP_HICOLOUR
   ld de,tempgraphic+8
ELSE
   ld de,tempgraphic             ; write graphics to temporary buffer
ENDIF
ELSE
   pop de
IF DISP_HICOLOUR
   ld a,$27
   add a,d
   ld d,a                        ; move to bottom of char in colour memory
ENDIF
ENDIF

IF DISP_SPECTRUM
   ld a,(hl)                     ; a = background colour
   ld (tempcolour),a             ; store colour of background tile
   inc hl                        ; point at graphic tile
ENDIF
IF DISP_HIRES
   inc hl                        ; point at graphic tile
ENDIF
IF DISP_HICOLOUR
   push hl                       ; save DLIST
   ld a,(hl)
   add a,SPTileArray%256
   ld l,a
   ld a,0
   adc a,SPTileArray/256 + 2
   ld h,a                        ; hl = address of pallette entry
   ld c,(hl)
   inc h
   ld b,(hl)                     ; bc = colour address
   pop hl
   inc hl                        ; point at graphic tile
ENDIF

   ld a,(hl)
   ex af,af'                     ; a' = graphic tile #
   inc hl                        ; point at MSB sprite list
   ld a,(hl)
   or a
   jr z, tileonly

IF DISP_HICOLOUR                 ; copy tile colour to screen, bottom up
IF NOFLICKER
   push hl
   ld l,c
   ld h,b
   ldi
   ldi
   ldi
   ldi
   ldi
   ldi
   ldi
   ldi
   pop hl
   ld de,tempgraphic
ELSE
   ld a,(bc)                     ; copy tile colour to screen, bottom up
   ld (de),a
   inc bc
   dec d
   ld a,(bc)
   ld (de),a
   inc bc
   dec d
   ld a,(bc)
   ld (de),a
   inc bc
   dec d
   ld a,(bc)
   ld (de),a
   inc bc
   dec d
   ld a,(bc)
   ld (de),a
   inc bc
   dec d
   ld a,(bc)
   ld (de),a
   inc bc
   dec d
   ld a,(bc)
   ld (de),a
   inc bc
   dec d
   ld a,(bc)                     ; bc = last colour byte in background tile
   ld (de),a
   ld a,(hl)
   res 5,d                       ; de = top of char screen address
ENDIF
ENDIF

   inc hl
   ld l,(hl)
   ld h,a                        ; hl = first sprite = char struct + 4

IF !SCROLLER
   ld a,(hl)
   cp $c0                        ; is this first sprite a load sprite?
   jr c, notload                 ; if so don't bother drawing background tile
ENDIF

   inc hl                        ; hl = char struct + 5
   ld c,(hl)
   inc hl
   ld b,(hl)
   inc hl
   defb $dd
   ld l,c
   defb $dd
   ld h,b                        ; ix = sprite graphic left
   ld c,(hl)
   inc hl
   ld b,(hl)                     ; bc = sprite graphic
   inc hl

   push hl                       ; save char struct + 9
   ld h,(hl)                     ; h = msb of horizontal rotation table to use
   jp loadtype

IF !SCROLLER
.notload
   push hl                       ; save char struct + 4
   ex af,af'                     ; a = tile #
   add a,SPTileArray%256
   ld l,a
   ld h,SPTileArray/256
   jp nc, noinc10
   inc h
.noinc10
   ld a,(hl)
   inc h
   ld h,(hl)
   ld l,a                        ; hl = graphic tile address

IF NOFLICKER
   ldi
   ldi
   ldi
   ldi
   ldi
   ldi
   ldi
   ld a,(hl)
   ld (de),a
ELSE
   ld a,(hl)                     ; copy background tile graphics to screen
   ld (de),a
   inc hl
   inc d
   ld a,(hl)                     ; repeat 8 times total for entire char
   ld (de),a
   inc hl
   inc d
   ld a,(hl)                     ; repeat
   ld (de),a
   inc hl
   inc d
   ld a,(hl)                     ; repeat
   ld (de),a
   inc hl
   inc d
   ld a,(hl)                     ; repeat
   ld (de),a
   inc hl
   inc d
   ld a,(hl)                     ; repeat
   ld (de),a
   inc hl
   inc d
   ld a,(hl)                     ; repeat
   ld (de),a
   inc hl
   inc d
   ld a,(hl)                     ; repeat
   ld (de),a
ENDIF
   pop hl                        ; hl = char struct + 4
ENDIF

.spriteloop

IF NOFLICKER
   ld de,tempgraphic
ELSE
   ld a,d                        ; move screen address back to top of char
IF DISP_TMXDUAL
   and $f8
ELSE
   and $d8
ENDIF
   ld d,a
ENDIF
   ld a,(hl)                     ; get sprite attribute (type | plane)

.dosprite
   inc hl                        ; hl = char struct + 5
   ld c,(hl)
   inc hl
   ld b,(hl)
   inc hl
   defb $dd
   ld l,c
   defb $dd
   ld h,b                        ; ix = sprite graphic left
   ld c,(hl)
   inc hl
   ld b,(hl)                     ; bc = sprite graphic
   inc hl

   ld a, (dosprites)
   or a
   jp z, skip_sprite_update

   push hl                       ; save char struct + 9
   
   ;; na_th_an
IF FLASHASFG
   ; Check if we must skip sprite rendering based upon cell attribute (bit 7 set = no sprites)
   
   ld  iy, tempcolour
   bit 7, (iy+0)
   
   jp  nz, coloursprite
ENDIF
   
   ld h,(hl)                     ; h = msb of horizontal rotation table to use
   cp $c0                        ; what kind of sprite is this?
   jp nc, loadtype
   cp $80
   jp nc, xortype
   cp $40
   jp nc, ortype

   ; this must be a mask sprite

   ld a,h                        ; have a look at the rotation being used
   and $0e
   jp z, masknorotate            ; if no rotation draw the fast way

   ld a,(bc)                     ; a = graphic
   ld l,a
   ld a,(hl)                     ; a = graphic rotated right
   inc h
   ld l,(ix+0)                   ; l = graphic left side
   or (hl)                       ; a = graphic rotated right | graphic from left side
   ex af,af'                     ; a' = final graphic
   inc bc                        ; advance to mask
   dec h
   ld a,(bc)                     ; a = mask
   ld l,a
   ld a,(hl)                     ; a = mask rotated right
   inc h
   ld l,(ix+1)                   ; l = mask left side
   or (hl)                       ; a = mask rotated right | mask from left side
   ex de,hl                      ; hl = screen address, d = msb hor rotate table
   and (hl)                      ; a = existing screen & mask
   ld e,a
   ex af,af'                     ; a = sprite graphic
   or e                          ; a = sprite graphic | remaining portion of screen
   ld (hl),a                     ; update screen
   ex de,hl                      ; de = screen address, h = msb hor rotate table
IF NOFLICKER
   inc de
ELSE
   inc d                         ; next scan line in char
ENDIF
   dec h
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc                        ; next sprite scan line

   ld a,(bc)                     ; repeat 8 times total for entire char
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+3)
ELSE
   ld l,(ix+2)
ENDIF
   or (hl)
   ex af,af'
   inc bc
   dec h
   ld a,(bc)
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+4)
ELSE
   ld l,(ix+3)
ENDIF
   or (hl)
   ex de,hl
   and (hl)
   ld e,a
   ex af,af'
   or e
   ld (hl),a
   ex de,hl
IF NOFLICKER
   inc de
ELSE
   inc d
ENDIF
   dec h
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+6)
ELSE
   ld l,(ix+4)
ENDIF
   or (hl)
   ex af,af'
   inc bc
   dec h
   ld a,(bc)
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+7)
ELSE
   ld l,(ix+5)
ENDIF
   or (hl)
   ex de,hl
   and (hl)
   ld e,a
   ex af,af'
   or e
   ld (hl),a
   ex de,hl
IF NOFLICKER
   inc de
ELSE
   inc d
ENDIF
   dec h
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+9)
ELSE
   ld l,(ix+6)
ENDIF
   or (hl)
   ex af,af'
   inc bc
   dec h
   ld a,(bc)
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+10)
ELSE
   ld l,(ix+7)
ENDIF
   or (hl)
   ex de,hl
   and (hl)
   ld e,a
   ex af,af'
   or e
   ld (hl),a
   ex de,hl
IF NOFLICKER
   inc de
ELSE
   inc d
ENDIF
   dec h
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+12)
ELSE
   ld l,(ix+8)
ENDIF
   or (hl)
   ex af,af'
   inc bc
   dec h
   ld a,(bc)
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+13)
ELSE
   ld l,(ix+9)
ENDIF
   or (hl)
   ex de,hl
   and (hl)
   ld e,a
   ex af,af'
   or e
   ld (hl),a
   ex de,hl
IF NOFLICKER
   inc de
ELSE
   inc d
ENDIF
   dec h
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+15)
ELSE
   ld l,(ix+10)
ENDIF
   or (hl)
   ex af,af'
   inc bc
   dec h
   ld a,(bc)
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+16)
ELSE
   ld l,(ix+11)
ENDIF
   or (hl)
   ex de,hl
   and (hl)
   ld e,a
   ex af,af'
   or e
   ld (hl),a
   ex de,hl
IF NOFLICKER
   inc de
ELSE
   inc d
ENDIF
   dec h
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+18)
ELSE
   ld l,(ix+12)
ENDIF
   or (hl)
   ex af,af'
   inc bc
   dec h
   ld a,(bc)
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+19)
ELSE
   ld l,(ix+13)
ENDIF
   or (hl)
   ex de,hl
   and (hl)
   ld e,a
   ex af,af'
   or e
   ld (hl),a
   ex de,hl
IF NOFLICKER
   inc de
ELSE
   inc d
ENDIF
   dec h
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+21)
ELSE
   ld l,(ix+14)
ENDIF
   or (hl)
   ex af,af'
   inc bc
   dec h
   ld a,(bc)
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+22)
ELSE
   ld l,(ix+15)
ENDIF
   or (hl)
   ex de,hl
   and (hl)
   ld e,a
   ex af,af'
   or e
   ld (hl),a
   ex de,hl                      ; de points at last scan line in char
   dec h

IF DISP_HICOLOUR
IF COMPRESS

   ; unfortunately, because I've used ix with fixed offsets to get colour,
   ; the colour code needs to be duplicated for masked sprites in COMPRESS
   ; mode to get correct offsets.  i don't like this it all and may change
   ; this in the future.

.DUPcoloursprite
   ld a,h                        ; have a look at the rotation
   dec a
   pop hl                        ; hl = char struct + 9
   inc hl                        ; point at colour threshold
   cp (hl)
   jp nc, DUPclrrotate           ; if rotation > threshold, rotate colour
.DUPnoclrrotate
   ld ix,-22
   add ix,bc                     ; ix = sprite graphic

.DUPclrrotate                    ; now do colours bottom up
   ld c,$80                      ; the transparent colour
IF NOFLICKER
   inc de
ELSE
   set 5,d
ENDIF

   ld a,(ix+23)
   cp c                          ; if transparent colour, do not colour
   jr z, DUPclear0
   ld (de),a

.DUPclear0
IF NOFLICKER
   inc de
ELSE
   dec d                         ; move up scan line
ENDIF
   ld a,(ix+20)
   cp c
   jr z, DUPclear1
   ld (de),a

.DUPclear1
IF NOFLICKER
   inc de
ELSE
   dec d
ENDIF
   ld a,(ix+17)
   cp c
   jr z, DUPclear2
   ld (de),a

.DUPclear2
IF NOFLICKER
   inc de
ELSE
   dec d
ENDIF
   ld a,(ix+14)
   cp c
   jr z, DUPclear3
   ld (de),a

.DUPclear3
IF NOFLICKER
   inc de
ELSE
   dec d
ENDIF
   ld a,(ix+11)
   cp c
   jr z, DUPclear4
   ld (de),a

.DUPclear4
IF NOFLICKER
   inc de
ELSE
   dec d
ENDIF
   ld a,(ix+8)
   cp c
   jr z, DUPclear5
   ld (de),a

.DUPclear5
IF NOFLICKER
   inc de
ELSE
   dec d
ENDIF
   ld a,(ix+5)
   cp c
   jr z, DUPclear6
   ld (de),a

.DUPclear6
IF NOFLICKER
   inc de
ELSE
   dec d
ENDIF
   ld a,(ix+2)
   cp c
   jp z, clear7
   ld (de),a                     ; de back to top of char again (colour map)
   jp clear7
ENDIF

.coloursprite
   ld a,h                        ; have a look at the rotation
   dec a
   pop hl                        ; hl = char struct + 9
   inc hl                        ; point at colour threshold
   cp (hl)
   jp nc, clrrotate              ; if rotation > threshold, rotate colour
.noclrrotate
IF !COMPRESS
   ld ix,-22
ELSE
   ld ix,-14
ENDIF
   add ix,bc                     ; ix = sprite graphic

.clrrotate                       ; now do colours bottom up
   ld c,$80                      ; the transparent colour
IF NOFLICKER
   inc de
ELSE
   set 5,d
ENDIF

IF !COMPRESS
   ld a,(ix+23)
ELSE
   ld a,(ix+15)
ENDIF
   cp c                          ; if transparent colour, do not colour
   jr z, clear0
   ld (de),a

.clear0
IF NOFLICKER
   inc de
ELSE
   dec d                         ; move up scan line
ENDIF
IF !COMPRESS
   ld a,(ix+20)
ELSE
   ld a,(ix+13)
ENDIF
   cp c
   jr z, clear1
   ld (de),a

.clear1
IF NOFLICKER
   inc de
ELSE
   dec d
ENDIF
IF !COMPRESS
   ld a,(ix+17)
ELSE
   ld a,(ix+11)
ENDIF
   cp c
   jr z, clear2
   ld (de),a

.clear2
IF NOFLICKER
   inc de
ELSE
   dec d
ENDIF
IF !COMPRESS
   ld a,(ix+14)
ELSE
   ld a,(ix+9)
ENDIF
   cp c
   jr z, clear3
   ld (de),a

.clear3
IF NOFLICKER
   inc de
ELSE
   dec d
ENDIF
IF !COMPRESS
   ld a,(ix+11)
ELSE
   ld a,(ix+7)
ENDIF
   cp c
   jr z, clear4
   ld (de),a

.clear4
IF NOFLICKER
   inc de
ELSE
   dec d
ENDIF
IF !COMPRESS
   ld a,(ix+8)
ELSE
   ld a,(ix+5)
ENDIF
   cp c
   jr z, clear5
   ld (de),a

.clear5
IF NOFLICKER
   inc de
ELSE
   dec d
ENDIF
IF !COMPRESS
   ld a,(ix+5)
ELSE
   ld a,(ix+3)
ENDIF
   cp c
   jr z, clear6
   ld (de),a

.clear6
IF NOFLICKER
   inc de
ELSE
   dec d
ENDIF
IF !COMPRESS
   ld a,(ix+2)
ELSE
   ld a,(ix+1)
ENDIF
   cp c
   jr z, clear7
   ld (de),a                     ; de back to top of char again (colour map)

.clear7

ELSE                             ; not DISP_HICOLOUR

.coloursprite
   pop hl                        ; hl = char struct + 9
.skip_sprite_update   
   inc hl
IF DISP_SPECTRUM
;; na_th_an
;   ld a,(hl)                     ; colour
;   cp $80                        ; special transparent colour
;   jr z, clear
;   ld (tempcolour),a

.clear
ENDIF
ENDIF

   inc hl                        ; hl = char struct + 11
   ld a,(hl)
   or a
IF NOFLICKER
   jr z, copybuffer
ELSE
   jr z, nomoresprites
ENDIF
   inc hl
   ld l,(hl)
   ld h,a                        ; hl = char struct + 4 of next sprite
   jp spriteloop

IF NOFLICKER
.copybuffer
   pop de                        ; de = screen address of top of char
   ld hl,tempgraphic
   ld a,(hl)                     ; copy buffered tempgraphic to screen
   ld (de),a
   inc d
   inc hl
   ld a,(hl)
   ld (de),a
   inc d
   inc hl
   ld a,(hl)
   ld (de),a
   inc d
   inc hl
   ld a,(hl)
   ld (de),a
   inc d
   inc hl
   ld a,(hl)
   ld (de),a
   inc d
   inc hl
   ld a,(hl)
   ld (de),a
   inc d
   inc hl
   ld a,(hl)
   ld (de),a
   inc d
   inc hl
   ld a,(hl)
   ld (de),a

IF DISP_HICOLOUR
   inc hl                        ; copy colour to screen
   set 5,d
   ld a,(hl)
   ld (de),a
   inc hl
   dec d
   ld a,(hl)
   ld (de),a
   inc hl
   dec d
   ld a,(hl)
   ld (de),a
   inc hl
   dec d
   ld a,(hl)
   ld (de),a
   inc hl
   dec d
   ld a,(hl)
   ld (de),a
   inc hl
   dec d
   ld a,(hl)
   ld (de),a
   inc hl
   dec d
   ld a,(hl)
   ld (de),a
   inc hl
   dec d
   ld a,(hl)
   ld (de),a
ENDIF
ENDIF

.nomoresprites
IF DISP_SPECTRUM
IF DISP_TMXDUAL
   ld a,d
   and $20
   ld l,a
   xor d
ELSE
   ld a,d                        ; de = screen address of last scan line in char
ENDIF
   xor $85                       ; find corresponding attribute address
   rrca
   rrca
   rrca
IF DISP_TMXDUAL
   or l
ENDIF
   ld d,a
   ld a,(tempcolour)             ; what's the final colour of this square?

IF FLASHASFG
   ;; na_th_an
   and 127
ENDIF

   ld (de),a
.skipupdatecol
ENDIF

   exx
   pop af
   ret


.masknorotate
   ex de,hl                      ; hl = screen address
   ld a,(bc)
   ld e,a                        ; e = graphic
   inc bc
   ld a,(bc)                     ; a = mask
   and (hl)                      ; portion of screen remaining
   or e                          ; or in sprite graphic
   ld (hl),a                     ; write to screen
IF NOFLICKER
   inc hl
ELSE
   inc h                         ; next scan line
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat 8 times in total for whole char
   ld e,a
   inc bc
   ld a,(bc)
   and (hl)
   or e
   ld (hl),a
IF NOFLICKER
   inc hl
ELSE
   inc h
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld e,a
   inc bc
   ld a,(bc)
   and (hl)
   or e
   ld (hl),a
IF NOFLICKER
   inc hl
ELSE
   inc h
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld e,a
   inc bc
   ld a,(bc)
   and (hl)
   or e
   ld (hl),a
IF NOFLICKER
   inc hl
ELSE
   inc h
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld e,a
   inc bc
   ld a,(bc)
   and (hl)
   or e
   ld (hl),a
IF NOFLICKER
   inc hl
ELSE
   inc h
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld e,a
   inc bc
   ld a,(bc)
   and (hl)
   or e
   ld (hl),a
IF NOFLICKER
   inc hl
ELSE
   inc h
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld e,a
   inc bc
   ld a,(bc)
   and (hl)
   or e
   ld (hl),a
IF NOFLICKER
   inc hl
ELSE
   inc h
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld e,a
   inc bc
   ld a,(bc)
   and (hl)
   or e
   ld (hl),a
   ex de,hl
IF DISP_HICOLOUR
   pop hl
   inc hl
IF !COMPRESS
   jp noclrrotate
ELSE
   jp DUPnoclrrotate
ENDIF
ELSE
   jp coloursprite               ; back to colour the sprite
ENDIF


.loadtype
   ld a,h                        ; have a look at the rotation being used
   and $0e
   jp z, loadnorotate            ; if no rotation draw the fast way

   ld a,(bc)                     ; sprite graphic
   ld l,a
   ld a,(hl)                     ; rotated right
   inc h
   ld l,(ix+0)                   ; get graphic on the left
   or (hl)                       ; a = graphic rotated right | graphic rot. right from left
   dec h
   ld (de),a                     ; write to screen
IF NOFLICKER
   inc de
ELSE
   inc d                         ; next scan line
ENDIF
IF !COMPRESS
   inc bc                        ; skip mask
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat 8 times total for entire char
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
IF !COMPRESS
   ld l,(ix+3)
ELSE
   ld l,(ix+2)
ENDIF
ELSE
IF !COMPRESS
   ld l,(ix+2)
ELSE
   ld l,(ix+1)
ENDIF
ENDIF
   or (hl)
   dec h
   ld (de),a
IF NOFLICKER
   inc de
ELSE
   inc d
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
IF !COMPRESS
   ld l,(ix+6)
ELSE
   ld l,(ix+4)
ENDIF
ELSE
IF !COMPRESS
   ld l,(ix+4)
ELSE
   ld l,(ix+2)
ENDIF
ENDIF
   or (hl)
   dec h
   ld (de),a
IF NOFLICKER
   inc de
ELSE
   inc d
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
IF !COMPRESS
   ld l,(ix+9)
ELSE
   ld l,(ix+6)
ENDIF
ELSE
IF !COMPRESS
   ld l,(ix+6)
ELSE
   ld l,(ix+3)
ENDIF
ENDIF
   or (hl)
   dec h
   ld (de),a
IF NOFLICKER
   inc de
ELSE
   inc d
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
IF !COMPRESS
   ld l,(ix+12)
ELSE
   ld l,(ix+8)
ENDIF
ELSE
IF !COMPRESS
   ld l,(ix+8)
ELSE
   ld l,(ix+4)
ENDIF
ENDIF
   or (hl)
   dec h
   ld (de),a
IF NOFLICKER
   inc de
ELSE
   inc d
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
IF !COMPRESS
   ld l,(ix+15)
ELSE
   ld l,(ix+10)
ENDIF
ELSE
IF !COMPRESS
   ld l,(ix+10)
ELSE
   ld l,(ix+5)
ENDIF
ENDIF
   or (hl)
   dec h
   ld (de),a
IF NOFLICKER
   inc de
ELSE
   inc d
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
IF !COMPRESS
   ld l,(ix+18)
ELSE
   ld l,(ix+12)
ENDIF
ELSE
IF !COMPRESS
   ld l,(ix+12)
ELSE
   ld l,(ix+6)
ENDIF
ENDIF
   or (hl)
   dec h
   ld (de),a
IF NOFLICKER
   inc de
ELSE
   inc d
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
IF !COMPRESS
   ld l,(ix+21)
ELSE
   ld l,(ix+14)
ENDIF
ELSE
IF !COMPRESS
   ld l,(ix+14)
ELSE
   ld l,(ix+7)
ENDIF
ENDIF
   or (hl)
   dec h
   ld (de),a
IF !COMPRESS
IF DISP_HICOLOUR
   inc bc
ENDIF
ENDIF
   jp coloursprite


.loadnorotate
IF NOFLICKER
   ld l,c
   ld h,b                        ; hl = sprite graphic
   ldi                           ; copy graphic to temp buffer
IF !COMPRESS
   inc hl                        ; skip mask
ENDIF
IF DISP_HICOLOUR
   inc hl                        ; skip colour for now
ENDIF
   ldi                           ; repeat
IF !COMPRESS
   inc hl
ENDIF
IF DISP_HICOLOUR
   inc hl
ENDIF
   ldi                           ; repeat
IF !COMPRESS
   inc hl
ENDIF
IF DISP_HICOLOUR
   inc hl
ENDIF
   ldi                           ; repeat
IF !COMPRESS
   inc hl
ENDIF
IF DISP_HICOLOUR
   inc hl
ENDIF
   ldi                           ; repeat
IF !COMPRESS
   inc hl
ENDIF
IF DISP_HICOLOUR
   inc hl
ENDIF
   ldi                           ; repeat
IF !COMPRESS
   inc hl
ENDIF
IF DISP_HICOLOUR
   inc hl
ENDIF
   ldi                           ; repeat
IF !COMPRESS
   inc hl
ENDIF
IF DISP_HICOLOUR
   inc hl
ENDIF
   ldi                           ; repeat
IF COMPRESS
   dec hl
ENDIF
   dec de
   ld c,l
   ld b,h

ELSE

   ld a,(bc)                     ; graphic
   ld (de),a                     ; write to screen
   inc d                         ; next scan line
IF !COMPRESS
   inc bc                        ; skip mask
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat 8 times total for entire char
   ld (de),a
   inc d
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld (de),a
   inc d
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld (de),a
   inc d
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld (de),a
   inc d
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld (de),a
   inc d
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld (de),a
   inc d
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld (de),a
IF !COMPRESS
IF DISP_HICOLOUR
   inc bc
ENDIF
ENDIF
ENDIF

IF DISP_HICOLOUR
   pop hl
   inc hl
   jp noclrrotate
ELSE
   jp coloursprite
ENDIF

.xortype
   ld a,h                        ; have a look at the rotation applied
   and $0e
   jp z, xornorotate             ; if no rotation draw the fast way

   ld a,(bc)                     ; graphic
   ld l,a
   ld a,(hl)                     ; graphic rotated right
   inc h
   ld l,(ix+0)                   ; graphic from left
   or (hl)                       ; a = final graphic
   dec h
   ex de,hl                      ; hl = screen address
   xor (hl)                      ; xor graphic onto screen
   ld (hl),a
   ex de,hl
IF NOFLICKER
   inc de
ELSE
   inc d                         ; next scan line
ENDIF
IF !COMPRESS
   inc bc                        ; ignore mask
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat 8 times in total for entire char
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+3)
ELSE
   ld l,(ix+2)
ENDIF
   or (hl)
   dec h
   ex de,hl
   xor (hl)
   ld (hl),a
   ex de,hl
IF NOFLICKER
   inc de
ELSE
   inc d
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+6)
ELSE
   ld l,(ix+4)
ENDIF
   or (hl)
   dec h
   ex de,hl
   xor (hl)
   ld (hl),a
   ex de,hl
IF NOFLICKER
   inc de
ELSE
   inc d
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+9)
ELSE
   ld l,(ix+6)
ENDIF
   or (hl)
   dec h
   ex de,hl
   xor (hl)
   ld (hl),a
   ex de,hl
IF NOFLICKER
   inc de
ELSE
   inc d
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+12)
ELSE
   ld l,(ix+8)
ENDIF
   or (hl)
   dec h
   ex de,hl
   xor (hl)
   ld (hl),a
   ex de,hl
IF NOFLICKER
   inc de
ELSE
   inc d
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+15)
ELSE
   ld l,(ix+10)
ENDIF
   or (hl)
   dec h
   ex de,hl
   xor (hl)
   ld (hl),a
   ex de,hl
IF NOFLICKER
   inc de
ELSE
   inc d
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+18)
ELSE
   ld l,(ix+12)
ENDIF
   or (hl)
   dec h
   ex de,hl
   xor (hl)
   ld (hl),a
   ex de,hl
IF NOFLICKER
   inc de
ELSE
   inc d
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+21)
ELSE
   ld l,(ix+14)
ENDIF
   or (hl)
   dec h
   ex de,hl
   xor (hl)
   ld (hl),a
   ex de,hl
IF !COMPRESS
IF DISP_HICOLOUR
   inc bc
ENDIF
ENDIF
   jp coloursprite


.xornorotate
   ex de,hl                      ; hl = screen address
   ld a,(bc)                     ; graphic
   xor (hl)                      ; xor onto screen
   ld (hl),a
IF NOFLICKER
   inc hl
ELSE
   inc h                         ; next scan line
ENDIF
IF !COMPRESS
   inc bc                        ; skip mask
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat total of 8 times for entire char
   xor (hl)
   ld (hl),a
IF NOFLICKER
   inc hl
ELSE
   inc h
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   xor (hl)
   ld (hl),a
IF NOFLICKER
   inc hl
ELSE
   inc h
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   xor (hl)
   ld (hl),a
IF NOFLICKER
   inc hl
ELSE
   inc h
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   xor (hl)
   ld (hl),a
IF NOFLICKER
   inc hl
ELSE
   inc h
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   xor (hl)
   ld (hl),a
IF NOFLICKER
   inc hl
ELSE
   inc h
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   xor (hl)
   ld (hl),a
IF NOFLICKER
   inc hl
ELSE
   inc h
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   xor (hl)
   ld (hl),a
   ex de,hl                      ; de = screen address
IF DISP_HICOLOUR
IF !COMPRESS
   inc bc
ENDIF
   pop hl
   inc hl
   jp noclrrotate
ELSE
   jp coloursprite
ENDIF

.ortype
   ld a,h                        ; have a look at the rotation applied
   and $0e
   jp z, ornorotate              ; if no rotation draw the fast way

   ld a,(bc)                     ; graphic
   ld l,a
   ld a,(hl)                     ; graphic rotated right
   inc h
   ld l,(ix+0)                   ; graphic from left
   or (hl)                       ; a = final graphic
   dec h
   ex de,hl                      ; hl = screen address
   or (hl)                       ; or graphic onto screen
   ld (hl),a
   ex de,hl
IF NOFLICKER
   inc de
ELSE
   inc d                         ; next scan line
ENDIF
IF !COMPRESS
   inc bc                        ; ignore mask
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat 8 times in total for entire char
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+3)
ELSE
   ld l,(ix+2)
ENDIF
   or (hl)
   dec h
   ex de,hl
   or (hl)
   ld (hl),a
   ex de,hl
IF NOFLICKER
   inc de
ELSE
   inc d
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+6)
ELSE
   ld l,(ix+4)
ENDIF
   or (hl)
   dec h
   ex de,hl
   or (hl)
   ld (hl),a
   ex de,hl
IF NOFLICKER
   inc de
ELSE
   inc d
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+9)
ELSE
   ld l,(ix+6)
ENDIF
   or (hl)
   dec h
   ex de,hl
   or (hl)
   ld (hl),a
   ex de,hl
IF NOFLICKER
   inc de
ELSE
   inc d
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+12)
ELSE
   ld l,(ix+8)
ENDIF
   or (hl)
   dec h
   ex de,hl
   or (hl)
   ld (hl),a
   ex de,hl
IF NOFLICKER
   inc de
ELSE
   inc d
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+15)
ELSE
   ld l,(ix+10)
ENDIF
   or (hl)
   dec h
   ex de,hl
   or (hl)
   ld (hl),a
   ex de,hl
IF NOFLICKER
   inc de
ELSE
   inc d
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+18)
ELSE
   ld l,(ix+12)
ENDIF
   or (hl)
   dec h
   ex de,hl
   or (hl)
   ld (hl),a
   ex de,hl
IF NOFLICKER
   inc de
ELSE
   inc d
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   ld l,a
   ld a,(hl)
   inc h
IF DISP_HICOLOUR
   ld l,(ix+21)
ELSE
   ld l,(ix+14)
ENDIF
   or (hl)
   dec h
   ex de,hl
   or (hl)
   ld (hl),a
   ex de,hl
IF !COMPRESS
IF DISP_HICOLOUR
   inc bc
ENDIF
ENDIF
   jp coloursprite


.ornorotate
   ex de,hl                      ; hl = screen address
   ld a,(bc)                     ; graphic
   or (hl)                       ; or onto screen
   ld (hl),a
IF NOFLICKER
   inc hl
ELSE
   inc h                         ; next scan line
ENDIF
IF !COMPRESS
   inc bc                        ; skip mask
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat total of 8 times for entire char
   or (hl)
   ld (hl),a
IF NOFLICKER
   inc hl
ELSE
   inc h
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   or (hl)
   ld (hl),a
IF NOFLICKER
   inc hl
ELSE
   inc h
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   or (hl)
   ld (hl),a
IF NOFLICKER
   inc hl
ELSE
   inc h
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   or (hl)
   ld (hl),a
IF NOFLICKER
   inc hl
ELSE
   inc h
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   or (hl)
   ld (hl),a
IF NOFLICKER
   inc hl
ELSE
   inc h
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   or (hl)
   ld (hl),a
IF NOFLICKER
   inc hl
ELSE
   inc h
ENDIF
IF !COMPRESS
   inc bc
ENDIF
IF DISP_HICOLOUR
   inc bc                        ; skip colour for now
ENDIF
   inc bc

   ld a,(bc)                     ; repeat
   or (hl)
   ld (hl),a
   ex de,hl                      ; de = screen address
IF DISP_HICOLOUR
IF !COMPRESS
   inc bc
ENDIF
   pop hl
   inc hl
   jp noclrrotate
ELSE
   jp coloursprite
ENDIF
