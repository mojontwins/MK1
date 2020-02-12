20200212
========

Empezamos. La idea es reconstruir **Cheril the Goddess**, que usaba una versión bastante modificada de la churrera que luego se convirtió en la rama abandonada 4, con v5 usando sólo cosas del motor e inyección de código y ampliando los puntos en caso de ser necesario.

En **Cheril the Goddess** Cheril puede volar y disparar bolas, pero esto le resta vida. Además, la cantidad de vida restada por el impacto de los enemigos voladores o los lineales es diferente. Todo esto NO es posible directamente con v5 y la idea es introducir los cambios mínimos para poder añadir esta funcionalidad de forma externa mediante la inyección de código.

Los temas que restan vidas pueden ser peliagudos. Ahora mismo la forma de matar al player consiste en levantar `p_killme`. Esto llamará a `player_kill` desde `game_loop`, que restará una vida, haciendo un sonido. El estado parpadeante ahora mismo se pone en los dos sitios separados que te matan, y quizá esto habría que centralizarlo. Podemos aprovechar para ampliar esto y permitir más flexibilidad. Así lo haremos:

```c
	void player_deplete (void) {
		p_life = (p_life > p_kill_amt) ? p_life - p_kill_amt : 0;
	}

	void player_kill (void) {
		p_killme = 0;
		player_deplete ();

		#ifdef MODE_128K
			wyz_play_sound (sound);
		#else
			beep_fx (sound);
		#endif

		#ifdef CP_RESET_WHEN_DYING
			#ifdef CP_RESET_ALSO_FLAGS
				mem_load ();
			#else
				n_pant = sg_pool [MAX_FLAGS];
				p_x = sg_pool [MAX_FLAGS + 1] << 10;
				p_y = sg_pool [MAX_FLAGS + 2] << 10;
			#endif	
			o_pant = 0xff; // Reload
		#endif	

		#ifdef PLAYER_FLICKERS
			p_estado = EST_PARP;
			p_ct_estado = 50;
		#endif		
	}
```

En condiciones normales, `p_kill_amt` valdrá siempre 1 (lo colocaremos al principio de cada vuelta de juego). *Factores externos* podrán modificar el valor si es necesario. Es una implementación poco robusta pero morir no se da a menudo y es muy difícil que se junten dos causas.

## Jetpac resta vida

Para implementar esto vamos a introducir un nuevo CIP, `my/ci/on_jetpac_boost.h`. Aquí podemos restar vida si es necesario llamando a `player_deplete`.

## Disparar resta vida

De la misma forma, introduciremos un nuevo CIP `my/ci/on_player_fires.h`. Aquí podemos restar vida si es necesario llamando a `player_deplete`.

## Colisiones según el tipo

Las colisiones con los enemigos restan una cantidad diferente de vida dependiendo del tipo en **Cheril the Goddess**. Para implementar esto añadiremos el CIP `my/ci/on_enems_collision.h`, y ahí podremos mirar `_en_t` y actuar en consecuencia.

## Vida de más de 99

Este juego introduce una complejidad muy innecesaria, a mi actual modo de ver: La vida puede valer hasta 100. Las centenas se mueven al marcador de las vidas, y luego hay otro marcador con la "fuerza", que son las decenas y las unidades. Así cuando "recargas" en un recargador, la vida sube a 1.

Esto es una estupidez. Voy a poner 99 y a quitar el marcador de vidas.

## Niveles de dificultad

El juego presentaba tres niveles de dificultad, que modificaban los valores `FANTIES_SIGHT_DISTANCE`, `FANTIES_LIFE_GAUGE` (presentes en v5), y los valores de `JETPAC_DRAIN_RATIO` (baja 1 cada X frames) y `JETPAC_DRAIN_OFFSET` (empieza a bajar tras X frames), `FIRING_DRAIN_AMOUNT` (cuanto bajar al disparar), `LINEAR_ENEMY_HIT` y `FLYING_ENEMY_HIT` según esta tabla:

