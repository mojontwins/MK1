;
; GetKey
; Alvin Albrecht 2002
;
; Scans the keyboard and returns an ascii code representing a
; single keypress.  "GetKey" operates as a state machine.  First
; it debounces a key by ignoring it until a minimum time
; "SPkeydebounce" (byte) is passed.  Then it will wait until
; the key has been pressed for a period "SPkeystartrepeat" (byte)
; at which time it will start to repeat the key at a rate
; "SPkeyrepeatperiod" (byte).  If more than one key is pressed,
; no key is registered and the state machine returns to the
; debounce state.  Time intervals depend on how often GetKey
; is called.  If GetKey is part of an interrupt service routine
; then time is measured in 1/50s (Europe) or 1/60s (N. America).
;
; Key to ascii code translation is done by lookup table pointed
; at by "SPkeytranstbl".
;

XLIB SPGetKey
LIB SPkeytranstbl, SPtbllookup
XDEF SPInkey
XDEF SPkeydebounce, SPkeystartrepeat, SPkeyrepeatperiod

;
; Local Static Variables
;

.state
   defb 0                     ; 0 = debounce, 1 = start repeat, 2 = repeat
.count
   defb 0                     ; how long a key has been pressed

;
; Global Static Variables
;

.SPkeydebounce
   defb 0
.SPkeystartrepeat
   defb 15
.SPkeyrepeatperiod
   defb 4


; Inkey
;
; Read a key without waiting for debounce, etc.
; uses :   af,bc,de,hl,af'
; 
; If GetKey() is part of an ISR, Inkey might *very*
; occasionally cause an extra keypress to be read
; by GetKey(). Look into "KeyPressed" as an alternative.

.SPInkey
   ld hl,(state)              ; get state AND count
   push hl                    ; save them
   ld a,255
   ld (count),a               ; pretend key has been pressed forever
   call SPGetKey
   pop hl
   ld (state),hl              ; restore state AND count
   ret


; GetKey
;
; uses :   af,bc,de,hl,af'
; exit :   carry flag set:  key is registered, a = ascii code
;
; A key is registered only if it is the sole key pressed on the keyboard.

.SPGetKey
   ld bc,$fefe          ; get ready to scan all rows on keyboard
   ld d,$fe             ; d = max 1 keypress
   xor a                ; a = current key index
   ld h,a               ; index of last keypress

.scanloop
   in e,(c)             ; read status of key row
   ld l,5               ; 5 keys in row

.keyrowloop
   rrc e                ; is this key pressed?
   jp c, nopress
   or a
   jr z, nopress        ; ignore CAPS
   cp 36
   jr z, nopress        ; ignore SYM SHIFT
   inc d                ; another key pressed
   jr z, toomanykeys    ; exit if more than one
   ld h,a               ; remember which key

.nopress
   inc a                ; on to the next key index
   dec l
   jp nz, keyrowloop

.nextscanrow
   rlc b                ; on to the next key row
   jp c, scanloop

   inc d                ; check if a single key was pressed
   jr nz, nokeys

   ld a,(count)         ; increase length of time key has been pressed
   inc a
   jr z, atmaxcount
   ld (count),a

.atmaxcount
   ld l,a               ; l = length of time key has been pressed
   ld de,SPkeydebounce
   ld a,(state)
   call SPtbllookup     ; a = length of time key needs to be pressed in order to register
   cp l
   ret nc               ; if key hasn't been held down long enough

   ld a,(state)         ; advance GetKey state machine
   inc a
   cp 3
   jr nc, skip
   ld (state),a

.skip
   xor a
   ld (count),a         ; reset keypress count
   ld e,h
   ld d,0               ; de = index of key pressed
   ld hl,SPkeytranstbl
   add hl,de

   ld a,$fe             ; check on CAPS key
   in a,($fe)
   and $01
   jr nz, nocaps
   ld e,40
   add hl,de

.nocaps
   ld a,$7f             ; check on SYM SHIFT
   in a,($fe)
   and $02
   jr nz, nosym
   ld e,80
   add hl,de

.nosym
   ld a,(hl)            ; a = ascii code
   scf                  ; indicate key was registered
   ret

.toomanykeys
.nokeys
   ld hl,0
   ld (state),hl        ; zero state AND count
   xor a
   ret
