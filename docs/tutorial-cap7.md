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

Para que entiendas la diferencia, fíjate cómo interactúa Lala con el escenario en Lala Prologue (que tiene una caja de colisión de 16×16 que ocupa todo el sprite) y en Lala Lah (en la que usamos una caja de colisión de 8×8, más pequeña que el sprite). La colisión de 8×8 ha sido uno de los añadidos para esta versión especial 3.99b de **MTE MK1**, y, en nuestra opinión, hace que el control sea más natural. De todas formas, hemos dejado que el desarrollador (o sea, tú), elija si prefiere la colisión antigua de 16×16, que puede ser más adecuada para depende de qué situaciones.

Si elegimos una colisión de 8×8 con el escenario, tenemos dos opciones: que el recuadro esté centrado en el sprite o que esté en la parte baja:



La primera opción (recuadro centrado) está pensada para güegos con vista genital, como Balowwwn o D'Veel'Ng. La segunda funciona bien con güegos de vista lateral o güegos con vista genital “con un poco de perspectiva”, como Mega Meghan.

Solo una de las dos directivas puede estar activa (porque son excluyentes): si queremos colisión 8×8 centrada activamos BOUNDING_BOX_8_CENTERED y desactivamos la otra. Si queremos colisión 8×8 en la parte baja activamos BOUNDING_BOX_8_BOTTOM y desactivamos la otra. Si queremos colisión de 16×16 desactivamos ambas.

La tercera directiva se refiere a las colisiones contra los enemigos. Si activamos SMALL_COLLISION, los sprites tendrán que tocarnos mucho más para darnos. Con SMALL_COLLISION los enemigos son más fáciles de esquivar. Funciona bien en güegos con movimientos rápidos, como Bootee. Nosotros la vamos a dejar desactivada para Dogmole.

Directivas generales

#define PLAYER_AUTO_CHANGE_SCREEN // Player changes screen automaticly

Si definimos esto, el jugador cambiará de pantalla cuando salga por el borde. Si no se define, habrá que estar pulsando la dirección concreta para que esto ocurra. Normalmente se deja activada, para que si el jugador se mueve sólo por inercia también cambie de pantalla. No se nos ocurre una situación en la que esto no sea deseable, pero de todos modos ahí está la opción de desactivarlo.

//#define PLAYER_PUSH_BOXES // If defined, tile #14 is pushable
//#define FIRE_TO_PUSH

Estas dos directivas activan y configuran los bloques empujables. Nosotros no vamos a usar bloques empujables en Dogmole, por lo que las desactivamos. Activar la primera (PLAYER_PUSH_BOXES) activa los bloques, de forma que los tiles #14 (con comportamiento tipo 10, recuerda) podrán ser empujados.

La segunda directiva, FIRE_TO_PUSH, es para definir si el jugador debe pulsar fire además de la dirección en la que empuja o no. En Cheril Perils, por ejemplo, no hay que pulsar fire: sólo tocando el bloque mientras avanzamos se desplazará. En D'Veel'Ng, sí que es necesario pulsar fire para empujar un bloque. Si vas a usar bloques empujables, debes decidir la opción que más te gusta (y que mejor se adecue al tipo de gameplay que quieras conseguir).

#define DIRECT_TO_PLAY // If defined, title screen = game frame.

Esta directiva, se activa para conseguir lo que dijimos cuando estábamos haciendo las pantallas fijas: que el título del juego sirva también como marco. Si tienes un title.bin y un marco.bin separados, deberás desactivarla. En nuestro caso, en el que sólo tenemos un title.bin que también incluye marco, la dejamos activada.

//#define DEACTIVATE_KEYS // If defined, keys are not present.
//#define DEACTIVATE_OBJECTS // If defined, objects are not present.

Estas dos directivas sirven para desactivar llaves u objetos. Si tu juego no usa llaves y cerrojos, deberás activar DEACTIVATE_KEYS. Si no vas a usar objetos, activamos DEACTIVATE_OBJECTS.

Seguramente alguno de vosotros estará pensando ¿por qué no activamos DEACTIVATE_OBJECTS en Dogmole, si hemos dicho que los objetos los vamos a controlar por scripting? ¡Buena pregunta! Es sencillo: lo que vamos a controlar por scripting es el conteo de objetos y la condición final, pero necesitamos que el motor gestione la recogida y colocación de los objetos.

Joder, qué lío ¿verdad? Paciencia.

#define ONLY_ONE_OBJECT // If defined, only one object can be carried
#define OBJECT_COUNT 1 // Defines FLAG to be used to store object #

