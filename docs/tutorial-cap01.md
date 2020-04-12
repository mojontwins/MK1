# Capítulo 1: Introducción

## ¿Pero qué seto?

![Seto](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/01_seto.png)

Eso digo yo ¿Pero qué seto? Ufff. Hay tanto que decir, y tan poco espacio. Podría tirarme horas charlando y diciendo chorradas, pero intentaré no hacerlo. Me han dicho que tengo que ser claro y conciso y, aunque me cueste, trataré de serlo.

Empecemos por el principio. En realidad un poquito más adelante, que hay mucha gresca entre creacionistas y evolucionistas. Vayámonos a 2010. A principios de ese año tuvimos una idea en Mojonia. Básicamente estábamos hartos de copiar y pegar a la hora de hacer güegos. Porque, a ver, no todo es cuestión de copiar y pegar, pero bien es cierto que cantidad de cosas siempre se hacen igual, cambiando varios parámetros. A ver, si te piensas que los que hacemos güegos escribimos la misma rutina de pintar la pantalla con tiles cada vez que hacemos un güego... po no. También estábamos hartos del arduo trabajo manual. Que si pasar a mano los sprites al formato de la splib2, que si ordenar a mano los tiles para que SevenuP los cogiese en el orden correcto, que si pasar el mapa, que si colocar enemigos con una hoja de cuadritos... Había mil quehaceres a la hora de hacer güegos que resultaban tediosos y aburridos. ¿Y quién quiere aburrirse mientras hace algo que supuestamente le gusta? Nosotros no. Y tú tampoco, supongo.

Ya lo sé. Que eso de diseñar el güego y hacer las cosas en papel milimetrado es muy de los 80 y tal pero, a ver, en serio, es un coñazo. Uno puede ser friki, pero masoquista no.

Se nos ocurrió que lo que necesitábamos era un _framework_, que lo llaman ahora, que nos permitiese disponer de los módulos de código que queríamos utilizar de forma sencilla, y que nos hiciese llevadero todo el tema de la conversión e integración de datos (gráficos, mapas, posicionamiento de enemigos y objetos...). Empezamos tímidamente escribiendo las utilidades de conversión, para luego ir levantando, usando trocitos de aquí y de allá, un _engine_ que sirviese como base.

Teníamos un montón de ideas para el _engine_. Podríamos habernos puesto a desarrollarlo poco a poco y luego sacar el güego definitivo, pero nosotros no funcionamos así. Como se nos iban ocurriendo paranoias, íbamos sacando güegos cada vez que le metíamos una cosa nueva al engine. Así, en cuanto estuvo listo el “mínimo operativo”, lo estrenamos con **Lala the Magical**, **Cheril of the Bosque**, **Sir Ababol** y **Viaje al Centro de la Napia**.

Como la gracieta, dentro de la retroescena, era que nosotros hacíamos juegos “como churros” (¡pero qué churros, señora!), decidimos llamarle al sistema **MTE MK1 (*Mojon Twins Engine MK1*)**, o **la Churrera**. Y así empezó todo... Mala idea, por cierto, porque hay gente a la que por lo visto le ha sentado muy mal que hagamos un motor reutilizable y usan el nombre de forma muy despectiva.

## Pero entonces ¿qué es exactamente **MTE MK1**?

Pues eso mismo: **MTE MK1** es un _framework_ que se compone de varias cosas muy chulas:

1. El *engine*, o *motor*, el corazón de **MTE MK1**. Se trata de un pifostio de código bestial que se “gobierna” mediante un archivo principal llamado “config.h” en el que decimos qué partes del motor usaremos en nuestro güego y cómo se comportarán.

2. Las utilidades de conversión, que nos permiten diseñar nuestro güego en nuestros editores preferidos y, de forma incolora, inodora e insípida, meter todos esos datos en nuestro güego.

3. Un montón de monos, imprescindibles para cualquier cosa que se quiera hacer en condiciones.

4. Tortilla.

