# de v5 a v6

Si estás modificando tu juego para adaptarlo a V6, tienes que tener en cuenta que hemos hecho un cambio bastante drástico: ahora el punto fijo es de 12.4 en lugar de 10.6 como en las versiones anteriores. Tendrás que adaptar todas las velocidades y valores de movimientos que afecten al punto fijo: los fantis, los valores del jugador, y todo lo custom que hayas puesto tú que use este sistema. Para las velocidades podrás dividir entre 4. Para las aceleraciones puedes empezar dividiendo entre 4, pero probablemente tengas que ajustar a mano un poco para obtener el mismo comportamiento.

Además, las variables de velocidad son `signed char`, lo que significa que los valores podrán oscilar entre -128 y 127.

El motivo es sencillo: más velocidad, menos bytes.