Seguimos con dos directivas con una aplicación muy específica: si activamos la primera, ONLY_ONE_OBJECT, sólo podremos llevar un objeto. Una vez que cojas un objeto, la recogida de objetos se bloquea y no puedes coger más. Para volver a activar la recogida de objetos tendremos que usar scripting. Con esto conseguimos el efecto que necesitamos de que haya que ir llevando las cajas una a una: configuramos el motor para que sólo permita que llevemos un objeto (una caja), y luego, cuando hagamos el script, haremos que cuando llevemos la caja al sitio donde hay que irlas depositando (un sitio concreto de la Universidad) se vuelva a activar la recogida de objetos para que podamos ir a por la siguiente caja.
La segunda directiva, OBJECT_COUNT, sirve para que en el marcador de objetos, en lugar de la cuenta interna de objetos recogidos, se muestre el valor de uno de los flags del sistema de scripting. Ya lo veremos en el futuro, cuando expliquemos el motor de scripting, pero los scripts tienen hasta 32 variables o “flags” que podemos usar para almacenar valores y realizar comprobaciones. Cada variable tiene un número. Si definimos esta directiva, el motor mostrará el valor del flag indicado en el contador de objetos del marcador. Desde el script iremos incrementando dicho valor cada vez que el jugador llegue a la Universidad y deposite un objeto.

En definitiva, sólo necesitaremos definir OBJECT_COUNT si somos nosotros los que vamos a llevar la cuenta, a mano, desde el script. Si no vamos a usar scripting, o no vamos a necesitar controlar a mano el número de objetos recogidos, tendremos que comentar esta directiva para que no sea tomada en cuenta.

//#define DEACTIVATE_EVIL_TILE // If defined, no killing tiles are detected.

Descomenta esta directiva si quieres desactivar los tiles que te matan (tipo 1). Si no usas tiles de tipo 1 en tu juego, descomenta esta linea y ahorrarás espacio, ya que así la detección de tiles matantes no se incluirá en el código.

//#define PLAYER_BOUNCES // If defined, collisions make player bounce
//#define FULL_BOUNCE
//#define SLOW_DRAIN // Works with bounces. Drain is 4 times slower
#define PLAYER_FLICKERS // If defined, collisions make player flicker

Estas dos directivas controlan los rebotes. Si activas PLAYER_BOUNCES, el jugador rebotará contra los enemigos al tocarlos. La fuerza de dicho rebote se controla con FULL_BOUNCE: si se activa, los rebotes serán mucho más bestias porque se empleará la velocidad con la que el jugador avanzaba originalmente, pero en sentido contrario. Desactivando FULL_BOUNCE el rebote es a la mitad de la velocidad.

Si definimos, además, SLOW_DRAIN, la velocidad a la que perderemos energía si nos quedamos atrapados en la trayectoria del enemigo (acuérdense de Lala Prologue, Sir Ababol o la versión original de Viaje al Centro de la Napia) será cuatro veces menor. Esto se usa en Bootee, donde es fácil quedarse atrapado en la trayectoria de un enemigo y complicado salir de la misma. Esto hace el juego más asequible.

Como podrás imaginar, FULL_BOUNCE y SLOW_DRAIN dependen de PLAYER_BOUNCES. Si PLAYER_BOUNCES está desactivada, las otras dos directivas son ignoradas.

Activando PLAYER_FLICKERS logramos que el personaje parpadee si colisiona con un enemigo (siendo invulnerable durante un corto período de tiempo). Normalmente elegiremos entre PLAYER_BOUNCES y PLAYER_FLICKERS, pero pueden funcionar juntas. Nosotros, en Dogmole, queremos que el protagonista únicamente parpadee al colisionar con un enemigo, por lo que desactivamos PLAYER_BOUNCES y activamos PLAYER_FLICKERS.

//#define MAP_BOTTOM_KILLS // If defined, exiting the map bottom kills.
Desactiva esta directiva si quieres que, en el caso de que el personaje vaya a salirse del mapa por abajo, el motor le haga rebotar y le reste vida, como ocurre en Zombie Calavera. Si tu mapa está cerrado por abajo, desactívala para ganar unos bytes.

//#define WALLS_STOP_ENEMIES // If defined… erm…

Esta directiva está relacionada con los tiles empujables. Si defines bloques empujables, puede interesarte que los enemigos reaccionen ante ellos y alteren sus trayectorias, como ocurre, por ejemplo, en Monono o Cheril of the Bosque (entre muchos otros). Si no usas tiles empujables o te da igual que los enemigos los traspasen, desactívala para ganar un montón de espacio.

Tipos de enemigos extra

Vamos a ver ahora un conjunto de directivas que nos servirán para activar los enemigos de tipos 5, 6 o 7. Recordad lo que mencionamos sobre este tipo de enemigos: el 5 son los murciélagos de Zombie Calavera, el 7 son los enemigos que te persiguen de Mega Meghan, y el 6 está reservado para que implementemos un nuevo tipo de enemigos.

En Dogmole no usamos ningún tipo de enemigo extra. Para tus juegos, puedes experimentar con estos bicharracos, o puedes esperarte al final del tutorial cuando expliquemos cómo implementar un tipo de enemigo custom para el tipo 6.

//#define ENABLE_RANDOM_RESPAWN // If defined, flying enemies
//#define FANTY_MAX_V 256 // Flying enemies max speed.
//#define FANTY_A 12 // Flying enemies acceleration.
//#define FANTIES_LIFE_GAUGE 10 // Amount of shots needed to kill.

