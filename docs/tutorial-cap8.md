# Capítulo 8: empezando con el scripting

Antes que nada, bájate el paquete de materiales correspondiente a este capítulo pulsando en este enlace:

http://www.mojontwins.com/churrera/churreratut-capitulo8.zip

¡Hombre, por fin!

Sí, ya. Pero ahora te vas a cagar. Porque esto puede ser tan denso y chungo como tú quieras. Nah, en serio, no es nada. Vamos a hacerlo además con vaselina. En este primer capítulo explicaremos cómo está montado el sistema, para que entiendas qué hace, para qué sirve, y cómo funciona, y terminaremos viendo ejemplos super sencillos de nivel 1, fácil fácil. El siguiente capítulo terminaremos de hacer el script de Dogmole Tuppowski y, a partir de ahí, exploraremos, parte por parte, lo que se puede hacer con el script. Porque se puede hacer mucho y variado.

¡Vamos a ello, pues!

Vale. ¿Qué es un script de la churrera? Pues no es más que un conjunto de comprobaciones con acciones asociadas, organizadas en secciones, que sirven para definir el gameplay de tu güego. O sea, las cosas que pasan, y las cosas que tienen que pasar para que todo vaya guay, o para que todo vaya mal.

A ver, sin script tienes un gameplay básico. Coger X objetos para terminar, matar X bichos… Ir más allá de eso precisa comprobaciones y acciones relacionadas: si estamos en tal sitio y hemos hecho tal cosa, abrir la puerta del castillo. Si entramos en la pantalla tal y hablamos con el personaje cual, que salga el texto “OLA K ASE” y suene un ruidito. A eso nos referimos.

El script te sirve desde para colocar un tile bonito en la pantalla 4 y un texto que ponga “ESTÁS EN TU CASA” hasta para reaccionar a lo que hagas en una pantalla, comprobar que has hecho otras cosas, ver que has empujado tal tile, y entonces encender el temporizador o cambiar el escenario o lo que sea.

En cuanto sepas las herramientas de las que dispones seguro que se te ocurren mil cosas que hacer. Muchas veces descubrimos aplicaciones que ni siquiera sabíamos que eran posibles cuando nos pusimos a diseñar el sistema, así que ya ves.

¡Esto es lo realmente divertido!

Pero es programar.

Claro, cojones, pero una cosa es tener que programar un gameplay en C y meterlo en el motor y otra cosa es tener un lenguaje específicamente diseñado para describir un gameplay y que es tan sencillo de aprender y dominar. Porque estoy seguro de que a muchos o va a sonar cómo está montado esto, sobre todo si algún día habéis hecho una aventura con el PAWS o el GAC o habéis trasteado con algún game maker. Porque a los Mojones nos encanta eso de reinventar ruedas, y resulta que el super sistema que ideamos es el más usado para estos menesteres de todos cuantos existen. Ya lo verás.

Vale, cuéntame como va eso.

De acuerdo. A ver si lo puedo decir de un tirón, y luego ya lo vamos desglosando: un script se compone de secciones. Cada sección no es más que un conjunto de cláusulas. Cada cláusula está formada por una lista de comprobaciones y una lista de comandos. Si se cumplen todas y cada una de las comprobaciones de la lista, se ejecutarán, en orden, todos y cada uno de los comandos. El motor del güego llamará al motor de scripting en determinadas ocasiones, ejecutando una de esas secciones. Ejecutar una sección significa ir cláusula por cláusula haciendo las comprobaciones de su lista de comprobaciones y, si se cumplen, ejecutar en orden los comandos de su lista de comandos. Ese es el concepto importante que hay que tener claro.

Para saber en qué momentos el motor del güego llama al motor de scripting, tenemos que entender qué son las secciones y qué tipos de sección hay:

ENTERING SCREEN n: con n siendo un número de pantalla, se ejecutan justo al entrar en una nueva pantalla, una vez dibujado el escenario, inicializados los enemigos, y colocados los hotspots. Las podemos utilizar para modificar el escenario o inicializar variables. Por ejemplo, asociada a la pantalla 3, podemos colocar un script que compruebe si hemos matado a todos los enemigos y, si no, que pinte un obstáculo para que no podamos pasar.

ENTERING ANY: se ejecutan para TODAS las pantallas, justo antes de ENTERING SCREEN n. O sea, cuando tú entras en la pantalla 3, se ejecutará primero la sección ENTERING ANY (si existe en el script), y justo después se ejecutará la sección ENTERING SCREEN 3 (si existe en el script).

