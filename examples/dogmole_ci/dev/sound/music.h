// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

#asm
                ;org 40000
;0x0    EQU  0x0

; *****************************************************************************
; * Phaser1 Engine, with synthesised drums
; *
; * Original code by Shiru - http://shiru.untergrund.net/
; * Modified by Chris Cowley
; *
; * Produced by Beepola v1.08.01
; ******************************************************************************

.musicstart
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
             LD   A,0x0
             LD   H,0x00
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
;; * Select the next pattern in sequence (and handle looping if we ve reached PATTERN_LOOP_END
; * Execution falls through to PLAYNOTE to play the first note from our next pattern
; ********************************************************************************************************
.NEXT_PATTERN
                          LD   A,(PATTERN_PTR)
                          INC  A
                          INC  A
                          DEFB 0xFE                           ; CP n
.PATTERN_LOOP_END         DEFB 0
                          JR   NZ,NO_PATTERN_LOOP
                          ; Handle Pattern Looping at and of song
                          DEFB 0x3E                           ; LD A,n
.PATTERN_LOOP_BEGIN       DEFB 0
.NO_PATTERN_LOOP          LD   (PATTERN_PTR),A
                          LD   HL,0x0000
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
             AND  0x3F
             CP   0x3C
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

             DEFB 0xDD,0x21                      ; LD IX,nn
.CURRENT_INST
             DEFW 0x0000

             LD   A,(IX+0x00)
             OR   A
             JR   Z,L809B                      ; Original code jumps into byte 2 of the DJNZ (invalid opcode FD)
             LD   B,A
.L8098       ADD  HL,HL
             DJNZ L8098
.L809B       LD   E,(IX+0x01)
             LD   D,(IX+0x02)
             ADD  HL,DE
             LD   (DIV_1B),HL
             LD   IYL,1                        ; Set channel = 1
             LD   A,IYH
             AND  0x40
             JR   Z,READ_LOOP                  ; No phase reset

             LD   HL,OUT_1                     ; Reset phaser
             RES  4,(HL)
             LD   HL,0x0000
             LD   (CNT_1A),HL
             LD   H,(IX+0x03)
             LD   (CNT_1B),HL
             JR   READ_LOOP

.SET_NOTE2
             LD   (DIV_2),DE
             LD   A,IYH
             LD   HL,OUT_2
             RES  4,(HL)
             LD   HL,0x0000
             LD   (CNT_2),HL
             JP   READ_LOOP

.SET_STOP
             LD   HL,0x0000
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

.OTHER       CP   0x3C
             JR   Z,SET_STOP                   ; Stop note
             CP   0x3E
             JR   Z,SKIP_CH1                   ; No changes to channel 1
             INC  HL                           ; Instrument change
             LD   L,(HL)
             LD   H,0x00
             ADD  HL,HL
             LD   DE,(NOTE_PTR)
             INC  DE
             LD   (NOTE_PTR),DE                ; Increment the note pointer

             DEFB 0x01                          ; LD BC,nn
.INSTRUM_TBL
             DEFW 0x0000

             ADD  HL,BC
             LD   (CURRENT_INST),HL
             JP   READ_LOOP

.SKIP_CH1
             LD   IYL,0x01
             JP   READ_LOOP

.EXIT_PLAYER
             LD   HL,0x2758
             EXX
             POP  IY
             ;ei
             RET

.RENDER
             AND  0x7F                          ; L813A
             CP   0x76
             JP   NC,DRUMS
             LD   D,A
             EXX
             DEFB 0x21                          ; LD HL,nn
.CNT_1A      DEFW 0x0000
             DEFB 0xDD,0x21                      ; LD IX,nn
.CNT_1B      DEFW 0x0000
             DEFB 0x01                          ; LD BC,nn
.DIV_1A      DEFW 0x0000
             DEFB 0x11                          ; LD DE,nn
.DIV_1B      DEFW 0x0000
             DEFB 0x3E                          ; LD A,n
.OUT_1       DEFB 0x0
             EXX
             EX   AF,AF
             DEFB 0x21                          ; LD HL,nn
.CNT_2       DEFW 0x0000
             DEFB 0x01                          ; LD BC,nn
.DIV_2       DEFW 0x0000
             DEFB 0x3E                          ; LD A,n
.OUT_2       DEFB 0x00

.PLAY_NOTE
             ; Read keyboard
             LD   E,A
             XOR  A
             IN   A,(0xFE)
             OR   0xE0
             INC  A

.PLAYER_WAIT_KEY
             JR   NZ,EXIT_PLAYER
             LD   A,E
             LD   E,0

.L8168       EXX
             EX   AF,AF
             ADD  HL,BC
             OUT  (0xFE),A
             JR   C,L8171
             JR   L8173
.L8171       XOR  0x10
.L8173       ADD  IX,DE
             JR   C,L8179
             JR   L817B
.L8179       XOR  0x10
.L817B       EX   AF,AF
             OUT  (0xFE),A
             EXX
             ADD  HL,BC
             JR   C,L8184
             JR   L8186
.L8184       XOR  0x10
.L8186       NOP
             JP   L818A

.L818A       EXX
             EX   AF,AF
             ADD  HL,BC
             OUT  (0xFE),A
             JR   C,L8193
             JR   L8195
.L8193       XOR  0x10
.L8195       ADD  IX,DE
             JR   C,L819B
             JR   L819D
.L819B       XOR  0x10
.L819D       EX   AF,AF
             OUT  (0xFE),A
             EXX
             ADD  HL,BC
             JR   C,L81A6
             JR   L81A8
.L81A6       XOR  0x10
.L81A8       NOP
             JP   L81AC

.L81AC       EXX
             EX   AF,AF
             ADD  HL,BC
             OUT  (0xFE),A
             JR   C,L81B5
             JR   L81B7
.L81B5       XOR  0x10
.L81B7       ADD  IX,DE
             JR   C,L81BD
             JR   L81BF
.L81BD       XOR  0x10
.L81BF       EX   AF,AF
             OUT  (0xFE),A
             EXX
             ADD  HL,BC
             JR   C,L81C8
             JR   L81CA
.L81C8       XOR  0x10
.L81CA       NOP
             JP   L81CE

.L81CE       EXX
             EX   AF,AF
             ADD  HL,BC
             OUT  (0xFE),A
             JR   C,L81D7
             JR   L81D9
.L81D7       XOR  0x10
.L81D9       ADD  IX,DE
             JR   C,L81DF
             JR   L81E1
.L81DF       XOR  0x10
.L81E1       EX   AF,AF
             OUT  (0xFE),A
             EXX
             ADD  HL,BC
             JR   C,L81EA
             JR   L81EC
.L81EA       XOR  0x10

.L81EC       DEC  E
             JP   NZ,L8168

             EXX
             EX   AF,AF
             ADD  HL,BC
             OUT  (0xFE),A
             JR   C,L81F9
             JR   L81FB
.L81F9       XOR  0x10
.L81FB       ADD  IX,DE
             JR   C,L8201
             JR   L8203
.L8201       XOR  0x10
.L8203       EX   AF,AF
             OUT  (0xFE),A
             EXX
             ADD  HL,BC
             JR   C,L820C
             JR   L820E
.L820C       XOR  0x10

.L820E       DEC  D
             JP   NZ,PLAY_NOTE

             LD   (CNT_2),HL
             LD   (OUT_2),A
             EXX
             EX   AF,AF
             LD   (CNT_1A),HL
             LD   (CNT_1B),IX
             LD   (OUT_1),A
             JP   MAIN_LOOP

; ************************************************************
; * DRUMS - Synthesised
; ************************************************************
.DRUMS
             ADD  A,A                          ; On entry A=0x75+Drum number (i.e. 0x76 to 0x7E)
             LD   B,0
             LD   C,A
             LD   HL,DRUM_TABLE - 236
             ADD  HL,BC
             LD   E,(HL)
             INC  HL
             LD   D,(HL)
             EX   DE,HL
             JP   (HL)

.DRUM_TONE1  LD   L,16
             JR   DRUM_TONE
.DRUM_TONE2  LD   L,12
             JR   DRUM_TONE
.DRUM_TONE3  LD   L,8
             JR   DRUM_TONE
.DRUM_TONE4  LD   L,6
             JR   DRUM_TONE
.DRUM_TONE5  LD   L,4
             JR   DRUM_TONE
.DRUM_TONE6  LD   L,2
.DRUM_TONE
             LD   DE,3700
             LD   BC,0x0101
             LD   A,0x0
.DT_LOOP0    OUT  (0xFE),A
             DEC  B
             JR   NZ,DT_LOOP1
             XOR  16
             LD   B,C
             EX   AF,AF
             LD   A,C
             ADD  A,L
             LD   C,A
             EX   AF,AF
.DT_LOOP1    DEC  E
             JR   NZ,DT_LOOP0
             DEC  D
             JR   NZ,DT_LOOP0
             JP   MAIN_LOOP

.DRUM_NOISE1 LD   DE,2480
             LD   IXL,1
             JR   DRUM_NOISE
.DRUM_NOISE2 LD   DE,1070
             LD   IXL,10
             JR   DRUM_NOISE
.DRUM_NOISE3 LD   DE,365
             LD   IXL,101
.DRUM_NOISE
             LD   H,D
             LD   L,E
             LD   A,0x0
             LD   C,A
.DN_LOOP0    LD   A,(HL)
             AND  16
             OR   C
             OUT  (0xFE),A
             LD   B,IXL
.DN_LOOP1    DJNZ DN_LOOP1
             INC  HL
             DEC  E
             JR   NZ,DN_LOOP0
             DEC  D
             JR   NZ,DN_LOOP0
             JP   MAIN_LOOP

.PATTERN_ADDR   DEFW  0x0000
.PATTERN_PTR    DEFB  0
.NOTE_PTR       DEFW  0x0000

; **************************************************************
;; * Frequency Table
; **************************************************************
.FREQ_TABLE
             DEFW 178,189,200,212,225,238,252,267,283,300,318,337
             DEFW 357,378,401,425,450,477,505,535,567,601,637,675
             DEFW 715,757,802,850,901,954,1011,1071,1135,1202,1274,1350
             DEFW 1430,1515,1605,1701,1802,1909,2023,2143,2270,2405,2548,2700
             DEFW 2860,3030,3211,3402,3604,3818,4046,4286,4541,4811,5097,5400

; *****************************************************************
; * Synth Drum Lookup Table
; *****************************************************************
.DRUM_TABLE
             DEFW DRUM_TONE1,DRUM_TONE2,DRUM_TONE3,DRUM_TONE4,DRUM_TONE5,DRUM_TONE6
             DEFW DRUM_NOISE1,DRUM_NOISE2,DRUM_NOISE3


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

; *** Pattern data - 0x00 marks the end of a pattern ***
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
         DEFB 0xBD,2
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
         DEFB 0x00
.PAT1
         DEFB 0xBD,2
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
         DEFB 0x00
#endasm