Activando ENABLE_RANDOM_RESPAWN activamos los enemigos de tipo 5. Estos enemigos aparecen fuera de la pantalla si hay algún enemigo de tipo 5 o algún enemigo muerto, y persiguen al jugador a menos que este esté tocando un tile de tipo 2 (esté escondido). Las siguientes directivas sirven para configurar su comportamiento:

FANTY_MAX_V define la velocidad máxima. Para hacerte una idea, divide el valor entre 64 y el resultado es el número de píxels que avanzará por cada cuadro (frame) de juego como máximo. Si definimos 256, el enemigo volador podrá acelerar hasta los 4 píxels por frame.

FANTY_A es el valor de aceleración. Cada cuadro de juego, la velocidad se incrementará en el valor indicado en dirección hacia el jugador, si no está escondido. Cuanto menor sea este valor, más tardará el enemigo en reaccionar a un cambio de dirección del jugador.

FANTIES_LIFE_GAUGE define cuántos tiros deberá recibir el bicharraco para morirse, si es que hemos activado los tiros (ver más adelante).

//#define ENABLE_PURSUERS // If defined, type 7 enemies are active
//#define DEATH_COUNT_EXPRESSION 8+(rand()&15)

Activando ENABLE_PURSUERS activamos los enemigos de tipo 7. Estos enemigos aparecen donde los hemos colocado (recordemos el capítulo de los enemigos) y persiguen al jugador. Se detienen con los obstáculos del escenario, a diferencia de los enemigos de tipo 5.

Si tenemos activado el motor de disparos, cuando matemos a un enemigo de tipo 7 tardará un tiempo en volver a salir. Dicho tiempo, expresado en número de cuadros (frames), se calcula usando la expresión definida en DEATH_COUNT_EXPRESSION. La que se ve en el ejemplo es la que se emplea en Mega Meghan: 8 más un número al azar entre 0 y 15 (o sea, entre 8 y 23 frames).

Motor de disparos

El motor de disparos es bastante costoso en cuanto a memoria. Activarlo incluye bastantes trozos de código, ya que hay que comprobar más colisiones y tener en cuenta muchas cosas, además de los sprites extra necesarios.

//#define PLAYER_CAN_FIRE // If defined, shooting engine is enabled.
Si activamos esta directiva, estamos incluyendo el motor de disparos. Las siguientes directivas sirven para configurar su comportamiento.

//#define PLAYER_BULLET_SPEED 8 // Pixels/frame.
//#define MAX_BULLETS 3 // Max number of bullets on screen.

La directiva PLAYER_BULLET_SPEED controla la velocidad de las balas. 8 píxels por cuadro es un buen valor y es el que hemos usado en todos los güegos. Un valor mayor puede hacer que se pierdan colisiones, ya que todo lo que ocurre en pantalla es discreto (no continuo) y si un enemigo se mueve rápidamente en dirección contraria a una bala que se mueve demasiado rápido, es posible que de frame a frame se crucen sin colisionar. Si piensas un poco en ello y te imaginas el juego en cámara lenta como una sucesión de frames lo verás.

El valor MAX_BULLETS controla el número máximo de balas que podrá haber en pantalla. Ten cuidado con esto, que ya te estoy viendo las intenciones que subirlo: en teoría podríamos tener más de tres balas, pero para ello habría que modificar la parte del motor que reserva la memoria que necesita el sistema de sprites. Cada sprite en movimiento gasta bastante memoria (14 bytes por bloque, y un sprite de 8×8 usa cuatro bloques), por lo que la reserva es la justa. La verdad es que está todo apretado al máximo y no cabe ni el pelo de una gamba, pero puede que para el final del tutorial explique como modificar el número de bloques que se reservan para los sprites de forma que podamos tener más balas.
¿Para qué dejamos definirlo, entonces? Pues para poder poner menos. Poder disparar sólo una bala puede venir bien para algunos juegos, por ejemplo.

//#define PLAYER_BULLET_Y_OFFSET 6 // vertical offset from the player's top.
//#define PLAYER_BULLET_X_OFFSET 0 // horz offset from the player's left/right.

Estas dos directivas definen dónde aparecen las balas cuando se disparan. El comportamiento de estos valores es relativamente complejo (bueno, no tanto) y cambia según la vista:

Si el güego es en vista lateral, sólo podemos disparar a la izquierda o a la derecha. En ese caso, PLAYER_BULLET_Y_OFFSET define la altura, en píxels, a la que aparecerá la bala contando desde la parte superior del sprite del personaje. Esto sirve para ajustar de forma que salgan de la pistola o de donde queramos (de la pisha o algo). PLAYER_BULLET_X_OFFSET se ignora completamente.

