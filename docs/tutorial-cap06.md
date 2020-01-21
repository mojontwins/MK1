# Capítulo 6: Colocando cosas

Antes que nada, bájate el paquete de materiales correspondiente a este capítulo pulsando en este enlace:

[Material del capítulo 6](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-zip/churreratut-capitulo6.zip)

## ¿Ahora qué?

Ahora es cuando colocamos las cosas. Es el acto equivalente a cuando llegas del supermercado cargado de bolsas y las tienes que colocar por toda la cocina. Es un proceso tedioso, pero necesario. Puedes optar no hacerlo, por supuesto, pero luego a ver quién encuentra las salchichas. O, yo qué sé, los filtros de la cafetera. ¿Alguien sigue usando filtros para cafetera?

Básicamente lo que vamos a hacer es poner en el mapa los enemigos, los objetos y las llaves. Y no, no nos referimos precisamente a hacer esto:

![Enemigos en el mapa](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/06_colocar_en_el_mapa.jpg)

Cada ítem pertenecerá a una pantalla en concreto y tendrá una serie de valores que indiquen su posición, su tipo, su velocidad en el caso de que se muevan, y otras cosas por el estilo. En realidad estamos hablando de una tabla de números enorme que sería todo un coñazo crear a mano. Por eso hemos hecho una aplicación para poder completar este trabajo de forma visual.

Quien haya catado nuestros motores recordarán el infame **colocador**. A ellos queremos dedicar su sucesor, el **ponedor**, que, entre otras cosas es:

1. Más mejor.
2. Menos peor.

La herramienta no sólo es útil para hacer güegos con **MTE MK1**. Cualquier proyecto que tengáis con tiles de 16×16 píxels, para cualquier tamaño de pantalla, podría beneficiarse de esta utilidad. Sin ir más lejos, la usamos para colocar los bichos en güegos como **Uwol 2** de CPC, **Lala Prologue** de MSDOS, o el muy nefasto port de **Cheril Perils** para Megadrive. 

## Conceptos básicos: enemigos y hotspots

Vamos a empezar explicando algunos conceptos básicos antes de ponernos a chulear de aplicación ponedora, más que nada porque la nomenclatura que usamos suele ser menos intuitiva que el control de Uchi-Mata.

![Uchi Mata](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/06_uchi_mata.jpg)

### Enemigos

En primer lugar tenemos el concepto de enemigo. Un enemigo, para **MTE MK1**, son esas cosas que se mueven en la pantalla y que te matan y, además, las plataformas móviles. Sí, para **MTE MK1** las plataformas móviles son enemigos. Así que cuando hablamos de colocar enemigos, también hablamos de colocar plataformas móviles. Y cuando decimos que en la pantalla puede haber un máximo de 3 enemigos, hay que contar también las plataformas móviles. Sí, podríamos haberlos llamado *móviles*, por ejemplo, pero lo cierto es que las plataformas móviles se nos ocurrieron cuando ya teníamos empezado el motor y Amador, nuestro mono programador, no consintió cambiarles el nombre porque estaba pegao y ni con rasqueta.

Los enemigos tienen asociados diversos valores y algo muy importante: el tipo. El tipo de enemigo define su comportamiento y, además, el gráfico con el que se pinta. Atención porque esto es un tanto confuso, sobre todo porque no se diseñó a priori y está algo parcheado (léase más arriba el asunto de las plataformas móviles):

Los enemigos de **tipos 1, 2 o 3** (y el **4** en los güegos de vista genital) describen trayectorias lineales y se dibujan con el primer, segundo o tercer (o cuarto) sprite de enemigos del tileset. Cuando hablamos de trayectorias lineales nos referimos a dos posibles casos:

1. **Trayectorias rectilineas**, verticales u horizontales: se definen el punto de inicio y el punto de final describiendo una linea recta vertical u horizontal. El enemigo sigue esa linea imaginaria yendo y viniendo ad infinitum.

![Trayectoria lineal](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/06_lineal.png)

