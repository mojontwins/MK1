# Capítulo 8: empezando con el _scripting_

Antes que nada, bájate el paquete de materiales correspondiente a este capítulo pulsando en este enlace:

[Material del capítulo 8](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-zip/churreratut-capitulo8.zip)

## ¡Hombre, por fin!

Sí, ya. Pero ahora te vas a cagar. Porque esto puede ser tan denso y chungo como tú quieras. Nah, en serio, no es nada. Vamos a hacerlo además con vaselina. En este primer capítulo explicaremos cómo está montado el sistema, para que entiendas qué hace, para qué sirve, y cómo funciona, y terminaremos viendo ejemplos súper sencillos de nivel 1, fácil fácil. El siguiente capítulo terminaremos de hacer el _script_ de Dogmole Tuppowski y, a partir de ahí, exploraremos, parte por parte, lo que se puede hacer con el _script_. Porque se puede hacer mucho y variado.

## ¡Vamos a ello, pues!

Vale. ¿Qué es un _script_ de *MTE MK1*? Pues no es más que un conjunto de comprobaciones con acciones asociadas, organizadas en secciones, que sirven para definir el _gameplay_ de tu güego. O sea, las cosas que pasan, y las cosas que tienen que pasar para que todo vaya guay, o para que todo vaya mal.

A ver, sin _script_ tienes un _gameplay_ básico. Coger X objetos para terminar, matar X bichos... Ir más allá de eso precisa comprobaciones y acciones relacionadas: si estamos en tal sitio y hemos hecho tal cosa, abrir la puerta del castillo. Si entramos en la pantalla tal y hablamos con el personaje cual, que salga el texto “OLA K ASE” y suene un ruidito. A eso nos referimos.

El _script_ te sirve desde para colocar un tile bonito en la pantalla 4 y un texto que ponga “ESTÁS EN TU CASA” hasta para reaccionar a lo que hagas en una pantalla, comprobar que has hecho otras cosas, ver que has empujado tal tile, y entonces encender el temporizador o cambiar el escenario o lo que sea.

En cuanto sepas las herramientas de las que dispones seguro que se te ocurren mil cosas que hacer. Muchas veces descubrimos aplicaciones que ni siquiera sabíamos que eran posibles cuando nos pusimos a diseñar el sistema, así que ya ves.

¡Esto es lo realmente divertido!

## Pero es programar.

Claro, cojones, pero una cosa es tener que programar un _gameplay_ en C y meterlo en el motor y otra cosa es tener un lenguaje específicamente diseñado para describir un _gameplay_ y que es tan sencillo de aprender y dominar. Porque estoy seguro de que a muchos o va a sonar cómo está montado esto, sobre todo si algún día habéis hecho una aventura con el PAWS o el GAC o habéis trasteado con algún game maker. Porque a los Mojones nos encanta eso de reinventar ruedas, y resulta que el súper sistema que ideamos es el más usado para estos menesteres de todos cuantos existen. Ya lo verás.

## Vale, cuéntame cómo va eso.

De acuerdo. A ver si lo puedo decir de un tirón, y luego ya lo vamos desglosando: un _script_ se compone de secciones. Cada sección no es más que un conjunto de cláusulas. Cada cláusula está formada por una lista de comprobaciones y una lista de comandos. Si se cumplen todas y cada una de las comprobaciones de la lista, se ejecutarán, en orden, todos y cada uno de los comandos. El motor del güego llamará al motor de _scripting_ en determinadas ocasiones, ejecutando una de esas secciones. Ejecutar una sección significa ir cláusula por cláusula haciendo las comprobaciones de su lista de comprobaciones y, si se cumplen, ejecutar en orden los comandos de su lista de comandos. Ese es el concepto importante que hay que tener claro.

Para saber en qué momentos el motor del güego llama al motor de _scripting_, tenemos que entender qué son las secciones y qué tipos de sección hay:

1. `ENTERING SCREEN n`: con `n` siendo un número de pantalla, se ejecutan justo al entrar en una nueva pantalla, una vez dibujado el escenario, inicializados los enemigos, y colocados los hotspots. Las podemos utilizar para modificar el escenario o inicializar variables. Por ejemplo, asociada a la pantalla 3, podemos colocar un _script_ que compruebe si hemos matado a todos los enemigos y, si no, que pinte un obstáculo para que no podamos pasar.

