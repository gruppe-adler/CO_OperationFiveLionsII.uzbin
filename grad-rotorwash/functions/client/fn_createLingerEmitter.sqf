params ["_vehicle"];

private _linger = "#particlesource" createVehicleLocal [
	0,
	0,
	0
];  

private _lingerSettings = _vehicle getVariable ["GRAD_rotorWash_linger", [
    [],
    [],
    [],
    []
]];

_lingerSettings params ["_lingerPos", "_lingerParticleCircle", "_lingerParticleParams", "_lingerParticleRandom"];

_linger setPos _lingerPos;
_linger setParticleCircle _lingerParticleCircle;
_lingerParticleParams set [18, _linger];
_linger setParticleParams _lingerParticleParams;
// _linger setParticleRandom _lingerParticleRandom;

_linger setDropInterval 0.05;

_linger