2. **Trayectorias diagonales**: estas surgieron de un *feature* del motor (efecto colateral no plenado debido a un algoritmo cutre, o, lo que es lo mismo, cuando un bug te sale bien), pero las dejamos porque molan. Las hemos usado mucho. Si el punto de inicio y el del final no están en la misma fila o columna, el muñeco se mueve dentro del rectángulo que describen ambos puntos, rebotando en sus paredes y moviéndose en diagonal.

![Trayectoria diagonal](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/06_diagonal.png)

Los enemigos de **tipo 4**, cuando la vista es lateral, son **plataformas móviles**. Se comportan exactamente igual que los enemigos lineales, pero con una limitación: aunque podemos definirles una trayectoria diagonal, no garantizamos que el funcionamiento sea el correcto en todos los casos. Por tanto, sólo pueden usarse trayectorias verticales u horizontales.

Los enemigos de **tipo 6** son **voladores perseguidores**. Simplemente persiguen al personaje principal por toda la pantalla y son la peste. Todos se pintan usando el gráfico 1, 2, 3 o 4 del tileset según se configure en el motor. Son como fantasmas porque pueden traspasar el escenario. Se pueden configurar normales o de tipo "HOMING", que aparecen en el sitio donde se colocan y te persiguen si te acercas. Si te alejas vuelven a su sitio. Como los celebros de **Goku Mal**.

Los enemigos de **tipo 7** son los que denominamos **EIJ**, o sea, **Enemigos Increíblemente Jartibles**. Se trata de perseguidores lineales. Estos enemigos aparecen en el punto donde los creas y se dedican a perseguir al jugador. No pueden traspasar el escenario. Si el jugador puede disparar y los mata, volverán a aparecer al ratito en el mismo sitio de donde salieron por primera vez. El gráfico con el que se dibujan se elige al azar entre todos los disponibles a menos que configures uno fijo. Funcionan mejor en güegos de vista genital y puedes verlos en acción en **Mega Meghan**. 

El código para gestionar los enemigos lineales (y plataformas) se añade por defecto al motor; los enemigos de tipo 6 o 7 hay que activarlos de forma explícita cuando configuremos el motor.

Nosotros en **Dogmole** sólo vamos a usar los enemigos de tipos 1 a 3 y las plataformas móviles de tipo 4.

