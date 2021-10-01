/*
 * Author: commy2, ripped by nomi
 * Handle the animaion for a Unit for Dragging Module
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: animaion <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit, "amovpercmstpsnonwnondnon"] call ace_dragging_fnc_handleAnimChanged;
 *
 * Public: No
*/

//IGNORE_PRIVATE_WARNING ["_thisArgs", "_thisID"]; // From CBA_fnc_addBISEventHandler;

params ["_unit", "_anim"];
_thisArgs params ["_realUnit"];

if (_unit != _realUnit) exitWith {
    diag_log format ["respawn (unit changed) - remove EH %1 %2",_unit,_realUnit];
    _unit removeEventHandler ["AnimChanged", _thisID];
};

if (_unit getVariable ["grad_bodybag_isCarrying", false]) then {

    // drop carried object when not standing; also some exceptions when picking up crate
    if (stance _unit != "STAND" && {_anim != "amovpercmstpsnonwnondnon"}) then {
        private _carriedObject = _unit getVariable ["grad_bodybag_carriedObject", objNull];

        if (!isNull _carriedObject) then {
            diag_log format ["stop carry %1 %2", _unit, _carriedObject];
            [_unit, _carriedObject] call grad_minimissions_fnc_bodyBagDropObject;
        };
    };
} else {
    diag_log format ["not drag/carry - remove EH %1",_unit];
    _unit removeEventHandler ["AnimChanged", _thisID];
};