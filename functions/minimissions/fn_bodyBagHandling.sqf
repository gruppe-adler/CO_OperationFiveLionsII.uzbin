if (isServer) then {

        // body bag scanner
        ["ace_placedInBodyBag", {
                params ["_target", "_bodyBag"];
                diag_log format ["placedInBodyBag _target %1 - bodybag pos %2", _target, getpos _bodyBag];

                // ace one might get created at 0,0,0 as well - wait for bodybag to be somewhere else
                [{
                        params ["_target", "_bodyBag"];
                        ((getPosWorldVisual _bodyBag) select 0) > 10
                },
                {
                        params ["_target", "_bodyBag"];
                        diag_log format ["placedInBodyBag2 _target %1 - bodybag pos %2", _target, getpos _bodyBag];

                        private _position = getPosWorldVisual _bodyBag;
                        private _dir = getDir _bodyBag;
                        _bodyBag setPos [0,0,0];
                        private _bodyBagNew = createVehicle ["Land_Bodybag_01_black_F", [0,0,0], [], 0, "NONE"];
                        _bodyBagNew setDir _dir;
                        _bodyBagNew setPosWorld _position;
                        
                        [{ 
                                params ["_bodyBag"];
                                deleteVehicle _bodyBag;
                        }, [_bodyBag], 3] call CBA_fnc_waitAndExecute;

                        private _name = [_target, false, true] call ace_common_fnc_getName;
                        _bodyBagNew setVariable ["grad_minimissions_unitName", _name, true];

                        [_bodyBagNew, 0.1] call ace_cargo_fnc_setSize;
                        [_bodyBagNew, true, [0, -0.2, 1.6], 90] remoteExec ["grad_minimissions_fnc_bodyBagSetCarryable", 0, true];

                        [_bodyBagNew] remoteExec ["grad_minimissions_fnc_bodyBagAction", 0, true];
                        
                        {
                                [_x, _bodyBagNew] remoteExecCall ["disableCollisionWith", 0, _x];
                                [_x, _bodyBagNew] remoteExecCall ["disableCollisionWith", 0, _bodyBagNew];
                        } forEach playableUnits + switchableUnits;
                }, [_target, _bodyBag]] call CBA_fnc_waitUntilAndExecute;

        }] call CBA_fnc_addEventHandler;
};
