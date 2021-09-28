/*
 
 	remover fnc for supported vehicles

*/

params ["_vehicle"];

if (!(_vehicle in GRAD_ROTORWASH_VEHICLES_SUPPORTED)) exitWith {
	diag_log format ["%1 not found in grad_rotorwash vehicles", _vehicle];
};

GRAD_ROTORWASH_VEHICLES_SUPPORTED = GRAD_ROTORWASH_VEHICLES_SUPPORTED - [_vehicle];