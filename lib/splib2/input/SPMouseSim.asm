; Simulated Mouse
; Alvin Albrecht 06.2003

INCLUDE "SPconfig.def"

XLIB SPMouseSim

; Simulated Mouse
;
; Simulates a mouse with keyboard or joystick.  The longer the
; user selects a direction, the faster the mouse moves.
;
; enter: hl = address of struct sp_UDM
; exit : a = h = y coord 0..191
;        l = x coord 0.255, hi-res: carry set adds 256
;        e = 1111111L active low button press
; used : af',af,bc,de,hl

; *** last maxcount in struct sp_UDM must be 255

.nomovement                 ; hl = UDM.delta, a' = F1111111 active low
   inc hl
   inc hl
   ld (hl),0                ; state = 0
   inc hl
   ld (hl),0                ; count = 0
   ex af,af'
   ld e,255
   rla
   rl e                     ; e = 1111111L active low
   ld bc,4
   add hl,bc                ; hl = UDM.x+1
   ld c,(hl)                ; c = x coord
   dec hl
IF DISP_HIRES
   ld b,(hl)                ; b = LSB x coord
ENDIF
   dec hl
   ld a,(hl)                ; a = y coord
   cp 8*(SP_ROWEND - SP_ROWSTART)
   jp c, notoutofrange2
   ld a,8*(SP_ROWEND - SP_ROWSTART) - 1
   ld (hl),a
.notoutofrange2
   ld h,a                   ; a = h = y coord
   ld l,c                   ; l = x coord
IF DISP_HIRES
   sla b
   rl l
ENDIF
   ret

.SPMouseSim
   ld c,(hl)
   inc hl
   ld b,(hl)                ; bc = keys struct
   inc hl
   ld e,(hl)
   inc hl
   ld d,(hl)
   inc hl
   push hl                  ; save UDM.delta
   ex de,hl                 ; hl = joystick function
   push bc                  ; push keys struct parameter, C compatible
   ld e,c
   ld d,b                   ; de = parameter, machine code compatible
   call JPHL
   pop bc
   pop hl                   ; hl = UDM.delta
   ld c,a
   ex af,af'                ; a' = F111RLDU active low

   ld a,c
   inc a
   and $0f
   jr z, nomovement

   ld e,(hl)
   inc hl
   ld d,(hl)                ; de = address of delta array
   inc hl                   ; hl = UDM.state
   ld a,(hl)                ; a = state = index into delta array
   inc hl                   ; hl = UDM.count
   ld c,a
   add a,a
   add a,a
   add a,c
   add a,e
   ld e,a
   jp nc, noinc
   inc d                    ; de = delta[state]
.noinc
   ld a,(hl)
   inc a                    ; increase current count
   jp nz, nowrap
   dec a
.nowrap
   ld (hl),a                ; store new count value
   dec a
   ex de,hl                 ; de = UDM.count, hl = delta[state]
   cp (hl)
   jp c, samestate          ; if not past maxcount for current state

   ex de,hl                 ; hl = UDM.count, de = delta[state]
   ld (hl),0                ; current count = 0
   dec hl
   inc (hl)                 ; move to next state
   inc hl
   ex de,hl                 ; de = UDM.count, hl = delta[state]

.samestate
   inc hl                   ; hl = delta.dx
   inc de                   ; de = UDM.y
   ld c,(hl)
   inc hl
   ld b,(hl)
   inc hl
   push bc                  ; save dx
   ld c,(hl)
   inc hl
   ld b,(hl)                ; bc = dy
   ex de,hl                 ; hl = UDM.y
   ld e,(hl)
   inc hl
   ld d,(hl)
   ex de,hl                 ; hl = y, de = UDM.y+1

.up
   ex af,af'                ; a = F111RLDU active low
   rrca
   jr c, down
   rrca                     ; swallow down, only doing up
   or a
   sbc hl,bc
   jp nc, endvertical
   ld hl,0
   jp endvertical
.down
   rrca
   jr c, endvertical
   add hl,bc
   ex af,af'
   ld a,h
   cp 8*(SP_ROWEND - SP_ROWSTART)
   jp c, notoutofrange
   ld a,8*(SP_ROWEND - SP_ROWSTART) - 1
   ld h,a
.notoutofrange
   ex af,af'

.endvertical                ; a = ??F111RL
   ex de,hl                 ; de = new y, hl = UDM.y+1
   ld (hl),d
   dec hl
   ld (hl),e                ; store new y
   inc hl
   inc hl                   ; hl = UDM.x
   pop bc                   ; bc = dx
   ld e,(hl)
   inc hl
   ld d,(hl)
   ex de,hl                 ; hl = x, de = UDM.x+1

.left
   rrca
   jr c,right
   rrca                     ; swallow right
   or a
   sbc hl,bc
   jp nc, endhorizontal
   ld hl,0
   jp endhorizontal
.right
   rrca
   jr c, endhorizontal
   add hl,bc
   jp nc, endhorizontal
   ld hl,$ffff

.endhorizontal              ; a = ????F111
   ex de,hl                 ; de = new x, hl = UDM.x+1
   ld (hl),d
   dec hl
   ld (hl),e                ; store new x
   dec hl                   ; hl = UDM.y+1

IF DISP_HIRES
   ld c,e                   ; c = LSB of x coord
ENDIF
   and $08
   ld e,255
   jp nz, nofire
   dec e
.nofire                     ; e = 1111111L active low
   ld h,(hl)
   ld a,h                   ; a = h = y coord
   ld l,d                   ; l = x coord
IF DISP_HIRES
   sla c
   rl l
ENDIF
   ret

.JPHL
   jp (hl)
