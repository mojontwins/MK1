// Churrera Engine
// ===============
// Copyleft 2010, 2011 by The Mojon Twins

// mainloop.h
// Cointains initialization stuff and the main game loop.

void do_game () {
	int j;
	unsigned char *allpurposepuntero;
	unsigned char i;
	unsigned char playing;
	unsigned char maincounter;
	unsigned char objs_old, keys_old, life_old, killed_old, item_old;
	unsigned char reentered;
	int key_m;
#ifdef RANDOM_RESPAWN
	int x, y;
#else
	unsigned char x, y;
#endif
	unsigned char success;
	
	// Kempston detection
	#asm
		halt
		in	a, (31)
		inc a
		ld	(_kempston_is_attached), a
		di
	#endasm
	
	// splib2 initialization
	sp_Initialize (7, 0);
	sp_Border (BLACK);
	sp_AddMemory(0, 64, 14, AD_FREE);
	
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
	for (j = 0; j < 192; j++) {
		sp_TileArray (j, allpurposepuntero);
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
	sp_player = sp_CreateSpr (sp_XOR_SPRITE, 3, sprite_2_a, 1, TRANSPARENT);
	sp_AddColSpr (sp_player, sprite_2_b, TRANSPARENT);
	sp_AddColSpr (sp_player, sprite_2_c, TRANSPARENT);
	player.current_frame = player.next_frame = sprite_2_a;
	
	for (i = 0; i < 3; i ++) {
		sp_moviles [i] = sp_CreateSpr(sp_XOR_SPRITE, 3, sprite_9_a, 1, TRANSPARENT);
		sp_AddColSpr (sp_moviles [i], sprite_9_b, TRANSPARENT);
		sp_AddColSpr (sp_moviles [i], sprite_9_c, TRANSPARENT);	
		en_an [i].current_frame = sprite_9_a;
	}
#else
	sp_player = sp_CreateSpr (sp_MASK_SPRITE, 3, sprite_2_a, 1, TRANSPARENT);
	sp_AddColSpr (sp_player, sprite_2_b, TRANSPARENT);
	sp_AddColSpr (sp_player, sprite_2_c, TRANSPARENT);
	player.current_frame = player.next_frame = sprite_2_a;
	
	for (i = 0; i < 3; i ++) {
		sp_moviles [i] = sp_CreateSpr(sp_MASK_SPRITE, 3, sprite_9_a, 2, TRANSPARENT);
		sp_AddColSpr (sp_moviles [i], sprite_9_b, TRANSPARENT);
		sp_AddColSpr (sp_moviles [i], sprite_9_c, TRANSPARENT);	
		en_an [i].current_frame = sprite_9_a;
	}
#endif

#ifdef PLAYER_CAN_FIRE
	for (i = 0; i < MAX_BULLETS; i ++) {
		sp_bullets [i] = sp_CreateSpr (sp_OR_SPRITE, 2, sprite_19_a, 1, TRANSPARENT);
		sp_AddColSpr (sp_bullets [i], sprite_19_b, TRANSPARENT);
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
#if defined(DEACTIVATE_KEYS) && defined(DEACTIVATE_OBJECTS)
#else
		init_hotspots ();
#endif
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
#ifdef OBJECT_COUNT
		flags [OBJECT_COUNT] = 0;
#endif
		
		// Execute "ENTERING GAME" script
		script = e_scripts [MAP_W * MAP_H];
		run_script ();
#endif
		
		draw_scr ();
		draw_life ();
#ifndef	DEACTIVATE_OBJECTS
		draw_objs ();
#endif
#ifdef PLAYER_SHOW_ITEM
		draw_item ();
#endif
#ifndef DEACTIVATE_KEYS
		draw_keys ();
#endif

#if defined(PLAYER_KILLS_ENEMIES) || defined(PLAYER_CAN_FIRE)
#ifdef SHOW_KILLED
		draw_killed ();
#endif
#ifdef SHOW_TOTAL
		// Show total of enemies next to the killed amount.

		sp_PrintAtInv (KILLED_Y, 2 + KILLED_X, 71, 15);
		sp_PrintAtInv (KILLED_Y, 3 + KILLED_X, 71, 16 + BADDIES_COUNT / 10);
		sp_PrintAtInv (KILLED_Y, 4 + KILLED_X, 71, 16 + BADDIES_COUNT % 10);
#endif
#endif
		reentered = 0;
		half_life = 0;

		while (playing) {
#ifndef DEACTIVATE_OBJECTS			
			if (player.objs != objs_old) {
				draw_objs ();
				objs_old = player.objs;
			}
#endif
			
			if (player.life != life_old) {
				draw_life ();
				life_old = player.life;
			}

#ifndef DEACTIVATE_KEYS
			if (player.keys != keys_old) {
				draw_keys ();
				keys_old = player.keys;
			}
#endif

#ifdef PLAYER_KILLS_ENEMIES		
			if (player.killed != killed_old) {
				draw_killed ();
				killed_old = player.killed;	
			}
#endif

#ifdef PLAYER_SHOW_ITEM
			if (flags [ITEM_IN_FLAG] != item_old) {
				draw_item ();
				item_old = flags [ITEM_IN_FLAG];
			}
#endif			

			maincounter ++;
			half_life = !half_life;
			
			// Move player
			if ( !(player.estado & EST_MUR) )
				move ();
			else {
				// WTF?
			}
			
			// Move enemies
			mueve_bicharracos ();

#ifdef PLAYER_CAN_FIRE
			// Move bullets				
			mueve_bullets ();
#endif

			// Render		
			for (i = 0; i < 3; i ++) {
#if defined(RANDOM_RESPAWN) || defined(USE_TYPE_6)
#ifdef RANDOM_RESPAWN
					if (en_an [i].fanty_activo) {
#else
					if (malotes [enoffs + i].t == 6) {
#endif
						x = en_an [i].x >> 6;
						y = en_an [i].y >> 6;
					} else {
#endif
						x = malotes [enoffs + i].x;
						y = malotes [enoffs + i].y;
#if defined(RANDOM_RESPAWN) || defined(USE_TYPE_6)
					}
#endif
					sp_MoveSprAbs (sp_moviles [i], spritesClip, en_an [i].next_frame - en_an [i].current_frame, VIEWPORT_Y + (y >> 3), VIEWPORT_X + (x >> 3),x & 7, y & 7);
					en_an [i].current_frame = en_an [i].next_frame;
			}

			// Precalc this, comes handy:
			x = player.x >> 6;
			y = player.y >> 6;
			
#ifdef ACTIVATE_SCRIPTING
			if (f_zone_ac == 1) {
				if (x >= fzx1 && x <= fzx2 && y >= fzy1 && y <= fzy2) {
					script = f_scripts [n_pant];
					run_script ();
				}	
			}
#endif
			
			if ( !(player.estado & EST_PARP) || !(half_life) )
				sp_MoveSprAbs (sp_player, spritesClip, player.next_frame - player.current_frame, VIEWPORT_Y + (y >> 3), VIEWPORT_X + (x >> 3), x & 7, y & 7);
			else
				sp_MoveSprAbs (sp_player, spritesClip, player.next_frame - player.current_frame, -2, -2, 0, 0);
			
			player.current_frame = player.next_frame;
			
			
#ifdef PLAYER_CAN_FIRE
			for (i = 0; i < MAX_BULLETS; i ++) {
				if (bullets [i].estado == 1) {
					sp_MoveSprAbs (sp_bullets [i], spritesClip, 0, VIEWPORT_Y + (bullets [i].y >> 3), VIEWPORT_X + (bullets [i].x >> 3), bullets [i].x & 7, bullets [i].y & 7);
				} else {
					sp_MoveSprAbs (sp_bullets [i], spritesClip, 0, -2, -2, 0, 0);
				}
			}
#endif			
			
			// Update to screen
			sp_UpdateNow();
			
#ifdef PLAYER_CAN_FIRE
			for (i = 0; i < 3; i ++)
				if (en_an [i].morido == 1) {
					peta_el_beeper (1);
					en_an [i].morido = 0;
				} 	
#endif

#ifdef PLAYER_FLICKERS
			// Flickering
			if (player.estado & EST_PARP) {
				player.ct_estado --;
				if (player.ct_estado == 0) {
					player.estado = EST_NORMAL;
					delete_text ();
				}	
			}
#endif			
			
#if defined(DEACTIVATE_KEYS) && defined(DEACTIVATE_OBJECTS)
#else
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
						i = 1;
						player.objs ++;
						hotspots [n_pant].act = 0;
						peta_el_beeper (9);	
					} else {
						i = 0;
						peta_el_beeper (4);	
						draw_coloured_tile (VIEWPORT_X + (hotspot_x >> 3), VIEWPORT_Y + (hotspot_y >> 3), 17);
					}
#else
					player.objs ++;
					hotspots [n_pant].act = 0;
					peta_el_beeper (9);
#ifdef OBJECT_COUNT
					flags [OBJECT_COUNT] ++;
#endif
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
#endif
		
			// Flick screen checks and scripting related stuff
			i = (joyfunc) (&keys);
			
#ifdef ACTIVATE_SCRIPTING		
#ifdef SCRIPTING_KEY_M			
			if (sp_KeyPressed (key_m) || ((i & sp_FIRE) == 0)) {
#endif
#ifdef SCRIPTING_DOWN
			if ((i & sp_DOWN) == 0) {
#endif
				script = f_scripts [MAP_W * MAP_H];
				run_script ();
				// Any scripts to run in this screen?
				script = f_scripts [n_pant];
				run_script ();
				if (!script_something_done) 
					peta_el_beeper (4);
#ifdef SCRIPTING_KEY_M			
				while (sp_KeyPressed (key_m) || ((i & sp_FIRE) == 0)) {
					i = (joyfunc) (&keys);
				}
#endif
#ifdef SCRIPTING_DOWN
				do {
					i = (joyfunc) (&keys);
				} while ((i & sp_DOWN) == 0);
#endif
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
			if (player.x == 0 && ((i & sp_LEFT) == 0)) {
				n_pant --;
				draw_scr ();	
				player.x = 14336;
			}
			if (player.x == 14336 && ((i & sp_RIGHT) == 0)) {		// 14336 = 224 * 64
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
				} else {
					player.vy = -PLAYER_MAX_VY_CAYENDO;	
					if (player.life > 0) {
						peta_el_beeper (4);
						player.life --;	
					}
				}
			}
			
			// Win game condition
#ifdef ACTIVATE_SCRIPTING
#ifndef REENTER_ON_ALL_OBJECTS
			if (player.objs == PLAYER_NUM_OBJETOS || script_result == 1 || n_pant == SCR_FIN) {
#else
			if (player.objs == PLAYER_NUM_OBJETOS && !reentered) {
				reentered = 1;
				draw_scr ();	
			} 

			if (script_result == 1 || n_pant == SCR_FIN) {
#endif
#else			
			if (player.objs == PLAYER_NUM_OBJETOS || n_pant == SCR_FIN) {
#endif
				success = 0;
				if (n_pant == pant_final) {
					if ((player.x >> 10) == PLAYER_FIN_X && (player.y >> 10) == PLAYER_FIN_Y) 
						success = 1;
				} else if (pant_final == 99) {
					success = 1;
				}
				if (success) {
					cortina ();
					game_ending ();
					playing = 0;
					cortina ();
				}
			}
			
			// Game over condition
#ifdef ACTIVATE_SCRIPTING
			if (player.life == 0 || script_result == 2) {
#else
			if (player.life == 0) {
#endif
				// ¡Saca a todo el mundo de aquí!
				sp_MoveSprAbs (sp_player, spritesClip, 0, VIEWPORT_Y + 30, VIEWPORT_X + 20, 0, 0);				
				for (i = 0; i < 3; i ++) {
					if (malotes [enoffs + i].t != 0)
						sp_MoveSprAbs (sp_moviles [i], spritesClip, 0, VIEWPORT_Y + 30, VIEWPORT_X + 20, 0, 0);
				}
				
				game_over ();
				playing = 0;
				cortina ();
			}
		}	
	}
}
