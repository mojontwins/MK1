# Capítulo 17: Scripting multilevel en 128K

(Esto es un borrador para que no se me olvide)

1. Primero haces el script con los `END_OF_LEVEL`, y lo compilas con el parámetro `rampage`. Esto debería generar una serie de macros en `msc-config.h` con los offsets al principio del script de cada nivel dentro del binario. Si usas `LEVELID` será más legible porque se usarán los identificadores que tú definas. Si no, generará macros llamadas `SCRIPT_xx`, con xx el número de nivel según el orden en el que se definan en el archivo de script, empezando por 0.

2. Luego el binario generado lo metes en un preload. Por ejemplo, en RAM4, para lo que lo llamarías `preload4.bin`. Así el librarian lo meterá al principio de RAM4 (a partir de la dirección 0xC000). *(tambien se puede meter como un resource normal y usar la dirección que le calcula el librarian, pero sería más complejo y pasando)*.

3. Seguidamente tienes que definir `SCRIPT_PAGE`. No está en `config.h` (lo solucionaré), pero se añade a mano, no pasa na. En nuestro caso, `#define SCRIPT_PAGE 4` para RAM4.

4. Finalmente, en el array `levels` de `my/levelset`, tienes que poner como dirección de cada script `0xC000 + offset`, donde el offset será la macro correspondiente generada por msc en `msc-config.h`. Por ejemplo, si has creado dos niveles y has puesto `LEVELID LEVEL_CASA` y `LEVELID LEVEL_BARCO` en el script, tendrías que usar `0xC000 + LEVEL_CASA` para el primer nivel y `0xC000 + LEVEL_BARCO` para el segundo.

El 0xC000 es porque lo estás metiendo como preload. Si lo metes como un recurso normal y corriente ya tienes más jaleo porque habría que especificar como SCRIPT_PAGE la RAM donde acabe y en el array levels la dirección.

Todo esto parece muy complicao y tal pero fíte tú y date cuen que esto permitiría tener varios archivos de script en juegos muy tochos con muchos scripting. So podewr.
