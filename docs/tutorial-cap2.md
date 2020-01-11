# Capítulo 2: Tileset

## Antes de empezar

En este capítulo y en prácticamente todos los demás tendremos que abrir una ventana de linea de comandos para ejecutar scripts y programillas, además de para lanzar la compilación del juego y cosas por el estilo. Lo que quiero decir es que deberías tener alguna noción básica de estos manejes. Si no sabes lo que es esto que te pongo aquí abajo, es mejor que consultes algún tutorial básico sobre el manejo de la ventana de linea de comandos (o consola) del sistema operativo que uses. O eso, o que llames a tu amigo el de las gafas y la camiseta de Piedra-Papel-Tijeras-Lagarto-Spock.

![Consola de linea de comandos](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/02_console.png)

Podéis echar un vistazo por ejemplo a [este tutorial](http://www.falconmasters.com/offtopic/como-utilizar-consola-de-windows/). Con los comandos listados en la sección *Lista de comandos básicos* tendréis más que suficiente.

## Material

El material necesario para seguir este capítulo os lo he dejado aquí:

[Material del capítulo 2](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-zip/churreratut-capitulo2.zip)

Descárgalo y ponlo en una carpeta temporal, que ya iremos poniendo cosas en nuestro proyecto según las vayamos necesitando. Dentro hay cosas bonitas.

## Tileset... ¿De qué leches estamos hablando?

Pues de tiles. ¿Que qué es un tile? Pues para ponerlo sencillo, no es más que un cachito de gráfico que es del mismo tamaño y forma que otros cachitos de gráficos. Para que lo veas, busca la traducción: tile significa “azulejo”, (aunque nosotros preferimos pensar que en ralidad se trata de las siglas “Tengo Ideas Locas y Estrafalarias”). Ahora piensa en la pared de tu cuarto de baño, e imagina que en cada azulejo hay un cachito de gráfico. Tenemos el azulejo con un cachito de ladrillo, el azulejo con un cachito de hierba, y el azulejo negro y el azulejo con un cachito de suelo. Con varios de cada uno podemos ordenarlos de forma que hagamos un dibujo que se parezca a una casa de campo. Un cuarto de baño así molaría de la hostia, por cierto. Siempre hay que hacer pipí. Y caca.

![Una casa de campo](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/02_tiles.png)

Esto es lo que usa **MTE MK1** para pintar los gráficos de fondo. Como guardar una pantalla gráfica completa ocupa un huevo, lo que se hace es guardar un cierto número de cachitos y luego una lista de qué cachitos ocupa cada pantalla. La colección de cachitos de un güego es lo que se conoce como “tileset”. En este capítulo vamos a explicar cómo son los tilesets de **MTE MK1**, cómo se crean, cómo se convierten, cómo se importan y cómo se usan. Pero antes necesitamos entender varios conceptos. Vete preparando un zumito.

Colisión

**MTE MK1**, además, usa los tiles para otra cosa: para la colisión. Colisión es un nombre muy chulo para referirse a algo muy tonto: el protagonista del güego podrá andar por la pantalla o no dependiendo del tipo del tile que vaya a pisar. O sea, que cada tile tiene asociado un comportamiento. Por ejemplo, al tile negro del ejemplo de arriba podríamos ponerle un comportamiento “traspasable” para que el jugador pudiera moverse libremente por el espacio ocupado por estos tiles. En cambio, el tile de la hierba debería ser “obstáculo”, entendiendo que debe impedir que el protagonista se mueva por el espacio que ocupan. Un güegos de plataformas, por ejemplo, el motor hará caer al protagonista siempre que no haya un tile “obstáculo” bajo sus pies.

En los güegos de **MTE MK1** tenemos los siguientes tipos de tiles, o, mejor dicho, los siguientes comportamientos para los tiles. Cada uno, además, tiene un código que necesitaremos saber. Ahora no, sino más adelante, cuando ya tengamos todo el material y estemos montando el güego. Por ahora nos basta con la lista:

1. *Tipo “0”, traspasable*. En los güegos de plataformas puede ser el cielo, unos ladrillos de fondo, el cuadro del tío Narciso, un florero feo o unas montañas a tomar por culo. En los güegos de vista genital los usaremos para el suelo por el que podemos andar. O sea, cosas que no detengan la marcha del muñeco.

2. *Tipo “1”, traspasable y matante*: se puede traspasar, pero si se toca se resta vida al protagonista. Por ejemplo, unos pinchos, un pozo de lava, pota radioactiva, cristales rotos, o las setas en el **Cheril of the Bosque** (¿recuerdas? ¡no se podían de tocá!).

3. *Tipo “2”, traspasable pero que oculta*. Son los matojos de **Zombie Calavera**. Si el personaje está quieto detrás de estos tiles, se supone que está “escondido”. Los efectos de estar escondido son muy poco interesantes ya que solo afectan a los murciélagos del Zombie Calavera, pero bueno, ahí está, y nosotros lo mencionamos.

4. *Tipo ”4”, plataforma*. Sólo tienen sentido en los güegos de plataformas, obviamente. Estos tiles sólo detienen al protagonista desde arriba, o sea, que si estás abajo puedes saltar a través de ellos, pero si caes desde arriba te posarás encima. No sé cómo explicártelo… como en el Sonic y eso. Por ejemplo, si pintas una columna que ocupe tres tiles (cabeza, cuerpo, y pie), puedes poner el cuerpo de tipo “0” y la cabeza de tipo “4”, y así se puede subir uno a la columna. También queda bien usar este tipo para plataformas delgadillas que no pegue que sean obstáculos del todo, como las típicas plataformas metálicas que salen en muchos de nuestros güegos.

5. *Tipo “8”, obstáculo*. Este para al personaje por todos los lados. Las paredes. Las rocas. El suelo. Todo eso es un tipo 8. No deja pasar. Piedro. Duro. Croc.

6. *Tipo “10”, interactuable*. Es un obstáculo pero que sea de tipo “10” hace que el motor esté coscao y sepa que es especial. De este tipo son, por ahora, los cerrojos y los bloques que se pueden empujar. Hablaremos de ellos dentro de poco.

Vaya mierda, pensarás, ¡si faltan números! Y más que faltaban antes. Esto está hecho queriendo, amigos, porque simplifica mucho los cálculos y permite meter más tipos en el futuro. Por ejemplo, fíjate como todo lo que sea mayor o igual que 4 parará al protagonista desde arriba, o que todo lo que sea menor que 7 dejará pasar lateralmente. ¿Ves? Trucos de ases de la programación (que, en rigor, no se usan en este motor).

En un futuro, además, se puede ampliar fácilmente, como hemos dicho. Por ejemplo, se podría añadir código a **MTE MK1** para que los tiles de tipo “5” y “6” fueran como cintas transportadoras a la izquierda y a la derecha, respectivamente. Se podría añadir. Podría. A lo mejor, al final, hacemos un capítulo de arremangarse y meter código nuevo en **MTE MK1**... ¿por qué no? Creo que además ya sabes de sobra que [me encanta el café](https://ko-fi.com/I2I0JUJ9)...

## Interactuables

Hemos mencionado los tiles interactuables. En la versión actual de **MTE MK1** son dos: cerrojos y empujables. Tienes que decidir si tu güego necesita estas características.

Los **cerrojos** los necesitarás si pones llaves en el güego. Si el personaje choca con un cerrojo y lleva una llave, pues lo abre. El cerrojo desaparecerá y se podrá pasar.

Los **tiles empujables** son unos tiles que, al empujarlos con el protagonista, cambiarán su posición si hay sitio. En los güegos de plataformas sólo se pueden empujar lateralmente; en los de vista genital se pueden empujar en cualquier dirección. Como ya veremos en su momento, podemos definir un par de cosas relacionadas con estos tiles empujables, como por ejemplo si queremos que los enemigos no puedan traspasarlos (y así poder usarlos para confinarlos y “quitarlos de enmedio” como ocurre en **Cheril of the Bosque** o **Monono**, por ejemplo).

## Vamos al lío ya ¿no?

Eso, vamos al lío ya. Vamos a dibujar nuestro tileset, o a rapiñarlo de por ahí, o a pedir a nuestro amigo que sabe dibujar que nos lo haga. Que sí, hombre, que te busques uno, que hay muchos grafistas faltos de amor. Lo primero que tenemos que decidir es si vamos a usar un tileset de 16 tiles diferentes o de 48, que son los dos tamaños de tilesets que soporta **MTE MK1**. Qué tontería, estarás pensando, ¡de 48! ¡son más! Por supuesto que son más, mi querido Einstein, pero ocurre una cosa: 16 tiles diferentes se pueden representar con un número de 4 bits. Eso significa que en un byte, que tiene 8 bits, podemos almacenar dos tiles. ¿Adónde quiero llegar? ¡Bien, lo habéis adivinado! Los mapas ocupan exactamente la mitad de memoria si usamos tilesets de 16 tiles en lugar de tilesets de 48.

Ya sé que 16 pueden parecer pocos tiles, pero pensad que la mayoría de nuestros güegos están hechos así, y muy feos no quedan. Con un poco de inventiva podemos hacer pantallas muy chulas con pocos tiles. Además, como veremos más adelante en este mismo capítulo, usar tilesets de 16 tiles nos permitirá activar el efecto de sombras automáticas, que hará que parezca que tenemos bastantes más de 16 tiles. 

Otra cosa que se puede hacer es hacer juegos de varios niveles cortos en el que cambiemos de tileset para cada nivel. Esto dará suficiente variedad y permitirá usar mapas que ocupen la mitad.

Por lo pronto id abriendo vuestro programa de edición gráfica preferido y creando un nuevo archivo de 256×48 píxels. Seguro que vuestro programa de edición gráfica tiene una opción para activar una rejilla (o grid). Colocadla para que haga recuadros de 16×16 píxels y, a ser posible, que tenga 2 subdivisiones, para que podamos ver donde empieza cada carácter. Esto nos ayudará a hacer los gráficos siguiendo las restricciones del Spectrum, o a poder saber donde empieza y termina cada tile a la hora de recortarlos y/o dibujarlos. Yo uso una versión super vieja de Photoshop y cuando creo un nuevo tileset me veo delante de algo así:

![Un lienzo vacío](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/02_empty_ts.png)

## Haciendo un tileset de 16 tiles

Si has decidido ahorrar memoria (por ejemplo, si planeas que el motor del güego termine siendo medianamente complejo, con scripting y muchas cosas molonas, o si prefieres que tu mapa sea bien grande) y usar tilesets de 16 tiles, tienes que crear algo así:

![Un lienzo vacío](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/02_tileset_16.png)

El tileset se divide en dos secciones: **la primera, formada por los primeros dieciséis tiles, es la sección de mapa**. Es la que usaremos para hacer nuestro mapa. La segunda, formada por los cuatro siguientes, es la **sección especial** que se usará para pintar cosas especiales.

### La sección de mapa

Por convención, el tile 0, o sea, el primero del tileset (los verdaderos desarrolladores empiezan a contar en el 0), será el tile de fondo principal, el que ocupe la mayoría del fondo en la mayoría de las pantallas. Esto no es un requerimiento, pero nos facilitará la vida cuando hagamos el mapa por motivos obvios: al crear un mapa vacío ya estarán todos los tiles puestos a 0.

Los **tiles del 1 al 13** pueden ser lo que quieras: tiles de fondo, obstáculos, plataformas, matantes…

El **tile 14** (el penúltimo), si has decidido que vas a activar los tiles empujables, será el **tile empujable**. Tiene que ser el 14, y ningún otro.

El **tile 15** (el último), si has decidido que vas a activar las llaves y los cerrojos, será el **tile de cerrojo**. Tiene que ser el 15, y ningún otro.

Si no vas a usar empujables o llaves/cerrojos puedes usar los tiles 14 y 15 libremente, por supuesto.

### La sección especial

Está formada por cuatro tiles que son, de izquierda a derecha:

1. El **tile 16** es la **recarga de vida**. Aparecerá en el mapa y, si el usuario la pilla, recargará un poco de vida.

2. El **tile 17** representa a los **objetos coleccionables**. Son los que el jugador tendrá que recoger durante el güego, si decidimos activarlos.

3. El **tile 18** representa las **llaves**. Si hemos decidido incluir llaves y cerrojos, pintaremos la llave en este tile.

4. El **tile 19** es el **fondo alternativo**. Para dar un poco de *age* a las pantallas, de forma aleatoria, se pintará este tile de vez en cuando en vez del tile 0. Por ejemplo, si tu tile 0 es el cielo, puedes poner una estrellica en este tile. O, si estás haciendo un güego de perspectiva genital, puedes poner una variación del suelo. **Este fondo alternativo sólo funciona en tilesets de 16 tiles**.

¿Se pilla bien? Básicamente hay que dibujar 20 tiles: 16 para hacer el mapa, y 4 para representar objetos y restar monotonía de los fondos. Huelga decir que si, por ejemplo, no vas a usar llaves y cerrojos en tu güego, te puedes ahorrar pintar la llave en el tile 18.

En el dogmole, por ejemplo, no hay tiles empujables. Por eso nuestro tile 14 es un mejillón del cantábrico que, como todos sabemos, no se puede empujar.

### Sombreado automático

El sombreado automático puede hacer que nuestras pantallas se vean mucho más chulas. Si lo activamos, **MTE MK1** hará que los tiles obstáculo proyecten sombras sobre los demás. Para conseguirlo, necesitamos definir una versión alternativa de la sección de mapa con los tiles que no sean obstáculo sombreados, que pegaremos en la fila inferior de nuestro archivo de tiles. Por ejemplo, este es el tileset de **Cheril Perils**:

![Cheril Perils](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/02_ts_perils.png)

Tendremos total control, por tanto, de cómo se proyectan las sombras. El resultado obtenido lo podéis ver aquí abajo:

![Cheril Perils](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/02_perils.png)

Otro ejemplo es **Lala Lah**, dentro pantallazo:

![Cheril Perils](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/02_lah.png)

En **Dogmole** no vamos a usar esto porque necesitamos el espacio que ocuparían las sombras automáticas para otra cosa que ya veremos en su momento.

## Ejemplos

Para verlo, vamos a echarle el ojete a algunos tilesets de nuestros güegos, a modo de ejemplo, para que veáis cómo están diseñados.

![Lala Lah](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/02_ts_lah.png)

Aquí tenemos el tileset de **Lala lah**. Como vemos,el primer tile es el fondo azul que se ve en la mayoría de las pantallas. Le sigue un trozo de plataforma que también es un tile de fondo, y después el rebordecico que es un tile tipo “plataforma” (tipo 4). Si juegas al güego verás cómo se comporta este tile, para terminar de entenderlo. El piedro amarillo que le sigue es un obstáculo (tipo 8). Luego hay dos matojitos psicodélicos para adornar de fondo (tipo 0). Luego otro piedro (8), un fondo enladrillado (0), una variación de los cuadricos (0), una bola de pinchos que mata (tipo 1), una caja con estrella (8), dos tiles para hacer tiras no traspasables (y, por tanto, de tipo 8), una plataforma to roneona (tipo 4), y para terminar el tile nº 15 será de tipo 10, porque usamos cerrojos y los cerrojos tienen que ser obstáculos interactuables. Luego tenemos la recarga, el objeto y la llave, el tile alternativo para el fondo, y en la tira de abajo los que se usan en el sombreado automático. Vamos a ver otro:

![D'Veel'Ng](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/02_ts_d'veel'ng.png)

Este es el tileset de **D'Veel'Ng**, un güego de perspectiva genital. Este empieza con dos tiles para suelo (tipo 0), seguidos por cuatro obstáculos (tipo 8) – los buesos, la calavera, la canina y el piedro, dos tiles matadores y malignos (tipo 1), que son esas calaveras rojas tan feas, otro obstáculo en forma de ladrillos amarillos (tipo 8), otro suelo embaldosado (tipo 0), otro tile que te mata en forma de seta maligna (tipo 1), ladrillos blancos (tipo 8), más suelo (tipo 0), y otra calavera obstaculizante (tipo 8). Este güego tiene tiles que se empujan, por lo que el tile 14 es una caja roja de tipo 10. También tenemos llaves, por lo que el tile 15 es un cerrojo, también de tipo 10. Luego tenemos la típica recarga de vida, el objeto y la llave, y el tile alternativo para el fondo que se pinta aleatoriamente. En la fila de abajo, volvemos a tener una versión sombreada de los tiles de fondo. Fíjate como los tiles que matan los he dejado igual en la tira “sombreada”: esto es para que siempre se vean bien destacados. Venga, más:

![Monono](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/02_ts_monono)

Ahora toca el del Monono. Este es muy sencillo de ver: empezamos con el tile de fondo principal, vacío del todo (tipo 0). Seguimos con seis obstáculos (tipo 8). Luego tenemos dos tiles de fondo más, para adornar los fondos: la ventanica para asomarse y desi ola k ase y el escudo . Luego hay tres tiles-obstáculo más (tipo 8), unos pinches venenozos (tipo 1), nuestra típica plataforma metálica copyright Mojon Twins signature special (tipo 4), una caja que se puede empujar (tile 14, tipo 10) y un cerrojo (tile 15, tipo 10). Luego lo de siempre: recarga, objeto, llave, alternativo. Este no tiene sombreado automático.

Podría seguir, pero es que no tengo más ganas.

Haciendo un tileset de 48 tiles

Como hemos advertido, los mapas hechos con tilesets de 48 tiles ocupan el doble que los que están hechos con tilesets de 16. Si aún así decides seguir esta ruta, aquí tienes una explicación de cómo hacerlo.

En primer lugar, aquí no hay una diferenciación explícita entre la sección de mapa y la sección especial: está todo junto. Además, no es posible añadir sombreado automático (no tenemos sitio para las versiones alternativas de los tiles). Sobre todo, se nota que esto de los tilesets de 48 tiles fue un añadido metido con calzador huntao en manteca para Zombie Calavera que no hemos vuelto a utilizar y que no está nada refinado. Pero oye, se puede usar.

En los tilesets de 48 tiles, podemos usar los tiles de 0 a 47 para hacer las pantallas salvo los correspondientes a las características especiales: el tile 14 para el empujable, el 15 para cerrojos, el 16 para recargas, el 17 para objetos y el 18 para llaves, si es que los vas a usar. Si no los vas a usar, puedes poner tus propios tiles. En los tilesets de 48 tiles tampoco se usa el 19 como tile alternativo de fondo, así que puedes poner lo que quieras en ese espacio.

Como único ejemplo tenemos el tileset de Zombie Calavera. Si te fijas, en Zombie Calavera no hay llaves (ni cerrojos), por lo que sólo están ocupados como “especiales” el 16 para las recargas y el 17 para los objetos. Tampoco hay tiles empujables. Todos los demás se usan para pintar el escenario:



Ya tenemos el tileset pintado. Ahora ¿qué?

Lo primero es grabarlo como copia maestra dentro de la carpeta /gfx llamándolo work.png. Ahora tenemos que prepararlo para usarlo. Haremos dos versiones: la que importaremos en el güego y la que usaremos en el Mappy para hacer el mapa y en el colocador de enemigos y objetos para… bueno, adivina.

Si estás siguiendo el tutorial con el Dogmole sin hacer experimentos propios, puedes encontrar el work.png del dogmole en el paquetito de archivos de este capítulo.

El tileset para Mappy

Mappy es muy jodío. Necesita que el tile 0 esté vacío, o sea, que sea todo negro. Si le cargas un tileset que no tenga el primer tile todo negro, pone él uno al principio y desplaza todos los demás tiles. Eso es una putada porque estaríamos haciendo un mapa con todos los índices bailados. No, no mola. Como no podemos cambiar ese comportamiento de Mappy, vamos a modificar nuestro tileset. Si has usado un gráfico en el tile 0 (por ejemplo, haciendo que el fondo de tu güego sea azul, o pintando puntitos para simular un césped en vista genital) tendremos que modificar el tileset para mappy de forma que este tile sea negro entero. Vamos a recortar los 16 tiles (si nuestro tileset es de 16 tiles) y vamos a dejar el primero vacío, así (en nuestro caso no hemos tenido que hacer nada porque nuestro tile 0 ya era renegrío, pero en juegos como, por ejemplo, Cheril of the Bosque, sí fue necesario hacerlo):



Este tileset lo grabamos en la carpeta /gfx como mappy.bmp, más que nada porque Mappy y el colocador se entienden mejor con ese formato.

Recuerda, que es importante: (leer esto con voz de madre, para que te cale más) si tu tile 0 no es totalmente negro, tienes que dejarlo totalmente negro. Mira los ejemplos de más arriba. En Zombre Calavera, Lala lah o D'Veel'Ng hubo que hacer esto. Que si no Mappy se hace un lío. Que ya me estoy viendo que me vendrás luego con el mapa terminado y los índices bailados y tendremos que liarla parda para arreglar el desbarajuste.

El tileset para importar

Splib2, la biblioteca sobre la que funciona **MTE MK1**, maneja un charset de 256 caracteres para pintar los fondos, además de los sprites que van encima. Por tanto, el siguiente paso es crear un charset para importar en el juego usando nuestro tileset y un tipo de letra. **MTE MK1** emplea los 64 caracteres que se corresponden con los códigos ASCII de 32 al 95, o sea, estas letras:


Lo suyo es que te pilles una de por ahí (hay muchas de gratis) o que pintes la tuya encima de ese gráfico (que encontrarás dentro del paquete en el archivo fuente-base.png). Sea lo que sea lo que terminéis haciéndolo, grabadlo en /gfx como fuente.png. Es muy importante que se respeten las posiciones de las letras dentro del gráfico porque si no el texto y los números saldrán mal. Esta es la fuente.png que usamos en Dogmole:


Lo primero que vamos a hacer es reordenar nuestro tileset. Lo que haremos será “partir” cada tile en cuatro trozos de 8×8. Cada uno de estos trozos se corresponde con lo que los Spectrumeros conocemos como UDG (User Defined Graphic) y, además, llevará un atributo de color asociado. Se trata de obtener algo así para poder convertirlo a código C usando SevenuP:



Hace años hacíamos esto a mano y era un verdadero coñazo. De hecho, la primera aplicación que hicimos para **MTE MK1** fue la que se encarga, precisamente, de reordenar tilesets en UDGs. La aplicación está en la carpeta /util de **MTE MK1** y se llama reordenator.exe. Para usarlo, abrimos una ventana de linea de comandos, nos metemos en la carpeta /gfx de nuestro proyecto, y escribimos algo así:

../utils/reordenator.exe work.png udgs.png

Esto pondrá a reordenator.exe a trabajar, generando un nuevo archivo udgs.png que será exactamente igual que el que hemos visto justo arriba.

Ahora que tenemos nuestra fuente en fuente.png y los udg en udgs.png, volvemos a nuestro editor gráfico, creamos un archivo nuevo de 256×64 píxels, y pegamos los udg debajo de la fuente, justo así:


Eso será lo que vamos a importar en nuestro güuego. Lo grabamos en /gfx como tileset.png. Esto es muy importante, ya que SevenuP generará el código a partir de nuestra imagen y a la estructura de datos la llamara, exactamente, “tileset”, que es lo que necesita **MTE MK1**.

Perfecto. Con todo esto hecho, abrimos, por fin, SevenuP. Una vez abierto, pulsamos “I” para “Importar”, lo que abrirá un diálogo de selección de archivos donde navegaremos hasta la carpeta /gfx de nuestro proyecto y seleccionaremos tileset.png. SevenuP lo importará y lo convertirá a formato Spectrum.

Ahora hay que configurar la exportación de datos del programa para que nos saque el charset en el orden que necesitamos. Para ello nos vamos al menú File->Output Options, con lo que se abrirá un cuadro de diálogo con muchas opciones. No habrá que tocar nada excepto el cuadro que pone Byte Sort Priority, que deberemos dejar exactamente así (pulsad sobre “Char line” y luego pulsad el botón “Move up”).



Hecho esto, le damos a OK. Ahora vamos a exportar los datos: le damos a “D” para “exportar Datos” y se nos abrirá otro diálogo de selección de archivos. Ahora tenemos que navegar hasta nuestra carpeta /dev y grabar el archivo como tileset.h (habrá que seleccionar “C” en el tipo de archivo, porque creo que por defecto viene ASM).

De esta forma, SevenuP generará un archivo /dev/tileset.h con el código necesario para tener nuestro charset en el güego. En concreto, escribirá 8 bytes para cada uno de los 256 caracteres, más 256 bytes con los atributos de los mismos.

Apréndete eso de arriba de memoria. No, en serio, quiero que generes tileset.h por tí mismo. Por eso no lo he puesto en el paquete.

Un poco de trabajo manual

Tranquilos, será muy poco.

Seguro que a estar alturas del cuento entenderéis cómo funcionan los gráficos en un Spectrum y todo el tema del “colour clash” o mezcla de atributos. Con esto sabido, es fácil entender el concepto de que, en **MTE MK1**, los sprites no tienen color propio, sino que toman el color del fondo.

El motor pintará la pantalla y luego pondrá los sprites encima. Si has sido cuidadoso y todos los tiles marcados como “fondo” son amarillos, el juego te quedará bastante homogeneo y no se notará mucho la mezcla de colores. El problema son los caracteres que son enteros del mismo color: SevenuP es bastante inteligente a la hora de seleccionar los dos colores que tiene cada carácter, pero si sólo hay un color en el carácter no tiene demasiado que hacer al respecto. Lo que termina haciendo no nos suele valer, sobre todo en el caso que nos ocupa, el Dogmole, en el que el tile 0 de fondo es todo negro: codifica los atributos como PAPER 0 e INK 0. Con esto así, los sprites no se verán, como es lógico. Y esto hay que arreglarlo a mano.



Abre /dev/tileset.h en un editor de textos. Hay que irse a la linea 279. Si tu editor de textos no te marca el número de linea es que deberías cambiar de editor de textos, por cierto. Cuando tengas un editor de textos en condiciones, te vas a la linea 279. Esta es la primera linea donde se definen los atributos de los caracteres que forman nuestro tileset. Como verás, SevenuP formatea los datos de forma que hay 8 bytes por linea. Eso significa que en cada linea de atributos están los colores de dos tiles. Si te fijas, (y si estás siguiendo el tutorial con los datos del Dogmole), SevenuP habrá generado una linea tal que así:

0, 0, 0, 0, 70, 6, 66, 2,

¿Ves lo que te decía? Esos cuatro ceros son los cuatro atributos del primer tile. Bien, pues vamos a cambiarlos. Vamos a poner la tinta a blanco, o sea, INK 7. Si recuerdas, los valores de los atributos se calculan con INK + 8*PAPER + 64*BRIGHT, así que para poner PAPER 0, INK 7 y BRIGHT 0 tenemos que cambiar esos ceros por sietes.

7, 7, 7, 7, 70, 6, 66, 2,

De hecho, deberíamos fijarnos si de ahí al final sale otro “0” que no queramos, y cambiarlo también por un el mismo valor. Si no te das cuenta ahora, créeme que te darás cuenta cuando montes el juego y veas como trozos de sprites desaparecen al pasar por ciertos sitios.

Vale, ya está todo.

Bien. Si has llegado hasta aquí has pasado la primera prueba de fuego. Hay que usar la linea de comandos para ejecutar cosas con parámetros. Hay que editar gráficos y cortar y pegar. Hay que usar aplicaciones de conversión. ¡Hay que modificar cosas a mano! Sé que muchos estaréis pensando “eh, esto no es como lo pensábamos”. Bueno, por muy fácil que te lo pongan, para hacer un güego hay que currárselo. Todo tiene su trabajo por detrás. El primer requisito que necesitamos a la hora de hacer un güego es tener ganas de hacerlo, constancia, y el propósito de currárnoslo un poco.

Y con el ladrillo escamondao, os ubicamos en este mismo canal para el próximo capítulo, donde montaremos el mapa.

Pequeña aclaración

Ha habido un par de dudas sobre el tema del tileset normal y el tileset de Mappy y tal. Vamos a poner algunos ejemplos para ilustrar el tema.

En primer lugar, veamos nuestro Dogmole Tuppowski. Para obtener el tileset de Mappy, sencillamente recortaremos los primeros 16 tiles (la tira superior) y lo grabaremos como mappy.bmp. No hay que hacer nada más, ya que el primer tile ya es totalmente negro.




Aquí tenemos otro ejemplo. Aquí vemos el tileset de Cheril of the Bosque. Para obtener el tileset de Mappy recortaremos, como siempre, los primeros 16 tiles, y además tendremos que dejar el primero completamente negro, ya que originalmente tiene una texturilla de hierba chula minimalista. Una vez eso esto, lo grabamos como mappy.bmp.




Creo que ya se pilla, pero pongamos un ejemplo más. He aquí el tileset de Viaje al Centro de la Napia. Aquí el tile 0 es rosa. Tampoco nos vale. Recortamos los 16 tiles y dejamos el tile rosa en negro. Y lo grabamos como mappy.bmp.