2. `ENTERING ANY`: es una sección especial que se ejecuta para TODAS las pantallas, justo antes de `ENTERING SCREEN n`. O sea, cuando tú entras en la pantalla 3, se ejecutará primero la sección `ENTERING ANY` (si existe en el _script_), y justo después se ejecutará la sección `ENTERING SCREEN 3` (si existe en el _script_).

3. `ENTERING GAME`: se ejecuta una sola vez al empezar el juego. Es lo primero que se ejecuta. Lo puedes usar para inicializar el valor de variables, por ejemplo. Ya veremos esto luego.

4. `PRESS_FIRE AT SCREEN n`: con `n` siendo un número de pantalla, se ejecuta en varios supuestos estando en la pantalla `n`: si el jugador pulsa el botón de acción, al empujar un bloque si hemos activado la directiva `PUSHING_ACTION`, o al entrar en una zona especial definida desde _scripting_ llamada “fire zone” (que ya explicaremos) si hemos activado la directiva `ENABLE_FIRE_ZONE`. Normalmente usaremos estas secciones para reaccionar a las acciones del jugador.

5. `PRESS_FIRE AT ANY`: se ejecuta en todos los supuestos anteriores, para cualquier pantalla, justo antes de `PRESS_FIRE AT SCREEN n`. O sea, si pulsamos acción en la pantalla 7, se ejecutarán las cláusulas de `PRESS_FIRE AT ANY` y luego las de `PRESS_FIRE AT SCREEN 7`.

6. `ON_TIMER_OFF`: se ejecuta cuando el temporizador llegue a cero, si tenemos activado el temporizador y hemos configurado que ocurra esto con la directiva `TIMER_SCRIPT_0`.

7. `PLAYER_KILLS_ENEMY`: Se ejecuta cuando matamos a un malo.

Por cierto, que no es obligatorio escribir todas las secciones posibles. El motor ejecutará una sección sólo si existe. Por ejemplo, si no hay nada que hacer en la pantalla 8, pues no habrá que escribir ninguna sección para la pantalla 8. Si no hay ninguna acción común al entrar en todas las pantallas, no habrá sección `ENTERING ANY`. Y así. Si no hay nada que ejecutar, el motor no ejecuta nada y ya.

A ver, recapitulemos: ¿para qué tanto pifostio de secciones y cacafuti? Muy sencillo: por un lado porque, por lo general, las comprobaciones y acciones serán específicas de una pantalla. Esto es de cajón. Pero lo más importante es que estamos en un micro de 8 bits y no nos podemos permitir estar continuamente haciendo todas las comprobaciones. No tenemos tiempo de _frame_, por lo que hay que dejarlas para momentos aislados: nadie se va a coscar si se tardan unos milisegundos más al cambiar de pantalla o si la acción se detiene brevemente al pulsar la tecla de acción.

## Guardando valores: las flags

Antes de que podamos seguir, tenemos que explicar otro concepto más: **las flags**, que no son más que **variables** donde podemos almacenar valores que posteriormente podremos consultar o modificar desde el _script_, y que además **nos sirven en algunos casos para comunicarnos con el motor**, como habrás podido discernir si te empapaste bien del capítulo anterior.

Muchas veces necesitaremos recordar que hemos hecho algo, o contabilizar cosas. Para ello tendremos que almacenar valores, y para ello tenemos las flags. En principio, tenemos 32 flags, numeradas del 0 al 31, aunque este número puede modificarse fácilmente cambiando el valor de `MAX_FLAGS` en `my/config.h`.

Cada flag puede almacenar **un valor de 0 a 127**, lo cual nos da de sobra para un montón de cosas. La mayoría del tiempo sólo estaremos almacenando un valor booleano (0 o 1).

## Valores numéricos y flags

En el _script_, la mayoría de las comprobaciones y comandos toman valores numéricos. Por ejemplo, `IF PLAYER_TOUCHES 4, 5` evaluará a “cierto” si el jugador está tocando la casilla de coordenadas (4, 5). Si anteponemos un # al número, estaremos **referenciando el valor de la flag correspondiente**, de forma que `IF PLAYER_TOUCHES #4, #5` evaluará a “cierto” si el jugador está tocando la casilla de coordenadas almacenadas en las flags 4 y 5, sea cual sea este valor.

