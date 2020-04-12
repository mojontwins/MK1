# Capítulo 4: Sprites

Antes que nada, bájate el paquete de materiales correspondiente a este capítulo pulsando en este enlace:

[Material del capítulo 4](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-zip/churreratut-capitulo4.zip)

## ¿Qué son los sprites?

A estas alturas del cuento, si no sabes lo que es un sprite, mal vamos… Y no, no voy a hacer la típica gracia de la bebida carbonatada, (jajá, jijí, qué graciosos somos, los reyes de la fiesta, tralarí, alocados, divertidos, amigos de nuestros amigos). Sin embargo, como este capítulo va sobre sprites, habrá que empezar explicando qué son. Por si no lo sabes, se trata de una de las leyes de los tutoriales de videogüegos. No importa de qué nivel sean o sobre qué sistema traten: es obligatorio explicar qué es un sprite. Lo manda su eminencia ilustrísima Paco Perales, el papa de los tutoriales.

Veamos: el concepto de sprite, realmente, no tiene absolutamente ningún sentido en sistemas como el Spectrum, en el que la salida gráfica se limita a una matriz de píxeles. Absolutamente ningún sentido. Sin embargo, se emplea por analogía. Elaboremos: tradicionalmente, un chip de gráficos diseñado para funcionar en una máquina de güegos manejaba dos entes, principalmente: el fondo y un cierto número (limitado) de sprites. Los sprites no eran más que puñados de píxeles, normalmente cuadrados o rectangulares, que el procesador gráfico se encargaba de componer sobre el fondo a la hora de enviar la imagen al monitor o la TV. Esto es: se trataba de objetos completamente ajenos al fondo y que, por tanto, podías mover sin afectar a éste. La CPU del sistema no tenía más que decirle al procesador gráfico dónde estaba cada sprite y olvidarse, ya que dicho procesador gráfico era el que se encargaba de construir la imagen enviando al monitor píxeles de sprite en vez de píxeles de fondo cuando era necesario. Es como si los muñequitos no estuviesen realmente ahí, de ahí su nombre: la palabra “sprite” significa “hadas” o “duendecillos”.

![El Sprite de una llama](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/04_sprite_de_una_llama.jpg)

Casi todas las videoconsolas de 8 y 16 bits (las de Nintendo y SEGA por lo menos, que los sistemas de Atari eran raros de narices y por eso se metían contigo en el colegio, por tener un Atari 5200), el MSX y el Commodore 64, entre otros sistemas, tienen un procesador de gráficos de verdad que hace fondos y sprites.

En ordenadores como el Spectrum o el Amstrad CPC, o cualquier PC, el concepto de sprite no tiene sentido. ¿Por qué? Pues porque el hardware sólo maneja una matriz de píxeles, lo que sería equivalente a sólo manejar el fondo. En estos casos, los muñequitos tiene que pintarlos la CPU: tiene que encargarse de sustituir ciertos píxeles del fondo por píxeles de los muñequitos. Además, el programador debe currarse algún método para mover los muñequitos: debe poder restaurar la pantalla a como estaba antes de pintar el muñequito y redibujarlo en la nueva posición. Sin embargo, por analogía, a estos muñequitos se les llama sprites.

Nosotros los llamamos sprites, y eso que a veces somos unos puristas de la hostia (purista significa frikazo).

## Sprites en **MTE MK1**

**MTE MK1** maneja cuatro sprites de 16×16 píxeles para bicharracos (incluido el personaje que maneja el jugador) y generalmente hasta tres sprites para proyectiles (en los güegos de matar). Los sprites de los bicharracos se dibujan usando los gráficos que podemos definir en lo que se conoce como el spriteset. Dicho spriteset contiene 16 gráficos, de los cuales 8 se usan para animar al personaje principal y 8 para animar a los 4 tipos de enemigos (2 para cada uno, si se te dan bien las matemáticas). Un spriteset tiene esta pinta (este es el spriteset del Dogmole):

