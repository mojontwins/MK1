// Config.h
// Churrera v.4
// Copyleft 2010, 2011 The Mojon Twins

// ============================================================================
// I. General configuration
// ============================================================================

//#define MODE_128K						// Experimental!

// In this section we define map dimmensions, initial and authomatic ending conditions, etc.

#define MAP_W					3		//
#define MAP_H					2		// Map dimmensions in screens
#define SCR_INICIO				3		// Initial screen
#define PLAYER_INI_X			3		//
#define PLAYER_INI_Y			3		// Initial tile coordinates
#define SCR_FIN 				99		// Last screen. 99 = deactivated.
#define PLAYER_FIN_X			99		//
#define PLAYER_FIN_Y			99		// Player tile coordinates to finish game
#define PLAYER_NUM_OBJETOS		99		// Objects to get to finish game
#define PLAYER_LIFE 			9		// Max and starting life gauge.
#define PLAYER_REFILL			1		// Life recharge
//#define COMPRESSED_LEVELS				// use levels.h instead of mapa.h and enems.h (!)
//#define MAX_LEVELS			4			// # of compressed levels
//#define REFILL_ME						// If defined, refill player on each level

// ============================================================================
// II. Engine type
// ============================================================================

// This section is used to define the game engine behaviour. Many directives are related,
// and others are mutually exclusive. I think this will be pretty obvious when you look at them. 

// Right now the shooting engine is only compatible with the side-view engine.

// Bounding box size
// -----------------
                                        // Comment both for normal 16x16 bounding box
#define BOUNDING_BOX_8_BOTTOM           // 8x8 aligned to bottom center in 16x16
//#define BOUNDING_BOX_8_CENTERED       // 8x8 aligned to center in 16x16
#define SMALL_COLLISION               // 8x8 centered collision instead of 12x12

// General directives:
// -------------------

#define PLAYER_AUTO_CHANGE_SCREEN		// Player changes screen automaticly (no need to press direction)
//#define PLAYER_CHECK_MAP_BOUNDARIES	// If defined, you can't exit the map.
#define DIRECT_TO_PLAY					// If defined, title screen is also the game frame.
#define DEACTIVATE_KEYS					// If defined, keys are not present.
#define DEACTIVATE_OBJECTS				// If defined, objects are not present.
//#define ONLY_ONE_OBJECT				// If defined, only one object can be carried at a time.
//#define OBJECT_COUNT			1		// Defines which FLAG will be used to store the object count.
//#define DEACTIVATE_EVIL_TILE			// If defined, no killing tiles (behaviour 1) are detected.
#define FULL_BOUNCE						// If defined, evil tile bounces equal MAX_VX, otherwise v/2
//#define PLAYER_BOUNCES				// If defined, collisions make player bounce
//#define SLOW_DRAIN					// Works with bounces. Drain is 4 times slower
#define PLAYER_FLICKERS 			 	// If defined, collisions make player flicker instead.
//#define MAP_BOTTOM_KILLS				// If defined, exiting the map bottomwise kills.
#define WALLS_STOP_ENEMIES				// If defined, enemies react to the scenary
//#define EVERYTHING_IS_A_WALL			// If defined, any tile <> type 0 is a wall, otherwise just 8.
//#define ENABLE_PURSUERS				// If defined, type 7 enemies are active
//#define DEATH_COUNT_EXPRESSION	20+(rand()&15)
//#define TYPE_7_FIXED_SPRITE 	4		// If defined, type 7 enemies are always #
/*
#define ENABLE_CUSTOM_TYPE_6			// If defined, add code to type 6 enemies.
#define TYPE_6_FIXED_SPRITE 	2		// Sprite used - 1.
#define SIGHT_DISTANCE			104		// Used in our type 6 enemies.
#define USE_TWO_BUTTONS					// Alternate keyboard scheme for two-buttons games
#define USE_HOTSPOTS_TYPE_3				// Alternate logic for recharges.
*/
// Pushable tile
// -------------

#define PLAYER_PUSH_BOXES 				// If defined, tile #14 is pushable. Must be type 10.
//#define FIRE_TO_PUSH					// If defined, you have to press FIRE+direction to push.
//#define ENABLE_PUSHED_SCRIPTING		// If defined, nice goodies (below) are activated:
//#define MOVED_TILE_FLAG 		1		// Current tile "overwritten" with block is stored here.
//#define MOVED_X_FLAG 			2		// X after pushing is stored here.
//#define MOVED_Y_FLAG 			3		// Y after pushing is stored here.
//#define PUSHING_ACTION				// If defined, pushing a tile runs PRESS_FIRE script

