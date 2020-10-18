# de v5 a v6

Si estás modificando tu juego para adaptarlo a V6, tienes que tener en cuenta que hemos hecho un cambio bastante drástico: ahora el punto fijo es de 12.4 en lugar de 10.6 como en las versiones anteriores. Tendrás que adaptar todas las velocidades y valores de movimientos que afecten al punto fijo: los fantis, los valores del jugador, y todo lo custom que hayas puesto tú que use este sistema. Para las velocidades podrás dividir entre 4. Para las aceleraciones puedes empezar dividiendo entre 4, pero probablemente tengas que ajustar a mano un poco para obtener el mismo comportamiento.

Además, las variables de velocidad son `signed char`, lo que significa que los valores podrán oscilar entre -128 y 127.

El motivo es sencillo: más velocidad, menos bytes.

## Limitador de faps

Puedes poner un "cap" a tu juego de forma que no vaya a más de N fps, con N = 50/M, siendo M el valor que se configura en la directiva `MIN_FAPS_PER_FRAME`. Un valor bastante realista es 2 en juegos con sprites de 16x16 y no demasiada acción, lo que daría una velocidad máxima de N = 50/2 = 25 fps. Con esto conseguimos que las pantallas menos pobladas no den un aceleron que se note demasiado. 

Pantallas con más enemigos que tengan trayectorias horizontales, disparos y cocos son más lentas de dibujar que pantallas con menos enemigos. `MIN_FAPS_PER_FRAME` te puede ayudar a que todo el juego se *sienta* a la misma velocidad.

Activar esta directiva es básicamente *gratis* en modo 128K, pero en Modo 48K cuesta algo más de 200 bytes. Para contar frames se usa un *ISR* en modo IM 2 del Z80. En modo 48K se hace de forma *maqueijan* sin la tabla de 257 valores iguales, lo cual debería funcionar en el 99% de los casos a menos que tengas cosas raras enchufadas (que no suele ser lo normal en el siglo XXI).
