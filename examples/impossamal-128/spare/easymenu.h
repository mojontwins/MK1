// Easy menu
// First shows PLAY/PASSWORD
// Let's you introduce password.
// Returns level number 0-n
// Passwords are fixed lenght

#define PASSWORD_LENGTH	6
#define MENU_Y 			16
#define MENU_X			11
extern unsigned char passwords [0];
#asm
	._passwords
		defm "TETICA"
		defm "PICHON"
		defm "CULETE"
		defm "BUTACA"
#endasm

unsigned char *clearout = "          ";
unsigned char *password = "****** ";

unsigned char which_level (void) {
	unsigned char *passpointer = passwords;
	print_str (MENU_X, MENU_Y, 7, " PASSWORD ");	
	print_str (MENU_X, MENU_Y + 1, 7, clearout);
	print_str (MENU_X, MENU_Y + 2, 7, clearout);
	for (gpit = 0; gpit < PASSWORD_LENGTH; gpit ++) password [gpit] = '.';
	password [PASSWORD_LENGTH] = ' ';
	gpit = 0;
	sp_WaitForNoKey ();
	while (1) {
		password [gpit] = '*';
		print_str (16 - PASSWORD_LENGTH / 2, MENU_Y + 2, 71, password);
		sp_UpdateNow ();
		do {
			gpjt = sp_GetKey ();
		} while (!gpjt);
		if (gpjt == 12 && gpit > 0) {
			password [gpit] = gpit == PASSWORD_LENGTH ? ' ' : '.';
			gpit --;
		}
		if (gpjt == 13) break;
		if (gpjt > 'Z') gpjt -= 32;
		if (gpjt >= 'A' && gpjt <= 'Z' && gpit < PASSWORD_LENGTH) {
			password [gpit] = gpjt;
			gpit ++;
		}
		PLAY_SOUND (0);
		sp_WaitForNoKey ();
	}
	
	sp_WaitForNoKey ();
	STOP_SOUND ();
	PLAY_SOUND (1);
	
	// Check password
	for (gpit = 0; gpit < MAX_LEVELS - 1; gpit ++) {
		gpt = 1;
		for (gpjt = 0; gpjt < PASSWORD_LENGTH; gpjt ++) {
			if (password [gpjt] != (*passpointer++)) gpt = 0;
		}
		if (gpt) return (1 + gpit);
	}
	
	return 0;
}

unsigned char simple_menu (void) {
	if (language) {
		print_str (MENU_X, MENU_Y, 7, "-= MENU =-");
		print_str (MENU_X, MENU_Y + 1, 7, "1 JUGAR   ");
	} else {
		print_str (MENU_X, MENU_Y, 7, "-=SELECT=-");
		print_str (MENU_X, MENU_Y + 1, 7, "1 PLAY    ");
	}
	print_str (MENU_X, MENU_Y + 2, 7, "2 PASSWORD");
	sp_UpdateNow ();
	while (1) {
		gpjt = sp_GetKey ();
		switch (gpjt) {
			case '1':
				STOP_SOUND ();
				PLAY_SOUND (1);
				return 0;
				break;
			case '2':
				PLAY_SOUND (0);
				return which_level ();
				break;
		}
	}
}

void print_password (unsigned char x, unsigned char y, unsigned char level) {
	unsigned char *passpointer = passwords + ((level - 1) * PASSWORD_LENGTH);
	
	for (gpit = 0; gpit < PASSWORD_LENGTH; gpit ++) {
		sp_PrintAtInv (y, x ++, 70, (*passpointer ++) - 32);
	}
	
}