ENTERING GAME: se ejecuta una sola vez al empezar el juego. Es lo primero que se ejecuta. Lo puedes usar para inicializar el valor de variables, por ejemplo. Ya veremos esto luego.

PRESS_FIRE AT SCREEN n: con n siendo un número de pantalla, se ejecuta en varios supuestos estando en la pantalla n: si el jugador pulsa el botón de acción, al empujar un bloque si hemos activado la directiva PUSHING_ACTION, o al entrar en una zona especial definida desde scripting llamada “fire zone” (que ya explicaremos) si hemos activado la directiva ENABLE_FIRE_ZONE. Normalmente usaremos estas secciones para reaccionar a las acciones del jugador.

PRESS_FIRE AT ANY: se ejecuta en todos los supuestos anteriores, para cualquier pantalla, justo antes de PRESS_FIRE AT SCREEN n. O sea, si pulsamos acción en la pantalla 7, se ejecutarán las cláusulas de PRESS_FIRE AT ANY y luego las de PRESS_FIRE AT SCREEN 7.

ON_TIMER_OFF: se ejecuta cuando el temporizador llegue a cero, si tenemos activado el temporizador y hemos configurado que ocurra esto con la directiva TIMER_SCRIPT_0.

Para la versión 3.99.2 estas son las secciones posibles, aunque añadiremos más en futuras versiones. Por ejemplo, al eliminar un enemigo. Pero por ahora no.

Por cierto, que no es obligatorio escribir todas las secciones posibles. El motor ejecutará una sección sólo si existe. Por ejemplo, si no hay nada que hacer en la pantalla 8, pues no habrá que escribir ninguna sección para la pantalla 8. Si no hay ninguna acción común al entrar en todas las pantallas, no habrá sección ENTERING ANY. Y así. Si no hay nada que ejecutar, el motor no ejecuta nada y ya.

A ver, recapitulemos: ¿para qué tanto pifostio de secciones y cacafuti? Muy sencillo: por un lado porque, por lo general, las comprobaciones y acciones serán específicas de una pantalla. Esto es de cajón. Pero lo más importante es que estamos en un micro de 8 bits y no nos podemos permitir estar continuamente haciendo todas las comprobaciones. No tenemos tiempo de frame, por lo que hay que dejarlas para momentos aislados: nadie se va a coscar si se tardan unos milisegundos más al cambiar de pantalla o si la acción se detiene brevemente al pulsar la tecla de acción.

Guardando valores: las flags

Antes de que podamos seguir, tenemos que explicar otro concepto más: los flags, que no son más que variables donde podemos almacenar valores que posteriormente podremos consultar o modificar desde el script.

