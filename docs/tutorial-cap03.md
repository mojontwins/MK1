# Capítulo 3: Mapas

Antes que nada, bájate el paquete de materiales correspondiente a este capítulo pulsando en este enlace:

[Material del capítulo 3](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-zip/churreratut-capitulo3.zip)

## ¡Podewwwr mapa!

En este capítulo vamos a hacer el mapa. El tema se trata de construir cada pantalla del juego usando los tiles que dibujamos en el capítulo anterior. Cada pantalla es una especie de rejilla de casillas, donde cada casilla tiene un tile. En concreto, las pantallas se forman con 15×10 tiles.

Para construir el mapa usaremos **Mappy** (cuyos programadores realmente se quebraron la cabeza para ponerle el nombre). **Mappy** es bastante sencillote pero lo cierto es que funciona muy bien y, lo que es mejor, se deja meter mano. La versión de **Mappy** incluida en este repositorio (disponible en `/env/mappy-mojono.zip`) tiene un par de añadidos y modificaciones para que funcione como nosotros queremos.

Antes de empezar a ensuciarnos las manos y tal vamos a explicar un poco cómo funciona **Mappy**. El programa maneja un formato complejo para describir los mapas que permite varias capas, tiles animados y un montón de paranoias. Este formato, el nativo de **Mappy**, se llama ``FMP`` (que significa *Fernando Masticando Pepinos*) y es el que usaremos para almacenar nuestra copia de trabajo del mapa. Es la copia que cargaremos en **Mappy** cada vez que queramos modificar algo. Sin embargo, este formato es demasiado complejo para el importador de **MTE MK1**, que es mu tonto.

Nosotros sólo queremos una ristra de bytes que nos digan qué tile hay en cada casilla del mapa. Para eso **Mappy** tiene otro formato, el formato ``MAP`` (*Manolo Asando Pepinos*), que es el formato simple y personalizable. Nosotros lo hemos dejado en la mínima expresión: una ristra de bytes que nos digan qué tile hay en cada casilla del mapa, precisamente. Es el formato en el que habrá que guardar el mapa cuando queramos generar la copia que luego procesaremos e incorporaremos al güego.

Hay que tener mucho cuidado con esto, ya que es posible que actualicemos el mapa, grabemos el `MAP`, y se nos olvide guardar el `FMP`, con lo que la próxima vez que queramos ir al **Mappy** a hacer algún cambio habremos perdido los últimos. Nosotros tenemos a Colacao, el Mono Coscao, que nos avisa cuando nos olvidamos de grabar el `FMP`, pero entendemos que tú no tengas a tu lado a ningún mono coscao que cuide de tí, así que asegúrate de grabar en `MAP` y en `FMP` cada vez que hagas un cambio. Que luego jode perder cosas. No sé, ponte un post-it.

¿Que cómo es esto? Ya lo verás, pero el tema es tan sencillo como especificar `mapa.map` o `mapa.fmp` como nombre de archivo a la hora de grabar el mapa con utilizando `File → Save`. Cutre, pero efectivo.

## Definiendo nuestro mapa

Lo primero que tenemos que hacer es decidir cuál será el tamaño de nuestro mapa. El mapa no es más que un rectángulo de N por M pantallas. Como es lógico, cuantas más pantallas tenga nuestro mapa en total, más RAM ocupará. Por tanto, el tamaño máximo que puede tener el mapa dependerá de qué características tengamos activadas en el motor para nuestro güego. Si se trata de un güego con motor simple, nos cabrán muchas pantallas. Si tenemos un güego más complejo, con muchas características, scripting y tal, nos cabrán menos.

Es muy complicado dar una estimación de cuántas pantallas nos cabrán, como máximo. En juegos de motor sencillo, con pocas características, como **Sir Ababol** (que, al estar construido usando la versión 1.0 de **MTE MK1**, sólo incorpora las características básicas de un juego de plataformas), nos cupieron 45 pantallas y aún sobró un porrón de RAM, con lo que podría haber tenido muchas más pantallas. Sin embargo, en otros juegos más complejos, como **Cheril the Goddess** o **Zombie Calavera**, ocupamos casi toda la RAM con mapas mucho más pequeños.

