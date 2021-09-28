params ["_vehicle"];

(
	isEngineOn _vehicle && 
	{ getPosATL _vehicle select 2 < GRAD_ROTORWASH_MAX_HEIGHT } &&
    { speed _vehicle < 20 } &&
    { GRAD_ROTORWASH_ACTIVE }
)