Muchas veces necesitaremos recordar que hemos hecho algo, o contabilizar cosas. Para ello tendremos que almacenar valores, y para ello tenemos las flags. En principio, tenemos 16 flags, numeradas del 0 a al 15, aunque este número puede modificarse fácilmente cambiando una definición de definitions.h (busca #define MAX_FLAGS y cambia el 16 por otro número).
Cada flag puede almacenar un valor de 0 a 255, lo cual nos da de sobra para un montón de cosas. La mayoría del tiempo sólo estaremos almacenando un valor booleano (0 o 1).

En el script, la mayoría de las comprobaciones y comandos toman valores numéricos. Por ejemplo, IF PLAYER_TOUCHES 4, 5 evaluará a “cierto” si el jugador está tocando la casilla de coordenadas (4, 5). Si anteponemos un # al número, estaremos referenciando el valor del flag correspondiente, de forma que IF PLAYER_TOUCHES #4, #5 evaluará a “cierto” si el jugador está tocando la casilla de coordenadas almacenadas en los flags 4 y 5, sea cual sea este valor.

Este nivel de indirección (apréndete esa palabra para decirla en la discoteca: las nenas caen fulminadas ante los programadores que conocen este concepto) es realmente util porque así podrás ahorrar mucho código. Por ejemplo, es lo que permite, en Cadàveriön, que el control del número de estatuas colocadas o de eliminar la cancela que bloquea la salida de cada pantalla puedan hacerse desde una única sección común: todas las coordenadas están almacenadas en flags y usamos el operador # para acceder a sus valores en las comprobaciones.

Pero no te preocupes si no pillas esto ahora, que ya se irá aclarando todo.

Afúf.

¿Mucha información? Soy consciente de ello. Pero en cuanto lo veas en movimiento seguro que lo pillas del tirón. Vamos a empezar con los ejemplos más sencillos de scripting viendo algunas de las secciones que necesitamos para nuestro Dogmole, que iremos construyendo poco a poco. En esto dedicaremos este capítulo y el siguiente. Luego iremos explicando, de forma temática, todas las posibles comprobaciones y comandos que podemos usar.

¿Cómo activo el scripting? ¿Dónde se introduce?

Para activar el scripting tendremos que hacer dos cosas: primero activarlo y configurarlo en config.h, y luego modificar nuestro make.bat para incluirlo en el proyecto. Empecemos por config.h. Las directivas relacionadas con la activación y configuración del scripting son estas:

#define ACTIVATE_SCRIPTING // Activates msc scripting and flag related stuff.
#define SCRIPTING_DOWN // Use DOWN as the action key.
//#define SCRIPTING_KEY_M // Use M as the action key instead.
//#define SCRIPTING_KEY_FIRE // User FIRE as the action key instead.
//#define ENABLE_EXTERN_CODE // Enables custom code to be run using EXTERN n
//#define ENABLE_FIRE_ZONE // Allows to define a zone which auto-triggers «FIRE»
La primera directiva, ACTIVATE_SCRIPTING, es la que activará el motor de scripting, y añadirá el código necesario para que se ejecute la sección correcta del script en el momento preciso. Es la que tenemos que activar sí o sí.

De las tres siguientes, tendremos que activar solo una, y sirven para configurar qué tecla será la tecla de acción, la que lance los scripts PRESS_FIRE AT ANY y PRESS_FIRE AT SCREEN n. La primera, SCRIPTING_DOWN, configura la tecla “abajo”. Esta es perfecta para güegos de perspectiva lateral, ya que esta tecla no se usa para nada más. La segunda, SCRIPTING_KEY_M habilita la tecla “M” para lanzar el script. La tercera, SCRIPTING_KEY_FIRE, configura la tecla de disparo (o el botón del joystick) para tal menester. Obviamente, si tu juego incluye disparos, no puedes usar esta configuración. Bueno, si puedes, pero allá tú.

La siguiente directiva, ENABLE_EXTERN_CODE, la dejarás normalmente desactivada a menos que seas un maestro churrero. Hay un comando de script especial, EXTERN n, donde n es un número, que lo que hace es llamar a una función de C situada en el archivo extern.h pasándole ese número. En esta función puedes añadir el código C que te de la gana y que necesites para hacer cosas divertidas. Por ejemplo, D_Skywalk lo ha usado en Justin and the Lost Abbey para añadir el código que va pintando los trozos de la espada que hemos recogido en el marcador. Si no vas a necesitar programar tus propios comportamientos en C, déjala desactivada y ahorra unos bytes.

Por último, ENABLE_FIRE_ZONE sirve para que podamos definir un rectángulo especial dentro del area de juego de la pantalla en curso. Normalmente, usaremos en ENTERING SCREEN n para definir el rectángulo usando el comando SET_FIRE_ZONE x1, y1, x2, y2. Cuando el jugador esté dentro de este rectángulo especial, se ejecutarán los scripts PRESS_FIRE AT ANY y PRESS_FIRE AT SCREEN n de la pantalla actual. Esto viene realmente bien para poder ejecutar acciones sin que el jugador tenga que pulsar la tecla de acción. Es lo que usamos en Sgt. Helmet para poner las bombas en la pantalla final o mostrar el mensaje “VENDO MOTO SEMINUEVA”. Si crees que vas a necesitar esto, activa esta directiva. Si no, déjala sin activar y ahorra unos bytes. No te preocupes que ya explicaremos esto más despacio.
Lo siguiente es configurar bien make.bat, activando la compilación e inclusión del script. Si abres make.bat y te fijas, verás que al principio hay una llamada a msc. Este es el compilador de scripts, que recibe el nombre del archivo de script, el nombre de salida (que será msc.h) y el número de pantallas total de tu juego:

echo ### COMPILANDO SCRIPT ###
cd ..script
msc cadaver.spt msc.h 20
copy *.h ..dev
El nombre de tu script será el nombre de tu juego con un .spt como extensión. El archivo se ubica en script. Si entras en script verás un churromain.spt. Cambiale el nombre para que coincida con el nombre de tu juego (el mismo de tu archivo .c de dev). No te olvides del número de pantallas, que es muy importante. Si no lo pones bien el código del intérprete de scripts se generará mal. Para nuestro Dogmole, el archivo será devdogmole.spt, y en el make.bat tendremos que poner:

echo ### COMPILANDO SCRIPT ###
cd ..script
msc dogmole.spt msc.h 24
copy *.h ..dev
Porque nuestro Dogmole tiene 24 pantallas.
Si ahora vas a script y abres el archivo con el script (que antes se llamaba churromain.spt y has renombrado con el nombre de tu güego) verás que está vacío, o casi. Sólo trae un esqueleto de una sección. Tiene esta pinta:

# Título tonto
# Copyleft 201X tu grupo roneón soft.
# Churrera 3.1
# flags:
# 1 –

ENTERING GAME
IF TRUE
THEN
SET FLAG 1 = 0
END
END

Es aquí donde vamos a escribir nuestro script. Fíjate el aspecto que tiene: eso que hay ahí es la sección ENTERING GAME, que se ejecuta nada más empezar la partida. Dentro de esta sección hay una única cláusula. Esta cláusula sólo tiene una comprobación: IF TRUE, que siempre será cierto. Luego hay un THEN y justo ahí, y hasta el END, empieza la lista de comandos. En este caso hay un único comando: SET FLAG 1 = 0, que pone el flag 1 a 0.

Este script no sirve absolutamente para nada. Además de no hacer nada, resulta que el sistema pone todos los flags a 0 al principio, así que no hace falta inicializarlos a cero. ¿Por qué está ahí? No se, joder, para que hubiera algo. De hecho, lo primero que vas a hacer es BORRARLO.

Es interesante modificar esa cabecera. Las lineas que empiezan por # (no tiene por qué ser #, puedes usar ;, por ejemplo, o ', o //, o lo que quieras) son comentarios. Acostúmbrate de poner los comentarios en su propia linea. No pongas comentarios al final de una comprobación o un comando, que el compilador es vago y puede interpretar lo que no es. Y, sobre todo, acostúmbrate a poner comentarios. Así podrás entender qué leches hiciste hace tres días, antes de la borrachera y ese affair con la morena de recepción.

Como por ahora las variables (flags) se identifican con un número (tengo pendiente mejorar el compilador para poder definir alias, como bien sugirió D_Skywalk) es buena idea hacerse una lista de qué hace cada una para luego no liarnos. Yo siempre lo hago, mira:

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

¿Ves? Eso viene genial para saber dónde tienes que tocar.

Mis primeras cláusulas

Ya que sabemos dónde tocar, vamos a empezar con nuestro script. Veamos la sintaxis básica. Esto de aquí es la pinta que tiene un script:

SECCION
COMPROBACIONES
THEN
COMANDOS
END
…
END
…
Como vemos, cada sección empieza con el nombre de la sección y termina con END. Entre el nombre de la sección y el END están las cláusulas que la componen, que puede ser una, o pueden ser varias. Cada cláusula empieza con una lista de comprobaciones, cada una en una linea, la palabra THEN, una lista de comandos, cada uno en una linea, y la palabra END. Luego puede o no venir otra cláusula.

Recuerda el funcionamiento: ejecutar una sección es ejecutar cada una de sus cláusulas, en orden. Ejecutar una cláusula es realizar todas las comprobaciones de la lista de comprobaciones. Si no falla ninguna, o sea, todas son ciertas, se ejecutarán todos los comandos de la lista.

Para verlo, vamos a crear un script sencillo que introduzca adornos en algunas pantallas. Vamos a extender el tileset de Dogmole, incluyendo nuevos tiles que no colocaremos desde el mapa (porque ya hemos usado los 16 que tenemos como máximo), sino que colocaremos desde el script. Este es nuestro nuevo tileset ampliado:



(Ya sabes qué hacer: reordena, monta con la fuente, cárgalo en SevenuP, pásalo a código, y muevelo a /dev/tileset.h).

Ahí hay un montón de cosas que vamos a colocar desde el scripting. El sitio ideal para hacerlo son las secciones ENTERING SCREEN n de las pantallas que queramos adornar, ya que se ejecutan cuando todo lo demás está en su sitio: el fondo ya estará dibujado, por lo que podremos pintar encima. Vamos a empezar decorando la pantalla número 0, que es donde hay que ir a llevar las cajas. Tendremos que colocar el pedestal, formado por los tiles 22 y 23, y además pondremos más adornos: unas vasijas (29), unas cuantas estanterías (20 y 21), unas cuantas cajas (27 y 28), una armadura (32 y 33) y una bombilla colgando de un cable (30 y 31). Empezamos creando la sección ENTERING SCREEN 0 en nuestro scriptdogmole.spt:

# Vestíbulo de la universidad
ENTERING SCREEN 0
END

El pintado de los tiles extra se hace desde la lista de comandos de una cláusula. Como queremos que la cláusula se ejecute siempre, emplearemos la condición más sencilla que existe: la que siempre evalúa a cierto y ya vimos más arriba:

# Vestíbulo de la universidad
ENTERING SCREEN 0
# Decoración y pedestal
IF TRUE
THEN
END
END

Esto significa que siempre que entremos en la pantalla 0, se ejecutarán los comandos de la lista de comandos de esa cláusula, ya que su única condición SIEMPRE evalúa a cierto.

El comando para pintar un tile en la pantalla tiene esta forma:

SET TILE (x, y) = t
Donde (x, y) es la coordenada (recuerda, tenemos 15×10 tiles en la pantalla, por lo que x podrá ir de 0 a 14 e y de 0 a 9) y t es el número del tile que queremos pintar. Con el mapa abierto en mappy delante para contar casillas y ver donde tenemos que pintar las cosas, vamos colocando primero el pedestal y luego todas las decoraciones:

# Vestíbulo de la universidad
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
Vale, has escrito tu primera cláusula. No ha sido tan complicado ¿verdad?. Supongo que para que la satisfacción sea completa querrás verlo. Bien: vamos a añadir un poco de código que luego eliminaremos de la versión definitiva y que usaremos para irnos a la pantalla que queramos al empezar el güego y probar así que lo estamos haciendo todo bien.

Si recuerdas, una de las posibles secciones que podemos añadir al script es la que se ejecuta justo al principio del güego: ENTERING GAME, que es la que venía vacía al principio y hemos borrado porque no nos servía para nada. Bien, pues vamos a hacer una ENTERING GAME que nos servirá para irnos directamente a la pantalla 0 al principio y comprobar que hemos colocado guay todos los tiles en los comandos de la cláusula de la sección ENTERING SCREEN 0. Añadimos, por tanto, este código (puedes añadirlo donde quieras, pero yo suelo dejarlo al principio. Da igual donde lo pongas, pero siempre mola seguir un orden).

ENTERING GAME
IF TRUE
THEN
WARP_TO 0, 12, 2
END
END
¿Qué hace esto? Pues hará que, al empezar el juego, se ejecute esa lista de cláusulas formada por una única cláusula, que siempre se ejecutará (porque tiene IF TRUE) y que lo que hace es trasladarnos a la coordenada (12, 2) de la pantalla 0, porque eso es lo que hace el comando WARP:

WARP_TO n, x, y
Nos traslada a la pantalla x, y nos hace aparecer en las coordenadas (x, y).

¿Qué pasará? Ooooh, oooh. Es sencillo: cuando el jugador empiece la partida se ejecutará la sección ENTERING GAME. Esta sección lo único que hace es trasladar al jugador a la posición (2, 2) y cambiar a la pantalla 0. Entonces, al entrar en la pantalla 0, se ejecutará la sección ENTERING SCREEN 0, que nos pintará los tiles extra. ¡Vamos a probarlo! Compila el güego y ejecútalo. Si todo va bien, deberíamos aparecer en nuestra pantalla 0 decorada:



¡Hala! Jodó, qué bien. Más, más. Vamos a pintar más tiles para decorar otras pantallas. Exactamente de la misma forma que hemos decorado la pantalla 0, vamos a decorar también la pantalla 1, colocando el cartel de la Universidad de Miskatonic (tiles 24, 25, y 26) y unas armaduras (tiles 32 y 33):

# Pasillo de la universidad
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
¡Vamos a verlo! Cambia ENTERING_GAME para saltar a la pantalla 1 en vez de la pantalla 0:

ENTERING GAME
IF TRUE
THEN
WARP_TO 1, 12, 2
END
END
Compila, ejecuta… et voie-la!



De la misma manera añadimos código para poner más decoraciones en el mapa. La verdad es que nos aburrimos pronto y sólo hay mandanga en la pantalla 6 (una lámpara) y la pantalla 18 (un ancla en la playa). ¿Por qué no aprovechas tú y pones más? Estas son las que vienen en el juego original:

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

Creo que lo voy pillando

Pues es el momento para dejarlo. Intenta absorber bien estos conocimientos, empápatelos bien. Si no has pillado algo de aquí, no tengas prisa y espérate a que sigamos, que seguramente lo terminarás entendiendo. Y, como siempre, lo que quieras preguntar ¡pregúntalo!

En el siguiente capítulo meteremos la chicha del gameplay: detectaremos que se han muerto todos los hechiceros para quitar el piedro de la entrada de la universidad, y programaremos la lógica para ir dejando las cajas en el vestíbulo.

Hasta entonces, cacharrea con esto. En el archivo con el material de este capítulo tienes el Dogmole con el script a medio hacer con las cosas que hemos visto en este capítulo.

The Mojon Twins
