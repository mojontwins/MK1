// msc-config.h
// Generated by Mojon Script Compiler v3.97 20191202 from MT Engine MK1 v5.10+
// Copyleft 2014, 2019 The Mojon Twins

unsigned char sc_x, sc_y, sc_n, sc_m, sc_c;
unsigned char script_result = 0;
unsigned char sc_terminado = 0;
unsigned char sc_continuar = 0;
unsigned int main_script_offset;
#ifndef MODE_128K
extern unsigned char main_script [0];
#asm
    ._main_script
        BINARY "scripts.bin"
#endasm
#endif
unsigned char warp_to_level;
extern unsigned char *script;
#asm
    ._script defw 0
#endasm

