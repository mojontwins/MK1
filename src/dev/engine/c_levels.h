// MTE MK1 (la Churrera) v5.10
// Copyleft 2010-2014, 2020-2023 by the Mojon Twins

// c_levels.h

void prepare_level (void) {
	#ifdef MODE_128K
		get_resource (levels [level].resource_id, (unsigned int) (level_data));
		
		#ifdef ACTIVATE_SCRIPTING
			if (script_result != 3)
		#else
			if (warp_to_level == 0)
		#endif
		{
			n_pant = level_data.scr_ini;
			gpx = level_data.ini_x << 4; p_x = gpx << 6;
			gpy = level_data.ini_y << 4; p_y = gpy << 6;
		}

		#ifdef ACTIVATE_SCRIPTING
			main_script_offset = levels [level].script_offset;
		#endif
	#else
		unpack ((unsigned int) levels [level].c_map_bolts, (unsigned int) (mapa));
		#ifdef PER_LEVEL_TILESET		
			unpack ((unsigned int) levels [level].c_tileset, (unsigned int) (tileset));
		#endif
		unpack ((unsigned int) levels [level].c_enems_hotspots, (unsigned int) (malotes));
		unpack ((unsigned int) levels [level].c_behs, (unsigned int) (behs));

		#ifdef PER_LEVEL_SPRITESET
			unpack ((unsigned int) levels [level].c_sprites, (unsigned int) (sprites + 16));
		#endif

		/*
		level_data.map_w = levels [level].map_w;
		level_data.map_h = levels [level].map_h;
		
		#ifdef ACTIVATE_SCRIPTING
			if (script_result != 3)
		#else
			if (warp_to_level == 0)
		#endif
		{
			n_pant = levels [level].scr_ini;
			gpx = levels [level].ini_x << 4; p_x = gpx << 6;
			gpy = levels [level].ini_y << 4; p_y = gpy << 6;
		}
		*/
		#asm
			// levels struct is 18 bytes per member
			// Multiply level by 18
			// Do calculations in 8 bits, max level = 14 (plenty)
				ld  a, (_level)
				sla a 				// A = level * 2
				ld  b, a 			// B = level * 2
				sla a 				// A = level * 4
				sla a 				// A = level * 8
				sla a 				// A = level * 16
				add b 				// A = level * 18
				ld  h, 0
				ld  l, a
				ld  de, _levels
				add hl, de 			// HL -> current level
				push hl 
				pop ix 				// IX -> current level

				// map_w/h are bytes 0/1 in both structs so
				// level_data.map_w = levels [level].map_w;
				// level_data.map_h = levels [level].map_h;
				ld  de, _level_data
				ldi
				ldi

			.relocate_player
			#ifdef ACTIVATE_SCRIPTING
					ld  a, (_script_result)
					cp  3
					jr  z, relocate_player_done
			#else
					ld  a, (_warp_to_level)
					or  a 
					jr  nz, relocate_player_done
			#endif

				ld  a, (ix + 2)		// 2 = scr_ini
				ld  (_n_pant), a 

				ld  a, (ix + 3) 	// 3 = ini_x
				sla a
				sla a
				sla a
				sla a
				ld  (_gpx), a 		// gpx = levels [level].ini_x << 4

				call Ashl16_HL 		// HL = gpx << 6
				ld  (_p_x), hl

				ld  a, (ix + 4) 	// 4 = ini_y
				sla a
				sla a
				sla a
				sla a
				ld  (_gpy), a 		// gpy = levels [level].ini_y << 4

				call Ashl16_HL 		// HL = gpy << 6
				ld  (_p_y), hl			
					
			.relocate_player_done
		#endasm

		#ifdef ACTIVATE_SCRIPTING
			main_script_offset = levels [level].script_offset;
		#endif
	#endif
}
