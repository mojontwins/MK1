; [0] Select
EFECTO0:		DB $51, $1A, $00
				DB $5A, $0F, $00
				DB $3C, $0F, $00
				DB $1E, $0E, $00
				DB $2D, $0E, $00
				DB $5A, $0B, $00
				DB $3C, $0B, $00
				DB $1E, $0A, $00
				DB $2D, $0A, $00
				DB $B4, $01, $00
				DB	$FF
				
; [1] Start
EFECTO1:		DB $25, $1C, $00
				DB $3A, $0F, $00
				DB $2D, $0F, $00
				DB $E2, $0F, $00
				DB $BC, $0F, $00
				DB $96, $0D, $00
				DB $4B, $0D, $00
				DB $32, $0D, $00
				DB $3A, $0D, $00
				DB $2D, $0D, $00
				DB $E2, $0D, $00
				DB $BC, $0D, $00
				DB $96, $0D, $00
				DB $4B, $0D, $00
				DB $32, $0D, $00
				DB $3A, $0D, $00
				DB $2D, $0C, $00
				DB $E2, $0C, $00
				DB $BC, $0C, $00
				DB $96, $0B, $00
				DB $4B, $0B, $00
				DB $32, $0B, $00
				DB $3A, $0B, $00
				DB $2D, $0B, $00
				DB $E2, $0B, $00
				DB $BC, $0B, $00
				DB $96, $0B, $00
				DB $4B, $0A, $00
				DB $32, $0A, $00
				DB $3A, $0A, $00
				DB $2D, $09, $00
				DB $E2, $09, $00
				DB $BC, $08, $00
				DB $96, $08, $00
				DB $4B, $08, $00
				DB $32, $07, $00
				DB $3A, $07, $00
				DB $2D, $06, $00
				DB $E2, $06, $00
				DB $BC, $06, $00
				DB $96, $05, $00
				DB $4B, $05, $00
				DB $32, $05, $00
				DB $3A, $04, $00
				DB $2D, $04, $00
				DB $E2, $03, $00
				DB $BC, $03, $00
				DB $96, $03, $00
				DB $4B, $03, $00
				DB $32, $02, $00
				DB $3A, $01, $00
				DB $2D, $01, $00
				DB $E2, $01, $00
				DB $BC, $01, $00
				DB	$FF
				
; [2] Sartar
EFECTO2:		DB $E8, $1B, $00
				DB $B4, $0F, $00
				DB $A0, $0E, $00
				DB $90, $0D, $00
				DB $87, $0D, $00
				DB $78, $0C, $00	
				DB $6C, $0B, $00	
				DB $60, $0A, $00	
				DB $5A, $09, $00
				DB	$FF	
				
; [3] Disparo 1
EFECTO3:		DB $1F, $0B, $00
				DB $5A, $0F, $00
				DB $3C, $0F, $00
				DB $1E, $0A, $00
				DB $2D, $0A, $00
				DB $5A, $05, $00
				DB $3C, $05, $00
				DB $1E, $04, $00
				DB $2D, $02, $00
				DB $B4, $01, $00
				DB	$FF
	
; [4] Disparo 2
EFECTO4:		DB $1F, $0B, $00
				DB $AF, $0F, $00
				DB $8A, $0F, $00
				DB $71, $0F, $00
				DB $64, $0F, $00
				DB $3E, $0C, $00
				DB $25, $0C, $00
				DB $25, $0C, $00
				DB $25, $0C, $00
				DB $25, $0A, $00
				DB $4B, $0A, $00
				DB $4B, $0A, $00
				DB $4B, $0A, $00
				DB $3E, $08, $00
				DB $3E, $08, $00
				DB $3E, $08, $00
				DB $71, $08, $00
				DB $3E, $07, $00
				DB $25, $05, $00
				DB $25, $02, $00
				DB	$FF
				
; [5] Vida
EFECTO5:		DB $1A, $0E, $00
				DB $B4, $0E, $00
				DB $B4, $0E, $00
				DB $B4, $0E, $00
				DB $B4, $0E, $00
				DB $B4, $0E, $00
				DB $B4, $0E, $00
				DB $B4, $0E, $00
				DB $B4, $0E, $00	
				DB $A0, $0E, $00
				DB $A0, $0E, $00
				DB $A0, $0E, $00
				DB $A0, $0E, $00
				DB $A0, $0E, $00
				DB $A0, $0E, $00
				DB $A0, $0E, $00
				DB $87, $0E, $00
				DB $87, $0E, $00
				DB $87, $0E, $00
				DB $87, $0E, $00
				DB $87, $0E, $00
				DB $87, $0E, $00
				DB $87, $0E, $00
				DB $87, $0E, $00
				DB $87, $0E, $00		
				DB $78, $0E, $00
				DB $78, $0E, $00
				DB $78, $0D, $00
				DB $78, $0D, $00
				DB $78, $0D, $00
				DB $78, $0D, $00
				DB $78, $0D, $00
				DB $78, $0D, $00
				DB $78, $0C, $00
				DB $78, $09, $00
				DB $78, $06, $00
				DB $78, $05, $00	
				DB	$FF
				
; [6] Daño Colision Disparo
EFECTO6:		DB $E8, $1B, $00
				DB $5F, $0F, $00
				DB $E2, $0F, $00
				DB $56, $0F, $00
				DB $F6, $0F, $00
				DB $14, $0E, $00
				DB $64, $0E, $00	
				DB $62, $0D, $00
				DB $D0, $0D, $00
				DB $F1, $0C, $00
				DB	$FF	
				
; [7] Daño Colisión Enemigo
EFECTO7:		DB $C3, $0E, $00
				DB $5F, $0F, $00
				DB $A6, $0F, $00
				DB $E8, $1B, $00
				DB $80, $2B, $00
				DB	$FF
				
; [8] Puncho
EFECTO8:		DB $E8, $1B, $00
				DB $5F, $0F, $00
				DB $A6, $0F, $00
				DB $00, $00, $00
				DB $80, $0F, $00
				DB	$FF	