```c
	// Difficulty levels.
	typedef struct {
		unsigned char sight_distance;
		unsigned char fanties_life_gauge;
		unsigned char jetpac_drain_ratio;
		unsigned char jetpac_drain_offset;
		unsigned char firing_drain_amount;
		unsigned char linear_enemy_hit;
		unsigned char flying_enemy_hit;
	} DIFFICULTY;

	DIFFICULTY difficulty [3] = {
		{60, 5, 4, 10, 1, 5, 15},		// EASY
		{80, 10, 3, 8, 2, 10, 25},		// MEDIUM
		{100, 15, 2, 4, 3, 15, 30}		// HARD	
	};

	unsigned char difficulty_level;
	void set_difficulty (unsigned char level) {
		difficulty_level = level;
		SIGHT_DISTANCE = difficulty [level].sight_distance;
		FANTIES_LIFE_GAUGE = difficulty [level].fanties_life_gauge;
		JETPAC_DRAIN_RATIO = difficulty [level].jetpac_drain_ratio;
		JETPAC_DRAIN_OFFSET = difficulty [level].jetpac_drain_offset;
		FIRING_DRAIN_AMOUNT = difficulty [level].firing_drain_amount;
		LINEAR_ENEMY_HIT = difficulty [level].linear_enemy_hit;
		FLYING_ENEMY_HIT = difficulty [level].flying_enemy_hit;
	}
```

Todo esto es factible con el motor tal y como está. Podemos asignar las macros `FANTIES_SIGHT_DISTANCE` y `FANTIES_LIFE_GAUGE` dos variables y controlar el resto de las cosas de forma custom. El menú se puede presentar facilmente en `my/ci/before_game.h`.

~~

Voy a divagar sobre cómo implementar el reordenado de los objetos sin depender de scripting y usando únicamente hotspots. En este juego no hay "dos cosas" en ninguna pantalla, así que se puede hacer esto.

El tema es el siguiente: tenemos tres objetos: piedra, papel, tijera. Debemos reordenarlos en sus templos correctamente, llevando uno cada vez. Cuando no llevas nada y das acción sobre uno, lo coges. Si llevas uno y das acción sobre otro, se intercambia. Ojal que esto no era originalmente así, pero así es más mejor.

En AGNES, por ejemplo, este tipo de interacciones se gestiona con un tipo específico de hotspots que registran como contenedores. Voy a ver cómo hacerlo aquí usando c.i., a ser posible sin más añadidos.

Supongamos que tenemos `p_inv` para almacenar qué objeto lleva el usuario, y los hotspots de tipo 5, 6, 7 y 8 representando "piedra", "papel", "tijeras" y "llave". Tengamos el hotspot de tipo 4 (que tiene un gráfico vacío, el 20, lo que nos viene genial) como "vacío".

Podemos empezar con `p_inv` valiendo 4, y luego hacer que los hotspots de tipo 4 a 8 se activen al pulsar *abajo* y que lo que hagan sea interacambiar su *tipo* `hotspots [n_pant].tipo` con `p_inv`. La condición de "activación" (todos están bien puesto) se basaría en comprobar que los `hotspots [n_pant].tipo` para las `n_pant` de los templos sean los correctos.

¡Voie la! En el `README.md` tengo que explicar bien toda esa implementación.

Cuando están los tres objetos, aparece un cerrojo. Me basta con crear un hotspot de tipo 12 en la pantalla correcta. Ya iré resolviendo según vaya haciendo.

De la misma manera puedo hacer los recargadores. El tile correspondiente al hotspot tipo 2 (que suele ser las llaves) también está vacío. Lo puedo colocar sobre los pedestales y actuar sobre él de la misma manera que con los contenedores de objetos.

Lo suyo sería poder parametrizar todo lo posible esto para que se pueda meter otra fase o algo así según se vaya antojando. O no, meter otra fase una vez dentro del templo que sea más arcade.
