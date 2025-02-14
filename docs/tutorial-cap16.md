# Capítulo 16: Más de 16 gráficos para *sprites*

Añadir más gráficos es relativamente sencillos si utilizamos `sprcnv2.exe`, que generará todos los que necesitemos:

```
$ ..\utils\sprcnv2.exe
** USO **
   sprcnv2 archivo.png archivo.h n [extra] [nomask]

Convierte un Spriteset de n sprites
```

Para MK1 tendremos que especificar el parámetro `extra`. De esta forma, los identificadores generados para los *sprites* más allá del 16 llevarán `extra_` antes, y no habrá colisión con `sprite_17_*`, `sprite_18_*` y `sprite_19_*` que ya se utilizan. Esto es lo que pasa cuando se añaden características cuando el diseño está cerrado y no se quieren romper muchas cosas (o salen padrastros que no te dejan ponerte a rehacer cosas).

En resumen, si haces que tu spriteset tenga más de 16 gráficos (siempre en filas de a 8, siguiendo el mismo formato que hasta ahora), tendrás que usar `sprcnv2` en lugar de `sprcnv` y añadir el número de gráficos que quieres importar y el parámetro extra. Los *sprites* del 17 en adelante estarán apuntados por etiquetas del rollo `extra_sprite_17_a`.

Vamos a ver todo esto en movimiento con un ejemplo práctico que vendrá muy bien a más de uno. Pero antes de ponernos a esto quiero recordar que cada gráfico de *sprite* ocupa 144 bytes, así que hay que pensarse bien si añadir más... y cuántos añadir. Mejor en modo 128K.

## Haciendo que enemigos miren a izquierda o derecha

Pudiendo importar más *sprites*, podríamos usarlo para animaciones del personaje principal, o para nuevos tipos de enemigos que nos inventemos y añadamos. También podemos hacer lo que dice el título: parchear el motor vía inyección de código para hacer que enemigos miren a izquierda o a derecha. Esto puede implementarse de mil formas. La que exponemos aquí es solo una de ellas. Vamos a organizar así nuestro spriteset: 

![Extra sprites](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/16_extra_sprites.png)

Como veis, en la fila "normal" de *sprites* para los enemigos van las versiones de los enemigos andando hacia la derecha, y en la fila extra va lo mismo, pero mirando hacia la izquierda.

Lo primero que tenemos que hacer es meterlos en nuestro juego. En `compile.bat` sustituiremos la llamada normal a `sprcnv.exe` por una a `sprcnv2.exe` que tenga este aspecto:

```
    ..\utils\sprcnv2.exe ..\gfx\sprites.png assets\sprites.h 24 extra > nul
```

Como vemos, la llamada es muy parecida, pero se añade `24`, que es el número total de gráficos para *sprites*, y `extra`, por la ñapa que hemos dicho antes. Esto hará que en `sprites.h`, además de los 16 originales (señalados por los identificadores `sprite_1_a` hasta `sprite_16_a`) tengamos 8 más, señalados por los identificadores `extra_sprite_17_a` hasta `extra_sprite_24_a`.

Para manejarnos cómodamente con ellos los vamos a meter en un array muy parecido al que **MTE MK1** utiliza para identificar a los *sprite* de los enemigos. Este array lo añadiremos en `my/ci/extra_vars.h` y simplemente listará en orden los gráficos **extra**:

```c
    // extra_vars.h

    const unsigned char *extra_enem_cells [] = {
        extra_sprite_17_a, extra_sprite_18_a, extra_sprite_19_a, extra_sprite_20_a,
        extra_sprite_21_a, extra_sprite_22_a, extra_sprite_23_a, extra_sprite_24_a
    };
```

Hecho esto, utilizaremos `my/ci/enems_extra_actions.h` para cambiar el sprite calculado para los enemigos cuando andan hacia la izquierda o hacia arriba

```c
    // enems_extra_actions.h
if (active) {
    if (_en_mx < 0 || _en_my < 0) {
        en_an_next_frame [enit] = extra_enem_cells [en_an_base_frame [enit] + en_an_frame [enit]];
    }
}
```

`en_an_base_frame [enit]` vale 0, 2, 4 o 6 dependiendo del tipo del enemigo (1 a 4) y `en_an_frame [enit]` va haciendo *flip-flop* cambiando entre 0 y 1 cada 4 cuadros. Lo que hacemos es que, si el muñeco va hacia la izquierda o hacia arriba, elegimos el sprite de nuestro nuevo array `extra_enems_cells`. En caso contrario, `en_an_next_frame` tendrá el valor estándar obtenido de `enem_cells` (que es el comportamiento natural de **MTE MK1**).

Ahora nos toca agregar `active = 0` esta linea de `engine/enengine.h`:

```c

								dec (hl)
						#endif	

							// if (_en_life == 0) {
							ld  a, (__en_life)
							or  a
							jp  nz, enems_collide_bullets_sound
					#endasm

					enems_draw_current ();
					sp_UpdateNow ();
					active = 0;  // <- esta

```

## Y listo

Como veis, esto que tanto me habéis pedido es muy fácil de conseguir en V5.
