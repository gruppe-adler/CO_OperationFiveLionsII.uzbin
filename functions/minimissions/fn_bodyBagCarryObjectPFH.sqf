/*
 * Author: commy2, ripped by nomi
 * PFH for Carry Object
 *
 * Arguments:
 * 0: ARGS <ARRAY>
 *  0: Unit <OBJECT>
 *  1: Target <OBJECT>
 *  2: Start time <NUMBER>
 * 1: PFEH Id <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[player, target], 20] call ace_minimissions_fnc_bodyBagCarryObjectPFH;
 *
 * Public: No
 */


// systemChat format ["%1 carryObjectPFH running", CBA_missionTime];


params ["_args", "_idPFH"];
_args params ["_unit", "_target", "_startTime"];

if (!(_unit getVariable ["grad_bodybag_isCarrying", false])) exitWith {
    diag_log format ["carry false %1 %2",_unit,_target];
    [_idPFH] call CBA_fnc_removePerFrameHandler;
};

// drop if the crate is destroyed OR (target moved away from carrier (weapon disasembled))
if (!alive _target || {_unit distance _target > 10}) then {
    diag_log format ["dead distance %1 %2",_unit,_target];
    if ((_unit distance _target > 10) && {(CBA_missionTime - _startTime) < 1}) exitWith {
        //attachTo seems to have some kind of network delay and target can return an odd position during the first few frames,
        //so wait a full second to exit if out of range (this is critical as we would otherwise detach and set it's pos to weird pos)
        diag_log format ["ignoring bad distance at start %1 %2",_unit distance _target,_startTime,CBA_missionTime];
    };
    [_unit, _target] call grad_minimissions_fnc_bodybagDropObject;
    [_idPFH] call CBA_fnc_removePerFrameHandler;
};
