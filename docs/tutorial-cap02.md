# Capítulo 2: Tileset

## Antes de empezar

En este capítulo y en prácticamente todos los demás tendremos que abrir una ventana de línea de comandos para ejecutar scripts y programillas, además de para lanzar la compilación del juego y cosas por el estilo. Lo que quiero decir es que deberías tener alguna noción básica de estos manejes. Si no sabes lo que es esto que te pongo aquí abajo, es mejor que consultes algún tutorial básico sobre el manejo de la ventana de línea de comandos (o consola) del sistema operativo que uses. O eso, o que llames a tu amigo el de las gafas y la camiseta de Piedra-Papel-Tijeras-Lagarto-Spock.

![Consola de línea de comandos](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/02_console.png)

Podéis echar un vistazo por ejemplo a [este tutorial](http://www.falconmasters.com/offtopic/como-utilizar-consola-de-windows/). Con los comandos listados en la sección *Lista de comandos básicos* tendréis más que suficiente.

## Material

El material necesario para seguir este capítulo os lo he dejado aquí:

[Material del capítulo 2](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-zip/churreratut-capitulo2.zip)

Descárgalo y ponlo en una carpeta temporal, que ya iremos poniendo cosas en nuestro proyecto según las vayamos necesitando. Dentro hay cosas bonitas.

## Tileset... ¿De qué leches estamos hablando?

Pues de tiles. ¿Que qué es un _tile_? Pues para ponerlo sencillo, no es más que un cachito de gráfico que es del mismo tamaño y forma que otros cachitos de gráficos. Para que lo veas, busca la traducción: tile significa “azulejo”, (aunque nosotros preferimos pensar que en ralidad se trata de las siglas “Tengo Ideas Locas y Estrafalarias”). Ahora piensa en la pared de tu cuarto de baño, e imagina que en cada azulejo hay un cachito de gráfico. Tenemos el azulejo con un cachito de ladrillo, el azulejo con un cachito de hierba, y el azulejo negro y el azulejo con un cachito de suelo. Con varios de cada uno podemos ordenarlos de forma que hagamos un dibujo que se parezca a una casa de campo. Un cuarto de baño así molaría de la hostia, por cierto. Siempre hay que hacer pipí. Y caca.

![Una casa de campo](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/02_tiles.png)

Esto es lo que usa **MTE MK1** para pintar los gráficos de fondo. Como guardar una pantalla gráfica completa ocupa un huevo, lo que se hace es guardar un cierto número de cachitos y luego una lista de qué cachitos ocupa cada pantalla. La colección de cachitos de un güego es lo que se conoce como “tileset”. En este capítulo vamos a explicar cómo son los tilesets de **MTE MK1**, cómo se crean, cómo se convierten, cómo se importan y cómo se usan. Pero antes necesitamos entender varios conceptos. Vete preparando un zumito.

Colisión

**MTE MK1**, además, usa los tiles para otra cosa: para la colisión. Colisión es un nombre muy chulo para referirse a algo muy tonto: el protagonista del güego podrá andar por la pantalla o no dependiendo del tipo del tile que vaya a pisar. O sea, que cada tile tiene asociado un comportamiento. Por ejemplo, al tile negro del ejemplo de arriba podríamos ponerle un comportamiento “traspasable” para que el jugador pudiera moverse libremente por el espacio ocupado por estos tiles. En cambio, el tile de la hierba debería ser “obstáculo”, entendiendo que debe impedir que el protagonista se mueva por el espacio que ocupan. En un güego de plataformas, por ejemplo, el motor hará caer al protagonista siempre que no haya un tile “obstáculo” bajo sus pies.

En los güegos de **MTE MK1** tenemos los siguientes tipos de tiles o, mejor dicho, los siguientes comportamientos para los tiles. Cada uno, además, tiene un código que necesitaremos saber. Ahora no, sino más adelante, cuando ya tengamos todo el material y estemos montando el güego. Por ahora nos basta con la lista:

1. *Tipo “0”, traspasable*. En los güegos de plataformas puede ser el cielo, unos ladrillos de fondo, el cuadro del tío Narciso, un florero feo o unas montañas a tomar por culo. En los güegos de vista genital los usaremos para el suelo por el que podemos andar. O sea, cosas que no detengan la marcha del muñeco.

2. *Tipo “1”, traspasable y matante*: se puede traspasar, pero si se toca se resta vida al protagonista. Por ejemplo, unos pinchos, un pozo de lava, pota radioactiva, cristales rotos, o las setas en el **Cheril of the Bosque** (¿recuerdas? ¡no se podían de tocá!).

3. *Tipo “2”, traspasable pero que oculta*. Son los matojos de **Zombie Calavera**. Si el personaje está quieto detrás de estos tiles, se supone que está “escondido”. Los efectos de estar escondido son muy poco interesantes ya que solo afectan a los murciélagos del Zombie Calavera, pero bueno, ahí está, y nosotros lo mencionamos.

4. *Tipo ”4”, plataforma*. Sólo tienen sentido en los güegos de plataformas, obviamente. Estos tiles sólo detienen al protagonista desde arriba, o sea, que si estás abajo puedes saltar a través de ellos, pero si caes desde arriba te posarás encima. No sé cómo explicártelo… como en el Sonic y eso. Por ejemplo, si pintas una columna que ocupe tres tiles (cabeza, cuerpo, y pie), puedes poner el cuerpo de tipo “0” y la cabeza de tipo “4”, y así se puede subir uno a la columna. También queda bien usar este tipo para plataformas delgadillas que no pegue que sean obstáculos del todo, como las típicas plataformas metálicas que salen en muchos de nuestros güegos.

5. *Tipo “8”, obstáculo*. Este para al personaje por todos los lados. Las paredes. Las rocas. El suelo. Todo eso es un tipo 8. No deja pasar. Piedro. Duro. Croc.

6. *Tipo “10”, interactuable*. Es un obstáculo pero que sea de tipo “10” hace que el motor esté coscao y sepa que es especial. De este tipo son, por ahora, los cerrojos y los bloques que se pueden empujar. Hablaremos de ellos dentro de poco.

7. *Tipo “16”, destructible*. Son tiles que se pueden romper disparándolos.

Vaya mierda, pensarás, ¡si faltan números! Y más que faltaban antes. Esto está hecho queriendo, amigos, porque simplifica mucho los cálculos y permite **combinar comportamientos** sumando los números, hasta donde tenga sentido. Por ejemplo, un tile *obstáculo que mata* (8+1 = 9) no tiene sentido porque no lo vamos a poder tocar nunca, pero un *obstáculo destructible* (8+16 = 24) sí que lo tiene. De hecho, si no ponemos los destructibles como obstáculos *se podrán traspasar*.

En un futuro, además, se puede ampliar fácilmente, como hemos dicho. Por ejemplo, se podría añadir código a **MTE MK1** para que los tiles de tipo “5” y “6” fueran como cintas transportadoras a la izquierda y a la derecha, respectivamente. Se podría añadir. Podría. A lo mejor, al final, hacemos un capítulo de arremangarse y meter código nuevo en **MTE MK1**... ¿por qué no? Creo que además ya sabes de sobra que [me encanta el café](https://ko-fi.com/I2I0JUJ9)...

## Interactuables

Hemos mencionado los tiles interactuables. En la versión actual de **MTE MK1** son dos: cerrojos y empujables. Tienes que decidir si tu güego necesita estas características.

Los **cerrojos** los necesitarás si pones llaves en el güego. Si el personaje choca con un cerrojo y lleva una llave, pues lo abre. El cerrojo desaparecerá y se podrá pasar.

Los **tiles empujables** son unos tiles que, al empujarlos con el protagonista, cambiarán su posición si hay sitio. En los güegos de plataformas sólo se pueden empujar lateralmente; en los de vista genital se pueden empujar en cualquier dirección. Como ya veremos en su momento, podemos definir un par de cosas relacionadas con estos tiles empujables, como por ejemplo si queremos que los enemigos no puedan traspasarlos (y así poder usarlos para confinarlos y “quitarlos de enmedio” como ocurre en **Cheril of the Bosque** o **Monono**, por ejemplo).

## Vamos al lío ya ¿no?

Eso, vamos al lío ya. Vamos a dibujar nuestro tileset, o a rapiñarlo de por ahí, o a pedir a nuestro amigo que sabe dibujar que nos lo haga. Que sí, hombre, que te busques uno, que hay muchos grafistas faltos de amor. Lo primero que tenemos que decidir es si vamos a usar un tileset de 16 tiles diferentes o de 48, que son los dos tamaños de tilesets que soporta **MTE MK1**. Qué tontería, estarás pensando, ¡de 48! ¡son más! Por supuesto que son más, mi querido Einstein, pero ocurre una cosa: 16 tiles diferentes se pueden representar con un número de 4 bits. Eso significa que en un byte, que tiene 8 bits, podemos almacenar dos tiles. ¿Adónde quiero llegar? ¡Bien, lo habéis adivinado! Los mapas ocupan exactamente la mitad de memoria si usamos tilesets de 16 tiles en lugar de tilesets de 48.

Ya sé que 16 pueden parecer pocos tiles, pero pensad que la mayoría de nuestros güegos están hechos así, y muy feos no quedan. Con un poco de inventiva podemos hacer pantallas muy chulas con pocos tiles. Además, como veremos más adelante en este mismo capítulo, usar tilesets de 16 tiles nos permitirá activar el efecto de sombras automáticas, que hará que parezca que tenemos bastantes más de 16 tiles.

Otra cosa que se puede hacer es hacer juegos de varios niveles cortos en el que cambiemos de tileset para cada nivel. Esto dará suficiente variedad y permitirá usar mapas que ocupen la mitad.

Por lo pronto id abriendo vuestro programa de edición gráfica preferido y creando un nuevo archivo de 256×48 píxeles. Seguro que vuestro programa de edición gráfica tiene una opción para activar una rejilla (o grid). Colocadla para que haga recuadros de 16×16 píxeles y, a ser posible, que tenga 2 subdivisiones, para que podamos ver donde empieza cada carácter. Esto nos ayudará a hacer los gráficos siguiendo las restricciones del Spectrum, o a poder saber donde empieza y termina cada tile a la hora de recortarlos y/o dibujarlos. Yo uso una versión súper vieja de Photoshop y, cuando creo un nuevo tileset, me veo delante de algo así:

![Un lienzo vacío](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/02_empty_ts.png)

Con respecto a la paleta del Spectrum, como todas estas cosas, los valores que soportan por defecto los conversores incluidos en el _toolchain_ son bastante arbitrarios. Para que todo vaya bien, usa unos valores de R, G, B de 200 si quieres representar los colores sin BRIGHT y de 255 si quieres representar los colores con BRIGHT. A Mappy no le gusta el magenta intenso (255, 0, 255), así que para este color puedes usar por ejemplo (254, 0, 255).

Si no te quieres rayar, usa los colores de esta paleta:

![Paleta](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/02_palette.png)

## Haciendo un tileset de 16 tiles

Si has decidido ahorrar memoria (por ejemplo, si planeas que el motor del güego termine siendo medianamente complejo, con scripting y muchas cosas molonas, o si prefieres que tu mapa sea bien grande) y usar tilesets de 16 tiles, tienes que crear algo así:

![16 tiles](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/02_tileset_16.png)

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

En el Dogmole, por ejemplo, no hay tiles empujables. Por eso nuestro tile 14 es un mejillón del cantábrico que, como todos sabemos, no se puede empujar.

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

Aquí tenemos el tileset de **Lala lah**. Como vemos, el primer tile es el fondo azul que se ve en la mayoría de las pantallas. Le sigue un trozo de plataforma que también es un tile de fondo, y después el rebordecico que es un tile tipo “plataforma” (tipo 4). Si juegas al güego verás cómo se comporta este tile, para terminar de entenderlo. El piedro amarillo que le sigue es un obstáculo (tipo 8). Luego hay dos matojitos psicodélicos para adornar de fondo (tipo 0). Luego otro piedro (8), un fondo enladrillado (0), una variación de los cuadricos (0), una bola de pinchos que mata (tipo 1), una caja con estrella (8), dos tiles para hacer tiras no traspasables (y, por tanto, de tipo 8), una plataforma to roneona (tipo 4), y para terminar el tile nº 15 será de tipo 10, porque usamos cerrojos y los cerrojos tienen que ser obstáculos interactuables. Luego tenemos la recarga, el objeto y la llave, el tile alternativo para el fondo, y en la tira de abajo los que se usan en el sombreado automático. Vamos a ver otro:

![D'Veel'Ng](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/02_ts_d'veel'ng.png)

Este es el tileset de **D'Veel'Ng**, un güego de perspectiva genital. Este empieza con dos tiles para suelo (tipo 0), seguidos por cuatro obstáculos (tipo 8) – los buesos, la calavera, la canina y el piedro, dos tiles matadores y malignos (tipo 1), que son esas calaveras rojas tan feas, otro obstáculo en forma de ladrillos amarillos (tipo 8), otro suelo embaldosado (tipo 0), otro tile que te mata en forma de seta maligna (tipo 1), ladrillos blancos (tipo 8), más suelo (tipo 0), y otra calavera obstaculizante (tipo 8). Este güego tiene tiles que se empujan, por lo que el tile 14 es una caja roja de tipo 10. También tenemos llaves, por lo que el tile 15 es un cerrojo, también de tipo 10. Luego tenemos la típica recarga de vida, el objeto y la llave, y el tile alternativo para el fondo que se pinta aleatoriamente. En la fila de abajo, volvemos a tener una versión sombreada de los tiles de fondo. Fíjate como los tiles que matan los he dejado igual en la tira “sombreada”: esto es para que siempre se vean bien destacados. Venga, más:

![Monono](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/02_ts_monono.png)

Ahora toca el del **Monono**. Este es muy sencillo de ver: empezamos con el tile de fondo principal, vacío del todo (tipo 0). Seguimos con seis obstáculos (tipo 8). Luego tenemos dos tiles de fondo más, para adornar los fondos: la ventanica para asomarse y desí ola k ase y el escudo. Luego hay tres tiles-obstáculo más (tipo 8), unos pinches venenozos (tipo 1), nuestra típica plataforma metálica copyright Mojon Twins signature special (tipo 4), una caja que se puede empujar (tile 14, tipo 10) y un cerrojo (tile 15, tipo 10). Luego lo de siempre: recarga, objeto, llave, alternativo. Este no tiene sombreado automático.

Podría seguir, pero es que no tengo más ganas.

## Haciendo un tileset de 48 tiles

Como hemos advertido, los mapas hechos con tilesets de 48 tiles ocupan el doble que los que están hechos con tilesets de 16. Si aún así decides seguir esta ruta, aquí tienes una explicación de cómo hacerlo.

En primer lugar, aquí no hay una diferenciación explícita entre la sección de mapa y la sección especial: está todo junto. Además, no es posible añadir sombreado automático (no tenemos sitio para las versiones alternativas de los tiles). Sobre todo, se nota que esto de los tilesets de 48 tiles fue un añadido metido con calzador huntao en manteca para Zombie Calavera que no hemos vuelto a utilizar y que no está nada refinado. Pero oye, se puede usar.

En los tilesets de 48 tiles, podemos usar los tiles de 0 a 47 para hacer las pantallas salvo los correspondientes a las características especiales: el tile 14 para el empujable, el 15 para cerrojos, el 16 para recargas, el 17 para objetos y el 18 para llaves, si es que los vas a usar. Si no los vas a usar, puedes poner tus propios tiles. En los tilesets de 48 tiles tampoco se usa el 19 como tile alternativo de fondo, así que puedes poner lo que quieras en ese espacio.

Como único ejemplo tenemos el tileset de Zombie Calavera. Si te fijas, en Zombie Calavera no hay llaves (ni cerrojos), por lo que sólo están ocupados como “especiales” el 16 para las recargas y el 17 para los objetos. Tampoco hay tiles empujables. Todos los demás se usan para pintar el escenario:

![Zombie Calavera Prologue](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/02_ts_zcp.png)

## Ya tenemos el tileset pintado. Ahora ¿qué?

**MTE MK1** utiliza un set de 256 "patrones" para las partes "fijas" (fondo, textos, marcadores). Un "patrón", o carácter, no es más que una imagen de 8x8 píxeles. De los 256 "patrones", los 64 primeros contendrán letras, números y símbolos, y los 192 restantes los diferentes trozos empleados para construir el tileset que has pintado.

Para conseguir tener todos sus trocitos tal y como los necesita, **MTE_MK1** dispone de un convertidor lamado `ts2bin.exe`, ubicado, como todas las utilidades, en el directorio `src/utils`. `ts2bin.exe` necesita DOS archivos para funcionar: uno con los 64 "patrones" de la fuente, y otro con tu "tileset".

Si no quieres tocar nada, lo primero que tienes que hacer es coger tu tileset, llamarlo `work.png`, y grabarlo en `/gfx` (sustituyendo el que viene por defecto). Luego necesitas hacer el archivo con la fuente.

Si estás siguiendo el tutorial con **Dogmole** sin hacer experimentos propios, puedes encontrar el `work.png` de este güego en el paquetito de archivos de este capítulo.

## La fuente

El archivo con la fuente, que debe llamarse `font.png` y estar en el directorio `gfx` si no quieres editar `compile.bat`, debe contener, como hemos dicho, 64 "patrones". Estos "patrones" deben representar los caracteres ASCII desde el 32 al 95 y estar organizados en una imagen de 256x16 parecida a esta:

![Zombie Calavera Prologue](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/02_base_font.png)

Lo más fácil es utilizar como plantilla el archivo `fuente_base.png` incluido en el paquetito de archivos de este capítulo, y dibujar sobre él o adaptar alguna fuente ya existente. La fuente para **Dogmole** también está incluida en el paquetito: `font.png` que deberás copiar en `/gfx` sustituyendo la que viene.

## La conversión e importación

Como hemos dicho, la utilidad `ts2bin` incluida en `/utils` se encarga de tomar una fuente y un tileset y generar un binario con todos los patrones en el formato que espera **MTE MK1**. La invocación al conversor está incluida en `compile.bat` para que tú no tengas nada más que hacer que editar los gráficos y ponerlos en su sitio (y hacer todas las modificaciones que necesites de forma indolora) (los que hayan catado la Churrera en sus versiones anteriores estará ahora dando palmas con las orejas porque antes había que hacer bastante trabajo manual).

Sin embargo, por tema del saber, que no ocupa lugar, vamos a explicar cómo funciona.

`ts2bin` está pensado para ser llamado desde línea de comandos (o desde un archivo de script como `compile.bat`). Si lo ejecutas a pelo desde la ventana de línea de comandos, él mismo te chiva qué parámetros espera:

```
    $ src\utils\ts2bin.exe
    ts2bin v0.4 20200119 ~ Usage:

    $ ts2bin font.png/nofont work.png|notiles|blank ts.bin defaultink

    where:
       * font.png is a 256x16 file with 64 chars ascii 32-95
         (use 'nofont' if you don't want to include a font & gen. 192 tiles)
       * work.png is a 256x48 file with your 16x16 tiles
         (use 'notiles' if you don't want to include a tileset & gen. 64 tiles)
         (use 'blank' if you want to generate a 100% blank placeholder tileset)
       * ts.bin is the output, 2304 bytes bin file.
       * defaultink: a number 0-7. Use this colour as 2nd colour if there's only
         one colour in a 8x8 cell
```

El primer parámetro es el nombre de archivo de la fuente (incluyendo su ubicación si es necesaria), o la palabra `nofont` si sólo quieres convertir el tileset (cosa que viene bien para hacer otras cosas que no son un juego de la churrera normal).

El segundo parámetro es el nombre del archivo con el tileset (incluyendo su ubicación si es necesaria), o la palabra `notiles` si sólo quieres convertir la fuente (bla bla bla, no con la churrera en situaciones normales), o `blank` si quieres generar el binario completo sólo con la fuente y con los tiles en negro, que es lo que llamamos un "placeholder para multi nivel" y que ya entenderás cuando veamos los multinivel.

El tercer parámetro es el nombre del archivo que quieres generar (incluyendo su ubicación si es necesaria). En el caso de la churrera, el archivo resultante ocupará 2304 y contendrá todos los patrones (fuente y tileset) y los colores que se usan en el tileset.

El cuarto parámetro es opcional, y sirve para especificar un color de tinta 0-7 que quieres que se utilice si se encuentra algún "patrón" que sea un cuadrado de color sólido como segundo color. Si sabes de Spectrum le encontrarás sentido a esto.

Si abres `compile.bat` verás que los parámetros que se emplean en la llamada para obtener los patrones se corresponden con los que hemos mencionado más arriba (la fuente se llama `font.png` y el tileset `work.png`, y se ubican en `gfx`). El archivo de salida es `tileset.bin` y se emplea `7` como `defaultink`:

```
    ..\utils\ts2bin.exe ..\gfx\font.png ..\gfx\work.png tileset.bin 7
```

**Si tu juego necesita sprites de otro color sobre cuadros totalmente negros tendrás que modificar esta línea con el color que necesites**.

Los `..\utils\` y `..\gfx` hacen referencia a que los archivos se ubican en esas carpetas que están un nivel más *abajo* de donde está `compile.bat`. El `> nul` del final hace que las mierdas que dice `ts2bin` no se muestren.

Puedes probar a ejecutar el comando desde `dev` tal y como aparece para ver como se genera `tileset.bin`:

```
    $ ..\utils\ts2bin.exe ..\gfx\font.png ..\gfx\work.png tileset.bin forcezero
    ts2bin v0.3 20191202 ~ Reading font ~ reading metatiles ~  2304 bytes written

    $ dir tileset.bin
     El volumen de la unidad C es Local Disk
     El número de serie del volumen es: 6009-D6D4

     Directorio de C:\git\MK1\src\dev

    11/01/2020  16:06             2.304 tileset.bin
                   1 archivos          2.304 bytes
               0 dirs  27.100.073.984 bytes libres
```

**Repetimos**, esta tarea, si no tienes necesidades especiales, está ya cubierta en `compile.bat`.

## Vale, ya está todo.

Y con el ladrillo escamondao, os ubicamos en este mismo canal para el próximo capítulo, donde montaremos el mapa.
