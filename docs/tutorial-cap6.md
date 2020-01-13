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

Los enemigos de **tipo 6** son **voladores perseguidores**. Simplemente persiguen al personaje principal por toda la pantalla y son la peste. Todos se pintan usando el gráfico 1, 2, 3 o 4 del tileset según se configure en el motor. Son como fantasmas porque pueden traspasar el escenario.

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

Cuando ejecutas el Colocador (por ejemplo, haciendo doble click sobre `ponedor.bat` en `/enems`) aparecerá la pantalla principal en al que, o bien cargaremos un proyecto existente, o configuraremos uno nuevo. Como no tenemos un proyecto existente, crearemos uno nuevo.



Como vemos, en las dos primeras casillas habrá que introducir el nombre de nuestro mapa y de nuestro tileset (mapa.map y mappy.bmp, que deberían estar ya en el directorio /enems). Posteriormente hay cuatro casillas que definen el tamaño del mapa y de las pantallas. MAP_W y MAP_H deberían contener el ancho y alto de tu mapa medido en pantallas. SCR_W y SCR_H son para especificar el ancho y alto de las pantallas en tiles. Paras los güegos de **MTE MK1** estos valores son, como ya deberías saber de sobra, 15 y 10.

La última casilla que hay que rellenar es el número de enemigos que aparecerá en cada pantalla. En **MTE MK1** son 3. No, si pones más no saldrán más en el güego. Sólo conseguirás que todo funcione mal. Pon 3. Te aseguro que 3 son suficientes.

Cuando esté todo relleno pulsamos en NUEVO y entonces podremos empezar a trabajar.

Manejo básico del programa

El manejo es muy sencillo. Más que nada porque el programa es muy sencillo. Si te fijas, hay una rejilla con la pantalla actual. Si no sale la rejilla, o lo que sale en la rejilla no es la primera pantalla de tu mapa, mal vamos. Revisa los pasos anteriores, sobre todo los referidos a las dimensiones del mapa y de las pantallas.

Para navegar por el mapa (para que salga otra pantalla en la rejilla) usaremos las teclas de los cursores. Pruébalo. Deberías poder hacer un bonito recorrido turístico por tu mapa.

Si pulsamos ESC se cerrará el programa, algo tremendamente útil cuando hemos terminado y queremos salir. Pero cuidado: se sale sin más. Cuidado, cuidado, cuidado. No pulses ESC sin grabar antes. Que no avisa. Que se cierra.

Precisamente para grabar tenemos la tecla S. De hecho, vamos a usarla ya mismo, aunque no hayamos colocado ningún enemigo. Por convención, nosotros usamos .ene como extensión para los archivos del Colocador. Pulsa S y, en el cuadro de diálogo que sale, escribe enems.ene y haz click sobre el botón Ok. Ya hemos grabado nuestras colocaciones. Haz esto muy a menudo. Haznos caso.

Vamos a ver esto en acción. Pulsa ESC para salir. Fíjate que ahora hay un archivo enems.ene en /enems. Vuelve a ejecutar colocador.exe. Esta vez, en lugar de rellenar los valores, escribe enems.ene en el cuadro que está etiquetado Abrir un proyecto existente y haz click sobre el botón que pone Cargar. Si todo sale bien, te debería volver a salir la primera pantalla del mapa.



Este archivo enems.ene no nos sirve para usarlo directamente en el güego. Para poder tener nuestros enemigos en el güego necesitaremos que el colocador exporte código C. Esto es hace pulsando la tecla E. Cuando lo hagamos, aparecerá un cuadro de diálogo parecido al del guardar. Ahí deberemos escribir enems.h, pulsar OK, y copiar este archivo a /dev. Esto será lo que haremos cuando hayamos terminado de colocar todos los enemigos y queramos integrarlos en el güego.

Poniendo enemigos y plataformas

Lo más sencillo es colocar enemigos lineales (horizontales, verticales, o los raros esos diagonales que vimos antes). Lo que se hace es definir una trayectoria, un tipo, y una velocidad. Vamos a hacerlo.

Lo primero que tenemos que hacer es colocar el ratón sobre la casilla de inicio de la trayectoria y hacer click. Esta posición será la inicial, donde aparecerá el enemigo, y además servirá como uno de los límites de su trayectoria (mirad los dibujitos de más arriba, de cuando hablábamos de los tipos de enemigos). Cuando hagamos esto, aparecerá un cuadro de diálogo donde deberemos introducir el tipo del enemigo. Recuerda que en el caso de enemigos lineales será un valor de 1 a 4, 4 para las plataformas en los güegos de vista lateral. Ponemos el numerito y pulsamos OK.

Ahora lo que el programa espera es que le digamos donde acabaría la trayectoria. Nos vamos a la casilla donde debe acabar la trayectoria y hacemos click de nuevo. Veremos como se nos muestra gráficamente la trayectoria y aparece un nuevo cuadro de diálogo en el que nos preguntan por la velocidad.

