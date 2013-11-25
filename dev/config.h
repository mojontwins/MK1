// Config.h
// Churrera v.4
// Copyleft 2010, 2011 The Mojon Twins

// ============================================================================
// I. General configuration
// ============================================================================

// In this section we define map dimmensions, initial and authomatic ending conditions, etc.

#define MAP_W					6		//
#define MAP_H					5		// Map dimmensions in screens
#define TOTAL_SCREENS			25		// 
#define SCR_INICIO				0		// Initial screen
#define PLAYER_INI_X			1		//
#define PLAYER_INI_Y			1		// Initial tile coordinates
//#define SCR_FIN 				99		// Last screen. 99 = deactivated.
//#define PLAYER_FIN_X			99		//
//#define PLAYER_FIN_Y			99		// Player tile coordinates to finish game
//#define PLAYER_NUM_OBJETOS	99		// Objects to get to finish game
#define PLAYER_LIFE 			5		// Max and starting life gauge.
//#define PLAYER_REFILL			1		// Life recharge

#define LINEAR_ENEMY_HIT		1		// Amount of life to substract when normal enemy hits
//#define FLYING_ENEMY_HIT		1		// Amount of life to substract when flying enemy hits

// ============================================================================
// II. Engine type
// ============================================================================

// This section is used to define the game engine behaviour. Many directives are related,
// and others are mutually exclusive. I think this will be pretty obvious when you look at them. 

// Right now the shooting engine is only compatible with the side-view engine.

// General directives:
// -------------------

//#define PLAYER_AUTO_CHANGE_SCREEN		// Player changes screen automaticly (no need to press direction)
#define DIRECT_TO_PLAY					// If defined, title screen is also the game frame.
#define DEACTIVATE_KEYS					// If defined, keys are not present.
#define DEACTIVATE_OBJECTS				// If defined, objects are not present.
//#define ONLY_ONE_OBJECT				// If defined, only one object can be carried at a time.
#define DEACTIVATE_EVIL_TILE			// If defined, no killing tiles (behaviour 1) are detected.
#define DEACTIVATE_EVIL_ZONE			// Zones kill you after a while. Read docs or ask na_th_an
//#define EVIL_ZONE_FRAME_COUNT	8		// For countdown in an evil zone.
//#define EVIL_ZONE_BEEPS_COUNT	32		// # of counts before killing
//#define PLAYER_BOUNCES				// If defined, collisions make player bounce
#define PLAYER_FLICKERS 			 	// If defined, collisions make player flicker instead.
#define DEACTIVATE_REFILLS				// If defined, no refills.
#define MAX_FLAGS				16		// Number of flags. For scripting and stuff.

// Coins engine
// ------------

//#define USE_COINS						// Coin engine activated
//#define COIN_TILE				13		// Coin is tile #X
//#define COIN_FLAG				1		// Coins are counted in flag #N
//#define COIN_TILE_DEACT_SUBS	0		// Substitute with this tile if coins are OFF.
//#define COINS_DEACTIVABLE				// Coins can be hidden.

// Fixed screens engine
// --------------------
#define FIXED_SCREENS					// If defined, you can't exit a screen running off an edge
#define SHOW_LEVEL_INFO					// If defined, show "LEVEL XX" before level start, XX=n_pant
//#define SHOW_LEVEL_SUBLEVEL			// If defined, level # is XX/YY using y_map and x_map resp.
#define RESPAWN_REENTER 				// If you die, reenter screen. (redraw)
#define RESPAWN_SHOW_LEVEL				// Besides, show level info.
#define RESPAWN_FLICKER					// Start level flickering.
#define RESET_BODY_COUNT_ON_ENTER		// Reset body count when entering new screen
#define USE_SUICIDE_KEY

// Boxes engine
// ------------
#define PLAYER_PUSH_BOXES 				// If defined, tile #14 is pushable
#define FALLING_BOXES					// If defined, boxes can fall off ledges.
#define FALLING_BOXES_SPEED 	4		// Boxes fall every nth frame.
#define ENEMIES_BLOCK_BOXES				// If defined, you can't push a box if it collides an enemy
#define BOXES_KILL_ENEMIES				// If defined, falling boxes can kill enemies.
#define BOXES_ONLY_KILL_TYPE 	1		// If defined, only enemies type N can be killed with boxes.
#define BOXES_KILL_PLAYER				// If defined, falling boxes can kill the player.

