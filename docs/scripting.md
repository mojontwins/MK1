SCRIPTING
=========

Documentación "al menos algo es algo" sobre msc3 y el sistema de scripting de MK2. 

Copyleft 2010-2015 the Mojon Twins

Target: lo suyo es que controles, al menos, la Churrera y su scripting. Viene bien conocer MK2. Al menos un poquito.

Este documento es válido para MK2 v.0.88c y msc 3.91

*DISCLAIMER: msc3 soporta más comprobaciones/comandos que no salen en este documento (pero sí en motor-de-clausulas.txt). No se garantiza que funcionen. Algunos directamente no lo harán (son de la rama 4 de la Churrera).*

*DISCLAIMER 2: Con el scripting se pueden hacer cosas increíbles. Cosas que ni te imaginas. Nosotros hemos hecho cosas que ni nos imaginábamos que fueran posibles. Miles de accidentes afortunados y cosas asín. Dale vueltas, probablemente encuentres la solución. Y si no, puedes preguntar. Pero dale vueltas antes. Confiamos en tí. Dale, Fran.*

msc3
====

msc3 significa "Mojon Script Compiler 3".

msc3 es el compilador de scripts. Comenzó siendo una solución sencilla para compilar scripts basados en cláusulas en un bytecode fácilmente interpretable por el motor, pero se ha convertido en un monstruo increíble de múltiples tentáculos y cambiantes formas, como un pequeño Nyarlathotep.

msc3 genera un archivo binario script.bin con el bytecode del script y un par de archivos .h que contienen el intérprete y su configuración (msc.h y msc-config.h).

msc3 necesita poco para funcionar: un script, el número de pantallas en total que tiene el mapa global de nuestro juego (*), y si debe preparar el intérprete para funcionar desde la RAM extra de los modelos de 128K.

msc3 se ejecuta desde linea de comandos y su sintaxis es:

> msc3.exe archivo.spt N [rampage]

Donde archivo.spt es el archivo con el script que hay que compilar, N es el número de pantallas de nuestro juego (*), y [rampage] es un parámetro opcional que, si se indica, hace que msc3 genere un intérprete preparado para interpretar script.bin desde una página de RAM extra de los modelos de 128K.

(*) En juegos multi-nivel en el que cada nivel tiene un número de pantallas, se refiere al tamaño máximo en pantallas para el que se reserva memoria en RAM baja, o sea, el resultado de multiplicar MAP_W por MAP_H.

Motor de cláusulas
==================

Los scripts de MK2 se organizan en secciones. Cada sección se ejecutará en un momento preciso y en una pantalla precisa. 

Principalmente tenemos secciones tipo ENTERING, que se ejecutarán al entrar en una pantalla, secciones PRESS_FIRE, que se ejecutarán al pulsar la tecla de acción, y secciones especiales que responderán a diversos eventos. Estos son los tipos de secciones:

```
ENTERING SCREEN x
```

Se ejecuta cada vez que el jugador entra en la pantalla x

```
ENTERING GAME
```

Se ejecuta al empezar cada partida, y sólo esta vez.

```
ENTERING ANY
```

Se ejecuta al entrar en cada pantalla, justo antes que `ENTERING SCREEN x`

```
PRESS_FIRE AT SCREEN x
```

Se ejecuta cuando el jugador pulsa la tecla de acción en la pantalla x.

```
PRESS_FIRE AT ANY
```

Se ejecuta cuando el jugador pulsa la tecla de acción en cualquier pantalla, justo antes que `PRESS_FIRE AT SCREEN x`

```
ON_TIMER_OFF
```

Se ejecuta cuando el temporizador llega a cero, siempre que hayamos definido la directiva `TIMER_SCRIPT_0` en config.h

```
PLAYER_GETS_COIN
```

Se ejecuta cuando el jugador toca un tile `TILE_GET`. Necesita tener activada y configurada la funcionalidad `TILE_GET` en config.h así como la directiva `TILE_GET_SCRIPT`.

```
PLAYER_KILLS_ENEMY
```

Se ejecuta cuando el jugador mata a un enemigo, siempre que hayamos definido la directiva `RUN_SCRIPT_ON_KILL` en config.h

-

Los scripts `PRESS_FIRE` se ejecutarán en más supuestos además de cuando el jugador pulse acción:

- Si tenemos `#define ENABLE_FIRE_ZONE` en config.h, hemos definido una zona de acción con `SET_FIRE_ZONE` en nuestro script, y el jugador entra en dicha zona.

- Si empujamos un bloque y tenemos definido en config.h las directivas `ENABLE_PUSHED_SCRIPTING` y `PUSHING_ACTION`.

- Cada vez que un "floating object" se ve afectado por la gravedad y cae, si tenemos definido `ENABLE_FO_SCRIPTING` y `FO_GRAVITY`.

En versiones anteriores de MK2 y la Churrera también se lanzaban al matar un enemigo, pero se ha sustituido por la sección `PLAYER_KILLS_ENEMY`.

Varios niveles
==============

Podemos definir script para varios niveles. El mejor ejemplo actual para verlo en acción es Ninjajar!. En nuestro archivo de script concatenamos los scripts de nuestros niveles uno detrás de otro separados por una linea

```
END_OF_LEVEL
```

Al compilar, msc3 generará una constante para identificar dónde empieza cada script para cada nivel que podremos usar en nuestro `level_manager` o como mejor nos convenga. La constante será del tipo `SCRIPT_X` con X el número de orden del script dentro del archivo .spt.

Sin embargo, a partir de MK2 0.90 podemos tener más control sobre esto. Si incluimos al principio de una sección de nuestro script (en realidad puede aparecer en cualquier sitio antes de `END_OF_LEVEL`, pero seamos ordenados) una linea

```
LEVELID xxxxx
```

Con "xxxxx" un literal alfanumérico, este literal será empleado como nombre de la constante generada. En lugar de `SCRIPT_X` será lo que pongamos nosotros, lo que nos dará quizá un poco más de control y legibilidad a la hora de montar nuestro manejador de niveles.

Cláusulas
=========

Todas las secciones descritas arriba contendrán una lista de cláusulas. Cada cláusula se compone de una lista de comprobaciones y de una lista de comandos.

El intérprete recorrerá la lista de comprobaciones en orden, realizando cada comprobación. Si alguna falla, dejará de procesar la cláusula.

Si todas las comprobaciones han resultado ser ciertas, se ejecutará la lista de comandos asociada en orden.

La sintaxis es:

```
	IF COMPROBACION
	...
	THEN
	    COMANDO
	    ...
	END
```

Todas las cláusulas de una sección se ejecutan en orden, sin parar (a menos que así lo indiques con un comando `BREAK` o tras algunos comandos como `WARP_TO`, `WARP_TO_LEVEL`, `REHASH`, `REPOSTN` o `REENTER`). 

Muchas veces puedes ahorrar script y evitar usar BREAK. La mayoría de las veces el tiempo de ejecución de un script no es crítico y puedes permitirtelo.

En vez de:

```
	IF FLAG 1 = 0
	THEN
		SET TILE (2, 4) = 2
	    SET FLAG 1 = 1
	    
	    # Si no ponemos este break se ejecutará la siguiente
	    # cláusula sí o sí, ya que FLAG 1 = 1.
	    BREAK
	END 

	IF FLAG 1 = 1
	THEN
		SET TILE (2, 4) = 3
	END
```

Puedes hacer:

```
	IF FLAG 1 = 1
	THEN
		SET TILE (2, 4) = 3
	END

	IF FLAG 1 = 0
	THEN
		SET TILE (2, 4) = 2
		SET FLAG 1 = 1
	END
```

Y te ahorras un BREAK.
	
Flags
=====

El motor de scripting maneja un conjunto de banderas o flags que pueden contener un valor de 0 a 127 y que se utilizan como variables. Los flags suelen referenciarse como FLAG N con N de 0 a 127 en el script.

En casi todas las comprobaciones y comandos que admiten valores inmediatos se puede utilizar la construcción #N donde N es un número de flag, que significa "el valor del flag N".

Por ejemplo:

```
	IF FLAG 5 = #3
```

Será cierta si el valor del flag 5 es igual al valor del flag 3, o:

```
	WARP_TO #3, #4, #5
```

Saltará a la pantalla contenida en el FLAG 3, en la posición indicada por los flags 4 y 5. Por el contrario:

```
	WARP_TO 3, 4, 5
```

Saltará a la pantalla 3, en la posición (4, 5).

Sin modificaciones, MK2 permite 32 flags, pero este número puede cambiarse fácilmente editando el #define correspondiente en definitions.h:

