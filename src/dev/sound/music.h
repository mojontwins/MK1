// mte mk1 (la churrera) v5.10
// copyleft 2010-2014, 2020-2023 by the mojon twins

#asm
; *****************************************************************************
; * phaser1 engine, with synthesised drums
; *
; * original code by shiru - .http//shiru.untergrund.net/
; * modified by chris cowley
; *
; * produced by beepola v1.05.01
; ******************************************************************************
 
.musicstart
             ld    hl,musicdata         ;  <- pointer to music data. change
                                        ;     this to play a different song
             ld   a,(hl)                         ; get the loop start pointer
             ld   (pattern_loop_begin),a
             inc  hl
             ld   a,(hl)                         ; get the song end pointer
             ld   (pattern_loop_end),a
             inc  hl
             ld   e,(hl)
             inc  hl
             ld   d,(hl)
             inc  hl
             ld   (instrum_tbl),hl
             ld   (current_inst),hl
             add  hl,de
             ld   (pattern_addr),hl
             xor  a
             ld   (pattern_ptr),a                ; set the pattern pointer to zero
             ld   h,a
             ld   l,a
             ld   (note_ptr),hl                  ; set the note offset (within this pattern) to 0

.player
             ;di
             push iy
             ;ld   a,border_col
             xor a
             ld   h,$00
             ld   l,a
             ld   (cnt_1a),hl
             ld   (cnt_1b),hl
             ld   (div_1a),hl
             ld   (div_1b),hl
             ld   (cnt_2),hl
             ld   (div_2),hl
             ld   (out_1),a
             ld   (out_2),a
             jr   main_loop

