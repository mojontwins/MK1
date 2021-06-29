;
; LookupKey
; Alvin Albrecht 01.2003
;

XLIB SPLookupKey
LIB SPkeytranstbl, SPbit2mask, SPtbllookup

; Given the ascii code of a character, returns the scan row and mask
; corresponding to the key that needs to be pressed to generate the
; character.  Eg: Calling LookupKey with character 'a' will return
; '$fd' for key row and '$01' for the mask.  You could then check to
; see if the key is pressed with the following bit of code:
;
;   ld a,$fd
;   in a,($fe)
;   and $01
;   jr z, a_is_pressed
;
; The mask returned will have bit 7 set and bit 6 set to
; indicate if CAPS, SYM SHIFTS also have to be pressed to generate the
; ascii code, respectively.

; enter: a = ascii code
; exit : No carry = ascii code not found
;        Else: c = scan row, b = mask
;              bit 7 of b set if CAPS needs to be pressed
;              bit 6 of b set if SYM SHIFT needs to be pressed

.SPLookupKey
   or a
   ld hl,SPkeytranstbl
   ld bc,160
   cpir
   ret nz                   ; no carry if ascii code not found!

   ld a,159
   sub c                    ; index into key translation table
   ;ld b,0                   ; mask

   cp 80                    ; ascii code requires SYM SHIFT?
   jp c, nosym
   sub 80
   set 6,b

.nosym
   cp 40                    ; ascii code requires CAPS SHIFT?
   jp c, nocaps
   sub 40
   set 7,b

.nocaps
   ld c,0

.div5loop                   ; speed is not of the essence
   cp 5                     ; a simple divide by 5 routine
   jr c, donedivide
   sub 5
   inc c
   jp div5loop

.donedivide                 ; c = index/5, a = index%5
   ld de,SPbit2mask
   call SPtbllookup
   or b
   ld b,a                   ; key mask
   ld a,c
   ld de,SPbit2mask
   call SPtbllookup
   cpl
   ld c,a                   ; key row
   scf
   ret
