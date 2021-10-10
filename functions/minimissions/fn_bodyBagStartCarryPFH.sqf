/*
 * Author: commy2, ripped by nomi
 * Carry PFH
 *
 * Arguments:
 * 0: ARGS <ARRAY>
 *  0: Unit <OBJECT>
 *  1: Target <OBJECT>
 *  2: Timeout <NUMBER>
 * 1: PFEH Id <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[player, target, 100], 20] call grad_minimissions_fnc_bodyBagStartCarryPFH;
 *
 * Public: No
 */


// systemChat format ["%1 startCarryPFH running", CBA_missionTime];

params ["_args", "_idPFH"];
_args params ["_unit", "_target", "_timeOut"];

// handle aborting carry
if (!(_unit getVariable ["grad_bodybag_isCarrying", false])) exitWith {
    [_unit, 1] remoteExec ["setAnimSpeedCoef"];
    diag_log format ["carry false %1 %2 %3",_unit,_target,_timeOut,CBA_missionTime];
    [_idPFH] call CBA_fnc_removePerFrameHandler;
};

// same as dragObjectPFH, checks if object is deleted or dead OR (target moved away from carrier (weapon disasembled))
if (!alive _target || {_unit distance _target > 10}) then {
    [_unit, 1] remoteExec ["setAnimSpeedCoef"];
    diag_log format ["dead/distance %1 %2 %3",_unit,_target,_timeOut,CBA_missionTime];
    [_unit, _target] call grad_minimissions_fnc_bodyBagDropObject;
    [_idPFH] call CBA_fnc_removePerFrameHandler;
};

if (CBA_missionTime > _timeOut) exitWith {
    [_unit, 1] remoteExec ["setAnimSpeedCoef"];
    diag_log format ["Start carry person %1 %2 %3",_unit,_target,_timeOut,CBA_missionTime];
    // no idea why only spawn works now
    [_unit, _target] spawn grad_minimissions_fnc_bodyBagCarryObject;

    [_idPFH] call CBA_fnc_removePerFrameHandler;
};

diag_log "carrypfh end";