Este nivel de indirección (apréndete esa palabra para decirla en la discoteca: las nenas caen fulminadas ante los programadores que conocen este concepto) es realmente útil porque así podrás ahorrar mucho código. Por ejemplo, es lo que permite, en **Cadàveriön**, que el control del número de estatuas colocadas o de eliminar la cancela que bloquea la salida de cada pantalla puedan hacerse desde una única sección común: todas las coordenadas están almacenadas en flags y usamos el operador # para acceder a sus valores en las comprobaciones.

## Afúf.

¿Mucha información? Soy consciente de ello. Pero en cuanto lo veas en movimiento seguro que lo pillas del tirón. Vamos a empezar con los ejemplos más sencillos de _scripting_ viendo algunas de las secciones que necesitamos para nuestro **Dogmole**, que iremos construyendo poco a poco. En esto dedicaremos este capítulo y el siguiente. Luego le llegará el turno a **el manual de MSC3**, donde es explica **todo** lo que puedes hacer con el _script_ de una forma más directa.

## ¿Cómo activo el _scripting_? ¿Dónde se meten los comandos?

Para activar el _scripting_ tendremos activarlo y configurarlo en `my/config.h`. Recordemos que las directivas relacionadas con la activación y configuración del _scripting_ son éstas:

```c
    #define ACTIVATE_SCRIPTING                  // Activates msc scripting and flag related stuff.
    #define MAX_FLAGS                   32
    #define SCRIPTING_DOWN                      // Use DOWN as the action key.
    //#define SCRIPTING_KEY_M                   // Use M as the action key instead.
    //#define SCRIPTING_KEY_FIRE                // User FIRE as the action key instead.
    //#define ENABLE_EXTERN_CODE                // Enables custom code to be run from the script using EXTERN n
    //#define ENABLE_FIRE_ZONE                  // Allows to define a zone which auto-triggers "FIRE"
```

La primera directiva, `ACTIVATE_SCRIPTING`, es la que activará el motor de _scripting_, y añadirá el código necesario para que se ejecute la sección correcta del _script_ en el momento preciso. Como hemos mencionado, `MAX_FLAGS` controla el número de flags disponible.

De las tres siguientes, tendremos que activar sólo una, y sirven para configurar qué tecla será la tecla de acción, la que lance los _scripts_ `PRESS_FIRE AT ANY` y `PRESS_FIRE AT SCREEN n`, o sea, **la tecla de acción**. La primera, `SCRIPTING_DOWN`, configura la tecla “abajo”. Esta es perfecta para güegos de perspectiva lateral, ya que esta tecla no se usa para nada más. La segunda, `SCRIPTING_KEY_M` habilita la tecla “M” para lanzar el _script_. La tercera, `SCRIPTING_KEY_FIRE`, configura la tecla de disparo (o el botón del joystick) para tal menester. Obviamente, si tu juego incluye disparos, no puedes usar esta configuración. Bueno, sí puedes, pero allá tú.

La siguiente directiva, `ENABLE_EXTERN_CODE`, sirve para ejecutar código C que escribas tú desde el _script_. Hay un comando de _script_ especial, `EXTERN n`, donde `n` es un número de 0 a 255, que lo que hace es llamar a una función de C situada en el archivo `my/extern.h` pasándole ese número. En esta función puedes añadir el código C que te dé la gana y que necesites para hacer cosas divertidas. Si no vas a necesitar programar tus propios comportamientos en C, déjala desactivada y ahorra unos bytes.

Por último, `ENABLE_FIRE_ZONE` sirve para que podamos definir un rectángulo especial dentro del área de juego de la pantalla en curso. Normalmente, usaremos en `ENTERING SCREEN n` para definir el rectángulo usando el comando `SET_FIRE_ZONE x1, y1, x2, y2` (en píxeles) o `SET_FIRE_ZONE_TILES x1, y1, x2, y2` (en coordenadas de tiles, más fáciles de manejar). Cuando el jugador esté dentro de este rectángulo especial, se ejecutarán los _scripts_ `PRESS_FIRE AT ANY` y `PRESS_FIRE AT SCREEN n` de la pantalla actual. Esto viene realmente bien para poder ejecutar acciones sin que el jugador tenga que pulsar la tecla de acción. Es lo que usamos en **Sgt. Helmet** para poner las bombas en la pantalla final o mostrar el mensaje `VENDO MOTO SEMINUEVA`. Si crees que vas a necesitar esto, activa esta directiva. Si no, déjala sin activar y ahorra unos bytes. No te preocupes, que ya explicaremos esto más despacio.

