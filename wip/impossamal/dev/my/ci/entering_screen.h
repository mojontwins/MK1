// MTE MK1 (la Churrera) v5.10
// Copyleft 2010-2014, 2020-2023 by the Mojon Twins

_gp_gen = 0;

if (flags[1] == 10) flags [2] = 1;

switch (n_pant) {
    case 24:
    	if (flags [2]) {
			textbox (4);
			flags [3]=1;
		} 
        _gp_gen = (unsigned char *) (decos_24);
        break;
}

if (_gp_gen) draw_decorations ();
