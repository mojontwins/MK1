; ---------------------------------------------------------------------------
; Reproductor de musicas del Arkos tracker + Canciones + SFXs
; ---------------------------------------------------------------------------

; ---------------------------------------------------------------------------
	ORG #C000		; Para la churrera

inicio_arkos_player
    include "arkos_player_zx.asm"
fin_arkos_player

; ---------------------------------------------------------------------------
; Canciones usadas en el proyecto
;
; Como las canciones van a estar a continuación del reproductor 
; de música nos tocará hacer un poco de trabajo manual, pero solo
; será una sola vez ó al menos cada vez que modifiquemos una canción. 
;
; Esto es debido a que las canciones se compilan para ir una 
; cierta dirección, empezando por fin_arkos_player, que como 
; podemos ver en musicas.lst es 0xC759.
;
; Para ello primero convertimos las canciones (.AKS) a binario usando 
; la herramienta AKStoBIN. Tal que así (usa compila_canciones.bat):
; akstobin.exe cancion_0x.aks 
;
; Una vez tenemos todos los ficheros binarios, ensamblamos este fichero con:
; pasmo musicas.asm musicas.bin musicas.lst ó compilamos el proyecto con make.bat
;
; Ahora miramos el fichero musicas.lst y veremos las direcciones de memoria
; donde iran las canciones. En este ejemplo:
; cancion_00	EQU 0C761H
; cancion_01	EQU 0CF3AH
; cancion_02	EQU 0D431H
; cancion_03	EQU 0D4E3H
; Estas son las direcciones definitivas de las canciones y a esas direcciones
; es donde vamos a compilarlas. Para ello volvemos a nuestra utilidad AKStoBIN
; y las compilamos una a una tal que así (ó editamos el compila_canciones.bat):
; akstobin.exe -a 0xc761 cancion_00.aks 
; akstobin.exe -a 0xcf3a cancion_01.aks 
; ...
;
; Ahora solo tendremos que poner las direcciones definitivas tanto de 
; lista_canciones, como de lista_sfxs en el arkos_player.h y recompilar
; el proyecto para poder disfrutar del juego con las canciones.
; 
; TODO: Hacer una script en python para automatizarlo.
; ---------------------------------------------------------------------------

; ---------------------------------------------------------------------------
; Lista de canciones
lista_canciones
    DEFW cancion_00,cancion_01,cancion_02,cancion_03, cancion_04, cancion_05, cancion_06
    
cancion_00
    INCBIN 'cancion_00.bin'

cancion_01
    INCBIN 'cancion_01.bin'

cancion_02
    INCBIN 'cancion_02.bin'

cancion_03
    INCBIN 'cancion_03.bin'
cancion_04
    INCBIN 'cancion_04.bin'
cancion_05
    INCBIN 'cancion_05.bin'
cancion_06
    INCBIN 'cancion_06.bin'
; ...

;cancion_99
;    INCBIN 'cancion_99.bin'

; ---------------------------------------------------------------------------
; Lista de efectos de sonido
lista_sfxs
    DEFW sfx_00,sfx_01,sfx_02,sfx_03,sfx_04
    DEFW sfx_05,sfx_06,sfx_07,sfx_08,sfx_09
    
; ---------------------------------------------------------------------------
; 0 -> Chat de Texto 
sfx_00
    LD   A,0        ; Número de canal (0-2)
    LD   L,1        ; Número de SFX (> 0)
    LD   H,15       ; Volumen (0 - 15)
    LD   E,59       ; Nota (0-143)
	LD   D,0        ; Velocidad (0 = Original, 1 - 255 = Nueva | 1 la más rápida)
    LD   BC,0    	; Inversión de tono (-65536 - 65535 | 0 es sin modificaciones
                    ; A valores más altos, más bajo el sonido)
    JP   atSfxPlay

; ---------------------------------------------------------------------------
; 1 -> Salto
sfx_01
    LD   A,0        ; Número de canal (0-2)
    LD   L,2        ; Número de SFX (> 0)
    LD   H,15       ; Volumen (0 - 15)
    LD   E,43       ; Nota (0-143)
	LD   D,0        ; Velocidad (0 = Original, 1 - 255 = Nueva | 1 la más rápida)
    LD   BC,0       ; Inversión de tono (-65536 - 65535 | 0 es sin modificaciones
                    ; A valores más altos, más bajo el sonido)
    JP   atSfxPlay

; ---------------------------------------------------------------------------
; 2 -> Click, el de cambiar el inventario
sfx_02
    LD   A,0        ; Número de canal (0-2)
    LD   L,3        ; Número de SFX (> 0)
    LD   H,15       ; Volumen (0 - 15)
    LD   E,50       ; Nota (0-143)
	LD   D,0        ; Velocidad (0 = Original, 1 - 255 = Nueva | 1 la más rápida)
    LD   BC,0       ; Inversión de tono (-65536 - 65535 | 0 es sin modificaciones
                    ; A valores más altos, más bajo el sonido)
    JP   atSfxPlay

