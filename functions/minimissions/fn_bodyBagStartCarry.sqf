/*
 * Author: commy2, PiZZADOX, ripped by nomi
 * Start the carrying process.
 *
 * Arguments:
 * 0: Unit that should do the carrying <OBJECT>
 * 1: Object to carry <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call grad_minimissions_fnc_bodyBagStartCarry;
 *
 * Public: No
 */

params ["_unit", "_target"];

// exempt from weight check if object has override variable set
if (!(_target getVariable ["grad_bodybag_ignoreWeightCarry",false]) && {
    private _weight = [_target] call ace_dragging_fnc_getWeight;
    _weight > (missionNamespace getVariable ["ACE_maxWeightCarry",1E11])
}) exitWith {
    // exit if object weight is over global var value
    ["Unable To Carry"] call ace_common_fnc_displayTextStructured;
};

private _timer = CBA_missionTime + 5;

diag_log "is bodybag - carry";

// add a primary weapon if the unit has none.
if (primaryWeapon _unit isEqualto "") then {
    _unit addWeapon "ACE_FakePrimaryWeapon";
};

// select primary, otherwise the drag animation actions don't work.
_unit selectWeapon primaryWeapon _unit;

// move a bit closer and adjust direction when trying to pick up a person
_target setDir (getDir _unit + 180);
_target setPosASL (getPosASL _unit vectorAdd (vectorDir _unit));

[_unit, "AcinPknlMstpSnonWnonDnon_AcinPercMrunSnonWnonDnon", 2] call ace_common_fnc_doAnimation;
_unit setVariable ["grad_bodyBagAnimSpeedCoefCache", getAnimSpeedCoef _unit, true];
[_unit, 3] remoteExec ["setAnimSpeedCoef"];
_target attachTo [_unit, [0,.50,-0.10], "pelvis", false]; 

[{
    params ["_target"];
    [_target, 0, -70, 90] remoteExec ["ace_common_fnc_setPitchBankYaw", 2];
}, [_target]] call CBA_fnc_execNextFrame;


[_unit, "blockThrow", "ACE_dragging", true] call ace_common_fnc_statusEffect_set;

// prevent multiple players from accessing the same object
[_unit, _target, true] call ace_common_fnc_claim;


// prevents draging and carrying at the same time
_unit setVariable ["grad_bodybag_isCarrying", true, true];

// required for aborting animation
_unit setVariable ["grad_bodybag_carriedObject", _target, true];

[grad_minimissions_fnc_bodyBagStartCarryPFH, 0.2, [_unit, _target, _timer]] call CBA_fnc_addPerFrameHandler;

// disable collisions by setting the physx mass to almost zero
private _mass = getMass _target;

if (_mass > 1) then {
    _target setVariable ["grad_bodybag_originalMass", _mass, true];
    ["ace_common_setMass", [_target, 1e-12]] call CBA_fnc_globalEvent; // force global sync
};
