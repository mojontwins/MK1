// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// Printing functions

unsigned char attr (unsigned char x, unsigned char y) {
	if (x >= 15 || y >= 10) return 0;
	return map_attr [x + (y << 4) - y];
}

unsigned char qtile (unsigned char x, unsigned char y) {
	return map_buff [x + (y << 4) - y];
}

#if defined (USE_AUTO_TILE_SHADOWS) || defined (USE_AUTO_SHADOWS)
	unsigned char attr_mk2 (void) {
		// x + 15 * y = x + (16 - 1) * y = x + 16 * y - y = x + (y << 4) - y.
		// if (cx1 < 0 || cy1 < 0 || cx1 > 14 || cy1 > 9) return 0;
		// return map_attr [cx1 + (cy1 << 4) - cy1];
		#asm
				ld  a, (_cx1)
				cp  15
				jr  nc, _attr_reset
	
				ld  a, (_cy1)
				cp  10
				jr  c, _attr_do
	
			._attr_reset
				ld  hl, 0
				ret
	
			._attr_do
				ld  a, (_cy1)
				ld  b, a
				sla a
				sla a
				sla a
				sla a
				sub b
				ld  b, a
				ld  a, (_cx1)
				add b
				ld  e, a
				ld  d, 0
				ld  hl, _map_attr
				add hl, de
				ld  a, (hl)
	
				ld  h, 0
				ld  l, a
				ret
		#endasm
	}
#endif
	
#ifdef COMPRESSED_LEVELS
	#define ATTR_OFFSET 1536
#else
	#define ATTR_OFFSET 2048
#endif