; ---------------------------------------------------------------------------
; 3 -> Parecido al 1, éxito al conseguir algo Exit
sfx_03
    LD   A,2        ; Número de canal (0-2)
    LD   L,4        ; Número de SFX (> 0)
    LD   H,15       ; Volumen (0 - 15)
    LD   E,45       ; Nota (0-143)
	LD   D,0        ; Velocidad (0 = Original, 1 - 255 = Nueva | 1 la más rápida)
    LD   BC,0       ; Inversión de tono (-65536 - 65535 | 0 es sin modificaciones
                    ; A valores más altos, más bajo el sonido)
    JP   atSfxPlay

; ---------------------------------------------------------------------------
; 4 -> Coger bellota
sfx_04
    LD   A,2        ; Número de canal (0-2)
    LD   L,5        ; Número de SFX (> 0)
    LD   H,15       ; Volumen (0 - 15)
    LD   E,50       ; Nota (0-143)
	LD   D,0        ; Velocidad (0 = Original, 1 - 255 = Nueva | 1 la más rápida)
    LD   BC,0       ; Inversión de tono (-65536 - 65535 | 0 es sin modificaciones
                    ; A valores más altos, más bajo el sonido)
    JP   atSfxPlay

; ---------------------------------------------------------------------------
; 5 -> Sonido de hacer algo
sfx_05
    LD   A,0        ; Número de canal (0-2)
    LD   L,6        ; Número de SFX (> 0)
    LD   H,15       ; Volumen (0 - 15)
    LD   E,45       ; Nota (0-143)
	LD   D,0        ; Velocidad (0 = Original, 1 - 255 = Nueva | 1 la más rápida)
    LD   BC,0       ; Inversión de tono (-65536 - 65535 | 0 es sin modificaciones
                    ; A valores más altos, más bajo el sonido)
    JP   atSfxPlay

; ---------------------------------------------------------------------------
; 6 -> Sonido corto, como el de tocar, pero mas grave
sfx_06
    LD   A,0        ; Número de canal (0-2)
    LD   L,7        ; Número de SFX (> 0)
    LD   H,15       ; Volumen (0 - 15)
    LD   E,33       ; Nota (0-143)
	LD   D,0        ; Velocidad (0 = Original, 1 - 255 = Nueva | 1 la más rápida)
    LD   BC,0       ; Inversión de tono (-65536 - 65535 | 0 es sin modificaciones
                    ; A valores más altos, más bajo el sonido)
    JP   atSfxPlay

; ---------------------------------------------------------------------------
; 7 -> Sonido de daño
sfx_07
    LD   A,0        ; Número de canal (0-2)
    LD   L,8        ; Número de SFX (> 0)
    LD   H,15       ; Volumen (0 - 15)
    LD   E,54       ; Nota (0-143)
	LD   D,0        ; Velocidad (0 = Original, 1 - 255 = Nueva | 1 la más rápida)
    LD   BC,0       ; Inversión de tono (-65536 - 65535 | 0 es sin modificaciones
                    ; A valores más altos, más bajo el sonido)
    JP   atSfxPlay

; ---------------------------------------------------------------------------
; 8 -> Explosión (para el petardazo) 
sfx_08
    LD   A,0        ; Número de canal (0-2)
    LD   L,9        ; Número de SFX (> 0)
    LD   H,15       ; Volumen (0 - 15)
    LD   E,45       ; Nota (0-143)
	LD   D,0        ; Velocidad (0 = Original, 1 - 255 = Nueva | 1 la más rápida)
    LD   BC,0       ; Inversión de tono (-65536 - 65535 | 0 es sin modificaciones
                    ; A valores más altos, más bajo el sonido)
    JP   atSfxPlay

; ---------------------------------------------------------------------------
; 9 -> Sonido de extender puente/Mismo sonido para cuando surge un templo submarino.
sfx_09
    LD   A,0        ; Número de canal (0-2)
    LD   L,10       ; Número de SFX (> 0)
    LD   H,15       ; Volumen (0 - 15)
    LD   E,21      ; Nota (0-143)
	LD   D,0        ; Velocidad (0 = Original, 1 - 255 = Nueva | 1 la más rápida)
    LD   BC,0       ; Inversión de tono (-65536 - 65535 | 0 es sin modificaciones
                    ; A valores más altos, más bajo el sonido)
    JP   atSfxPlay

; ---------------------------------------------------------------------------
    END
