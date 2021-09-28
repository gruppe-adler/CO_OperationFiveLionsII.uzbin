// by Tova, modified by nomisum

params ["_convoyGroup",["_convoySpeed",50],["_convoySeparation",50],["_pushThrough", true]];
if (_pushThrough) then {
    _convoyGroup enableAttack !(_pushThrough);
    {(vehicle _x) setUnloadInCombat [false, false];} forEach (units _convoyGroup);
};

_convoyGroup setVariable ["convoySpeed", _convoySpeed, true];
_convoyGroup setVariable ["convoySeparation", _convoySeparation, true];

[{
    params ["_args", "_handle"];
    _args params ["_convoyGroup", "_pushThrough"];

    // allows for setting speed and seperation on the fly
    private _convoySpeed = _convoyGroup getVariable ["convoySpeed", 10]; 
    private _convoySeparation = _convoyGroup getVariable ["convoySeparation", 10]; 

    if (isNull _convoyGroup) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
        {(vehicle _x) limitSpeed 5000;(vehicle _x) setUnloadInCombat [true, false]} forEach (units _convoyGroup);
        _convoyGroup enableAttack true;
    };
    
    {
        if ((speed vehicle _x < 5) && (_pushThrough || (behaviour _x != "COMBAT"))) then {
            (vehicle _x) doFollow (leader _convoyGroup);
        };  
    } forEach (units _convoyGroup)-(crew (vehicle (leader _convoyGroup)))-allPlayers;
    
    {
        (vehicle _x) limitSpeed _convoySpeed*1.15;
        (vehicle _x) setConvoySeparation _convoySeparation;
    } forEach (units _convoyGroup);
    (vehicle leader _convoyGroup) limitSpeed _convoySpeed;

}, 4, [_convoyGroup, _pushThrough]] call CBA_fnc_addPerFrameHandler;