void draw_coloured_tile (void) {
	#if defined (USE_AUTO_TILE_SHADOWS) || defined (USE_AUTO_SHADOWS)		
		#asm
			// Undo screen coordinates -> buffer coordinates
				ld  a, (__x)
				sub VIEWPORT_X
				srl a
				ld  (_xx), a

				ld  a, (__y)
				sub VIEWPORT_Y
				srl a
				ld  (_yy), a
		#endasm

		// Nocast for tiles which never get shadowed
		nocast = !((attr (xx, yy) & 8) || (_t >= 16 && _t != 19));		

		// Precalc 
		#asm
				ld  a, (__t)
				sla a 
				sla a 
				add 64
				ld  (__ta), a

				ld  hl, _tileset + ATTR_OFFSET
				ld  b, 0
				ld  c, a
				add hl, bc
				ld  (_gen_pt), hl
		#endasm

		// Fill up c1, c2, c3, c4 then use them
		#ifdef USE_AUTO_SHADOWS			
			cx1 = xx - 1; cy1 = yy - 1; rda = *gen_pt; c1 = (nocast && (attr_mk2 () & 8)) ? (rda & 7) - 1 : rda; t1 = _ta; ++ gen_pt; ++ _ta;
			cx1 = xx    ; cy1 = yy - 1; rda = *gen_pt; c2 = (nocast && (attr_mk2 () & 8)) ? (rda & 7) - 1 : rda; t2 = _ta; ++ gen_pt; ++ _ta;
			cx1 = xx - 1; cy1 = yy    ; rda = *gen_pt; c3 = (nocast && (attr_mk2 () & 8)) ? (rda & 7) - 1 : rda; t3 = _ta; ++ gen_pt; ++ _ta;			
		#endif
		#ifdef USE_AUTO_TILE_SHADOWS
			// Precalc
			
			if (_t == 19) {
				#asm
					ld  hl, _tileset + ATTR_OFFSET + 192
					ld  (_gen_pt_alt), hl
				#endasm
				t_alt = 192;
			} else {
				#asm
					ld  hl, _tileset + ATTR_OFFSET + 128
					ld  de, (__ta)
					ld  d, 0
					add hl, de
					ld  (_gen_pt_alt), hl
				#endasm
				t_alt = 128 + _ta;
			}
			
			gen_pt_alt = tileset + ATTR_OFFSET + t_alt;

			// cx1 = xx - 1; cy1 = yy ? yy - 1 : 0; a1 = (nocast && (attr_mk2 () & 8));
			#asm
				// cx1 = xx - 1; 
					ld  a, (_xx)
					dec a
					ld  (_cx1), a

				// cy1 = yy ? yy - 1 : 0;
					ld  a, (_yy)
					or  a
					jr  z, _dct_1_set_yy
					dec a
				._dct_1_set_yy
					ld  (_cy1), a

				// a1 = (nocast && (attr_mk2 () & 8));
					ld  a, (_nocast)
					or  a
					jr  z, _dct_a1_set

					call _attr_mk2
					ld  a, l
					and 8
					jr  z, _dct_a1_set

					ld  a, 1

				._dct_a1_set
					ld  (_a1), a
			#endasm			

			// cx1 = xx    ; cy1 = yy ? yy - 1 : 0; a2 = (nocast && (attr_mk2 () & 8));
			#asm
									// cx1 = xx; 
					ld  a, (_xx)					
					ld  (_cx1), a

				// cy1 = yy ? yy - 1 : 0;
					ld  a, (_yy)
					or  a
					jr  z, _dct_2_set_yy
					dec a
				._dct_2_set_yy
					ld  (_cy1), a

				// a2 = (nocast && (attr_mk2 () & 8))
					ld  a, (_nocast)
					or  a
					jr  z, _dct_a2_set

					call _attr_mk2
					ld  a, l
					and 8
					jr  z, _dct_a2_set

					ld  a, 1

				._dct_a2_set
					ld  (_a2), a
			#endasm

			// cx1 = xx - 1; cy1 = yy             ; a3 = (nocast && (attr_mk2 () & 8));
			#asm
					// cx1 = xx - 1; 
					ld  a, (_xx)
					dec a
					ld  (_cx1), a

				// cy1 = yy;
					ld  a, (_yy)					
					ld  (_cy1), a

				// a3 = (nocast && (attr_mk2 () & 8));
					ld  a, (_nocast)
					or  a
					jr  z, _dct_a3_set

					call _attr_mk2
					ld  a, l
					and 8
					jr  z, _dct_a3_set

					ld  a, 1

				._dct_a3_set
					ld  (_a3), a
			#endasm

			/*
			if (a1 || (a2 && a3)) { c1 = *gen_pt_alt; t1 = t_alt; }
				else { c1 = *gen_pt; t1 = _ta; }
			++ gen_pt; ++ gen_pt_alt; ++ _ta; ++ t_alt;
			*/
			#asm
					ld  a, (_a1)
					or  a
					jr  nz, _dct_1_shadow

					ld  a, (_a2)
					or  a
					jr  z, _dct_1_no_shadow

					ld  a, (_a3)
					or  a
					jr  z, _dct_1_no_shadow

				._dct_1_shadow
				// { c1 = *gen_pt_alt; t1 = t_alt; }
					ld  hl, (_gen_pt_alt)
					ld  a, (hl)
					ld  (_c1), a

					ld  a, (_t_alt)
					ld  (_t1), a

					jr  _dct_1_increment
				
				._dct_1_no_shadow
				// else { c1 = *gen_pt; t1 = _ta; }
					ld  hl, (_gen_pt)
					ld  a, (hl)
					ld  (_c1), a

					ld  a, (__ta)
					ld  (_t1), a

				._dct_1_increment
				// ++ gen_pt; ++ gen_pt_alt; ++ _ta; ++ t_alt;
					ld  hl, (_gen_pt)
					inc hl
					ld  (_gen_pt), hl

					ld  hl, (_gen_pt_alt)
					inc hl
					ld  (_gen_pt_alt), hl

					ld  hl, __ta
					inc (hl)

					ld  hl, _t_alt
					inc (hl)
			#endasm 

			/*		
			if (a2) { c2 = *gen_pt_alt; t2 = t_alt; }
				else { c2 = *gen_pt; t2 = _ta; }
			++ gen_pt; ++ gen_pt_alt; ++ _ta; ++ t_alt;
			*/
			#asm
					ld  a, (_a2)
					or  a
					jr  z, _dct_2_no_shadow

				._dct_2_shadow
				// { c1 = *gen_pt_alt; t1 = t_alt; }
					ld  hl, (_gen_pt_alt)
					ld  a, (hl)
					ld  (_c2), a

					ld  a, (_t_alt)
					ld  (_t2), a

					jr  _dct_2_increment
				
				._dct_2_no_shadow
				// else { c1 = *gen_pt; t1 = _ta; }
					ld  hl, (_gen_pt)
					ld  a, (hl)
					ld  (_c2), a

					ld  a, (__ta)
					ld  (_t2), a

				._dct_2_increment
				// ++ gen_pt; ++ gen_pt_alt; ++ _ta; ++ t_alt;
					ld  hl, (_gen_pt)
					inc hl
					ld  (_gen_pt), hl

					ld  hl, (_gen_pt_alt)
					inc hl
					ld  (_gen_pt_alt), hl

					ld  hl, __ta
					inc (hl)

					ld  hl, _t_alt
					inc (hl)
			#endasm 		

			/*
			if (a3) { c3 = *gen_pt_alt; t3 = t_alt; }
				else { c3 = *gen_pt; t3 = _ta; }
			++ gen_pt; ++ gen_pt_alt; ++ _ta; ++ t_alt;	
			*/

			#asm
					ld  a, (_a3)
					or  a
					jr  z, _dct_3_no_shadow

				._dct_3_shadow
				// { c1 = *gen_pt_alt; t1 = t_alt; }
					ld  hl, (_gen_pt_alt)
					ld  a, (hl)
					ld  (_c3), a

					ld  a, (_t_alt)
					ld  (_t3), a

					jr  _dct_3_increment
				
				._dct_3_no_shadow
				// else { c1 = *gen_pt; t1 = _ta; }
					ld  hl, (_gen_pt)
					ld  a, (hl)
					ld  (_c3), a

					ld  a, (__ta)
					ld  (_t3), a

				._dct_3_increment
				// ++ gen_pt; ++ gen_pt_alt; ++ _ta; ++ t_alt;
					ld  hl, (_gen_pt)
					inc hl
					ld  (_gen_pt), hl

					ld  hl, (_gen_pt_alt)
					inc hl
					ld  (_gen_pt_alt), hl

					ld  hl, __ta
					inc (hl)

					ld  hl, _t_alt
					inc (hl)
			#endasm 
			
		#endif

		// c4 = *gen_pt; t4 = _ta;
		#asm
				ld  hl, (_gen_pt)
				ld  a, (hl)
				ld  (_c4), a

				ld  a, (__ta)
				ld  (_t4), a
		#endasm	

		// Paint tile
		#asm
				// Calculate address in the display list

				ld  a, (__x)
				ld  c, a
				ld  a, (__y)
				call SPCompDListAddr
				
				// Now write 4 attributes and 4 chars.

				// For each char: write colour, inc DE, write tile, inc DE*3
				
				ld  a, (_c1) 		// read colour			
				ld  (hl), a 		// write colour
				inc hl

				ld  a, (_t1)		// read tile
				ld  (hl), a			// write tile
				inc hl
				
				inc hl
				inc hl 				// next DisplayList cell

				ld  a, (_c2) 		// read colour			
				ld  (hl), a 		// write colour
				inc hl				

				ld  a, (_t2)  		// read tile
				ld  (hl), a			// write tile
								
				ld  bc, 123
				add hl, bc 			// next DisplayList cell
				
				ld  a, (_c3) 		// read colour			
				ld  (hl), a 		// write colour
				inc hl				

				ld  a, (_t3)		// read tile
				ld  (hl), a			// write tile
				inc hl
				
				inc hl
				inc hl 				// next DisplayList cell

				ld  a, (_c4) 		// read colour			
				ld  (hl), a 		// write colour
				inc hl

				ld  a, (_t4)		// read tile
				ld  (hl), a			// write tile
		#endasm
	#else
		#asm
			/*
			_t = 64 + (_t << 2);
			gen_pt = tileset + ATTR_OFFSET + _t;
			sp_PrintAtInv (_y, _x, *gen_pt ++, _t ++);
			sp_PrintAtInv (_y, _x + 1, *gen_pt ++, _t ++);
			sp_PrintAtInv (_y + 1, _x, *gen_pt ++, _t ++);
			sp_PrintAtInv (_y + 1, _x + 1, *gen_pt, _t);
			*/
			// Calculate address in the display list

				ld  a, (__x)
				ld  c, a
				ld  a, (__y)
				call SPCompDListAddr
				ex de, hl

				// Now write 4 attributes and 4 chars.

				// Make a pointer to the metatile colour array	
				ld  a, (__t)
				sla a
				sla a 				// A = _t * 4
				add 64 				// A = _t * 4 + 64
				
				ld  hl, _tileset + ATTR_OFFSET
				ld  b, 0
				ld  c, a
				add hl, bc 			// HL = tileset + _taux
				
				ld  c, a 			// C = current pattern #

				// For each char: write colour, inc DE, write tile, inc DE*3
				
				ld  a, (hl) 		// read colour			
				ld  (de), a 		// write colour
				inc de
				inc hl 				// next colour

				ld  a, c  			// read tile
				ld  (de), a			// write tile
				inc de
				inc a 				// next tile
				ld  c, a 

				inc de
				inc de 				// next DisplayList cell

				ld  a, (hl) 		// read colour			
				ld  (de), a 		// write colour
				inc de
				inc hl 				// next colour

				ld  a, c  			// read tile
				ld  (de), a			// write tile
				inc a 				// next tile
				
				ex  de, hl
				ld  bc, 123
				add hl, bc
				ex  de, hl			// next DisplayList cell
				ld  c, a 

				ld  a, (hl) 		// read colour			
				ld  (de), a 		// write colour
				inc de
				inc hl 				// next colour

				ld  a, c  			// read tile
				ld  (de), a			// write tile
				inc de
				inc a 				// next tile
				ld  c, a 

				inc de
				inc de 				// next DisplayList cell

				ld  a, (hl) 		// read colour			
				ld  (de), a 		// write colour
				inc de

				ld  a, c  			// read tile
				ld  (de), a			// write tile
		#endasm
	#endif
}