Dependiendo de cómo vaya a funcionar tu güego, a lo mejor un mapa pequeño es suficiente. Por ejemplo, en el citado **Cheril the Goddess** hay que andar bastante de un lado para otro y recorrerlo varias veces para ir llevando los objetos a los altares, por lo que el juego no se hace nada corto.

Como en **Mappy** es posible redimensionar un mapa una vez hecho, quizá sea buena idea empezar con un mapa de tamaño moderado y, al final, si vemos que nos sobra RAM y queremos más pantallas, ampliarlo.

En el capítulo anterior hablamos de tilesets de 16 y de 48 tiles, y dijimos que usando uno de los primeros las pantallas ocupaban la mitad. Esto es así porque el formato de mapa que se usa es el que conocemos como `packed`, que almacena dos tiles en cada byte. Por tanto, un mapa de estas características ocupa 15×10/2 = 75 bytes por pantalla. Las 30 pantallas de **Lala the Magical**, por ejemplo, ocupan 2250 bytes (30×75). Los mapas de 48 tiles no se pueden empaquetar de la misma manera, por lo que cada tile ocupa un byte. Por tanto, cada pantalla ocupa 150 bytes. Las 25 pantallas de Zombie Calavera ocupan, por tanto, 3750 bytes. ¿Ves como conviene usar menos tiles?

