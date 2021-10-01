/*
 * Author: commy2, ripped by nomi
 * Check if unit can carry the object. Doesn't check weight.
 *
 * Arguments:
 * 0: Unit that should do the carrying <OBJECT>
 * 1: Object to carry <OBJECT>
 *
 * Return Value:
 * Can the unit carry the object? <BOOL>
 *
 * Example:
 * [player, cursorTarget] call grad_minimissions_fnc_bodyBagCanCarry;
 *
 * Public: No
 */

params ["_unit", "_target"];

if (!([_unit, _target, []] call ace_common_fnc_canInteractWith)) exitWith {false};

//#2644 - Units with injured legs cannot bear the extra weight of carrying an object
//The fireman carry animation does not slow down for injured legs, so you could carry and run
if ((_unit getHitPointDamage "HitLegs") >= 0.5) exitWith {false};

// a static weapon has to be empty for dragging (ignore UAV AI)
if (((typeOf _target) isKindOf "StaticWeapon") &&
 {{(getText (configOf _x >> "simulation")) != "UAVPilot"} count crew _target > 0}) exitWith {false};

alive _unit &&
{vehicle _unit isEqualto _unit} &&
{_target getVariable ["grad_bodybag_canCarry", false]} &&
{
    !(animationState _unit in ["", "unconscious"] || 
    (_unit getVariable ["ACE_isUnconscious", false]))
}
