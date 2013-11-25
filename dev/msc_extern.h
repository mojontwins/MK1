// Extern actions.
// Add code here at your wish.
// Will be run from scripting (EXTERN n)
/*
extern unsigned char cad1[0];
extern unsigned char cad2[0];
extern unsigned char cad3[0];
extern unsigned char cad4[0];
unsigned char *cads [4] = {cad1, cad2, cad3, cad4};
#asm
	._cad1
		defm " EL MALO GONZALO SE HA "
		defb 0
		defm " LLEVADO A TU HIJA!!   "
		defb 0
		defm "                       "
		defb 0
		defm " VE A VERLE, A VER QUE "
		defb 0
		defm " QUIERE. ESTA EN SUS   "
		defb 0
		defm " APOSENTOS, EN LO MAS  "
		defb 0
		defm " ALTO DEL CASTILLO...  "
		defb 0
	._cad2
		defm " TENGO A TU HIJA Y NO  "
		defb 0
		defm " TE LA DEVOLVERE HASTA "
		defb 0
		defm " QUE NO ME DEVUELVAS   "
		defb 0
		defm " EL TALISMAN ALEMAN.   "
		defb 0
		defm " COLOCA CADA FRAGMENTO "
		defb 0
		defm " EN SU CRIPTA CORRES-  "
		defb 0
		defm " PONDIENTE.            "
		defb 0
	._cad3
		defm " PARA LIBRARTE DE LOS  "
		defb 0
		defm " LOS GUARDIANES DE LAS "
		defb 0
		defm " CRIPTAS, ACCIONA UNOS "
		defb 0
		defm " CRISTALES QUE ENCON-  "
		defb 0
		defm " TRARAS CERCA. UNA VEZ "
		defb 0
		defm " DENTRO, PON LOS FRAG- "
		defb 0
		defm " MENTOS EN LOS ALTARES "
		defb 0
	._cad4
		defm " BIEN, ME HAS COMPLA-  "
		defb 0
		defm " CIDO. HAS DEVUELTO EL "
		defb 0
		defm " TALISMAN ALEMAN Y POR "
		defb 0
		defm " TANTO TE DEVOLVERE A  "
		defb 0
		defm " TU HIJA CANIJA.       "
		defb 0
		defm " LA PROXIMA VEZ TE LO  "
		defb 0
		defm " PIENSAS ANTES !!      "
		defb 0
#endasm

void draw_texts (unsigned char x, unsigned char y, unsigned char c, char *cad, unsigned char n, unsigned char width) {
	while (n > 0) {
		draw_text (x, y, c, cad);
		y ++;		
		cad += width;
		n --;	
		sp_UpdateNow ();
		peta_el_beeper (7 + ((rand () & 1) << 2));
	}	
}
*/
void do_extern_action (unsigned char n) {
/*
	saca_a_todo_el_mundo_de_aqui ();
	draw_rectangle (4, 6, 26, 14, 112);
	draw_texts (4, 7, 112, cads [n - 1], 7, 24);
	espera_activa (500);
*/
}
