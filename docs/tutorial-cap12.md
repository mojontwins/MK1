# Capítulo 12: Code Injection Points

Tras este nombre tan rimbombante se esconde una funcionalidad muy sencilla pero que, una vez que nos vayamos empapando hasta el tuétano de **MTE MK1**, puede darnos alas. Se trata de una serie de archivos en los que podemos añadir código C que son incluidos en partes clave del código. De esa forma podremos ampliar la funcionalidad del motor de formas muy interesantes o programar el gameplay igual que hacíamos mediante scripting, pero con mejor kung fu.

Hay una buena colección de puntos de inyección de código que están documentados en la [documentación](https://github.com/mojontwins/MK1/blob/master/docs/code_injection.md) (!), así que no nos vamos a parar en describirlos todos. Lo que haremos será tomar nuestro **Dogmole**, desactivar el script, y replicar toda la funcionalidad usando código C usando algunos de estos.

## Tocando el totete

Exacto: programar en C usando puntos de inyección de código significa tocarle directamente el totete al motor de **MTE MK1**. Eso significa que tendremos que conocer hasta cierto punto qué tocar y cómo: funciones de la API, variables globales importantes... Todo eso podréis mirarlo en la [documentación](https://github.com/mojontwins/MK1/blob/master/docs/code_injection.md). Sin embargo, aunque todo está ahí, trataremos de ir describiendo como es debido todo lo que usemos a medida que vayamos metiendo cosas.

## Recordando el diseño de gameplay

En el juego hay dos misiones: primero hay que encargarse de eliminar a todos los monjes. Esto abrirá el paso a la Universidad de Miskatonic (eliminando un piedro de la pantalla 2). Una vez abierta, tendremos que ir buscando las cajas y llevándolas al mostrador en la pantalla 0. Cuando estén las 10, terminaremos el juego.

## Empezando

Para empezar hemos copiado el proyecto en una carpeta nueva (podéis encontrarlo en `examples/dogmole_ci` del repositorio). Seguidamente, editamos `compile.bat` para cambiar el nombre del proyecto a `dogmole_ci` y posteriormente editamos `my/config.h` para comentar `ACTIVATE_SCRIPTING`.

Si recompilamos en este punto deberemos ver claramente que el script ocupa 0 bytes:

```
	Compilando script
	Convirtiendo mapa
	Convirtiendo enemigos/hotspots
	Importando GFX
	Compilando guego
	dogmole_ci.bin: 26713 bytes
	scripts.bin: 0 bytes
	Construyendo cinta
	Limpiando
	Hecho!
```

## Inicializando el juego

Vamos a usar los flags para almacenar valores (en concreto los flags 1 y 3, como en el script original). Sin embargo, al haber desactivado el script, no habrá nada que los inicialice al empezar cada partida, así que tendremos que hacerlo nosotros. Para ello usamos `my/ci/entering_game.h` (que equivale a la sección `ENTERING GAME` del script) y ponemos los dos flags que necesitamos a 0:

```c
	my/ci/entering_game.h

	flags [1] = 0;
	flags [3] = 0;
```

## Contando monjes

El motor se encarga de contar los enemigos que vamos eliminados en la variable `p_killed`. Como los únicos enemigos que pueden matarse son los monjes, en cuanto `p_killed` valga 20 sabremos que hemos eliminado a todos. Para rizar el rizo, el conversor `ene2h` cuenta cada tipo de enemigo de forma que nuestro código será super robusto si comparamos `p_killed` con el número total de enemigos de tipo 3 (que son los monjes). Las constantes `N_ENEMS_TYPE_n` contienen el número exactos de enemigo de tipo n, por lo tanto tendremos que comparar con `N_ENEMS_TYPE_3`.

El sitio perfecto para hacer esta comprobación es el punto de inyección de código `my/ci/on_enemy_killed.h`, que se ejecutará cada vez que eliminemos un enemigo. Para funcionar como en el script, levantaremos el flag 3 cuando hayamos eliminado los 20 monjes.

Abriremos `my/ci/on_enemy_killed.h` y añadiremos el siguiente trozo de código:

```c
	// my/ci/on_enemy_killed.h

	if (p_killed == N_ENEMS_TYPE_3) {
		flags [3] = 1;
	}
```

Otra cosa que hacíamos era usar EXTERN para ejecutar el código que mostraba el cartel de que la puerta estaba abierta. Como la función con nuestro código extern no está disponible al haber desactivado el scripting tendremos que añadir el código directamente en el if que acabamos de meter. Queda así:

```c
	// my/ci/on_enemy_killed.h

	if (p_killed == N_ENEMS_TYPE_3) {
		flags [3] = 1;

		// Print message
		_t = 79;
		_x = 8; _y = 10; _gp_gen = my_spacer;  print_str ();
		_x = 8; _y = 12;                       print_str ();
		_x = 8; _y = 11; _gp_gen = my_message; print_str ();

		sp_UpdateNowEx (0);

		// Wait
		espera_activa (150);

		// Force reenter
		o_pant = 99;
	}
```

Este código necesita dos variables con las cadenas que se imprimen, `my_spacer` y `my_message`. Para definir nuestras propias variables usamos `my/ci/extra_vars.h`:

```c
	// my/ci/extra_vars.h

	unsigned char *my_spacer =  "                ";
	unsigned char *my_message = " PUERTA ABIERTA ";
```

En el trozo de código que hemos escrito vemos varias cosas:

### Imprimir un string

Para imprimir un string empleamos la función `print_str`. La función, como la mayoría del motor de **MTE MK1**, no recibe ningún parámetro, pero necesita que demos valores a las globales generales `_x` e `_y` con las coordenadas, `_t` con el atributo, y `_gp_gen` apuntando a la cadena.

### Enviar el buffer a la pantalla

La impresión se hace en el buffer de **splib2**. Para que sea visible hay que decirle a la biblioteca que nos lo envíe a la pantalla. Para ello empleamos la función custom que hemos añadido en mojonia a **splib2** `sp_UpdateNowEx` que se encarga de volcar a la pantalla los cuadros de 8x8 (rejilla de caracteres/atributos) que han cambiado. La función recibe un parámetro que puede ser 0 o 1 dependiendo de si queremos que se actualicen los sprites en los cuadros que cambian. 

### Esperar un rato

La función `espera_activa` del motor de **MTE MK1** espera un tiempo (!) y puede interrumpirse pulsando una tecla.

### Forzar reentrada

Llamaos *reentrada* a recargar completamente la pantalla. En este caso, esto es necesario porque hemos impreso un cartel que ha tapado parte de la misma. El motor de **MTE MK1** llama a `draw_scr`, que se encarga de dibujar e inicializar una nueva pantalla, cada vez que la variable `n_pant` (número de pantalla actual) y `o_pant` (número de pantalla anterior) son diferentes. Una forma fácil de redibujar la pantalla sin cambiar de idem es poner en `o_pant` a un valor no válido, como puede ser 99.

(...)