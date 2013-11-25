// Config.h
// Generado por GameConfig de la churrera
// Copyleft 2010 The Mojon Twins

// ============================================================================
// I. Configuración general del juego
// ============================================================================

// En esta sección configuramos las dimensiones del mapa, pantalla y posición iniciales,
// pantalla y posición finales (si aplica), número de objetos que hay que recoger, etcétera.

#define MAP_W 					5		//
#define MAP_H					5		// Dimensiones del mapa, en pantallas.
#define SCR_INICIO				15		// Pantalla de inicio
#define PLAYER_INI_X			1		//
#define PLAYER_INI_Y			2		// Coordenadas de inicio del jugador, a nivel de tiles
#define SCR_FIN					99		// Pantalla del final. 99 si da igual.
#define PLAYER_FIN_X			99		//
#define PLAYER_FIN_Y			99		// Posición del jugador para terminar, a nivel de tiles
#define PLAYER_NUM_OBJETOS		31		// Número de objetos para terminar el juego
#define PLAYER_LIFE				99		// Vida máxima (con la que empieza, además)
#define PLAYER_REFILL			25		// Recarga de vida.

// ============================================================================
// II. Tipo de motor
// ============================================================================

// En esta sección definimos el tipo de motor que será compilado con el juego. En esta 
// versión 2.0 tenemos dos tipos básicos y excluyentes: top-view (MOGGY_STYLE) y de plataformas.
// Para emplear uno u otro deberemos descomentarlo eliminando las marcas /* y */ de principio
// y fin de bloque.

/*
// Motor top-view (MOGGY-STYLE)

#define PLAYER_MOGGY_STYLE				// Vista cenital, movimiento 8-way
#define PLAYER_AUTO_CHANGE_SCREEN		// Si se define, se cambiará de pantalla sin pulsar una dirección.
*/

/*
// Motor de plataformas

#define	PLAYER_HAS_JUMP					// Si se define, el personaje principal SALTA
#define PLAYER_HAS_JETPAC				// Si se define, el personaje principal tiene JET PAC
*/

// Los siguientes defines pueden aplicarse a cualquiera de los dos tipos de motores y definen
// comportamiento extra:

// #define PLAYER_PUSH_BOXES			// Si se define, el jugador podrá empujar los tiles #14

// ============================================================================
// III. Configuración de la pantalla
// ============================================================================

// En esta sección colocamos los elementos en la pantalla: la ventana de juego y los tres
// marcadores (vida, objetos y llaves) definiendo su posición a nivel de carácteres.
// También definimos si queremos sombreado automático (los tiles obstáculo dejan sombra sobre
// los de segundo plano), y de qué tipo:

#define VIEWPORT_X				1		//
#define VIEWPORT_Y				0		// Posición de la ventana de juego (en carácteres)
#define LIFE_X					14		//
#define LIFE_Y					21		// Posición del marcador de vida (en carácteres)
#define OBJECTS_X				19		//
#define OBJECTS_Y				21		// Posición del marcador de objetos (en carácteres)
#define KEYS_X					24		//
#define KEYS_Y					21		// Posición del marcador de llaves (en carácteres)

// Sombras: descomentar la que aplique, o ninguna.

//#define USE_AUTO_SHADOWS				// Sombras automáticas por atributos
//#define USE_AUTO_TILE_SHADOWS			// Sombras automáticas por tiles-

// ============================================================================
// IV. Configuración del movimiento del jugador
// ============================================================================

// En esta sección definimos las constantes que gobiernan los parámetros del motor de movimiento.
// En un juego tipo plataformas, definimos por separado el comportamiento en vertical y el compor-
// tamiento en horizontal. Para un juego tipo top-view, los valores definidos en el comportamiento
// horizontal se aplican también al vertical.

// IV.1. Movimiento vertical, sólo aplicable al motor de plataformas:

#define PLAYER_MAX_VY_CAYENDO	512		// Velocidad máxima cuando cae (512/64 = 8 píxels/frame)
#define PLAYER_G				32		// Aceleración de la gravedad (32/64 = 0.5 píxeles/frame^2)

#define PLAYER_VY_INICIAL_SALTO	64		// Velocidad inicial al saltar (64/64 = 1 píxel/frame)
#define PLAYER_MAX_VY_SALTANDO	320		// Velocidad máxima al saltar (320/64 = 5 píxels/frame)
#define PLAYER_INCR_SALTO 		48		// Aceleración al pulsar "salto" (48/64 = 0.75 píxeles/frame^2)

#define PLAYER_INCR_JETPAC		32		// Incremento al usar el jetpac
#define PLAYER_MAX_VY_JETPAC	256		// Máxima velocidad vertical con jetpac

// IV.2. Movimiento horizontal (en motor de plataformas) o general (en motor top-view):

#define PLAYER_MAX_VX			256		// Velocidad máxima horizontal (192/64 = 3 píxels/frame)
#define PLAYER_AX				16		// Aceleración horizontal (24/64 = 0,375 píxels/frame^2)
#define PLAYER_RX				0		// Fricción horizontal (32/64 = 0,5 píxels/frame^2)

// ============================================================================
// V. Comportamiento de los tiles
// ============================================================================

// Indica el comportamiento de cada uno de los 16 tiles. Recuerda que el tile nº 15 (el último)
// es el cerrojo y debe ser un obstáculo, porque si no, vaya mierda de cerrojo.

// 0 = traspasable.
// 1 = traspasable y mata.
// 2 = obstáculo

unsigned char comportamiento_tiles [] = {
	0, 1, 2, 2, 2, 2, 1, 0, 0, 2, 2, 0, 0, 1, 2, 2
};
