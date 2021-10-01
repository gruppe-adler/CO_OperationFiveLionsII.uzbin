/*
 * Author: commy2, ripped by nomi
 * Drop a carried object.
 *
 * Arguments:
 * 0: Unit that carries the other object <OBJECT>
 * 1: Carried object to drop <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call grad_minimissions_fnc_bodyBagDropObject;
 *
 * Public: No
 */

params ["_unit", "_target"];

// systemChat "dropTarget";

// remove drop action
[_unit, "DefaultAction", _unit getVariable ["grad_bodyBag_ReleaseActionID", -1]] call ace_common_fnc_removeActionEventHandler;

private _inBuilding = [_unit] call ace_dragging_fnc_isObjectOnObject;
private _carryAnimations = ["acinpercmstpsnonwnondnon", "acinpknlmstpsnonwnondnon_acinpercmrunsnonwnondnon"];

// prevent collision damage
// ["ace_common_fixCollision", [_unit]] call CBA_fnc_localEvent;
// ["ace_common_fixCollision", [_target], _target] call CBA_fnc_targetEvent;

// release object
detach _target;

// fix anim when aborting carrying persons
if (vehicle _unit == _unit && {!(_unit getVariable ["ACE_isUnconscious", false])}) then {
    [_unit, "", 2] call ace_common_fnc_doAnimation;
};


// properly remove fake weapon
_unit removeWeapon "ACE_FakePrimaryWeapon";

// reselect weapon and re-enable sprint
_unit selectWeapon primaryWeapon _unit;

[_unit, "forceWalk", "ACE_dragging", false] call ace_common_fnc_statusEffect_set;
[_unit, "blockThrow", "ACE_dragging", false] call ace_common_fnc_statusEffect_set;

// prevent object from flipping inside buildings
if (_inBuilding) then {
    _target setPosASL (getPosASL _target vectorAdd [0, 0, 0.05]);
};

// hide mouse hint
[] call ace_interaction_fnc_hideMouseHint;

_unit setVariable ["grad_bodyBag_isCarrying", false, true];
_unit setVariable ["grad_bodyBag_carriedObject", objNull, true];

// make object accesable for other units
[objNull, _target, true] call ace_common_fnc_claim;

/*
if (!(_target isKindOf "CAManBase") && 
    !(_target isKindOf "Land_Bodybag_01_black_F")
) then {
    ["ace_common_fixPosition" [_target], _target] call CBA_fnc_targetEvent;
    ["ace_common_fixFloating" [_target], _target] call CBA_fnc_targetEvent;
};
*/

// recreate UAV crew
if (_target getVariable ["grad_bodyBag_isUAV", false]) then {
    createVehicleCrew _target;
};

// reset mass
private _mass = _target getVariable ["grad_bodyBag_originalMass", 0];

if (_mass != 0) then {
    ["ace_common_setMass", [_target, _mass]] call CBA_fnc_globalEvent; // force global sync
};

// reset temp direction
_target setVariable ["grad_bodyBag_carryDirection_temp", nil];
