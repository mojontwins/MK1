// mainloop.h
// Churrera copyleft 2011 by The Mojon Twins.

void saca_a_todo_el_mundo_de_aqui (void) {
	sp_MoveSprAbs (sp_player, spritesClip, 0, VIEWPORT_Y + 30, VIEWPORT_X + 20, 0, 0);				
	for (gpit = 0; gpit < 3; gpit ++) {
		if (malotes [enoffs + gpit].t != 0)
			sp_MoveSprAbs (sp_moviles [gpit], spritesClip, 0, VIEWPORT_Y + 30, VIEWPORT_X + 20, 0, 0);
	}
}

int itj;
unsigned char objs_old, keys_old, life_old, killed_old;
void do_game (void) {
	unsigned char *allpurposepuntero;
	unsigned char playing;
	int key_m;
#ifdef RANDOM_RESPAWN
	int x, y;
#else
	unsigned char x, y;
#endif
	unsigned char success;
	
	#asm
		di
	#endasm
	
	cortina ();
	
	// splib2 initialization
	sp_Initialize (7, 0);
	sp_Border (BLACK);
	sp_AddMemory(0, 56, 14, AD_FREE);
	
	// Define keys and default controls
	keys.up    = sp_LookupKey('q');
	keys.down  = sp_LookupKey('a');
	keys.left  = sp_LookupKey('o');
	keys.right = sp_LookupKey('p');
	keys.fire  = sp_LookupKey(' ');

	key_m = sp_LookupKey ('m');
		
	joyfunc = sp_JoyKeyboard;

	// Load tileset
	allpurposepuntero = tileset;
	for (itj = 0; itj < 256; itj++) {
		sp_TileArray (itj, allpurposepuntero);
		allpurposepuntero += 8;
	}

	// Clipping rectangle
	spritesClipValues.row_coord = VIEWPORT_Y;
	spritesClipValues.col_coord = VIEWPORT_X;
	spritesClipValues.height = 20;
	spritesClipValues.width = 30;
	spritesClip = &spritesClipValues;
	
	// Sprite creation
#ifdef NO_MASKS
	sp_player = sp_CreateSpr (sp_OR_SPRITE, 3, sprite_2_a, 1, TRANSPARENT);
	sp_AddColSpr (sp_player, sprite_2_b, TRANSPARENT);
	sp_AddColSpr (sp_player, sprite_2_c, TRANSPARENT);
	player.current_frame = player.next_frame = sprite_2_a;
	
	for (gpit = 0; gpit < 3; gpit ++) {
		sp_moviles [gpit] = sp_CreateSpr(sp_OR_SPRITE, 3, sprite_9_a, 1, TRANSPARENT);
		sp_AddColSpr (sp_moviles [gpit], sprite_9_b, TRANSPARENT);
		sp_AddColSpr (sp_moviles [gpit], sprite_9_c, TRANSPARENT);	
		en_an [gpit].current_frame = sprite_9_a;
	}
#else
	sp_player = sp_CreateSpr (sp_MASK_SPRITE, 3, sprite_2_a, 1, TRANSPARENT);
	sp_AddColSpr (sp_player, sprite_2_b, TRANSPARENT);
	sp_AddColSpr (sp_player, sprite_2_c, TRANSPARENT);
	player.current_frame = player.next_frame = sprite_2_a;
	
	for (gpit = 0; gpit < 3; gpit ++) {
		sp_moviles [gpit] = sp_CreateSpr(sp_MASK_SPRITE, 3, sprite_9_a, 2, TRANSPARENT);
		sp_AddColSpr (sp_moviles [gpit], sprite_9_b, TRANSPARENT);
		sp_AddColSpr (sp_moviles [gpit], sprite_9_c, TRANSPARENT);	
		en_an [gpit].current_frame = en_an [gpit].next_frame = sprite_9_a;
	}
#endif

#ifdef PLAYER_CAN_FIRE
	for (gpit = 0; gpit < MAX_BULLETS; gpit ++) {
		sp_bullets [gpit] = sp_CreateSpr (sp_OR_SPRITE, 2, sprite_19_a, 1, TRANSPARENT);
		sp_AddColSpr (sp_bullets [gpit], sprite_19_b, TRANSPARENT);
	}
#endif

	while (1) {
		// Here the title screen
		sp_UpdateNow();
		unpack ((unsigned int) (s_title));
		select_joyfunc ();
		
#ifndef DIRECT_TO_PLAY
		// Clear screen and show game frame
		cortina ();
		sp_UpdateNow();
		unpack ((unsigned int) (s_marco));
#endif

		// Let's do it.

		playing = 1;
		init_player ();
		init_hotspots ();
#ifndef DEACTIVATE_KEYS
		init_cerrojos ();
#endif
#if defined(PLAYER_KILLS_ENEMIES) || defined (PLAYER_CAN_FIRE)
		init_malotes ();
#endif
#ifdef PLAYER_CAN_FIRE
		init_bullets ();
#endif	
			
		n_pant = SCR_INICIO;
		maincounter = 0;
		
#ifdef ACTIVATE_SCRIPTING		
		script_result = 0;
		msc_init_all ();
#endif
		
		draw_scr ();
#ifdef PLAYER_KILLS_ENEMIES		
#ifdef SHOW_TOTAL
		// Show total of enemies next to the killed amount.

		sp_PrintAtInv (KILLED_Y, 2 + KILLED_X, 71, 15);
		sp_PrintAtInv (KILLED_Y, 3 + KILLED_X, 71, 16 + BADDIES_COUNT / 10);
		sp_PrintAtInv (KILLED_Y, 4 + KILLED_X, 71, 16 + BADDIES_COUNT % 10);
#endif
#endif
		
		half_life = 0;
			
		// Entering game
#ifdef ACTIVATE_SCRIPTING
		script = e_scripts [MAP_W * MAP_H];
		run_script ();
#endif

		objs_old = keys_old = life_old = killed_old = 0xff;
		success = 0;
		
		while (playing) {
			
#ifndef DEACTIVATE_OBJS
			if (player.objs != objs_old) {
				draw_objs ();
				objs_old = player.objs;
			}
#endif
			
			if (player.life != life_old) {
				print_number2 (LIFE_X, LIFE_Y, player.life);
				life_old = player.life;
			}
			
#ifndef DEACTIVATE_KEYS
			if (player.keys != keys_old) {
				print_number2 (KEYS_X, KEYS_Y, player.keys);
				keys_old = player.keys;
			}
#endif

#if defined(PLAYER_KILLS_ENEMIES) || defined(PLAYER_CAN_FIRE)
#ifdef SHOW_KILLED
			if (player.killed != killed_old) {
				print_number2 (KILLED_X, KILLED_Y, player.killed);
				killed_old = player.killed;	
			}
#endif
#endif
			maincounter ++;
			half_life = !half_life;
			
			// Move player
			move ();
			
			// Move enemies
			mueve_bicharracos ();

#ifdef PLAYER_CAN_FIRE
			// Move bullets				
			mueve_bullets ();
#endif

			// Render		
			for (gpit = 0; gpit < 3; gpit ++) {
#ifdef RANDOM_RESPAWN
				if (en_an [gpit].fanty_activo) {
					x = en_an [gpit].x >> 6;
					y = en_an [gpit].y >> 6;
				} else {
#endif
					x = malotes [enoffs + gpit].x;
					y = malotes [enoffs + gpit].y;
#ifdef RANDOM_RESPAWN
				}
#endif
				sp_MoveSprAbs (sp_moviles [gpit], spritesClip, en_an [gpit].next_frame - en_an [gpit].current_frame, VIEWPORT_Y + (y >> 3), VIEWPORT_X + (x >> 3),x & 7, y & 7);
				en_an [gpit].current_frame = en_an [gpit].next_frame;
			}

			// Precalc this, comes handy:
			x = player.x >> 6;
			y = player.y >> 6;
			
			if ( !(player.estado & EST_PARP) || !(half_life) )
				sp_MoveSprAbs (sp_player, spritesClip, player.next_frame - player.current_frame, VIEWPORT_Y + (y >> 3), VIEWPORT_X + (x >> 3), x & 7, y & 7);
			else
				sp_MoveSprAbs (sp_player, spritesClip, player.next_frame - player.current_frame, -2, -2, 0, 0);
			
			player.current_frame = player.next_frame;
			
			
#ifdef PLAYER_CAN_FIRE
			for (gpit = 0; gpit < MAX_BULLETS; gpit ++) {
				if (bullets [gpit].estado == 1) {
					sp_MoveSprAbs (sp_bullets [gpit], spritesClip, 0, VIEWPORT_Y + (bullets [gpit].y >> 3), VIEWPORT_X + (bullets [gpit].x >> 3), bullets [gpit].x & 7, bullets [gpit].y & 7);
				} else {
					sp_MoveSprAbs (sp_bullets [gpit], spritesClip, 0, -2, -2, 0, 0);
				}
			}
#endif			
			
			// Update to screen
			sp_UpdateNow();
			
#ifdef PLAYER_CAN_FIRE
			for (gpit = 0; gpit < 3; gpit ++)
				if (en_an [gpit].morido == 1) {
					peta_el_beeper (1);
					en_an [gpit].morido = 0;
				} 	
#endif

#ifdef PLAYER_FLICKERS
			// Flickering
			if (player.estado == EST_PARP) {
				player.ct_estado --;
				if (player.ct_estado == 0)
					player.estado = EST_NORMAL;	
			}
#endif			
			
			// Hotspot interaction.
			if (x >= hotspot_x - 15 && x <= hotspot_x + 15 && y >= hotspot_y - 15 && y <= hotspot_y + 15) {
				// Deactivate hotspot
				draw_coloured_tile (VIEWPORT_X + (hotspot_x >> 3), VIEWPORT_Y + (hotspot_y >> 3), orig_tile);
				// Was it an object, key or life boost?
				if (hotspots [n_pant].act == 0) {
					player.life += PLAYER_REFILL;
					if (player.life > PLAYER_LIFE)
						player.life = PLAYER_LIFE;
					hotspots [n_pant].act = 2;
					peta_el_beeper (8);
#ifndef DEACTIVATE_OBJECTS
				} else if (hotspots [n_pant].tipo == 1) {
#ifdef ONLY_ONE_OBJECT
					if (player.objs == 0) {
						player.objs ++;
						hotspots [n_pant].act = 0;
						peta_el_beeper (9);	
					} else {
						peta_el_beeper (4);	
						draw_coloured_tile (VIEWPORT_X + (hotspot_x >> 3), VIEWPORT_Y + (hotspot_y >> 3), 17);
					}
#else
					player.objs ++;
					hotspots [n_pant].act = 0;
					peta_el_beeper (9);
#endif
#endif
#ifndef DEACTIVATE_KEYS
				} else if (hotspots [n_pant].tipo == 2) {
					player.keys ++;
					hotspots [n_pant].act = 0;
					peta_el_beeper (7);
#endif
				} 
				// PLOP!!
				hotspot_x = hotspot_y = 240;
			}
			
			// Flick screen checks and scripting related stuff
			gpit = (joyfunc) (&keys);
			
#ifdef ACTIVATE_SCRIPTING		
#ifdef SCRIPTING_KEY_M			
			if (sp_KeyPressed (key_m)) {
#endif
#ifdef SCRIPTING_DOWN
			if ((gpit & sp_DOWN) == 0) {
#endif
				// Any scripts to run in this screen?
				script = f_scripts [n_pant];
				run_script ();
			}
#endif

#ifdef PLAYER_AUTO_CHANGE_SCREEN
			if (player.x == 0 && player.vx < 0) {
				n_pant --;
				draw_scr ();
				player.x = 14336;
			}
			if (player.x == 14336 && player.vx > 0) {
				n_pant ++;
				draw_scr ();
				player.x = 0;
			}
#else
			if (player.x == 0 && ((gpit & sp_LEFT) == 0)) {
				n_pant --;
				draw_scr ();	
				player.x = 14336;
			}
			if (player.x == 14336 && ((gpit & sp_RIGHT) == 0)) {		// 14336 = 224 * 64
				n_pant ++;
				draw_scr ();
				player.x = 0;
			}
#endif
			if (player.y == 0 && player.vy < 0 && n_pant >= MAP_W) {
				n_pant -= MAP_W;
				draw_scr ();
				player.y = 9216;	
			}
			if (player.y == 9216 && player.vy > 0) {				// 9216 = 144 * 64
				if (n_pant < MAP_W * MAP_H - MAP_W) {
					n_pant += MAP_W;
					draw_scr ();
					player.y = 0;
					if (player.vy > 256) player.vy = 256;
#ifdef MAP_BOTTOM_KILLS
				} else {
					player.vy = -PLAYER_MAX_VY_CAYENDO;	
					if (player.life > 0) {
						peta_el_beeper (4);
						player.life --;	
					}
#endif
				}
			}
			
			// Win game condition
#ifdef ACTIVATE_SCRIPTING
			if (player.objs == PLAYER_NUM_OBJETOS || script_result == 1) {
#else			
			if (player.objs == PLAYER_NUM_OBJETOS) {
#endif
				if (
					(n_pant == pant_final && ((player.x >> 10) == PLAYER_FIN_X && (player.y >> 10) == PLAYER_FIN_Y)) ||
					pant_final == 99
				) {
					success = 1;
					cortina ();
					playing = 0;					
				}
			}
			
			// Game over condition
#ifdef ACTIVATE_SCRIPTING
			if (player.life == 0 || script_result == 2) {
#else
			if (player.life == 0) {
#endif
				playing = 0;				
			}
		}
		
		saca_a_todo_el_mundo_de_aqui ();
		if (success) game_ending (); else game_over ();
		cortina ();
	}
}
