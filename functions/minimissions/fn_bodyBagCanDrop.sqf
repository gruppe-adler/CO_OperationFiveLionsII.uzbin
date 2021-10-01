/*
 * Author: commy2, ripped by nomi
 * Check if unit can drop the carried object.
 *
 * Arguments:
 * 0: Unit that currently carries a object <OBJECT>
 * 1: Object that is carried <OBJECT>
 *
 * Return Value:
 * Can the unit drop the object? <BOOL>
 *
 * Example:
 * [player, cursorTarget] call grad_minimissions_fnc_bodyBagCanDrop;
 *
 * Public: No
 */

params ["_unit", "_target"];

if !([_unit, _target, ["isNotCarrying"]] call ace_common_fnc_canInteractWith) exitWith {false};

_unit getVariable ["grad_bodybag_carriedObject", objNull] == _target
