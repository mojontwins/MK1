// msc.h
// Generado por Mojon Script Compiler de la Churrera
// Copyleft 2011 The Mojon Twins
 
// Script data & pointers
extern unsigned char mscce_0 [];
extern unsigned char mscce_1 [];
extern unsigned char mscce_2 [];
extern unsigned char mscce_3 [];
extern unsigned char mscce_4 [];
extern unsigned char mscce_5 [];
extern unsigned char mscce_6 [];
extern unsigned char msccf_0 [];
 
unsigned char *e_scripts [] = {
    mscce_4, mscce_3, mscce_2, 0, 0, 0, mscce_5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, mscce_6, 0, 0, 0, 0, 0, mscce_0, mscce_1
};
 
unsigned char *f_scripts [] = {
    msccf_0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
};
 
#asm
._mscce_0

    defb 0x09, 0xF0, 0xFF, 0x01, 0x01, 0x00, 0x01, 0x03, 0x00, 0xFF, 0xFF

._mscce_1

    defb 0x16, 0x31, 0x14, 0x10, 0x03, 0x00, 0xFF, 0x01, 0x03, 0x01, 0xE0, 0x07, 0xE0, 0x08, 0xE0, 0x09
    defb 0xE0, 0x07, 0xE0, 0x08, 0xE0, 0x09, 0xFF, 0xFF

._mscce_2

    defb 0x09, 0x10, 0x03, 0x01, 0xFF, 0x20, 0x0C, 0x07, 0x00, 0xFF, 0xFF

._mscce_3

    defb 0x1F, 0xF0, 0xFF, 0x20, 0x07, 0x02, 0x18, 0x20, 0x08, 0x02, 0x19, 0x20, 0x09, 0x02, 0x1A, 0x20
    defb 0x01, 0x06, 0x20, 0x20, 0x01, 0x07, 0x21, 0x20, 0x0D, 0x06, 0x20, 0x20, 0x0D, 0x07, 0x20, 0xFF
    defb 0xFF

._mscce_4

    defb 0x47, 0xF0, 0xFF, 0x20, 0x03, 0x07, 0x16, 0x20, 0x04, 0x07, 0x17, 0x20, 0x01, 0x05, 0x1D, 0x20
    defb 0x01, 0x06, 0x14, 0x20, 0x01, 0x07, 0x15, 0x20, 0x06, 0x06, 0x14, 0x20, 0x06, 0x07, 0x15, 0x20
    defb 0x07, 0x07, 0x1C, 0x20, 0x01, 0x02, 0x1B, 0x20, 0x01, 0x03, 0x1C, 0x20, 0x02, 0x02, 0x1D, 0x20
    defb 0x02, 0x03, 0x1B, 0x20, 0x03, 0x02, 0x20, 0x20, 0x03, 0x03, 0x21, 0x20, 0x09, 0x01, 0x1E, 0x20
    defb 0x09, 0x02, 0x1E, 0x20, 0x09, 0x03, 0x1F, 0xFF, 0xFF

._mscce_5

    defb 0x0F, 0xF0, 0xFF, 0x20, 0x0A, 0x01, 0x1E, 0x20, 0x0A, 0x02, 0x1F, 0x20, 0x0A, 0x04, 0x23, 0xFF
    defb 0xFF

._mscce_6

    defb 0x07, 0xF0, 0xFF, 0x20, 0x04, 0x08, 0x22, 0xFF, 0xFF

._msccf_0

    defb 0x10, 0x21, 0x30, 0x4F, 0x22, 0x70, 0x7F, 0x40, 0xFF, 0x10, 0x01, 0x01, 0x41, 0x01, 0xE0, 0x07
    defb 0xFF, 0x0C, 0x21, 0x30, 0x4F, 0x22, 0x70, 0x7F, 0x10, 0x01, 0x0A, 0xFF, 0xF1, 0xFF, 0xFF

#endasm
 
unsigned char *script;
 
void msc_init_all () {
    unsigned char i;
    for (i = 0; i < MAX_FLAGS; i ++)
        flags [i] = 0;
}
 
unsigned char read_byte () {
    unsigned char c;
    c = script [0];
    script ++;
    return c;
}
 
unsigned char read_vbyte () {
    unsigned char c;
    c = read_byte ();
    if (c & 128) return flags [c & 127];
    return c;
}
 
// Ejecutamos el script apuntado por *script:
unsigned char run_script () {
    unsigned char res = 0;
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
                case 0x10:
                    // IF FLAG x = n
                    // Opcode: 10 x n
                    x = read_vbyte ();
                    n = read_vbyte ();
                    if (flags [x] != n)
                        terminado = 1;
                    break;
                case 0x21:
                    // IF PLAYER_IN_X x1, x2
                    // Opcode: 21 x1 x2
                    x = read_byte ();
                    y = read_byte ();
                    if (!((player.x >> 6) >= x && (player.x >> 6) <= y))
                        terminado = 1;
                    break;
                case 0x22:
                    // IF PLAYER_IN_Y y1, y2
                    // Opcode: 22 y1 y2
                    x = read_byte ();
                    y = read_byte ();
                    if (!((player.y >> 6) >= x && (player.y >> 6) <= y))
                        terminado = 1;
                    break;
                case 0x31:
                    // IF ENEMIES_KILLED_EQUALS n
                    // Opcode: 31 n
                    n = read_vbyte ();
                    if (player.killed != n)
                        terminado = 1;
                    break;
                case 0x40:
                     // IF PLAYER_HAS_OBJECTS
                     // Opcode: 40
                     if (player.objs == 0)
                         terminado = 1;
                     break;
                case 0xF0:
                     // IF TRUE
                     // Opcode: F0
                     break;
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
                    case 0x01:
                        // SET FLAG x = n
                        // Opcode: 01 x n
                        x = read_vbyte ();
                        n = read_vbyte ();
                        flags [x] = n;
                        break;
                    case 0x10:
                        // INC FLAG x, n
                        // Opcode: 10 x n
                        x = read_vbyte ();
                        n = read_vbyte ();
                        flags [x] += n;
                        break;
                    case 0x20:
                        // SET TILE (x, y) = n
                        // Opcode: 20 x y n
                        x = read_vbyte ();
                        y = read_vbyte ();
                        n = read_vbyte ();
                        map_buff [x + (y << 4) - y] = n;
                        map_attr [x + (y << 4) - y] = comportamiento_tiles [n];
                        draw_coloured_tile (VIEWPORT_X + x + x, VIEWPORT_Y + y + y, n);
                        break;
                    case 0x41:
                        // DEC OBJECTS n
                        // Opcode: 41 n
                        n = read_vbyte ();
                        player.objs -= n;
                        draw_objs ();
                        break;
                    case 0xE0:
                        // SOUND n
                        // Opcode: E0 n
                        n = read_vbyte ();
                        peta_el_beeper (n);
                        break;
                    case 0xF1:
                        script_result = 1;
                        terminado = 1;
                        break;
                    case 0xFF:
                        terminado = 1;
                        break;
                }
            }
        }
        script = next_script;
    }
 
    return res;
}
