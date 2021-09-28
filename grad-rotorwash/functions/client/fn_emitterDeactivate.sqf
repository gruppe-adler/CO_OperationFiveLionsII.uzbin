params ["_vehicle"];

private _emitters = _vehicle getVariable ["grad_rotorwash_emittersActive", []];

{
	deleteVehicle _x;
} forEach _emitters;

_vehicle setVariable ["grad_rotorwash_emittersActive", []];

/*systemChat "deleting emitters";*/