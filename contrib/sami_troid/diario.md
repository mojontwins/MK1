20200204
========

Sami Troid es interesante porque tiene muchas pantallas (8x9) y tendré que usar un decoder custom de mapa (por ejemplo, en RLE62, aunque se podría intentar adaptar el comprimido de Villena, ya lo veré).

Lo primero es obtener los assets en formato estándar, que está todo en tmx y aledaños y por ahora necesito trabajar en mi propio campo. 

Los enemigos los he sacado rápidamente pillando el `enems.h` que hay en el `/dev` original y usando el viejo conversor que escribí para no sé qué, el `h2ene.h`, que me ha rescatado un `.ene` inexistente. El segundo paso ha sido obtener el mapa: he compilado `tmxcnv.c` de Antonio Villena y he obtenido el mapa en código. A partir de ahí he tenido que hacerme un conversor para desordenar las pantallas y hacer un rectángulo grande, pero ha sido cosa fásil.

El descompresor de RLE62 lo pillo directamente de ese **Tenebra Macabre** que debería ir retomando un día de estos (pronto), que debería funcionar con muy pocos cambios.