Si el güego es en vista genital, el comportamiento es igual que el descrito si miramos para la izquierda o para la derecha, pero si miramos para arriba o para abajo la bala aparecerá desplazada lateralmente PLAYER_BULLET_X_OFFSET píxels desde la izquierda si miramos hacia abajo o desde la derecha si miramos hacia arriba. Esto significa que nuestro personaje es diestro. Fijáos en los sprites de Mega Meghan. Para hacer jugadores zurdos hay que cambiar dos lineas del motor. Si estás super interesado y de ello depende tu vida, escríbenos y te lo contamos, amigo Flanders.

//#define ENEMIES_LIFE_GAUGE 4 // Amount of shots needed to kill enemies.
//#define RESPAWN_ON_ENTER // Enemies respawn when entering screen

Estas de aquí sirven para controlar qué ocurre cuando las balas golpean a los enemigos normales (de tipo 1, 2 o 3). En primer lugar, ENEMIES_LIFE_GAUGE define el número de tiros que deberán llevarse para morirse. Si activamos RESPAWN_ON_ENTER, los enemigos habrán resucitado si salimos de la pantalla y volvemos a entrar. Como en los güegos clásicos, illo.

Por cierto, los enemigos matados se van contando y dicho valor puede controlarse desde el script.

Scripting

Las siguientes directivas sirven para activar el motor de scripting y definir un par de cosas relacionadas con el mismo. Por ahora las vamos a dejar sin activar, para poder ir compilando y probando el güego ya sin tener que hacer un script. Porque tenemos ganas ya, ¿no? Tranquilos, volveremos a ellas cuando empecemos a ponernos hardcore.

//#define ACTIVATE_SCRIPTING // Activates msc scripting and flags.
#define SCRIPTING_DOWN // Use DOWN as the action key.
//#define SCRIPTING_KEY_M // Use M as the action key instead.

La primera es sencilla: si activamos ACTIVATE_SCRIPTING, todo el sistema de scripting será incluido en el motor. Las otras dos definen cuál será la tecla de acción: abajo o fire. Sólo una de las dos podrá estar activada. Nosotros vamos a usar abajo para realizar las acciones, así que activamos SCRIPTING_DOWN.

Como te he dicho, por ahora dejamos ACTIVATE_SCRIPTING desactivada. Ya la activaremos cuando empecemos a hacer nuestro script.

Directivas relacionadas con la vista genital

//#define PLAYER_MOGGY_STYLE // Enable top view.
//#define TOP_OVER_SIDE // UP/DOWN has priority over LEFT/RIGHT

Si activamos PLAYER_MOGGY_STYLE, el güego será de vista genital. Si no está activada, el güego será de vista lateral. Para Dogmole la dejamos desactivada, por tanto.

La siguiente, TOP_OVER_SIDE, define el comportamiento de las diagonales. Esto tiene utilidad sobre todo si tu güego tiene, además, disparos. Si se define TOP_OVER_SIDE, al desplazarse en diagonal el muñeco mirará hacia arriba o hacia abajo y, por tanto, disparará en dicha dirección. Si no se define, el muñeco mirará y disparará hacia la izquierda o hacia la derecha. Depende del tipo de juego o de la configuración del mapa te interesará más una u otra opción. No, no se puede disparar en diagonal.

Directivas relacionadas con la vista lateral

Aquí hay un montón de cosas:
#define PLAYER_HAS_JUMP // If defined, player is able to jump.

Si se define esta, el jugador puede saltar. Si no se han activado los disparos, fire hará que el jugador salte. Si están activados, lo hará la tecla “arriba”.

//#define PLAYER_HAS_JETPAC // If defined, player can thrust a jetpac

Si definimos PLAYER_HAS_JETPAC, la tecla “arriba” hará que activemos un jetpac. Es compatible con poder saltar. Sin embargo, si activas a la vez el salto y el jetpac no podrás usar los disparos… aunque no lo hemos probado, a lo mejor pasa algo raro. No lo hagas. O, no sé, hazlo. Si no sabes qué es esto, juega a Cheril the Goddess o Jet Paco.

#define PLAYER_KILLS_ENEMIES // If defined, stepping on enemies kills them
#define PLAYER_MIN_KILLABLE 3 // Only kill id >= PLAYER_MIN_KILLABLE

Estas activan el motor de pisoteo. Con PLAYER_KILLS_ENEMIES activado, el jugador podrá saltar sobre los enemigos para matarlos. PLAYER_MIN_KILLABLE nos sirve para hacer que no todos los enemigos se puedan matar. En Dogmole, sólo podremos matar a los hechiceros, que son de tipo 3. Ojo con esto: si ponemos un 1 podremos matar a todos, si ponemos un 2, a los enemigos tipo 2 y 3, y si ponemos un 3 sólo a los de tipo 3. O sea, se podrá matar a los enemigos cuyo tipo sea mayor o igual al valor que se configure.

//#define PLAYER_BOOTEE // Always jumping engine.

Esta directiva activa el salto continuo (ver Bootee). No es compatible con PLAYER_HAS_JUMP o con PLAYER_HAS_JETPAC. Si activas PLAYER_BOOTEE, tienes que desactivar los otros dos. Si no, cacota.