### El compilador de scripts `msc3_mk1`

Lo siguiente que hay que hacer es modificar levemente una línea de `compile.bat`, ya que el compilador de _scripts_, `msc3_mk1`, **necesita saber el número de pantallas que hay en tu mapa**, esto es, **el valor de `MAP_W * MAP_H`**. En el caso de **Dogmole**, que tenemos un mapa de 8x3 pantallas, este valor será **24**.

`msc3_mk1`, el compilador de _scripts_, recibe los siguientes parámetros, que nos chiva el propio programa al ejecutarlo desde la ventana de línea de comandos:

```
    $ ..\utils\msc3_mk1.exe
    MojonTwins Scripts Compiler v3.97 20191202
    MT Engine MK1 v5.00+

    usage: msc3_mk1 input n_rooms [rampage]

    input   - script file
    n_pants - # of screens
    rampage - If included, generate code to read script from ram N
```

Vemos que necesita saber el archivo de entrada que contiene el _script_ (incluyendo la ruta si es necesaria), el número total de habitaciones, y que luego admite un parámetro opcional "rampage" que sirve para generar _scripts_ que puedan almacenarse en la RAM extra de los Spectrum de 128K y que por ahora obviaremos.

Examinemos pues la línea que nos interesa en `compile.bat`. La encontrarás justo al principio. La ajustamos con el número correcto de pantallas para **Dogmole**, que es 24:

```
    ..\utils\msc3_mk1.exe %game%.spt 24
```

Que el archivo de entrada esté referenciado com %game%.spt significa que tienes que llamarlo justo así: con el identificador que has puesto al principio de este archivo en la línea `set game=dogmole`, o sea, `dogmole.spt`. El archivo deberá estar en `/script`.

Puedes crear un archivo `dogmole.spt` vacío o **renombrar** el archivo base que hay, `script.spt`. Hagamos esto último. Le cambiamos el nombre a `script.spt` por `dogmole.spt`. Si lo abres verás este sencillo _script_ mínimo.

```
    # Script mínimo que no hace nada
    # MTE MK1 v5.0

    # flags:
    # 1 -

    ENTERING GAME
        IF TRUE
        THEN
            SET FLAG 1 = 0
        END
    END
```

Es aquí donde vamos a escribir nuestro _script_. Fíjate el aspecto que tiene: eso que hay ahí es la sección `ENTERING GAME`, que se ejecuta nada más empezar la partida. Dentro de esta sección hay una única cláusula. Esta cláusula sólo tiene una comprobación: `IF TRUE`, que siempre será cierto. Luego hay un `THEN` y justo ahí, y hasta el `END`, empieza la **lista de comandos**. En este caso hay un único comando: `SET FLAG 1 = 0`, que sencillamente pone la flag 1 a 0.

Este _script_ no sirve absolutamente para nada. Además de no hacer nada, resulta que el sistema pone todas las flags a 0 al principio, así que no hace falta inicializarlas a cero. ¿Por qué está ahí? No sé, joder, para que hubiera algo. De hecho, lo primero que vas a hacer es BORRARLO.

Es interesante modificar esa cabecera. Las líneas que empiezan por # (no tiene por qué ser #, puedes usar ;, por ejemplo, o ', o //, o lo que quieras) son comentarios. Acostúmbrate de poner los comentarios en su propia línea. No pongas comentarios al final de una comprobación o un comando, que el compilador es vago y puede interpretar lo que no es. Y, sobre todo, acostúmbrate a poner comentarios. Así podrás entender qué leches hiciste hace tres días, antes de la borrachera y ese affair con el moreno de recepción.

Como por ahora las variables (flags) se identifican con un número (a partir de cierta versión también se pudo empezar a definir aliases, que asignan un identificador a una flag, pero eso lo dejaremos para más adelante) es buena idea hacerse una lista de qué hace cada una para luego no liarnos. Yo siempre lo hago, mira:

