
void prepare_level (void) {
	#ifdef MODE_128K
		get_resource (levels [level].resource, (unsigned int) (level_data));
		
		n_pant = level_data.scr_ini;
		gpx = level_data->ini_x << 4; p_x = gpx << 6;
		gpy = level_data->ini_y << 4; p_y = gpy << 6;

		#ifdef ACTIVATE_SCRIPTING
			main_script_offset = level_data->script_offset;
		#endif
	#else

		unpack ((unsigned int) levelset [level].leveldata_c, MAP_DATA);
		unpack ((unsigned int) levelset [level].tileset_c, (unsigned int) (tileset));
		unpack ((unsigned int) levelset [level].spriteset_c, (unsigned int) (sprite_1_a - 16));
		n_pant = levelset [level].ini_pant;
		gpx = level_data->ini_x << 4; p_x = gpx << 6;
		gpy = level_data->ini_y << 4; p_y = gpy << 6;
	#endif
}
