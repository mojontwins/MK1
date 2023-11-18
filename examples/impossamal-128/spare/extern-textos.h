// Extern actions.
// Add code here at your wish.
// Will be run from scripting (EXTERN n)

extern unsigned char cad1[0];
extern unsigned char cad2[0];
extern unsigned char cad3[0];

#define BOX_Y 6

unsigned char *cads [] = {cad1, cad2, cad3};
#asm
	._cad1
		defb 7
		defm " HOLA, QUERIDO RAMIRO! "
		defb 0
		defm " ASI QUE TU HIJA QUERE "
		defb 0
		defm " EL TESORO DEL MORO... "
		defb 0
		defm " PUEDO ABRIR LA CAMARA "
		defb 0
		defm " PERO NECESITO QUE ME  "
		defb 0
		defm " TRAIGAS LAS 4 PARTES  "
		defb 0
		defm " DEL TALISMAN ALEMAN.  "
		defb 0
	
	._cad2
		defb 7
		defm " OH, CLARO, ES DE DIA  "
		defb 0
		defm " Y EL SOL TE QUEMA...  "
		defb 0
		defm " CON ESTE HECHIZO POS- "
		defb 0
		defm " TIZO QUE TE LANZO,    "
		defb 0
		defm " PODRAS SALIR FUERA... "
		defb 0
		defm " PERO CUIDADO: SOLO TE "
		defb 0
		defm " PROTEGERA UN MINUTO.  "
		defb 0
	
	._cad3
		defb 7
		defm " BIEN... VEO QUE TIE-  "
		defb 0
		defm " NES LOS CUATRO TROZOS "
		defb 0
		defm " DEL TALISMAN ALEMAN.  "
		defb 0
		defm " AHORA PUEDO HACER EL  "
		defb 0
		defm " ENCANTAMIENTO DEL PI- "
		defb 0
		defm " MIENTO PARA ABRIR LA  "
		defb 0
		defm " CAMARA DEL TESORO.    "
		defb 0

#endasm

unsigned char extx, exty, extn;

void draw_rectangle (unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2, unsigned char c) {
	for (exty = y1; exty <= y2; exty ++)
		for (extx = x1; extx <= x2; extx ++)
			sp_PrintAtInv (exty, extx, c, 0);	 
}

void draw_texts (unsigned char x, unsigned char y, unsigned char c, char *cad, unsigned char width) {
	extn = *cad ++;
	while (extn -- > 0) {
		print_str (x, y, c, cad);
		y ++; 	 
		cad += width;
		sp_UpdateNow ();
		PLAY_SOUND (1);
		espera_activa (50);
	}   
}

void do_extern_action (unsigned char n) {
	saca_a_todo_el_mundo_de_aqui ();
	draw_rectangle (4, BOX_Y, 26, BOX_Y + 1 + *(cads [n - 1]), 15);
	draw_texts (4, 7, 15, cads [n - 1], 24);
	espera_activa (500);
}