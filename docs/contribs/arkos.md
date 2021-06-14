# Uso de Arkos Player en juegos 128k

Ahora en juegos de 128k podemos usar para crear músicas y efectos de sonidos (SFX) tanto **Wyz Tracker** como **Arkos Tracker 1**.

El proceso de añadir músicas en **Arkos** era algo más complejo que en Wyz ya que las canciones hay que compilarlas en la dirección de memoria en la que van a ser guardadas, por lo que era algo más laborioso sobre todo si estás en fase de pruebas.

Gracias a una utilidad de **MTE MK1**, ahora el proceso es mucho más automático y tan solo hay que preparar en juego para usarlo en unos sencillos pasos que detallaremos ahora.

## Activando Arkos Player

Lo primero es tener tu juego montado para 128k, claro. El sonido que usa Arkos es el que el chip AY produce, por tanto solo es válido para modelos 128k.

Para eso puedes leer en la doc (si, hay una carpeta "docs" llena de informacion) el * [Capítulo 13: Un juego de 128K](./tutorial-cap13.md), pero si tu juego no va a usar multi niveles y solo quieres música 128k, te lo ponemos aún más fácil. Sigue leyendo.

Abre el archivo `config.h` y verás que justo al inicio, hay 3 líneas tal que así:
	
```c
	// #define MODE_128K 						// Read the docs!
	// #define USE_ARKOS_PLAYER					// Use Arkos instead of Wyz player for 128k Music
	// #define ARKOS_SFX_CHANNEL	0			// SFX Channel (0-2)
```

Si descomentamos la primera línea, activaremos toda la mandanga de 128k, incluyendo el sonido y el Wyz Player. Si queremos usar Arkos en lugar de Wyz, tendremos que descomentar las dos líneas siguientes, y elegir el canal porque el que sonarán los sonidos FX en la tercera línea. Sobre eso tu músico te dirá cual es el adecuado, o debería decírtelo.
	
Perfecto, ahora que tenemos el 128k activado, vamos a probar el juego demo, que por defecto trae unas musiquillas listas para compilar.

## Preparando `compile.bat`

Vamos a abrir ahora el archivo "compile.bat" para prepararlo según nuestra elección. Aquí hay varias cosas que ver. Vamos por partes:

### Librarian

Hay que activar el librarian, que es una utilidad que se encarga de ordenar los trastos que van en toda la RAM extra del 128k, incluida la música y las pantallas fijas como el menú, marco y la pantalla del final. Busca estas líneas y mira que no estén comentadas:
	
```bat
	echo Running The Librarian
	..\utils\librarian2.exe list=..\bin\list.txt index=assets\librarian.h bins_prefix=..\bin\ rams_prefix=..\bin\ > nul
```

### Conversiones

A continuación veremos el bloque "Música AY". Aqui tenemos que descomentar la parte del player que vayamos a usar, para usar Arkos quedaría así:

```bat
	rem *** Música AY: Descomenta el player que vayas a usar (Wyz o Arkos) ***

	rem echo Compilando musica 128k - Wyz Player
	rem cd ..\mus
	rem ..\utils\apultra.exe menu.mus menu.bin
	rem ..\utils\apultra.exe level1.mus level1.bin
	rem ..\utils\pasmo WYZproPlay47aZXc.ASM ..\bin\RAM1.bin 
	rem cd ..\dev

	echo Compilando musica 128k - Arkos Player
	cd ..\mus_arkos
	if [%1]==[nomus] goto :nomus
	..\utils\build_mus_bin.exe ram1.bin > nul
	:nomus
	copy ram1.bin ..\bin
	copy arkos-addresses.h ..\dev\sound
	cd ..\dev	
```

### Seleccionando cargador

Por último veremos más abajo el bloque "Tipo de cargador" donde tenemos que comentar el cargador para 48k y descomentar el de 128k. Quedaría así:
		
```bat
	rem *** Tipo de cargador ***

	rem echo Construyendo cinta 48k
	rem cambia LOADER por el nombre que quieres que salga en Program:
	rem ..\utils\bas2tap -a10 -sLOADER loader\loader.bas loader.tap > nul
	rem ..\utils\bin2tap -o screen.tap -a 16384 loading.bin > nul
	rem ..\utils\bin2tap -o main.tap -a 24000 %game%.bin > nul
	rem copy /b loader.tap + screen.tap + main.tap %game%.tap > nul

	echo Construyendo cinta 128k
	..\utils\imanol.exe ^
		in=loader\loaderzx.asm-orig ^
		out=loader\loader.asm ^
		ram1_length=?..\bin\RAM1.bin ^
		ram3_length=?..\bin\RAM3.bin ^
		mb_length=?%game%.bin  > nul

	..\utils\pasmo.exe loader\loader.asm ..\bin\loader.bin loader.txt

	rem cambia LOADER por el nombre que quieres que salga en Program:
	..\utils\GenTape.exe %game%.tap ^
		basic 'LOADER' 10 ..\bin\loader.bin ^
		data                loading.bin ^
		data                ..\bin\RAM1.bin ^
		data                ..\bin\RAM3.bin ^
		data                %game%.bin
```

### Compilando 

¡LISTO! Ahora si compilamos el juego demo debería sonar música y SFX usando el Arkos Player (o Wyz si elegiste este otro). Pero éstas son solo unas músicas de ejemplo para comprobar que todo va bien. Veamos ahora como cambiar las canciones y SFX por los tuyos propios.

## Tu propia mandanga

Entiendo que estás usando Arkos, así que nos centraremos en este player. Vete a la carpeta "mus_arkos" y vas a encontrar uno cuantos archivos. 

Los archivos .aks son las canciones que exporta el Arkos Tracker y una de ellas contiene exclusivamente los SFX. Puedes abrirlos con el tracker y ver como están hechos.

Cuando tengas tus propias canciones y SFX hechos, tendrás que editar el archivo `song_list.txt` que está en esta misma carpeta. Este archivo contiene la lista de canciones en el orden en que serán compiladas y guardadas en memoria. Si abres el archivo verás esto:
	
```
	Cancion_00.aks
	Cancion_01.aks
	Cancion_02.aks
	Cancion_03.aks
	sfx.aks<
```

El ultimo es el fichero con los SFX y para indicarlo ponemos el signo < justo despues de su nombre. Como ves, la primera cancion es la 0, la segunda la 1, etc. Así se le deben llamar desde el juego. En el juego demo "Lala Prologue" la música que suena en el menú es la 0 y se llama desde esta funcion que encontrarás en "my/title_screen.h" si tienes curiosidad o simplemente quieres cambiarla por otra:

```c
	PLAY_MUSIC (0);
```

Pues bien, edita este archivo `song_list.txt` y pon tu lista de canciones y SFX. Solo eso, guardas los cambios y al compilar tu juego de nuevo ya deberían sonar las nuevas melodías y efectos de sonido. Si no va bien, repasa todo.

Recuerda tambien que en **MTE MK1**, en la carpeta `/dev/assets/`, hay un archivo llamado `ay_fx_numbers.h` donde puedes asignar que SFX sonará con cada acción del juego (salto, disparo, recibir daño, etc). ¡OJO! Los SFX en Arkos se numeran del 1 en adelante, a diferencia de con Wyz que empiezan en el cero.
