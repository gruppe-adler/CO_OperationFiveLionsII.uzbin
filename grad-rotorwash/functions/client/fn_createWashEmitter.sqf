params ["_vehicle"];

private _wash = "#particlesource" createVehicleLocal [
	0,
	0,
	0
];  

private _washSettings = _vehicle getVariable ["GRAD_rotorWash_wash", [
    [],
    [],
    [],
    []
]];

_washSettings params ["_washPos", "_washParticleCircle", "_washParticleParams", "_washParticleRandom"];

_wash setPos _washPos;
_wash setParticleCircle _washParticleCircle;
_washParticleParams set [18, _wash];
_wash setParticleParams _washParticleParams;
// _wash setParticleRandom _washParticleRandom;

_wash setDropInterval 0.04;

_wash