params ["_vehicle", "_point", "_color"];

_vehicle setVariable ["grad_rotorwash_colors", _color];

_color params ["_grad_colorR", "_grad_colorG", "_grad_ColorB", "_grad_alpha"];

private _height = (getPosATL (_vehicle)) select 2;
private _speed = speed _vehicle;

private _alpha = 1 - (0.025*_height);// * _grad_alpha;

if (_speed < 1) then {
	_timer = _vehicle getVariable ["grad_rotorwash_emitterStatic", 0];
	_timer = _timer + 1;
	_vehicle setVariable ["grad_rotorwash_emitterStatic", _timer];

	if (_timer > 30) then {
		_alpha =  _alpha/4;
	} else {
		if (_timer > 20) then {
			_alpha = _alpha/3;
		} else {
			if (_timer > 10) then {
				_alpha = _alpha/2;
			} else {
				if (_timer > 5) then {
					_alpha = _alpha/1.5;
				};
			};
		};
	};
} else {
	_vehicle setVariable ["grad_rotorwash_emitterStatic", 0, true];
};

private _washParticleCircle = [15 - random 3, [1, 1, 0]];
private _washParticleParams = [
		["\A3\data_f\cl_basic", 1, 0, 1],
		 "", "Billboard", 1, grad_lifetime, 
		 [0, 0, 0], 
		 [0, 0, grad_uplift], 1, 
		 grad_weight,
		 grad_volume,
		 grad_rubbing,
		 [6, 7, 8, 9, 13], 
		 [
		 	[_grad_colorR/4, _grad_colorG/4, _grad_colorB/4, 0],
		 	[_grad_colorR/3, _grad_colorG/3, _grad_colorB/3, 0.7 * _alpha],
		 	[_grad_colorR/2, _grad_colorG/2, _grad_colorB/2, 0.6 * _alpha],
		 	[_grad_colorR/1.2, _grad_colorG/1.2, _grad_colorB/1.2, 0.5 * _alpha],
		 	[_grad_colorR, _grad_colorG, _grad_colorB, 0.4 * _alpha],
		 	[_grad_colorR*1.5, _grad_colorG*1.5, _grad_colorB*1.5, 0.3 * _alpha/2],
		 	[_grad_colorR*2, _grad_colorG*2, _grad_colorB*2, 0]
		 ], 
		 [1000], 0, 0, "", "", "", 0, true, grad_bounce];

private _washParticleRandom = [0.5,[1,1,0.5],[0,0,0],2,0.5,[0,0,0,0],1,1,0];


private _lingerParticleCircle = [13 - random 3, [0, 0, 0]];
private _lingerParticleParams = [
		["\A3\data_f\cl_basic", 1, 0, 1],
		 "", "Billboard", 1, grad_rotorwash_linger_lifetime, 
		 [0, 0, 0], 
		 [0, 0, grad_rotorwash_linger_uplift], 0.3, 
		 grad_rotorwash_linger_weight,
		 grad_rotorwash_linger_volume,
		 grad_rotorwash_linger_rubbing,
		 [20, 23, 25, 40, 50], 
		 [
		 	
		 	[_grad_colorR, _grad_colorG, _grad_colorB, 0],
		 	[_grad_colorR, _grad_colorG, _grad_colorB, 0.2 * _alpha],
		 	[_grad_colorR*1.2, _grad_colorG*1.2, _grad_colorB*1.2, 0.1 * _alpha],
		 	[_grad_colorR*1.5, _grad_colorG*1.5, _grad_colorB*1.5, 0.05 * _alpha],
		 	[_grad_colorR*2, _grad_colorG*2, _grad_colorB*2, 0]
		 ], 
		 [0.08], 0, 0, "", "", ""];

private _lingerParticleRandom = [0.5,[1,1,0.5],[0,0,0],0,0.2,[0,0,0,0],0,0,0];

_vehicle setVariable ["GRAD_rotorWash_linger", [
	_point,
	_lingerParticleCircle,
	_lingerParticleParams,
	_lingerParticleRandom
], true];

_vehicle setVariable ["GRAD_rotorWash_wash", [
	_point,
	_washParticleCircle,
	_washParticleParams,
	_washParticleRandom
], true];