```c
	#define MAX_FLAGS 32
```

Alias
=====

Para no tener que recordar tantos números de flags, esposible definir alias. Cada alias representa un número de flag, y comienzan con el caracter
"$". De este modo, podemos asociar por ejemplo el alias `$LLAVE` al flag 2 y usar en el script este alias en vez del 2:

```
	IF FLAG $LLAVE = 1
```

Los alias también funcionan con la construcción #N, de este modo si escribimos `#$NENEMS` nos referiremos al contenido del flag cuyo alias es `NENEMS`:

```
	IF FLAG $TOTAL = #$NENEMS
```

Se cumple si el valor del flag cuyo alias es `$TOTAL` coincide con el valor del flag cuyo alias es `$NENEMS`.

Los alias deben definirse al principio del script (en realidad pueden definirse en cualquier parte del script, pero sólo serán válidos en la parte del script que viene después) en una sección `DEFALIAS` que debe tener el siguiente formato:

```
	DEFALIAS
		$ALIAS = N
		...
	END
```

Donde `$ALIAS` es un alias y N es un número de flag. Definiremos un alias por cada linea. No es necesario definir un alias para cada flag.

A partir de la versión 3.92 de msc3, puedes obviar la palabra FLAG si usas alias. O sea, que el compilador aceptará

```
	SET $LLAVE = 1
```

y también 

```
	IF $LLAVE = 1
```

A partir de la versión 0.90 de MK2 (y de su correspondiente msc3.exe), podemos definir macros sencillos dentro de `DEFALIAS`. Los macros empiezan por el caracter %. Todo lo que venga después del nombre del macro se considera el texto de sustitución. Por ejemplo, si defines:

```
	%CLS EXTERN 0
```

Cada vez que pongas `%CLS` en tu código msc3 lo sustituirá por `EXTERN 0`.

Decoraciones
============

Cada script (y con esto quiero decir cada script de nivel incluido en nuestro archivo de script) puede incluir un set de decoraciones tal y como genera map2bin.exe. Para ello habrá que incluir la directiva INC_DECORATIONS al principio del script:

```
	INC_DECORATIONS archivo.spt
```

Donde archivo.spt es el archivo .spt que genera map2bin.exe

El intérprete dinámico
======================

msc3 genera un intérprete que sólo será capaz de entender las comprobaciones y comandos que hayas introducido en tu script. Esto se hace para ahorrar memoria no generando código que jamás se ejecutará.

A veces hay varias formas de conseguir una cosa en tu script. Si tienes que elegir, no elijas la que produzca un script más sencillo, sino la que haga que tengas que utilizar menos variedad de comprobaciones o de comandos, ya que un poco más de script ocupa muchísimo menos que el código C necesario para ejecutar una comprobación o comando.

Siempre cierto
==============

Hay una comprobación que siempre vale cierto y que se utiliza para ejecutar comandos en cualquier caso:

```
	IF TRUE
```

Comprobaciones y comandos relacionados con los flags
====================================================

Gran parte de tu script estará comprobando valores de los flags y modificando dichos valores. Para ello hay todo un set de comprobaciones y comandos.

Comprobaciones con flags
------------------------

```
IF FLAG x = n			Evaluará a CIERTO si el flag "x" vale "n"
    
IF FLAG x < n			Evaluará a CIERTO si el flag "x" < n
    
IF FLAG x > n			Evaluará a CIERTO si el flag "x" > n
    
IF FLAG x <> n			Evaluará a CIERTO si el flag "x" <> n
```

Estas otras cuatro son "legacy". Están aquí porque era la única forma de comparar dos flags en las primeras versiones del sistema de scripting,  pero pueden obviarse - de hecho DEBEN obviarse, ya que así ahorraremos código de intérprete.
    
```    
IF FLAG x = FLAG y		Evaluará a CIERTO si el flag "x" = flag "y"
						Equivale a IF FLAG x = #y
    
IF FLAG x < FLAG y		Evaluará a CIERTO si el flag "x" < flag "y"
						Equivale a IF FLAG x < #y
    
IF FLAG x > FLAG y		Evaluará a CIERTO si el flag "x" > flag "y"
						Equivale a IF FLAG x > #y
    
IF FLAG x <> FLAG y		Evaluará a CIERTO si el flag "x" <> flag "y"
						Equivale a IF FLAG x <> #y
```

Una de las cosas en mi TODO es modificar MSC para traducir automáticamente las construcciones "IF FLAG x <OP> FLAG y" a "IF FLAG X <OP> #y".

Comandos con flags
------------------

```
SET FLAG x = n			Da el valor N al flag X.
						Huelga decir que SET FLAG x = #y dará el valor del
						flag y al flag x. Pero ya lo he dicho.
						
INC FLAG x, n			Incrementa el valor del flag X en N.
    
DEC FLAG x, n			Decrementa el valor del flag X en N
    
FLIPFLOP x				Si x vale 0, valdrá 1. Si vale 1, valdrá 0.
						Lo que viene a ser un flip-flop, vaya.
						
SWAP x, y				Intercambia el valor de los flags x e y						
```

Estas dos son legacy ya que pueden simularse con INC/DEC FLAG. Lo mismo de antes, permanecen aquí desde las primeras versiones cuando no existía la construcción #N.
						
```
ADD FLAGS x, y			Hace x = x + y. 
						Equivale a INC FLAG x, #y
    
SUB FLAGS x, y			Hace x = x - y.
						Equivale a DEC FLAG x, #y
```

Cosas del motor que modifican flags
===================================

Todo este jaleo de flags sería mucho menos útil si el motor no pudiese modificarlos también dando información de estado. Ciertas directivas de config.h harán que ciertos flags se actualicen con valores del motor:

Número de objetos recogidos
---------------------------

Directiva `OBJECT_COUNT`

Con "objetos" me refiero a los objetos coleccionables automáticos que se colocan usando hotspots de tipo 1 en el Colocador.

Si se define esta directiva, el valor especificado indicará que flag debe actualizar el motor con el número de objetos que el jugador lleva  ecogidos. Por ejemplo

```c
	#define OBJECT_COUNT 1
```

Hará que el FLAG 1 contenga en todo momento el número de objetos que lleva el jugador recogidos. De ese modo,

```
	IF FLAG 1 = 5
```

Se cumpliará cuando el jugador haya recogido 5 objetos.

Número de enemigos en la pantalla
---------------------------------

Directiva `COUNT_SCR_ENEMS_ON_FLAG`

Si se define esta directiva, el motor contará cuántos enemigos activos hay en la pantalla a la hora de entrar en ella. Por ejemplo

```c
	#define COUNT_SCR_ENEMS_ON_FLAG 1
```

Hara que el FLAG 1 contenga el número de enemigos que había en la pantalla al entrar.

Número de enemigos eliminados
-----------------------------

Directiva `BODY_COUNT_ON`

Si se define esta directiva, el motor incrementará el flag especificado siempre que el jugador elimine un enemigo. Por ejemplo,

```c
	#define BODY_COUNT_ON 2
```

Hará que el FLAG 2 se incremente cada vez que el jugador mata un enemigo. Esto puede ser muy util para usarlo en conjunción con `COUNT_SCR_ENEMS_ON_FLAG`.