//#define PLAYER_BOUNCE_WITH_WALLS // Bounce when hitting a wall.

El jugador rebota contra las paredes, como en Balowwwn. Esto también funciona en vista genital (de hecho se programó específicamente para Balowwwn que está en vista genital), no sé por qué lo hemos puesto en esta sección. Ay, yo qué sé.

//#define PLAYER_CUMULATIVE_JUMP // Keep pressing JUMP to JUMP higher

Esta funciona en conjunción con PLAYER_HAS_JUMP. Si se define, al pulsar la tecla de salto empezaremos saltando poquito y cada vez que vayamos rebotando ganaremos más y más altura, como en Monono.

Configuración de la pantalla

En esta sección colocamos todos los elementos en la pantalla. ¿Recordáis cuando estábamos diseñando el marco? Pues es aquí donde vamos a poner todos los valores que dejamos apuntados, a saber:

#define VIEWPORT_X 1 //
#define VIEWPORT_Y 0 // Viewport character coordinates
Definen la posición (siempre en coordenadas de carácter) del área de juego. Nuestro área de juego empezará en (0, 1), y esos son los valores que le damos a VIEWPORT_X y VIEWPORT_Y.

#define LIFE_X 22 //
#define LIFE_Y 21 // Life gauge counter character coordinates

Definen la posición del marcador de las vidas (del numerico, vaya).

#define OBJECTS_X 17 //
#define OBJECTS_Y 21 // Objects counter character coordinates

Definen la posición del contador de objetos, si usamos objetos (la posición del numerico).

#define OBJECTS_ICON_X 15 // Objects icon character coordinates
#define OBJECTS_ICON_Y 21 // (use with ONLY_ONE_OBJECT)

Estas dos se utilizan con ONLY_ONE_OBJECT: Cuando “llevemos” el objeto encima, el motor nos lo indicará haciendo parpadear el icono del objeto en el marcador. En OBJECTS_ICON_X e Y indicamos dónde aparece dicho icono (el tile con el dibujito de la caja). Como verás, esto obliga a que estemos usando el icono en el marcador, y no un texto u otra cosa.

Sí, es una limitación.

Efectos gráficos

En esta sección se definen diversos efectos gráficos (muy básicos) que podemos activar y que controlarán la forma en la que se muestra el güego. Básicamente podemos configurar **MTE MK1** para que pinte sombras o no a la hora de construir el escenario, y definir un par de cosas relacionadas con los sprites y tal.

//#define USE_AUTO_SHADOWS // Automatic shadows made of darker attributes
//#define USE_AUTO_TILE_SHADOWS // Automatic shadows using tiles 32-47.

Estas dos se encargan de las sombras de los tiles, y podemos activar sólo una de ellas, o ninguna. Si recuerdas, en el capítulo del tileset hablamos de sombras automáticas. Si activamos USE_AUTO_SHADOWS, los tiles obstáculo dibujan sombras sobre los tiles traspasables usando sólo atributos (a veces queda resultón, pero no siempre).
USE_AUTO_TILE_SHADOWS emplea versiones sombreadas de los tiles de fondo para hacer las sombras, tal y como explicamos. Desactivando ambas no se dibujarán sombras.

En Dogmole no usaremos sombras de ningún tipo, porque las de atributos no nos gustan y las de tiles no nos las podemos permitir porque usaremos esos tiles para embellecer algunas pantallas imprimiendo gráficos por medio del script.

//#define UNPACKED_MAP // Full, uncompressed maps.

Si definimos UNPACKED_MAP estaremos diciéndole al motor que nuestro mapa es de 48 tiles.

//#define NO_MASKS // Sprites are rendered using OR
//#define PLAYER_ALTERNATE_ANIMATION // If defined, animation is 1,2,3,1,2,3…

Estas dos directivas fueron ideadas específicamente para Zombie Calavera. La primera (NO_MASKS) hace que los sprites no estén enmascarados, lo cual ahorra memoria. Como Zombie Calavera no necesitaba máscaras, pudimos sacar un montón de bytes para otras cosas. Sin embargo, el conversor de sprites que actualmente está en **MTE MK1** no es capaz de exportar spritesets sin máscaras, por lo que por ahora esta directiva no te servirá de mucho. Nos plantearemos decirle a Amador, el Mono Programador, que actualice el conversor de sprites para poder sacar spritesets sin máscaras si existe la suficiente demanda.

PLAYER_ALTERNATE_ANIMATION puede que te venga bien, ya que cambia el orden en el que se realiza la animación del personaje cuando anda. Normalmente, la animación es 2, 1, 2, 3, 2, 1, 2, 3… Pero si activas esta directiva será 1, 2, 3, 1, 2, 3,…

Configuración del movimiento del personaje principal

En esta sección configuraremos como se moverá nuestro jugador. Es muy probable que los valores que pongas aquí tengas que irlos ajustando por medio del método de prueba y error. Si tienes unas nociones básicas de física, te vendrán muy bien para saber cómo afecta cada parámetro.

