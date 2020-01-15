# Capítulo 7: Primer montaje

Antes que nada, bájate el paquete de materiales correspondiente a este capítulo pulsando en este enlace:

[Material del capítulo 7](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-zip/churreratut-capitulo7.zip)

## Venga ya. ¡Quiero ver cosas moviéndose!

En eso estamos. Este capítulo va a ser densote, pero densote. Prepárate para absorver cual porífero abisal toneladas y toneladas de información. Para seguir este capítulo recomendamos que te comas un buen tico-tico de sandía, que fortalece el cerebro y el peshito.

![Enemigos en el mapa](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/07_tico_tico.jpg)

Para empezar de fácil, vamos primero a hacer una especie de recapitulación para ver que tenemos todo lo que necesitamos.

1. El primer paso fue hacerse con una copia del repositorio y copiar el contenido de la carpeta `/src` a una nueva con el nombre de tu proyecto.

2. El segundo paso se trató de editar `/dev/compile.bat` y cambiar el nombre del juego en la linea que empieza por `set game=`.

3. Todos los gráficos deberían estar en `/gfx` con los nombres correctos, a saber: `font.png` y `work.png` para los patrones fijos, `sprites.png`, `sprites_extra.png` y `sprites_bullet.png` para los sprites, y `loading.png`, `title.png`, `marco.png` (si usas marco separado de la pantalla de título) y `ending.png` para las pantallas fijas.

4. El cuarto paso fue poner el mapa en `/map` exportado en formato `MAP`, y luego volver a editar `/dev/compile.bat` para modificar la linea del conversor (`mapcnv`) con el tamaño de tu mapa: Para **Dogmole** sería:

```
    ..\utils\mapcnv.exe ..\map\mapa.map 8 3 15 10 15 packed > nul
```

5. Seguidamente pusimos los enemigos y los hotspots y los guardamos en `/enems` como `enems.ene`.

¿Lo tenemos todo? ¿Seguro? Bien. Entonces podemos empezar a configurar el motor para hacer nuestra primera compilación. Agárrense, que vienen curvas. Y mucho texto.

## El archivo de configuración

Si te fijas en nuestra carpeta de desarrollo `/dev`, existe una subcarpeta `/dev/my`, y dentro de esta un archivo llamado `config.h`. Quédate con su cara: es el archivo más importante de todos, ya que es el que decide qué trozos del engine se ensamblan para formar el güego, y qué valores de parámetros se emplean en dichos trozos. Tendrías que haberlo hecho ya, pero por si acaso: abre `/dev/my/config.h` en tu editor de textos favorito (que no sea mierder). Y ahora flípalo con la cantidad de cosas que hay. Vamos a ir por partes, explicando cada sección, para qué sirven los valores, cómo interpretarlos, y rellenándolos para nuestro Dogmole de ejemplo. 

En este archivo lo que hay es un porrón de directivas `#define`, que definen (!) símbolos que luego están por el código diciéndole al compilador qué partes o no incluir, o qué valor dar a algunas partes. Por lo general, nuestro cometido aquí será *comentar* las directivas que no queramos, y *descomentar* (!) las que sí queramos. La expresión *comentar*, en este contexto, es un false friend de una elipsis y más o menos significa "convertir en un comentario", o sea, en texto que el compilador ignore. **MTE MK1** está escrito en lenguaje `C`, por lo que la forma de hacer que una linea sea ignorada es ponerle dos barras delante: `//`. Cada vez que hablemos de *desactivar* o *comentar* una directiva nos estaremos refiriendo a ponerle `//` delante, y cada vez que digamos *activar* o *descomentar* nos estaremos refiriendo a quitarle el `//`. 

Aquí es importante tener un buen editor de textos *no mierder* que además tenga resaltado de sintaxis, porque eso nos ayudará a ver muy fácilmente qué está activo y qué no, ya que los comentarios suelen ponerse todos de un color especial.

![Un color especial](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/07_color_especial.png)

Otra convención que hemos tenido a bien tomar en **MTE MK1** es que un valor de `99` significa "no uses esto" o "ignora este parámetro". Esto es cierto en general, excepto para el máximo de vida del jugador (`PLAYER_LIFE`), que puede ser 99 perfectamente.

Tomemos aire y empecemos.

## Configuración general

Esta sección empieza con un `#define MODE_128K` que está desactivado y que por ahora ignoraremos amablemente. Sin aspavientos.

En este apartado se configuran los valores generales de güego: el tamaño del mapa, el número de objetos (si aplica), y cosas por el estilo:

### Tamaño del mapa

```c
    #define MAP_W                       8       //
    #define MAP_H                       3       // Map dimensions in screens
```

Estas dos directivas definen el tamaño que tiene nuestro mapa. Si recordamos, para nuestro **Dogmole** el mapa mide 8×3 pantallas. Rellenamos, por tanto, 8 y 3 (W de Width, anchura, y H de Height, altura).

### Posición de inicio

```c
    #define SCR_INICIO                  16      // Initial screen
    #define PLAYER_INI_X                1       //
    #define PLAYER_INI_Y                7       // Initial tile coordinates
```

Aquí definimos la posición del personaje principal cuando se empieza una nueva partida. `SCR_INICIO` define qué pantalla, y `PLAYER_INI_X` e `Y` definen al coordenada del tile donde aparecerá el personaje. Nosotros empezamos en la primera pantalla de la tercera fila, que (si contamos, o calculamos) es la pantalla número 16. Hemos colocado a Dogmole sobre el suelo y junto a la pared de roca, en la casilla de coordenadas (1, 7) (¡recuerda! Los verdaderos desarrolladores empiezan a contar en el 0).

### Posición de fin

```c
    #define SCR_FIN                     99      // Last screen. 99 = deactivated.
    #define PLAYER_FIN_X                99      //
    #define PLAYER_FIN_Y                99      // Player tile coordinates to finish game
```

Aquí definimos la posición final a la que debemos llegar para terminar el güego. Puede interesarnos hacer un güego en el que sencillamente tengamos que llegar a un sitio en concreto para terminarlo. En ese caso rellenaríamos estos valores. Como en el güego que nos ocupa esto no lo vamos a usar, ponemos 99 para que sea ignorado.

### Número de objetos

```c
    #define PLAYER_NUM_OBJETOS          99      // Objects to get to finish game
```

Este parámetro define el número de objetos que tenemos que reunir para terminar el güego. En güegos sencillos como **Lala Prologue**, el conteo de objetos y la comprobación de que lo tenemos todos es automática y emplea este valor: en cuanto el jugador tenga ese número de objetos se mostrará la pantalla del final. En nuestro caso, no: nosotros vamos a usar scripting para manejar los objetos y las comprobaciones de que hemos hecho todo lo que teníamos que hacer para ganar la partida, así que no vamos a necesitar para nada esto. Por tanto, pondremos 99 para que el motor ignore el conteo de objetos automático. Si estás haciendo un güego por tu cuenta en el que simplemente hay que recoger todos los objetos, como en tantos que hemos lanzado, coloca aquí el número máximo de objetos necesarios.

### Vida inicial y valor de recarga

```c
    #define PLAYER_LIFE                 15      // Max and starting life gauge.
    #define PLAYER_REFILL               1       // Life recharge
```

Aquí definimos cuál será el valor inicial de vidas del personaje y cuánto se incrementará cuando cojamos una vida extra. En Dogmole, empezaremos con 15 vidas y recargaremos de 1 en 1 al encontrar corazones. Como vamos a configurar el motor para que una colisión con un enemigo nos haga parpadear, las vidas se perderán poco a poco. En güegos como Lala Prologue, en los que las colisiones producen rebotes y el enemigo nos puede golpear muchas veces, las “vidas” se consideran “energía” y se usan valores más altos, como 99, y recargas más generosas, de 10 o 25.

### Juegos multi nivel

Por ahora vamos a pasar de los juegos multi nivel. Pero, como ya hemos mencionado (y habrás visto), es algo totalmente posible. Internamente se basa en tener reservado espacio para mapa y enemigos, y quizá también gráficos y comportamientos, y luego tener una colección de recursos comprimidos que se descomprimen sobre este espacio para cada nivel que se carga, siguiendo diferentes configuraciones.

## Tipo de motor

