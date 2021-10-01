params ["_bodybag"];

private _displayName = "Respawn casualty";
private _action = ["grad_minimissions_respawnAction", _displayName, "\A3\ui_f\data\igui\cfg\actions\heal_ca.paa", {

    if (_target distance2D (getMarkerPos "respawn_west") > 100) exitWith {
        hint "Get Closer to Graveyard in FOB.";
    };
    
    private _deadStoredName = _target getVariable ["grad_minimissions_unitName", ""];
    {
        private _deadUnit = _x;
        private _currentName = [_deadUnit, false, true] call ace_common_fnc_getName;
        if (_currentName == _deadStoredName) exitWith {
            [_target, _deadUnit] remoteExec ["grad_minimissions_fnc_respawnPlayer", _deadUnit];
            
            private _worldPosition = getPosWorld _target;
            private _dir = getDir _target;

            private _coffin = createVehicle ["Coffin_02_Flag_F", [0,0,0], [], 0, "NONE"];
            _coffin setObjectTextureGlobal [2, "data\flag3.paa"];
            _coffin setDir _dir;
            _coffin setPosWorld _worldPosition;

            [_coffin, true, [0, 2, 0.26], 0] remoteExec ["ace_dragging_fnc_setDraggable", 0, true];

            if (!(missionNamespace getVariable ["lamentPlaying", false])) then {
                playSound3D [getMissionPath "data\lament.ogg", _coffin, false, getPosASL _coffin, 1, 1, 100];
                missionNamespace setVariable ["lamentPlaying", true, true];
                [{ missionNamespace setVariable ["lamentPlaying", false, true]; }, [], 39] call CBA_fnc_waitAndExecute;
            };
            deleteVehicle _target;

        };
    } forEach allDead;
    
}, {(_target getVariable ["grad_minimissions_unitName", ""]) != "" && _target distance2D (getMarkerPos "respawn_west") < 100}] call ace_interact_menu_fnc_createAction;

[_bodybag, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

private _displayName = "Respawn casualty (DONE)";
private _action = ["grad_minimissions_respawnAction", _displayName, "\A3\ui_f\data\igui\cfg\actions\heal_ca.paa", {
    
    hint "already respawned";
}, {(_target getVariable ["grad_minimissions_unitName", ""]) == ""}] call ace_interact_menu_fnc_createAction;
[_bodybag, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;


private _displayName = "Too far away from graveyard to respawn";
private _action = ["grad_minimissions_respawnAction", _displayName, "\A3\ui_f\data\igui\cfg\actions\heal_ca.paa", {
    
    hint "Too far away from graveyard to respawn";
}, {(_target getVariable ["grad_minimissions_unitName", ""]) != "" && _target distance2D (getMarkerPos "respawn_west") >= 100}] call ace_interact_menu_fnc_createAction;
[_bodybag, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;