# Capítulo 10: Música y FX (48K)

En este capítulo veremos como cambiar la música y los efectos de sonido (de 48K) en nuestros juegos. Cambiar la música es trivial. Cambiar los sonidos puede ser muy fácil o muy laborioso. Vamos al rock.

Descárgate los materiales de este capítulo (básicamente, el proyecto Beepola con la música de **Dogmole**):

[Material del capítulo 10](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-zip/churreratut-capitulo10.zip)

## Cambiando la música

Para poder cambiar la música de un juego necesitamos disponer de la misma y de su player en formato de código fuente. Puede hacerse de otras maneras (como en los inicios, cuando usábamos *Wham! The Music Box*) pero es un dolor. En la actualidad existen varias formas de componer música 1 bit para Spectrum en programas que se ejecutan en nuestros PC y exportan el código del player y la música en un bonito archivo .asm, como **Beepola**.

**Beepola** ([link](http://freestuff.grok.co.uk/beepola/)) es un tracker de toda la vida que es capaz de manejar varios players. Puedes elegir el que quieras **siempre que no necesite cosas extrañas como estar ubicado en un sitio concreto o necesitar un manejador de interrupciones**. Por ejemplo, nosotros solemos usar **Phaser - Digital Drums** que suena muy bien, permite algunas chiribitas, y tiene una percusión potente y que no ocupa un montón.

No vamos a explicar aquí cómo se maneja Beepola. Si eres músico te harás rápido con el programa, y si no lo eres, seguro que tu amigo el músico sabe usarlo. Solo nos detendremos en la parte que nos interesa: la **exportación**. Si quieres practicar ya puedes probar a cargar el achivo `dogmole.bbsong` que incluimos con este capítulo y seguir las indicaciones a partir de aquí.