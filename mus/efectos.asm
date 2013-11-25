; [0] Caída del salto
EFECTO0:		DB 	$51,$1A
				DB 	$E8,$1B
				DB 	$80,$2B
				DB 	$FF   
				
; [1] Quitar vida
EFECTO1:		DB 	$25,$1C
				DB 	$30,$2E
				DB	$00,$00
				DB	$A8,$0A
				DB	$C5,$1A
				DB	$00,$00
				DB	$37,$1C
				DB	$C5,$1C
				DB	$00,$00
				DB	$25,$18
				DB	$30,$26
				DB	$FF
				
; [2] Arrastrar en cinta
EFECTO2:		DB	$80,$2E,$00
				DB	$00,$0A,$04
				DB	$FF	
				
; [3] Coger tesoro
EFECTO3:		DB	$1F,$0B
				DB	$1A,$0C
				DB	$1F,$0D
				DB	$16,$0E
				DB	$1F,$0E
				DB	$0D,$0D
				DB	$1F,$0C
				DB	$0D,$0B
				DB	$00,$00
				DB	$00,$00
				DB	$1F,$08
				DB	$1A,$09
				DB	$1F,$0A
				DB	$16,$0B
				DB	$1F,$0B
				DB	$0D,$0A
				DB	$1F,$09
				DB	$0D,$07
				DB	$00,$00
				DB	$00,$00
				DB	$1F,$06
				DB	$1A,$07
				DB	$1F,$08
				DB	$16,$08
				DB	$1F,$07
				DB	$0D,$06
				DB	$1F,$05
				DB	$FF
	
; [4] ?
EFECTO4:		DB	$00,$0C,$03
				DB	$FF
				
; [5] Coger vida
EFECTO5:		DB	$1A,$0E
				DB	$1A,$0E
				DB	$00,$00
				DB	$1A,$0A
				DB	$1A,$0A
				DB	$00,$00
				DB	$1A,$0C
				DB	$1A,$0C
				DB	$00,$00
				DB	$1A,$08
				DB	$1A,$08
				DB	$FF
				
; [6] ?
EFECTO6:		DB 	$E8,$1B
				DB 	$80,$2B
				DB	$FF	
				
; [7] Salto largo
EFECTO7:		DB	$C3,$0E
				DB	$CC,$0D
				DB	$D5,$0A
				DB	$DE,$06
				DB	$35,$03
				DB	$50,$0B
				DB	$47,$0C
				DB	$3E,$08
				DB	$FF
				
; [8] Salto alto
EFECTO8:		DB	$58,$0D
				DB	$50,$0B
				DB	$47,$0A
				DB	$3E,$06
				DB	$35,$03
				DB	$50,$09
				DB	$47,$0A
				DB	$3E,$07
				DB	$FF
				