![El spriteset de Dogmole](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/04_spriteset_dogmole.png)

Como verás, siempre hay un gráfico de un muñeco y al lado hay una cosa rara justo a su derecha. Vamos a explicar qué es esa cosa rara antes de seguir. En primer lugar, no se llama cosa rara. Se llama máscara. Sí, ya sé que no se parece a una máscara ni de coña, pero se llama así. Tampoco los ratones de ordenador parecen ratones ni el gráfico de Horace parece un niño y no he visto a nadie quejarse todavía. La máscara se usa para decirle a la biblioteca gráfica (en este caso, nuestra **splib2** modificada), que es la que se encarga de mover los sprites (recordad que “esto es Spectrum y aquí hay que mamar”: no hay chip gráfico que haga estas cosas), qué píxeles del gráfico son *transparentes*, esto es, qué píxeles del gráfico NO deben sustituir los píxeles del fondo.

Si no hubiera dicha máscara, todos los sprites serían cuadrados o rectangulares, y eso queda bastante feo.

Nosotros hemos ordenado nuestro spriteset de forma que cada gráfico tiene su máscara correspondiente justo a la derecha. Si te fijas, las máscaras tienen píxeles negros en las zonas donde debe verse el gráfico correspondiente, y píxeles de color en las zonas donde debe verse el fondo. Es como si definiésemos la silueta.

¿Por qué son necesarias las máscaras? Si eres un poco perspicaz lo habrás adivinado: en Spectrum los gráficos son de 1 bit de profundidad, lo que significa que cada píxel se representa usando un solo bit. Eso se traduce en que sólo tenemos dos posibles valores para los píxeles: encendido o apagado (1 o 0). Para poder especificar qué píxeles son transparentes necesitaríamos un tercer valor, y eso no es posible (¡es lo que tiene el binario!). Por eso necesitamos una estructura separada para almacenar esta información ¡la máscara! ¡las máscaras molan!.

## Construyendo nuestro spriteset

Antes de construir el spriteset es muy importante saber qué tipo de vista tendrá nuestro güego: lateral o genital. Supongo que, llegados a este punto, es algo que ya tenemos decidido (vaya, si ya hemos hecho el mapa). El orden de los gráficos en el spriteset depende del tipo de vista de nuestro güego.

## Spritesets de vista lateral

Para los güegos de vista lateral, los 16 gráficos de 16×16 (acompañados por sus máscaras) que componen el spriteset tienen que tener este orden:

|#|Qué tiene
|---|---
|0|Personaje principal, derecha, andando, frame 1
|1|Personaje principal, derecha, andando, frame 2, o parado
|2|Personaje principal, derecha, andando, frame 3
|3|Personaje principal, derecha, en el aire
|4|Personaje principal, izquierda, andando, frame 1
|5|Personaje principal, izquierda, andando, frame 2, o parado
|6|Personaje principal, izquierda, andando, frame 3
|7|Personaje principal, izquierda, en el aire
|8|Enemigo tipo 1, frame 1
|9|Enemigo tipo 1, frame 2
|10|Enemigo tipo 2, frame 1
|11|Enemigo tipo 2, frame 2
|12|Enemigo tipo 3, frame 1
|13|Enemigo tipo 3, frame 2
|14|Plataforma móvil, frame 1
|15|Plataforma móvil, frame 2

Como vemos, los ocho primeros gráficos sirven para animar al personaje principal: cuatro para cuando mira a la derecha, y otros cuatro para cuando mira a la izquierda.

Tenemos tres animaciones básicas para el personaje: parado, andando, y saltando/cayendo:

1. **Parado**: La primera es cuando el personaje está parado (como su propio nombre indica). Parado significa que no se está moviendo por sí mismo (si lo mueve un ente externo sigue estando “parado”). Cuando el personaje está parado, el motor lo dibuja usando el frame 2 (gráfico número 1 si mira a la derecha o 5 si mira a la izquierda).

