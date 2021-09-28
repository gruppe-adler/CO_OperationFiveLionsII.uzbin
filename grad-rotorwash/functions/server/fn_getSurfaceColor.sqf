params ["_point"];

private ["_colorR", "_colorG", "_colorB", "_alpha"];

// default colors, greyish
_colorR = 0.2; 
_colorG = 0.15; 
_colorB = 0.1;
_alpha = 0.8;

switch (surfaceType _point) do {
	case "#GdtDesert": { _colorR = 0.3; _colorG = 0.25; _colorB = 0.2; _alpha = 1; };
    case "#gbr_es_tierra2": { _colorR = 0.3; _colorG = 0.25; _colorB = 0.2; _alpha = 1; };

    case "#tem_kujari_tumma_hiekka_Surface": { _colorR = 0.35; _colorG = 0.25; _colorB = 0.2; _alpha = 1; };
    case "#tem_kujari_keltainen_hiekka_Surface": { _colorR = 0.35; _colorG = 0.27; _colorB = 0.26; _alpha = 1; };
    case "#tem_kujari_vaalea_hiekka_Surface": { _colorR = 0.35; _colorG = 0.27; _colorB = 0.26; _alpha = 1; };

	case "#GdtStratisConcrete": { _colorR = 0.7; _colorG = 0.65; _colorB = 0.6; _alpha = 0.1; };

	case "#ZRPolopoust": { _colorR = 0.25; _colorG = 0.23; _colorB = 0.21; _alpha = 1; /* zarga desert */ };
	case "#ZRTrava": { _colorR = 0; _colorG = 0; _colorB = 0; _alpha = 0; /* zarga grass */ };
	case "#ZRSterkNaDno": { _colorR = 0.9; _colorG = 0.9; _colorB = 0.9; _alpha = 0.1; /* zarga brown grass */ };
	case "#ZRHlina": { _colorR = 0.25; _colorG = 0.23; _colorB = 0.21; _alpha = 0.2; /* zarga brown grass */ };

	default { _colorR = 0.35; _colorG = 0.25; _colorB = 0.2; _alpha = 0.5; };
};

// systemChat format ["surfaceType is %1", surfaceType _point];

// grad_transparency = _alpha; // todo: make this less abysmal

[_colorR, _colorG, _colorB, _alpha]