// Shooting behaviour
// ------------------
/*
#define PLAYER_CAN_FIRE 				// If defined, shooting engine is enabled.
//#define PLAYER_CAN_FIRE_FLAG	1		// If defined, player can only fire when flag # is 1
#define PLAYER_BULLET_SPEED 	8		// Pixels/frame. 
#define MAX_BULLETS 			3		// Max number of bullets on screen. Be careful!.
#define PLAYER_BULLET_Y_OFFSET	6		// vertical offset from the player's top.
#define PLAYER_BULLET_X_OFFSET	0		// vertical offset from the player's left/right.
#define ENEMIES_LIFE_GAUGE		4		// Amount of shots needed to kill enemies.

#define RESPAWN_ON_ENTER				// Enemies respawn when entering screen
#define FIRE_MIN_KILLABLE 	3			// If defined, only enemies >= N can be killed.
#define CAN_FIRE_UP						// If defined, player can fire upwards and diagonal.
#define MAX_AMMO				99		// If defined, ammo is not infinite!
#define AMMO_REFILL				50		// ammo refill, using tile 20 (hotspot #4)
#define INITIAL_AMMO 			0		// If defined, ammo = X when entering game.

#define BREAKABLE_WALLS					// Breakable walls
#define BREAKABLE_WALLS_LIFE	1		// Amount of hits to break wall
*/
//#define ENABLE_RANDOM_RESPAWN			// If defined, automatic flying enemies spawn on killed enemies
#define FANTY_MAX_V				256		// Flying enemies max speed (also for custom type 6 if you want)
#define FANTY_A					16		// Flying enemies acceleration.
//#define FANTIES_LIFE_GAUGE	10		// Amount of shots needed to kill flying enemies.

// Scripting
// ---------

#define ACTIVATE_SCRIPTING			// Activates msc scripting and flag related stuff.
#define SCRIPTING_DOWN				// Use DOWN as the action key.
//#define SCRIPTING_KEY_M			// Use M as the action key instead.
//#define SCRIPTING_KEY_FIRE		// User FIRE as the action key instead.
#define ENABLE_EXTERN_CODE			// Enables custom code to be run from the script using EXTERN n
#define ENABLE_FIRE_ZONE			// Allows to define a zone which auto-triggers "FIRE"

// Timer
// -----

//#define TIMER_ENABLE					// Enable timer
//#define TIMER_INITIAL		99			// For unscripted games, initial value.
//#define TIMER_REFILL		30			// Timer refill, using tile 21 (hotspot #5)
//#define TIMER_LAPSE 		32			// # of frames between decrements
//#define TIMER_START					// If defined, start timer from the beginning
//#define TIMER_SCRIPT_0				// If defined, timer = 0 runs "ON_TIMER_OFF" in the script
//#define TIMER_GAMEOVER_0				// If defined, timer = 0 causes "game over"
//#define TIMER_KILL_0					// If defined, timer = 0 causes "one life less".
//#define TIMER_WARP_TO 0				// If defined, warp to screen X after "one life less".
//#define TIMER_WARP_TO_X 	1			//
//#define TIMER_WARP_TO_Y 	1			// "warp to" coordinates.
//#define TIMER_AUTO_RESET				// If defined, timer resets after "one life less"
//#define SHOW_TIMER_OVER				// If defined, "TIME OVER" shows when time is up.

// Top view:
// ---------

//#define PLAYER_MOGGY_STYLE				// Enable top view.
//#define TOP_OVER_SIDE					// UP/DOWN has priority over LEFT/RIGHT

// Side view:
// ----------

#define PLAYER_HAS_JUMP					// If defined, player is able to jump.
//#define PLAYER_HAS_JETPAC 			// If defined, player can thrust a vertical jetpac
//#define PLAYER_KILLS_ENEMIES			// If defined, stepping on enemies kills them
//#define PLAYER_CAN_KILL_FLAG	1		// If defined, player can only kill when flag # is "1"
//#define PLAYER_MIN_KILLABLE	3		// Only kill enemies with id >= PLAYER_MIN_KILLABLE
//#define PLAYER_BOOTEE					// Always jumping engine. Don't forget to disable "HAS_JUMP" and "HAS_JETPAC"!!!
#define PLAYER_STEP_SOUND				// Sound while walking. No effect in the BOOTEE engine.
//#define PLAYER_BOUNCE_WITH_WALLS		// Bounce when hitting a wall. Only really useful in MOGGY_STYLE mode
#define PLAYER_CUMULATIVE_JUMP			// Keep pressing JUMP to JUMP higher in several bounces

// ============================================================================
// III. Screen configuration
// ============================================================================

