// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

#asm
                ORG 60000
.BORDER_COL     EQU  $0

; *****************************************************************************
; * Phaser1 Engine, With Digital Drum Samples
; *
; * Original code by Shiru - http://shiru.untergrund.net/
; * Modified by Chris Cowley
; *
; * Produced by Beepola v1.05.01
; ******************************************************************************
 
.START
             LD    HL,MUSICDATA         ;  <- Pointer to Music Data. Change
                                        ;     this to play a different song
             LD   A,(HL)                         ; Get the loop start pointer
             LD   (PATTERN_LOOP_BEGIN),A
             INC  HL
             LD   A,(HL)                         ; Get the song end pointer
             LD   (PATTERN_LOOP_END),A
             INC  HL
             LD   E,(HL)
             INC  HL
             LD   D,(HL)
             INC  HL
             LD   (INSTRUM_TBL),HL
             LD   (CURRENT_INST),HL
             ADD  HL,DE
             LD   (PATTERN_ADDR),HL
             XOR  A
             LD   (PATTERN_PTR),A                ; Set the pattern pointer to zero
             LD   H,A
             LD   L,A
             LD   (NOTE_PTR),HL                  ; Set the note offset (within this pattern) to 0

.PLAYER
             ;di
             PUSH IY
             LD   A,BORDER_COL
             LD   H,$00
             LD   L,A
             LD   (CNT_1A),HL
             LD   (CNT_1B),HL
             LD   (DIV_1A),HL
             LD   (DIV_1B),HL
             LD   (CNT_2),HL
             LD   (DIV_2),HL
             LD   (OUT_1),A
             LD   (OUT_2),A
             JR   MAIN_LOOP