Siguiendo nuestro ejemplo (cuenta enemigos en pantalla en el flag 1, e incrementar el flag 2 al matar un enemigo), si al entrar en una nueva pantalla establecemos el flag 2 a 0 (resetear la cuenta de enemigos matados:

```
	ENTERING ANY
		IF TRUE
		THEN
			SET FLAG 2 = 0
		END
	END
```

Podemos controlar que hemos matado a todos los enemigos de la pantalla muy fácilmente, en la sección `PLAYER_KILLS_ENEMY`, que se ejecuta siempre que el jugador mata un enemigo:

```
	PLAYER_KILLS_ENEMY
		IF FLAG 2 = #1
		THEN
			# ¡Hemos matado a todos los enemigos de la pantalla!
		END
	END
```

Contar los TILE_GET
-------------------

Directiva `TILE_GET_FLAG`

El motor te permite definir un tile del mapa como "recogible". Por ejemplo, monedas. Puedes colocar monedas en el mapa, o hacerlas aparecer al romper una piedra (ver Ninjajar!). Si te has empapado whatsnew.txt sabrás que la directiva `TILE_GET n` hace que el tile "n" sea "recogible". Esto se utiliza en conjunción con la directiva `TILE_GET_FLAG`, de forma que cuando el jugador toque un tile número `TILE_GET` se incremente ese flag.

No se puede usar `TILE_GET` sin `TILE_GET_FLAG`, por supuesto.

Por ejemplo, puedes hacer que tu tile 10 sea un diamante y colocar estos diamantes por todo el mapa. Luego defines `TILE_GET` a 10 y `TILE_GET_FLAG` a 1. Cada vez que el jugador toque un diamante, este desaparecerá y el flag 1 se incrementará.

En Ninjajar se usa de un modo más complejo, en conjunción con la directiva `BREAKABLE_TILE_GET n`. En ninjajar está definido así:

```c
	#define BREAKABLE_TILE_GET 12
	#define TILE_GET 22
	#define TILE_GET_FLAG 1
```

Y produce este comportamiento: Si el jugador rompe el tile 12, que es la caja con estrellas (que en sus "behaviours" tiene activado el flag "rompible"), aparecerá el tile `TILE_GET`, que es el 22, la moneda. Si el jugador toca un tile 22 (una moneda), esta desaparecerá y se incrementará el flag 1, que es la cuenta del dinero que llevamos recogido.

Nótese que Ninjajar usa mapas de 16 tiles - las monedas sólo aparecerán al romper bloques estrella.

Todo esto funciona automáticamente, nosotros sólo tendremos que preocuparno de examinar el valor del FLAG definido en `TILE_GET_FLAG` desde nuestro script.

Bloques que se empujan
----------------------

Directivas `MOVED_TILE_FLAG`, `MOVED_X_FLAG` y `MOVED_Y_FLAG`

Si hemos activado que el jugador pueda empujar cajas (tile 14 del tileset, con "behaviour" = 10) mediante `#define PLAYER_PUSH_BOXES`, y además activamos la directiva `ENABLE_PUSHED_SCRIPTING`, cada vez que el jugador mueva una caja (o bloque, lo que sea que hayamos puesto en el tile 14 ;-) ), ocurrirá esto:

- El número de tile que se "pisa" se copiará en el flag `MOVED_TILE_FLAG`.
- La coordenada X a la que se mueve la caja se copia en el flag `MOVED_X_FLAG`.
- La coordenada Y a la que se mueve la caja se copia en el flag `MOVED_Y_FLAG`.

Si, además, definimos `PUSHING_ACTION`, se lanzarán las secciones `PRESS_FIRE` (la `ANY` y la correspondiente a la pantalla actual) y podremos hacer las comprobaciones inmediatamente.

Este sistema se emplea en Cadaverion (aunque sea un juego de la Churrera, esto funciona exactamente igual) para comprobar que hemos colocado las estatuas en sus pedestales.

Por ejemplo, si queremos abrir una puerta si se empuja una caja a la posición (7, 7) de la pantalla 4, podemos definir:

```c
	#define PLAYER_PUSH_BOXES
	#define ENABLE_PUSHED_SCRIPTING
	#define PUSHING_ACTION
	#define MOVED_TILE_FLAG		1	// Esto no lo vamos a usar en este ejemplo
	#define MOVED_X_FLAG		2
	#define MOVED_Y_FLAG		3
```

Y en nuestro script...

```
	PRESS_FIRE AT SCREEN 4
		IF FLAG 2 = 7
		IF FLAG 3 = 7
		THEN
			# La caja que hemos movido está en la posición 7,7
			# abrir puerta...
		END
	END
```

Si, por ejemplo, queremos que una puerta se abra siempre que se coloque una caja sobre un tile "pulsador", que hemos dibujado en el tile, digamos, 3, (con los mismos defines) tendríamos:

```
	PRESS_FIRE AT SCREEN 4
	    IF FLAG 1 = 3
	    THEN
	        # La caja que hemos movido está sobre un tile 3
	        # abrir puerta...
	    END
	END
```

Que se pueda o no disparar
--------------------------

Directiva `PLAYER_CAN_FIRE_FLAG`

Si tenemos nuestro motor configurado para un juego de disparos usando la directiva `PLAYER_CAN_FIRE` y sus compañeras, podemos definir que el jugador sólo pueda disparar si un flag determinado vale 1 dándole el número de ese flag a la directiva `PLAYER_CAN_FIRE_FLAG`. Por ejemplo:

```c
	#define PLAYER_CAN_FIRE_FLAG 4
```

Al principio del juego podemos hacer:

```
	ENTERING GAME
		IF TRUE
		THEN
		    SET FLAG 4 = 0
		END
	END
```

Con lo que el jugador no podrá disparar. Luego, más adelante, podemos hacer que el jugador encuentre una pistola y la recoja:

```
	... (donde sea)
		IF ... (condiciones de coger la pistola)
		THEN
		   SET FLAG 4 = 1
		   # Ahora el muñaco puede disparar
		END
	END
```

TODO: hacer lo mismo para el hitter (puño/espada). Pronto.

Golpeado por una "floating object" lanzable
-------------------------------------------

Directiva `CARRIABLE_BOXES_COUNT_KILLS`

En realidad, morir aplastado por una caja cuenta como incremento en el flag definido en `BODY_COUNT_ON`, pero por alguna misteriosa razón que no recuerdo (probablemente, desorganización mental) lo puse también separado.

Si se activa esta directiva el número de flag indicado contará sólo los enemigos que mueran golpeados por un floating object lanzable. 

(Si se define `BODY_COUNT_ON` también incrementarán el flag definido ahí... no sé, a lo mejor te sirve de algo).

"Floating objects" que caen afectados por la gravedad
-----------------------------------------------------

Directivas `ENABLE_FO_SCRIPTING`, `FO_X_FLAG`, `FO_Y_FLAG` y `FO_T_FLAG`

Si tu juego utiliza "floating objects" (Leovigildo 1, 2 y 3), si activas la gravedad con `FO_GRAVITY` los objetos caeran si no tienen nigún obstáculo debajo.

En Leovigildo 3 nos inventamos un puzzle en el que había que dejar caer una corchoneta de sartar sobre Amador el Domador para estrujarlo. Esto necesitó ampliar el motor para poder comprobar adónde caía un "floating object".

Si activamos `ENABLE_FO_SCRIPTING`, se ejecutarán las secciones `PRESS_FIRE` general y de la pantalla actual cada vez que un "floating object" caiga y descienda una casilla.

Justo antes de llamar al script, la posición a la que ha caído se copiará en los flags indicados en `FO_X_FLAG` y `FO_Y_FLAG`,  y el tipo del "floating object" se copiará en `FO_T_FLAG`.

Es interesante saber que el flag `FO_T_FLAG` se pondrá a 0 al entrar en una pantalla.

```c
	#define ENABLE_FO_SCRIPTING 
	#define FO_X_FLAG					1
	#define FO_Y_FLAG					2
	#define FO_T_FLAG					3
```

Aquí ya usamos alias...

```
	DEFALIAS
		[...]
		$FO_X 1
		$FO_Y 2
		$FO_T 3
		[...]
	END
```

Y en el `PRESS_FIRE` de la pantalla de Amador encontramos...

```
	PRESS_FIRE AT SCREEN 19
		# Lanzar el FO encima de Amador
		# Amador está en X, Y = (8, 7).
		# El FO corchoneta es el tile 17
		IF FLAG $FO_T = 17
		IF FLAG $FO_X = 8
		IF FLAG $FO_Y = 7
		THEN
			SOUND 0
			EXTERN 31
			SET FLAG $AMADOR = 5
			REENTER
		END
		...
```

Comprobaciones y comandos relacionados con la posición
======================================================

También tenemos varias formas de comprobar y modificar la posición - incluso cambiando de pantalla ¡y de nivel!

Comprobaciones sobre la posición 
--------------------------------

```
IF PLAYER_TOUCHES x, y	Evaluará a CIERTO si el jugador está tocando 
						el tile (x, y). x e y pueden llevar #.
        
IF PLAYER_IN_X x1, x2	Evaluará a CIERTO si el jugador está horizontalmente 
						entre las coordeadas en pixels x1 y x2.
    
IF PLAYER_IN_Y y1, y2	Evaluará a CIERTO si el jugador está verticalmente 
						entre las coordeandas en pixles y1 e y2.
```

Cambiando de posición
---------------------

Estos comandos sirven para modificar la posición del personaje. Todas se expresan a nivel de tiles (x de 0 a 14, y de 0 a 9).

```
SETX x					Colocará al personaje en la coordenada de tile x
						(modifica solo la posición horizontal)
	
SETY y					Colocará al personaje en la coordenada de tile y
						(modifica solo la posición vertical)
	
SETXY x, y				Colocará al personaje en la coordenada de tile (x, y)
						(modifica ambas coordenadas, x e y).
```

