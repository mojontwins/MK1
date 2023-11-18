// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

flags[1] = 0; //variable para almacenar el número de cristales
flags[2] = 0; //variable para indicar si hemos conseguido los 10 cristales
flags[3] = 0; //variable para indicar si hemos hablado ya con el ulises

//MOSTRAMOS EL PRIMER TEXTO, ASÍ EXPLICAMOS DE QUÉ VA EL JUEGO
PLAY_MUSIC (1);
blackout_area();
textbox(0);
blackout_area();
textbox(1);
blackout_area();
textbox(2);
blackout_area();
textbox(3);
beep_fx(10);