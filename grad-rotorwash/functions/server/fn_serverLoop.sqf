// now client loop
[{

    {
        // check if veh should be active
        if ([_x] call grad_rotorwash_fnc_isActive && GRAD_ROTORWASH_ACTIVE) then {
                
            if (!(_x in GRAD_ROTORWASH_VEHICLES_ACTIVE)) then {

                // add vehicle to active list and activate emitters on clients
                GRAD_ROTORWASH_VEHICLES_ACTIVE = GRAD_ROTORWASH_VEHICLES_ACTIVE + [_x];
                publicVariable "GRAD_ROTORWASH_VEHICLES_ACTIVE";

                private _point = [_x] call grad_rotorwash_fnc_getWashOrigin;
                private _color = [_point] call grad_rotorwash_fnc_getSurfaceColor;
                [_x, _point, _color] call grad_rotorwash_fnc_adjustParams;
                [_x] remoteExecCall ["grad_rotorwash_fnc_emitterActivate", [0,-2] select isDedicated];

            } else {
            
                // adjust emitter color
                private _point = [_x] call grad_rotorwash_fnc_getWashOrigin;
                private _color = [_point] call grad_rotorwash_fnc_getSurfaceColor;

                [_x, _point, _color] call grad_rotorwash_fnc_adjustParams;
            };
        } else {
            // do nothing for helis without reason
            if (_x in GRAD_ROTORWASH_VEHICLES_ACTIVE) then {

                // remove vehicle from active list and deactivate emitters on clients
                GRAD_ROTORWASH_VEHICLES_ACTIVE = GRAD_ROTORWASH_VEHICLES_ACTIVE - [_x];
                publicVariable "GRAD_ROTORWASH_VEHICLES_ACTIVE";
                [_x] remoteExecCall ["grad_rotorwash_fnc_emitterDeactivate", [0,-2] select isDedicated];  
            };
        };

    } forEach GRAD_ROTORWASH_VEHICLES_SUPPORTED;

    // placeholder
    if (false) exitWith {
    	[_handle] call CBA_fnc_removePerFrameHandler;
    };
   
},0.25,[]] call CBA_fnc_addPerFrameHandler;