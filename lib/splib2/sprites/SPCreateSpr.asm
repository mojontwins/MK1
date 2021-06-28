;
; CreateSpr
; Alvin Albrecht 2002
;

INCLUDE "SPconfig.def"

XLIB SPCreateSpr
XREF _u_malloc
LIB SPBlockAlloc, SPDeleteSpr, SPNullSprPtr

IF COMPRESS
LIB SPCompNullSprPtr
ENDIF

; CreateSpr 
;
; Create a new sprite.  The first column of the sprite bitdef is added.  More 
; columns are added with "AddColSpr".  The sprite is not added to the display 
; list and will not be visible until it is moved. 
;
; enter:  B = #rows 
;         C = sprite attribute 
;             bits 7..6 = 00 (mask-type), 01 (or-type), 10 (xor-type), 11 (load-type) 
;             bits 5..0 = sprite plane 0..63, lower means closer to viewer 
;        DE = sprite column definition (bitdef) 
;        A' = (spectrum )  colour attribute for column 
;           = (hi-colour)  colour threshold
;           = (hi-res   )  unused 
; exit : IX = sprite structure address 
;        carry for success 
;
; The display order of sprites in the same plane is indeterminate. 
; The call will only fail if sufficient memory is not available from u_malloc. 

.SPCreateSpr
;IF DISP_HICOLOUR
;   ex af,af'
;   add a,a                    ; convert threshold number
;   or SProtatetbl/256         ; to rotation table msb
;   ex af,af'
;ENDIF
   push de
   push bc
   ld de,14
   push de
   ld hl,(_u_malloc)
   call JPHL                  ; get memory for sprite struct
   pop de
   pop bc
   ld a,h
   or l
   jp z, csfail1
   ld e,l
   ld d,h                     ; hl = de = sprite struct address
   defb $dd
   ld l,e
   defb $dd
   ld h,d                     ; ix = sprite struct address
   xor a
   ld (hl),a                  ; row position = 0
   inc hl
IF DISP_HIRES
   ld (hl),64                 ; col position = 64
ELSE
   ld (hl),32                 ; col position = 32
ENDIF
   inc hl
   ld (hl),b                  ; height in char rows
   inc hl
   ld (hl),1                  ; width = 1 char
   inc hl
   ld (hl),a                  ; no horizontal rotation
   inc hl
   ld (hl),a                  ; no vertical rotation
   inc hl
   ld (hl),a                  ; no next char struct
   ;ld a,c
   ;and $3f
   ;ld (ix+12),a               ; sprite plane
   ld a,c
   and $c0
   ld (ix+13),a               ; sprite type
   push hl
   push bc
   ld de,14
   push de
   ld hl,(_u_malloc)
   call JPHL                  ; get memory for char struct
   pop de
   pop bc
   ld a,h
   or l
   jr z, csfail2
   ex de,hl
   ld (ix+8),e                ; last column in sprite is
   ld (ix+9),d                ; the one being made now
   jp csenter

.csloop
   push de
   push hl
   push bc
   ld de,14
   push de
   ld hl,(_u_malloc)
   call JPHL                  ; get memory for char struct
   pop de
   pop bc
   ld a,h
   or l
   jr z, csfail2
   ex de,hl

.csenter
   pop hl                     ; hl = next char struct ptr
   ld (hl),d                  ; store address of next char struct
   inc hl
   ld (hl),e
   pop hl                     ; hl = sprite column def
   ex de,hl                   ; de = spr col def, hl = char struct
   push hl
   xor a
   ld (hl),a                  ; no next char struct in sprite
   inc hl
   ld (hl),a
   inc hl
   ld (hl),a                  ; no previous char struct in display list
   inc hl
   ld (hl),a
   inc hl
   ld (hl),c                  ; sprite attribute
   inc hl
IF COMPRESS
   ld a,c
   and $c0
IF DISP_HICOLOUR
   ld a,24
ELSE
   ld a,16
ENDIF
   jr z, notcompress
IF DISP_HICOLOUR
   ld a,16
ELSE
   ld a,8
ENDIF
   ld (hl),SPCompNullSprPtr%256
   inc hl
   ld (hl),SPCompNullSprPtr/256
   jp cont
ENDIF
.notcompress
   ld (hl),SPNullSprPtr%256   ; empty space to left of sprite
   inc hl                     ; so sprite rotations will introduce
   ld (hl),SPNullSprPtr/256   ; empty space at leftmost column
.cont
   inc hl
   ld (hl),e                  ; sprite column bitdef
   inc hl
   ld (hl),d
   inc hl
   ld (hl),SProtatetbl/256    ; no horizontal rotation
   inc hl
;IF !DISP_HIRES
;   ex af,af'
;   ld (hl),a
;   ex af,af'
;ENDIF
   inc hl
   ld (hl),0			; no next char struct in display list
   pop hl                     ; hl = char struct (next in sprite ptr)
IF !COMPRESS
IF DISP_HICOLOUR
   ld a,24
ELSE
   ld a,16
ENDIF
ENDIF
   add a,e
   ld e,a                     ; de = sprite column bitdef, next char
   jp nc, csnocry
   inc d

.csnocry
   djnz csloop                ; for all rows in sprite
   ld (ix+10),l
   ld (ix+11),h               ; last char struct in sprite
   scf                        ; success
   ret

.csfail1
   pop de
   ret

.csfail2
   pop hl
   pop de
   defb $dd
   ld e,l
   defb $dd
   ld d,h                     ; de = sprite struct address
   jp SPDeleteSpr

.JPHL
   jp (hl)
