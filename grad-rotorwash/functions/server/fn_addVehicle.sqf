/*
 
 	adder fnc for supported vehicles

*/

params ["_vehicle"];

if (_vehicle in GRAD_ROTORWASH_VEHICLES_SUPPORTED) exitWith { 
	diag_log format ["%1 already supported by grad_rotorwash", _vehicle]; 
};

if (!(_vehicle isKindOf 'Air')) exitWith {
	diag_log format ["%1 is no heli - canceling grad_rotorwash", _vehicle]; 	
};

GRAD_ROTORWASH_VEHICLES_SUPPORTED = GRAD_ROTORWASH_VEHICLES_SUPPORTED + [_vehicle];