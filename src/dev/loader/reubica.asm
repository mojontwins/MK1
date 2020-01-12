; Reubicador by Benway

org 25000
memoria_a_cambiar defb 0
org 25002

ld a, (memoria_a_cambiar)
ld b, a

ld A, (#5B5C)   ; en 5B5C está la página de memoria actual
and #F8
or b
ld (#5B5C), A   ; hay que preservarla, o el BASIC se vuelve loco



ld BC, #7FFD
out (C), A



ld hl, 32768
ld de, 49152
ld bc, 16384   
ldir      ; copiamos 16k desde 32768 hasta 49152 (en la página correcta)

; aqui vuelves a la 0


ld A, (#5B5C)
and #F8
ld (#5B5C), A

ld BC, #7FFD
out (C), A

ret