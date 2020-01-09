// msc.h
// Generado por Mojon Script Compiler de la Churrera
// Copyleft 2011 The Mojon Twins
 
// Script data & pointers
 
unsigned char *e_scripts [] = {
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
};
 
unsigned char *f_scripts [] = {
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
};
 
#asm
#endasm
 
unsigned char *script;
 
void msc_init_all (void) {
    unsigned char i;
    for (i = 0; i < MAX_FLAGS; i ++)
        flags [i] = 0;
}
 
unsigned char read_byte (void) {
    unsigned char c;
    c = script [0];
    script ++;
    return c;
}
 
unsigned char read_vbyte (void) {
    unsigned char c;
    c = read_byte ();
    if (c & 128) return flags [c & 127];
    return c;
}
 
// Ejecutamos el script apuntado por *script:
void run_script (void) {
    unsigned char terminado = 0;
    unsigned char continuar = 0;
    unsigned char x, y, n, m, c;
    unsigned char *next_script;
 
    if (script == 0)
        return; 
 
    script_something_done = 0;
 
    while (1) {
        c = read_byte ();
        if (c == 0xFF) break;
        next_script = script + c;
        terminado = continuar = 0;
        while (!terminado) {
            c = read_byte ();
            switch (c) {
                case 0xFF:
                    // THEN
                    // Opcode: FF
                    terminado = 1;
                    continuar = 1;
                    script_something_done = 1;
                    break;
            }
        }
        if (continuar) {
            terminado = 0;
            while (!terminado) {
                c = read_byte ();
                switch (c) {
                    case 0xFF:
                        terminado = 1;
                        break;
                }
            }
        }
        script = next_script;
    }
    if (script_result == 3) {
        script_result = 0;
        draw_scr ();
    }
}