Si [me invitáis a café](https://ko-fi.com/I2I0JUJ9), al final del tutorial podemos ver cómo modificar todo el motor de enemigos para poder usar más de 4 tipos lineales básicos de dos formas: usando 8 tipos diferentes sin animación, o añadiendo más frames para tener 8 tipos diferentes con animación (gastando un montón de memoria en el proceso). Pero para esto todavía queda un montón. No te vayas a emocionar ya, que estás hecho un bochinche.

### Hotspots

Los **hotspots** son, simple y llanamente, una posición dentro de la pantalla donde puede haber un objeto, una llave, una recarga de vida, una recarga de munición, o una recarga de tiempo. En cada pantalla se define un único hotspot. Cada hotspot tiene asociado un valor:

|#|Significado
|---|---
|1|Objeto o item coleccionable
|2|Llave
|3|Recarga de vida
|4|Recarga de munición
|5|Recarga de tiempo 

Cuando hablamos de objetos nos referimos al item que se dibuja con el tile número 17 del tileset y que será contado automáticamente por el motor del juego sin necesidad de tener que hacer nosotros nada más que decirle al motor que vamos a usar objetos. Se trata de las pócimas en **Lala Prologue**, o las cruces de **Zombie Calavera**, los lápices en **Viaje al Centro de la Napia** o los diskettes en **Trabajo Basura**. Nosotros vamos a usar objetos para representar las cajas que tenemos que recoger y llevar a la universidad de Miskatonic en nuestro güego. Luego, mediante scripting y configuración, haremos que el comportamiento de los objetos sea diferente (no se contará el objeto hasta que, después de cogerlo, lo hayamos depositado en un punto determinado de la universidad, de forma muy parecida a cómo funcionan los diskettes en **Trabajo Basura**), pero básicamente se trata de objetos que habrá que colocar en el mapa usando hotspots de tipo objeto (tipo 1).

Como sé que lo vais a preguntar: no, no se puede asignar más de un hotspot por pantalla tal y como está programado el motor.

## Preparando los materiales necesarios

Bien. Vamos a ponernos manos a la obra. Lo primero que tendremos que hacer es copiar los materiales necesarios al directorio `/enems`. Necesitamos dos cosas: el mapa del güego en formato `MAP`, y el tileset del juego `work.png`. Por tanto, copiamos `/map/mapa.map` y `/gfx/work.png` en `/enems`. ¡Ya estamos preparados para la marcha!

## Configuración de nuestro proyecto

Ponedor era originalmente una aplicación que, aunque tiene su interfaz gráfica, estaba pensada para ser lanzada desde la ventana de linea de comandos. Sin embargo, por petición popular, le he añadido un diálogo de entrada para que se pueda usar tal y como se usaba el viejo colocador. Si estáis interesados en usarlo desde la ventana de linea de comandos, ejecutad el programa con e parámetro -h:

```
    $ ..\utils\ponedor.exe -h
    Edit an existing set:
    $ ponedor.exe file.ene

    Create new set:
    $ ponedor.exe new out=file.ene map=file.map tiles=file.png|bmp [adjust=n] size=w,h
                      [scrsize=w,h] [nenems=n] [x2]

    out           output filename
    map           map file (raw, headerless, 1 byte per tile, row order)
    tiles         tileset in png or bmp format.
    adjust        substract this number from every byte read from the map file. Def=0
    size          map size in screens
    scrsize       screen size in tiles. Def=16,12
    nenems        number of enemies per screen. Def=3
    x2            zoom x2 (hacky)
```

Cuando ejecutas el Ponedor (por ejemplo, haciendo doble click sobre `ponedor.bat` en `/enems`) aparecerá la pantalla principal en al que podemos cargar un proyecto existente o configurar uno nuevo. Como no tenemos un proyecto existente, crearemos uno nuevo rellenando las casillas del recuadro superior:

![Creando un nuevo proyecto](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/06_ponedor_create_new.png)

Aquí hay un porrón de casillas que rellenar. Vamos a ir explicando qué son cada una de ellas, aunque la verdad es que a estas alturas casi todo debería resultar bastante intuitivo. Empezando desde arriba:

1. `Map W` y `Map H` son el **ancho** y el **alto** de nuestro mapa **en pantallas**, o sea, las **dimensiones del mapa**. En el caso de **dogmole** habría que rellenar 8 y 3.

2. `Scr W` y `Scr H` son las **dimensiones de cada pantalla**, en **tiles**. Para todos los güegos de **MTE MK1** estos valores son 15 y 10 (de hecho, vienen ya puestos por defecto). No toques aquí.

3. `Nenems` es el número de enemigos máximo por pantalla. En **MTE MK1** debe ser 3, ni más ni menos. También viene puesto por defecto. No toques aquí tampoco.

4. `Adjust` podrá valer 0 o 1, dependiendo se Mappy hizo fullerías. Si recordarás, a la hora de explicar cómo se montaba el mapa, mencionamos que Mappy quiere un tile negro como tile 0 y que si no se lo das, él se lo pone desplazando un espacio todos los tuyos. **Si te pasó esto, deberás cambiar el 0 que aparece en esta casilla por un 1**. De ese modo nuestro Ponedor estará coscado y pintará bien el mapa.

5. Donde pone `TS` tenemos que poner la ruta del archivo con el tileset, que debería ser `work.png` a secas si lo has copiado en `enems`, aunque puedes usar el botón `Find` para ubicarlo desde un explorador si no te apetece escribir 8 caracteres.

6. En `Map` hay que poner la ruta del archivo con el mapa, que debería ser `mapa.map` a secas si lo copiaste a `enems`. También puedes usar `Find`.

7. No te olvides de poner **el nombre de archivo de salida** en la casilla `Output`. Si no quieres tocar `compile.bat`, este nombre debe ser `enems.ene`. 

En la parte inferior izquierda de la ventana, por cierto, verás un botón que pone `Size`. Puedes pulsarlo para que en vez de `Normal` salga `Double` y así el Ponedor se mostrará ampliado 2X y se verá mejor todo. Consciente que soy de que cada vez se manejan resoluciones más bestias y que cada vez estamos más cegatones, tengo en mente añadir más opciones (3x y 4x).

Cuando esté todo relleno **revísalo**, que luego vienen los llantos y el crujir de dientes (nunca entendí esta expresión, pero la decía mucho una maestra de Badajoz que tuve), y cuando estés seguro de que todo está en su sitio, pulsa `Create New`.

## Manejo básico del programa

El manejo es muy sencillo. Más que nada porque el programa es muy sencillo. Si te fijas, hay una rejilla con la pantalla actual. Si no sale la rejilla, o lo que sale en la rejilla no es la primera pantalla de tu mapa, mal vamos. Revisa los pasos anteriores, sobre todo los referidos a las dimensiones del mapa y de las pantallas.

Para navegar por el mapa (para que salga otra pantalla en la rejilla) usaremos las teclas de los cursores. Pruébalo. Deberías poder hacer un bonito recorrido turístico por tu mapa.

La pantalla se divide en tres zonas, de arriba a abajo:

### Indicadores

En la parte superior de la pantalla ves un montón de indicadores que te vendrán muy bien para algunas cosas (por ejemplo para hacer el script del juego). De izquierda a derecha:

1. Coordenadas de la pantalla actual dentro del mapa (XP, YP).
2. Número actual de la pantalla (que será `YP * MAP_W + XP`).
3. `2b` o `3b` dependiendo si el archivo que estás editando es de formato antiguo o de formato nuevo, respectivamente. Con la versión 5.0 de **MTE MK1** verás siempre `3b`. Se puede convertir de formato pulsando `L`.
4. Las coordenadas de la casilla sobre la que pasa el ratón, cuando está en el área de edición.

### Área de edición

Donde ponemos las cosas que hay que poner.

### Botones

Abajo del todo verás un montón de botones. El primero pone `Save`, y graba una copia de lo que estás haciendo en el archivo que configuraste como archivo de salida. Púlsalo a menudo. Muy a menudo. También puedes darle a la tecla **S**.

Los que hayáis sufrido el colocador recordaréis lo divertido que era pulsar **ESC** sin querer y perder todos los cambios. Ahora ya no, te sale un diálogo de confirmación. Igualmente puedes pulsar el botón `Exit`. 

El botón **Grid** activa o desactiva la rejilla. No sé para qué lo puse o para qué carajo puede servir. También vale pulsar la tecla **G**.

El siguiente botón pone **Reload** y sirve para recargar los recursos (mapa y gráficos) de nuevo. A veces puedes estar poniendo enemigos y ver una cagada en el mapa. Entonces abres mappy, apañas, copias el `mapa.map` de nuevo en `enems`, y pulsar **Reload** para que el Ponedor se cosque de los cambios.

El último botón que pone **H** es por si quieres trabajar con la churrera antigua o con las primeras versiones de MK1_NES (lo que ahora es AGNES). Genera un archivo `enems.h` con los enemigos en un array de código C, **pero esto ya no se usa y no es necesario**. Ahora en `compile.bat` hay una llamada a un conversor que pilla lo que necesita directamente de tu `enems.ene`. Así que olvídate de exportar y hostias como en la Churrera vieja. No he quitado este botón porque ¿y si hay que modificar un juego viejo? Pues eso.

### Grabando y cargando

Aunque no hayas puesto nada todavía, graba tu proyecto pulsando `Save` o **S**. Verás que en el directorio `/enems` aparecerá el archivo `enems.ene` que referenciaste en el diálogo inicial al crear el proyecto. Ahora cierra el Ponedor. Ahora vuelve a ejecutarlo pulsando sobre `ponedor.bat` en `/enems`.

Esta vez, en lugar de rellenar los valores, escribe `enems.ene` en el cuadro `Input` situado en el recuadro inferior que está etiquetado `Open existing` y haz click sobre el botón que pone `Load Existing`. Si todo sale bien, te debería volver a salir la primera pantalla del mapa.

![Cargando un proyecto existente](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/06_ponedor_load_existing.png)

Como mencionamos antes, sólo tenemos que preocuparnos de poner las cosas en el Ponedor y grabar el archivo `enems.ene` a menudo. `compile.bat` se encargará de hacer las conversiones necesarias y de meter los numeritos en el juego.

## Poniendo enemigos y plataformas

Lo primero es aprender a colocar enemigos lineales (horizontales, verticales, o los raros esos diagonales que vimos antes). Lo que se hace es definir una trayectoria, un tipo, y una velocidad. Vamos a hacerlo.

Para empezar, colocamos el ratón sobre la casilla de inicio de la trayectoria y hacer click. Esta posición será la inicial, donde aparecerá el enemigo, y además servirá como uno de los límites de su trayectoria (mirad los dibujitos de más arriba, de cuando hablábamos de los tipos de enemigos). Cuando hagamos esto, aparecerá un cuadro de diálogo donde deberemos introducir el tipo del enemigo. Recuerda que en el caso de enemigos lineales será un valor de 1 a 4, 4 para las plataformas en los güegos de vista lateral. Ponemos el numerito y pulsamos OK.

Ahora lo que el programa espera es que le digamos donde acabaría la trayectoria. Nos vamos a la casilla donde debe acabar la trayectoria y hacemos click de nuevo. Veremos como se nos muestra gráficamente la trayectoria y aparece un nuevo cuadro de diálogo algo más complejo:

![El atributo sirve para la velocidad de los enemigos lineales](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/06_ponedor_attr.png)

En **MTE MK1** sólo tendremos que rellenar el recuadro `Attr`. Los otros dos están ahí porque Ponedor pretende ser una herramienta más general y **la usamos con otros motores que sí que necesitan más parámetros**. 

El valor introducido en `Attr` será el número de píxels que avanzará el enemigo o plataforma por cada cuadro de juego. Estos valores, para que no haya problemas, deberían ser potencias de dos. O sea, 1, 2, 4, 8… En realidad, los valores que valen son 1, 2 o 4. Algo más allá es ya demasiado rápido y daría problemas de todas clases. Valores que no sean potencias de dos también pueden dar problemas. Si quieres puedes probar a poner un 3 o algo a ver qué pasa, pero te digo ya que es probable que termines con el enemigo yéndose a pescar fuera de la pantalla o cosas peores. Una vez que hayamos puesto el numerico, pulsamos OK y ya tenemos nuestro primer enemigo colocado.

Para los enemigos de tipo 6 (los que vuelan, que nosotros llamamos **Fantys**) y los de tipo 7 (los que aparecen continuamente en un punto fijo y se tiran para tí a toda leche, o **EIJ**) sólo importa la casilla de inicio. La otra casilla da igual donde la pongas. Para no guarrear, se suele poner en la casilla de al lado. Para ambos tipos de enemigos puedes dejar vacío el cuadro `Attr`, ya que no se usa tampoco.

Puedes poner un máximo de tres por pantalla (el programa no te dejará meter más). No tiene por que haber tres en cada pantalla, puedes tener pantallas con uno, con dos, o con ninguno.

Para eliminar o editar los valores de un enemigo que ya hayamos colocado, basta con hacer click sobre la casilla de inicio de la trayectoria (donde aparece el numerito que indica el tipo). Entonces nos aparecerá un cuadro de diálogo donde podremos cambiar su tipo o la velocidad o eliminarlo completamente.

![Editar un enemigo](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/06_ponedor_edit.png)

Y así, poco a poco, iremos colocando nuestros enemigos y plataformas en el mapa, con un máximo de 3 por pantalla, cuidándonos de no meter un valor fuera de rango como tipo de enemigo, y no olvidándonos de que la velocidad debe ser 1, 2 o 4.

## Colocando hotspots

Como dijimos antes, un hotspot es la casilla donde aparecerá una llave, un objeto o una recarga de vida, munición o tiempo.

Se recordáis, mencionamos que cada hotspot tiene un tipo. Para **MTE MK1**, este tipo puede ser 0 (desactivado) o uno de esta tabla que pusimos antes y que ponemos de nuevo porque github es gratis:

|#|Significado
|---|---
|1|Objeto o item coleccionable
|2|Llave
|3|Recarga de vida
|4|Recarga de munición
|5|Recarga de tiempo 

Recordemos que **cada pantalla admite un único hotspot**. Eso significa que el número total de llaves y objetos necesarios para terminar el güego no puede exceder el número de pantallas. Por ejemplo, en Lala Prologue tenemos 30 pantallas. Para terminar el güego con éxito hay que recoger 25 objetos, y además hay cuatro cerrojos que abrir, por lo que necesitamos 4 llaves. Esto significa que en 25 de las 30 pantallas habrá un objeto, y en 4 habrá una llave. Perfecto: necesitamos 29 pantallas de las 30. Es importante planear esto de antemano. Si te emocionas colocando un montón de cerrojos puede que luego no te quepan todas las llaves y todos los objetos que hay que recoger.

También deberías asegurarte de que pones suficientes llaves para abrir todos los cerrojos y que siempre hay una forma de terminarse el juego sin quedarnos encerrados. Ten cuidado con esto, es posible construir combinaciones de llaves y cerrojos incorrectas si haces bifurcaciones y puede que el jugador gaste las llaves en una ruta que no tenías planeada y luego no pueda seguir avanzando.

Para colocar el hotspot de la pantalla actual, simplemente **hacemos click con el botón derecho en la casilla donde queremos que aparezca** la llave, el objeto o la recarga, con lo que haremos aparecer un pequeño cuadro de diálogo donde deberemos introducir el tipo:

![Colocando un hotspot](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/06_ponedor_hotspot.png)

Huelga decir que no todas las pantallas tienen por qué tener un hotspot. Para editar o borrar un hotspot, simplemente haz click *con el botón derecho* sobre él para mostrar el diálogo de edición desde el que también te lo puedes cargar.

## Conversión e importación

Esto antes era una tarea manual. Ahora es algo de lo que se encarga automaticamente `compile.bat`. En concreto, lo hace gracias a la utilidad `ene2h`, que lee nuestro archivo `.ene` y, mediante un mágico y misterioso proceso, obtiene el código que necesita para enchufarle al motor. Como ya es costumbre, veamos como funciona, sólo por el placer de adquirir conocimiento. Ejecutándolo en la ventana de linea de comandos, como siempre, nos chiva los parámetros:

```
    $ ..\utils\ene2h.exe
    $ ene2h.exe enems.ene enems.h [2bytes]

    The 2bytes parameter is for really old .ene files which
    stored the hotspots 2 bytes each instead of 3 bytes.
    As a rule of thumb:
    .ene file created with ponedor.exe -> 3 bytes.
    .ene file created with colocador.exe for MK1 -> 2 bytes.
```

Para **MTE MK1** sólo utilizaremos el parámetro de entrada, que deberá apuntar a nuestro archivo `.ene`, conteniendo la ruta si es necesario, nuestro archivo de salida, que para **MTE MK1** **debe** ser `assets/enems.h`, y listo. De hecho, si editas una vez más `compile.bat` encontrarás la linea de conversión tal que así:

```
    ..\utils\ene2h.exe ..\enems\enems.ene assets\enems.h
```

## ¡Y hemos terminado!

Además, con más emoción: en el próximo número vamos a configurar y compilar por primera vez nuestro güego, aunque sea sin scripting, para ver cómo va quedando.
