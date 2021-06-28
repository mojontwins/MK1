;
; JoyKeyboard
; Alvin Albrecht 2002
;
; Five keys are read corresponding to Fire, Right, Left, Up, Down
; as in a joystick read.  Returns the same result as the low level
; joystick functions.
;
; enter:   de points at a 5-entry table, each entry holds
;             a key row value (byte) followed by a mask (byte).
;             The key row byte is the same byte that would appear
;             in the MSB of a port read of the keyboard.  The mask
;             byte isolates the key within the byte.  "LookupKey"
;             will provide this information for a particular key
;             given its ascii code.
;               de + 0/1 fire key: key row / mask
;               de + 2/3 right key: key row / mask
;               de + 4/5 left key: key row / mask
;               de + 6/7 down key: key row / mask
;               de + 8/9 up key: key row / mask
; exit :   a = F111RLDU active low
; uses :   af,bc,de,hl

XLIB SPJoyKeyboard

.SPJoyKeyboard
   ld bc,$f7ff          ; b = doing R, c = F111RLDU inactive (active low)
   ex de,hl             ; hl = table of user-defined keys
   ld a,(hl)
   in a,($fe)
   inc hl
   and (hl)
   jr nz, nofire
   res 7,c

.nofire
.jkloop
   inc hl
   ld a,(hl)            ; key row
   in a,($fe)           ; read state of keys on row
   inc hl
   and (hl)             ; isolate specific key in row
   jr nz, nopress
   ld a,b
   and c                ; indicate keypress
   ld c,a

.nopress
   rrc b
   jp c, jkloop
   ld a,c
   ret
