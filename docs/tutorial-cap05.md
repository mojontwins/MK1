# Capítulo 5: Terminando los gráficos (por ahora)

Antes que nada, bájate el paquete de materiales correspondiente a este capítulo pulsando en este enlace:

[Material del capítulo 5](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-zip/churreratut-capitulo5.zip)

## ¿Qué nos falta?

Ya queda poco que dibujar. En este capítulo vamos a explicar dos cosas: por un lado, cómo cambiar los sprites extra (explosión y bala). Por otro lado, veremos cómo hacer, convertir, comprimir e incluir el marco del juego, la pantalla de carga, la de título, y la pantalla del final.

## Sprites Extra

Además del spriteset que vimos en el anterior capítulo, **MTE MK1** utiliza algunos gráficos más si se activan algunas opciones. En concreto, si los enemigos pueden morirse necesitaremos un gráfico de explosión, y si el personaje dispara necesitaremos un gráfico de bala. El paquete trae unos por defecto que se pueden cambiar muy fácilmente (de nuevo, aquellos de vosotros que hayáis catado **MTE MK1** con anterioridad agradeceréis mucho este cambio).

Huelga decir que si tu güego no tiene enemigos pisables ni balas, o si te valen las que hay, puedes pasar de esta sección como de la cacota.

Para cambiar estos gráficos únicamente tenéis que sustituir los archivos `sprites_extra.png` y `sprites_bullet.png` en `/gfx`. El script `compile.bat` se encarga automáticamente de llamar a los conversores necesarios para obtener los gráficos en el formato que necesita el motor.

### Cambiando la explosión

La explosión es un sprite de 16×16. Para cambiarla tendremos que sustituir `/gfx/sprites_extra.png` por un nuevo archivo. Si recordáis como estaba construido el spriteset del juego, este archivo es parecido pero solo trae un gráfico y su máscara. Por tanto, deberá tratarse de una imagen de 32×16 que tenga este aspecto (el archivo está incluido en el paquete de archivos de este capítulo):

![Una nueva explosión](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/05_explosion.png)

Una vez hecho, lo guardamos, como hemos dicho, como `\gfx\sprites_extra.png`, sustituyendo al que viene por defecto.

### Cambiando el disparo

El disparo original es una bolita centrada en un cuadro. Pusimos una bolita porque usamos el mismo gráfico para disparos en todas las direcciones, así que una forma “orientada” no nos vale. Por lo tanto, vuestra nueva bala debe ser igualmente un gráfico de 8×8 que valga para todas las direcciones.

De forma muy parecida al sprite de la explosión tendremos que crear una imagen para definir la bala y su máscara. Esta vez, al ser el gráfico de 8×8, la imagen deberá ser de 16×8 para incluir la máscara; algo así:

![Una nueva explosión](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/05_bala.png)

Una vez hecho, lo guardamos, como hemos dicho, como `\gfx\sprites_bullet.png`, sustituyendo al que viene por defecto.

Como **Dogmole** no utiliza balas, no hay ningún archivo nuevo de bala en el paquetito de archivos de este capítulo.

## Pantallas fijas

Bueno, vamos con el tema de las pantallas fijas. Básicamente, los güegos de **MTE MK1** llevan tres pantallas fijas: la pantalla de título, que es la que muestra, además, el menú (para seleccionar el tipo de control y empezar a jugar), la pantalla del marco de juego, donde se ubicarán los marcadores de vidas, objetos, y cosas así, y la pantalla del final, que será la que se mostrará una vez que el jugador haya cumplido el objetivo encomendado. Además tenemos una pantalla de carga que se muestra mientras te tomas el bocata de Nocilla.

Para ahorrar memoria, además, se ofrece la posibilidad de que la pantalla de título y la pantalla con el marco del juego sean la misma, con lo que ahorraremos bastante, y que será la opción que tomaremos para nuestro Dogmole.

Otra cosa que no quiero dejar de mencionar es que las pantallas se almacenan en el güego en formato comprimido. El tipo de compresión empleado (como casi todas las compresiones) funciona mejor cuanto más sencillas sean las imágenes. O sea: cuanta más repetición y/o menos cosas haya en las pantallas, menos ocuparán al final. Ten esto muy en cuenta. Si te ves apurado de memoria, una forma de ahorrar que funciona muy bien es hacer que tus pantallas fijas sean menos complejas.