; ********************************************************************************************************
; * NEXT_PATTERN
; *
; * Select the next pattern in sequence (and handle looping if we've reached PATTERN_LOOP_END
; * Execution falls through to PLAYNOTE to play the first note from our next pattern
; ********************************************************************************************************
.NEXT_PATTERN
                          LD   A,(PATTERN_PTR)
                          INC  A
                          INC  A
                          DEFB $FE                           ; CP n
.PATTERN_LOOP_END         DEFB 0
                          JR   NZ,NO_PATTERN_LOOP
                          ; Handle Pattern Looping at and of song
                          DEFB $3E                           ; LD A,n
.PATTERN_LOOP_BEGIN       DEFB 0
.NO_PATTERN_LOOP          LD   (PATTERN_PTR),A
                          LD   HL,$0000
                          LD   (NOTE_PTR),HL   ; Start of pattern (NOTE_PTR = 0)

.MAIN_LOOP
             LD   IYL,0                        ; Set channel = 0

.READ_LOOP
             LD   HL,(PATTERN_ADDR)
             LD   A,(PATTERN_PTR)
             LD   E,A
             LD   D,0
             ADD  HL,DE
             LD   E,(HL)
             INC  HL
             LD   D,(HL)                       ; Now DE = Start of Pattern data
             LD   HL,(NOTE_PTR)
             INC  HL                           ; Increment the note pointer and...
             LD   (NOTE_PTR),HL                ; ..store it
             DEC  HL
             ADD  HL,DE                        ; Now HL = address of note data
             LD   A,(HL)
             OR   A
             JR   Z,NEXT_PATTERN               ; select next pattern

             BIT  7,A
             JP   Z,RENDER                     ; Play the currently defined note(S) and drum
             LD   IYH,A
             AND  $3F
             CP   $3C
             JP   NC,OTHER                     ; Other parameters
             ADD  A,A
             LD   B,0
             LD   C,A
             LD   HL,FREQ_TABLE
             ADD  HL,BC
             LD   E,(HL)
             INC  HL
             LD   D,(HL)
             LD   A,IYL                        ; IYL = 0 for channel 1, or = 1 for channel 2
             OR   A
             JR   NZ,SET_NOTE2
             LD   (DIV_1A),DE
             EX   DE,HL

             DEFB $DD,$21                      ; LD IX,nn
.CURRENT_INST
             DEFW $0000

             LD   A,(IX+$00)
             OR   A
             JR   Z,L809B                      ; Original code jumps into byte 2 of the DJNZ (invalid opcode FD)
             LD   B,A
.L8098       ADD  HL,HL
             DJNZ L8098
.L809B       LD   E,(IX+$01)
             LD   D,(IX+$02)
             ADD  HL,DE
             LD   (DIV_1B),HL
             LD   IYL,1                        ; Set channel = 1
             LD   A,IYH
             AND  $40
             JR   Z,READ_LOOP                  ; No phase reset

             LD   HL,OUT_1                     ; Reset phaser
             RES  4,(HL)
             LD   HL,$0000
             LD   (CNT_1A),HL
             LD   H,(IX+$03)
             LD   (CNT_1B),HL
             JR   READ_LOOP

.SET_NOTE2
             LD   (DIV_2),DE
             LD   A,IYH
             LD   HL,OUT_2
             RES  4,(HL)
             LD   HL,$0000
             LD   (CNT_2),HL
             JP   READ_LOOP

.SET_STOP
             LD   HL,$0000
             LD   A,IYL
             OR   A
             JR   NZ,SET_STOP2
             ; Stop channel 1 note
             LD   (DIV_1A),HL
             LD   (DIV_1B),HL
             LD   HL,OUT_1
             RES  4,(HL)
             LD   IYL,1
             JP   READ_LOOP
.SET_STOP2
             ; Stop channel 2 note
             LD   (DIV_2),HL
             LD   HL,OUT_2
             RES  4,(HL)
             JP   READ_LOOP

.OTHER       CP   $3C
             JR   Z,SET_STOP                   ; Stop note
             CP   $3E
             JR   Z,SKIP_CH1                   ; No changes to channel 1
             INC  HL                           ; Instrument change
             LD   L,(HL)
             LD   H,$00
             ADD  HL,HL
             LD   DE,(NOTE_PTR)
             INC  DE
             LD   (NOTE_PTR),DE                ; Increment the note pointer

             DEFB $01                          ; LD BC,nn
.INSTRUM_TBL
             DEFW $0000

             ADD  HL,BC
             LD   (CURRENT_INST),HL
             JP   READ_LOOP

.SKIP_CH1
             LD   IYL,$01
             JP   READ_LOOP

.EXIT_PLAYER
             LD   HL,$2758
             EXX
             POP  IY
             ;di
             RET

.RENDER
             AND  $7F                          ; L813A
             CP   $76
             JP   NC,DRUM_TYPE_1
             LD   D,A
             EXX
             DEFB $21                          ; LD HL,nn
.CNT_1A      DEFW $0000
             DEFB $DD,$21                      ; LD IX,nn
.CNT_1B      DEFW $0000
             DEFB $01                          ; LD BC,nn
.DIV_1A      DEFW $0000
             DEFB $11                          ; LD DE,nn
.DIV_1B      DEFW $0000
             DEFB $3E                          ; LD A,n
.OUT_1       DEFB $0
             EXX
             EX   AF,AF'
             DEFB $21                          ; LD HL,nn
.CNT_2       DEFW $0000
             DEFB $01                          ; LD BC,nn
.DIV_2       DEFW $0000
             DEFB $3E                          ; LD A,n
.OUT_2       DEFB $00

.PLAY_NOTE
             ; Read keyboard
             LD   E,A
             XOR  A
             IN   A,($FE)
             OR   $E0
             INC  A

.PLAYER_WAIT_KEY
             JR   NZ,EXIT_PLAYER
             LD   A,E
             LD   E,0

.L8168       EXX
             EX   AF,AF'
             ADD  HL,BC
             OUT  ($FE),A
             JR   C,L8171
             JR   L8173
.L8171       XOR  $10
.L8173       ADD  IX,DE
             JR   C,L8179
             JR   L817B
.L8179       XOR  $10
.L817B       EX   AF,AF'
             OUT  ($FE),A
             EXX
             ADD  HL,BC
             JR   C,L8184
             JR   L8186
.L8184       XOR  $10
.L8186       NOP
             JP   L818A

.L818A       EXX
             EX   AF,AF'
             ADD  HL,BC
             OUT  ($FE),A
             JR   C,L8193
             JR   L8195
.L8193       XOR  $10
.L8195       ADD  IX,DE
             JR   C,L819B
             JR   L819D
.L819B       XOR  $10
.L819D       EX   AF,AF'
             OUT  ($FE),A
             EXX
             ADD  HL,BC
             JR   C,L81A6
             JR   L81A8
.L81A6       XOR  $10
.L81A8       NOP
             JP   L81AC

.L81AC       EXX
             EX   AF,AF'
             ADD  HL,BC
             OUT  ($FE),A
             JR   C,L81B5
             JR   L81B7
.L81B5       XOR  $10
.L81B7       ADD  IX,DE
             JR   C,L81BD
             JR   L81BF
.L81BD       XOR  $10
.L81BF       EX   AF,AF'
             OUT  ($FE),A
             EXX
             ADD  HL,BC
             JR   C,L81C8
             JR   L81CA
.L81C8       XOR  $10
.L81CA       NOP
             JP   L81CE

.L81CE       EXX
             EX   AF,AF'
             ADD  HL,BC
             OUT  ($FE),A
             JR   C,L81D7
             JR   L81D9
.L81D7       XOR  $10
.L81D9       ADD  IX,DE
             JR   C,L81DF
             JR   L81E1
.L81DF       XOR  $10
.L81E1       EX   AF,AF'
             OUT  ($FE),A
             EXX
             ADD  HL,BC
             JR   C,L81EA
             JR   L81EC
.L81EA       XOR  $10

.L81EC       DEC  E
             JP   NZ,L8168

             EXX
             EX   AF,AF'
             ADD  HL,BC
             OUT  ($FE),A
             JR   C,L81F9
             JR   L81FB
.L81F9       XOR  $10
.L81FB       ADD  IX,DE
             JR   C,L8201
             JR   L8203
.L8201       XOR  $10
.L8203       EX   AF,AF'
             OUT  ($FE),A
             EXX
             ADD  HL,BC
             JR   C,L820C
             JR   L820E
.L820C       XOR  $10

.L820E       DEC  D
             JP   NZ,PLAY_NOTE

             LD   (CNT_2),HL
             LD   (OUT_2),A
             EXX
             EX   AF,AF'
             LD   (CNT_1A),HL
             LD   (CNT_1B),IX
             LD   (OUT_1),A
             JP   MAIN_LOOP

; ************************************************************
; * DRUM type 1 - Digital
; ************************************************************
.DRUM_TYPE_1
             SUB  $74                          ; On entry A=$75+Drum number (i.e. $76 to $7D), this makes it $02 to $09
             LD   B,A
             LD   A,$80
.L822C       RLA                               ;
             DJNZ L822C                        ; Rotates the drum number, giving us the appropriately-set bit in A

.DRUM_DIGITAL
             LD   (DRUM_SAMPLE),A
             LD   A,BORDER_COL
             LD   D,A
             LD   HL,SAMPLE_DATA
             LD   BC,1024                      ; Drums are all 1024 samples long, and striped into a byte
.NEXT_SAMPLE
             LD   A,(HL)

             DEFB $E6                          ; AND n
.DRUM_SAMPLE
             DEFB $08

             LD   A,D                          ; Put border colour bits into A
             JR   NZ,L8247                     ; Sample bit set
             JR   Z,L8249                      ; Sample bit not set
.L8247       OR   $10
.L8249       OUT  ($FE),A
             LD   E,$04
.L824D       DEC  E
             JR   NZ,L824D
             INC  HL
             DEC  BC
             LD   A,B
             OR   C
             JR   NZ,NEXT_SAMPLE
             JP   MAIN_LOOP

.PATTERN_ADDR   DEFW  $0000
.PATTERN_PTR    DEFB  0
.NOTE_PTR       DEFW  $0000

; **************************************************************
; * Frequency Table
; **************************************************************
.FREQ_TABLE
             DEFW 178,189,200,212,225,238,252,267,283,300,318,337
             DEFW 357,378,401,425,450,477,505,535,567,601,637,675
             DEFW 715,757,802,850,901,954,1011,1071,1135,1202,1274,1350
             DEFW 1430,1515,1605,1701,1802,1909,2023,2143,2270,2405,2548,2700
             DEFW 2860,3030,3211,3402,3604,3818,4046,4286,4541,4811,5097,5400

; *****************************************************************
; * Digital Drum Samples - 8 * 1024bit samples, striped into bytes
; *****************************************************************
.SAMPLE_DATA
             DEFB $02,$02,$02,$02,$00,$00,$02,$00,$0E,$00,$00,$00,$00,$00,$00,$00
             DEFB $0C,$00,$00,$00,$08,$10,$10,$10,$18,$70,$70,$70,$70,$70,$70,$70
             DEFB $74,$70,$50,$50,$D8,$D0,$D0,$D0,$D4,$D0,$D0,$D0,$D0,$D0,$D0,$D0
             DEFB $D4,$D1,$D1,$D1,$5D,$41,$41,$41,$41,$41,$41,$41,$4D,$41,$41,$41
             DEFB $49,$41,$41,$41,$47,$41,$41,$60,$6C,$22,$20,$20,$2E,$22,$20,$20
             DEFB $22,$22,$22,$22,$26,$32,$32,$32,$36,$32,$32,$32,$36,$B2,$B2,$B2
             DEFB $B2,$B2,$32,$32,$3E,$32,$32,$B2,$B2,$B2,$B2,$B2,$BE,$12,$12,$11
             DEFB $17,$13,$93,$93,$97,$83,$83,$C3,$CB,$C3,$C3,$C3,$CB,$C3,$C1,$C1
             DEFB $C9,$C1,$C1,$C1,$C5,$C1,$C1,$C1,$41,$41,$41,$41,$4D,$41,$41,$41
             DEFB $41,$40,$40,$40,$6C,$60,$70,$70,$78,$70,$70,$70,$7C,$70,$70,$70
             DEFB $74,$70,$70,$70,$70,$70,$70,$70,$34,$30,$30,$30,$38,$30,$30,$30
             DEFB $38,$30,$30,$B0,$B8,$B0,$B0,$B0,$A4,$A0,$A0,$A0,$84,$80,$80,$80
             DEFB $8C,$80,$80,$80,$8C,$82,$82,$82,$8C,$80,$82,$82,$8E,$83,$81,$83
             DEFB $8F,$83,$83,$83,$87,$83,$83,$83,$87,$D3,$D3,$D3,$D7,$D3,$D3,$53
             DEFB $53,$53,$73,$73,$77,$73,$73,$73,$7B,$73,$73,$73,$73,$73,$73,$73
             DEFB $73,$73,$73,$73,$77,$73,$73,$73,$7D,$73,$73,$71,$6D,$61,$60,$60
             DEFB $6C,$62,$62,$62,$62,$60,$60,$60,$64,$60,$60,$20,$00,$00,$00,$00
             DEFB $08,$00,$00,$00,$00,$00,$00,$00,$04,$00,$00,$00,$04,$00,$90,$90
             DEFB $1C,$10,$10,$10,$90,$90,$90,$90,$18,$10,$10,$10,$90,$90,$90,$10
             DEFB $1C,$10,$10,$10,$1C,$30,$30,$30,$34,$B0,$B0,$B0,$34,$30,$F0,$F0
             DEFB $F4,$F0,$E0,$E0,$E4,$E0,$E0,$60,$68,$E0,$E0,$E0,$E0,$E2,$E2,$E2
             DEFB $E6,$E0,$E2,$E0,$E6,$E3,$E3,$E3,$E3,$61,$63,$E3,$E7,$E3,$43,$43
             DEFB $4F,$41,$41,$41,$43,$53,$53,$53,$57,$53,$53,$53,$57,$53,$53,$53
             DEFB $13,$13,$13,$13,$17,$13,$13,$13,$1B,$13,$13,$11,$19,$13,$13,$11
             DEFB $11,$11,$13,$11,$11,$11,$11,$13,$1B,$33,$33,$A1,$A3,$A1,$A1,$A1
             DEFB $21,$21,$A1,$A1,$A9,$A0,$A0,$A0,$A0,$A0,$20,$20,$28,$20,$A0,$A0
             DEFB $A0,$20,$20,$A0,$E0,$E0,$60,$E0,$E0,$E0,$E0,$E0,$E8,$60,$60,$70
             DEFB $78,$F0,$F0,$F0,$D8,$50,$50,$50,$58,$50,$50,$50,$50,$50,$50,$50
             DEFB $50,$50,$50,$50,$58,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50
             DEFB $5C,$50,$50,$50,$54,$40,$42,$40,$00,$02,$00,$00,$00,$00,$20,$20
             DEFB $20,$22,$22,$22,$22,$22,$20,$22,$2A,$20,$22,$22,$22,$20,$22,$22
             DEFB $26,$22,$20,$22,$26,$22,$20,$22,$22,$22,$A2,$B2,$B8,$B0,$B0,$B2
             DEFB $B2,$B2,$B2,$32,$32,$B2,$B0,$B2,$B0,$B0,$32,$90,$90,$92,$52,$51
             DEFB $51,$51,$D1,$D1,$D9,$D1,$51,$51,$51,$51,$53,$D1,$D9,$51,$51,$D3
             DEFB $D3,$51,$41,$C1,$C1,$C1,$C1,$C1,$C9,$C1,$C1,$C1,$41,$41,$C1,$C1
             DEFB $C9,$C1,$C1,$41,$C9,$C1,$C1,$61,$69,$E1,$E1,$E1,$61,$61,$61,$61
             DEFB $61,$61,$61,$61,$29,$21,$21,$21,$25,$31,$31,$31,$35,$31,$31,$31
             DEFB $39,$B1,$B1,$31,$31,$31,$31,$31,$31,$B1,$32,$30,$B0,$B0,$30,$30
             DEFB $34,$30,$32,$32,$14,$10,$10,$10,$10,$10,$10,$10,$10,$90,$92,$12
             DEFB $10,$92,$82,$02,$00,$00,$00,$02,$8A,$02,$02,$02,$CE,$40,$40,$40
             DEFB $40,$42,$40,$42,$4A,$C2,$C2,$42,$40,$40,$40,$40,$48,$C2,$42,$42
             DEFB $48,$40,$60,$60,$EA,$62,$62,$E2,$EA,$60,$70,$70,$70,$70,$F0,$F0
             DEFB $70,$70,$72,$70,$7A,$72,$70,$70,$F0,$F0,$70,$F0,$F0,$70,$70,$F0
             DEFB $F2,$70,$F0,$B0,$3C,$30,$30,$30,$34,$30,$30,$30,$30,$B0,$B0,$30
             DEFB $B0,$90,$10,$00,$00,$00,$00,$80,$82,$02,$00,$00,$00,$00,$00,$00
             DEFB $00,$00,$00,$00,$04,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
             DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$50,$50,$50
             DEFB $58,$72,$70,$70,$70,$70,$70,$70,$70,$70,$70,$72,$7A,$72,$72,$70
             DEFB $F8,$F0,$F0,$F2,$7A,$70,$70,$70,$F0,$F0,$F0,$70,$70,$70,$72,$F2
             DEFB $F0,$70,$70,$F2,$F2,$F0,$F0,$E0,$E8,$E2,$60,$60,$E0,$E0,$E2,$E2
             DEFB $EA,$C0,$C2,$C2,$C2,$42,$00,$82,$82,$82,$80,$82,$80,$80,$80,$80
             DEFB $80,$80,$00,$02,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
             DEFB $08,$00,$10,$10,$10,$10,$10,$10,$18,$10,$10,$10,$12,$10,$10,$10
             DEFB $10,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$70
             DEFB $70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$70,$60,$60
             DEFB $60,$60,$60,$60,$60,$60,$60,$60,$68,$60,$60,$60,$60,$60,$60,$60
             DEFB $68,$60,$60,$C0,$C8,$C0,$C0,$C0,$C0,$40,$40,$40,$40,$C0,$C0,$40
             DEFB $40,$42,$40,$C2,$C8,$C0,$40,$42,$C2,$C2,$10,$10,$98,$90,$92,$92
             DEFB $12,$12,$10,$10,$10,$10,$10,$10,$9A,$92,$90,$90,$98,$90,$90,$90
             DEFB $12,$12,$92,$90,$B0,$B0,$30,$30,$38,$30,$30,$30,$38,$30,$30,$30
             DEFB $3A,$30,$32,$30,$30,$30,$20,$22,$20,$A0,$A0,$20,$28,$A0,$A2,$A2
             DEFB $A0,$20,$20,$20,$20,$60,$60,$60,$60,$60,$62,$60,$68,$E0,$E0,$E0
             DEFB $E0,$E0,$60,$60,$60,$60,$E0,$E0,$40,$40,$40,$40,$40,$40,$40,$40
             DEFB $48,$40,$40,$40,$58,$50,$50,$50,$58,$50,$D0,$D0,$50,$50,$50,$50


.MUSICDATA
             DEFB 0  ; Pattern loop begin * 2
             DEFB 4  ; Song length * 2
             DEFW 8         ; Offset to start of song (length of instrument table)
             DEFB 1      ; Multiple
             DEFW 14      ; Detune
             DEFB 0      ; Phase
             DEFB 0      ; Multiple
             DEFW 5      ; Detune
             DEFB 0      ; Phase

.PATTERNDATA        DEFW      PAT0
                    DEFW      PAT1

; *** Pattern data - $00 marks the end of a pattern ***
.PAT0
         DEFB 188
         DEFB 152
         DEFB 118
     DEFB 5
         DEFB 190
         DEFB 152
         DEFB 118
     DEFB 2
         DEFB 254
     DEFB 3
         DEFB $BD,2
         DEFB 168
         DEFB 152
         DEFB 125
     DEFB 5
         DEFB 190
         DEFB 152
         DEFB 118
     DEFB 5
         DEFB 166
         DEFB 152
     DEFB 6
         DEFB 190
         DEFB 152
         DEFB 118
     DEFB 2
         DEFB 190
         DEFB 118
     DEFB 2
         DEFB 164
         DEFB 152
         DEFB 125
     DEFB 5
         DEFB 190
         DEFB 152
         DEFB 118
     DEFB 2
         DEFB 190
         DEFB 118
     DEFB 2
         DEFB 163
         DEFB 154
         DEFB 118
     DEFB 5
         DEFB 161
         DEFB 154
         DEFB 118
     DEFB 2
         DEFB 190
         DEFB 118
     DEFB 2
         DEFB 163
         DEFB 154
         DEFB 125
     DEFB 2
         DEFB 190
         DEFB 118
     DEFB 2
         DEFB 164
         DEFB 154
     DEFB 3
         DEFB 190
         DEFB 118
     DEFB 2
         DEFB 190
         DEFB 154
     DEFB 6
         DEFB 190
         DEFB 154
         DEFB 118
     DEFB 2
         DEFB 190
         DEFB 118
     DEFB 2
         DEFB 190
         DEFB 154
         DEFB 125
     DEFB 5
         DEFB 190
         DEFB 154
         DEFB 125
     DEFB 5
         DEFB 190
         DEFB 156
         DEFB 118
     DEFB 5
         DEFB 190
         DEFB 156
         DEFB 118
     DEFB 5
         DEFB 168
         DEFB 156
         DEFB 125
     DEFB 5
         DEFB 190
         DEFB 156
         DEFB 118
     DEFB 5
         DEFB 166
         DEFB 156
         DEFB 118
     DEFB 5
         DEFB 190
         DEFB 156
         DEFB 118
     DEFB 5
         DEFB 164
         DEFB 156
         DEFB 125
     DEFB 5
         DEFB 190
         DEFB 156
         DEFB 118
     DEFB 5
         DEFB 168
         DEFB 157
         DEFB 118
     DEFB 5
         DEFB 190
         DEFB 157
         DEFB 118
     DEFB 5
         DEFB 166
         DEFB 157
         DEFB 125
     DEFB 2
         DEFB 190
         DEFB 125
     DEFB 2
         DEFB 190
         DEFB 157
     DEFB 3
         DEFB 190
         DEFB 125
     DEFB 2
         DEFB 169
         DEFB 157
         DEFB 125
     DEFB 2
         DEFB 190
         DEFB 125
     DEFB 2
         DEFB 190
         DEFB 157
     DEFB 3
         DEFB 190
         DEFB 125
     DEFB 2
         DEFB 168
         DEFB 157
         DEFB 125
     DEFB 2
         DEFB 190
         DEFB 122
     DEFB 2
         DEFB 190
         DEFB 157
         DEFB 123
     DEFB 2
         DEFB 190
         DEFB 124
     DEFB 2
         DEFB $00
.PAT1
         DEFB $BD,2
         DEFB 168
         DEFB 152
         DEFB 118
     DEFB 5
         DEFB 166
         DEFB 140
         DEFB 118
     DEFB 2
         DEFB 166
     DEFB 3
         DEFB 169
         DEFB 152
         DEFB 125
     DEFB 5
         DEFB 169
         DEFB 140
         DEFB 118
     DEFB 2
         DEFB 190
         DEFB 118
     DEFB 2
         DEFB 190
         DEFB 154
         DEFB 118
     DEFB 5
         DEFB 168
         DEFB 142
         DEFB 118
     DEFB 2
         DEFB 190
         DEFB 118
     DEFB 2
         DEFB 166
         DEFB 154
         DEFB 125
     DEFB 5
         DEFB 169
         DEFB 142
         DEFB 118
     DEFB 2
         DEFB 169
         DEFB 118
     DEFB 2
         DEFB 169
         DEFB 156
         DEFB 118
     DEFB 5
         DEFB 168
         DEFB 144
         DEFB 118
     DEFB 2
         DEFB 190
         DEFB 118
     DEFB 2
         DEFB 166
         DEFB 156
         DEFB 125
     DEFB 2
         DEFB 190
         DEFB 118
     DEFB 2
         DEFB 169
         DEFB 144
         DEFB 118
     DEFB 5
         DEFB 190
         DEFB 157
         DEFB 118
     DEFB 5
         DEFB 168
         DEFB 156
         DEFB 118
     DEFB 2
         DEFB 190
         DEFB 118
     DEFB 2
         DEFB 166
         DEFB 154
         DEFB 125
     DEFB 2
         DEFB 190
         DEFB 125
     DEFB 2
         DEFB 171
         DEFB 156
         DEFB 125
     DEFB 2
         DEFB 190
         DEFB 125
     DEFB 2
         DEFB 190
         DEFB 118
     DEFB 2
         DEFB 190
         DEFB 118
     DEFB 2
         DEFB 190
         DEFB 122
     DEFB 2
         DEFB 190
         DEFB 123
     DEFB 2
         DEFB 169
         DEFB 125
     DEFB 2
         DEFB 190
         DEFB 122
     DEFB 2
         DEFB 190
         DEFB 123
     DEFB 2
         DEFB 190
         DEFB 118
     DEFB 2
         DEFB 190
         DEFB 118
     DEFB 2
         DEFB 190
         DEFB 122
     DEFB 2
         DEFB 168
         DEFB 123
     DEFB 2
         DEFB 190
         DEFB 124
     DEFB 2
         DEFB 190
         DEFB 125
     DEFB 5
         DEFB 166
         DEFB 154
         DEFB 125
     DEFB 5
         DEFB 168
         DEFB 156
         DEFB 118
     DEFB 2
         DEFB 190
         DEFB 125
     DEFB 2
         DEFB 169
         DEFB 157
     DEFB 6
         DEFB 190
         DEFB 157
         DEFB 125
     DEFB 2
         DEFB 190
         DEFB 118
     DEFB 2
         DEFB 168
         DEFB 156
         DEFB 118
     DEFB 2
         DEFB 190
         DEFB 122
     DEFB 2
         DEFB 190
         DEFB 156
         DEFB 123
     DEFB 2
         DEFB 190
         DEFB 118
     DEFB 2
         DEFB 164
         DEFB 152
         DEFB 118
     DEFB 2
         DEFB 190
         DEFB 124
     DEFB 2
         DEFB 190
         DEFB 152
         DEFB 125
     DEFB 2
         DEFB 190
         DEFB 122
     DEFB 2
         DEFB 166
         DEFB 154
         DEFB 123
     DEFB 2
         DEFB 190
         DEFB 124
     DEFB 2
         DEFB $00
#endasm

