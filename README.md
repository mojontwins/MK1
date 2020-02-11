# MTE MK1 (la Churrera)

**MTE MK1** (más conocido como *la Churrera*) es un framework compuesto por un motor modular programado en C y ensamble, y un conjunto de herramientas para hacer juegos para ZX Spectrum. **MTE MK1** compila con z88dk 1.10 (incluido) y emplea una versión modificada de la biblioteca **splib2** de Alvin Albrecht.

El motor ha ido evolucionando desde 2010 y fue abandonado a principios de 2014 cuando evolucionó para convertirse en **MTE MK2**. Con motivo del décimo aniversario en 2020, se retomó el proyecto, actualizando, corrigiendo o reescribiendo distintas partes del motor y del toolchain.

# How to Build

Descarga la última release estable de la v5 de la carpeta "releases".

El motor / framework reside en `src`. El código, tal y como está, genera un juego mínimo por defecto que debes *remplazar* con el tuyo. Para compilarlo, sigue los siguientes pasos:

1. Descomprime la versión mínima de z88dk que encontrarás en `env/` en la raíz de `C:` (el archivo `env/z88dk10-stripped.zip`). Se creará un directorio `C:\z88dk10\` con los archivos del compilador.
2. Desde una ventana de linea de comandos, entra en `src/dev` y ejecuta los siguientes comandos:

```
	$ setenv.bat
	$ compile.bat
```

El primer comando establece las variables de entorno necesarias. El segundo construye y compila el juego de ejemplo.

# Documentación

Puedes encontrar documentación y un tutorial en el directorio `docs/`.

# Evolución

Por nuestra parte es posible que el motor sólo reciba correcciones, pero los pull request son muy bienvenidos.

# Créditos

**MTE MK1** ha sido diseñado y desarrollado por los **Mojon Twins** y utiliza:

* Una versión modificada de **splib2**, por **Alvin Albrecht**.
* Efectos de sonido y Phaser1 engine music player por **Shiru**.
* Decompresor appack por **dwedit**, adaptado por **Utopian** y optimizado por **Metalbrain**.
* Compresor para aplib [apultra](https://github.com/emmanuel-marty/apultra) por **Emmanuel Marty**
* WYZ Player por WYZ, modificado por **na_th_an** (compresión) y **thEpOpE** (FX con ruido).
* WYZ Tracker 0.5.0.2 por **Augusto Ruiz**.
* ROM-based tape loader y Gentape por **Antonio Villena**

# Licencia

La Churrera es copyleft The Mojon Twins y se distribuye bajo una [licencia LGPL](https://github.com/mojontwins/MK1/blob/master/LICENSE). Puedes hacer juegos como quieras, pero acuérdate de añadir el logo en un lugar visible, que así salimos beneficiados todos:

![Logo MTE MK1](https://github.com/mojontwins/MK1/blob/master/logo.png)

*Pero* si quieres hacer un juego con el motor entenderemos que quieras hacer copias físicas en cinta o en cualquier otro medio. En ese caso **sólo tienes que avisarnos**, que nos gusta saber estas cosas.

Los **juegos de ejemplo** contenidos en `examples/` son propiedad de **Mojon Twins** y no pueden ser reproducidos en formato físico sin llegar a un acuerdo con nostros.

Los **juegos realizados por otros desarrolladores** contenidos en `/contrib` son propiedad de sus respectivos desarrolladores y los derechos quedan reservados a los mismos.

Los **recursos gráficos y sonoros** de nuestros juegos son [donationware](https://en.wikipedia.org/wiki/Donationware). 

Si te gusta esto y aprecias la cantidad de horas que le hemos echado, [invita a un café](https://ko-fi.com/I2I0JUJ9).

Y lo más importante: pásalo guay.
