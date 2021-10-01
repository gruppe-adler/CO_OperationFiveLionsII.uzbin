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


systemChat format ["%1 startCarryPFH running", CBA_missionTime];

params ["_args", "_idPFH"];
_args params ["_unit", "_target", "_timeOut"];

// handle aborting carry
if !(_unit getVariable ["grad_bodybag_isCarrying", false]) exitWith {
    diag_log format ["carry false %1 %2 %3",_unit,_target,_timeOut,CBA_missionTime];
    [_idPFH] call CBA_fnc_removePerFrameHandler;
};

// same as dragObjectPFH, checks if object is deleted or dead OR (target moved away from carrier (weapon disasembled))
if (!alive _target || {_unit distance _target > 10}) then {
    diag_log format ["dead/distance %1 %2 %3",_unit,_target,_timeOut,CBA_missionTime];
    [_unit, _target] call grad_minimissions_fnc_bodyBagDropObject;
    [_idPFH] call CBA_fnc_removePerFrameHandler;
};

// handle persons vs objects
if (_target isKindOf "CAManBase") then {
    if (CBA_missionTime > _timeOut) exitWith {
        diag_log format ["Start carry person %1 %2 %3",_unit,_target,_timeOut,CBA_missionTime];
        [_unit, _target] call grad_minimissions_fnc_bodyBagcarryObject;

        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
} else {
    if (CBA_missionTime > _timeOut) exitWith {
        diag_log format ["timeout %1 %2 %3",_unit,_target,_timeOut,CBA_missionTime];
        [_idPFH] call CBA_fnc_removePerFrameHandler;

        // drop if in timeout
        private _draggedObject = _unit getVariable ["grad_bodybag_draggedObject", objNull];
        [_unit, _draggedObject] call grad_minimissions_fnc_bodyBagDropObject;
    };

    // wait for the unit to stand up
    if (stance _unit isEqualto "STAND") exitWith {
        diag_log format ["Start carry object",_unit,_target,_timeOut,CBA_missionTime];
        [_unit, _target] call grad_minimissions_fnc_bodyBagcarryObject;

        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
};