Comprobaciones sobre la pantalla
--------------------------------

Aunque poder definir scripts en ENTERING n y PRESS_FIRE AT n donde n es la pantalla actual y que sólo se ejecuten cuando estamos en dicha pantalla, hay veces en las que es necesario saber en qué pantalla estamos en una de las secciones "generales" (cuando se acaba el TIMER, cuando matamos un enemigo...) Para esos casos tenemos:

```
IF NPANT n				Evaluará a CIERTO si el jugador está en la pantalla n

IF NPANT_NOT n			Evaluará a CIERTO si el jugador NO está en la pantalla n
```

Cambiando de pantalla
---------------------

```
WARP_TO n, x, y			Mueve al jugador a la posición (x, y) de la pantalla n.
						x e y a nivel de tiles.
```

Cambiando de nivel
------------------

Obviamente, sólo si tu juego tiene varios niveles.

```
WARP_TO_LEVEL l, n, x, y, s
```

Hace lo siguiente:

- Termina el nivel actual.
- Carga e inicializa el nivel l.
- Establece la pantalla activa a n.
- Pone al jugador en las coordenadas (x, y) (a nivel de tiles).
- Si s = 1, no muestra una pantalla de nuevo nivel (*)

(*) Esto es muy relativo y muy custom. En Ninjajar! hay una pantalla antes de empezar cada nivel, que sólo se muestra si la variable `silent_level` vale 0. El valor de s se copia a `silent_level`, so...

Si tu manejador de niveles es diferente lo puedes obviar, o usar para otra cosa.

Sí, hacer juegos de muchos niveles y tal es complicado. La vida es asín.

Redibujar la pantalla
=====================

Es util si haces algo que se cargue la pantalla, como sacar un cuadro de texto con un `EXTERN` (ver más adelante) (todo lo que hemos hecho de Ninjajar en adelante usa `EXTERN` principalmente para sacar cuadros de texto que se cargan la zona de juego). Así vuelves a pintarlo todo. Sólo hay que ejecutar:

```
	REDRAW
```

Ojete: existe un buffer de tamaño pantalla donde cada cosa que se imprime  (bien por la rutina que se ejecuta al entrar en una pantalla nueva y que compone el escenario, bien por un `SET TILE (X, Y) = T` del scripting, etc.) se copia ahí. `REDRAW` simplemente vuelca ese buffer a la pantalla. ¡Si has modificado la pantalla con cosas desde el script, `REDRAW` no la va a volver a su estado original!

"Reentrar" en la pantalla
=========================

A veces necesitas volver a ejecutar todo el script de `ENTERING ANY` y/o de `ENTERING SCREEN n`, o necesitas reinicializar los enemigos (si les cambias el tipo al vuelo, ver más adelante), o sabe dios qué.

Hay varias formas de reentrar en la pantalla:

```
REENTER					Vuelve a entrar en la pantalla, exactamente igual
						que si viniésemos de otra. Lo hace todo: redibuja,
						inicializa todo, ejecuta los scripts...
						
REHASH					Lo mismo, pero sin redibujar. Tampoco muestra la
						pantalla "LEVEL XX" si tu motor está configurado 
						para ello. Pero si inicializa todo y ejecuta los
						scripts.
```

Modificar la pantalla
=====================

Hay varias formas de modificar la pantalla:

Cambiar tiles del área de juego
-------------------------------

Cambiar tiles del área de juego modifica efectivamente el area de juego. Quiero decir que los cambios son persistentes (sobreviven a un REDRAW) y además los tiles modificados son interactuables. O sea, si modificas la pantalla eliminando una pared con un tile transparente, el jugador podrá pasar por ahí.

```
SET TILE (x, y) = t		Pone el tile t en la coordenada (x, y).
						Las coordenadas	(x, y) están a nivel de tiles.
```

Por supuesto, y esto es muy útil, tanto x como y como t pueden llevar `#` para indicar el contenido de un flag. Para imprimir en 4, 5 el tile que diga el flag 2, hacemos 

```
	SET TILE (4, 5) = #2.
```

Para imprimir un tile 7 en las coordendas almacenadas en los flags 2 (x) y 3 (y), hacemos:

```
	SET TILE (#2, #3) = 7
```

Y, recordemos, siempre que referenciemos un flag podemos usar un alias. No lo estoy recordando todo el rato porque confío en tu inteligencia, pero

```
	DEFALIAS
		$COORD_X 2
		$COORD_Y 3
	END

	[...]

	SET TILE (#$COORD_X, #$COORD_Y) = 7
```

Vale igual.

También puedes usar listas de decoraciones. Las he mencionado más arriba cuando hablé de INC_DECORATIONS. Las listas de decoraciones las puedes meter en cualquier sección de comandos, son así:

```
	DECORATIONS
		x, y, t
		...
	END
```

Donde (x, y) es una coordenada a nivel de tiles, y t es un número de tile.

Por ejemplo:

```
	DECORATIONS
		12, 3, 18
		7, 4, 16
		8, 4, 18
		2, 5, 27
		12, 5, 27
		2, 6, 28
		7, 6, 27
		12, 6, 26
		7, 7, 29
		12, 7, 28
		8, 8, 19
		9, 8, 20
		10, 8, 20
		11, 8, 21
	END
```

Cambiar sólo el comportamiento
------------------------------

Muy, muy tonto. Si lo necesitas, funciona igual que SET TILE pero sólo sustituye el comportamiento original por el que especifiques:

```
	SET BEH (x, y) = b
```

Imprimir tiles en cualquier sitio
---------------------------------

Podemos imprimir un tile en cualquier sitio de la pantalla, sea en el area de juego o bien fuera (por ejemplo, en una zona del marcador).	Para ello usamos:

```
PRINT_TILE_AT (x, y) = n	
						Imprime el time n e (x, y), con (x, y) ¡ojo! en 
						coordenadas DE CARACTER (x = 0-30, y = 0-22).
```

Esta función sólo imprime. Aunque el tile que pintemos esté sobre el area de juego no la afectará en absoluto para nada.						
						
Una cosa muy chula para lo que puede servir esto es para hacer pasajes secretos: en tu mapa haces un pasillo, pero luego en el ENTERING SCREEN lo cubres de tiles con `PRINT_TILE_AT`... Como estos tiles no afectan al area de juego, parecerá que no se puede pasar por ahí... pero ¡sí que se puede!

Mostrar cambios
---------------

Todas las impresiones de tiles en el motor se hacen a un buffer. En cada cuadro de juego, este buffer se dibuja en la pantalla siguiendo un divertido y mágico proceso. Sin embargo, durante la ejecución del script, no se vuelca el buffer a la pantalla.

Si cambiamos algo y queremos que se vea inmediatamente sin tener que esperar a volver al juego (por ejemplo, si estamos haciendo una animación), necesitamos decirle al intérprete de forma explícita que pinte el buffer en la pantalla. Esto se hace con el comando:

```
	SHOW
```

Empujar bloques
===============

Ya hemos hablado, pero no habíamos mencionado que:

```
IF JUST_PUSHED			Será cierto si hemos llegado al FIRE_SCRIPT por
						haber empujado una caja.
```

Esto es MUY UTIL. Tienes que tener en cuenta que la posición del objeto empujado (almacenada en los flags definidos en `MOVED_X_FLAG` y `MOVED_Y_FLAG`) y el tile que ha sobrescrito (almacenado en el flag definido en `MOVED_TILE_FLAG`) son persistentes - estos flags conservarán su valor hasta que se mueva otro bloque. 

En la sección `PRESS_FIRE` se puede entrar de varias formas, por ejemplo pulsando acción. A lo mejor no te conviene que se hagan comprobaciones que impliquen los flags afectados por los bloques empujados si no hemos entrado tras empujar un bloque.

Cadaverion hace uso de esto.

En Cadaverion hay que empujar cierto número de estatuas sobre cierto número de pedestales. La configuración en config.h relacionada con esto es:

```c
	#define ENABLE_PUSHED_SCRIPTING	
	#define MOVED_TILE_FLAG 		1
	#define MOVED_X_FLAG 			2
	#define MOVED_Y_FLAG 			3
	#define PUSHING_ACTION
```

En el `ENTERING` de cada pantalla, se establece en el flag #9 el número de estatuas/pedestales que hay. O sea, el flag #9 contendrá el número de estatuas que tenemos que colocar en sus pedestales.

En cada pantalla hay una cancela que hay que abrir poniendo las estatuas en sus pedestales. En el `ENTERING` definimos su posición en las flags #6 y #7 (resp., coordenadas X e Y).

