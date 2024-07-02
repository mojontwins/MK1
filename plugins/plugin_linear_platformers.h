// BONIATO, The Linear Platformer Engine v0.1. for MTE MK1 v5

#define IS_CPC

/*
	This MTE MK1v5 plugin works in ZX and Pestecera.
	To use, do this:
	
	* Make a `plugins` folder in `dev` and copy this file.
	* Add this to `my/ci/extra_vars.h`:

	#include "plugins/plugin_linear_platformers.h"

	Then add the hooks:

	* In `my/ci/custom_veng.h`         call `linear_vertical_axis ();`
	* In `my/ci/custom_heng.h`         call `linear_horizontal_axis ();`
	* In `my/ci/on_player_respawned.h` call `linear_player_respawned();`
	* In `my/custom_animation.h`       call `linear_custom_animation ();`

	Then change your `my/config.h` so...

	* `PLAYER_GENITAL` is off (obviously).
	* All vertical default engines are off (comment out `PLAYER_HAS_JUMP`, 
	  `PLAYER_HAS_JETPAC` and `PLAYER_BOOTEE`).
	* Enable `PLAYER_DISABLE_GRAVITY`.
	* Enable `PLAYER_DISABLE_DEFAULT_HENG`.
	* Enable `PLAYER_CUSTOM_ANIMATION`

	Now configure the macros:
	(All velocities & accelerations in [square] pixel units)
*/

#define PLAYER_LINEAR_GRAVITY 	4 	// Units to add when falling, per frame.
#define PLAYER_LINEAR_VX 		2 	// Units to add when walking, per frame.

#define PLAYER_JUMPING_FRAMES 	16 	// Jumps lasts this amount of frames.
									// 1st half going up, 2nd half going down.

#define PLAYER_JUMP_A_VX 		2 	// Jump type A values.
#define PLAYER_JUMP_A_VY 		4 	// Activated pressing `UP`

#define PLAYER_JUMP_B_VX 		4 	// Jump type B values.
#define PLAYER_JUMP_B_VY 		2 	// Activated pressing `DOWN`

//#define PLAYER_CAN_JUMP_UP 		// If defined, pl. has to press direction
									// to jump laterally.

//#define PLAYER_IDLE_FRAME 	1 	// If defined, set this frame when stopped

signed int p_jump_vx, p_jump_vy;

void linear_vertical_axis (void) {
	if (p_saltando) {
		p_cont_salto ++;
		if (p_cont_salto >= PLAYER_JUMPING_FRAMES || (possee && p_cont_salto > 1)) {
			p_saltando = 0;
		} else {
			p_vx = p_jump_vx;

			if (p_cont_salto > (PLAYER_JUMPING_FRAMES/2)) {
				p_vy = p_jump_vy;
			} else {
				p_vy = -p_jump_vy;
			}
		}
	} 

	if (p_saltando == 0) {
		p_vy = (PLAYER_LINEAR_GRAVITY << FIXBITS);
	}

	// Jump A 

	if (possee) {
		#ifdef IS_CPC
			if (cpc_TestKey (KEY_UP))
		#else
			if ((pad0 & sp_UP) == 0)
		#endif
		{
			p_jump_vy = (PLAYER_JUMP_A_VY << FIXBITS);

			#ifdef PLAYER_CAN_JUMP_UP
				#ifdef IS_CPC
					if (cpc_TestKey (KEY_LEFT))
				#else
					if ((pad0 & sp_LEFT) == 0)
				#endif
					p_jump_vx = -(PLAYER_JUMP_A_VX << FIXBITS);

				#ifdef IS_CPC
					if (cpc_TestKey (KEY_RIGHT))
				#else
					if ((pad0 & sp_RIGHT) == 0)
				#endif
					p_jump_vx = (PLAYER_JUMP_A_VX << FIXBITS);
			#else
				p_jump_vx = p_facing ? (PLAYER_JUMP_A_VX << FIXBITS) : -(PLAYER_JUMP_A_VX << FIXBITS);
			#endif

			p_cont_salto = 0; p_saltando = 1;
		}

		// Jump B

		#ifdef IS_CPC
			if (cpc_TestKey (KEY_DOWN))
		#else
			if ((pad0 & sp_DOWN) == 0)
		#endif
		{
			p_jump_vy = (PLAYER_JUMP_B_VY << FIXBITS);

			#ifdef PLAYER_CAN_JUMP_UP
				#ifdef IS_CPC
					if (cpc_TestKey (KEY_LEFT))
				#else
					if ((pad0 & sp_LEFT) == 0)
				#endif
					p_jump_vx = -(PLAYER_JUMP_B_VX << FIXBITS);

				#ifdef IS_CPC
					if (cpc_TestKey (KEY_RIGHT))
				#else
					if ((pad0 & sp_RIGHT) == 0)
				#endif
					p_jump_vx = (PLAYER_JUMP_B_VX << FIXBITS);
			#else
				p_jump_vx = p_facing ? (PLAYER_JUMP_B_VX << FIXBITS) : -(PLAYER_JUMP_B_VX << FIXBITS);
			#endif

			p_cont_salto = 0; p_saltando = 1;
		}
	}
}

void linear_horizontal_axis (void) {	
	if (possee) {
		// On platform
		#ifdef IS_CPC
			if (cpc_TestKey (KEY_LEFT))
		#else
			if ((pad0 & sp_LEFT) == 0)
		#endif
		{
			if (possee) {
				p_vx = -(PLAYER_LINEAR_VX << FIXBITS);
				p_facing = 0;
			} 
		} else

		#ifdef IS_CPC
			if (cpc_TestKey (KEY_RIGHT))
		#else
			if ((pad0 & sp_RIGHT) == 0)
		#endif
		{
			if (possee) {
				p_vx = (PLAYER_LINEAR_VX << FIXBITS);
				p_facing = 1;
			}
		} else {
			p_vx = 0; 
			p_vx = 0; 
			#ifdef IS_CPC
				gpx &= 0xfe;
			#endif
		}
	} else {
		// Airborne
		if (p_saltando == 0) {
			p_vx = 0; 
			#ifdef IS_CPC
				gpx &= 0xfe;
			#endif
		}
	}
}

void linear_custom_animation (void) {
	gpit = p_facing ? 0 : 4;

	if (possee) {
		#ifdef PLAYER_IDLE_FRAME
			if (p_vx == 0) rda = PLAYER_IDLE_FRAME; else
		#endif
		{
			rda = (gpx >> 1) & 3; if (rda == 3) rda = 1;
		}
		gpit += rda;
	} else {
		gpit += 3;
	}

    #ifdef IS_CPC
    	sp_sw [SP_PLAYER].sp0 = (int) (sm_sprptr [gpit]);
    #else
        p_next_frame = (unsigned char *) (player_cells [gpit]);
    #endif
}

void linear_player_respawned (void) {
	p_saltando = 0;
}