```
    # Cadàveriön
    # Copyleft 2013 Mojon Twins
    # Churrera 3.99.2
    # flags:
    # 1 – Tile pisado por el bloque que se empuja
    # 2, 3 – coordenadas X e Y
    # 4, 5 – coordenadas X e Y del tile «retry»
    # 6, 7 – coordenadas X e Y del tile puerta
    # 8 – número de pantallas finalizadas
    # 9 – número de estatuas que hay que colocar
    # 10 – número de estatuas colocadas
    # 11 – Ya hemos quitado la cancela
    # 12 – Pantalla a la que volvemos al agotarse el tiempo
    # 13, 14 – Coordenadas a las que volvemos… bla
    # 15 – Piso
    # 0 – valor de 8 almacenado
    # 16 – Vendo moto seminueva.
```

¿Ves? Eso viene genial para saber dónde tienes que tocar.

## Tus primeras cláusulas chispas

Ya que sabemos dónde tocar, vamos a empezar con nuestro _script_. Veamos la sintaxis básica. Esto de aquí es la pinta que tiene un _script_:

```
    SECCION
        COMPROBACIONES
        THEN
            COMANDOS
        END
        …
    END
    …
```

Como vemos, cada sección empieza con el nombre de la sección y termina con `END`. Entre el nombre de la sección y el `END` están las cláusulas que la componen, que puede ser una, o pueden ser varias. Cada cláusula empieza con una lista de comprobaciones, cada una en una línea, la palabra `THEN`, seguida de una lista de comandos, cada uno en una línea, y la palabra `END`. Luego pueden venir más cláusulas.

Recuerda el funcionamiento: ejecutar una sección es ejecutar cada una de sus cláusulas, en orden, de arriba a abajo. Ejecutar una cláusula es realizar todas las comprobaciones de la lista de comprobaciones. Si no falla ninguna, o sea, **todas son ciertas**, se ejecutarán todos los comandos de la lista.

Para verlo, vamos a crear un _script_ sencillo que introduzca adornos en algunas pantallas. Vamos a extender el tileset de **Dogmole**, incluyendo nuevos tiles que no colocaremos desde el mapa (porque ya hemos usado los 16 que tenemos como máximo), sino que colocaremos desde el _script_. Este es nuestro nuevo tileset ampliado con adornos o, como los llamamos en el argot mojono, **decoraciones**:

![Tileset de Dogmole con decoraciones](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/08_tileset_dogmole_completo.png)