void invalidate_tile (void) {
	#asm
			; Invalidate Rectangle
			;
			; enter:  B = row coord top left corner
			;         C = col coord top left corner
			;         D = row coord bottom right corner
			;         E = col coord bottom right corner
			;        IY = clipping rectangle, set it to "ClipStruct" for full screen

			ld  a, (__x)
			ld  c, a
			inc a
			ld  e, a
			ld  a, (__y)
			ld  b, a
			inc a
			ld  d, a
			ld  iy, fsClipStruct
			call SPInvalidate			
	#endasm
}

void invalidate_viewport (void) {
	#asm
			; Invalidate Rectangle
			;
			; enter:  B = row coord top left corner
			;         C = col coord top left corner
			;         D = row coord bottom right corner
			;         E = col coord bottom right corner
			;        IY = clipping rectangle, set it to "ClipStruct" for full screen

			ld  b, VIEWPORT_Y
			ld  c, VIEWPORT_X
			ld  d, VIEWPORT_Y+19
			ld  e, VIEWPORT_X+29
			ld  iy, vpClipStruct
			call SPInvalidate
	#endasm
}

void draw_invalidate_coloured_tile_gamearea (void) {
	draw_coloured_tile_gamearea ();
	invalidate_tile ();
}

void draw_coloured_tile_gamearea (void) {
	_x = VIEWPORT_X + (_x << 1); _y = VIEWPORT_Y + (_y << 1); draw_coloured_tile ();
}