// Shooting behaviour (only side view!)
// ------------------------------------

//#define PLAYER_CAN_FIRE 				// If defined, shooting engine is enabled.
//#define PLAYER_BULLET_SPEED 	8		// Pixels/frame. 
//#define MAX_BULLETS 			3		// Max number of bullets on screen. Be careful!.
//#define PLAYER_BULLET_Y_OFFSET	4	// vertical offset from the player's top.
//#define ENEMIES_LIFE_GAUGE	5		// Amount of shots needed to kill enemies.

//#define FIRING_DRAINS_LIFE			// If defined, firing drains life (oi!)
//#define FIRING_DRAIN_AMOUNT	2		// what to substract when firing.

//#define PLAYER_CAN_HIDE				// If defined, tile type 2 hides player.
//#define RANDOM_RESPAWN				// If defined, automatic flying enemies spawn on killed enemies
//#define USE_TYPE_6					// If defined, type 6 enemies are enabled.
//#define USE_SIGHT_DISTANCE			// If defined, type 6 only pursue you within sight distance
//#define SIGHT_DISTANCE		120		
//#define FANTY_MAX_V 			256 	// Flying enemies max speed.
//#define FANTY_A 				16		// Flying enemies acceleration.
//#define FANTIES_LIFE_GAUGE	10		// Amount of shots needed to kill flying enemies.

// Scripting
// ---------

#define ACTIVATE_SCRIPTING			  	// Activates msc scripting and flag related stuff.
#define WIN_ON_SCRIPTING				// Game can only be won using WIN GAME in the script
#define SCRIPTING_DOWN					// Use DOWN as the action key.
#define COUNT_KILLABLE_ON		2		// Count killable enemies on flag #N (per screen basis)
//#define SCRIPTING_KEY_M				// Use M as the action key instead.
//#define OBJECTS_ON_VAR		2		// If defined, only show objects if var # is set.
//#define OBJECT_COUNT			3		// Defines which FLAG will be used to store the object count.
//#define REENTER_ON_ALL_OBJECTS		// If set, re-enter screen when all objects are got, instead of ending

// Top view:
// ---------

//#define PLAYER_MOGGY_STYLE			// Enable top view.
//#define PLAYER_NO_INERTIA				// Disable inertia
//#define PLAYER_CONST_V		256		// Constant speed

// Side view:
// ----------

#define PLAYER_HAS_JUMP 				// If defined, player is able to jump.
//#define PLAYER_HAS_JETPAC 			// If defined, player can thrust a vertical jetpac
//#define JETPAC_DRAINS_LIFE			// If defined, flying drains life.
//#define JETPAC_DRAIN_RATIO	3		// Drain 1 each X frames.
//#define JETPAC_DRAIN_OFFSET	8		// Drain after X frames.
//#define PLAYER_KILLS_ENEMIES		  	// If defined, stepping on enemies kills them
//#define PLAYER_MIN_KILLABLE 	3		// Only kill enemies with id >= PLAYER_MIN_KILLABLE


// ============================================================================
// III. Screen configuration
// ============================================================================

// This sections defines how stuff is rendered, where to show counters, etcetera

#define VIEWPORT_X				1		//
#define VIEWPORT_Y				2		// Viewport character coordinates

#define LIFE_X					8		//
#define LIFE_Y					22		// Life gauge counter character coordinates
//#define DRAW_HI_DIGIT	
//#define LIFE_H_X 				1
//#define LIFE_H_Y				8

//#define OBJECTS_X				29		//
//#define OBJECTS_Y				23		// Objects counter character coordinates
//#define OBJECTS_ICON_X		2		// 
//#define OBJECTS_ICON_Y		21		// Objects icon character coordinates (use with ONLY_ONE_OBJECT)

