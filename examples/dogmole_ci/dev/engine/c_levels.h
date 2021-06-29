
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
		unpack ((unsigned int) levels [level].c_tileset, (unsigned int) (tileset));
		unpack ((unsigned int) levels [level].c_enems_hotspots, (unsigned int) (malotes));
		unpack ((unsigned int) levels [level].c_behs, (unsigned int) (behs));

		#ifdef PER_LEVEL_SPRITESET
			unpack ((unsigned int) levels [level].c_sprites, (unsigned int) (sprites + 16));
		#endif

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

		#ifdef ACTIVATE_SCRIPTING
			main_script_offset = levels [level].script_offset;
		#endif
	#endif
}