Ahora empezamos con lo bueno: la configuración de las partes de código que serán ensambladas cual transformer múltiple para formar nuestro engendro. Aquí es donde está toda la chicha. Es divertido porque podemos experimentar usando combinaciones extrañas (lo hemos hecho a saco en la Covertape #2) y probando los efectos. Como ya mencionamos, es imposible activarlo todo, y no sólo porque haya cosas que se anulan entre sí, sino porque, sencillamente, no cabría.

Vayamos por partes, como dijo Victor Frankenstein…

### Tamaño de la caja de colisión

```c
    // Bounding box size
    // -----------------
                                                // Comment both for normal 16x16 bounding box
    #define BOUNDING_BOX_8_BOTTOM               // 8x8 aligned to bottom center in 16x16
    //#define BOUNDING_BOX_8_CENTERED           // 8x8 aligned to center in 16x16
    //#define SMALL_COLLISION                   // 8x8 centered collision instead of 12x12
```

La caja de colisión se refiere al cuadrado que ocupa “realmente” nuestro sprite. Para entendernos, nuestro sprite va a chocar contra el escenario. Dicha colisión se calcula con un cuadrado imaginario que puede tener dos tamaños: 16×16 u 8×8. El motor sencillamente comprueba que ese cuadrado no se meta en un bloque obstáculo.

Para que entiendas la diferencia, fíjate cómo interactúa Lala con el escenario en **Lala Prologue** (que tiene una caja de colisión de 16×16 que ocupa todo el sprite) y en **Lala Lah** (en la que usamos una caja de colisión de 8×8, más pequeña que el sprite). 

Si elegimos una colisión de 8×8 con el escenario, tenemos dos opciones: que el recuadro esté centrado en el sprite o que esté en la parte baja:

![Tipos de colisión 8×8](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/07_colision.png)

La primera opción (recuadro centrado) está pensada para güegos con vista genital, como **Balowwwn** o **D'Veel'Ng**. La segunda funciona bien con güegos de vista lateral o güegos con vista genital “con un poco de perspectiva”, como **Mega Meghan**.

Las dos primeras directivas se refieren a colisiones **contra el escenario**. Solo una de las dos directivas puede estar activa (porque son excluyentes): si queremos colisión 8×8 centrada activamos `BOUNDING_BOX_8_CENTERED` y desactivamos la otra. Si queremos colisión 8×8 en la parte baja activamos `BOUNDING_BOX_8_BOTTOM` y desactivamos la otra. **Si queremos colisión de 16×16 desactivamos ambas**.

La tercera directiva se refiere a las colisiones **contra los enemigos**. Si activamos `SMALL_COLLISION`, los sprites tendrán que tocarnos mucho más para darnos. Con `SMALL_COLLISION` los enemigos son más fáciles de esquivar. Funciona bien en güegos con movimientos rápidos, como **Bootee**. Nosotros la vamos a dejar desactivada para **Dogmole**.

### Directivas generales

```c
    #define PLAYER_AUTO_CHANGE_SCREEN           // Player changes screen automaticly (no need to press direction)
```

Si definimos esto, el jugador cambiará de pantalla cuando salga por el borde. Si no se define, habrá que estar pulsando la dirección concreta para que esto ocurra. Normalmente se deja activada, para que si el jugador se mueve sólo por inercia también cambie de pantalla. No se nos ocurre una situación en la que esto no sea deseable, pero de todos modos ahí está la opción de desactivarlo.

```c
    //#define PLAYER_CHECK_MAP_BOUNDARIES       // If defined, you can't exit the map.
```

Si se activa, el motor comprobará que no nos salimos del mapa. Si tu mapa está bien delimitado con tiles obstáculos por todos los lados, puedes desactivar esta directiva y ahorrar espacio. Tampoco hace falta activarla si el único sitio no delimitado es la parte superior del mapa, como es nuestro caso en **Dogmole**, por lo que la dejamos deshabilitada.

```c
    #define DIRECT_TO_PLAY                      // If defined, title screen is also the game frame.
```

Activamos esto para conseguir lo que dijimos cuando estábamos haciendo las pantallas fijas: que el título del juego sirva también como marco. Si tienes un `title.png` y un `marco.png` separados, deberás desactivarla. En nuestro caso, en el que sólo tenemos un `title.png` que también incluye marco, la dejamos activada.

```c
    //#define DEACTIVATE_KEYS                   // If defined, keys are not present.
    //#define DEACTIVATE_OBJECTS                // If defined, objects are not present.
```

Estas dos directivas sirven para desactivar llaves u objetos. Si tu juego no usa llaves y cerrojos, deberás activar `DEACTIVATE_KEYS`. Si no vas a usar objetos, activamos `DEACTIVATE_OBJECTS`. Así ahorramos toneladas de código.

Seguramente alguno de vosotros estará pensando ¿por qué no activamos `DEACTIVATE_OBJECTS` en **Dogmole**, si hemos dicho que los objetos los vamos a controlar por scripting? ¡Buena pregunta! Es sencillo: lo que vamos a controlar por scripting es el **conteo de objetos** y la **condición final**, pero necesitamos que el motor gestione la **recogida** y **colocación** de los objetos. No nos los podemos fumar.

```c
    #define ONLY_ONE_OBJECT                     // If defined, only one object can be carried at a time.
    #define OBJECT_COUNT                1       // Defines which FLAG will be used to store the object count.
```

Seguimos con dos directivas con una aplicación muy específica: si activamos la primera, `ONLY_ONE_OBJECT`, sólo podremos llevar un objeto *cada vez*. Una vez que cojas un objeto, la recogida de objetos se bloquea y no puedes coger más. Para volver a activar la recogida de objetos hay que *liberar el objeto*, y para eso tendremos que usar scripting o *inyección de código* (que algún día explicaremos en otro tutorial). 

Con esto conseguimos en **Dogmole** el efecto que necesitamos de que haya que ir llevando las cajas una a una: configuramos el motor para que sólo permita que llevemos un objeto (una caja), y luego, cuando hagamos el script, haremos que cuando llevemos la caja al sitio donde hay que irlas depositando (un sitio concreto de la Universidad) *liberemos el objeto* para que se vuelva a activar la recogida de objetos y así podamos ir a por la siguiente caja.

La segunda directiva, `OBJECT_COUNT`, sirve para que en el **marcador de objetos**, en lugar de la cuenta interna de objetos recogidos, **se muestre el valor de uno de los *flags* del sistema de scripting**. Ya lo veremos en el futuro, cuando expliquemos el motor de scripting, pero los scripts tienen hasta 32 variables o *flags* que podemos usar para almacenar valores y realizar comprobaciones. Cada variable tiene un número. Si definimos esta directiva, el motor mostrará el valor del flag indicado en el contador de objetos del marcador, en lugar del contador interno de objetos. Desde el script iremos incrementando dicho valor cada vez que el jugador llegue a la Universidad y deposite un objeto.

En definitiva, sólo necesitaremos definir `OBJECT_COUNT` si somos nosotros los que vamos a llevar la cuenta, a mano, desde el script (o mediante inyección de código), usando uno de sus flags. Si no vamos a usar scripting, o no vamos a necesitar controlar a mano el número de objetos recogidos, tendremos que comentar esta directiva para que no sea tomada en cuenta.

```c
    //#define DEACTIVATE_EVIL_TILE              // If defined, no killing tiles (behaviour 1) are detected.
```

Activa esta directiva si quieres desactivar los tiles que te matan (tipo 1). Si no usas tiles de tipo 1 en tu juego, descomenta esta linea y ahorrarás espacio, ya que así la detección de tiles matantes no se incluirá en el código.

```c
    #define PLAYER_BOUNCES                      // If defined, collisions make player bounce
    //#define FULL_BOUNCE                       // If defined, evil tile bounces equal MAX_VX, otherwise v/2
    //#define SLOW_DRAIN                        // Works with bounces. Drain is 4 times slower
    #define PLAYER_FLICKERS                     // If defined, collisions make player flicker instead.
```

Estas directivas controlan los rebotes. Si activas `PLAYER_BOUNCES`, el jugador rebotará contra los enemigos al tocarlos. La fuerza de dicho rebote se controla con `FULL_BOUNCE`: si se activa, los rebotes serán mucho más bestias porque se empleará la velocidad con la que el jugador avanzaba originalmente, pero en sentido contrario. Desactivando `FULL_BOUNCE` el rebote es a la mitad de la velocidad (y por tanto menos desagradable).

Si definimos, además, `SLOW_DRAIN`, la velocidad a la que perderemos energía si nos quedamos atrapados en la trayectoria del enemigo (acuérdense de **Lala Prologue**, **Sir Ababol** o la versión original de **Viaje al Centro de la Napia**) será cuatro veces menor. Esto se usa en **Bootee**, donde es fácil quedarse atrapado en la trayectoria de un enemigo y complicado salir de la misma. Esto hace el juego más asequible.

Como podrás imaginar, `FULL_BOUNCE` y `SLOW_DRAIN` dependen de `PLAYER_BOUNCES`. Si `PLAYER_BOUNCES` está desactivada, las otras dos directivas son ignoradas.

Activando `PLAYER_FLICKERS` logramos que el personaje parpadee si colisiona con un enemigo (siendo invulnerable durante un corto período de tiempo). Normalmente elegiremos entre `PLAYER_BOUNCES` y `PLAYER_FLICKERS`, **pero pueden funcionar juntas**. Nosotros, en **Dogmole**, queremos que el protagonista únicamente parpadee al colisionar con un enemigo, por lo que desactivamos `PLAYER_BOUNCES` y activamos `PLAYER_FLICKERS`.

```c
    //#define MAP_BOTTOM_KILLS                  // If defined, exiting the map bottomwise kills.
```

Desactiva esta directiva si quieres que, en el caso de que el personaje vaya a salirse del mapa por abajo, el motor le haga rebotar y le reste vida, como ocurre en **Zombie Calavera**. Si tu mapa está cerrado por abajo, desactívala para ganar unos bytes.

```c
    //#define WALLS_STOP_ENEMIES                // If defined, enemies react to the scenary
    //#define EVERYTHING_IS_A_WALL              // If defined, any tile <> type 0 is a wall, otherwise just 8.
```

Si activas `WALLS_STOP_ENEMIES`, los tiles de tipo 8 pararán la trayectoria de los enemigos lineales, haciéndolos cambiar de dirección igual que si llegasen a sus límites de trayectoria. Esto es interesante por ejemplo si quieres hacer trayectorias diagonales interesantes o tienes tiles empujables o escenario destructible.

Si además activas `EVERYTHING_IS_A_WALL`, cualquier tile de comportamiento distinto de 0 (recuerda los tipos de tile que explicamos en el capítulo 2) será considerado un obstáculo.

## Tipos de enemigos extra

Vamos a ver ahora un conjunto de directivas que nos servirán para activar los enemigos de tipos 6 o 7. Recordad lo que mencionamos sobre este tipo de enemigos: el 6 son los Fanties y el 7 son los enemigos que te persiguen de **Mega Meghan** y **Sgt. Helmet: Training Day**.

En **Dogmole** no usamos ningún tipo de enemigo extra. Para tus juegos, puedes experimentar con estos bicharracos. Aquí explicamos cómo se configuran y para qué sirven las cosas

### Los Fanties

Los Fanties van volando por la pantalla en trayectorias suaves y persiguen al jugador. Hay dos tipos de Fanties: los sencillos, que simplemente aparecen donde los has puesto en Ponedor y persiguen al jugador, y los tipo "Homing Fanties", que permanecen en su sitio a menos que te acerques a determinada distancia. Es como si fueran cegatos. Si no te ven, no te persiguen. Si te alejas, dejarán de verte y volverán a su sitio inicial (que nosotros llamamos *su nido*).

Los Fanties se activan con esta directiva (en **Dogmole** la dejamos desactivada):

```c
    //#define ENABLE_FANTIES                    // If defined, Fanties are enabled!
```

Y se configuran con estas otras:

```c
    //#define FANTIES_BASE_CELL         2       // Base sprite cell (0, 1, 2 or 3)
    //#define FANTIES_SIGHT_DISTANCE    104     // Used in our type 6 enemies.
    //#define FANTIES_MAX_V             256     // Flying enemies max speed (also for custom type 6 if you want)
    //#define FANTIES_A                 16      // Flying enemies acceleration.
    //#define FANTIES_LIFE_GAUGE        10      // Amount of shots needed to kill flying enemies.
    //#define FANTIES_TYPE_HOMING               // Unset for simple fanties.
```

1. `FANTIES_BASE_CELL` selecciona con qué gráfico pintaremos a los fanties de entre los 4 disponibles (3 si estás en vista lateral y usas plataformas). El valor debe ser 0, 1, 2 o 3, porque recuerda, los verdaderos desarrolladores empiezan a contar desde 0.

2. `FANTIES_SIGHT_DISTANCE` sólo tiene sentido para los fanties de tipo "Homing". Es la distancia, en píxel, a la que ven. Si no te acercas a menos de esa distancia se quedarán en su *nido* (donde los pones con el Ponedor).

3. `FANTY_MAX_V` define la velocidad máxima. Para hacerte una idea, divide el valor entre 64 y el resultado es el número de píxels que avanzará por cada cuadro (frame) de juego como máximo. Si definimos 256, el enemigo volador podrá acelerar hasta los 4 píxels por frame.

4. `FANTY_A` es el valor de aceleración. Cada cuadro de juego, la velocidad se incrementará en el valor indicado en dirección hacia el jugador, si no está escondido. Cuanto menor sea este valor, más tardará el enemigo en reaccionar a un cambio de dirección del jugador.

5. `FANTIES_LIFE_GAUGE` define cuántos tiros deberá recibir el bicharraco para morirse, si es que hemos activado los tiros (ver más adelante).

6. `FANTIES_TYPE_HOMING` sirve para seleccionar el tipo de Fanties. Si la activas, serán de tipo "Homing". Si la desactivas, serán de los sencillos.

### Los Enemigos Increíblemente Jartibles

La casilla donde los pones en Ponedor será el "punto de aparición", o el "spawning point" para los que les guste el Checoslovaco. En ese punto, cada cierto tiempo, aparecerá un enemigo que perseguirá al jugador. Cuando el enemigo muera (a tiros, normalmente), tras ese cierto tiempo, aparecerá un nuevo enemigo. Y así *ad nauseam*. De ahí el nombre del tipo de enemigos. Los enemigos que te persiguen, por cierto, se detienen con los obstáculos del escenario, lo cual es de agradecer.

Los EIJs se activan con esta directiva (en **Dogmole** la dejamos desactivada):

```c
    //#define ENABLE_PURSUERS                   // If defined, type 7 enemies are active
```

Y se configuran con estas otras:

```c
    //#define DEATH_COUNT_EXPRESSION    20+(rand()&15)
    //#define PURSUERS_BASE_CELL        3       // If defined, type 7 enemies are always #
```

1. `DEATH_COUNT_EXPRESSION`. Si tenemos activado el motor de disparos, cuando matemos a un enemigo de tipo 7 tardará un tiempo en volver a salir. Dicho tiempo, expresado en número de cuadros (frames), se calcula usando la expresión definida en esta directiva. La que se ve en el ejemplo es la que se emplea en **Sgt. Helmet: Training Day**: 20 más un número al azar entre 0 y 15 (o sea, entre 20 y 35 frames).

2. `PURSUERS_BASE_CELL` selecciona con qué gráfico pintaremos a los EIJs de entre los 4 disponibles (3 si estás en vista lateral y usas plataformas). El valor debe ser 0, 1, 2 o 3, porque recuerda, bla bli blu.

## Motor de bloques empujables

Estas dos directivas activan y configuran los bloques empujables. Nosotros no vamos a usar bloques empujables en Dogmole, por lo que las desactivamos. Activar la primera (PLAYER_PUSH_BOXES) activa los bloques, de forma que los tiles #14 (con comportamiento tipo 10, recuerda) podrán ser empujados.

El motor de bloques empujables se activa con:

```c
    //#define PLAYER_PUSH_BOXES                 // If defined, tile #14 is pushable. Must be type 10.
```

Y se configura con:

```c
    //#define FIRE_TO_PUSH                      // If defined, you have to press FIRE+direction to push.
    //#define ENABLE_PUSHED_SCRIPTING           // If defined, nice goodies (below) are activated:
    //#define MOVED_TILE_FLAG           1       // Current tile "overwritten" with block is stored here.
    //#define MOVED_X_FLAG              2       // X after pushing is stored here.
    //#define MOVED_Y_FLAG              3       // Y after pushing is stored here.
    //#define PUSHING_ACTION                    // If defined, pushing a tile runs PRESS_FIRE script
```

1. `FIRE_TO_PUSH`: Si está activa, el jugador debe pulsar fire además de la dirección en la que empuja o no. En **Cheril of the Bosque**, por ejemplo, no hay que pulsar fire: sólo tocando el bloque mientras avanzamos se desplazará. En **D'Veel'Ng**, sí que es necesario pulsar fire para empujar un bloque. Si vas a usar bloques empujables, debes decidir la opción que más te gusta (y que mejor se adecue al tipo de gameplay que quieras conseguir).

2. `ENABLE_PUSHED_SCRIPTING` activa la integración del sistema de scripting con los bloques empujables. Dicha integración se configura con las siguientes directivas:

3. `MOVED_TILE_FLAG`, `MOVED_X_FLAG` y `MOVED_Y_FLAG`: Cuando se empuja un bloque empujable, el tile que "pisa" se almacena en el flag que diga `MOVED_TILE_FLAG`, y sus coordenadas en los flags que digan `MOVED_X_FLAG` y `MOVED_Y_FLAG`. Con esto sabemos, desde el scripting, un montón de cosas útiles sólo mirando el valor de esas flags.

4. `PUSHING_ACTION`: Si la activamos, las cláusulas de las secciones `PRESS_FIRE` de la pantalla actual serán ejecutadas tras copias los valores a los flags definidos más arriba cuando movamos un bloque empujable. Cuando expliquemos el sistema de scripting esto no te sonará a chino, sólo a croata.

## Motor de disparos

El motor de disparos es bastante costoso en cuanto a memoria. Activarlo incluye bastantes trozos de código, ya que hay que comprobar más colisiones y tener en cuenta muchas cosas, además de los sprites extra necesarios. Tiene mogollón de cosas configurables y se puede usar para cosas que en un principio no se parecen a un motor de disparos. Échale imaginación, que de eso se trata.

El motor de disparos se activa con (desactivada en **Dogmole**):

```c
    //#define PLAYER_CAN_FIRE                   // If defined, shooting engine is enabled.
```

Y se configura con todas estas, que partimos en bloques:

```c
    //#define PLAYER_CAN_FIRE_FLAG      1       // If defined, player can only fire when flag # is 1
    //#define PLAYER_BULLET_SPEED       8       // Pixels/frame. 
    //#define MAX_BULLETS               3       // Max number of bullets on screen. Be careful!.
```

1. `PLAYER_CAN_FIRE_FLAG` se usa con scripting o inyección de código. Si está activa, el jugador sólo podrá disparar si el valor del flag que indica es 1. Puedes usarlo para que no se pueda matal hasta que se encuentre la pihtola.

2. `PLAYER_BULLET_SPEED` controla la velocidad de las balas. 8 píxels por cuadro es un buen valor y es el que hemos usado en todos los güegos. Un valor mayor puede hacer que se pierdan colisiones, ya que todo lo que ocurre en pantalla es discreto (no continuo) y si un enemigo se mueve rápidamente en dirección contraria a una bala que se mueve demasiado rápido, es posible que de frame a frame se crucen sin colisionar. Si piensas un poco en ello y te imaginas el juego en cámara lenta como una sucesión de frames lo entenderás.

3. El valor de `MAX_BULLETS` controla el número máximo de balas que podrá haber en pantalla. Ten cuidado con esto, porque valores muy altos podrían comer mucha memoria y además ralentizar bastante el juego. 

```c
    //#define PLAYER_BULLET_Y_OFFSET    6       // vertical offset from the player's top.
    //#define PLAYER_BULLET_X_OFFSET    0       // vertical offset from the player's left/right.
```

Estas dos directivas definen dónde aparecen las balas cuando se disparan. El comportamiento de estos valores cambia según la vista:

* Si el güego es en **vista lateral**, sólo podemos disparar a la izquierda o a la derecha (y, si lo configuramos, también en diagonal, pero sólo influye si el jugador mira a izquierda o a derecha). En ese caso, `PLAYER_BULLET_Y_OFFSET` define la altura, en píxels, a la que aparecerá la bala contando desde la parte superior del sprite del personaje. Esto sirve para ajustar de forma que salgan de la pistola o de donde queramos (de la pisha por ejemplo). `PLAYER_BULLET_X_OFFSET` se ignora completamente.

* Si el güego es en **vista genital**, el comportamiento es igual que el descrito si miramos para la izquierda o para la derecha, pero si miramos para arriba o para abajo la bala aparecerá desplazada lateralmente `PLAYER_BULLET_X_OFFSET` píxels desde la izquierda si miramos hacia abajo o desde la derecha si miramos hacia arriba. **Esto significa que nuestro personaje es diestro** a menos que seamos más listos que la quina *y juguemos con valores negativos*. Fijáos en los sprites de **Mega Meghan**.

```c
    //#define ENEMIES_LIFE_GAUGE        4       // Amount of shots needed to kill enemies.
    //#define RESPAWN_ON_ENTER                  // Enemies respawn when entering screen
    //#define FIRE_MIN_KILLABLE         3       // If defined, only enemies >= N can be killed.
    //#define CAN_FIRE_UP                       // If defined, player can fire upwards and diagonal.
```

Estas de aquí sirven para controlar cosas misceláneas balísticas

1. `ENEMIES_LIFE_GAUGE` define el número de tiros que deberán llevarse para morirse. 

2. Si activamos `RESPAWN_ON_ENTER`, los enemigos habrán resucitado si salimos de la pantalla y volvemos a entrar. Como en los güegos clásicos, illo.

3. `FIRE_MIN_KILLABLE` sirve para que algunos enemigos no se puedan matal. Sólo morirán los que tengan un tipo mayor o igual al valor de esta directiva.

4. `CAN_FIRE_UP` deja que el jugador dispare en diagonales y para arriba en juegos de vista lateral, como en **Goku Mal**.

Por cierto, los enemigos matados se van contando y dicho valor puede controlarse desde el script.

Las balas, además, pueden tener un alcance limitado, lo que da mucho juego para hacer *cosas que no son balas con balas*. Este comportamiento se puede configurar con las siguientes directivas:

```c
    //#define LIMITED_BULLETS                   // If defined, bullets die after N frames
    //#define LB_FRAMES                 4       // If defined, defines the # of frames bullets live (fixed)
    //#define LB_FRAMES_FLAG            2       // If defined, defines which flag determines the # of frames
```

Si activamos `LIMITED_BULLETS`, las balas durarán solo cierto número de frames. Este número de frames será el valor del flag `LB_FRAMES_FLAG` si se activa esta directiva, o el valor de `LB_FRAMES` directamente si queremos que sea fijo.

## Scripting

Las siguientes directivas sirven para activar el motor de scripting y definir un par de cosas relacionadas con el mismo. Por ahora las vamos a dejar sin activar, para poder ir compilando y probando el güego ya sin tener que hacer un script. Porque tenemos ganas ya, ¿no? Tranquilos, volveremos a ellas más adelante.

Con la primera activamos el sistema de scripting:

```c
    //#define ACTIVATE_SCRIPTING              // Activates msc scripting and flag related stuff.
```

Con las siguientes lo configuramos:

```c
#define SCRIPTING_DOWN                      // Use DOWN as the action key.
//#define SCRIPTING_KEY_M                   // Use M as the action key instead.
//#define SCRIPTING_KEY_FIRE                // User FIRE as the action key instead.

#define ENABLE_EXTERN_CODE                  // Enables custom code to be run from the script using EXTERN n
//#define ENABLE_FIRE_ZONE                  // Allows to define a zone which auto-triggers "FIRE"
```

1. Las tres primeras directivas sirven para elegir qué tecla de acción activará el scripting. Habrá que activar una de ellas y desactivar las otras dos. Podemos elegir entre que la tecla de acción sea "abajo", **M** o el botón de disparo (usando la configuración de controles que sea).

2. `ENABLE_EXTERN_CODE` permite que escribamos código C para responder al comando `EXTERN` del script. `EXTERN` tomará un parámetro y el intérprete lo pasará tal cual a una función especial `do_extern_action` que está en `/dev/my` y donde podremos añadir nuestro código. Ya lo trataremos en más detalle cuando hablemos del scripting.

3. `ENABLE_FIRE_ZONE` permite utilizar el comando `SET_FIRE_ZONE` del script, que activa un rectángulo en pantalla que lanzará las cláusulas de las secciones `PRESS_FIRE` de la pantalla actual cuando el personaje la toque. De nuevo, ya lo trataremos más adelante.

Como te he dicho, por ahora dejamos `ACTIVATE_SCRIPTING` desactivada. Ya la activaremos cuando empecemos a hacer nuestro script.

## Timer

Se trata de un temporizador que podemos usar de forma automática o desde el script. El temporizador toma un valor inicial, va contando hacia abajo, puede recargarse, se puede configurar cada cuántos frames se decrementa o decidir qué hacer cuando se agota. 

Con esta directiva activamos el sistema de timer. En **Dogmole** no lo usaremos.

```c
    //#define TIMER_ENABLE
```

Con las siguientes lo configuramos. Son unas cuantas. Veámoslas:

```c
    #define TIMER_INITIAL       99  
    #define TIMER_REFILL        25
    #define TIMER_LAPSE         32
    #define TIMER_START
```

1. `TIMER_INITIAL` especifica el valor inicial del temporizador. 

2. Las recargas de tiempo, que se ponen con el Ponedor como *hotspots* de **tipo 5**, recargarán el
valor especificado en `TIMER_REFILL`.  El valor máximo del timer, tanto para el inicial como al recargar, es de 99. 

3. `TIMER_LAPSE` cntrola intervalo de tiempo que transcurre entre cada decremento del temporizador, y está medido en frames. Los juegos de **MTE MK1** suelen ejecutarse a una media de 20 fps, para que te hagas una idea.

4. Si se define TIMER_START, el temporizador estará activo desde el principio del juego

Tenemos, además, algunas directivas que definen qué pasará cuando el temporizador llegue a cero. Hay que activar solo una de ellas, dejando las demás comentadas.:

```c
    #define TIMER_SCRIPT_0  
    //#define TIMER_GAMEOVER_0
    //#define TIMER_KILL_0
```

1. `TIMER_SCRIPT_0`: Cuando llegue a cero el temporizador se ejecutará una sección especial del script, `ON_TIMER_OFF`. Es ideal para llevar todo el control del temporizador por scripting, como ocurre en **Cadàveriön**.

2. `TIMER_GAME_OVER_0`: El juego terminará cuando el temporizador llegue a cero (Game Over).

3. `TIMER_KILL_0`: Se restará una vida cuando el temporizador llegue a cero. Si se define esta última, además, se hace caso de las tres siguientes:

```c
    //#define TIMER_WARP_TO 0
    //#define TIMER_WARP_TO_X   1
    //#define TIMER_WARP_TO_Y   1
```

1. Si se define `TIMER_WARP_TO_0` además de `TIMER_KILL_0`, al morir cambiaremos a la pantalla indicada.

2. Si se define `TIMER_WARP_TO_X` y `TIMER_WARP_TO_Y` además de `TIMER_KILL_0`, al moriri nos moveremos a esta posición.

Pueden combinarse las tres para cambiar a una pantalla y a una posición concreta dentro de la misma.

Esperad, no os vayáis, que hay más:

```c
    //#define TIMER_AUTO_RESET
    #define SHOW_TIMER_OVER 
```

1. `TIMER_AUTO_RESET`: Si se define esta opción, el temporizador volverá al máximo tras llegar a cero de forma automática. Si vas a realizar el control por scripting, mejor deja esta comentada.

2. `SHOW_TIMER_OVER`: Si se define esta, en el caso de que hayamos definido o bien TIMER_SCRIPT_0 o bien TIMER_KILL_0, se mostrará un cartel de "TIME'S UP!" cuando el temporizador llegue a cero.

Como hemos dicho, el temporizador puede administrarse desde el script. Es interesante que, si decidimos hacer esto, activemos `TIMER_SCRIPT_0` para que cuando el temporizador llegue a cero se ejecute la sección `ON_TIMER_OFF` de nuestro script y que el control sea total. 

## Guardar estado

Se trata de definir *check points* en el juego. Se colocan como **hotspots de tipo 6**. Cuando el jugador los toca, se almacena su estado actual:

- Valor de todos los flags. (si aplica)
- Posición. (n_pant, tile X, tile Y)
- Tiempo. (si aplica)
- Munición. (si aplica)

Cuando esto ocurre, cuando se va a iniciar una nueva partida se da la opción entre empezar de nuevo o continuar desde el último *check point*.

Nótese que no es posible almacenar llaves y objetos, ya que esto implicaría hacer copias en memoria de estructuras grandes. Esta funcionalidad está más pensada para juegos en los que la lógica venga regida por un script.

También se puede configurar el motor para que la vuelta al check point se de siempre que perdamos una vida.

```c
//#define ENABLE_CHECKPOINTS                // Enable checkpoints
//#define CP_RESET_WHEN_DYING               // Move player to checkpoint when player dies.
//#define CP_RESET_ALSO_FLAGS               // and also restore its flags / values
```

El comportamiento por defecto es que no pase nada al morir, y cuando acabe la partida podremos continuar desde el último *check point*.

1. Si se activa `CP_RESET_WHEN_DYING`, además, cada vez que se pierda una vida se trasladará al jugador al último *check point*.

2. Si se activa `CP_RESET_ALSO_VALUES`, además de lo anterior, se restaurará el valor de los flags.

No usaremos nada de esto en **Dogmole**, por lo que todo se queda comentado.

## Directivas relacionadas con la vista genital

```c
    //#define PLAYER_MOGGY_STYLE                // Enable top view.
    //#define TOP_OVER_SIDE                     // UP/DOWN has priority over LEFT/RIGHT
```

Si activamos `PLAYER_MOGGY_STYLE`, el güego será de vista genital. Si no está activada, el güego será de vista lateral. Para **Dogmole** la dejamos desactivada, por tanto.

La siguiente, `TOP_OVER_SIDE`, define el comportamiento de las diagonales. Esto tiene utilidad sobre todo si tu güego tiene, además, disparos. Si se define `TOP_OVER_SIDE`, al desplazarse en diagonal el muñeco mirará hacia arriba o hacia abajo y, por tanto, disparará en dicha dirección. Si no se define, el muñeco mirará y disparará hacia la izquierda o hacia la derecha. Depende del tipo de juego o de la configuración del mapa te interesará más una u otra opción. No, no se puede disparar en diagonal.

```c
    //#define PLAYER_BOUNCE_WITH_WALLS          // Bounce when hitting a wall. Only really useful in MOGGY_STYLE mode
```

El jugador rebota contra las paredes, como en **Balowwwn**. Si le encuentras alguna utilidad, go!

## Directivas relacionadas con la vista lateral

Aquí hay un montón de cosas:

### Sartar

```c
    #define PLAYER_HAS_JUMP                     // If defined, player is able to jump.
```

Si se define esta, el jugador puede saltar. Si no se han activado los disparos, fire hará que el jugador salte. Si están activados, lo hará la tecla “arriba”. También podemos usar la configuración de dos botones (que veremos más adelante), que asignará un botón a saltar y otro a disparar.

### Jetpac

```c
    //#define PLAYER_HAS_JETPAC                 // If defined, player can thrust a vertical jetpac
```

Si definimos `PLAYER_HAS_JETPAC`, la tecla “arriba” hará que activemos un jetpac. Es compatible con poder saltar. Sin embargo, si activas a la vez el salto y el jetpac no podrás usar los disparos… aunque no lo hemos probado, a lo mejor pasa algo raro. No lo hagas. O, no sé, hazlo. Si no sabes qué es esto, juega a **Cheril the Goddess** o **Jet Paco**.

### Pisar enemigos

```c
    #define PLAYER_STEPS_ON_ENEMIES             // If defined, stepping on enemies kills them
    //#define PLAYER_CAN_STEP_ON_FLAG   1       // If defined, player can only kill when flag # is "1"
    #define PLAYER_MIN_KILLABLE         3       // Only kill enemies with id >= PLAYER_MIN_KILLABLE
```

`PLAYER_STEPS_ON_ENEMIES` activa el motor de pisoteo y las otras dos, que lo configuran, son opcionales. Con este motor activado, el jugador podrá saltar sobre los enemigos para matarlos. 

1. `PLAYER_CAN_STEP_ON_FLAG`: Si se activa, el valor del flag indicado deberá valer 1 para que el pisoteo funcione. Como ganar un super poder.

2. `PLAYER_MIN_KILLABLE` nos sirve para hacer que no todos los enemigos se puedan matar. En Dogmole, sólo podremos matar a los hechiceros, que son de tipo 3. Ojo con esto: si ponemos un 1 podremos matar a todos, si ponemos un 2, a los enemigos tipo 2 y 3, y si ponemos un 3 sólo a los de tipo 3. O sea, se podrá matar a los enemigos cuyo tipo sea mayor o igual al valor que se configure.

### Motor de Bootèe

```c
    //#define PLAYER_BOOTEE                     // Always jumping engine. Don't forget to disable "HAS_JUMP" and "HAS_JETPAC"!!!
```

Esta directiva activa el salto continuo (el del juego **Botèe**). No es compatible con `PLAYER_HAS_JUMP` o con `PLAYER_HAS_JETPAC`. Si activas `PLAYER_BOOTEE`, tienes que desactivar los otros dos. Si no, cacota.

## Definición del teclado

**MTE MK1** soporta dos configuraciones de controles, una basada en un sólo botón, que además se puede emplear cómodamente con joysticks tipo Sinclair o Kempston, y otra basada en dos botones, más pensada para usar el teclado como si fuera un pad de Master System y NES: con una "cruceta" virtual y dos botones.

```c
    //#define USE_TWO_BUTTONS
```

Por defecto la configuración será la de un solo botón. Para ello dejamos `USE_TWO_BUTTONS` desactivada.

Las teclas que se usarán en el juego pueden definirse fácilmente para cualquiera de las dos configuraciones dando valores a la estructura "keys" y a dos variables que se definen justo después:

```c
    #ifdef USE_TWO_BUTTONS
        // Define here if you selected the TWO BUTTONS configuration

        struct sp_UDK keys = {
            0x047f, // .fire
            0x04fd, // .right
            0x01fd, // .left
            0x02fd, // .down
            0x02f7  // .up
        };
        
        int key_jump = 0x087f;
        int key_fire = 0x047f;
    #else
        // Define here if you selected the NORMAL configuration

        struct sp_UDK keys = {
            0x017f, // .fire
            0x01df, // .right
            0x02df, // .left
            0x01fd, // .down
            0x01fb  // .up
        };
    #endif
```

De "fábrica", las teclas son **W A S D** para la "cruceta" y **N M** para los "botones" en el modo de dos botones, y **O P Q A** y **SPACE** en el modo normal. 

Si quieres otras teclas en la configuración que vayas a usar, el tema se trata de cambiar esos numeritos, lo cual no es nada complicado porque hemos incluido esta tabla justo arriba para que la tengas enfrente a la hora de cambiarlos. La tabla es algo así:

|B\A|`01`|`02`|`04`|`08`|`10`
|---|---|---|---|---|---
|`f7`|1|2|3|4|5
|`fb`|Q|W|E|R|T
|`fd`|A|S|D|F|G
|`fe`|CS|Z|X|C|V

|B\A|`01`|`02`|`04`|`08`|`10`
|---|---|---|---|---|---
|`ef`|0|9|8|7|6
|`df`|P|O|I|U|Y
|`bf`|EN|L|K|J|H
|`7f`|SP|SS|M|N|B

Pensemos en los números como en `0xAABB`. Lo que tenemos que hacer es buscar la tecla que queremos en la tabla (que si te fijas es como las dos partes del teclado de un Spectrum original), y mirar el número `AA` de la columna y el número `BB` de la fila correspondientes, y con ellos formar el `0xAABB` que necesitamos. Por ejemplo, la tecla "8" está en la columna `04` y la fila `ef`, por lo que el número que la representaría sería `0x04ef`.

Para la configuración de un botón hay que sustituir la estructura de abajo, en orden *disparo*, *derecha*, *izquierda*, *abajo*, *arriba* (como queda indicado en los comentarios). Para la configuración de los dos botones habrá que sustituir la estructura de arriba, en el mismo orden, y adicionalmente rellenar el valor de las teclas *salto* y *disparo*.

## Configuración de la pantalla

En esta sección colocamos todos los elementos en la pantalla. ¿Recordáis cuando estábamos diseñando el marco? Pues es aquí donde vamos a poner todos los valores que dejamos apuntados. Estas directivas son de las que se pueden invalidar con el valor 99. Normalmente el motor no tratará de mostrar marcadores que no va a usar, como por ejemplo el de munición si el juego no activa `MAX_AMMO`. Sin embargo, hay ocasiones en la que necesitamos tener activado uno de los motores pero que no se muestre el marcador correspondiente. Para lograrlo, ponemos sus coordenadas a 99 y los desactivaremos.

```c
    #define VIEWPORT_X                  1       //
    #define VIEWPORT_Y                  0       // Viewport character coordinates
```

Definen la posición (siempre en coordenadas de carácter) del área de juego. Nuestro área de juego empezará en (0, 1), y esos son los valores que le damos a `VIEWPORT_X` y `VIEWPORT_Y`.

```c
    #define LIFE_X                      22      //
    #define LIFE_Y                      21      // Life gauge counter character coordinates
```

Definen la posición del marcador de las vidas (del numerico, vaya).

```c
    #define OBJECTS_X                   17      //
    #define OBJECTS_Y                   21      // Objects counter character coordinates
```

Definen la posición del contador de objetos, si usamos objetos (la posición del numerico). Recordad que en **Dogmole**, por configuración, en estas coordenadas se mostrará el valor del flag que usaremos para llevar el recuento de los objetos, y no el contador interno de objetos.

```c
    #define OBJECTS_ICON_X              15      // 
    #define OBJECTS_ICON_Y              21      // Objects icon character coordinates (use with ONLY_ONE_OBJECT)
```

Estas dos se utilizan con `ONLY_ONE_OBJECT`: Cuando “llevemos” el objeto encima, el motor nos lo indicará haciendo parpadear el icono del objeto en el marcador. En `OBJECTS_ICON_X` e `Y` indicamos dónde aparece dicho icono (el tile con el dibujito de la caja). Como verás, esto obliga a que estemos usando el icono en el marcador, y no un texto u otra cosa. Sí, es una limitación.

```c
    #define KEYS_X                      27      //
    #define KEYS_Y                      21      // Keys counter character coordinates
```

Define la posición del contador de llaves.

```c
    #define KILLED_X                    12      //
    #define KILLED_Y                    21      // Kills counter character coordinates
```

La cuenta de enemigos matados o moridos.

```c
    #define AMMO_X                      99      // 
    #define AMMO_Y                      99      // Ammo counter character coordinates
    #define TIMER_X                     99      //
    #define TIMER_Y                     99      // Timer counter coordinates
```

Estas últimas son para colocar un marcador de munición y mostrar el valor del timer, pero como no las vamos a usar, las dejamos a `99`.

## La linea de texto

**MTE_MK1** permite imprimir una sencilla linea de texto desde el script. Para activar esta funcionalidad, define `LINE_OF_TEXT` con la coordenada `Y` de la linea de texto. Adicionalmente, `LINE_OF_TEXT_X` sirve para definir su coordenada `X` (0 o 1, normalmente) y `LINE_OF_TEXT_ATTR` el color del texto, en atributos de Spectrum (recuerda, el número que salga de aplicar la fórmula `INK + 8*PAPER + 64*BRIGHT + 128*FLASH`).

## Efectos gráficos

En esta sección se definen diversos efectos gráficos (muy básicos) que podemos activar y que controlarán la forma en la que se muestra el güego. Básicamente podemos configurar **MTE MK1** para que pinte sombras o no a la hora de construir el escenario, y definir un par de cosas relacionadas con los sprites y tal.

```c
    //#define USE_AUTO_SHADOWS                  // Automatic shadows made of darker attributes
    //#define USE_AUTO_TILE_SHADOWS             // Automatic shadows using specially defined tiles 32-47.
```

Estas dos se encargan de las sombras de los tiles, y podemos activar sólo una de ellas, o ninguna. Si recuerdas, en el capítulo del tileset hablamos de sombras automáticas. Si activamos `USE_AUTO_SHADOWS`, los tiles obstáculo dibujan sombras sobre los tiles traspasables usando sólo atributos (a veces queda resultón, pero no siempre).

`USE_AUTO_TILE_SHADOWS` emplea versiones sombreadas de los tiles de fondo para hacer las sombras, tal y como explicamos. Desactivando ambas no se dibujarán sombras.

En **Dogmole** no usaremos sombras de ningún tipo, porque las de atributos no nos gustan y las de tiles no nos las podemos permitir porque usaremos esos tiles para embellecer algunas pantallas imprimiendo gráficos por medio del script.

```c
    //#define UNPACKED_MAP                      // Full, uncompressed maps. Shadows settings are ignored.
```

Si definimos `UNPACKED_MAP` estaremos diciéndole al motor que nuestro mapa es de 48 tiles.

```c
    //#define NO_MASKS                          // Sprites are rendered using OR instead of masks.
    //#define MASKED_BULLETS                    // If needed
```

### Cosas de máscaras

`NO_MASKS`  hace que los sprites del jugador y los enemigos se dibujen sin máscaras, con un sencillo OR. Esto funciona bien si tus fondos son planos o muy poco complejos porque el render es más rápido y ganamos algunos ciclos, lo que significa más faps de esos.

`MASKED_BULLETS` hace que los sprites de las balas usen máscaras para más bonitor general si usas fondos complejos.

### Tiles animados

**MTE MK1** te da la opción de usar tiles animados de una forma muy sencilluna. Básicamente un tile animado es una pareja de tiles correlativos en el tileset. Tú colocas (mediante mapa o mediante scripting) el primero de ellos en pantalla y el motor lo animará alternándo entre éste y su pareja cada cierto tiempo un poco al azar (básicamente elige uno de entre todos los que hay cada frame y lo cambia). En **MTE MK1** los tiles animados tienen que estar al final del tileset todos seguidos, con lo que realmente sólo tienen utilidad si tu mapa es `UNPACKED` (de 48 tiles) o si vas a poner decoraciones con el script.

```c
    //#define ENABLE_TILANIMS           32      // If defined, animated tiles are enabled.
                                                // the value especifies first animated tile pair.
```

El valor configurado es el del primer par de tiles animados, si `ENABLE_TILANIMS` está activo. Por ejemplo, si pones `44`, tus tiles animados serán la pareja `44, 45` y la pareja `46, 47`. Siempre que pongas un tile `44` o `45` (en tu mapa unpacked, o desde el script si tu tileset para el mapa es de 16 tiles), se animará.

## Pausa y abortar

```c
    //#define PAUSE_ABORT                       // Add h=PAUSE, y=ABORT
```

Si se define, la techa *H* pausará el huego y la tecla *Y* volverá a la pantalla de título.

## Get X More

```c
    //#define GET_X_MORE                        // Shows "get X more" when getting an object
```

Si se define, se mostrará un cuadro con los objetos que te quedan por coger cada vez que cojas uno.

## Configuración del movimiento del personaje principal

En esta sección configuraremos como se moverá nuestro jugador. Es muy probable que los valores que pongas aquí tengas que irlos ajustando por medio del método de prueba y error. Si tienes unas nociones básicas de física, te vendrán muy bien para saber cómo afecta cada parámetro.

Básicamente, tendremos lo que se conoce como *Movimiento Rectilíneo Uniformemente Acelerado* (MRUA) en cada eje: el horizontal y el vertical. Básicamente tendremos una posición (digamos X) que se verá afectada por una velocidad (digamos VX), que a su vez se verá afectada por una aceleración (o sea, AX).

Los parámetros siguientes sirven para especificar diversos valores relacionados con el movimiento en cada eje en güegos de vista lateral. En los de vista genital, se tomarán los valores del eje horizontal también para el vertical.

Para obtener la suavidad de los movimientos sin usar valores en coma flotante (que son muy costosos de manejar), usamos aritmética de punto fijo. Básicamente los valores se expresan en 1/64 de pixel. Esto significa que el valor empleado se divide entre 64 a la hora de mover los sprites reales a la pantalla. Eso nos da una precisión de 1/64 pixels en ambos ejes, lo que se traduce en mayor suavidad de movimientos. En palabras techis, estamos usando 10 bits para la parte entera y 6 para la parte "decimal", así que decimos que nuestro punto fijo es **10.6**.

Somos conscientes en mojonia de que este apartado es especialmente densote, así que no te preocupes demasiado si, de entrada, te pierdes un poco. Experimenta con los valores hasta que encuentres la combinación ideal para tu güego.

### Eje vertical en güegos de vista lateral

Al movimiento vertical le afecta la gravedad. La velocidad vertical será incrementada por la gravedad hasta que el personaje aterrice sobre una plataforma u obstáculo. Además, a la hora de saltar, habrá un impulso inicial y una aceleración del salto, que también definiremos aquí. Estos son los valores para Dogmole; acto seguido detallaremos cada uno de ellos:

```c
    #define PLAYER_MAX_VY_CAYENDO       512     // Max falling speed
    #define PLAYER_G                    48      // Gravity acceleration

    #define PLAYER_VY_INICIAL_SALTO     96      // Initial junp velocity
    #define PLAYER_MAX_VY_SALTANDO      312     // Max jump velocity
    #define PLAYER_INCR_SALTO           48      // acceleration while JUMP is pressed

    #define PLAYER_INCR_JETPAC          32      // Vertical jetpac gauge
    #define PLAYER_MAX_VY_JETPAC        256     // Max vertical jetpac speed
```

#### Caída libre

La velocidad del jugador, que medimos en pixels/frame será incrementada en `PLAYER_G` / 64 pixels/frame hasta que llegue al máximo especificado por `PLAYER_MAX_CAYENDO` / 64. Con los valores que hemos elegido para **Dogmole**, la velocidad vertical en caída libre será incrementada en 48 / 64 = 0,75 pixels/frame hasta que llegue a un valor de 512 / 64 = 8 píxels/frame. O sea, Dogmole caerá más y más rápido hasta que llegue a la velocidad máxima de 8 píxels por frame. 

Incrementar `PLAYER_G` hará que se alcance la velocidad máxima mucho antes (porque la aceleración es mayor). Estos valores afectan al salto: a mayor gravedad, menos saltaremos y menos nos durará el impulso inicial. Modificando `PLAYER_MAX_CAYENDO` podremos conseguir que la velocidad máxima, que se alcanzará antes o después dependiendo del valor de `PLAYER_G`, sea mayor o menor. Usando valores pequeños podemos simular entornos de poca gravedad como el espacio exterior, la superficie de la luna, o el fondo del mar. El valor de 512 (equivalente a 8 píxels por frame) podemos considerarlo el máximo, ya que valores superiores y caídas muy largas podrían resultar en glitches y cosas raras.

#### Salto

Los saltos se controlan usando tres parámetros. El primero, `PLAYER_VY_INICIAL_SALTO`, será el valor del impulso inicial: cuando el jugador pulse la tecla de salto, la velocidad vertical tomará automáticamente el valor especificado en dirección hacia arriba. Mientras se esté pulsando salto, y durante unos ocho frames, la velocidad se seguirá incrementando en el valor especificado por `PLAYER_INCR_SALTO` hasta que lleguemos al valor `PLAYER_MAX_VY_SALTANDO`. Esto se hace para que podamos controlar la fuerza del salto pulsando la tecla de salto más o menos tiempo. El período de aceleración, que dura 8 frames, es fijo y no se puede cambiar (para cambiarlo habría que tocar el motor), pero podemos conseguir saltos más bruscos subiendo el valor de `PLAYER_INCR_SALTO` y `PLAYER_MAX_VY_SALTANDO`.

Normalmente encontrar los valores ideales exige un poco de prueba y error. Hay que tener en cuenta que al saltar horizontalmente de una plataforma a otra también entran en juego los valores del movimiento horizontal, por lo que si has decidido que en tu güego el prota debería poder sortear distancias de X tiles tendrás que encontrar la combinación óptima jugando con todos los parámetros.

Los dos valores que quedan no se usan en **Dogmole** porque tienen que ver con el jetpac. El primero es la aceleración que se produce mientras pulsamos la tecla arriba y el segundo el valor máximo que puede alcanzarse. Si tu juego no usa jetpac estos valores no se utilizan para nada.

### Eje horizontal en güegos de vista lateral / comportamiento general en vista genital

El siguiente set de parámetros describen el comportamiento del movimiento en el eje horizontal si tu güego es en vista lateral, o los de ambos ejes si tu güego es en vista genital. Estos parámetros son mucho más sencillos:

```c
    #define PLAYER_MAX_VX               256     // Max velocity
    #define PLAYER_AX                   48      // Acceleration
    #define PLAYER_RX                   64      // Friction
```

1. `PLAYER_MAX_VX` indica la velocidad máxima a la que el personaje se desplazará horizontalmente (o en cualquier dirección si el güego es en vista genital). Cuanto mayor sea este número, más correrá, y más lejos llegará cuando salte (horizontalmente). Un valor de 256 significa que el personaje correrá a un máximo de 256/64 = 4 píxels por frame.

2. `PLAYER_AX` controla la aceleración que sufre el personaje mientras el jugador pulsa una tecla de dirección. Cuando mayor sea el valor, antes se alcanzará la velocidad máxima. Valores pequeños hacen que “cueste arrancar”. Un valor de 48 significa que se tardará aproximadamente 6 frames (256/48) en alcanzar la velocidad máxima.

3. `PLAYER_RX` es el valor de fricción o rozamiento. Cuando el jugador deja de pulsar la tecla de movimiento, se aplica esta aceleración en dirección contraria al movimiento. Cuanto mayor sea el valor, antes se detendrá el personaje. Un valor de 64 significa que tardará 4 frames en detenerse si iba al máximo de velocidad.

Usar valores pequeños de `PLAYER_AX` y `PLAYER_RX` harán que el personaje parezca resbalar. Es lo que ocurre en güegos como, por ejemplo, **Viaje al Centro de la Napia**. Salvo excepciones misteriosas, casi siempre “se güega mejor” si el valor de `PLAYER_AX` es mayor que el de `PLAYER_RX`.

## Comportamiento de los tiles

¿Recordáis que explicamos como cada tile tiene un tipo de comportamiento asociado? Tiles que matan, que son obstáculos, plataformas, o interactuables. En esta sección (la última, por fin) de `my/config.h` definimos el comportamiento de cada uno de los 48 tiles del tileset completo **aunque estemos usando mapas *packed* de 16 tiles**.

Tendremos que definir los comportamientos de los 48 tiles sin importar que nuestro güego utilice un tileset de 16 porque los tiles extra que no van en el mapa podrían llegar a aparecer por obra del script o de inyección de código. En Dogmole no vamos a poner ningún obstáculo “fuera de tileset”, pero güegos como los de la saga de **Ramiro el Vampiro** sí que tienen obstáculos de este tipo.

Para poner los valores, simplemente abrimos el tileset y nos fijamos, están en el mismo orden en el que aparecen los tiles en el tileset:

![Tileset de Dogmole](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/02_tileset_16.png)

```c
    unsigned char behs [] = {
        0, 8, 8, 8, 8, 8, 0, 8, 4, 0, 8, 1, 0, 0, 0,10,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    };
```

Como vemos, tenemos el primer tile vacío (tipo 0), luego tenemos cinco tiles de roca que son obstáculos (tipo 8), otro tile de fondo (la columnita, tipo 0), el tile de ladrillos (tipo 8), los dos tiles que forman un arco (tipo 4, plataforma, y tipo 0, traspasable), las tejas (tipo 8), unos pinchos que matan (tipo 1), tres tiles de fondo (tipo 0), y el tile cerrojo (tipo 10, interactuable).

Cuando modifiques estos valores ten cuidado con las comas y que no se te baile ningún número.

## ¡Arf, arf, arf!

Ah, ¿aún estás ahí? Pensaba que ya había conseguido aburrirte y quitarte todas las ganas de seguir con esto. Bien, veo que eres un tipo constante y con mucho podewwwr. Sí, ya hemos terminado de configurar nuestro güego. Ahora viene cuando lo compilamos. 

A estas alturas del cuento ya tendríamos que tener todo en su sitio y listo (salvo el script) para ser compilado. Incluso `compile.bat` debería tener ya el par de modificaciones necesarias (el nombre del juego y el tamaño del mapa en el conversor).

## Echando un vistazo a `compile.bat`

Como no nos gustan las cajas negras vamos a echar un vistazo a `compile.bat` para que todos le veamos bien el totete.

```
    @echo off

    set game=dogmole

    echo Compilando script
    cd ..\script
    msc %game.spt msc.h 25 > nul
    copy *.h ..\dev > nul
    cd ..\dev

    echo Convirtiendo mapa
    ..\utils\mapcnv.exe ..\map\mapa.map 6 5 15 10 15 packed > nul
    cd ..\dev

    echo Convirtiendo enemigos/hotspots
    ..\utils\ene2h.exe ..\enems\enems.ene enems.h

    echo Importando GFX
    ..\utils\ts2bin.exe ..\gfx\font.png ..\gfx\work.png tileset.bin forcezero >nul

    ..\utils\sprcnv.exe ..\gfx\sprites.png sprites.h > nul

    ..\utils\sprcnvbin.exe ..\gfx\sprites_extra.png sprites_extra.bin 1 > nul
    ..\utils\sprcnvbin8.exe ..\gfx\sprites_bullet.png sprites_bullet.bin 1 > nul

    ..\utils\png2scr.exe ..\gfx\title.png ..\gfx\title.scr > nul
    ..\utils\png2scr.exe ..\gfx\marco.png ..\gfx\marco.scr > nul
    ..\utils\png2scr.exe ..\gfx\ending.png ..\gfx\ending.scr > nul
    ..\utils\png2scr.exe ..\gfx\loading.png loading.bin > nul
    ..\utils\apack.exe ..\gfx\title.scr title.bin > nul
    ..\utils\apack.exe ..\gfx\marco.scr marco.bin > nul
    ..\utils\apack.exe ..\gfx\ending.scr ending.bin > nul

    echo Compilando guego
    zcc +zx -vn mk1.c -o %game%.bin -lsplib2_mk2.lib -zorg=24000 > nul
    ..\utils\printsize.exe %game%.bin

    echo Construyendo cinta
    rem cambia LOADER por el nombre que quieres que salga en Program:
    ..\utils\bas2tap -a10 -sLOADER loader\loader.bas loader.tap > nul
    ..\utils\bin2tap -o screen.tap -a 16384 loading.bin > nul
    ..\utils\bin2tap -o main.tap -a 24000 %game%.bin > nul
    copy /b loader.tap + screen.tap + main.tap %game%.tap > nul

    echo Limpiando
    del loader.tap > nul
    del screen.tap > nul
    del main.tap > nul
    del ..\gfx\*.scr > nul
    del *.bin > nul

    echo Hecho!
```

En él vemos que se realiza toda una serie de fullerías dedicadas a convertir automáticamente todos los archivos implicados en la construcción de nuestro juego: script, mapa, enemigos y gráficos. Acto seguido **compila el juego** y posteriormente **construye la cinta**.

## Preparando el entorno

El script `compile.bat` necesita saber donde está **z88dk**. Nosotros sabemos que está en `C:\z88dk10` porque lo descomprimimos ahí en el paso 1, pero cada vez que abramos una ventana de linea de comandos nueva habrá que recordarle al entorno donde está. Para eso ejecutamos `setenv.bat` que debería mostrar la versión de `zcc` si todo fue bien, algo así:

```
    $ setenv.bat
    zcc - Frontend for the z88dk Cross-C Compiler
    v2.59 (C) 16.4.2010 D.J.Morris
```

Una vez hecho esto no tenemos más que ejecutar `compila.bat` y, tras un mágico proceso que podremos ver suceder ante nuestros atónitos óculos, obtendremos un archivo `tap` que se llame igual que nuestro juego (el valor de `game` en `compile.bat`). En nuestro caso `dogmole.tap`. Nos vamos rápido y lo cargamos en el emu para ver que todo se mueve y está en su sitio.

Y como ya nos duele la cabeza a tí y a mí, pues lo dejamos hasta el capítulo que viene. Si decidiste empezar con algo sencillo tipo **Lala Prologue** o **Sir Ababol**, ya has terminado. Si no, aún hay muchas cosas por hacer.