En el flag #10 vamos a ir contando las estatuas que colocamos en su sitio. Cuando todas las estatuas estén en su sitio, (esto es, el flag 9 y el flag 10 contengan el mismo valor) vamos a abrir la cancela que permite ir a la siguiente pantalla.

Vamos a usar el flag #11 como bandera. Si vale 0, la cancela está cerrada. Si vale 1, la hemos abierto ya. Entonces, este código es el que abre la cancela:

```
	IF FLAG 9 = #10
	IF FLAG 11 = 0
	THEN
		# Decimos que la cancela está abierta:	
		SET FLAG 11 = 1
		
		# Borramos la cancela poniendo un tile 0 en sus coordenadas:
		SET TILE (#6, #7) = 0
		
		# Mostramos los cambios inmediatamente.
		SHOW
		
		# Ruiditos
		SOUND 0
		SOUND 7
		
		# más cosas que no nos interesan.		
		[...] 
	END
```

Podríamos haber añadido `JUST_PUSHED` pero da igual. No se cumplirá hasta que no hayamos colocado la última estatua, así que no importa que se compruebe cuando no debe.

Las estatuas corresponden al tile 14, y tiene "behaviour 10", o sea, que las estatuas son el bloque "empujable".

Los pedestales son el tile 13.

En el `PRESS_FIRE AT ANY`, que se lanzará (junto con el `PRESS_FIRE AT SCREEN n` de la pantalla actual) cada vez que movamos un bloque, comprobaremos que hemos pisado un pedestal. O sea, comprobaremos que:

```
	IF JUST_PUSHED
	IF FLAG 1 = 13
	THEN
		INC FLAG 10, 1
```

Esto es: hemos llegado aquí por haber empujado una estatua (`JUST_PUSHED`) y el tile que hemos "pisado" es el 13 (un pedestal). Entonces, sumamos 1 a la cuenta de estatuas colocadas.

¿Qué pasaría si no pusiésemos `JUST_PUSHED`? Pues imagina: tú coges, mueves una estatua al pedestal. en el FLAG 1 se copia el tile que acaba de pisar, que es 13. Pero ese valor se queda ahí... Si pulsas ACCIÓN, por ejemplo, el valor seguirá ahí, y contaría como que hemos pisado otro pedestal. No mola.

El código completo de esta cláusula es este, porque se hace otra cosa muy interesante:

```
	IF JUST_PUSHED
	IF FLAG 1 = 13
	THEN
		# Incrementamos la cuenta de estatuas
		INC FLAG 10, 1
		
		# Sonido
		SOUND 0
		
		# ¡Cambiamos la estatua por otro tile!
		SET TILE (#2, #3) = 22
		
		SHOW
		SOUND 0
	END
```

Si no cambiásemos la estatua por otro tile, podrías seguir empujándola. Como empujar un bloque normal es destructivo (siempre borra con el tile 0), esto quedaría de la hostia de feo.