void draw_decorations (void) {
	// Point _gp_gen to where the decorations are and fire away!
	#asm
			ld  hl, (__gp_gen)

		._draw_decorations_loop
			ld  a, (hl)
			cp  0xff
			ret z

			ld  a, (hl)
			inc hl
			ld  c, a
			and 0x0f
			ld  (__y), a
			ld  a, c
			srl a
			srl a
			srl a
			srl a
			ld  (__x), a

			ld  a, (hl)
			inc hl
			ld  (__t), a

			push hl

			ld  b, 0
			ld  c, a
			ld  hl, _behs
			add hl, bc
			ld  a, (hl)
			ld  (__n), a

			call _update_tile

			pop hl
			jr  _draw_decorations_loop
	#endasm
}

unsigned char utaux = 0;
void update_tile (void) {
	#ifdef ENABLE_TILANIMS
		// Detect tilanims
		if (_t >= ENABLE_TILANIMS) {
			_n = (_x << 4) | _y;
			tilanims_add ();	
		}
	#endif

	/*
	utaux = (_y << 4) - _y + _x;
	map_attr [utaux] = _n;
	map_buff [utaux] = _t;
	draw_invalidate_coloured_tile_gamearea ();
	*/
	#asm
		ld  a, (__x)
		ld  c, a
		ld  a, (__y)
		ld  b, a
		sla a 
		sla a 
		sla a 
		sla a 
		sub b
		add c
		ld  b, 0
		ld  c, a
		ld  hl, _map_attr
		add hl, bc
		ld  a, (__n)
		ld  (hl), a
		ld  hl, _map_buff
		add hl, bc
		ld  a, (__t)
		ld  (hl), a

		call _draw_coloured_tile_gamearea

		ld  a, (_is_rendering)
		or  a
		ret nz

		call _invalidate_tile
	#endasm
}

