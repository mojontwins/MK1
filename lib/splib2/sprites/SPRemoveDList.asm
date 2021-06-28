;
; RemoveDList
; Alvin Albrecht 2002
;

XLIB SPRemoveDList

; RemoveDList 
;
; Removes a sprite from the display list, making it invisible.  Moving the sprite 
; will make it visible again. 
;
; enter: IX = sprite structure address 

.SPRemoveDList
   ld h,(ix+6)
   ld l,(ix+7)          ; hl = first char struct in sprite
   ld a,h

.rdloop
   or a
   ret z                ; no more char structs in sprite
   push hl              ; save next char struct ptr
   inc hl
   inc hl               ; hl = current + 2
   ld a,(hl)            ; check if char in display list
   or a
   jp z, rdcont         ; not in display list, skip it
   ld (hl),0            ; mark as not in display list
   inc hl
   ld e,(hl)
   ld d,a               ; de = previous char struct + 11
   ld a,8
   add a,l
   ld l,a               ; hl = char struct + 11
   jp nc, noinc1
   inc h

.noinc1
   ld a,(hl)
   ld (hl),0            ; mark no next char struct in display list
   inc hl
   ld l,(hl)
   ld h,a               ; hl = next char struct + 4
   ex de,hl             ; de = next char struct + 4, hl = previous ch str + 11
   ld (hl),d            ; change next ch str ptr
   inc hl
   ld (hl),e
   dec hl

   ex de,hl             ; hl = next ch str + 4, de = prev ch str + 11
   ld a,h
   or a
   jr z, rdcont         ; nothing in display list after this char str
   dec hl               ; hl = next ch str + 3
   ld (hl),e            ; change prev ch str ptr
   dec hl
   ld (hl),d

.rdcont
   pop hl               ; next char struct ptr
   ld a,(hl)
   inc hl
   ld l,(hl)
   ld h,a               ; hl = char struct
   jp rdloop