Básicamente, tendremos lo que se conoce como Movimiento Rectilíneo Uniformemente Acelerado (MRUA) en cada eje: el horizontal y el vertical. Básicamente tendremos una posición (digamos X) que se verá afectada por una velocidad (digamos VX), que a su vez se verá afectada por una aceleración (o sea, AX).

Los parámetros siguientes sirven para especificar diversos valores relacionados con el movimiento en cada eje en güegos de vista lateral. En los de vista genital, se tomarán los valores del eje horizontal también para el vertical.

Para obtener la suavidad de los movimientos sin usar valores decimales (que son muy costosos de manejar), usamos aritmética de punto fijo. Básicamente los valores se expresan en 1/64 de pixel. Esto significa que el valor empleado se divide entre 64 a la hora de mover los sprites reales a la pantalla. Eso nos da una precisión de 1/64 pixels en ambos ejes, lo que se traduce en mayor suavidad de movimientos.

Somos conscientes en mojonia de que este apartado es especialmente densote, así que no te preocupes demasiado si, de entrada, te pierdes un poco. Experimenta con los valores hasta que encuentres la combinación ideal para tu güego.


Eje vertical en güegos de vista lateral

Al movimiento vertical le afecta la gravedad. La velocidad vertical será incrementada por la gravedad hasta que el personaje aterrice sobre una plataforma u obstáculo. Además, a la hora de saltar, habrá un impulso inicial y una aceleración del salto, que también definiremos aquí. Estos son los valores para Dogmole; acto seguido detallaremos cada uno de ellos:

#define PLAYER_MAX_VY_CAYENDO 512 // Max falling speed
#define PLAYER_G 48 // Gravity acceleration

#define PLAYER_VY_INICIAL_SALTO 96 // Initial junp velocity
#define PLAYER_MAX_VY_SALTANDO 312 // Max jump velocity
#define PLAYER_INCR_SALTO 48 // acceleration while JUMP is pressed

#define PLAYER_INCR_JETPAC 32 // Vertical jetpac gauge
#define PLAYER_MAX_VY_JETPAC 256 // Max vertical jetpac speed

Caída libre: La velocidad del jugador, que medimos en pixels/frame será incrementada en PLAYER_G/64 pixels/frame^2 hasta que llegue al máximo especificado por PLAYER_MAX_CAYENDO/64. Con los valores que hemos elegido para Dogmole, la velocidad vertical en caída libre será incrementada en 48/64=0,75 pixels/frame hasta que llegue a un valor de 512/64=8 píxels/frame. O sea, Dogmole caerá más y más rápido hasta que llegue a la velocidad máxima de 8 píxels por frame. Incrementando PLAYER_G hará que se alcance la velocidad máxima mucho antes. Estos valores afectan al salto: a mayor gravedad, menos saltaremos y menos nos durará el impulso inicial. Modificando PLAYER_MAX_CAYENDO podremos conseguir que la velocidad máxima, que se alcanzará antes o después dependiendo de PLAYER_G, sea mayor o menor. Usando valores pequeños podemos simular entornos de poca gravedad como el espacio exterior, la superficie de la luna, o el fondo del mar. El valor de 512 (equivalente a 8 píxels por frame) podemos considerarlo el máximo, ya que valores superiores y caídas muy largas podrían resultar en glitches y cosas raras.

Salto: Los saltos se controlan usando tres parámetros. El primero, PLAYER_VY_INICIAL_SALTO, será el valor del impulso inicial: cuando el jugador pulse la tecla de salto, la velocidad vertical tomará automáticamente el valor especificado en dirección hacia arriba. Mientras se esté pulsando salto, y durante unos ocho frames, la velocidad se seguirá incrementando en el valor especificado por PLAYER_INCR_SALTO hasta que lleguemos al valor PLAYER_MAX_VY_SALTANDO. Esto se hace para que podamos controlar la fuerza del salto pulsando la tecla de salto más o menos tiempo. El período de aceleración, que dura 8 frames, es fijo y no se puede cambiar (para cambiarlo habría que tocar el motor), pero podemos conseguir saltos más bruscos subiendo el valor de PLAYER_INCR_SALTO y PLAYER_MAX_VY_SALTANDO.

Normalmente encontrar los valores ideales exige un poco de prueba y error. Hay que tener en cuenta que al saltar horizontalmente de una plataforma a otra también entran en juego los valores del movimiento horizontal, por lo que si has decidido que en tu güego el prota debería poder sortear distancias de X tiles tendrás que encontrar la combinación óptima jugando con todos los parámetros.

Los dos valores que quedan no se usan en Dogmole porque tienen que ver con el jetpac. El primero es la aceleración que se produce mientras pulsamos la tecla arriba y el segundo el valor máximo que puede alcanzarse. Si tu juego no usa jetpac estos valores no se utilizan para nada.

Eje horizontal en güegos de vista lateral / comportamiento general en vista genital

