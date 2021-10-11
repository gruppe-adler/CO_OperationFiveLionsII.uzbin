["Five Lions", "Show Intro Start", {
     ["intro2.paa", 15, 3] remoteExec ["USER\customCam\fn_showIntro.sqf", 0];
}] call zen_custom_modules_fnc_register;


["Five Lions", "Show Intro Raid 1", {
     ["firstraid.paa", 15, 3] remoteExec ["USER\customCam\fn_showIntro.sqf", 0];
}] call zen_custom_modules_fnc_register;


["Five Lions", "Show Intro Raid 2", {
     ["secondraid.paa", 15, 3] remoteExec ["USER\customCam\fn_showIntro.sqf", 0];
}] call zen_custom_modules_fnc_register;

["Five Lions", "Show Intro Convoy", {
     ["convoyraid.paa", 15, 3] remoteExec ["USER\customCam\fn_showIntro.sqf", 0];
}] call zen_custom_modules_fnc_register;


["Five Lions", "Convert to Taliban Flag", {
     params ["_position", "_object"];

     if (isNull _object) then {
            private _flags = nearestObjects [ASLtoAGL _position, ["FlagCarrierCore"], 50];
            if (count _flags > 0) then {
                _flags params ["_flag"];

                _flag setFlagTexture "data\tali_flag.paa";
            } else {
                private _vehicles = nearestObjects [ASLtoAGL _position, ["AllVehicles"], 50];
                if (count _vehicles > 0) then {
                    _vehicles params ["_vehicle"];
                    _vehicle forceFlagTexture "data\tali_flag.paa";
                } else {
                    hint "no flag or vehicle found";
                };
        };
     } else {
        if (_flag isKindOf "FlagCarrierCore") then {
            _flag setFlagTexture "data\tali_flag.paa";
        } else {
            hint "no flag found";
        };
    };
}] call zen_custom_modules_fnc_register;


["Five Lions", "Convert to Afghan Army Flag", {
     params ["_position", "_object"];

     if (isNull _object) then {
            private _flags = nearestObjects [ASLtoAGL _position, ["FlagCarrierCore"], 50];
            if (count _flags > 0) then {
                _flags params ["_flag"];

                _flag setFlagTexture "data\flag3.paa";
            } else {
                private _vehicles = nearestObjects [ASLtoAGL _position, ["AllVehicles"], 50];
                if (count _vehicles > 0) then {
                    _vehicles params ["_vehicle"];
                    _vehicle forceFlagTexture "data\flag3.paa";
                } else {
                    hint "no flag or vehicle found";
                };
        };
     } else {
        if (_flag isKindOf "FlagCarrierCore") then {
            _flag setFlagTexture "data\flag3.paa";
        } else {
            hint "no flag found";
        };
    };
}] call zen_custom_modules_fnc_register;




{

    _x addEventHandler ["CuratorGroupPlaced", {
        params ["", "_group"];
        ["GRAD_missionControl_setServerAsOwner", [_group]] call CBA_fnc_serverEvent;

        {
            _x setSkill ["aimingShake", 0.2];
            _x setSkill ["aimingSpeed", 0.9];
            _x setSkill ["endurance", 0.6];
            _x setSkill ["spotDistance", 1];
            _x setSkill ["spotTime", 0.9];
            _x setSkill ["courage", 1];
            _x setSkill ["reloadSpeed", 1];
            _x setSkill ["commanding", 1];
            _x setSkill ["general", 1];

        } forEach units _group;
    }];

    _x addEventHandler ["CuratorObjectPlaced", {
        params ["", "_object"];


        _object setSkill ["aimingShake", 0.2];
        _object setSkill ["aimingSpeed", 0.9];
        _object setSkill ["endurance", 0.6];
        _object setSkill ["spotDistance", 1];
        _object setSkill ["spotTime", 0.9];
        _object setSkill ["courage", 1];
        _object setSkill ["reloadSpeed", 1];
        _object setSkill ["commanding", 1];
        _object setSkill ["general", 1];



        if (_object isKindOf "CAManBase") then {
            if (count units _object == 1) then {
                ["GRAD_missionControl_setServerAsOwner", [group _object]] call CBA_fnc_serverEvent;
            };
        } else {
            if (count crew _object > 1) then {
                ["GRAD_missionControl_setServerAsOwner", [group (crew _object select 0)]] call CBA_fnc_serverEvent;
            };
        };
    }];
} forEach allCurators;