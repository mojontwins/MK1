# Capítulo 17: Scripting multilevel en 128K

(Esto es un borrador para que no se me olvide)

1. Primero haces el script con los `END_OF_LEVEL`, y lo compilas con el parámetro `rampage`. Esto debería generar una serie de macros en `msc-config.h` con los offsets al principio del script de cada nivel dentro del binario. Si usas `LEVELID` será más legible porque se usarán los identificadores que tú definas. Si no, generará macros llamadas `SCRIPT_xx`, con xx el número de nivel según el orden en el que se definan en el archivo de script, empezando por 0.

Para compilar el script, hay que modificar `compile.bat` para que la llamada sea algo así:

```
    [...]

    cd ..\script
    if not exist %game%.spt goto :noscript
    echo Compilando script
    ..\..\..\src\utils\msc3_mk1.exe %game%.spt 20 rampage > nul
    copy msc.h ..\dev\my > nul
    copy msc-config.h ..\dev\my > nul
    copy scripts.bin ..\bin\preload3.bin > nul
    :noscript
    cd ..\dev

    [...]
```

2. Luego el binario generado lo metes en un preload. Por ejemplo, en RAM4, para lo que lo llamarías `preload4.bin`. Así el librarian lo meterá al principio de RAM4 (a partir de la dirección 0xC000). *(tambien se puede meter como un resource normal y usar la dirección que le calcula el librarian, pero sería más complejo y pasando)*.

En el capítulo 13 del tutorial se llama a `librarian2` desde `build_assets.bat`, pero como estaremos modificando el script continuamente, lo mejor es mover la ejecución a `compile.bat`, justo antes de compilar el juego, algo así:

```
    [...]
    :compile
    echo Running The Librarian
    ..\..\..\src\utils\librarian2.exe list=..\bin\list.txt index=assets\librarian.h bins_prefix=..\bin\ rams_prefix=..\bin\ > nul

    echo Compilando guego
    zcc +zx -vn -m mk1.c -o %game%.bin -lsplib2_mk2.lib -zorg=24000 > nul
    [...]
```

* Hemos añadido `rampage` como parámetro extra de `msc3_mk1.exe`.
* Hemos copiado `scripts.bin` a `../bin/preload3.bin` para que Librarian lo meta en RAM3.

3. Seguidamente tienes que definir `SCRIPT_PAGE`. En nuestro caso, `#define SCRIPT_PAGE 4` para RAM4.

4. Finalmente, en el array `levels` de `my/levelset`, tienes que poner como dirección de cada script `0xC000 + offset`, donde el offset será la macro correspondiente generada por msc en `msc-config.h`. Por ejemplo, si has creado dos niveles y has puesto `LEVELID LEVEL_CASA` y `LEVELID LEVEL_BARCO` en el script, tendrías que usar `0xC000 + LEVEL_CASA` para el primer nivel y `0xC000 + LEVEL_BARCO` para el segundo.

```c
    // my/levelset.h
    [...]

    LEVEL levels [] = {
        { LEVEL0C_BIN, 1, 0xC000 + LEVEL_BASE },
        { LEVEL1C_BIN, 1, 0xC000 + LEVEL_PIRAMIDE }
    };
```

El 0xC000 es porque lo estás metiendo como preload. Si lo metes como un recurso normal y corriente ya tienes más jaleo porque habría que especificar como SCRIPT_PAGE la RAM donde acabe y en el array levels la dirección.

Todo esto parece muy complicao y tal pero fíte tú y date cuen que esto permitiría tener varios archivos de script en juegos muy tochos con muchos scripting. So podewr.
