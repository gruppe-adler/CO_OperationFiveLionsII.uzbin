/*
*   Wird zum Missionsstart auf Server und Clients ausgeführt.
*   Funktioniert wie die init.sqf.
*/

[] execVM "USER\modules\addModules.sqf";
[] execvm "USER\markCustomHouses\markCustomHouses.sqf";

if (!isServer) exitWith {};

["GRAD_missionControl_setServerAsOwner", {
    params ["_group"];

    //make unit editable for all zeus
    if([_group] isEqualTypeParams [grpNull])then{
        {
            _x addCuratorEditableObjects [units _group, true];
        } forEach (entities "moduleCurator_F");
    };


    // change owner to server
    _group setGroupOwner 2;


    // reapply loadout if necessary
    [{
        params ["_group"];

        // setunitloadout class as a fallback, if unit is naked
        {
            if ((uniform _x) isEqualTo "") then {
                _x setUnitLoadout (typeOf _x);
            };
        } forEach units _group;
    }, [_group], 3] call CBA_fnc_waitAndExecute;
   
}] call CBA_fnc_addEventHandler;