2. **Andando**: Es cuando el personaje se desplaza lateralmente por encima de una plataforma. En ese caso se realiza una animación de cuatro pasos usando los frames 1, 2, 3, 2, … en ese orden (gráficos 0, 1, 2, 1… si miramos a la derecha o 4, 5, 6, 5… si miramos a la izquierda). A la hora de dibujar, el personaje deberá tener ambos pies en el suelo para el frame 2, y las piernas extendidas (con la izquierda o la derecha delante) en los frames 1 y 3. Por eso usamos el frame 2 en la animación “parado”.

3. **Saltando/Cayendo**: Es cuando el personaje salta o cae (joder, ¡menos mal que lo he aclarado!). Entonces el motor dibuja el frame “saltando” (gráfico número 3 si mira a la derecha o número 7 si mira a la izquierda.

Los siguientes seis gráficos se usan para representar a los enemigos. Los enemigos pueden ser de tres tipos, y cada uno tiene dos frames de animación.

Para acabar, los dos últimos gráficos se usan para las plataformas móviles, que también tienen dos frames de animación. Las plataformas móviles son, precisamente, y como su nombre indica, plataformas que se mueven. El personaje principal podrá subirse en ellas para desplazarse. Para dibujar los gráficos tenemos que cuidar que la superficie sobre la que se debe posar el personaje principal debe tocar el borde superior del gráfico.

### Para que quede claro, veamos otro ejemplo

![El spriteset de Cherils Perils](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/04_spriteset_perils.png)

El spriteset de arriba corresponde a **Cheril Perils**. Como vemos, los ocho primeros gráficos son los correspondientes a Cheril, primero mirando a la derecha y luego mirando a la izquierda. Luego tenemos los tres enemigos que vemos en el güego, y al final la plataforma móvil. Fíjate bien en el tema de la animación de andar, imaginate pasar del frame 1 al 2, del 2 al 3, del 3 al 2, y del 2 al 1. Mira el gráfico e imagínatelo en tu cabeza. ¿lo ves? ¿ves como mueve las paticas? Ping, pong, ping, pong… Fíjate también como el frame 2 es el que mejor queda para cuando el muñeco está parado.

## Spritesets de vista genital

Para los güegos de vista genital, los 16 gráficos del spriteset tienen que tener este orden:

|#|Qué tiene
|---|---
|0|Personaje principal, derecha, andando, frame 1
|1|Personaje principal, derecha, andando, frame 2
|2|Personaje principal, izquierda, andando, frame 1
|3|Personaje principal, izquierda, andando, frame 2
|4|Personaje principal, arriba, andando, frame 1
|5|Personaje principal, arriba, andando, frame 2
|6|Personaje principal, abajo, andando, frame 1
|7|Personaje principal, abajo, andando, frame 2
|8|Enemigo tipo 1, frame 1
|9|Enemigo tipo 1, frame 2
|10|Enemigo tipo 2, frame 1
|11|Enemigo tipo 2, frame 2
|12|Enemigo tipo 3, frame 1
|13|Enemigo tipo 3, frame 2
|14|Enemigo tipo 4, frame 1
|15|Enemigo tipo 4, frame 2

De nuevo, los ocho primeros gráficos sirven para animar al personaje principal, pero esta vez el tema es más sencillo: como tenemos cuatro direcciones en las que el personaje principal puede moverse, sólo disponemos de dos frames para cada dirección.

Los ocho gráficos restantes corresponden a cuatro tipo de enemigos, ya que en un güego de vista genital no hay plataforma móvil que valga.

### algunos ejemplos:

![El spriteset de El Hobbit](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/04_spriteset_hobbit.png)

Este es el spriteset de nuestra genial conversión de **El Hobbit** (uno de nuestros grandes honores: quedar los últimos en un concurso. Es casi mejor que quedar los primeros). Fíjate como el tema cambia: arriba tenemos 8 gráficos con 2 frames para cada dirección, y abajo tenemos cuatro tipos de enemigos en lugar de tres más las plataformas.

![El spriteset de Mega Meghan](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/04_spriteset_meghan.png)

Este otro spriteset es el de **Mega Meghan**. Aquí volvemos a tener a la prota (Meghan, la asesina malvada) en las cuatro direcciones posibles con dos frames de animación para cada una en la tira superior, y a cuatro mujeres encueras (que hacen de enemigas) en la tira inferior.

Fíjate como, en este caso, nuestra vista genital la hemos diseñado con cierta perspectiva: cuando los muñecos van para arriba se dan la vuelta y cuando van para abajo miran de frente. Eso queda super chuli.

## Dibujando nuestro spriteset

Nada más fácil que crear un nuevo archivo de 256×32 píxeles, activar la rejilla para no salirnos, y dibujar los gráficos. Cuando acabemos, lo guardamos como `sprites.png` en `/gfx`. Aquí tendremos que respetar una regla muy sencilla (o dos, según se mire). Para pintar gráficos y máscaras usaremos dos colores:

En los gráficos, el **negro PURO** es el color del PAPER, y el otro color (el que queramos, es buena idea usar el blanco) es el color del INK. Recuerda que los sprites tomarán el color de los tiles que tienen de fondo al moverse por la pantalla.

En las máscaras, el **negro PURO** es la parte del gráfico que debe permanecer sólida, y cualquier otro color sirve para definir las partes transparentes (a través de las que se ve el fondo).

En nuestros ejemplos verás que usamos un color diferente (además del negro) en gráficos y máscaras, pero es más que nada por claridad. Puedes usar los colores que quieras. Yo, personalmente, uso colores diferentes porque suelo pintar la máscara y el sprite en la misma casilla de 16×16, para luego seleccionar sólo los píxeles del “color máscara” y moverlos a la casilla siguiente. Es un truco que puedes aplicar si eres mañoso con tu editor de gráficos.

Una vez que tengamos todos nuestros gráficos y sus máscaras dibujaditos en el archivo del spriteset, lo guardamos como `sprites.png` en `/gfx` y estamos listos para convertirlos en código C directamente usable por **MTE MK1**.

Por cierto, vuelve a asegurarte que el negro que has usado es **negro PURO**. Todos los píxeles negros deben ser `RGB = (0, 0, 0)`.

## Convirtiendo nuestro spriteset

Al igual que con todas las conversiones, la de los sprites también está incluida en `compile.bat` y no deberás preocuparte de nada más que de poner el archivo con los sprites `sprites.png` en `/gfx`.

Sin embargo, para seguir con la tradición, veamos como funciona el conversor, que en este caso se llama `sprcnv` y está, como los demás, en `/utils`. Si lo ejecutamos sin parámetros también nos los chiva:

```
	$ ..\utils\sprcnv.exe
	** USO **
	   sprcnv archivo.png archivo.h [nomask]

	Convierte un Spriteset de 16 sprites
```

Este es mucho más sencillo. Toma dos parámetros obligatorios: el archivo de entrada (nuestro `sprites.png`), un archivo de salida, que para **MTE MK1** debe ser `sprites.h` en `/dev/assets`, y el parámetro `nomask`, que es optativo, y que generará los sprites sin máscara (algo que solo hemos usado en Zombie Calavera y que por ahora dejaremos "ahí").

Si abres `/dev/compile.bat` verás que los valores de los parámetros son, precisamente, los que hemos mencionado arriba.

## Jodó, ¿ya?

Sí, tío o tía. El tema de los sprites era sencillo y tenía muy poca chicha… O al menos eso creo. Si crees que algo no queda claro ya sabes qué hacer: te aguantas. No, que es coña. Si crees que algo no queda claro simplemente pregúntanos. Pero tienes que poner voz de niña repipi.

En el próximo capítulo vamos a explicar el tema de las pantallas fijas: el título, el marco del juego, y la pantalla del final. Hasta entonces, ¡a hacer sprites!