(La magia de esta versión de **MTE MK1** es que cuando cambias el tileset no tienes más que dejarlo en `gfx/work.png`; los usuarios del motor de toda la vida recordarán que antes había que hacerle encaje de bolillos, incluido un paso por el programa SevenuP. ¿Veis? Para hacer este tipo de cosas [utilizo todo el café](https://ko-fi.com/I2I0JUJ9) que me dais).

Ahí hay un montón de tiles decorativos que vamos a colocar desde el _scripting_. El sitio para hacerlo son las secciones `ENTERING SCREEN n` de las pantallas que queramos adornar, ya que se ejecutan cuando todo lo demás está en su sitio: el fondo ya estará dibujado, por lo que podremos pintar encima. Vamos a empezar decorando la pantalla número 0, que es donde hay que ir a llevar las cajas. Tendremos que colocar el pedestal, formado por los tiles 22 y 23, y además pondremos más adornos: unas vasijas (29), unas cuantas estanterías (20 y 21), unas cuantas cajas (27 y 28), una armadura (32 y 33) y una bombilla colgando de un cable (30 y 31). Empezamos creando la sección `ENTERING SCREEN 0` en nuestro script `dogmole.spt`:

```
    # Vestíbulo de la Universidad
    ENTERING SCREEN 0

    END
```

El pintado de los tiles extra se hace desde la lista de comandos de una cláusula. Como queremos que la cláusula se ejecute siempre, emplearemos la condición más sencilla que existe: la que siempre evalúa a cierto y ya vimos más arriba (como verás, utilizo tabulaciones para ayudarme a distinguir mejor la estructura del _script_. Esto se llama *indentar* y deberías hacerlo tú también. `msc3_mk1` ignora los espacios en blanco así que los usamos simplemente como guía visual humana):

```
    # Vestíbulo de la Universidad
    ENTERING SCREEN 0
        # Decoración y pedestal
        IF TRUE
        THEN

        END
    END
```

Esto significa que, siempre que entremos en la pantalla 0, se ejecutarán los comandos de la lista de comandos de esa cláusula, ya que su única condición SIEMPRE evalúa a cierto.

El comando para pintar un tile en la pantalla tiene esta forma:

```
    SET TILE (x, y) = t
```

Donde `(x, y)` es la coordenada (recuerda, tenemos 15×10 tiles en la pantalla, por lo que `x` podrá ir de 0 a 14 e `y` de 0 a 9) y `t` es el número del tile que queremos pintar. Es aquí donde Ponedor vuelve a ser muy útil: recuerda que si pasas el ratón por el área de edición **te va chivando las coordenadas de las casillas**. Así pues, con el Ponedor delante para chivar casillas y ver dónde tenemos que pintar las cosas, vamos colocando primero el pedestal y luego todas las decoraciones:

```
    # Vestíbulo de la Universidad
    ENTERING SCREEN 0
        # Decoración y pedestal
        IF TRUE
        THEN
            # Pedestal
            SET TILE (3, 7) = 22
            SET TILE (4, 7) = 23

            # Decoración
            SET TILE (1, 5) = 29
            SET TILE (1, 6) = 20
            SET TILE (1, 7) = 21
            SET TILE (6, 6) = 20
            SET TILE (6, 7) = 21
            SET TILE (7, 7) = 28
            SET TILE (1, 2) = 27
            SET TILE (1, 3) = 28
            SET TILE (2, 2) = 29
            SET TILE (2, 3) = 27
            SET TILE (3, 2) = 32
            SET TILE (3, 3) = 33
            SET TILE (9, 1) = 30
            SET TILE (9, 2) = 30
            SET TILE (9, 3) = 31
        END
    END
```

Vale, has escrito tu primera cláusula. No ha sido tan complicado ¿verdad? Supongo que para que la satisfacción sea completa querrás verlo. Bien: vamos a añadir un poco de código que luego eliminaremos de la versión definitiva y que usaremos para irnos a la pantalla que queramos al empezar el güego y probar así que lo estamos haciendo todo bien.

Si recuerdas, una de las posibles secciones que podemos añadir al _script_ es la que se ejecuta justo al principio del güego: `ENTERING GAME`, que es la que venía vacía al principio y hemos borrado porque no nos servía para nada. Bien, pues vamos a hacer una `ENTERING GAME` que nos servirá para irnos directamente a la pantalla 0 al principio y comprobar que hemos colocado guay todos los tiles en los comandos de la cláusula de la sección `ENTERING SCREEN 0`. Añadimos, por tanto, este código (puedes añadirlo donde quieras, pero yo suelo dejarlo al principio. Da igual donde lo pongas, pero siempre mola seguir un orden).

```
    ENTERING GAME
        IF TRUE
        THEN
            WARP_TO 0, 12, 2
        END
    END
```

¿Qué hace esto? Pues hará que, al empezar el juego, se ejecute esa lista de cláusulas formada por una única cláusula, que siempre se ejecutará (porque tiene IF TRUE) y que lo que hace es trasladarnos a la coordenada (12, 2) de la pantalla 0, porque eso es lo que hace el comando WARP:

`WARP_TO n, x, y` Nos traslada a la pantalla n, y nos hace aparecer en las coordenadas (x, y).

Cuando el jugador empiece la partida se ejecutará la sección `ENTERING GAME`. Esta sección lo único que hace es trasladar al jugador a la posición (12, 2) y cambiar a la pantalla 0. Entonces, al entrar en la pantalla 0, se ejecutará la sección `ENTERING SCREEN 0`, que nos pintará los tiles extra. ¡Vamos a probarlo! Compila el güego y ejecútalo. Si todo va bien, deberíamos aparecer en nuestra pantalla 0 decorada:

![Pantalla 0 de Dogmole con decoraciones](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/08_dogmole_screen0_decos.png)

¡Hala! Jodó, qué bien. Más, más. Vamos a pintar más tiles para decorar otras pantallas. Exactamente de la misma forma que hemos decorado la pantalla 0, vamos a decorar también la pantalla 1, colocando el cartel de la Universidad de Miskatonic (tiles 24, 25, y 26) y unas armaduras (tiles 32 y 33):

```
    # Pasillo de la Universidad
    ENTERING SCREEN 1
        # Cartel de miskatonic, etc.
        IF TRUE
        THEN
            SET TILE (7, 2) = 24
            SET TILE (8, 2) = 25
            SET TILE (9, 2) = 26
            SET TILE (1, 6) = 32
            SET TILE (1, 7) = 33
            SET TILE (13, 6) = 32
            SET TILE (13, 7) = 33
        END
    END
```

¡Vamos a verlo! Cambia `ENTERING_GAME` para saltar a la pantalla 1 en vez de la pantalla 0:

```
    ENTERING GAME
        IF TRUE
            THEN
            WARP_TO 1, 12, 2
        END
    END
```

Compila, ejecuta… et voilà!


![Pantalla 1 de Dogmole con decoraciones](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/08_dogmole_screen1_decos.png)

De la misma manera añadimos código para poner más decoraciones en el mapa. La verdad es que nos aburrimos pronto y sólo hay mandanga en la pantalla 6 (una lámpara) y la pantalla 18 (un ancla en la playa). ¿Por qué no aprovechas tú y pones más? Estas son las que vienen en el juego original:

```
    ENTERING SCREEN 6
        IF TRUE
        THEN
            SET TILE (10, 1) = 30
            SET TILE (10, 2) = 31
            SET TILE (10, 4) = 35
            END
            END
            ENTERING SCREEN 18
            IF TRUE
            THEN
            SET TILE (4, 8) = 34
        END
    END
```

## Decoraciones más mejor (y menos peor)

Cuando tienes que pintar más de tres tiles tenemos un atajo que hace que el _script_ sea más rápido de escribir y que además ocupe menos bytes. Se trata de emplear el comando `DECORATIONS`, al que deberá seguir una lista de posiciones de tile y números de tile, uno por línea, terminados con un `END`. De este modo, el _script_ que habíamos introducido para las pantallas 0 y 1 se convierte en:

```
    # Vestíbulo de la Universidad
    ENTERING SCREEN 0
        # Decoración y pedestal
        IF TRUE
        THEN
            DECORATIONS
                # Pedestal
                3, 7, 22
                4, 7, 23

                # Decoración
                1, 5, 29
                1, 6, 20
                1, 7, 21
                6, 6, 20
                6, 7, 21
                7, 7, 28
                1, 2, 27
                1, 3, 28
                2, 2, 29
                2, 3, 27
                3, 2, 32
                3, 3, 33
                9, 1, 30
                9, 2, 30
                9, 3, 31
        END
    END

    # Pasillo de la Universidad
    ENTERING SCREEN 1
        # Cartel de miskatonic, etc.
        IF TRUE
        THEN
            DECORATIONS
                7, 2, 24
                8, 2, 25
                9, 2, 26
                1, 6, 32
                1, 7, 33
                13, 6, 32
                13, 7, 33
            END
        END
    END
```

Semánticamente esto es equivalente 100% a lo que habíamos escrito, pero hace que el _script_ ocupe menos y se ejecute más rápido, ya que al entrar en "modo ristra de impresiones de tiles" el intérprete tiene que hacer menos trabajo. Y es una de las cosas nuevas de msc3 que hemos inyectado directamente de MK2 para la v5 de MK1.

## Creo que lo voy pillando

Pues es el momento para dejarlo. Intenta absorber bien estos conocimientos, empápatelos bien. Si no has pillado algo de aquí, no tengas prisa y espérate a que sigamos, que seguramente lo terminarás entendiendo. Y, como siempre, lo que quieras preguntar, ¡pregúntalo!

En el siguiente capítulo meteremos la chicha del _gameplay_: detectaremos que se han muerto todos los hechiceros para quitar el piedro de la entrada de la Universidad, y programaremos la lógica para ir dejando las cajas en el vestíbulo.

Hasta entonces, cacharrea con esto. En el archivo con el material de este capítulo tienes el _script_ de **Dogmole** a medio hacer con las cosas que hemos visto en este capítulo y el `work.png` con el tileset completo.