void print_number2 (void) {
	rda = 16 + (_t / 10); rdb = 16 + (_t % 10);
	#asm
			; enter:  A = row position (0..23)
			;         C = col position (0..31/63)
			;         D = pallette #
			;         E = graphic #

			ld  a, (_rda)
			ld  e, a

			ld  d, HUD_INK
			
			ld  a, (__x)
			ld  c, a

			ld  a, (__y)

			call SPPrintAtInv

			ld  a, (_rdb)
			ld  e, a

			ld  d, HUD_INK
			
			ld  a, (__x)
			inc a
			ld  c, a

			ld  a, (__y)

			call SPPrintAtInv
	#endasm
}

#ifndef DEACTIVATE_OBJECTS
	void draw_objs () {
		#if defined (ONLY_ONE_OBJECT) && defined (ACTIVATE_SCRIPTING)
			#if OBJECTS_ICON_X != 99
				if (p_objs) {
					// Make tile 17 flash
					/*
					sp_PrintAtInv (OBJECTS_ICON_Y, OBJECTS_ICON_X, 135, 132);
					sp_PrintAtInv (OBJECTS_ICON_Y, OBJECTS_ICON_X + 1, 135, 133);
					sp_PrintAtInv (OBJECTS_ICON_Y + 1, OBJECTS_ICON_X, 135, 134);
					sp_PrintAtInv (OBJECTS_ICON_Y + 1, OBJECTS_ICON_X + 1, 135, 135);
					*/
					#asm
							// Calculate address in the display list

							ld  a, OBJECTS_ICON_X
							ld  (__x), a
							ld  c, a
							ld  a, OBJECTS_ICON_Y
							ld  (__y), a
							call SPCompDListAddr // -> HL

							ld  a, 135
							ld  (hl), a 		// Colour 1
							inc hl
							ld  a, 132
							ld  (hl), a 		// Tile 1
							inc hl

							inc hl
							inc hl 				// Next cell

							ld  a, 135
							ld  (hl), a 		// Colour 2
							inc hl
							ld  a, 133
							ld  (hl), a 		// Tile 2

							ld  bc, 123
							add hl, bc 			// Next cell

							ld  a, 135
							ld  (hl), a 		// Colour 3
							inc hl
							ld  a, 134
							ld  (hl), a 		// Tile 3
							inc hl

							inc hl
							inc hl 				// Next cell

							ld  a, 135
							ld  (hl), a 		// Colour 4
							inc hl
							ld  a, 135
							ld  (hl), a 		// Tile 4

							// Invalidate
							call _invalidate_tile
					#endasm						
				} else {
					_x = OBJECTS_ICON_X; _y = OBJECTS_ICON_Y; _t = 17; 
					draw_coloured_tile ();
					invalidate_tile ();
				}
			#endif
				
			#if OBJECTS_X != 99
				_x = OBJECTS_X; _y = OBJECTS_Y; _t = flags [OBJECT_COUNT]; print_number2 ();
			#endif
		#else
			#if OBJECTS_X != 99
				_x = OBJECTS_X; _y = OBJECTS_Y; 
				#if defined REVERSE_OBJECTS_COUNT && defined PLAYER_NUM_OBJETOS
					_t = PLAYER_NUM_OBJETOS - p_objs;
				#else
					_t = p_objs; 
				#endif
				print_number2 ();
			#endif
		#endif
	}
