; temp.asm
; Automaticly generated using build_mus_bin.exe by The Mojon Twins
 
org #C000

arkos:
    include "arkos_player_zx.asm"

song_pool:

SONG_0:
    ; Address is 0xC759
    incbin Cancion_00.aks.bin

SONG_1:
    ; Address is 0xC9F1
    incbin Cancion_01.aks.bin

SONG_2:
    ; Address is 0xCCBE
    incbin Cancion_02.aks.bin

SONG_3:
    ; Address is 0xCF5B
    incbin Cancion_03.aks.bin

SFXS_SONG:
SONG_4:
    ; Address is 0xD10C
    incbin sfx.aks.bin

song_list:
    defw SONG_0, SONG_1, SONG_2, SONG_3, SONG_4

