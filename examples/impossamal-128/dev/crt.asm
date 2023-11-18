    MODULE  zx82_crt0
    INCLUDE "zcc_opt.def"
    XREF    _main           ; main() is always external to crt0 code

    IF !STACKPTR
        defc STACKPTR = $FFFF
    ENDIF
            
    IF !CRT_ORG_CODE
        defc CRT_ORG_CODE  = 32768
    ENDIF

    org CRT_ORG_CODE

start:
    ld sp,STACKPTR
    jp _main 
