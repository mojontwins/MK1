; temp.asm
; Automaticly generated using build_mus_bin.exe by The Mojon Twins
 
org #C000

arkos:
    include "arkos_player_zx.asm"

song_pool:

SONG_0:
    ; Address is 0xC759
    incbin 00_title.aks.bin

SONG_1:
    ; Address is 0xCE4B
    incbin 01_ending_intro.aks.bin

SONG_2:
    ; Address is 0xCF5E
    incbin 02_ingameA.aks.bin

SONG_3:
    ; Address is 0xD659
    incbin 03_ingameB.aks.bin

SONG_4:
    ; Address is 0xD9D7
    incbin 04_gameover.aks.bin

SFXS_SONG:
SONG_5:
    ; Address is 0xDAB2
    incbin sfx.aks.bin

song_list:
    defw SONG_0, SONG_1, SONG_2, SONG_3, SONG_4, SONG_5

