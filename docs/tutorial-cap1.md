Una de las caracter°sticas m†s recordada de nuestra querida Microhobby fue aquella que nos permiti¢ a muchos hacer nuestros pinitos en programaci¢n y hardware. Entre otras cosas, y casi siempre en forma de talleres breves, pod°amos ÆpicarØ l°neas y l°neas de c¢digo para hacer nuestros propios juegos. Luego pod°amos modificarlos y hasta aprender de forma autodidacta. Fue lo m†s parecido a aquella promesa eterna de Æc¢mprame el Spectrum que me ayudar† a estudiarØ. Pues bien, salvando las distancias, siempre

Dividido en cap°tulos, los Mojon Twins ir†n cont†ndonos, con su tradicional estilo surrealista y mucho humor, el mÇtodo para usar su Churrera v3.99b. VerÇis lo sencillo que es cuando te lo explican. Y si tenÇis alguna duda podÇis preguntar lo que sea por

Sin m†s, aqu° tenÇis el primer cap°tulo de La Churrera v3.99b - Tutorial y mandanga - Copyleft 2013 The Mojon Twins.

Pulsa aqu° para ver el cap°tulo 1 del Taller Crea tu propio juego de Spectrum.

Cap°tulo 1: Introducci¢n


®Pero quÇ seto?

Eso digo yo ®Pero quÇ seto? Ufff. Hay tanto que decir, y tan poco espacio. Podr°a tirarme horas charlando y diciendo chorradas, pero intentarÇ no hacerlo. Me han dicho que tengo que ser claro y conciso y, aunque me cueste, tratarÇ de serlo.

