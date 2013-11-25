// Config.h
// Generado por GameConfig de la churrera
// Copyleft 2010 The Mojon Twins

// ***********************************************
// Datos sobre el movimiento del jugador principal
// ***********************************************

// Movimiento vertical: 
// ====================
//
// 1.- PLAYER_G siempre se suma a la velocidad vertical del jugador y le hace caer.
// 2.- Cuando se pulsa la tecla de salto, primero se hace que la velocidad vertical del juga-
//     dor sea PLAYER_VY_INICIAL_SALTO, y en cada frame mientras se sigue pulsando la tecla
//     se le suma PLAYER_INCR_SALTO hasta que se alcanza PLAYER_MAX_VY_SALTANDO.

#define PLAYER_MAX_VY_CAYENDO	512		// Velocidad máxima cuando cae (512/64 = 8 píxels/frame)
#define PLAYER_G				32		// Aceleración de la gravedad (32/64 = 0.5 píxeles/frame^2)

#define PLAYER_VY_INICIAL_SALTO	64		// Velocidad inicial al saltar (64/64 = 1 píxel/frame)
#define PLAYER_MAX_VY_SALTANDO	320		// Velocidad máxima al saltar (320/64 = 5 píxels/frame)
#define PLAYER_INCR_SALTO 		48		// Aceleración al pulsar "salto" (48/64 = 0.75 píxeles/frame^2)

// Movimiento horizontal:
// ======================
//
// 1.- Si el jugador pulsa IZQ o DER, la velocidad horizontal del jugador se va incrementando
//     según PLAYER_AX hasta que se llega a PLAYER_MAX_VX, a partir de entonces sigue constante.
// 2.- Si no se pulsa IZQ o DER, la velocidad horizontal del jugador se va decrementando según
//     PLAYER_RX hasta que se llega a 0.

#define PLAYER_MAX_VX			192		// Velocidad máxima horizontal (192/64 = 3 píxels/frame)
#define PLAYER_AX				24		// Aceleración horizontal (24/64 = 0,375 píxels/frame^2)
#define PLAYER_RX				32		// Fricción horizontal (32/64 = 0,5 píxels/frame^2)

// Valores generales
// =================

#define PLAYER_LIFE				99		// Vida máxima (con la que empieza, además)
#define PLAYER_REFILL			10		// Recarga de vida.

// ****************************************
// Datos sobre la configuración de pantalla
// ****************************************

#define VIEWPORT_X				1		//
#define VIEWPORT_Y				2		// Posición de la ventana de juego (en carácteres)
#define LIFE_X					4		//
#define LIFE_Y					0		// Posición del marcador de vida (en carácteres)
#define OBJECTS_X				11		//
#define OBJECTS_Y				0		// Posición del marcador de objetos (en carácteres)
#define KEYS_X					18		//
#define KEYS_Y					0		// Posición del marcador de llaves (en carácteres)

// *************************************
// Datos sobre la configuración del mapa
// *************************************

#define MAP_W 					6		//
#define MAP_H					5		// Dimensiones del mapa, en pantallas.
#define SCR_INICIO				24		// Pantalla de inicio
#define PLAYER_INI_X			2		//
#define PLAYER_INI_Y			2		// Coordenadas de inicio del jugador, a nivel de tiles
#define SCR_FIN					99		// Pantalla del final. 99 si da igual.
#define PLAYER_FIN_X			99		//
#define PLAYER_FIN_Y			99		// Posición del jugador para terminar, a nivel de tiles
#define PLAYER_NUM_OBJETOS		25		// Número de objetos para terminar el juego

// ****************************
// Comportamiento de cada tile.
// ****************************

// Indica el comportamiento de cada uno de los 16 tiles. Recuerda que el tile nº 15 (el último)
// es el cerrojo y debe ser un obstáculo, porque si no, vaya mierda de cerrojo.

// 0 = traspasable.
// 1 = traspasable y mata.
// 2 = obstáculo

unsigned char comportamiento_tiles [] = {
	0, 2, 2, 0, 0, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2
};