**MTE MK1** ha tenido muchas versiones a lo largo de los últimos tres años. Desde 2010 hasta principios de 2013 fuimos evolucionando hasta llegar a la versión 4.7, pero el pifostio se nos lió tanto que no era, para nada, presentable. Cuando por aquella época se nos ocurrió hacer un tutorial decidimos irnos para atrás un poco, a un punto del pasado en el que el tema era aún manejable: la versión 3.1 (**Trabajo Basura**, **Zombie Calavera Prologue**).

Durante un par de meses nos dedicamos exclusivamente a coger la versión 3.1, corregirle todas las cosas que estaban chungas, cambiar la mitad de los componentes para hacerlos más rápidos y más compactos, y añadir un montón de características. Así construímos las versiones **3.99**, que fueron las que pusimos a vuestra disposición y fuimos evolucionando poco a poco hasta que, de forma poco natural, mutó en **MK2** a mediados de 2014.

Años después, aprovechando el décimo aniversario de **MTE MK1**, hemos revisado la última versión, actualizado el *toolchain* para automatizar al máximo todo el proceso, e incorporado en el *engine* muchísimas mejoras propias de motores más modernos, para hacer un híbrido tan sencillo como **MTE MK1** original pero que rindiese como nuestros últimos productos.

Para poneros un ejemplo, el *proyecto por defecto* (que no es más que la versión beta de **Lala Prologue** portada a **MTE MK1** v5.0) ocupa 2.5KB menos y corre un 20% más rápido (con cambio de pantallas instantáneo) que utilizando la versión 3.99 del motor. Además, grabada en un diskette da la consistencia necesaria al material magnético para que, lanzado en plan ninja, cercene limpiamente las cabezas de los enemigos.

## Pero ¿qué se puede hacer con esto?

Pues un montón de cosas. A nosotros se nos han ocurrido ya un montón. Si bien es cierto que hay elementos comunes y ciertas limitaciones, muchas veces te puedes sacar de la manga una paranoia nueva solamente combinando de forma diferente los elementos que tienes a tu disposición. ¿Quieres ejemplos? Pues para eso mismo hemos acompañado el lanzamiento de la rama 3.99 con la **Mojon Twins Covertape #2**. Si todavía no la tienes, bájatela. AHORA.

![Mono](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/01_mono.png)

Para la **Mojon Twins Covertape #2** lo que hicimos fue contratar a una tribu de indios pies-sucios (oriundos de la Jungla de Badajoz). A cada uno le escribimos una característica de **MTE MK1** en la espalda y otra en el pecho, y les animamos a descender por las colinas haciendo la croqueta. Cuando llegaban abajo hacíamos una foto y anotábamos las combinaciones. Con esas combinaciones hacíamos un güego. Luego llamábamos a Alberto, el Mono Tuerto, que el tío se inventa una historias de la leche, para que las justificase con un argumento convincente. Y funciona, en serio.

## Vamos a echarle un vistazo a las cosas que tenemos.

1. **Valores**: Todos los valores relacionados con el movimiento del protagonista son modificables. Podemos hacer que salte más o menos, que caiga más despacio, que resbale más, que corra poco o mucho, y más cosas.

2. **Orientación**: Podemos hacer que nuestro güego se vea de lado o desde arriba (lo que, en Mojonia, conocemos como “perspectiva genital”). Es lo primero que tendremos que decidir, porque esto condicionará todo el diseño del güego.

3. **¿Sartar? ¿Volar? ¿cómor?**: Si elegimos una perspectiva lateral (que el güego se vea de lado) tendremos que decidir cómo se moverá el muñeco. Podemos hacer que sarte cuando se pulse salto (**Lala Lah**, **Julifrustris**, **Journey to the Centre of the Nose**, **Dogmole Tuppowski**...), que sarte siempre (**Bootee**)... También podemos hacer que vuele (**Jetpaco**).

4. **Rebotar contra las paredes**. Si elegimos que nuestro güego tenga perspectiva genital, podemos hacer que el prota rebote un poco cuando se choque con una pared.

5. **Bloques especiales**. Podemos activar o desactivar llaves y cerrojos, o bloques que se pueden empujar. Esto funciona para ambas orientaciones, si bien en la vista lateral los bloques sólo pueden empujarse lateralmente.