El siguiente set de parámetros describen el comportamiento del movimiento en el eje horizontal si tu güego es en vista lateral, o los de ambos ejes si tu güego es en vista genital. Estos parámetros son mucho más sencillos:

#define PLAYER_MAX_VX 256 // Max velocity
#define PLAYER_AX 48 // Acceleration
#define PLAYER_RX 64 // Friction

La primera, PLAYER_MAX_VX, indica la velocidad máxima a la que el personaje se desplazará horizontalmente (o en cualquier dirección si el güego es en vista genital). Cuanto mayor sea este número, más correrá, y más lejos llegará cuando salte (horizontalmente). Un valor de 256 significa que el personaje correrá a un máximo de 4 píxels por frame.
PLAYER_AX controla la aceleración que sufre el personaje mientras el jugador pulsa una tecla de dirección. Cuando mayor sea el valor, antes se alcanzará la velocidad máxima. Valores pequeños hacen que “cueste arrancar”. Un valor de 48 significa que se tardará aproximadamente 6 frames (256/48) en alcanzar la velocidad máxima.

PLAYER_RX es el valor de fricción o rozamiento. Cuando el jugador deja de pulsar la tecla de movimiento, se aplica esta aceleración en dirección contraria al movimiento. Cuanto mayor sea el valor, antes se detendrá el personaje. Un valor de 64 significa que tardará 4 frames en detenerse si iba al máximo de velocidad.

Usar valores pequeños de PLAYER_AX y PLAYER_RX harán que el personaje parezca resbalar. Es lo que ocurre en güegos como, por ejemplo, Viaje al Centro de la Napia. Salvo excepciones misteriosas, casi siempre “se güega mejor” si el valor de PLAYER_AX es mayor que el de PLAYER_RX.

Comportamiento de los tiles

¿Recordáis que explicamos como cada tile tiene un tipo de comportamiento asociado? Tiles que matan, que son obstáculos, plataformas, o interactuables. En esta sección (la última, por fin) de config.h definimos el comportamiento de cada uno de los 48 tiles del tileset completo.

Tendremos que definir los comportamientos de los 48 tiles sin importar que nuestro güego utilice un tileset de 16. Por lo general, en estos casos, todos los tiles del 16 al 47 tendrán tipo “0”, pero es posible que necesitemos otros valores si empleamos los tiles extra para pintar gráficos y adornos desde el script, como haremos nosotros. En Dogmole no vamos a poner ningún obstáculo “fuera de tileset”, pero güegos como los de la saga de Ramiro el Vampiro sí que tienen obstáculos de este tipo.

Para poner los valores, simplemente abrimos el tileset y nos fijamos, están en el mismo orden en el que aparecen los tiles en el tileset:



unsigned char comportamiento_tiles [] = {
0, 8, 8, 8, 8, 8, 0, 8, 4, 0, 8, 1, 0, 0, 0,10,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
};

Como vemos, tenemos el primer tile vacío (tipo 0), luego tenemos cinco tiles de roca que son obstáculos (tipo 8), otro tile de fondo (la columnita, tipo 0), el tile de ladrillos (tipo 8), los dos tiles que forman un arco (tipo 4, plataforma, y tipo 0, traspasable), las tejas (tipo 8), unos pinchos que matan (tipo 1), tres tiles de fondo (tipo 0), y el tile cerrojo (tipo 10, interactuable).

Cuando modifiques estos valores ten cuidado con las comas y que no se te baile ningún número.

¡Arf, arf, arf!

Ah, ¿aún estás ahí? Pensaba que ya había conseguido aburrirte y quitarte todas las ganas de seguir con esto. Bien, veo que eres un tipo constante y con mucho podewwwr. Sí, ya hemos terminado de configurar nuestro güego. Ahora viene cuando lo compilamos. Paciencia con esto, sobre todo si no estás acostumbrado a pelearte con un compilador en una ventana de linea de comandos.

Vamos a configurar bien nuestro script de compilación make.bat para que nos sea muy sencillo. El script de compilación, además, se encargará de regenerar el mapa cada vez, lo cual nos viene muy bien si estamos constantemente modificándolo (por ejemplo, durante la etapa de pruebas), ya que se automatiza el proceso bastante.

Preparando nuestro script de compilación

Vamos a abrir make.bat con nuestro editor de textos para cambiar algunas cositas. Ahora mismo, si me hiciste caso en el primer capítulo, debe tener más o menos una pinta parecida a esta que sale en el recuadrito:

@echo off
rem cd ..\script
rem msc dogmole.spt msc.h 24
rem copy *.h ..\dev
rem cd ..\dev
cd ..\map
..\utils\mapcnv mapa.map 8 3 15 10 15 packed
copy mapa.h ..\dev
cd ..\dev
zcc +zx -vn dogmole.c -o dogmole.bin -lndos -lsplib2 -zorg=25000
..\utils\bas2tap -a10 -sLOADER loader.bas loader.tap
..\utils\bin2tap -o screen.tap -a 16384 loading.bin
..\utils\bin2tap -o main.tap -a 25000 dogmole.bin
copy /b loader.tap + screen.tap + main.tap dogmole.tap
del loader.tap
del screen.tap
del main.tap
del dogmole.bin
echo DONE