Soy consciente de que con toda esta plasta que te he soltado te he aclarado muy poco, pero es que poco más te puedo aclarar. Esto es una cosa bastante empírica. Podría haberme puesto a estudiar cuanto ocupa cada característica que activemos de **MTE MK1**, pero la verdad es que nunca me ha apetecido hacerlo. Sí te puedo decir que el motor de disparos, por ejemplo, ocupa bastante, sobre todo en vista genital (como en **Mega Meghan**), ya que necesita muchas rutinas que añadir al binario. Los enemigos voladores que te persiguen (**Zombie Calavera**) también ocupan bastante. El tema de empujar bloques, las llaves, objetos, tiles que te matan, rebotar contra las paredes, o los diferentes tipos de movimiento (poder volar (**Jet Paco**, **Cheril the Goddess**), salto automático (**Bootee**), ocupan menos. El scripting también puede llegar a ocupar mucha memoria si usamos muchas órdenes y comprobaciones diferentes.

Tú fíjate un número que ronde entre las 25 y 40 pantallas y cabrá. Y si no, se recorta y listo. También me puedes [hartar a cafés](https://ko-fi.com/I2I0JUJ9) para que incorpore los mapas comprimidos en RLE (que significa *Ramiro Lo Entiende*) de MK2 en MK1.

## Creando un proyecto en **Mappy**

Lo primero que tenemos que hacer es abrir **Mappy**, ir a `File → New map`, y rellenar el recuadro donde definiremos los valores importantes de nuestro mapa: el tamaño de los tiles (16×16), y el tamaño del mapa en tiles.

En nuestro Dogmole Tuppowski, el mapa es de 8 por 3 pantallas, que María del Mar, la Mona que sabe Multiplicar, nos apunta que son un total de 24. Como cada pantalla, hemos dicho, mide 15×10 tiles, esto significa que nuestro mapa medirá 8×15 = 120 tiles de ancho y 3×10 = 30 tiles de alto. O sea, 120×30 tiles de 16×16. Y eso es lo que tendremos que rellenar en el recuadro de valores importantes (el llamado RDVI):

![El RDVI](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/03_mappy_new.png)

Cuando le demos a OK, **Mappy**, que es muy cumplido y muy apañao, nos sacará un mensaje recordándonos que lo siguiente que tenemos que hacer es cargar un tileset. Y eso es, precisamente, lo que vamos a hacer. Nos vamos a `File → Import`, lo que nos abrirá un cuadro de diálogo de selección de archivo. Navegamos hasta la carpeta gfx de nuestro proyecto, y seleccionamos nuestro `work.png`. Si todo va bien, veremos como **Mappy** es obediente y carga nuestro tileset correctamente: lo veremos en la paleta de la derecha, que es la paleta de tiles:

![El RDVI](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/03_mappy_with_ts.png)

## Inserto sobre PQSPDLs

Los PQSPDLs son los Programas Que Se Pasan de Listos, otro nombre para los Programas un poco tontetes. Es el caso de Mappy. Por favor, detenéos aquí que esto es **muy importante**.

**Mappy necesita que el tile 0 sea un tile completamente negro**. Como habrás visto, en **Dogmole** esto es así, con lo que no hay problema. El problema viene cuando el primer tile de nuestro tileset **no es completamente negro**. 

Cuando intentas cargar un tileset así en **Mappy** lo que ocurrirá es que **Mappy** meterá mamporreramente su querido tile 0 negro, **desplazando todo el tileset a la derecha**:

![¡Ay, pillín!](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/03_pillin.png) 

Esto tiene **dos posibles soluciones**. La primera, y más tonta, y la que se ha venido usando de toda la vida con **MTE MK1**, consiste en **crear un tileset alternativo en el que sustituyamos el tile 0 por un tile completamente negro**. Usaremos ese tileset en **Mappy** y todo solucionado.

La segunda solución se basa en **permitir que Mappy haga sus mierdas** y meta el tile negro que tanto le gusta, pero luego tendremos que acordarnos de este detalle porque habrá que modificar `compile.bat` para añadir un parámetro extra al conversor de mapas, y a la hora de crear nuestro archivo de enemigos (en próximos capítulos). Lo mencionaremos cuando sea el momento.

En el caso de que optemos por la segunda solución, podemos llenar todo el mapa de nuestro tile 0 (que para mappy será el 1) usando `Custom → Tile Replace`, introduciendo `0, 1` y pulsando `OK`.

## Guías

Ahora sólo queda una cosa más por hacer antes de empezar: necesitamos una ayuda para saber dónde empieza y termina cada pantalla, ya que los bordes de cada pantalla tienen que ser consistentes con los de las pantallas colindantes: si hay un obstáculo al borde derecho de una pantalla, deberá haber otro obstáculo al borde izquierdo de la pantalla que esté a su derecha. A veces se nos olvida, como estaréis pensando los que nos sigáis normalmente: la mayoría de los bugs tradicionales de los Mojon Twins tiene que ver con que no hemos hecho bien el mapa. No nos tomes como ejemplo y fíjate bien en los bordes 😀

Coloquemos esas guías. Selecciona `MapTools → Dividers` para abrir el cuadro de diálogo de las guías. Marca la casilla `Enable Dividers` y rellena `Pixel gap x` y `Pixel gap y` con los valores `240` y `160`, respectivamente, que son las dimensiones en píxels de nuestras pantallas (esto lo sabemos de nuevo gracias a María del Mar, que ha calculado que 15×16 = 240 y 10×16 = 160). Pulsa OK y verás como el área de trabajo se divide en rectángulos con unas guías azules. Sí, lo has adivinado: cada rectángulo es una pantalla de güego. Eres un puto crack. Ídolo. Mastodonte. ¡Ya estamos preparados para empezar a trabajar!

Aquí es donde hacemos el mapa. Vamos pinchando en la paleta de tiles de la derecha para seleccionar con qué tile dibujar, y luego ponemos el tile en el área de la izquierda haciendo las pantallas. Es un trabajo laborioso, lento, y, a veces, un poco coñazo. Te recomendamos que no caigas en la vagancia y hagas pantallas aburridas con amplias zonas de tiles repetidos. Intenta que tu mapa sea orgánico, irregular y variado. Las pantallas quedan mejor. También tienes que tener en cuenta que nuestro personaje tiene que poder llegar a todos los sitios. ¿Te acuerdas que al principio decidimos que haríamos que el personaje saltase alrededor de dos tiles de alto y cuatro o cinco de ancho? Hay que diseñar el mapa con eso en cuenta. Otra cosa que hay que respetar es que no debe haber sitios de “no vuelta atrás”. Eso es muy barato y muy de juego chungo de los 80. Es una caca gorda. No caigas en eso. No confundas dificultad con mal diseño. No repitas las mierdas del pasado sólo por nostalgia.

![Haciendo pantallicas](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/03_mappy_pantallitas.png)

Así que, poquito a poco, vamos construyendo nuestro mapa, que nos va quedando así (puedes cargar el archivo `mapa.fmp` del paquete de materiales de este capítulo para ver el de **Dogmole**).

Recuerda ir grabando de vez en cuando en mapa en nuestro directorio `MAP` como `mapa.fmp` (`File → Save As`). Es importante que pongas siempre `mapa.fmp` a mano o hagas click en `mapa.fmp` en la lista de archivos para que se grabe en el formato `FMP` y no perdamos nada.

Si tu juego tiene cerrojos (tile 15) o tiles empujables (tile 14) colócalos donde quieres que salgan al empezar el güego. Por ejemplo, en esta pantalla hemos colocado un cerrojo. No te preocupes por las llaves: las colocaremos luego, cuando pongamos los enemigos y los objetos en el mapa.

![Un cerrojete](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/03_mappy_cerrojo.png)

Si eres, como nuestro mono Colacao, todo un coscao, habrás visto que en el mapa de **Dogmole** hay una zona del mapa (en concreto, la zona superior izquierda) que no se puede acceder. Esta zona es la que corresponde a la Universidad de Miskatonic. Si recuerdas, cuando nos inventamos la paranoia de argumento que tiene el juego dijimos que la Universidad estaría bloqueada hasta que eliminásemos a todos los Brujetes de la Religión de Petete, que Meemaid había puesto por ahí para echar un hechizo mental que la cerrase para que no pudiésemos llevar las cajas. Cuando lleguemos al scripting veremos cómo añadir código para eliminar ese obstáculo durante el juego, cuando se detecte que los Brujetes de la Religión de Petete están todos muertos (es una cosa que podemos hacer con el scripting: modificar el mapa al vuelo). Por ahora, simplemente colocamos un piedro ahí y nos olvidamos:

![Un Piedro](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/03_mappy_piedro.png)

Otra cosa con la que tienes que tener cuidado es con los pinchos: debe haber una forma de salir de cualquier foso con pinchos. Cuando el muñeco se rebota con los pinchos salta un poquito, pero no mucho, así que no los coloques en fosos profundos. Fíjate como están puestos en nuestros güegos.

## Exportando nuestro mapa

Cuando hayamos terminado con nuestro mapa (o no, no pasa nada si montamos el juego con un cachito del mapa nada más, para ir probando), llegará el momento de exportarlo como tipo `MAP` y convertirlo para incluirlo en nuestro güego.

Nos vamos a `File → Save As` y lo grabamos como `mapa.map` en nuestro directorio `/map`. Sí, tienes que escribir `mapa.map`. Cuando lo hayas hecho, te vas de nuevo a `File → Save As` y lo grabas como `mapa.fmp` de nuevo. Escribiendo letra a letra `mapa.fmp`. Hazme caso. Hazlo, en serio. Que luego perder cosas porque se te olvidó grabar el `FMP` después de un cambio rápido es un coñazo. Que lo tenemos más que estudiao esto. Que nos ha pasado mil veces. En serio. (en rigor, se puede recuperar el `FPM` a partir del `MAP`, pero tú ten cuidado).

## Convirtiendo nuestro mapa a código

Para esto se usa otra de las utilidades de **MTE MK1**: `mapcnv`. Esta utilidad pilla archivos `MAP` de **Mappy** y los divide en pantallas (para que el motor pueda construirlas de forma más sencilla, ahorrando así tiempo y espacio). Además, si estamos usando tilesets de 16 tiles, empaqueta los tiles como hemos explicado (2 por cada byte).

La llamada a `mapcnv` está también incluida en `dev/compile.bat` pero tendremos que tunearla para adecuarla a nuestro juego, por lo que conviene saberse bien los parámetros que espera. Al igual que `ts2bin`, `mapcnv` te los chiva si lo ejecutas desde la ventana de linea de comandos sin especificar parámetros:

```
$ mapcnv
** USO **
   MapCnv archivo.map ancho_mapa alto_mapa ancho_pantalla alto_pantalla tile_cerrojo [packed] [fixmappy]

   - archivo.map : Archivo de entrada exportado con mappy en formato raw.
   - ancho_mapa : Ancho del mapa en pantallas.
   - alto_mapa : Alto del mapa en pantallas.
   - ancho_pantalla : Ancho de la pantalla en tiles.
   - alto_pantalla : Alto de la pantalla en tiles.
   - tile_cerrojo : N║ del tile que representa el cerrojo.
   - packed : Escribe esta opci¾n para mapas de la churrera de 16 tiles.
   - fixmappy : Escribe esta opci¾n para arreglar lo del tile 0 no negro

Por ejemplo, para un mapa de 6x5 pantallas para la churrera:

   MapCnv mapa.map 6 5 15 10 15 packed
```

Expliquémoslos uno a uno:

1. `archivo.map` es el archivo de entrada con nuestro mapa recién exportado de **Mappy**.
2. `ancho_mapa` es el ancho del mapa en pantallas. En el caso de **Dogmole**, 8.
3. `alto_mapa` es el alto del mapa en pantallas. En el caso de **Dogmole**, 3.
4. `ancho_pant` es el ancho de cada pantalla en tiles. Para **MTE MK1**, siempre es 15.
5. `alto_pant` es el alto de cada pantalla en tiles. Para **MTE MK1**, siempre es 10.
6. `tile_cerrojo` es el número de tile que hace de cerrojo. Para **MTE MK1** siempre ha de ser el tile número 15. Si tu juego no usa cerrojos, pon aquí un valor fuera de rango como 99. Por ejemplo, **Zombie Calavera** no usa cerrojos, así que pusimos aquí un 99 al convertir su mapa. Nosotros sí tenemos cerrojos en Dogmole, así que pondremos un 15.
7. `packed` se pone, tal cual, si nuestro tileset es de 16 tiles. Si usamos un tileset de 48 tiles, simplemente no ponemos nada. Si hacemos esto, habrá que configurar igualmente el motor activando `UNPACKED_MAP`, aunque eso ya lo veremos en el capítulo 7.
8. `fixmappy` lo pondremos si nuestro tileset no tiene un primer tile todo a negro y pasamos de hacer un tileset especial, dejando que mappy lo insertase. Así `mapcnv` lo tiene en cuenta y hace sus fullerias.

Por tanto, para convertir el mapa de **Dogmole**, tendremos que ejecutar `mapcnv` así:

```
	..\utils\mapcnv.exe mapa.map 8 3 15 10 15 packed
```

Es el momento de editar `dev/compile.bat`, ubicar la llamada a `mapcnv`, y modificar los valores del proyecto por defecto por los nuestros.

Aunque no es necesario, podemos verlo en acción ejecutando esa linea desde dentro del directorio `dev/` de nuestro proyecto. Con esto, tras un misterioso y mágico proceso, obtendremos un archivo `mapa.h` listo para que el motor lo use.

```
	$ ..\utils\mapcnv mapa.map 8 3 15 10 15 packed
	Se escribió mapa.h con 24 pantallas empaquetadas (1800 bytes).
	Se encontraron 0 cerrojos.
```

Si abrís este mapa.h con el editor de textos, veréis un montón de números en un array de C: Ese es nuestro mapa. Justo abajo, están definidos los cerrojos en otra estructura. Como verás, habrá tantos cerrojos definidos como hayamos puesto en el mapa. Si esto no es así, es que has hecho algo mal. ¡Repasa todos los pasos!

## Perfecto, todo guay, todo correcto.

Muy bien. Hemos terminado por hoy. En el próximo capítulo pintaremos los sprites del güego: el prota, los malos, las plataformas... Veremos cómo hacer un spriteset y como convertirlo para usarlo en nuestro güego.

Mientras tanto, deberías practicar. Algo que te recomendamos hacer, si es que aún no se te ha ocurrido, es descargarte los paquetes de código fuente de nuestros güegos y echarle un vistazo a los mapas. Abre los archivos `FMP` con **Mappy** y fíjate cómo están hechas las cosas.