## La pantalla de título

Como ya hemos mencionado, se trata de la pantalla que se muestra con el título del güego y las opciones de control. La selección de control es fija: si el jugador pulsa 1 seleccionará el control por teclado. Si pulsa 2, elegirá Kempston, y si pulsa 3 es porque quiere jugar con un joystick de la norma Sinclair (Interface 2, puerto 1). ¿Qué quiere decir esto? Pues que tendremos que dibujar una pantalla que, además del título del güego, muestre estras tres opciones. Por ejemplo, algo así:

![Pantalla de título de Lala The Magikal Beta](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/05_title_lala.png)

Cuando hagas la tuya, guárdala como `title.png` en el directorio `\gfx`.

## La pantalla del marco de juego

Aquí sí que hay más chicha. La pantalla del marco del juego debe reservar varias zonas importantes y luego separarlas con un adorno e indicadores. Las zonas que tenemos que reservar son:

1. El **área de juego**, que es donde pasan las cosas. Como habrás adivinado, debe ser igual de grande que cada una de nuestras pantallas. Si recuerdas, las pantallas son de 15×10 tiles y, por tanto, ocupan 240×160 píxeles. Debes reservar una zona de ese tamaño como área principal de juego.

2. El **marcador de vidas/energía/vitalidad/lo que sea**: son dos dígitos que se dibujarán con la fuente que definiste cuando hicimos el tileset. Debes ubicarlo en alguna parte del marco, añadiendo algún gráfico que le dé significado. Nosotros solemos poner un dibujito del protagonista y una “x”, como verás en los ejemplos.

3. El **marcador de llaves** (si usas llaves en tu güego). Tiene las mismas características que el marcador de vidas.

4. El **marcador de objetos** (si usas objetos en tu güego). Idem de idem, para los objetos.

5. El **marcador de enemigos matados** (si se pueden matar enemigos y es importante contarlos). Pues lo mismo.

Todas estas cosas las podemos colocar donde nos venga en gana, siempre que estén alineadas a carácter. Además, deberemos apuntar la posición de cada una de estas cosas (en coordenadas de carácter, esto es, 0 a 31 para la X y 0 a 23 para la Y), porque luego habrá que indicarla en la configuración de **MTE MK1** (como veremos dentro de un par de capítulos).

Veámoslo con un ejemplo. Esta es la pantalla del marco de juego de **Lala Prologue** (no beta). Veamos los diferentes elementos. En lala tenemos llaves y además hay que recoger objetos, por lo que tendremos que poner esas dos cosas, junto con el marcador de energía, en el marco, tal y como vemos:

![Marco de Lala Prologue](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/05_marco_lala.png)

1. El área de juego, como vemos, empieza en las coordenadas x = 1, y = 2, o sea, en (1, 2).
2. El espacio que hemos dejado para el marcador de energía está en (4, 0).
3. El marcador de objetos aparece tal que en (11, 0).
4. Por último, el marcador de llaves está en (18, 0).

Como digo, hay que apuntar todos esos valores porque habrá que usarlos a la hora de construir la configuración de nuestro güego, dentro de un par de capítulos.

Cuando tengas la tuya, se graba como `marco.png` en el directorio `\gfx`.

## Pantalla de título y marco combinados

Desde muy temprano empezamos a hacer esto porque nos ayudaba a ahorrar un montón de memoria. El tema es sencillo: a una pantalla del marco de juego le añades el título y las opciones del menú dentro de la zona reservada para el área principal. La verdad es que queda bastante bien, y, reiteramos, podrás ahorrar bastante memoria.

Esto es, de hecho, lo que vamos a usar en nuestro **Dogmole**, tal y como vemos aquí:

![Título y marco combinados en Dogmole](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/05_title_marco_dogmole.png)

Como vemos, por un lado tenemos el título del güego y las opciones de control, como explicamos cuando hablamos de la pantalla de título. Por otro lado, tenemos el marcador del juego. El área de juego, como se verá, se mostrará sobre el espacio que ocupa el título y las opciones de control:

1. El área de juego estará colocada en las coordenadas (1, 0).
2. El contador de enemigos eliminados (los hechiceros) se dibujará en (12, 21).
3. El contador de cajas (o sea, los objetos) se dibujará en (17, 21).
4. El contador de vidas se dibujará en (22, 21)
5. Por último, el contador de llaves lo tendremos en (27, 21).

En este caso, la pantalla de título/marco combinados se guarda como `title.png` en `\gfx`. No habrá archivo `marco.png` para los juegos que combinen título y marco en la misma pantalla, como es nuestro caso con **Dogmole**.

## La pantalla del final

Es la pantalla que se muestra cuando el jugador se acaba el güego con éxito. Aquí no hay ninguna restricción: puedes dibujar lo que quieras. Si tiene gracia queda mejor, pero si te gusta hacer güegos serios a lo mejor no pega. Esta es la pantalla del final de Dogmole (¡¡SPOILER!!):

![El final de Dogmole](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/05_ending_dogmole.png)

Cuando la tengamos la grabaremos como `ending.png` en el directorio `/gfx`.

## La pantalla de carga

La pantalla de carga es la que se muestra mientras... bueno, ya tu sabeh. Debe guardarse igualmente en `/gfx` y llamarse `loading.png`.

## Convirtiendo las pantallas a formato Spectrum y comprimiendo

Todo el proceso está automatizado en `compile.bat` pero vamos a ver cémo es y de qué se trata, como viene siendo costumbre.

La conversión de imágenes PNG a formato de Spectrum (que se suele llamar SCR) se realiza mediante otra utilidad del _toolchain_, `png2scr`. De nuevo, si la ejecutamos desde la ventana de línea de comandos sin parámetros nos los chiva:

```
$ ..\utils\png2scr.exe
png2scr v0.2.20191119 ~ usage:

$ png2scr.exe img.png img.scr [thirds]
   * img.png is a 256x192 image, speccy formatted
   * img.scr is the converted, output file
   * [thirds] = 1, 2, 3; don't include for full image+attrs
```

En este caso deberemos pasar como parámetros el nombre de archivo de entrada en formato PNG (que debe ser de 256x192 y respetar las restricciones del Spectrum) seguido del nombre de archivo de salida. Ambos parámetros pueden incluir ruta si es necesario. El tercer parámetro no lo vamos a necesitar en **MTE_MK1** a menos que estemos haciendo fullerías avanzadas que no entran en el tutorial.

Si abres `compile.bat` en tu editor de textos verás toda una sección dedicada a convertir al formato Spectrum las cuatro pantallas fijas (carga, título, marco y final). Fíjate como los nombres de archivo son los que hemos mencionado y que todas deben ubicarse en `/gfx`:

```
    ..\utils\png2scr.exe ..\gfx\title.png ..\gfx\title.scr > nul
    ..\utils\png2scr.exe ..\gfx\marco.png ..\gfx\marco.scr > nul
    ..\utils\png2scr.exe ..\gfx\ending.png ..\gfx\ending.scr > nul
    ..\utils\png2scr.exe ..\gfx\loading.png loading.bin > nul
```

## Comprimiendo las pantallas

Como te habrás dado cuenta, los 6912 bytes que ocupa cada pantalla por tres (o por dos) son un pasote, por lo que habrá que comprimirlas. Para eso usaremos el compresor `apultra.exe` que comprime un binario en formato aplib. Tranqui, lo hemos incluido en la carpeta utils.

De nuevo, `compile.bat` se encargará de comprimir las pantallas de título, marco y final (la de carga va a pelo en el `.tap` ya que usaremos un sencillo cargador BASIC de toda la vida):

```
    ..\utils\apultra.exe ..\gfx\title.scr title.bin > nul
    ..\utils\apultra.exe ..\gfx\marco.scr marco.bin > nul
    ..\utils\apultra.exe ..\gfx\ending.scr ending.bin > nul
```

## Y ya hemos terminado

Jo ¿ya? Vaya capítulo aburrido. Lo sé. Pero bueno, era necesario. En el próximo capítulo aprenderemos a colocar los enemigos, los objetos y las llaves en el mapa del güego. Y pronto, muy pronto, podremos compilar por primera vez para empezar a verlo todo en movimiento.
