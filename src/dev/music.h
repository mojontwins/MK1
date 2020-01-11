// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

#asm
; *****************************************************************************
; * Phaser1 Engine, with synthesised drums
; *
; * Original code by Shiru - .http//shiru.untergrund.net/
; * Modified by Chris Cowley
; *
; * Produced by Beepola v1.05.01
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

.player
             ;DI
             PUSH IY
             ;LD   A,BORDER_COL
             xor a
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
; * Select the next pattern in sequence (and handle looping if weve reached PATTERN_LOOP_END
; * Execution falls through to PLAYNOTE to play the first note from our next pattern
; ********************************************************************************************************
.next_pattern
                          LD   A,(PATTERN_PTR)
                          INC  A
                          INC  A
                          DEFB $FE                           ; CP n
.pattern_loop_end         DEFB 0
                          JR   NZ,NO_PATTERN_LOOP
                          ; Handle Pattern Looping at and of song
                          DEFB $3E                           ; LD A,n
.pattern_loop_begin       DEFB 0
.no_pattern_loop          LD   (PATTERN_PTR),A
                          LD   HL,$0000
                          LD   (NOTE_PTR),HL   ; Start of pattern (NOTE_PTR = 0)

.main_loop
             LD   IYL,0                        ; Set channel = 0

.read_loop
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
.current_inst
             DEFW $0000

             LD   A,(IX+$00)
             OR   A
             JR   Z,L809B                      ; Original code jumps into byte 2 of the DJNZ (invalid opcode FD)
             LD   B,A
.l8098       ADD  HL,HL
             DJNZ L8098
.l809b       LD   E,(IX+$01)
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

.set_note2
             LD   (DIV_2),DE
             LD   A,IYH
             LD   HL,OUT_2
             RES  4,(HL)
             LD   HL,$0000
             LD   (CNT_2),HL
             JP   READ_LOOP

.set_stop
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
.set_stop2
             ; Stop channel 2 note
             LD   (DIV_2),HL
             LD   HL,OUT_2
             RES  4,(HL)
             JP   READ_LOOP

.other       CP   $3C
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
.instrum_tbl
             DEFW $0000

             ADD  HL,BC
             LD   (CURRENT_INST),HL
             JP   READ_LOOP

.skip_ch1
             LD   IYL,$01
             JP   READ_LOOP

.exit_player
             LD   HL,$2758
             EXX
             POP  IY
             ;EI
             RET

.render
             AND  $7F                          ; L813A
             CP   $76
             JP   NC,DRUMS
             LD   D,A
             EXX
             DEFB $21                          ; LD HL,nn
.cnt_1a      DEFW $0000
             DEFB $DD,$21                      ; LD IX,nn
.cnt_1b      DEFW $0000
             DEFB $01                          ; LD BC,nn
.div_1a      DEFW $0000
             DEFB $11                          ; LD DE,nn
.div_1b      DEFW $0000
             DEFB $3E                          ; LD A,n
.out_1       DEFB $0
             EXX
             EX   AF,AF ; beware!
             DEFB $21                          ; LD HL,nn
.cnt_2       DEFW $0000
             DEFB $01                          ; LD BC,nn
.div_2       DEFW $0000
             DEFB $3E                          ; LD A,n
.out_2       DEFB $00

.play_note
             ; Read keyboard
             LD   E,A
             XOR  A
             IN   A,($FE)
             OR   $E0
             INC  A

.player_wait_key
             JR   NZ,EXIT_PLAYER
             LD   A,E
             LD   E,0

.l8168       EXX
             EX   AF,AF ; beware!
             ADD  HL,BC
             OUT  ($FE),A
             JR   C,L8171
             JR   L8173
.l8171       XOR  $10
.l8173       ADD  IX,DE
             JR   C,L8179
             JR   L817B
.l8179       XOR  $10
.l817b       EX   AF,AF ; beware!
             OUT  ($FE),A
             EXX
             ADD  HL,BC
             JR   C,L8184
             JR   L8186
.l8184       XOR  $10
.l8186       NOP
             JP   L818A

.l818a       EXX
             EX   AF,AF ; beware!
             ADD  HL,BC
             OUT  ($FE),A
             JR   C,L8193
             JR   L8195
.l8193       XOR  $10
.l8195       ADD  IX,DE
             JR   C,L819B
             JR   L819D
.l819b       XOR  $10
.l819d       EX   AF,AF ; beware!
             OUT  ($FE),A
             EXX
             ADD  HL,BC
             JR   C,L81A6
             JR   L81A8
.l81a6       XOR  $10
.l81a8       NOP
             JP   L81AC

.l81ac       EXX
             EX   AF,AF ; beware!
             ADD  HL,BC
             OUT  ($FE),A
             JR   C,L81B5
             JR   L81B7
.l81b5       XOR  $10
.l81b7       ADD  IX,DE
             JR   C,L81BD
             JR   L81BF
.l81bd       XOR  $10
.l81bf       EX   AF,AF ; beware!
             OUT  ($FE),A
             EXX
             ADD  HL,BC
             JR   C,L81C8
             JR   L81CA
.l81c8       XOR  $10
.l81ca       NOP
             JP   L81CE

.l81ce       EXX
             EX   AF,AF ; beware!
             ADD  HL,BC
             OUT  ($FE),A
             JR   C,L81D7
             JR   L81D9
.l81d7       XOR  $10
.l81d9       ADD  IX,DE
             JR   C,L81DF
             JR   L81E1
.l81df       XOR  $10
.l81e1       EX   AF,AF ; beware!
             OUT  ($FE),A
             EXX
             ADD  HL,BC
             JR   C,L81EA
             JR   L81EC
.l81ea       XOR  $10

.l81ec       DEC  E
             JP   NZ,L8168

             EXX
             EX   AF,AF ; beware!
             ADD  HL,BC
             OUT  ($FE),A
             JR   C,L81F9
             JR   L81FB
.l81f9       XOR  $10
.l81fb       ADD  IX,DE
             JR   C,L8201
             JR   L8203
.l8201       XOR  $10
.l8203       EX   AF,AF ; beware!
             OUT  ($FE),A
             EXX
             ADD  HL,BC
             JR   C,L820C
             JR   L820E
.l820c       XOR  $10

.l820e       DEC  D
             JP   NZ,PLAY_NOTE

             LD   (CNT_2),HL
             LD   (OUT_2),A
             EXX
             EX   AF,AF ; beware!
             LD   (CNT_1A),HL
             LD   (CNT_1B),IX
             LD   (OUT_1),A
             JP   MAIN_LOOP

; ************************************************************
; * DRUMS - Synthesised
; ************************************************************
.drums
             ADD  A,A                          ; On entry A=$75+Drum number (i.e. $76 to $7E)
             LD   B,0
             LD   C,A
             LD   HL,DRUM_TABLE - 236
             ADD  HL,BC
             LD   E,(HL)
             INC  HL
             LD   D,(HL)
             EX   DE,HL
             JP   (HL)

.drum_tone1  LD   L,16
             JR   DRUM_TONE
.drum_tone2  LD   L,12
             JR   DRUM_TONE
.drum_tone3  LD   L,8
             JR   DRUM_TONE
.drum_tone4  LD   L,6
             JR   DRUM_TONE
.drum_tone5  LD   L,4
             JR   DRUM_TONE
.drum_tone6  LD   L,2
.drum_tone
             LD   DE,3700
             LD   BC,$0101
             //LD   A,BORDER_COL
             xor a
.dt_loop0    OUT  ($FE),A
             DEC  B
             JR   NZ,DT_LOOP1
             XOR  16
             LD   B,C
             EX   AF,AF ; beware!
             LD   A,C
             ADD  A,L
             LD   C,A
             EX   AF,AF ; beware!
.dt_loop1    DEC  E
             JR   NZ,DT_LOOP0
             DEC  D
             JR   NZ,DT_LOOP0
             JP   MAIN_LOOP

.drum_noise1 LD   DE,2480
             LD   IXL,1
             JR   DRUM_NOISE
.drum_noise2 LD   DE,1070
             LD   IXL,10
             JR   DRUM_NOISE
.drum_noise3 LD   DE,365
             LD   IXL,101
.drum_noise
             LD   H,D
             LD   L,E
             //LD   A,BORDER_COL
             xor a
             LD   C,A
.dn_loop0    LD   A,(HL)
             AND  16
             OR   C
             OUT  ($FE),A
             LD   B,IXL
.dn_loop1    DJNZ DN_LOOP1
             INC  HL
             DEC  E
             JR   NZ,DN_LOOP0
             DEC  D
             JR   NZ,DN_LOOP0
             JP   MAIN_LOOP

.pattern_addr   DEFW  $0000
.pattern_ptr    DEFB  0
.note_ptr       DEFW  $0000

; **************************************************************
; * Frequency Table
; **************************************************************
.freq_table
             DEFW 178,189,200,212,225,238,252,267,283,300,318,337
             DEFW 357,378,401,425,450,477,505,535,567,601,637,675
             DEFW 715,757,802,850,901,954,1011,1071,1135,1202,1274,1350
             DEFW 1430,1515,1605,1701,1802,1909,2023,2143,2270,2405,2548,2700
             DEFW 2860,3030,3211,3402,3604,3818,4046,4286,4541,4811,5097,5400

; *****************************************************************
; * Synth Drum Lookup Table
; *****************************************************************
.drum_table
             DEFW DRUM_TONE1,DRUM_TONE2,DRUM_TONE3,DRUM_TONE4,DRUM_TONE5,DRUM_TONE6
             DEFW DRUM_NOISE1,DRUM_NOISE2,DRUM_NOISE3


.musicdata
             DEFB 0  ; Pattern loop begin * 2
             DEFB 16  ; Song length * 2
             DEFW 8         ; Offset to start of song (length of instrument table)
             DEFB 1      ; Multiple
             DEFW 10      ; Detune
             DEFB 0      ; Phase
             DEFB 1      ; Multiple
             DEFW 5      ; Detune
             DEFB 1      ; Phase

.patterndata
                    DEFW      PAT0
                    DEFW      PAT1
                    DEFW      PAT0
                    DEFW      PAT1
                    DEFW      PAT2
                    DEFW      PAT3
                    DEFW      PAT2
                    DEFW      PAT3

; *** Pattern data - $00 marks the end of a pattern ***
.pat0
         DEFB $BD,0
         DEFB 152
         DEFB 140
     DEFB 6
         DEFB 157
         DEFB 140
     DEFB 6
         DEFB 159
         DEFB 188
     DEFB 6
         DEFB 152
         DEFB 140
     DEFB 6
         DEFB 157
     DEFB 6
         DEFB 159
     DEFB 6
         DEFB 152
     DEFB 6
         DEFB 159
     DEFB 6
         DEFB 151
         DEFB 139
     DEFB 6
         DEFB 157
         DEFB 139
     DEFB 6
         DEFB 159
         DEFB 188
     DEFB 6
         DEFB 151
         DEFB 139
     DEFB 6
         DEFB 157
     DEFB 6
         DEFB 159
     DEFB 6
         DEFB 151
     DEFB 6
         DEFB 159
     DEFB 6
         DEFB $00
.pat1
         DEFB $BD,0
         DEFB 150
         DEFB 138
     DEFB 6
         DEFB 157
         DEFB 138
     DEFB 6
         DEFB 159
         DEFB 188
     DEFB 6
         DEFB 150
         DEFB 138
     DEFB 6
         DEFB 157
     DEFB 6
         DEFB 159
     DEFB 6
         DEFB 150
     DEFB 6
         DEFB 159
     DEFB 6
         DEFB 149
         DEFB 137
     DEFB 6
         DEFB 159
         DEFB 137
     DEFB 6
         DEFB 157
         DEFB 188
     DEFB 6
         DEFB 149
         DEFB 137
     DEFB 6
         DEFB 159
     DEFB 6
         DEFB 157
         DEFB 145
     DEFB 6
         DEFB 149
     DEFB 6
         DEFB 159
     DEFB 6
         DEFB $00
.pat2
         DEFB $BD,2
         DEFB 140
         DEFB 152
     DEFB 24
         DEFB 140
     DEFB 6
         DEFB 141
     DEFB 6
         DEFB 140
     DEFB 12
         DEFB 139
         DEFB 163
     DEFB 24
         DEFB 139
     DEFB 6
         DEFB 140
     DEFB 6
         DEFB 139
     DEFB 12
         DEFB $00
.pat3
         DEFB 138
         DEFB 150
     DEFB 24
         DEFB 138
     DEFB 6
         DEFB 139
     DEFB 6
         DEFB 138
     DEFB 12
         DEFB 137
         DEFB 161
     DEFB 30
         DEFB 133
         DEFB 145
     DEFB 18
         DEFB $00

#endasm