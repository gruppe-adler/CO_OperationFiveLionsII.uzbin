/*
    by nomisum
*/

// MAIN LOOP
[{
    params ["_args", "_handle"];
    _args params [];

    {
        [_x] call grad_rotorwash_fnc_adjustEmittersLocal;
    } forEach GRAD_ROTORWASH_VEHICLES_ACTIVE;

    // placeholder
    if (false) exitWith {
    	[_handle] call CBA_fnc_removePerFrameHandler;
    };
   
},0.5,[]] call CBA_fnc_addPerFrameHandler;