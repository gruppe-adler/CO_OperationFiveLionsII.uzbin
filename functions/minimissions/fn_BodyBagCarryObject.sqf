/*
 * Author: commy2, ripped by nomi
 * Carry an object.
 *
 * Arguments:
 * 0: Unit that should do the carrying <OBJECT>
 * 1: Object to carry <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call grad_minimissions_fnc_bodyBagCarryObject;
 *
 * Public: No
 */

params ["_unit", "_target"];

// get attachTo offset and direction.

private _position = _target getVariable ["grad_bodybag_carryPosition", [0, 0, 0]];
private _direction = _target getVariable ["grad_bodybag_carryDirection", 0];

// handle objects vs persons
if (_target isKindOf "CAManBase") then {

    [_unit, "AcinPercMstpSnonWnonDnon", 2] call ace_common_fnc_doAnimation;
    [_target, "AinjPfalMstpSnonWnonDf_carried_dead", 2] call ace_common_fnc_doAnimation;

    // attach person
    _target attachTo [_unit, _position, "LeftShoulder"];

} else {

    // add height offset of model
    private _offset = (_target modelToWorldVisual [0, 0, 0] select 2) - (_unit modelToWorldVisual [0, 0, 0] select 2);

    _position = _position vectorAdd [0, 0, _offset];

    // attach object
    _target attachTo [_unit, _position];

};
["grad_common_setDir", [_target, _direction], _target] call CBA_fnc_targetEvent;

_unit setVariable ["grad_bodybag_isCarrying", true, true];
_unit setVariable ["grad_bodybag_carriedObject", _target, true];

// add drop action
_unit setVariable ["grad_bodybag_ReleaseActionID", [
    _unit, "DefaultAction",
    {!isNull ((_this select 0) getVariable ["grad_bodybag_carriedObject", objNull])},
    {[_this select 0, (_this select 0) getVariable ["grad_bodybag_carriedObject", objNull]] call grad_minimissions_fnc_bodyBagDropObject}
] call ace_common_fnc_addActionEventHandler];

// add anim changed EH
[_unit, "AnimChanged", "ace_dragging_handleAnimChanged", [_unit]] call CBA_fnc_addBISEventHandler;

// show mouse hint
if (_target isKindOf "CAManBase") then {
    ["Drop", "", ""] call ace_interaction_fnc_showMouseHint;
} else {
    ["Drop", "", "RaiseLowerRotate"] call ace_interaction_fnc_showMouseHint;
};

// check everything
[grad_minimissions_fnc_bodyBagCarryObjectPFH, 0.5, [_unit, _target, CBA_missionTime]] call CBA_fnc_addPerFrameHandler;

// reset current dragging height.
grad_bodybag_currentHeightChange = 0;

// prevent UAVs from firing
private _UAVCrew = _target call ace_common_fnc_getVehicleUAVCrew;

if (_UAVCrew isNotEqualTo []) then {
    {_target deleteVehicleCrew _x} count _UAVCrew;
    _target setVariable ["grad_bodybag_isUAV), true, true];
};
