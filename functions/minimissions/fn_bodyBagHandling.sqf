if (isServer) then {

        // body bag scanner
        ["ace_placedInBodyBag", {
                params ["_target", "_bodyBag"];
                diag_log format ["placedInBodyBag _target %1 - bodybag %2", _target, _bodyBag];

                private _position = getPosWorld _bodyBag;
                private _dir = getDir _bodyBag;
                private _bodyBagNew = createVehicle ["Land_Bodybag_01_black_F", [0,0,0], [], 0, "NONE"];
                _bodyBagNew setDir _dir;
                deleteVehicle _bodyBag;
                _bodyBagNew setPosWorld _position;

                private _name = [_target, false, true] call ace_common_fnc_getName;
                _bodyBagNew setVariable ["grad_minimissions_unitName", _name, true];

                [_bodyBagNew, 0.1] call ace_cargo_fnc_setSize;
                [_bodyBagNew, true, [0, -0.2, 1.6], 90] remoteExec ["grad_minimissions_fnc_bodyBagSetCarryable", 0, true];

                [_bodyBagNew] remoteExec ["grad_minimissions_fnc_bodyBagAction", 0, true];
                
                {
                        [_x, _bodyBagNew] remoteExecCall ["disableCollisionWith", 0, _x];
                        [_x, _bodyBagNew] remoteExecCall ["disableCollisionWith", 0, _bodyBagNew];
                } forEach playableUnits + switchableUnits;

        }] call CBA_fnc_addEventHandler;

};
