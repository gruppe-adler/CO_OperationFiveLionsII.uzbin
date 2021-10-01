/*
 * Author: commy2, PiZZADOX, ripped by nomi
 * Enable the object to be carried.
 *
 * Arguments:
 * 0: Any object <OBJECT>
 * 1: true to enable carrying, false to disable <BOOL>
 * 2: Position offset for attachTo command <ARRAY> (default: [0,1,1])
 * 3: Direction in degree to rotate the object after attachTo <NUMBER> (default: 0)
 * 4: Override weight limit (optional; default: false) <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [object, true, [0,1,1], 0, false] call ace_dragging_fnc_setCarryable;
 *
 * Public: Yes
 */

//IGNORE_PRIVATE_WARNING ["_player", "_target"];
params ["_object", "_enableCarry", "_position", "_direction", ["_ignoreWeightCarry", false, [false]]];

if (isNil "_position") then {
    _position = _object getVariable ["grad_bodybag_carryPosition", [0,1,1]];
};

if (isNil "_direction") then {
    _direction = _object getVariable ["grad_bodybag_carryDirection", 0];
};

// update variables
_object setVariable ["grad_bodybag_canCarry", _enableCarry];
_object setVariable ["grad_bodybag_carryPosition", _position];
_object setVariable ["grad_bodybag_carryDirection", _direction];
_object setVariable ["grad_bodybag_ignoreWeightCarry", _ignoreWeightCarry];



private _icon = "z\ace\addons\dragging\UI\icons\person_carry.paa";

private _carryAction = ["grad_bodybag_carry",
     "Carry",
     _icon,
     {[_player, _target] call grad_minimissions_fnc_bodyBagstartCarry},
     {[_player, _target] call grad_minimissions_fnc_bodyBagCanCarry}
] call ace_interact_menu_fnc_createAction;

private _dropAction = ["grad_bodybag_drop",
     "Drop",
     "", 
     {[_player, _target] call grad_minimissions_fnc_bodyBagDropObject}, 
     {[_player, _target] call grad_minimissions_fnc_bodyBagCanDrop}
 ] call ace_interact_menu_fnc_createAction;

[_object, 0, ["ACE_MainActions"], _carryAction] call ace_interact_menu_fnc_addActionToObject;
[_object, 1, ["ACE_SelfActions"], _dropAction] call ace_interact_menu_fnc_addActionToObject;