#endif

void print_str (void) {
	#asm
		ld  hl, (__gp_gen)
		.print_str_loop
			ld  a, (hl)
			or  a
			ret z 

			inc hl
			
			sub 32
			ld  e, a

			ld  a, (__t)
			ld  d, a

			ld  a, (__x)
			ld  c, a
			cp  31
			jr  z, print_str_no_inc_a
			inc a
		.print_str_no_inc_a			
			ld  (__x), a
			
			ld  a, (__y)

			push hl
			call SPPrintAtInv
			pop  hl
			
			jr  print_str_loop
	#endasm
}

#if defined (COMPRESSED_LEVELS) || defined (SHOW_LEVEL_ON_SCREEN)
	void blackout_area (void) {
		#asm
			ld  de, 22528 + 32 * VIEWPORT_Y + VIEWPORT_X
			ld  b, 20
		.bal1
			push bc
			ld  h, d 
			ld  l, e
			ld	(hl), 0
			inc de
			ld  bc, 29
			ldir
			inc de
			inc de
			pop bc
			djnz bal1
		#endasm
	}
#endif

void clear_sprites (void) {
	#asm
			ld  ix, (_sp_player)
			ld  iy, vpClipStruct
			ld  bc, 0
			ld  hl, 0xdede
			ld  de, 0
			call SPMoveSprAbs
	
			xor a
		.hide_sprites_enems_loop
			ld  (_gpit), a

			sla a
			ld  c, a
			ld  b, 0
			ld  hl, _sp_moviles
			add hl, bc
			ld  e, (hl)
			inc hl
			ld  d, (hl)
			push de
			pop ix

			ld  iy, vpClipStruct
			ld  bc, 0
			ld  hl, 0xfefe	// -2, -2
			ld  de, 0

			call SPMoveSprAbs

			ld  a, (_gpit)
			inc a
			cp  3
			jr  nz, hide_sprites_enems_loop

		#ifdef PLAYER_CAN_FIRE
				xor a
			.hide_sprites_bullets_loop
				ld  (_gpit), a

				sla a
				ld  c, a
				ld  b, 0
				ld  hl, _sp_bullets
				add hl, bc
				ld  e, (hl)
				inc hl
				ld  d, (hl)
				push de
				pop ix

				ld  iy, vpClipStruct
				ld  bc, 0
				ld  hl, 0xfefe	// -2, -2
				ld  de, 0

				call SPMoveSprAbs

				ld  a, (_gpit)
				inc a
				cp  MAX_BULLETS
				jr  nz, hide_sprites_bullets_loop
		#endif
	#endasm
}