; ********************************************************************************************************
; * next_pattern
; *
; * select the next pattern in sequence (and handle looping if weve reached pattern_loop_end
; * execution falls through to playnote to play the first note from our next pattern
; ********************************************************************************************************
.next_pattern
                          ld   a,(pattern_ptr)
                          inc  a
                          inc  a
                          defb $fe                           ; cp n
.pattern_loop_end         defb 0
                          jr   nz,no_pattern_loop
                          ; handle pattern looping at and of song
                          defb $3e                           ; ld a,n
.pattern_loop_begin       defb 0
.no_pattern_loop          ld   (pattern_ptr),a
                          ld   hl,$0000
                          ld   (note_ptr),hl   ; start of pattern (note_ptr = 0)

.main_loop
             ld   iyl,0                        ; set channel = 0

.read_loop
             ld   hl,(pattern_addr)
             ld   a,(pattern_ptr)
             ld   e,a
             ld   d,0
             add  hl,de
             ld   e,(hl)
             inc  hl
             ld   d,(hl)                       ; now de = start of pattern data
             ld   hl,(note_ptr)
             inc  hl                           ; increment the note pointer and...
             ld   (note_ptr),hl                ; ..store it
             dec  hl
             add  hl,de                        ; now hl = address of note data
             ld   a,(hl)
             or   a
             jr   z,next_pattern               ; select next pattern

             bit  7,a
             jp   z,render                     ; play the currently defined note(s) and drum
             ld   iyh,a
             and  $3f
             cp   $3c
             jp   nc,other                     ; other parameters
             add  a,a
             ld   b,0
             ld   c,a
             ld   hl,freq_table
             add  hl,bc
             ld   e,(hl)
             inc  hl
             ld   d,(hl)
             ld   a,iyl                        ; iyl = 0 for channel 1, or = 1 for channel 2
             or   a
             jr   nz,set_note2
             ld   (div_1a),de
             ex   de,hl

             defb $dd,$21                      ; ld ix,nn
.current_inst
             defw $0000

             ld   a,(ix+$00)
             or   a
             jr   z,l809b                      ; original code jumps into byte 2 of the djnz (invalid opcode fd)
             ld   b,a
.l8098       add  hl,hl
             djnz l8098
.l809b       ld   e,(ix+$01)
             ld   d,(ix+$02)
             add  hl,de
             ld   (div_1b),hl
             ld   iyl,1                        ; set channel = 1
             ld   a,iyh
             and  $40
             jr   z,read_loop                  ; no phase reset

             ld   hl,out_1                     ; reset phaser
             res  4,(hl)
             ld   hl,$0000
             ld   (cnt_1a),hl
             ld   h,(ix+$03)
             ld   (cnt_1b),hl
             jr   read_loop

.set_note2
             ld   (div_2),de
             ld   a,iyh
             ld   hl,out_2
             res  4,(hl)
             ld   hl,$0000
             ld   (cnt_2),hl
             jp   read_loop

.set_stop
             ld   hl,$0000
             ld   a,iyl
             or   a
             jr   nz,set_stop2
             ; stop channel 1 note
             ld   (div_1a),hl
             ld   (div_1b),hl
             ld   hl,out_1
             res  4,(hl)
             ld   iyl,1
             jp   read_loop
.set_stop2
             ; stop channel 2 note
             ld   (div_2),hl
             ld   hl,out_2
             res  4,(hl)
             jp   read_loop

.other       cp   $3c
             jr   z,set_stop                   ; stop note
             cp   $3e
             jr   z,skip_ch1                   ; no changes to channel 1
             inc  hl                           ; instrument change
             ld   l,(hl)
             ld   h,$00
             add  hl,hl
             ld   de,(note_ptr)
             inc  de
             ld   (note_ptr),de                ; increment the note pointer

             defb $01                          ; ld bc,nn
.instrum_tbl
             defw $0000

             add  hl,bc
             ld   (current_inst),hl
             jp   read_loop

.skip_ch1
             ld   iyl,$01
             jp   read_loop

.exit_player
             ld   hl,$2758
             exx
             pop  iy
             ;ei
             ret

.render
             and  $7f                          ; l813a
             cp   $76
             jp   nc,drums
             ld   d,a
             exx
             defb $21                          ; ld hl,nn
.cnt_1a      defw $0000
             defb $dd,$21                      ; ld ix,nn
.cnt_1b      defw $0000
             defb $01                          ; ld bc,nn
.div_1a      defw $0000
             defb $11                          ; ld de,nn
.div_1b      defw $0000
             defb $3e                          ; ld a,n
.out_1       defb $0
             exx
             ex   af,af ; beware!
             defb $21                          ; ld hl,nn
.cnt_2       defw $0000
             defb $01                          ; ld bc,nn
.div_2       defw $0000
             defb $3e                          ; ld a,n
.out_2       defb $00

.play_note
             ; read keyboard
             ld   e,a
             xor  a
             in   a,($fe)
             or   $e0
             inc  a

.player_wait_key
             jr   nz,exit_player
             ld   a,e
             ld   e,0

.l8168       exx
             ex   af,af ; beware!
             add  hl,bc
             out  ($fe),a
             jr   c,l8171
             jr   l8173
.l8171       xor  $10
.l8173       add  ix,de
             jr   c,l8179
             jr   l817b
.l8179       xor  $10
.l817b       ex   af,af ; beware!
             out  ($fe),a
             exx
             add  hl,bc
             jr   c,l8184
             jr   l8186
.l8184       xor  $10
.l8186       nop
             jp   l818a

.l818a       exx
             ex   af,af ; beware!
             add  hl,bc
             out  ($fe),a
             jr   c,l8193
             jr   l8195
.l8193       xor  $10
.l8195       add  ix,de
             jr   c,l819b
             jr   l819d
.l819b       xor  $10
.l819d       ex   af,af ; beware!
             out  ($fe),a
             exx
             add  hl,bc
             jr   c,l81a6
             jr   l81a8
.l81a6       xor  $10
.l81a8       nop
             jp   l81ac

.l81ac       exx
             ex   af,af ; beware!
             add  hl,bc
             out  ($fe),a
             jr   c,l81b5
             jr   l81b7
.l81b5       xor  $10
.l81b7       add  ix,de
             jr   c,l81bd
             jr   l81bf
.l81bd       xor  $10
.l81bf       ex   af,af ; beware!
             out  ($fe),a
             exx
             add  hl,bc
             jr   c,l81c8
             jr   l81ca
.l81c8       xor  $10
.l81ca       nop
             jp   l81ce

.l81ce       exx
             ex   af,af ; beware!
             add  hl,bc
             out  ($fe),a
             jr   c,l81d7
             jr   l81d9
.l81d7       xor  $10
.l81d9       add  ix,de
             jr   c,l81df
             jr   l81e1
.l81df       xor  $10
.l81e1       ex   af,af ; beware!
             out  ($fe),a
             exx
             add  hl,bc
             jr   c,l81ea
             jr   l81ec
.l81ea       xor  $10

.l81ec       dec  e
             jp   nz,l8168

             exx
             ex   af,af ; beware!
             add  hl,bc
             out  ($fe),a
             jr   c,l81f9
             jr   l81fb
.l81f9       xor  $10
.l81fb       add  ix,de
             jr   c,l8201
             jr   l8203
.l8201       xor  $10
.l8203       ex   af,af ; beware!
             out  ($fe),a
             exx
             add  hl,bc
             jr   c,l820c
             jr   l820e
.l820c       xor  $10

.l820e       dec  d
             jp   nz,play_note

             ld   (cnt_2),hl
             ld   (out_2),a
             exx
             ex   af,af ; beware!
             ld   (cnt_1a),hl
             ld   (cnt_1b),ix
             ld   (out_1),a
             jp   main_loop

; ************************************************************
; * drums - synthesised
; ************************************************************
.drums
             add  a,a                          ; on entry a=$75+drum number (i.e. $76 to $7e)
             ld   b,0
             ld   c,a
             ld   hl,drum_table - 236
             add  hl,bc
             ld   e,(hl)
             inc  hl
             ld   d,(hl)
             ex   de,hl
             jp   (hl)

.drum_tone1  ld   l,16
             jr   drum_tone
.drum_tone2  ld   l,12
             jr   drum_tone
.drum_tone3  ld   l,8
             jr   drum_tone
.drum_tone4  ld   l,6
             jr   drum_tone
.drum_tone5  ld   l,4
             jr   drum_tone
.drum_tone6  ld   l,2
.drum_tone
             ld   de,3700
             ld   bc,$0101
             //ld   a,border_col
             xor a
.dt_loop0    out  ($fe),a
             dec  b
             jr   nz,dt_loop1
             xor  16
             ld   b,c
             ex   af,af ; beware!
             ld   a,c
             add  a,l
             ld   c,a
             ex   af,af ; beware!
.dt_loop1    dec  e
             jr   nz,dt_loop0
             dec  d
             jr   nz,dt_loop0
             jp   main_loop

.drum_noise1 ld   de,2480
             ld   ixl,1
             jr   drum_noise
.drum_noise2 ld   de,1070
             ld   ixl,10
             jr   drum_noise
.drum_noise3 ld   de,365
             ld   ixl,101
.drum_noise
             ld   h,d
             ld   l,e
             //ld   a,border_col
             xor a
             ld   c,a
.dn_loop0    ld   a,(hl)
             and  16
             or   c
             out  ($fe),a
             ld   b,ixl
.dn_loop1    djnz dn_loop1
             inc  hl
             dec  e
             jr   nz,dn_loop0
             dec  d
             jr   nz,dn_loop0
             jp   main_loop

.pattern_addr   defw  $0000
.pattern_ptr    defb  0
.note_ptr       defw  $0000

; **************************************************************
; * frequency table
; **************************************************************
.freq_table
             defw 178,189,200,212,225,238,252,267,283,300,318,337
             defw 357,378,401,425,450,477,505,535,567,601,637,675
             defw 715,757,802,850,901,954,1011,1071,1135,1202,1274,1350
             defw 1430,1515,1605,1701,1802,1909,2023,2143,2270,2405,2548,2700
             defw 2860,3030,3211,3402,3604,3818,4046,4286,4541,4811,5097,5400

; *****************************************************************
; * synth drum lookup table
; *****************************************************************
.drum_table
             defw drum_tone1,drum_tone2,drum_tone3,drum_tone4,drum_tone5,drum_tone6
             defw drum_noise1,drum_noise2,drum_noise3


.musicdata
             defb 0  ; pattern loop begin * 2
             defb 16  ; song length * 2
             defw 8         ; offset to start of song (length of instrument table)
             defb 1      ; multiple
             defw 10      ; detune
             defb 0      ; phase
             defb 1      ; multiple
             defw 5      ; detune
             defb 1      ; phase

.patterndata
                    defw      pat0
                    defw      pat1
                    defw      pat0
                    defw      pat1
                    defw      pat2
                    defw      pat3
                    defw      pat2
                    defw      pat3

; *** pattern data - $00 marks the end of a pattern ***
.pat0
         defb $bd,0
         defb 152
         defb 140
     defb 6
         defb 157
         defb 140
     defb 6
         defb 159
         defb 188
     defb 6
         defb 152
         defb 140
     defb 6
         defb 157
     defb 6
         defb 159
     defb 6
         defb 152
     defb 6
         defb 159
     defb 6
         defb 151
         defb 139
     defb 6
         defb 157
         defb 139
     defb 6
         defb 159
         defb 188
     defb 6
         defb 151
         defb 139
     defb 6
         defb 157
     defb 6
         defb 159
     defb 6
         defb 151
     defb 6
         defb 159
     defb 6
         defb $00
.pat1
         defb $bd,0
         defb 150
         defb 138
     defb 6
         defb 157
         defb 138
     defb 6
         defb 159
         defb 188
     defb 6
         defb 150
         defb 138
     defb 6
         defb 157
     defb 6
         defb 159
     defb 6
         defb 150
     defb 6
         defb 159
     defb 6
         defb 149
         defb 137
     defb 6
         defb 159
         defb 137
     defb 6
         defb 157
         defb 188
     defb 6
         defb 149
         defb 137
     defb 6
         defb 159
     defb 6
         defb 157
         defb 145
     defb 6
         defb 149
     defb 6
         defb 159
     defb 6
         defb $00
.pat2
         defb $bd,2
         defb 140
         defb 152
     defb 24
         defb 140
     defb 6
         defb 141
     defb 6
         defb 140
     defb 12
         defb 139
         defb 163
     defb 24
         defb 139
     defb 6
         defb 140
     defb 6
         defb 139
     defb 12
         defb $00
.pat3
         defb 138
         defb 150
     defb 24
         defb 138
     defb 6
         defb 139
     defb 6
         defb 138
     defb 12
         defb 137
         defb 161
     defb 30
         defb 133
         defb 145
     defb 18
         defb $00

#endasm