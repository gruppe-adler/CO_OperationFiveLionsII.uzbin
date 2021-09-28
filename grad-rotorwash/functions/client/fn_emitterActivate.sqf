params ["_vehicle"];

private _linger = [_vehicle] call grad_rotorwash_fnc_createLingerEmitter;
private _wash = [_vehicle] call grad_rotorwash_fnc_createWashEmitter;

_vehicle setVariable ["grad_rotorwash_emittersActive", [_linger, _wash]];

/*
systemChat "activating emitters";
diag_log format ["activating emitters"];
*/