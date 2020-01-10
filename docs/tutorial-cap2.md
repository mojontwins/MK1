Continuamos el Taller de creaci¢n de tu propio juego de Spectrum con la Churrera de los Mojon Twins. En este segundo cap°tulo nos meteremos ya en faena y empezaremos a ver el proceso de creaci¢n del juego. No os asustÇis, parece complicado pero no hay problema si se le dedica algo de tiempo y atenci¢n. Adem†s, explicado con humor y de forma amena, siempre es m†s llevadero.

No perdamos m†s tiempo. Vamos all†.

Pulsa aqu° para ver el cap°tulo 2 del Taller Crea tu propio juego de Spectrum.

Cap°tulo 2: Tileset

Antes de empezar

En este cap°tulo y en pr†cticamente todos los dem†s tendremos que abrir una ventana de linea de comandos para ejecutar scripts y programillas, adem†s de para lanzar la compilaci¢n del juego y cosas por el estilo. Lo que quiero decir es que deber°as tener


Material

El material necesario para seguir este cap°tulo os lo he dejado aqu°:

http://www.mojontwins.com/churrera/churreratut-capitulo2.zip

Desc†rgalo y ponlo en una carpeta temporal, que ya iremos poniendo cosas en nuestro proyecto seg£n las vayamos necesitando. Dentro hay cosas bonitas.

Tileset. ®De quÇ leches estamos hablando?