6. **Disparar**. También podemos hacer que el prota dispare. En los güegos de vista genital disparará en cualquiera de las cuatro direcciones principales. También podemos indicarle al motor qué dirección (vertical u horizontal) tiene preferencia en las diagonales. En los de vista lateral, disparará en un sentido u otro según mire a izquierda o derecha.

7. **Enemigos voladores**: que te persiguen sin tregua.

8. **Pinchos y cosas del escenario que te matan**, no necesariamente pinchos.

10. **Matar**: en los güegos de perspectiva lateral podemos hacer que los enemigos, un cierto tipo de enemigos, se mueran si les pisas la cabeza.

11. **Objetos coleccionables**: para que haya cosas que ir recopilando y guardándose en la buchaca.

12. **Scripting** Si lo de arriba no es suficiente, podemos inventarnos muchas más cosas usando el sencillo lenguaje de scripting incorporado.

Y más cosas que ahora mismo no recuerdo pero que irán surgiendo a medida que vayamos haciendo cosas.

El truco está en combinar estas cosas, echarle imaginación, timar un poco con los gráficos, y, en definitiva, ser un poco creativo. Por ejemplo, si ponemos una gravedad débil (que hará que el prota caiga muy lentamente) y habilitamos la capacidad de volar con muy poca aceleración, ponemos un fondo azul y el personaje tiene forma de buzo, podemos hacer como si estuviésemos debajo del agua. También se pueden probar cosas extremas, como por ejemplo poner los valores de aceleración vertical y de gravedad en negativo, con lo que el muñeco se vería empujado hacia arriba y haría fuerza para hundirse... cosa que, por cierto, no hemos probado nunca y que me acaba de dar una idea... En cuanto hable con Alberto y se invente un argumento tenemos güego nuevo.

¿Veis? ¡Así funciona! Mandadme un email y os doy el teléfono de Alberto.

## Entonces ¿Cómo empezamos?

Con imaginación. No me vale que cojas un juego nuestro que ya esté hecho y le cambies cosas. No. Así no vas a llegar a ningún sitio. La gente se cree que sí, pero NO. Invéntate algo, empieza de cero, y lo vamos construyendo poco a poco.

Si no se te da bien dibujar, búscate a un amigo que sepa, que siempre hay. En serio, siempre hay. Si no encuentras a nadie, no pasa nada: puedes usar cualquier gráfico que hayamos hecho nosotros. En los paquetes de código fuente de todos los güegos están todos los gráficos en png y tal. Recortar y pegar con un editor de gráficos es lo mínimo que deberás aprender.

De todos modos, para empezar, y siendo conscientes de que realmente no sabéis qué se puede y qué no se puede hacer, os invito a que vayamos construyendo, poco a poco, el juego **Dogmole Tuppowski**. ¿Por qué éste? Pues porque usa un montón de cosas, incluyendo el _scripting_. Pero no quiero que vayas, te pilles el paquete de fuentes de la **Covertape #2**, y te limites a seguir el tutorial mirando los archivos y tal. No. Lo suyo es que empieces con el paquete del _engine_ vacío que os vamos a ofrecer más abajo, y que, para cada capítulo, vayas obteniendo los diferentes recursos y realizando las acciones necesarias, como si realmente estuvieses creando el juego desde cero.

¿Para qué tanto teatro? Pues porque cuando te quieras poner a hacer el tuyo ya no será la primera vez y, créeme, es toda una ventaja. Y porque el teatro mola. ¡Salen tetas!

## Venga, va. Vamos a ello

Lo primero es inventarse una historia que apunte al _gameplay_. No vamos a escribir todavía una historia para el güego (porque ahora no la necesitamos) – eso vendrá dentro de poco. Primero vamos a decidir qué hay que hacer. Vamos a hacer un güego con **Dogmole Tuppowski**, un personaje que nos inventamos hace tiempo y que tiene esta pinta:

![Dogmole Tuppowski](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/01_dogmole.jpg)

