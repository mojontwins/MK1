# Capítulo 15: Custom Vertical Engine

O *vEng* personalizado. Cómo me gusta inventarne términos y que luego la gente los use. En mojonia nos encanta que digáis "perspectiva genital". Pero ¿qué es un deso? Pues muy sencillo: una forma fácil de introducir tu propio código para controlar el movimiento en el eje vertical. 

Programar un nuevo eje vertical suele generar una necesidad: definir una nueva forma de organizar los 8 cells de animación del sprite del jugador para adecuarse al nuevo tipo de movimiento. Por suerte esto también lo tenemos cubierto: es fácil definir tu propia animación para el personaje.

¿Por qué sólo el vertical? Porque suele ser suficiente para hacer de todo. ¿Y por qué no también el horizontal? Bueno, ahí estamos esperando vuestros *pull request*. Recordad que mayormente **MTE MK1** tiene características que hemos necesitado para nuestros juegos o que nos habéis pedido y hemos considerado factibles. 

Para añadir tu propio eje vertical deberás poner código en `my/ci/custom_veng.h`.

## El pifostio de los movimientos verticales.

A ver, voy a intentar explicar cómo está montado el eje vertical así a modo de culturilla general y así podremos entender mejor el tema.

Como sabrás, desde el día 1 **MTE MK1** soporta juegos en vista lateral y en vista genital. Además de otras historias, la principal diferencia radica en cómo se maneja el eje vertical, ya que el eje horizontal se controla exactamente igual para ambas vistas.

* En vista genital, el eje vertical lo controla el teclado. Si pulsas arriba se aplica aceleración hacia arriba, y si pulsas abajo se aplica aceleración hacia abajo. Si no pulsas nada se aplica fricción en el sentido contrario al movimiento.

* En vista lateral, el eje vertical lo controla la gravedad, de forma que en todo momento se aplica aceleración hacia abajo. Aparte de esto, hay un par de formas de conseguir velocidad negativa (hacia arriba): mediante los diversos tipos de salto o el jetpac.

Desde v5, **MTE MK1** permite varias cosas interesantes:

* Activar varias características del eje vertical *a la vez*. Si, en modo de vista lateral, definimos `VENG_SELECTOR` en `my/config.h`, podremos marcar a la vez varios motores de eje vertical (salto, jetpac, bootee, teclado (como en vista genital)) y elegir cuál está activo en cada momento dandole valores a la variable `veng_selector` (hay macros creadas en `definitions.h` para las selecciones: `VENG_JUMP`, `VENG_JETPAC`, `VENG_BOOTEE` y `VENG_KEYS`, respectivamente).

* Desactivar la gravedad en modo de vista lateral.

* Añadir tu código personalizado para manejar el eje vertical.

Esto permite muchas combinaciones. Lo más básico (que será lo que haremos en este capítulo), es dejar la gravedad tal y como está, desactivar todo lo demás (salto, jetpac, bootee y teclado), y añadir código para gestionar el movimiento del choco. Dejaremos comentado `VENG_SELECTOR` y desactivaremos todas las macros que controlan el movimiento vertical en modo lateral:

```c
	// my/config.h

	//#define PLAYER_HAS_JUMP 					// If defined, player is able to jump.
	//#define PLAYER_HAS_JETPAC 				// If defined, player can thrust a vertical jetpac
	//#define PLAYER_BOOTEE 					// Always jumping engine. 
	//#define PLAYER_VKEYS 						// Use with VENG_SELECTOR. Advanced.
	//#define PLAYER_DISABLE_GRAVITY			// Disable gravity. Advanced.
```

Pero si os dais cuenta, con estas características las posibilidades son infinitas. Por ejemplo sé podría añadir el movimiento de nadar de **Ninjajar** en `my/ci/custom_veng.h`, activar `VENG_SELECTOR`, y cambiar entre salto o nadar con diferentes valores de `PLAYER_G` dependiendo de si estamos o no en el agua.

Otra cosa que me gustaría mencionar es que, desde siempre, si tu juego no usa disparos, puedes activar a la vez (y sin `VENG_SELECTOR`) el jetpac y los saltos normales, ya que el primero emplea la tecla *arriba* y los segundos la tecla *fire*.

## El movimiento choco

Desde hace mucho tiempo en Mojonia habíamos querido hacer un juego protagonizado por un choco, Blip Blep, que hiciese cosas chocosas en el espacio, cerca de la galaxia de Choconia, y dijera ¡Blip, Blep!. Para eso el choco tendría que moverse como un choco, por lo que diseñamos este movimiento que describo aquí:

* Gravedad baja, para simular espacio o debajo del agua.
* Velocidad horizontal y aceleración/fricción bajas, para idem, y sobre todo porque la mayor parte del tiempo el choco no está posado en plataformas y queda mejor.
* Cuando pulsas FIRE, el choco se comprime *haciendo fuerza*.
* Al soltar FIRE, el choco sale propulsado hacia arriba con la fuerza que había hecho.

Cuanto más tiempo pulses FIRE, con más fuerza se impulsará el choco al soltarlo, por lo que necesitamos un contador, un valor de incremento, y un valor máximo.

## La animación choco

## Más cosas para el choco

Queremos que el choco pueda romper bloques rompiscibles cuando se haya lanzado hacia arriba con la suficiente fuerza. Para eso tendremos que ampliar nuestro código en `my/ci/custom_veng.h`. Detectaremos la colisión en el punto central de la fila superior del cuadro de 16x16 que contiene al sprite. Como esto sólo va a detectarse con el choco a determinada velocidad negativa, en este píxel hay cabeza de choco porque el choco estará estirado y quedará bien.
