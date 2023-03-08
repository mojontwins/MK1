// MTE MK1 (la Churrera) v5.10
// Copyleft 2010-2014, 2020-2023 by the Mojon Twins

// flick_screen.h - Flicks the screen

	#ifdef PLAYER_CHECK_MAP_BOUNDARIES		
		#if MAP_W > 1
			if (gpx == 0 && p_vx < 0 && x_pant > 0) {
				-- n_pant;
				-- x_pant;
				gpx = 224;
				p_x = 14336;
			}

			#if defined (COMPRESSED_LEVELS)
				if (gpx == 224 && p_vx > 0 && x_pant < (level_data.map_w - 1))
			#else			
				if (gpx == 224 && p_vx > 0 && x_pant < (MAP_W - 1))
			#endif
			{
				++ n_pant;
				++ x_pant;					
				gpx = p_x = 0;
			}
		#endif

		#if MAP_H > 1
			if (gpy == 0 && p_vy < 0 && y_pant > 0) {
				#if defined (COMPRESSED_LEVELS)
					n_pant -= level_data.map_w;
				#else				
					n_pant -= MAP_W;
				#endif
				-- y_pant;					
				gpy = 144;
				p_y = 9216;	
			}

			#if defined (COMPRESSED_LEVELS)
				if (gpy >= 144 && p_vy > 0 && y_pant < (level_data.map_h - 1)) {
					n_pant += level_data.map_w;
			#else			
				if (gpy >= 144 && p_vy > 0 && y_pant < (MAP_H - 1)) {
					n_pant += MAP_W;
			#endif
				++ y_pant;					
				gpy = p_y = 0;
				if (p_vy > 256) p_vy = 256;	
			}
		#endif
	#else
		#if MAP_W > 1		
			if (gpx == 0 && p_vx < 0) {
				-- n_pant;
				gpx = 224; p_x = 14336;
			}
			if (gpx == 224 && p_vx > 0) {		// 14336 = 224 * 64
				++ n_pant;
				gpx = p_x = 0;
			}			
		#endif

		#if MAP_H > 1
			#if defined (COMPRESSED_LEVELS)
				if (gpy == 0 && p_vy < 0 && n_pant >= level_data.map_w) {
					n_pant -= level_data.map_w;
			#else
				if (gpy == 0 && p_vy < 0 && n_pant >= MAP_W) {
					n_pant -= MAP_W;
			#endif
				gpy = 144;
				p_y = 9216;	
			}

			if (gpy >= 144 && p_vy > 0) {				// 9216 = 144 * 64
				#if defined (COMPRESSED_LEVELS)
					if (n_pant < level_data.map_w * (level_data.map_h - 1)) {
						n_pant += level_data.map_w;
				#else
					if (n_pant < MAP_W * MAP_H - MAP_W) {
						n_pant += MAP_W;
				#endif				
					gpy = p_y = 0;
					if (p_vy > 256) p_vy = 256;
				}
				#ifdef MAP_BOTTOM_KILLS
					else {
						p_vy = -PLAYER_MAX_VY_CAYENDO; 
						{
							#ifdef MODE_128K
								p_killme = 1;
							#else
								p_killme = 4;
							#endif
						}
					}
				#endif
			}
		#endif
	#endif