En primer lugar vamos a hacer un juego de perspectiva lateral, de plataformas, en el que el personaje salte. No saltará demasiado, pongamos que podrá cubrir una distancia de unos cuatro o cinco tiles horizontalmente y dos tiles verticalmente. Esto lo tenemos que decidir en este punto porque tendremos que diseñar el mapa y habrá que asegurarse de que el jugador podrá llegar a los sitios a los que decidamos que se puede llegar.

Vamos a hacer que en el juego haya que llevar a cabo dos misiones para poder terminarlo. Esto lo conseguiremos mediante _scripting_, que será algo que dejaremos para el final del desarrollo. Las dos misiones serán sencillas y emplearán características automáticas del motor para que no haya que hacer un _script_ demasiado complicado:

1. Habrá cierto tipo de enemigos a los que tendremos que eliminar. Una vez eliminados, tendremos acceso a la segunda misión, porque se eliminará un bloque de piedra en la pantalla que da acceso a una parte del mapa.

2. Habrá que llevar, uno a uno, objetos a la parte del mapa que se desbloquea con la primera misión.

Para justificar esto, explicaremos que los enemigos que hay que eliminar son unos brujos o monjes o algo así mágico que hacen un podewwwr que mantiene cerrada la parte del escenario donde hay que llevar los objetos. ¡La historia se nos escribe sola!

Por tanto, ya sabemos que tendremos que construir un güego de vista lateral, con saltos, que se pueda pisar a cierto tipo de enemigos y matarlos, que sólo se pueda llevar un objeto encima, y que necesitaremos scripting para que se pinte la piedra en la entrada del sitio donde hay que llevar los objetos si no hemos matado a los enemigos. Además, el hecho de llevar las cosas una a una para dejarlas en un sitio necesitará otro poquito de _scripting_ también.

Como lo tenemos a huevo, nos inventamos la historia, que, si te leíste en su día la ficha del **Covertape #2**, ya conocerás:

**Dogmole Tuppowski** es el patrón de un esquife de lata que hace transportes de estraperlo de objetos raros y demás artefactos de dudosa procedencia (algunos dicen que con propiedades mágicas) para cierto departamento de la Universidad de Miskatonic (provincia de Badajoz). Sin embargo, una noche, justo cuando iba a hacer su entrega con cajas repletas de misteriosos y mágicos objetos, se levantó una tempestad del copetín que estrelló su barco contra un montón de piedras hostioneras con lo que el reventón fue de aúpa, y todas las cajas quedaron desperdigadas por la playa y alrededores.

La señorita Meemaid de Miskatonic, que se encontraba peinando sus Nancys a la luz de la luna llena en su torreón del acantilado, lo vio todo y, consciente de que el contenido de las cajas podría ser muy preciado por ocultistas y demás gente raruna, decidió llevárselas para ella. Como su camión estaba roto y reparándose y no lo tendría hasta el día siguiente, puso a sus esbirros de dudosa procedencia a guardar las cajas, y, por si acaso, también mandó a los veinte Brujetes de la Religión de Petete que hicieran un hechizo mental para cerrar las puertas de la Universidad.

La misión de Dogmole, por tanto, es doble: primero tiene que eliminar a los veinte Brujetes de la Religión de Petete y, una vez abierta la puerta de la Universidad, tendrá que buscar y llevar, una por una, cada una de las diez cajas al vestíbulo del edificio, donde deberá dejarlas en donde pone “BOXES” pulsando “A”.

Y ya, con esto, podemos empezar a diseñar nuestro juego. En realidad el tema suele salir así. En nuestro caso a veces hacemos trampas y jugamos con ventaja: muchos de nuestros juegos han surgido porque hemos añadido una nueva capacidad a **MTE MK1** y había que probarla, como ocurrió con Bootee, Balowwwn, Zombie Calavera o Cheril the Goddess. El proceso creativo es insondable y requiere que tengas algo de inventiva e imaginación y eso, desgraciadamente, no es algo que se pueda enseñar.

Ah, que se me olvidaba. También hicimos un dibujo de la Meemaid. Es ésta:

![The Mesmerizing Meemaid From Miscatonic](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/01_meemaid.jpg)