// This sections defines how stuff is rendered, where to show counters, etcetera

#define VIEWPORT_X				0		//
#define VIEWPORT_Y				1		// Viewport character coordinates
#define LIFE_X					30		//
#define LIFE_Y					7		// Life gauge counter character coordinates
#define OBJECTS_X				30		//
#define OBJECTS_Y				16		// Objects counter character coordinates
#define OBJECTS_ICON_X			99		// 
#define OBJECTS_ICON_Y			99		// Objects icon character coordinates (use with ONLY_ONE_OBJECT)
#define KEYS_X					99		//
#define KEYS_Y					99		// Keys counter character coordinates
#define KILLED_X				99		//
#define KILLED_Y				99		// Kills counter character coordinates
//#define PLAYER_SHOW_KILLS				// If defined, show kill counter.
#define AMMO_X					99		// 
#define AMMO_Y					99		// Ammo counter character coordinates
#define TIMER_X					99		//
#define TIMER_Y					99		// Timer counter coordinates
//#define PLAYER_SHOW_TIMER				// If defined, show timer counter

// Text
/*
#define LINE_OF_TEXT			1		// If defined, scripts can show text @ Y = #
#define LINE_OF_TEXT_X			1		// X coordinate.
#define LINE_OF_TEXT_ATTR		71		// Attribute
*/

// Graphic FX, uncomment which applies...

//#define USE_AUTO_SHADOWS				// Automatic shadows made of darker attributes
//#define USE_AUTO_TILE_SHADOWS			// Automatic shadows using specially defined tiles 32-47.
//#define UNPACKED_MAP					// Full, uncompressed maps. Shadows settings are ignored.
//#define NO_MASKS						// Sprites are rendered using OR instead of masks.
//#define PLAYER_ALTERNATE_ANIMATION	// If defined, animation is 1,2,3,1,2,3... 
//#define MASKED_BULLETS				// If needed
//#define ENABLE_TILANIMS			32	// If defined, animated tiles are enabled.
										// the value especifies firt animated tile pair.
//#define PAUSE_ABORT					// Add h=PAUSE, y=ABORT
//#define GET_X_MORE					// Shows "get X more" when getting an object

// ============================================================================
// IV. Player movement configuration
// ============================================================================

// This section is used to define which constants are used in the gravity/acceleration engine.
// If a side-view engine is configured, we have to define vertical and horizontal constants
// separately. If a top-view engine is configured instead, the horizontal values are also
// applied to the vertical component, vertical values are ignored.

// IV.1. Vertical movement. Only for side-view.

#define PLAYER_MAX_VY_CAYENDO	512 	// Max falling speed (512/64 = 8 pixels/frame)
#define PLAYER_G				32		// Gravity acceleration (32/64 = 0.5 píxeles/frame^2)

#define PLAYER_VY_INICIAL_SALTO 128		// Initial junp velocity (64/64 = 1 píxel/frame)
#define PLAYER_MAX_VY_SALTANDO	512 	// Max jump velocity (320/64 = 5 píxels/frame)
#define PLAYER_INCR_SALTO		32		// acceleration while JUMP is pressed (48/64 = 0.75 píxeles/frame^2)

#define PLAYER_INCR_JETPAC		32		// Vertical jetpac gauge
#define PLAYER_MAX_VY_JETPAC	256 	// Max vertical jetpac speed

// IV.2. Horizontal (side view) or general (top view) movement.

#define PLAYER_MAX_VX			312	 	// Max velocity (192/64 = 3 píxels/frame)
#define PLAYER_AX				48		// Acceleration (24/64 = 0,375 píxels/frame^2)
#define PLAYER_RX				64		// Friction (32/64 = 0,5 píxels/frame^2)

// ============================================================================
// V. Tile behaviour
// ============================================================================

// Defines the behaviour for each tile. Remember that if keys are activated, tile #15 is a bolt
// and, therefore, it should be made a full obstacle!

// 0 = Walkable (no action)
// 1 = Walkable and kills.
// 2 = Walkable and hides.
// 4 = Platform (only stops player if falling on it)
// 8 = Full obstacle (blocks player from all directions)
// 10 = special obstacle (pushing blocks OR locks!)
// 16 = Breakable (#ifdef BREAKABLE_WALLS)
// You can add the numbers to get combined behaviours
// Save for 10 (special), but that's obvious, innit?
#ifndef COMPRESSED_LEVELS
unsigned char comportamiento_tiles [] = {
	0, 8, 8, 8, 8, 8, 8, 0, 0, 8, 8, 8, 1, 4,10,10,
	0, 0, 0, 0, 0, 0, 0, 8, 8, 8, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
};
#endif
