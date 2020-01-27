# Capítulo 11: Juegos multinivel (48K)

Este capítulo es muy interesante pero no ponemos paquetito de materiales, ya que ¿qué mejor paquete que el del Sgt Helmet? Entre los ejemplos de **MTE MK1** tienes la nueva versión de uno de los juegos de Mojon Twins que más nos gusta a los Mojon Twins, esta vez con tres fases. Puedes mirar las cosas de las que hablamos aquí en marcha en ese juego.

## En qué se basa el multiniveleo

Básicamente el multinivel en **MTE MK1** (¡y en **MK2**!) se basa un poco en engañar al chamán. Básicamente el motor es como el abuelo y tú vas y le cambias las pastillas de sitio y le pones las verdes en vez de las rojas. 

Para entendernos, **MTE MK1** funcionará (salvo por un par de detalles) como si estuviese ejecutando un juego normal de sólo un nivel como los de la churrera de toda la vida, solo que habrá un agente que se encargará de, antes de que empiece el bucle de juego, de *descomprimir* un nuevo set formado por mapa, cerrojos, tileset, enemigos, hotspots, comportamientos y opcionalmente sprites sobre los actuales, efectivamente *cambiando de fase*.

Lo que se hace para construir un juego de **MTE MK1** multinivel es configurar una especie de nivel "dummy" o "vacío" para hacer "sitio": un mapa a 0, cerrojos vacíos, un tileset con todos los tiles negros, todas las pantallas sin enemigos ni hotspots, y un montón de comportamientos a cero. Obviamente, a esto no se puede jugar. Pero además cargamos una serie de binarios comprimidos con mapas, tilesets, enemigos... y antes de empezar el juego descomprimimos los que necesitemos sobre los espacios "vacíos" que hemos reservado.

## Activando en `config.h`

En principio, para activar el multinivel sólo tendremos que tocar un par de cosas en `my/config.h`. Obviamente, luego habrá que tunear por varios sitios, pero lo más básico es configurar esto:

```c
	#define COMPRESSED_LEVELS 					// use levels.h instead of mapa.h and enems.h (!)
	#define MAX_LEVELS					3		// # of compressed levels
```

Esto activará los manejes necesarios para el multiniveleo y además indicará que el número de niveles de nuestra secuencia será 3. O sea, que tendremos tres niveles.

## Modificando `compile.bat`

Como hemos dicho, los recursos comprimidos se descomprimirán sobre "espacios" especiales para cada tipo de datos que maneja el motor. Por lo general, esto implica que no tendremos que generar enemigos o mapas desde `compile.bat`. Lo único que vamos a dejar es la generación de un tileset "vacío" (porque necesitamos la fuente), un spriteset y las pantallas fijas. Del hacer hueco para el resto ya se encarga **MTE MK1** con la configuración que le hemos hecho. Por tanto abrimos en `compile.bat` y:

1. Nos fumamos la conversión del mapa (`mapcnv`) y la importación de los enemigos (`ene2h`).

2. Modificamos la conversión del tileset (`ts2bin`) para que genere uno usando la fuente pero dejando todos los tiles a negro. Para ello empleamos la cadena `none` en lugar de una ruta al un archivo de tileset:

```
	..\..\..\src\utils\ts2bin.exe ..\gfx\font.png none tileset.bin 7 >nul
```

3. Si fueramos a cambiar el spriteset en cada fase tendríamos que eliminar también la llamada a `sprcnv`.

## Preparando los assets

Los *assets* o los *recursos* son las *cosas* con las que vamos a construir nuestros niveles. Como hemos mencionado, un *nivel* de **MTE MK1** se corresponde de (voy a resumirte cosas que ya sabes):

1. Un mapa, en formato PACKED (75 bytes por pantalla, 2 tiles por byte, 16 tiles) o UNPACKED (150 bytes por pantalla, 1 tile por byte, 48 tiles).

2. Un set de cerrojos. Cada cerrojo representa eso, un cerrojo. Se almacena en qué pantalla está y en qué coordenadas, y si está abierto o cerrado.

3. Un tileset, o 192 carácteres o "patrones" y los atributos (o colores) con los que se pintan. 

4. Un set de enemigos, con tres por pantalla. Cada enemigo ocupa 10 bytes.

5. Un set de hotspots, uno por pantalla. Cada hotspot ocupa 3 bytes.

6. Un set de comportamientos de tile.

7. Opcionalmente (en 48K, en 128K no es opcional) un spriteset de 16 tiles de 144 bytes más una "cabecera" de 16 bytes (2320 bytes).

Nosotros tendremos que generar nuestro conjunto de recursos, comprimirlos en formato aplib, y luego combinarlos para formar los niveles. El primer paso, por tanto (aparte de, ejem, *hacerlos*) será generar binarios comprimidos de cada uno de ellos, en el formato de **MTE MK1**. 

Personalmente, a mi me gusta crearme un archivo `.bat` aparte de `compile.bat` que se encargue de convertir y comprimir todos los assets. En este archivo llamaremos a los conversores para cada recurso y luego comprimiremos el resultado. Puedes guardarlo todo en `/bin` y así no lo tienes por medio.

Si eres un poco avispado estarás pensando que no paro de hablar de binarios y algunos de los conversores echan archivos .h con los arrays en formato código. Y así es, ¡cinco puntos para Gryffindor, señorita Granger!. Por suerte, hay versiones de esos conversores pensadas para multinivel que escupen binarios. Y en esta sección lo vamos a ver usando la generación de recursos de **Helmet** como ejemplo.



El levelset

Controlando la condición de final de cada nivel

Número de objetos
Llegar a un sitio concreto
Scripting
Inyección de código custom