Asegúrate de que pone “dogmole.*” (o el nombre de tu güego) en todos los sitios que salen en negrita y cursiva. Eso es lo primero. Asegúrate también de que no se te ha olvidado renombrar el churromain.c a dogmole.c (o el nombre de tu güego).

Vamos a ver qué hace cada linea porque si estás haciendo tu propio güego querrás cambiar cosas.

En primer lugar, vemos que hay cuatro lineas que empiezan con rem. Estas lineas están comentadas y no se ejecutarán. Quitaremos los rem cuando empecemos a hacer nuestro script, así que por ahora vamos a pasar de ellas.

Acto seguido, el script cambia al directorio del mapa para volver a generar mapa.h y copiarlo a /dev, por si acaso hemos hecho algún cambio para que quede reflejado automáticamente. Esta es una de las lineas que tendrás que cambiar para tu güego, indicando los parámetros correctos de mapcnv (en concreto, el tamaño en pantallas, o si no usas cerrojos para poner 99 en lugar de 15, o si usas mapas de 48 tiles para quitar packed):

cd ..\map
..\utils\mapcnv mapa.map 8 3 15 10 15 packed
copy mapa.h ..\dev
cd ..\dev
La siguiente linea compila el güego:

zcc +zx -vn dogmole.c -o dogmole.bin -lndos -lsplib2 -zorg=25000

Esto no es más que una ejecución del compilador z88dk que toma como fuente dogmole.c (y todos los archivos .h que incluye), y saca un binario en código máquina dogmole.bin. La dirección de compilación es 25000.

Acto seguido, el script crea tres cintas en formato .tap. La primera contiene un cargador en BASIC (que puedes modificar si te pones muy friki, el fuente está en loader.bas). La siguiente contiene la pantalla de carga. Ahora mismo no nos vamos a detener en esto, así que tu güego incluirá la pantalla de carga por defecto de **MTE MK1** (que está en loading.bin). La última contiene el dogmole.bin que acabamos de compilar:

..\utils\bas2tap -a10 -sLOADER loader.bas loader.tap
..\utils\bin2tap -o screen.tap -a 16384 loading.bin
..\utils\bin2tap -o main.tap -a 25000 dogmole.bin

Fíjate en el -sLOADER de la primera linea, la que genera el cargador BASIC. Ese es el nombre que aparece tras el Program: al cargar la cinta en el Spectrum, así que, si quieres, puedes cambiarlo por otra cosa. Recuerda que los nombres de archivo de cinta de Spectrum pueden tener un máximo e 10 caracteres. Vamos a cambiarlo para que salga DOGMOLE:

..\utils\bas2tap -a10 -sDOGMOLE loader.bas loader.tap

Cuando ya tenemos las tres cintas, cada una con un bloque (cargador, pantalla, y güego) lo único que queda por hacer es unirlas:

copy /b loader.tap + screen.tap + main.tap dogmole.tap

Y, para terminar, hacemos un poco de limpieza, eliminando los archivos intermedios que ya no nos sirven para nada:
del loader.tap
del screen.tap
del main.tap
del dogmole.bin

Graba de nuevo make.bat con los cambios. Ya estamos listos. ¿Nos atrevemos?

Compilando

Lo primero que tenemos que hacer es abrir una ventana de linea de comandos e irnos a la carpeta /dev de nuestro güego:


Una vez hecho esto, vamos a ejecutar un script de z88dk que establece algunas variables de entorno. Recordad que lo instalamos en C:\z88dk10. Ejecutamos esto:

C:\z88dk10\setenv.bat


Una vez que hayamos hecho esto (tendremos que hacerlo cada vez que abramos una ventana de linea de comandos para compilar un güego), podemos ejecutar nuestro script make.bat. Salga bien o salga mal, no cierres la ventana de linea de comandos, seguramente tendrás que volver a compilar mil veces más (sobre todo si estás ajustando los valores del movimiento o modificando el mapa para arreglar cosas).

make.bat

Si lo hemos hecho todo bien, no debería haber ningún problema:



¡Ha sido DONE! ¡Ya lo tenemos! Ahora tenemos nuestro dogmole.tap con el güego listo para ser probado. Por supuesto no funcionará del todo, ya que nos falta el script, pero al menos podremos ver que se mueven los muñecos, que no la hemos cagado con el mapa, que el movimiento está bien, que los hechiceros se mueren al ser pisados, y cosas así. Si hay algo mal, se arregla, se recompila (poniendo make de nuevo), y se vuelve a probar.

Y como ya nos duele la cabeza a tí y a mí, pues lo dejamos hasta el capítulo que viene. Si decidiste empezar con algo sencillo tipo Lala Prologue o Sir Ababol, ya has terminado. Si no, aún hay muchas cosas por hacer.

The Mojon Twins