//#define KEYS_X				28		//
//#define KEYS_Y				21		// Keys counter character coordinates

//#define SHOW_KILLED
//#define SHOW_TOTAL
//#define KILLED_X				20		//
//#define KILLED_Y				21		// Kills counter character coordinates

// Use this to show tile = ITEM_FIRST_TILE + flags [ITEM_IN_FLAG] - 1 at coordinates
// ITEM_SHOW_X, ITEM_SHOW_Y.

//#define PLAYER_SHOW_ITEM				// If defined, current item is shown (scripting needed)
//#define ITEM_IN_FLAG			4		// Which flag is used to store current item.
//#define ITEM_FIRST_TILE		17		// First tile in tileset representing an object
//#define ITEM_SHOW_X			2		//
//#define ITEM_SHOW_Y			21		// Position

//#define COINS_X 				12 		// Coins coint character coordinates
//#define COINS_Y				23

//#define EVIL_GAUGE_X			21		// For evil zone counters
//#define EVIL_GAUGE_Y			23

// Line of text

#define LINE_OF_TEXT			23
#define LINE_OF_TEXT_X			1
#define LINE_OF_TEXT_SUBSTR		2
#define LINE_OF_TEXT_ATTR 		7		

// Graphic FX, uncomment which applies...

//#define USE_AUTO_SHADOWS				// Automatic shadows made of darker attributes
//#define USE_AUTO_TILE_SHADOWS			// Automatic shadows using specially defined tiles 32-47.
//#define UNPACKED_MAP					// Full, uncompressed maps. Shadows settings are ignored.
#define NO_ALT_BG						// No alternative tile 19 for bg = 0
#define NO_MAX_ENEMS					// Less than 3 enems in some screens
//#define NO_MASKS						// Sprites are rendered using OR instead of masks.
//#define PLAYER_ALTERNATE_ANIMATION	// If defined, animation is 1,2,3,1,2,3... 
//#define TWO_SETS						// If defined, two sets of tiles. Second set is activated if
//#define TWO_SETS_CONDITION	(n_pant>14?32:0)	// Must return 32 if second tileset is active, 0 otherwise.

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
#define PLAYER_MAX_VY_SALTANDO	256 	// Max jump velocity (320/64 = 5 píxels/frame)
#define PLAYER_INCR_SALTO		16		// acceleration while JUMP is pressed (48/64 = 0.75 píxeles/frame^2)

#define PLAYER_INCR_JETPAC		48		// Vertical jetpac gauge
#define PLAYER_MAX_VY_JETPAC	384 	// Max vertical jetpac speed

// IV.2. Horizontal (side view) or general (top view) movement.

#define PLAYER_MAX_VX			256 	// Max velocity (192/64 = 3 píxels/frame)
#define PLAYER_AX				64		// Acceleration (24/64 = 0,375 píxels/frame^2)
#define PLAYER_RX				48		// Friction (32/64 = 0,5 píxels/frame^2)

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

#ifndef UNPACKED_MAP
#ifdef TWO_SETS
// Fill this array for dual tileset maps.
unsigned char comportamiento_tiles [] = {
	0, 3, 3, 3, 3, 3, 8, 8, 8, 8, 4, 3, 3, 0, 3, 4,
	8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0,
	0, 0, 8, 8, 1, 0, 0, 8, 8, 8, 4, 0, 0, 0, 0, 4	
};
#else
// Fill this array for normal, packed maps. The second row
// is defined if you want to use tiles 20-31 in your scripts.
// Remove it if you are not using extra tiles at all. And remember
// that tiles 16 to 19 MUST be 0.
unsigned char comportamiento_tiles [] = {
	0, 8, 8, 4, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
	0, 0, 0, 0, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0
};
#endif
#else
// Fill this array if you are using unpacked maps.
unsigned char comportamiento_tiles [] = {
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0,
	0, 0, 4, 8, 8, 4, 8, 8, 4, 4, 8, 0, 0, 2, 0, 0,
	0, 0, 4, 4, 0, 8, 2, 2, 2, 2, 8, 0, 2, 2, 2, 8	
};
#endif