El valor introducido será el número de píxels que avanzará el enemigo o plataforma por cada cuadro de juego. Estos valores, para que no haya problemas, deberían ser potencias de dos. O sea, 1, 2, 4, 8… En realidad, los valores que valen son 1, 2 o 4. Algo más allá es ya demasiado rápido y daría problemas de todas clases. Valores que no sean potencias de dos también pueden dar problemas. Si quieres puedes probar a poner un 3 o algo a ver qué pasa, pero te digo ya que es probable que termines con el enemigo yéndose a pescar fuera de la pantalla o cosas peores. Una vez que hayamos puesto el numerico, pulsamos OK y ya tenemos nuestro primer enemigo colocado.



Para enemigos de otros tipos (5 o 7, por ahora) el tema cambia un poco. Por ejemplo, los enemigos tipo 5 da igual donde los pongas: siempre aparecen desde fuera de la pantalla (mira los murciélagos de Zombie Calavera para saber a qué me refiero). Puedes establecer el inicio y fin de la trayectoria donde te de la gana. La velocidad que pongas también es lo de menos. Con los enemigos de tipo 7 (Mega Meghan) sólo se tendrá en cuenta la posición de inicio. La velocidad y la posición del final serán ignoradas igualmente.

Cuando nos pongamos, en un futuro, a programar en el motor un tipo de enemigo custom para el tipo 6, lo haremos teniendo en cuenta que tenemos las posiciones de inicio y fin y un valor de velocidad para jugar. Por ejemplo, si vamos a hacer una bala de cañón que se dispare, podemos usar la posición de final para definir la dirección hacia la que se disparará. Pero bueno, no adelantemos acontecimientos. Además, Dogmole no utiliza enemigos que no sean lineales, y mucho menos cosas raras como estas.

Puedes poner un máximo de tres por pantalla (el programa no te dejará meter más). No tiene por que haber tres en cada pantalla, puedes tener pantallas con uno, con dos, o con ninguno.

Para eliminar o editar los valores de un enemigo que ya hayamos colocado, basta con hacer click sobre la casilla de inicio de la trayectoria (donde aparece el numerito que indica el tipo). Entonces nos aparecerá un cuadro de diálogo donde podremos cambiar su tipo o la velocidad o eliminarlo completamente.

Y así, poco a poco, iremos colocando nuestros enemigos y plataformas en el mapa, con un máximo de 3 por pantalla, cuidándonos de no meter un valor fuera de rango como tipo de enemigo, y no olvidándonos de que la velocidad debe ser 1, 2 o 4.

Colocando hotspots

Como dijimos antes, un hotspot es la casilla donde aparecerá una llave o un objeto durante el güego, y donde puede que aparezca una recarga si volvemos a la pantalla después de haber cogido dicha llave o dicho objeto.

Se recordáis, mencionamos que cada hotspot tiene un tipo. Para **MTE MK1**, este tipo puede ser 0 (desactivado), 1 (contiene un objeto) o 2 (contiene una llave). Si luego te pones guay puedes expandir el engine para que haya más, pero tal y como está **MTE MK1** admite estos tres tipos.

Recordemos que cada pantalla admite un único hotspot. Eso significa que el número total de llaves y objetos necesarios para terminar el güego no puede exceder el número de pantallas. Por ejemplo, en Lala Prologue tenemos 30 pantallas. Para terminar el güego con éxito hay que recoger 25 objetos, y además hay cuatro cerrojos que abrir, por lo que necesitamos 4 llaves. Esto significa que en 25 de las 30 pantallas habrá un objeto, y en 4 habrá una llave. Perfecto: necesitamos 29 pantallas de las 30. Es importante planear esto de antemano. Si te emocionas colocando un montón de cerrojos puede que luego no te quepan todas las llaves y todos los objetos que hay que recoger.

También deberías asegurarte de que pones suficientes llaves para abrir todos los cerrojos y que siempre hay una forma de terminarse el juego sin quedarnos encerrados. Ten cuidado con esto, es posible construir combinaciones de llaves y cerrojos incorrectas si haces bifurcaciones y puede que el jugador gaste las llaves en una ruta que no tenías planeada y luego no pueda seguir avanzando.

Para colocar el hotspot de la pantalla actual, simplemente hacemos click con el botón derecho en la casilla donde queremos que aparezca la llave o el objeto, con lo que haremos aparecer un pequeño cuadro de diálogo donde deberemos introducir el tipo. En esta captura estoy colocando una de las llaves de Lala Prologue.



Con mucha paciencia iremos pantalla por pantalla colocando el hotspot, indicando el valor 1 en los sitios donde deba salir un objeto (las cajas en Dogmole) y el valor 2 en los sitios donde debería salir una llave.

Generando el código

Una vez que hayamos terminado de colocarlo todo, como dijimos antes, tendremos que generar el código que necesita **MTE MK1**. ¿recordáis la super tabla de valores que os mencionamos al principio del capítulo? Pues eso. Cuando hayas terminado, pues, pulsa E y graba el código como enems.h. Copia este archivo en /dev. Si te pica la curiosidad, puedes abrirlo en el editor de textos y ver la cantidad de números que te has ahorrado escribir.

¡Y hemos terminado!

Además, con más emoción: en el próximo número vamos a compilar por primera vez nuestro güego, aunque sea sin scripting, para ver cómo va quedando.

The Mojon Twins