## Metiendo la cara en el barro

Vamos a empezar a montar cosas. En primer lugar, necesitarás **z88dk**, que es un compilador de C, y **splib2**, que es la biblioteca de gráficos y demás E/S que usamos. Como no tenemos ganas de que te compliques instalando cosas (sobre todo porque la splib2 es muy vieja y es complicado compilarla usando un z88dk moderno, y porque la splib2 que usamos en el motor está modificada por Elías, el mono modificalibrerías), hemos preparado, para los usuarios de Windows, un paquete `z88dk10-stripped.zip` que encontrarás en el directorio `env` de este repositorio y que deberás descomprimir en C:.

También vamos a necesitar un editor de textos. Si eres programador ya tendrás uno que te guste de la hostia. Si no lo eres, por favor, no utilices el Bloc de Notas de Windows.

Nos hará falta el editor Mappy para hacer los mapas del juego. La versión mojona `mappy-mojon.zip`, que está modificada con las cosas que necesitamos y un par de características _custom_ que vienen muy bien, también la hemos incluido en el directorio `env` de este repositorio.

Cuando lleguemos a la parte del sonido hablaremos de las utilidades Beepola y BeepFX. Puedes buscarlas y descargarlas ahora si quieres, pero no las utilizaremos hasta el final.

Otra cosa que necesitarás será un buen editor de gráficos para pintar los monitos y los cachitos de escenario. Te vale cualquiera que grabe en `.png`. Te reitero que si no sabes dibujar y no tienes ningún amigo que sepa puedes pillar los gráficos de Mojon Twins. Igualmente vas a necesitar un editor gráfico para recortar y pegar nuestros gráficos en los tuyos. Te vale cualquier cosa. Yo uso una versión super vieja de Photoshop o el genial Aseprite porque es a lo que estoy acostumbrado. Mucha gente usa Gimp. Hay un montón, elije el que más te guste. Pero que grabe .png. Remember. Se bebes no kandusikas.

Una vez que eso esté instalado y tal, necesitaremos **MTE MK1**. Descarga este repositorio a tu disco duro.

## Probando que todo está bien instalado

Para probar que todo está correctamente instalado, abre una ventana de línea de comandos, muévete al directorio `src/dev`, y:

1. Ejecuta `setenv.bat` la primera vez para establecer las variables de entorno que harán que **z88dk** esté encontrable. Si todo está donde debe estar, deberás obtener este mensaje en tu consola:

```
    zcc - Frontend for the z88dk Cross-C Compiler
    v2.59 (C) 16.4.2010 D.J.Morris
```

2. Ejecuta `compile.bat` para compilar el juego de ejemplo. Deberás ver el proceso en tu consola:

```
    Compilando script
    Convirtiendo mapa
    Convirtiendo enemigos/hotspots
    Importando GFX
    Compilando guego
    lala_beta.bin: 28566 bytes
    Construyendo cinta
    Limpiando
    Hecho!
```

Esto generará el archivo `lala_beta.tap` que podrás ejecutar en tu emulador de Spectrum favorito.

![Lala Beta](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/01_lala.png)

## Empezando un nuevo proyecto

1. Copia el contenido de `src` en un nuevo directorio con el nombre de tu juego.

2. Luego entra en `dev` y edita el archivo `compile.bat`. Al principio encontrarás una línea parecida a esta:

```
    set game=lala_beta
```

Simplemente cambia `lala_beta` por el nombre de tu juego.

Este archivo `compile.bat` contiene todos los pasos que hay que ejecutar para convertir cada archivo de datos (imágenes, mapa, etc.) de tu juego y luego compilar el motor para obtener un archivo `.tap`. En los siguientes capítulos veremos cada conversión e incluso la ejecutaremos de forma manual para entender qué está pasando tras las entretelas de los visillos, pero a la hora de hacer un juego, a menos que estés haciendo algo muy avanzado, te bastará con sustituir los archivos que vienen en el proyecto de ejemplo y ejecutar `compile.bat` cada vez.

Ahora ya estamos listos para que empiece lo bueno.