Al cambiar el tile que hay en (#2, #3), que es la posición de nuestra estatua según config.h, por otro que no sea el 14 (el 22 es una estatua girada, quedaba chuli), no podrá empujarse más.

Clever, uh?

El timer
========

El timer es una cosa muy chula que hay en el motor MK2 (también estaba en la Churrera, pero ahora es más mejón). Básicamente es un valor que se decrementa cada cierto número de cuadros de juego. Cuando llega a 0, puede hacerse que el jugador pierda una vida, o que haya un game over... O puede ejecutarse una sección especial del script.

(Hay mucho sobre el timer, que puede funcionar de forma autónoma y hacer muchas cosas, pero eso no nos incumbe. Mira en whatsnew.txt o pregunta).

Si activamos en config.h

```c
	#define TIMER_SCRIPT_0
```

Cada vez que el timer llegue a 0 se disparará la sección `ON_TIMER_OFF`. Ahí podremos hacer cosas.

Además tenemos ciertas comprobaciones y algunos comandos relacionados con el timer:

Comprobaciones sobre el timer
-----------------------------

```
IF TIMER >= x			Cierto si el timer tiene un valor >= x.
	
IF TIMER <= x			Cierto si el timer... ¡oh, vamos!
```

Comandos del timer
------------------

En realidad, "comando", porque sólo hay este:

```
SET_TIMER v, r			Establece el timer a un valor v con "rate" r. 
						Significa que se decrementará cada r cuadros de
						juego. En condiciones normales, los juegos van entre
						22 y 33 faps por segundo... de 25 a 30 son buenos
						valores si quieres que tu timer parezca que cuenta
						en segundos. Experimenta.
```

OJO: `SET_TIMER`, con "_". Sí, ya sé que hay un `SET FLAG` sin "_". Asín es,  acéptalo. Get over it. Te equivocarás mil veces. Yo me equivoco mil veces. Pero me jodo. En serio, ya lo cambiaré.

TODO: Cambiar esto.

```
TIMER_START				Enciende el timer.

TIMER_STOP				Apaga el timer.
```

Se pueden hacer muchas cosas. Por ejemplo, nos vale lo que se hace en 
Cadaverion...

```
	# Esto es lo que pasa cuando se acaba el tiempo.
	# En #12 guardamos la pantalla a la que hay que volver al acabarse el tiempo.
	# En #13, #14 las coordenadas donde apareceremos cuando esto ocurra.

	ON_TIMER_OFF
		IF TRUE
		THEN
			SOUND 0
			SOUND 0
			SOUND 0
			SOUND 0
			SET_TIMER 60, 40
			DEC LIFE 1
			SET FLAG 8 = #0
			WARP_TO #12, #13, #14
		END
	END
```

Una cosa que suele hacerse, como acabamos de ver, es reiniciar el timer. En este caso se resta una vida, se resetea el timer, y se cambia al personaje de sitio.

El inventario
=============

Esto empezó de coña, se empepinó en Leovigildo, y ahora es un pepino genial que nos permite hacer muchas cosas con muy poco código. Ains, hubiera venido bien en Ninjajar! - hubiese ahorrado un montón de código de script y de quebraderos de cabeza.

El inventario no es más que un contenedor de objetos. Podemos definir cuántos objetos como máximo vamos a llevar.

El inventario tiene, por tanto, un número N de "slots". Cada slot puede estar vacío o contener un objeto. Los objetos se referencian de la forma más sencilla posible: por su número de tile. "0" no se puede usar porque indica "vacío".

Hay, además, y en todo momento, un "slot seleccionado". 

El valor del slot seleccionado y, por comodidad, el valor del objeto que hay en dicho slot, se mantienen en dos flags especiales que podemos elegir.

La posición y configuración del inventario también es bastante configurable y se puede adaptar bastante.

Vamos a hablar primero del inventario "a pelo" y luego hablamos de los "floating objects" de tipo "container", que fueron creados para hacer que hacer juegos con objetos e inventario sea un puto paseo.

Definiendo nuestro inventario.
------------------------------

El inventario se define en un apartado especial a principio del script. En él se definen los diferentes parámetros necesarios para poner en marcha el sistema y tiene esta forma:

```
	ITEMSET
	   SIZE n
	   LOCATION x, y
	   DISPOSITION disp, sep
	   SELECTOR col, c1, c2
	   EMPTY tile_empty
	   SLOT_FLAG slot_flag
	   ITEM_FLAG item_flag
	END
```

Vamos describiendo cada linea una por una (sí, son necesarias todas).

```
SIZE n					Indica el tamaño de nuestro inventario, esto es,
						el número de slots que lo compondrán.
						
LOCATION x, y			Indica la posición (x, y) a nivel de caracteres 
						de la esquina superior del inventario, que se
						corresponde a dónde aparecerá el primer item.
						
DISPOSITION disp, sep	"disp" debe valer HORZ o VERT, para indicar si
						queremos que los slots de nuestro inventario se
						muestren unos al lado de otros (HORZ) o unos
						debajo de otros (VERT).
						"sep" define la separación:
```

* Si el inventario es HORIZONTAL (HORZ)
	- El primer slot se colocará en (x, y)
	- El siguiente, en (x + sep, y)
	- El siguiente, en (x + sep + sep, y)
	...
	
* Si el inventario es VERTICAL (VERT)
	- El primer slot se colocará en (x, y)
	- El siguiente, en (x, y + sep)
	- El siguiente, en (x, y + sep + sep)
	...
	
Cada slot ocupa 2x2 caracteres (lo que ocupa un tile) pero debe dejarse un espacio de 2x1 caracteres justo debajo para pintar el "selector" que indica cuál es el slot activo. 

```
SELECTOR col, c1, c2	Define el selector. El selector no es más que una
						flecha o un algo que se coloca justo debajo del
						slot activo.
						El selector se pintará de color "col" y se 
						compondrá de los caracteres c1 y c2 del charset,
						en horizontal.
						Yo suelo usar dos caracteres de las letras, para 
						no desperdiciar tiles. Mira font.png en cualquiera
						de los "Leovigildo" y verás la flecha en los 
						caracteres 62 y 63.
						
EMPTY tile_empty		Contiene el número de tile de nuestro tileset que
						se empleará para representar un "slot vacío".
						En Leovigildo pusimos un cuadradito azul muy
						chulo, puedes verlo en el tileset en la posición
						31.
						
SLOT_FLAG slot_flag		Dice qué flag contiene el slot actual seleccionado

ITEM_FLAG item_flag		Dice qué flag contiene el contenido del slot 
						actual seleccionado.
```

Para no estorbar, yo suelo definir los flags 30 y 31 (los dos últimos si usamos los 32 que vienen por defecto) para estos dos valores. Así, en todo momento, el flag 30 (`SLOT_FLAG 30`) contiene qué slot está seleccionado (un número de 0 a n - 1; si el inventario tiene 4 slots, podrá valer 0, 1, 2 o 3 dependiendo de cuál esté seleccionado), y el flag 31 (`ITEM_FLAG 31`) contiene el objeto que hay en ese slot.

Ejemplos: Leovigildo 1, por ejemplo:

```
	ITEMSET
	   SIZE 4
	   LOCATION 18, 21
	   DISPOSITION HORZ, 3
	   SELECTOR 66, 62, 63
	   EMPTY 31
	   SLOT_FLAG 30
	   ITEM_FLAG 31
	END
```

Tenemos un inventario que podrá contener cuatro objetos. Hemos dejado sitio en el marcador para él, a partir de las coordenadas (18, 21). Se pintará en horizontal, con un nuevo slot cada 3 caracteres. El selector será rojo intenso (2 + 64 = 66) y se pintará con los caracteres 62 y 63. El tile que representará un slot vacío es el 31, que en el tileset aparece como un recuadro azul. El flag 30 contendrá el slot seleccionado, y el flag 31 contendrá qué objeto hay en ese slot (0 si no hay ninguno).

En Leovigildo 3 también tenemos un inventario:

```
	ITEMSET
	   SIZE 3
	   LOCATION 21, 21
	   DISPOSITION HORZ, 3
	   SELECTOR 66, 62, 63
	   EMPTY 31
	   SLOT_FLAG 30
	   ITEM_FLAG 31
	END
```

En este caso el inventario es más pequeño, de solo 3 slots. Se colocará a partir de las coordenadas (21, 21), será también horizontal y los slots se dibujarán cada 3 caracteres. El selector será igual, y la configuración de tile vacío y flags es la misma.

Vaya mierda de ejemplos, son muy parecidos. Pero a hoerce.

Acceso directo a cada slot
--------------------------

Podemos acceder directamente a cada slot, recordemos, numerados de 0 a n - 1, usando "ITEM", tanto en condiciones como en comandos:

```
IF ITEM n = t			Evalúa CIERTO si en el slot N está el item T
	
IF ITEM n <> t			Evalúa CIERTO si en el slot N no está el item T
						(Dudo que esto sirva para algo... pero bueno)
						
SET ITEM n = t			Pone el objeto representado por el tile T en el
						slot N.
```

`SET ITEM` nos servirá para inicializar el inventario, por ejemplo, o para hacer aparecer objetos en él por arte potagio. Al principio de cada  uego puedes hacer:

```
	SET ITEM 0 = 0
	SET ITEM 1 = 0
	SET ITEM 2 = 0
	SET ITEM 3 = 0
```

(para un inventario de 4 slots). Yo lo uso también cuando estoy haciendo debug, para ponerme en el inventario objetos que necesito para probar alguna cosa.

Al igual que ocurría con las impresiones, los cambios no serán visibles  hasta que ocurra el siguiente cuadro de juego. Si por alguna razón necesitas modificar el inventario y que se muestre en el medio de un script, puedes usar

```
	REDRAW_ITEMS
```

Para refrescar el inventario en pantalla.

Slot seleccionado y objeto seleccionado en el script
----------------------------------------------------

Lo de arriba es suficiente para que aparezca el inventario cuando ejecutemos el juego, pero habrá que hacerlo funcionar. Para ello usaremos los flags definidos para tal fin en `SLOT_FLAG` e `ITEM_FLAG`.

Hemos hablado de alias. Podríamos definir estos alias (contando con que estamos siguiendo el ejemplo y hemos definido `SLOT_FLAG` en 30 e `ITEM_FLAG` en 31):

```
	ALIAS
		$SLOT_FLAG 30
		$ITEM_FLAG 31
	END
```

Incluso podríamos usar los flags 30 y 31 a pelo...

Se puede hacer todo con esto, pero hay ciertas condiciones y ciertos comandos predefinidos que harán tu script más legible... y que serán traducidos de forma transparente a manejes con los flags definidos en `SLOT_FLAG` e `ITEM_FLAG` - por lo que no te costarán "código de intérprete".

```
IF SEL_ITEM = T			Evalúa CIERTO si el item que hay en el slot 
						seleccionado es el representado por el tile T.
						(Internamente equivale a IF FLAG $ITEM_FLAG = T)
						
IF SEL_ITEM <> T		Evalúa CIERTO si el item que hay en el slot 
						seleccionado NO es el representado por el tile T.
						(Internamente equivale a IF FLAG $ITEM_FLAG <> T)
```

Además se definen el alias automático:

```
SLOT_SELECTED			Equivale al valor del slot seleccionado.
```

Por tanto, podemos establecer qué ITEM queremos en el slot actual haciendo

```
	SET ITEM SLOT_SELECTED = T
```

Esto se utiliza así. Se supone que cuando pulsamos "acción", es para usar el item que tenemos seleccionado en un sitio específico de la pantalla.

Vamos a poner un ejemplo práctico para ver el funcionamiento básico del inventario. Todo esto se simplifica muchísimo con el uso de "floating objects" de tipo contenedor, pero vamos a verlo primero en plan comando.

Imaginad que llegamos a una habitación donde hay un objeto, una hoja de papel. Se trata del tile 22 de nuestro tileset. Lo hemos colocado en la  posición (5, 4) al entrar en la habitación en concreto, que es la 6. Tenemos un flag especial, $PAPEL, que valdrá 0 si aún no lo hemos cogido.

```
	ENTERING SCREEN 6
		IF FLAG $PAPEL = 0
		THEN
			SET TILE (5, 4) = 22
		END
	END
```

Ahora vamos a permitir que el jugador coja el papel. Para ello, el jugador se irá a por el papel (tocando la posición (5, 4), esto es) y pulsará la tecla de Acción. Esto lanzará el script de PRESS_FIRE correspondiente.

En él vamos a detectar que estamos en el sitio correcto, vamos a eliminar el papel de la pantalla, lo vamos a meter como ITEM en el inventario, y pondremos el flag $PAPEL a 1 para que no vuelva a aparecer:

```
	PRESS_FIRE AT SCREEN 6
		IF FLAG $PAPEL = 0
		IF PLAYER_TOUCHES 5, 4
		THEN
			SET TILE (5, 4) = 0
			SET ITEM SLOT_SELECTED = 22
			SET FLAG $PAPEL = 1
		END
	END
```

La linea `SET ITEM SLOT_SELECTED = 22` hace que el papel aparezca en el inventario, justo en el slot que el usuario tuviese seleccionado.

Obviamente, si había algo ahí se machacará - para evitarlo habría que montar un pequeño pifostio, pero para eso tenemos los "floating objects" que vermos después. Ahora mismo da igual que machaque, es un ejemplo.

Nos vamos a otra pantalla de nuestro juego, pongamos que es la numero 8. Pongamos que tenemos en (7, 7) a un personaje que espera que le demos un papel para escribir una carta. Cuando se lo demos, se pondrá "contento" y esto hará que pasen cosas. El estado de "contento" lo expresaremos en un flag $CONTENTO, que valdrá 0 al principio.

El jugador deberá seleccionar el item en el inventario y luego irse al sitio correcto y pulsar acción. Eso lanzará nuestro script de `PRESS_FIRE`:

```
	PRESS_FIRE AT SCREEN 8
		IF SEL_ITEM = 22
		THEN
			# Hacer cosas de oh, un papewl!
			# Con EXTERN, o lo que sea, sonidos, tal.
			# yasta, ahora...
			SET ITEM SLOT_SELECTED = 0
			SET FLAG $CONTENTO = 1
		END
	END
```

Como véis, hemos quitado el objeto del inventario simplemente diciéndole al juego que ponga un 0 en el slot seleccionado.

¿No tendríamos que haber hecho más comprobaciones? Por ejemplo, que $PAPEL = 1 o que $CONTENTO = 0. Se podrían poner y seguiría funcionando, pero no son necesarias: ten en cuenta que, por un lado, el papel sólo se puede coger una vez, y que una vez dado al tío desaparecerá del inventario y, por tanto, del juego. Por tanto, SEL_ITEM nunca podrá volver a ser 22. ¡Ahorro!

"Floating Objects" de tipo "container".
=======================================

Los "Floating Objects" de tipo "container" no son más que "cajas" donde podemos meter un objeto. Estas cajas se colocan en una pantalla desde el script y se les puede asignar un contenido.

Los "Floating Objects" de tipo "container" (a partir de ahora, les vamos a llamar contenedores) hacen que manejar el inventario sea muy sencillo, ya que, cuando el usuario pulse ACCION tocando uno, harán que el objeto que haya en el slot seleccionado y el objeto contenido en el container se intercambien de forma automática, sin script de por medio. Eso nos sirve para:

- Si el slot seleccionado está vacío, "cogeremos el objeto".
- Si el slot seleccionado está lleno, el objeto que había se intercambiará por el del contenedor, y no se perderá nada.
- Si el contenedor está vacío pero no el slot seleccionado, "dejaremos el objeto".

Para poder usar contenedores, hay que habilitarlos en config.h. Además, hay que hacerle saber al motor qué flag de nuestro script representa el slot seleccionado (tal y como lo definimos en la sección ITEMSET de nuestro script):

```c
	#define ENABLE_FO_OBJECT_CONTAINERS
```

Con esto activamos los conenedores y le decimos al motor que el slot seleccionado se almacena en el flag 30.

Ah, ¡y que no se nos olvide habilitar los "floating objects", en general!

```c
	#define ENABLE_FLOATING_OBJECTS
```

Creando un contenedor
---------------------

Los contenedores pueden crearse desde cualquier cuerpo de cláusula, pero se suelen crear en las secciones ENTERING en un IF TRUE.

A cada contenedor se le asigna un flag. El valor de dicho flag indicará qué objeto hay en el contenedor, y será 0 si está vacío.

Los contenedores se crean con el siguiente comando:

```
ADD_CONTAINER FLAG, X, Y	Crea un contenedor para el flag FLAG en (X, Y)
```

Es buena práctica crear un alias para cada contenedor y ponerles `CONT_`, para distinguirlos fácilmente. Por ejemplo, vamos a crear un contenedor para el papel del ejemplo anterior:

```
	DEFALIAS
		...
		$CONT_PAPEL 16
		...
	END
```

El papel salía en la pantalla 6, así que vamos a crear ese contenedor en la sección `ENTERING SCREEN` de la pantalla 6. Recordad que antes teníamos que imprimir el tile y tal (ver sección anterior), pero con los contenedores no es necesario. Tampoco vamos a necesitar un flag $PAPEL ni pollas. 

```
	ENTERING SCREEN 6
		IF TRUE
		THEN
			ADD CONTAINER $CONT_PAPEL, 5, 4
		END
	END
```

¿Pero dónde decimos que en ese contenedor tiene que estar el objeto que se representa por el tile 22 (la hoja de papel) - Recordemos que los contenedores son en ralidad abstracciones de flags, así que para que el contenedor que acabamos de crear tenga una hoja de papel, habrá que darle ese valor al flag ¿Cuando? Al principio del juego:

```
	ENTERING GAME
		IF TRUE
		THEN
			SET FLAG $CONT_PAPEL = 22
		END
	END
```

Con esto, en cada partida habrá un contenedor en (5, 4) de la pantalla 6 que tenga una hoja de papel dentro.

Cuando el jugador llegue a la pantalla 6, toque el contenedor (en (5, 4)) y pulse la tecla de acción, el motor intercambiará automáticamente el contenido del slot seleccionado con el contenido del contenedor. Así, si el slot seleccionado estaba vacío, pasará a contener la hoja de papel y el contenedor se quedará vacío. Si teníamos un objeto en ese slot, pasará a estar en la posición (5, 4) y el papel en nuestro inventario.

Y nosotros no tendremos que hacer nada. Ni en el script, ni en nada.

A la hora de irnos a la pantalla 8 a dárselo al jipi, todo sigue igual:

```
	PRESS_FIRE AT SCREEN 8
		IF SEL_ITEM = 22
		THEN
			SET ITEM SLOT_SELECTED = 0
			SET FLAG $CONTENTO = 1
		END
	END
```

Obviamente, los contenidos de los contenedores no tienen por qué crearse desde el principio del juego. Por ejemplo, en Leovigildo III los objetos para el puzzle final no están disponibles hasta que no hablamos con Nicanor el Aguador en la última pantalla. Inicialmente se ponen a 0 y llegados a ese punto ya se les da valor.

Otros floating objects
======================

El motor soporta otros tipos de floating objects: cajas que se transportan, por ejemplo. Todo esto tiene que ver con la configuración del motor y tal, pero como se colocan desde el script, lo menciono aquí. 

Un floating object está representado por un número de tile y su ubicación inicial. Para crear un floating object tenemos que ejecutar el siguiente comando en el cuerpo de una cláusula (generalmente, en el IF TRUE dentro de una sección `ENTERING SCREEN`):

```
ADD_FLOATING_OBJECT T, X, Y		
							Crea un floating object con el tile T en (X, Y).
```

Como decíamos, el comportamiento de FO dependerá de tile que se le asigne y esto a su vez dependerá de cómo tengamos configurado el juego.

Por ejemplo, en Leovigildo las cajas que podemos acarrear y apilar son un floating object y están representadas por el tile 16. Para ello, hemos hecho la siguiente configuración en config.h:

```c
	#define ENABLE_FLOATING_OBJECTS
	#define ENABLE_FO_CARRIABLE_BOXES
	#define FT_CARRIABLE_BOXES 16
	#define CARRIABLE_BOXES_ALTER_JUMP 180
```

La primera habilita los floating objects, en general. La segunda habilita los floating objects de tipo "CARRIABLE_BOXES" (cajas transportables). La tercera dice que estas cajas se representan por el tile 16. La última tiene que ver con la configuración de esta mierda: si se define, la fuerza del salto se verá alterada cuando llevemos una caja (para saltar menos) y el valor máximo de la velocidad vertical será el definido. 

Con esto, añadiremos una de estas bonitas cajas a la pantalla 4 en la posición (5, 5) poniendo esto en el script:

```
	ENTERING SCREEN 4
		IF TRUE
		THEN
			ADD_FLOATING_OBJECT 16, 5, 5
		END
	END
```

Comprobaciones y comandos relacionados con los valores del personaje
====================================================================

Existe todo un set de comprobaciones y comandos que tienen que ver con los valores del personaje (por ejemplo, la vida).

Comprobaciones
--------------

Estas dos comprobaciones están en desuso porque opino que es mucho más cómodo definir #define OBJECT_COUNT y asignarlo a una flag, y operar con dicha flag. Siguen aquí por yo qué sé. 

```
IF PLAYER_HAS_OBJECTS	Evaluará a CIERTO si el jugador tiene objetos.
		
IF OBJECT_COUNT = n		Evaluará a CIERTO si el jugador tiene N objetos.
```

Comandos
--------

```
INC LIFE n				Incrementa el valor de la vida en n
        
DEC LIFE n				Decrementa el valor de la vida en n
   
RECHARGE				Recarga toda la vida (la pone al máximo)

FLICKER					Hace que el jugador empiece a parpadear durante
						un segundo y pico, como cuando te quitan una vida.
```

Sobre estas dos últimas digo lo mismo que antes: usando OBJECT_COUNT y una flag todo es más sencillo, pero ahí siguen:

```
INC OBJECTS n			Añade n objetos más.
	
DEC OBJECTS n			Resta n objetos (si objects >= n; si no objects = 0).
```

Terminar el juego
=================

Comandos para terminar el juego desde el scripting (es necesario activar, en config.h, `#define WIN_CONDITION 2`, en el caso de que queramos GANAR desde el script - para GAME OVER No es necesario).

```
GAME OVER				Termina el juego con un GAME OVER.

WIN GAME				Termina el juego si no hay varios niveles. En juegos
						con varios niveles termina el nivel actual (y pasa
						al siguiente, si tu manejador de niveles funciona de
						esta manera)

GAME_ENDING				En juegos con varios niveles, termina el juego 
						completamente y le dice al motor que muestre la
						secuencia final.
```

Para que `GAME_ENDING` funcione hay que indicarlo en config.h con un bonito `#define SCRIPTED_GAME_ENDING`.

Fire Zone
=========

La "fire zone" de una pantalla es una zona rectangular definida a nivel de pixels que lanzará la sección `PRESS_FIRE` de la pantalla (y `PRESS_FIRE AT ANY`) si el jugador la toca. Nos sirve para lanzar trozos de script cuando el jugador toque algo o entre en algún sitio.

Hay que activarlas en config.h

```c
	#define ENABLE_FIRE_ZONE
```

Para definir el `FIRE_ZONE` activo de una pantalla usamos este comando desde cualquier sección de comandos (normalmente en un `IF TRUE` de `ENTERING SCREEN`)

```
	SET_FIRE_ZONE x1, y1, x2, y2
```

Que definirá un rectángulo desde (x1, y1) a (x2, y2), en píxels.

Si quieres desactivar la "fire zone" sólo tienes que poner un rectángulo fuera de rango o vacío:

```
	SET_FIRE_ZONE 0, 0, 0, 0
```

Para que sea menos coñazo trabajar, y ya que la mayoría de las veces las  fire zones hay que calcularlas en base a un rango de tiles, msc3 entenderá el comando

```
	SET_FIRE_ZONE_TILES tx1, ty1, tx2, ty2
```

donde los parámetros definen un rango en coordenadas de tile (ambos límites inclusive) que msc3 traducirá internamente a un `SET_FIRE_ZONE` normal.

Modificando enemigos
====================

La modificación más sencilla es la que permite activar o desactivar enemigos. Los enemigos tienen, internamente, un flag que los activa o desactiva para, por ejemplo, matarlos y que no salgan más. Desde el script podemos modificar ese flag para conseguir varios efectos.

Por ejemplo, en Ninjajar! hacemos aparecer plataformas móviles como resultado de acciones más o menos complejas. Para ello, creamos la plataforma normalmente en esa pantalla, la desactivamos en el ENTERING SCREEN, y la activamos posteriormente cuando la acción necesaria ha sido ejecutada.

En las pantallas hay tres enemigos, numerados 0, 1 y 2. Estos números se corresponden con el orden en el que fueron colocados en el Colocador. Hay que tener esto en cuenta, porque necesitamos este número para referenciarlos:

```
ENEMY n ON				Activa el enemigo "n".

ENEMY n OFF				Desactiva el enemigo "n".
```

Otra cosa que podemos hacer con los enemigos es cambiar su tipo. En el tipo del enemigo, con el nuevo motor introducido en Leovigildo III, tenemos codificado el tipo de movimiento, si dispara o no, y el número de sprite (todo esto detallado en whatsnew.txt, no voy a detenerme aquí), así que con esto tenemos una herramienta bastante potente.

```
ENEMY n TYPE t			Establece el tipo "t" para el enemigo "n".
```

El problema es que estamos modificando un parámetro básico del enemigo. Si nuestro juego maneja varios niveles no importa, ya que siempre tenemos una copia (comprimida) de los valores originales que podemos restaurar cuando nos de la gana.

El problema viene en los juegos de un solo nivel. Si cambiamos el tipo de un enemigo, perderemos el tipo original para siempre. Para poder recuperarlo necesitaremos una "copia de seguridad" de los tipos de todos los enemigos. Esta copia ocupa 3 bytes por pantalla y hay que activarla desde config.h:

```c
	#define ENEMY_BACKUP
```

Con la copia de seguridad activada, podemos restaurar todos los enemigos a su valor original o sólo los de la pantalla actual:

```
ENEMIES RESTORE			Restablece a sus valores originales los enemigos de
						la pantalla actual.
	
ENEMIES RESTORE ALL		Restaura el tipo de TODOS los enemigos del nivel.
```

Si sólo necesitas restaurarlos al empezar cada partida, puedes pasar de usar `ENEMIES RESTORE ALL` en el script y activar la directiva `RESTORE_ON_INIT` en config.h

```c
	#define BODY_COUNT_ON n
```

Donde n es un número de flag, hace que el motor cuente las muertes en el flag especificado. Esto nos da bastante control sobre el tema de las muertes.

```c
	#define RUN_SCRIPT_ON_KILL
```

Ejecuta la sección `PLAYER_KILLS_ENEMY` el script siempre que el jugador mate un enemigo, sea como sea.

```c
	#define EXTERN_E
```

Hace que en vez de `EXTERN n` en el script tengamos que usar `EXTERN_E n,m`, y que extern.h se sustituya por extern_e.h; además, `do_extern_action` ahora toma dos parámetros n y m en vez de uno. Esto sirve para multiplicar por 256 el número de "externs" disponibles desde el script.

Código externo
==============

Hay muchas cosas que no podemos hacer directamente desde el script y por ello el sistema permite ejecutar código externo, que no es más que una función definida en el código de MK2.

Para usar código externo habrá que incluir dicha función activando en config.h la directiva

```c
	#define ENABLE_EXTERN_CODE
```

Esto hará que se incluya el archivo extern.h en la compilación. Este archivo puede contener el código que nos de la gana siempre que el punto de entrada sea la función

```c
	void do_extern_action (unsigned char n);
```

En nuestro script disponemos del comando EXTERN:

```
EXTERN n				Hace una llamada a do_extern_action pasándole "n",
						donde n es un número de 0 a 255. No se puede usar 
						construcciones #.
```

En el extern.h de casi todos los juegos a partir de Ninjajar verás código para imprimir textos comprimidos con textstuffer.exe e incluidos en un  text.bin. A nosotros nos parece muy conveniente, pero siempre puedes usar esta característica para lo que te de la gana.

Es posible que 256 posibles acciones externas sean pocas (por ejemplo, si vas a usar mucho texto en tu juego y necesitas hacer más cosas - Ninjajar! usa 226 lineas de texto, casi nos quedamos sin valores). En ese caso podemos activar el "extern extendido" en config.h. Además de lo anterior, tienes que definir

```c
	#define EXTERN_E
```

Ojo, que esto desactiva EXTERN y no incluye el archivo extern.h. En su lugar incluye extern_e.h y activa el comando EXTERN_E. Ahora el punto de entrada, dentro de extern_e.h, debe ser

```c
	void do_extern_action (unsigned char n, unsigned char m);
```

y en nuestro script deberemos usar el comando:

```
EXTERN_E n, m			Hace una llamada a do_extern_action pasándole n y m,
						donde n y m son números de 0 a 255. No se puede usar
						construcciones #.						
```

Safe Spot
=========

Si defines `#define DIE_AND_RESPAWN` en config.h, el jugador, al morir, va a reaparecer en el "último punto seguro". Si `DIE_AND_RESPAWN` está activo, el motor salva la posición (pantalla, x, y) cada vez que nos posamos sobre un tile no traspasable (que no sea un "floating object").

Podemos controlar la definición del "punto seguro" (safe spot) desde nuestro script. Si decidimos hacer esto (por ejemplo, para definir un "checkpoint" de forma manual), es conveniente desactivar que el motor almacene el safe spot de forma automática con:

```c
	#define DISABLE_AUTO_SAFE_SPOT
```

Hagamos o no hagamos esto, podemos definir el safe spot desde el script con estos dos comandos:

```
SET SAFE HERE			Establece el "safe spot" a la posición actual del
						jugador.
						
SET SAFE n, x, y		Establece el "safe spot" a la pantalla n en las 
						coordenadas (de tile) (x, y).
```

Comandos miscelaneos
====================

No sabía donde meter estos...

```
SOUND n					Toca el sonido n. Dependerá de qué sonido sea n.

TEXT texto				Imprime un texto en la linea de textos si la hemos
						definido en config.h con los #define LINE_OF_TEXT,
						LINE_OF_TEXT_X, y LINE_OF_TEXT_ATTR. El texto va 
						a pelo, sin comillas, y en vez de espacios tienes 
						que poner "_". No usamos esto desde hace eones...

PAUSE n					Espera n frames, o sea, n = 50 es un segundo. Ojo
						pelao, que sólo funciona en 128K ya que usa HALT.
						Los juegos de 48K tienen las interrupciones apagadas
						por lo que usar PAUSE pausará el juego PARA SIEMPRE.
						
MUSIC n					Toca la música n. Obviamente, sólo en juegos de 128K

```

