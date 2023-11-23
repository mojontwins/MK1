# Impossamal

Aquí apunto las modificaciones via Inyección de Código que he hecho para preparar la base sobre la que **Anjuel** construirá el juego.

## Rebotar contra las paredes

Esto lo he logrado empleando los CIP `my/ci/bg_collision/obstacle_left/` y `my/ci/bg_collision/obstacle_right.h`. Para saltarme el `p_vx = 0` que hay juto después, pongo `if`s que siempre evalúan a cierto y termino con un `else`, así:

```c
    // obstacle_left

    if (p_vy < 0)       // Siempre se va a cumplir
        p_vy = -p_vy;   // Rebotar
    else
```

```c
    // obstacle_right

    if (p_vy > 0)       // Siempre se va a cumplir
        p_vy = -p_vy;   // Rebotar
    else
```

## Frenar verticalmente pulsando abajo

Esto lo conseguimos añadiendo código en `my/ci/custom_veng.h` sin desactivar `PLAYER_BOOTEE`:

```c
	// custom_vemg.h

	if ((pad0 & sp_DOWN) == 0) {
		if (p_vy < -P_MAX_VY_FRENANDO) p_vy = -P_MAX_VY_FRENANDO;
	}
```

```c
	// extra_vars.h

	 #define P_MAX_VY_FRENANDO 128
```

## Animación custom

Hemos añadido dos cells de animación de la pelota comprimiéndose al chocar horizontal o verticalmente. Para la animación hacemos algo de fullería: 

- En `my/ci/custom_veng.h` establecemos una variable `rebound` (que definiremos en `my/ci/extra_vars`) a  `COLL_NONE` (que estableceremos en `my/ci/extra_vars`)..
- En `my/ci/bg_collision/obstacle_up.h` y `my/ci/bg_collision/obstacle_up.h` le damos el valor `COLL_VERT` (que estableceremos en `my/ci/extra_vars`).
- En `my/ci/bg_collision/obstacle_up.h` y `my/ci/bg_collision/obstacle_up.h` le damos el valor `COLL_HORZ` (que estableceremos en `my/ci/extra_vars`).
- Activaremos `PLAYER_CUSTOM_ANIMATION`
- En `my/custom_animation.h` estableceremos el cell que sea según el valor de `rebound`.

```c
	// extra_vars.h

	unsigned char rebound;

	#define COLL_NONE 0
	#define COLL_VERT 1
	#define COLL_HORZ 2
```

```c
	// obstacle_up.h y obstacle_down.h

	rebound = COLL_VERT;
```

```c
	// obstacle-left.h y obstacle_right.h

	// Al principìo, antes del código que añadimos antes

	rebound = COLL_HORZ;
```

```c
	// custom_animation.h

	p_next_frame = player_cells [rebound];
```

La clave es tener los tres cells en el orden correcto en el spriteset: primero normal, después comprimido verticalmente, y finalmente comprimido horizontalmente.

## Romper bloques

La idea es poder romper los bloques obstáculo rompiscibles (beh 24 = 8 + 16) al golpearlos. Se consigue así. Primero añadimos dos nuevas rutinas, `break_horizontal` y `break_vertical` en `my/ci/extra_functions.h`:

```c
	// extra_functions.h

	void break_horizontal (void) {
		_x = cx1;
		if (at1 & 16) {
			_y = cy1; break_wall ();
		} 
		if (cy1 != cy2 && (at2 & 16)) {
			_y = cy2; break_wall ();
		}
	}

	void break_vertical (void) {	
		_y = cy1;
		if (at1 & 16) {
			_x = cx1; break_wall ();
		} 
		if (cx1 != cx2 && (at2 & 16)) {
			_x = cx2; break_wall ();
		}	
	}
```

Que abusan (reusan) de las coordenadas de colisión precalculadas para eliminar un tile. Ahora sólo hay que engancharlas en los `my/ci/bg_collision/obstacle_*.h`; `break_vertical ()` en `obstacle_down.h` y `obstacle_up.h`, `break_horizontal ()` en `obstacle_left.h` y `obstacle_right.h`. 