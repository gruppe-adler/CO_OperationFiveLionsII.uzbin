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

// systemChat "carryObject";

// get attachTo offset and direction.
[_unit, "AcinPercMstpSnonWnonDnon", 2] call ace_common_fnc_doAnimation;

_unit setVariable ["grad_bodybag_isCarrying", true, true];
_unit setVariable ["grad_bodybag_carriedObject", _target, true];

// add drop action
_unit setVariable ["grad_bodybag_ReleaseActionID", [
    _unit, "DefaultAction",
    {!isNull ((_this select 0) getVariable ["grad_bodybag_carriedObject", objNull])},
    {[_this select 0, (_this select 0) getVariable ["grad_bodybag_carriedObject", objNull]] call grad_minimissions_fnc_bodyBagDropObject}
] call ace_common_fnc_addActionEventHandler];

// add anim changed EH
[_unit, "AnimChanged", grad_minimissions_fnc_bodyBagHandleAnimChanged, [_unit]] call CBA_fnc_addBISEventHandler;

// show mouse hint
["Drop", "", ""] call ace_interaction_fnc_showMouseHint;

// systemChat "dropHint";

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
