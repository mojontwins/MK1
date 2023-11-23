// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

if (n_pant == 0) {

	if((p_tx == 1) && (p_ty == 5)) {

		if(flags[3]) {
			success = 1;
			playing = 0;
		}

	}
}

if (n_pant == 24) {
		
	if((p_tx == 10 || p_tx == 11 ) && (p_ty == 5 || p_ty == 6)) {

	    if (flags[2]) {

	    	if (!flags[3]) {
	    		#ifdef MODE_128K
					PLAY_MUSIC (1);
				#endif
		    	blackout_area();
				textbox (4);
				flags[3] = 1;
				timer_on = 1;
				recuadrius_plus();
				o_pant=0xff;
				#ifdef MODE_128K
					PLAY_MUSIC (3);
				#endif
			}

		} else {
			#ifdef MODE_128K
				PLAY_MUSIC (1);
			#endif
			blackout_area();
			textbox (5);
			blackout_area();
			success = 0;
	        playing = 0;

	    }
 	}
}