Empecemos por el principio. En realidad un poquito m†s adelante, que hay mucha gresca entre creacionistas y evolucionistas. Vay†monos a 2010. (Aqu° suena la m£sica t°pica de poner imagenes del pasado, esa que hace taaaa, tararar† tar†aaa, tararara tar†aa

A principios de a§o tuvimos una idea en Mojonia. B†sicamente est†bamos hartos de copiar y pegar a la hora de hacer gÅegos. Porque, a ver, no todo es cuesti¢n de copiar y pegar, pero bien es cierto que cantidad de cosas siempre se hacen igual, cambiando v

Ya lo sÇ. Que eso de dise§ar el gÅego y hacer las cosas en papel milimetrado es muy de los 80 y tal pero, a ver, en serio, es un co§azo. Uno puede ser friki, pero masoquista no.

Se nos ocurri¢ que lo que necesit†bamos era un framework, que le llaman ahora, que nos permitiese disponer de los m¢dulos de c¢digo que quer°amos utilizar de forma sencilla, y que nos hiciese llevadero todo el tema de la conversi¢n e integraci¢n de datos



Ten°amos un mont¢n de ideas para el engine. Podr°amos habernos puesto a desarrollarlo poco a poco y luego sacar el gÅego definitivo, pero nosotros no funcionamos as°. Como se nos iban ocurriendo paranoias, °bamos sacando gÅegos cada vez que le met°amos u

Como la gracieta, dentro de la retroescena, era que nosotros hac°amos juegos "como churros" (≠pero quÇ churros, se§ora!), decidimos llamarle al sistema "la Churrera". Y as° empez¢ todo.

Pero entonces ®quÇ es exactamente la Churrera?

Pues eso mismo: la Churrera es un framework que se compone de varias cosas muy chulas:

1. El engine, o "motor", el coraz¢n de la Churrera. Se trata de un pifostio de c¢digo bestial que se "gobierna" mediante un archivo principal llamado "config.h" en el que decimos quÇ partes del motor usaremos en nuestro gÅego y c¢mo se comportar†n.

2. Las utilidades de conversi¢n, que nos permiten dise§ar nuestro gÅego en nuestros editores preferidos y, de forma incolora, inodora e ins°pida, meter todos esos datos en nuestro gÅego.

3. Un mont¢n de monos, imprescindibles para cualquier cosa que se quiera hacer en condiciones.


La Churrera ha tenido muchas versiones a lo largo de los £ltimos tres a§os. De forma interna hemos llegado a la versi¢n 4.7, pero el pifostio se nos li¢ tanto que no es, para nada, presentable. Tiene demasiados hacks y est† muy desordenada. As° que cuand

Durante un par de meses nos hemos dedicado exclusivamente a coger la versi¢n 3.1, corregirle todas las cosas que estaban chungas, cambiar la mitad de los componentes para hacerlos m†s r†pidos y m†s compactos, y a§adir un mont¢n de caracter°sticas. As° co

La versi¢n 3.99b est† tan optimizada que, si recompilamos los viejos juegos con ella, obtenemos binarios entre 2 y 5Kb m†s peque§os, con movimientos m†s r†pidos y mucho m†s fluidos. Y est† a vuestra disposici¢n.

Adem†s, grabada en un diskette da la consistencia necesaria al material magnÇtico para que, lanzado en plan ninja, cercene limpiamente las cabezas de los enemigos.

Pero ®quÇ se puede hacer con esto?

Pues un mont¢n de cosas. A nosotros se nos han ocurrido ya un mont¢n. Si bien es cierto que hay elementos comunes y ciertas limitaciones, muchas veces te puedes sacar de la manga una paranoia nueva solamente combinando de forma diferente los elementos qu

Para la Mojon Twins Covertape #2 lo que hicimos fue contratar a una tribu de indios pies-sucios (oriundos de la Jungla de Badajoz). A cada uno le escribimos una caracter°stica de la churrera en la espalda y otra en el pecho, y les animamos a descender po


Vamos a echarle un vistazo a las cosas que tenemos.

1. Valores: Todos los valores relacionados con el movimiento del protagonista son modificables. Podemos hacer que salte m†s o menos, que caiga m†s despacio, que resbale m†s, que corra poco o mucho, y m†s cosas.

2. Orientaci¢n: Podemos hacer que nuestro gÅego se vea de lado o desde arriba (lo que, en mojonia, conocemos como "perspectiva genital"). Es lo primero que tendremos que decidir, porque esto condicionar† todo el dise§o del gÅego.

3. ®Sartar? ®Volar? ®c¢mor?: Si elegimos una perspectiva lateral (que el gÅego se vea de lado) tendremos que decidir c¢mo se mover† el mu§eco. Podemos hacer que sarte cuando se pulse salto (Lala Lah, Julifrustris, Journey to the Centre of the Nose, Dogmo

4. Rebotar contra las paredes. Si elegimos que nuestro gÅego tenga perspectiva genital, podemos hacer que el prota rebote un poco cuando se choque con una pared.

5. Bloques especiales. Podemos activar o desactivar llaves y cerrojos, o bloques que se pueden empujar. Esto funciona para ambas orientaciones, si bien en la vista lateral los bloques solo pueden empujarse lateralmente.

6. Disparar. TambiÇn podemos hacer que el prota dispare. En los gÅegos de vista genital disparar† en cualquiera de las cuatro direcciones principales. TambiÇn podemos indicarle al motor quÇ direcci¢n (vertical u horizontal) tiene preferencia en las diago

7. Enemigos voladores: que te persiguen sin tregua.

8. Enemigos perseguidores: parecidos pero diferentes. Ya hablaremos de ellos.

9. Pinchos y cosas del escenario que te matan, no necesariamente pinchos.

10. Matar: en los gÅegos de perspectiva lateral podemos hacer que los enemigos, un cierto tipo de enemigos, se mueran si les pisas la cabeza.

11. Objetos: para que haya cosas que ir recopilando y guard†ndose en la buchaca.

12. Scripting Si lo de arriba no es suficiente, podemos inventarnos muchas m†s cosas usando el sencillo lenguaje de scripting incorporado.

Y m†s cosas que ahora mismo no recuerdo pero que ir†n surgiendo a medida que vayamos haciendo cosas.

El truco est† en combinar estas cosas, echarle imaginaci¢n, timar un poco con los gr†ficos, y, en definitiva, ser un poco creativo. Por ejemplo, si ponemos una gravedad dÇbil (que har† que el prota caiga muy lentamente) y habilitamos la capacidad de vola

®VÇis? ≠As° funciona! Mandadme un email y os doy el telÇfono de Alberto.

Entonces ®C¢mo empezamos?

Con imaginaci¢n. No me vale que cojas un juego nuestro que ya estÇ hecho y le cambies cosas. No. As° no vas a llegar a ning£n sitio. La gente se cree que s°, pero NO. InvÇntate algo, empieza de cero, y lo vamos construyendo poco a poco.
Si no se te da bien dibujar, b£scate a un amigo que sepa, que siempre hay. En serio, siempre hay. Si no encuentras a nadie, no pasa nada: puedes usar cualquier gr†fico que hayamos hecho nosotros. En los paquetes de c¢digo fuente de todos los gÅegos est†n

De todos modos, para empezar, y siendo conscientes de que realmente no sabÇis quÇ se puede y quÇ no se puede hacer, os invito a que vayamos construyendo, poco a poco, el Dogmole Tuppowski. ®Por quÇ este? Pues porque usa un mont¢n de cosas, incluyendo el 

®Para quÇ tanto teatro? Pues porque cuando te quieras poner a hacer el tuyo ya no ser† la primera vez y, crÇeme, es toda una ventaja. Y porque el teatro mola. ≠Salen tetas!

Venga, va. Vamos a ello

Lo primero es inventarse una historia que apunte al gameplay. No vamos a escribir todav°a una historia para el gÅego (porque ahora no la necesitamos) - eso vendr† dentro de poco. Primero vamos a decidir quÇ hay que hacer.
Vamos a hacer un gÅego con Dogmole Tuppowski, un personaje que nos inventamos hace tiempo y que tiene esta pinta:


En primer lugar vamos a hacer un juego de perspectiva lateral, de plataformas, en el que el personaje salte. No saltar† demasiado, pongamos que podr† cubrir una distancia de unos cuatro o cinco tiles horizontalmente y dos tiles verticalmente. Esto lo ten

Vamos a hacer que en el juego haya que llevar a cabo dos misiones para poder terminarlo. Esto lo conseguiremos mediante scripting, que ser† algo que dejaremos para el final del desarrollo. Las dos misiones ser†n sencillas y emplear†n caracter°sticas auto

1. Habr† cierto tipo de enemigos a los que tendremos que eliminar. Una vez eliminados, tendremos acceso a la segunda misi¢n, porque se eliminar† un bloque de piedra en la pantalla que da acceso a una parte del mapa.

2. Habr† que llevar, uno a uno, objetos a la parte del mapa que se desbloquea con la primera misi¢n.

Para justificar esto, explicaremos que los enemigos que hay que eliminar son unos brujos o monjes o algo as° m†gico que hacen un podewwwr que mantiene cerrada la parte del escenario donde hay que llevar los objetos. ≠La historia se nos escribe sola!

Por tanto, ya sabemos que tendremos que construir un gÅego de vista lateral, con saltos, que se pueda pisar a cierto tipo de enemigos y matarlos, que s¢lo se pueda llevar un objeto encima, y que necesitaremos scripting para que se pinte la piedra en la e

Como lo tenemos a huevo, nos inventamos la historia, que, si te le°ste en su d°a la ficha del Covertape #2, ya conocer†s:

Dogmole Tuppowski es el patr¢n de un esquife de lata que hace transportes de extraperlo de objetos raros y dem†s artefactos de dudosa procedencia (algunos dicen que con propiedades m†gicas) para cierto departamento de la Universidad de Miskatonic (provin

La se§orita Meemaid de Miskatonic, que se encontraba peinando sus Nancys a la luz de la luna llena en su torre¢n del acantilado, lo vio todo y, consciente de que el contenido de las cajas podr°a ser muy preciado por ocultistas y dem†s gente raruna, decid

La misi¢n de Dogmole, por tanto, es doble: primero tiene que eliminar a los veinte Brujetes de la Religi¢n de Petete y, una vez abierta la puerta de la Universidad, tendr† que buscar y llevar, una por una, cada una de las diez cajas al vest°bulo del edif

Y ya, con esto, podemos empezar a dise§ar nuestro juego. En realidad el tema suele salir as°. En nuestro a veces hacemos trampas y jugamos con ventaja: muchos de nuestros juegos han surgido porque hemos a§adido una nueva capacidad a la churrera y hab°a q

Ah, que se me olvidaba. TambiÇn hicimos un dibujo de la Meemaid. Es esta:



Metiendo la cara en el barro

Vamos a empezar a montar cosas. En primer lugar, necesitar†s z88dk, que es un compilador de C y splib2, que es la biblioteca de gr†ficos que usamos. Como no tenemos ganas de que te compliques instalando cosas (sobre todo porque la splib2 es muy vieja y e

http://www.mojontwins.com/churrera/mt-z88dk10.zip

Los usuarios de Linux y otros sistemas no deber°an tener ning£n problema en instalar la £ltima versi¢n de z88dk en sus sistemas y copiar el archivo splib2.lib y splib2t.lib en donde las clibs y spritepack.h en donde los includes. Estos dos archivos los h

http://www.mojontwins.com/churrera/mt-splib2.zip

TambiÇn vamos a necesitar un editor de textos. Si eres programador ya tendr†s uno que te guste de la hostia. Si no lo eres, por favor, no utilices el bloc de notas de Windows. B†jate Crimson Editor, por ejemplo. En realidad cualquiera es mejor que el blo

Nos har† falta el editor Mappy para hacer los mapas del juego. Puedes bajarte la versi¢n oficial, aunque es mejor usar la versi¢n mojona que est† modificada con las cosas que necesitamos y un par de caracter°sticas custom que vienen muy bien y que ya ver

http://www.mojontwins.com/churrera/mt-mappy.zip

Otra cosa que necesitaremos ser† SevenuP para realizar la conversi¢n de gr†ficos. B†jatelo de su web oficial, aqu°:

http://metalbrain.speccy.org/

Cuando lleguemos a la parte del sonido hablaremos de las utilidades Beepola y BeepFX. Puedes buscarlas y descargarlas ahora si quieres, pero no las utilizaremos hasta el final.

Otra cosa que necesitar†s ser† un buen editor de gr†ficos para pintar los monitos y los cachitos de escenario. Te vale cualquiera que grabe en .png. Te reitero que si no sabes dibujar y no tienes ning£n amigo que sepa puedes pillar los gr†ficos de Mojon 
Una vez que eso estÇ instalado y tal, necesitaremos la Churrera. En la siguiente direcci¢n est† el paquete completo de la versi¢n 3.99b:

http://www.mojontwins.com/churrera/mt-churrera-3.99b.zip

Para empezar a trabajar, descomprimimos el paquete de la Churrera en un sitio chuli y lo personalizamos para nuestro juego siguiendo estos pasos:

1. Le cambiamos el nombre al directorio principal Churrera3.99b por el de nuestro juego. Por ejemplo "Dogmole Tuppowski".

2. Le cambiamos el nombre al m¢dulo C principal por el de nuestro juego. Este m¢dulo est† en /dev/ y se llama churromain.c. Le cambiaremos el nombre a dogmole.c.

3. Editaremos el archivo make.bat que est† en /dev/ con nuestro editor de texto para adaptarlo a nuestro juego. En primer lugar hay que sustituir donde pone %1 y poner el nombre que le pusiste a churromain.c. En nuestro caso, dogmole. Deber°a quedar as°:


Cada vez que hagamos un juego nuevo tendremos que descomprimir una nueva copia de la Churrera y personalizarlo igualmente.

Ya estamos listos para empezar. Pero os tendrÇis que esperar al pr¢ximo cap°tulo.