Pues de tiles. ®Que quÇ es un tile? Pues para ponerlo sencillo, no es m†s que un cachito de gr†fico que es del mismo tama§o y forma que otros cachitos de gr†ficos. Para que lo veas, busca la traducci¢n: tile significa "azulejo", (aunque nosotros preferim


Esto es lo que usa la Churrera para pintar los gr†ficos de fondo. Como guardar una pantalla gr†fica completa ocupa un huevo, lo que se hace es guardar un cierto n£mero de cachitos y luego una lista de quÇ cachitos ocupa cada pantalla. La colecci¢n de cac

Colisi¢n

La Churrera, adem†s, usa los tiles para otra cosa: para la colisi¢n. Colisi¢n es un nombre muy chulo para referirse a algo muy tonto: el protagonista del gÅego podr† andar por la pantalla o no dependiendo del tipo del tile que vaya a pisar. O sea, que ca

En los gÅegos de la Churrera tenemos los siguientes tipos de tiles, o, mejor dicho, los siguientes comportamientos para los tiles. Cada uno, adem†s, tiene un c¢digo que necesitaremos saber. Ahora no, sino m†s adelante, cuando ya tengamos todo el material

Tipo "0", traspasable. En los gÅegos de plataformas puede ser el cielo, unos ladrillos de fondo, el cuadro del t°o Narciso, un florero feo o unas monta§as a tomar por culo. En los gÅegos de vista genital los usaremos para el suelo por el que podemos anda

Tipo "1", traspasable y matante: se puede traspasar, pero si se toca se resta vida al protagonista. Por ejemplo, unos pinchos, un pozo de lava, pota radioactiva, cristales rotos, o las setas en el Cheril of the Bosque (®recuerdas? ≠no se pod°an de toc†!)

Tipo "2", traspasable pero que oculta. Son los matojos de Zombie Calavera. Si el personaje est† quieto detr†s de estos tiles, se supone que est† "escondido". Los efectos de estar escondido son muy poco interesantes ya que solo afectan a los murciÇlagos d

Tipo "4", plataforma. S¢lo tienen sentido en los gÅegos de plataformas, obviamente. Estos tiles s¢lo detienen al protagonista desde arriba, o sea, que si est†s abajo puedes saltar a travÇs de ellos, pero si caes desde arriba te posar†s encima. No sÇ c¢mo

Tipo "8", obst†culo. Este para al personaje por todos los lados. Las paredes. Las rocas. El suelo. Todo eso es un tipo 8. No deja pasar. Piedro. Duro. Croc.

Tipo "10", interactuable. Es un obst†culo pero que sea de tipo "10" hace que el motor estÇ coscao y sepa que es especial. De este tipo son, por ahora, los cerrojos y los bloques que se pueden empujar. Hablaremos de ellos dentro de poco.

Vaya mierda, pensar†s, ≠si faltan n£meros! Y m†s que faltaban antes. Esto est† hecho queriendo, amigos, porque simplifica mucho los c†lculos y permite meter m†s tipos en el futuro. Por ejemplo, f°jate como todo lo que sea mayor o igual que 4 parar† al pr

En un futuro, adem†s, se puede ampliar f†cilmente, como hemos dicho. Por ejemplo, se podr°a a§adir c¢digo a la Churrera para que los tiles de tipo "5" y "6" fueran como cintas transportadoras a la izquierda y a la derecha, respectivamente. Se podr°a a§ad

Interactuables

Hemos mencionado los tiles interactuables. En la versi¢n actual de la Churrera son dos: cerrojos y empujables. Tienes que decidir si tu gÅego necesita estas caracter°sticas.

Los cerrojos los necesitar†s si pones llaves en el gÅego. Si el personaje choca con un cerrojo y lleva una llave, pues lo abre. El cerrojo desaparecer† y se podr† pasar.

Los tiles empujables son unos tiles que, al empujarlos con el protagonista, cambiar†n su posici¢n si hay sitio. En los gÅegos de plataformas s¢lo se pueden empujar lateralmente; en los de vista genital se pueden empujar en cualquier direcci¢n. Como ya ve

Vamos al l°o ya ®no?

Eso, vamos al l°o ya. Vamos a dibujar nuestro tileset, o a rapi§arlo de por ah°, o a pedir a nuestro amigo que sabe dibujar que nos lo haga. Que s°, hombre, que te busques uno, que hay muchos grafistas faltos de amor. Lo primero que tenemos que decidir e

Ya sÇ que 16 pueden parecer pocos tiles, pero pensad que la mayor°a de nuestros gÅegos est†n hechos as°, y muy feos no quedan. Con un poco de inventiva podemos hacer pantallas muy chulas con pocos tiles. Adem†s, como veremos m†s adelante en este mismo ca

Por lo pronto id abriendo vuestro programa de edici¢n gr†fica preferido y creando un nuevo archivo de 256û48 p°xels. Seguro que vuestro programa de edici¢n gr†fica tiene una opci¢n para activar una rejilla (o grid). Colocadla para que haga recuadros de 1


Haciendo un tileset de 16 tiles

Si has decidido ahorrar memoria (por ejemplo, si planeas que el motor del gÅego termine siendo medianamente complejo, con scripting y muchas cosas molonas, o si prefieres que tu mapa sea bien grande) y usar tilesets de 16 tiles, tienes que crear algo as°


El tileset se divide en dos secciones: la primera, formada por los primeros diecisÇis tiles, es la secci¢n de mapa. Es la que usaremos para hacer nuestro mapa. La segunda, formada por los cuatro siguientes, es la secci¢n especial que se usar† para pintar

Empecemos viendo la secci¢n de mapa:

Por convenci¢n, el tile 0, o sea, el primero del tileset (los verdaderos desarrolladores empiezan a contar en el 0), ser† el tile de fondo principal, el que ocupe la mayor°a del fondo en la mayor°a de las pantallas. Esto no es un requerimiento, pero nos 

Los tiles del 1 al 13 pueden ser lo que quieras: tiles de fondo, obst†culos, plataformas, matantes.

El tile 14 (el pen£ltimo), si has decidido que vas a activar los tiles empujables, ser† el tile empujable. Tiene que ser el 14, y ning£n otro.

El tile 15 (el £ltimo), si has decidido que vas a activar las llaves y los cerrojos, ser† el tile de cerrojo. Tiene que ser el 15, y ning£n otro.

Si no vas a usar empujables o llaves/cerrojos puedes usar los tiles 14 y 15 libremente, por supuesto.

En cuanto a la secci¢n especial, est† formada por cuatro tiles que son, de izquierda a derecha:

El tile 16 es la recarga de vida. Aparecer† en el mapa y, si el usuario la pilla, recargar† un poco de vida.

El tile 17 representa a los objetos. Son los que el jugador tendr† que recoger durante el gÅego, si decidimos activarlos.

El tile 18 representa las llaves. Si hemos decidido incluir llaves y cerrojos, pintaremos la llave en este tile.

El tile 19 es el fondo alternativo. Para dar un poco de age a las pantallas, de forma aleatoria, se pintar† este tile de vez en cuando en vez del tile 0. Por ejemplo, si tu tile 0 es el cielo, puedes poner una estrellica en este tile. O, si est†s haciend

®Se pilla bien? B†sicamente hay que dibujar 20 tiles: 16 para hacer el mapa, y 4 para representar objetos y restar monoton°a de los fondos. Huelga decir que si, por ejemplo, no vas a usar llaves y cerrojos en tu gÅego, te puedes ahorrar pintar la llave e

En el dogmole, por ejemplo, no hay tiles empujables. Por eso nuestro tile 14 es un mejill¢n del cant†brico que, como todos sabemos, no se puede empujar.

Sombreado autom†tico

El sombreado autom†tico puede hacer que nuestras pantallas se vean mucho m†s chulas. Si lo activamos, la Churrera har† que los tiles obst†culo proyecten sombras sobre los dem†s. Para conseguirlo, necesitamos definir una versi¢n alternativa de la secci¢n 


Tendremos total control, por tanto, de c¢mo se proyectan las sombras. El resultado obtenido lo podÇis ver en muchos de nuestros gÅegos. Por ejemplo, en el Cheril Perils, al que pertenece el tileset de arriba. F°jate como los tiles obst†culos dejan una so




En el Dogmole no vamos a usar esto porque necesitamos el espacio que ocupar°an las sombras autom†ticas para otra cosa que ya veremos en su momento.

Ejemplos

Para verlo, vamos a echarle el ojete a algunos tilesets de nuestros gÅegos, a modo de ejemplo, para que ve†is c¢mo est†n dise§ados.



Aqu° tenemos el tileset de Lala lah. Como vemos,el primer tile es el fondo azul que se ve en la mayor°a de las pantallas. Le sigue un trozo de plataforma que tambiÇn es un tile de fondo, y despuÇs el rebordecico que es un tile tipo "plataforma" (tipo 4).


Este es el tileset de D'Veel'Ng, un gÅego de perspectiva genital. Este empieza con dos tiles para suelo (tipo 0), seguidos por cuatro obst†culos (tipo 8) - los buesos, la calavera, la canina y el piedro, dos tiles matadores y malignos (tipo 1), que son e



Ahora toca el del Monono. Este es muy sencillo de ver: empezamos con el tile de fondo principal, vac°o del todo (tipo 0). Seguimos con seis obst†culos (tipo 8). Luego tenemos dos tiles de fondo m†s, para adornar los fondos: la ventanica para asomarse y d

Podr°a seguir, pero es que no tengo m†s ganas.

Haciendo un tileset de 48 tiles

Como hemos advertido, los mapas hechos con tilesets de 48 tiles ocupan el doble que los que est†n hechos con tilesets de 16. Si a£n as° decides seguir esta ruta, aqu° tienes una explicaci¢n de c¢mo hacerlo.

En primer lugar, aqu° no hay una diferenciaci¢n expl°cita entre la secci¢n de mapa y la secci¢n especial: est† todo junto. Adem†s, no es posible a§adir sombreado autom†tico (no tenemos sitio para las versiones alternativas de los tiles). Sobre todo, se n

En los tilesets de 48 tiles, podemos usar los tiles de 0 a 47 para hacer las pantallas salvo los correspondientes a las caracter°sticas especiales: el tile 14 para el empujable, el 15 para cerrojos, el 16 para recargas, el 17 para objetos y el 18 para ll

Como £nico ejemplo tenemos el tileset de Zombie Calavera. Si te fijas, en Zombie Calavera no hay llaves (ni cerrojos), por lo que s¢lo est†n ocupados como "especiales" el 16 para las recargas y el 17 para los objetos. Tampoco hay tiles empujables. Todos 



Ya tenemos el tileset pintado. Ahora ®quÇ?

Lo primero es grabarlo como copia maestra dentro de la carpeta /gfx llam†ndolo work.png. Ahora tenemos que prepararlo para usarlo. Haremos dos versiones: la que importaremos en el gÅego y la que usaremos en el Mappy para hacer el mapa y en el colocador d

Si est†s siguiendo el tutorial con el Dogmole sin hacer experimentos propios, puedes encontrar el work.png del dogmole en el paquetito de archivos de este cap°tulo.

El tileset para Mappy

Mappy es muy jod°o. Necesita que el tile 0 estÇ vac°o, o sea, que sea todo negro. Si le cargas un tileset que no tenga el primer tile todo negro, pone Çl uno al principio y desplaza todos los dem†s tiles. Eso es una putada porque estar°amos haciendo un m



Este tileset lo grabamos en la carpeta /gfx como mappy.bmp, m†s que nada porque Mappy y el colocador se entienden mejor con ese formato.

Recuerda, que es importante: (leer esto con voz de madre, para que te cale m†s) si tu tile 0 no es totalmente negro, tienes que dejarlo totalmente negro. Mira los ejemplos de m†s arriba. En Zombre Calavera, Lala lah o D'Veel'Ng hubo que hacer esto. Que s

El tileset para importar

Splib2, la biblioteca sobre la que funciona la Churrera, maneja un charset de 256 caracteres para pintar los fondos, adem†s de los sprites que van encima. Por tanto, el siguiente paso es crear un charset para importar en el juego usando nuestro tileset y


Lo suyo es que te pilles una de por ah° (hay muchas de gratis) o que pintes la tuya encima de ese gr†fico (que encontrar†s dentro del paquete en el archivo fuente-base.png). Sea lo que sea lo que terminÇis haciÇndolo, grabadlo en /gfx como fuente.png. Es


Lo primero que vamos a hacer es reordenar nuestro tileset. Lo que haremos ser† "partir" cada tile en cuatro trozos de 8û8. Cada uno de estos trozos se corresponde con lo que los Spectrumeros conocemos como UDG (User Defined Graphic) y, adem†s, llevar† un



Hace a§os hac°amos esto a mano y era un verdadero co§azo. De hecho, la primera aplicaci¢n que hicimos para la Churrera fue la que se encarga, precisamente, de reordenar tilesets en UDGs. La aplicaci¢n est† en la carpeta /util de la Churrera y se llama re

../utils/reordenator.exe work.png udgs.png

Esto pondr† a reordenator.exe a trabajar, generando un nuevo archivo udgs.png que ser† exactamente igual que el que hemos visto justo arriba.

Ahora que tenemos nuestra fuente en fuente.png y los udg en udgs.png, volvemos a nuestro editor gr†fico, creamos un archivo nuevo de 256û64 p°xels, y pegamos los udg debajo de la fuente, justo as°:


Eso ser† lo que vamos a importar en nuestro gÅuego. Lo grabamos en /gfx como tileset.png. Esto es muy importante, ya que SevenuP generar† el c¢digo a partir de nuestra imagen y a la estructura de datos la llamara, exactamente, "tileset", que es lo que ne

Perfecto. Con todo esto hecho, abrimos, por fin, SevenuP. Una vez abierto, pulsamos "I" para "Importar", lo que abrir† un di†logo de selecci¢n de archivos donde navegaremos hasta la carpeta /gfx de nuestro proyecto y seleccionaremos tileset.png. SevenuP 

Ahora hay que configurar la exportaci¢n de datos del programa para que nos saque el charset en el orden que necesitamos. Para ello nos vamos al men£ File->Output Options, con lo que se abrir† un cuadro de di†logo con muchas opciones. No habr† que tocar n



Hecho esto, le damos a OK. Ahora vamos a exportar los datos: le damos a "D" para "exportar Datos" y se nos abrir† otro di†logo de selecci¢n de archivos. Ahora tenemos que navegar hasta nuestra carpeta /dev y grabar el archivo como tileset.h (habr† que se

De esta forma, SevenuP generar† un archivo /dev/tileset.h con el c¢digo necesario para tener nuestro charset en el gÅego. En concreto, escribir† 8 bytes para cada uno de los 256 caracteres, m†s 256 bytes con los atributos de los mismos.

AprÇndete eso de arriba de memoria. No, en serio, quiero que generes tileset.h por t° mismo. Por eso no lo he puesto en el paquete.

Un poco de trabajo manual

Tranquilos, ser† muy poco.

Seguro que a estar alturas del cuento entenderÇis c¢mo funcionan los gr†ficos en un Spectrum y todo el tema del "colour clash" o mezcla de atributos. Con esto sabido, es f†cil entender el concepto de que, en la Churrera, los sprites no tienen color propi

El motor pintar† la pantalla y luego pondr† los sprites encima. Si has sido cuidadoso y todos los tiles marcados como "fondo" son amarillos, el juego te quedar† bastante homogeneo y no se notar† mucho la mezcla de colores. El problema son los caracteres 



Abre /dev/tileset.h en un editor de textos. Hay que irse a la linea 279. Si tu editor de textos no te marca el n£mero de linea es que deber°as cambiar de editor de textos, por cierto. Cuando tengas un editor de textos en condiciones, te vas a la linea 27

0, 0, 0, 0, 70, 6, 66, 2,

®Ves lo que te dec°a? Esos cuatro ceros son los cuatro atributos del primer tile. Bien, pues vamos a cambiarlos. Vamos a poner la tinta a blanco, o sea, INK 7. Si recuerdas, los valores de los atributos se calculan con INK + 8*PAPER + 64*BRIGHT, as° que 

7, 7, 7, 7, 70, 6, 66, 2,

De hecho, deber°amos fijarnos si de ah° al final sale otro "0" que no queramos, y cambiarlo tambiÇn por un el mismo valor. Si no te das cuenta ahora, crÇeme que te dar†s cuenta cuando montes el juego y veas como trozos de sprites desaparecen al pasar por

Vale, ya est† todo.

Bien. Si has llegado hasta aqu° has pasado la primera prueba de fuego. Hay que usar la linea de comandos para ejecutar cosas con par†metros. Hay que editar gr†ficos y cortar y pegar. Hay que usar aplicaciones de conversi¢n. ≠Hay que modificar cosas a man

Y con el ladrillo escamondao, os ubicamos en este mismo canal para el pr¢ximo cap°tulo, donde montaremos el mapa.

Peque§a aclaraci¢n

Ha habido un par de dudas sobre el tema del tileset normal y el tileset de Mappy y tal. Vamos a poner algunos ejemplos para ilustrar el tema.

En primer lugar, veamos nuestro Dogmole Tuppowski. Para obtener el tileset de Mappy, sencillamente recortaremos los primeros 16 tiles (la tira superior) y lo grabaremos como mappy.bmp. No hay que hacer nada m†s, ya que el primer tile ya es totalmente neg




Aqu° tenemos otro ejemplo. Aqu° vemos el tileset de Cheril of the Bosque. Para obtener el tileset de Mappy recortaremos, como siempre, los primeros 16 tiles, y adem†s tendremos que dejar el primero completamente negro, ya que originalmente tiene una text




Creo que ya se pilla, pero pongamos un ejemplo m†s. He aqu° el tileset de Viaje al Centro de la Napia. Aqu° el tile 0 es rosa. Tampoco nos vale. Recortamos los 16 tiles y dejamos el tile rosa en negro. Y lo grabamos como mappy.bmp.




Mojon Twins
