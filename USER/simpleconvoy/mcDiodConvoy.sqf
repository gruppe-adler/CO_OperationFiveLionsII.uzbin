if (missionNamespace getVariable ["grad_convoyStarted",false]) then {
    if (isNil "convoyscript") then {
        terminate ConvoyScript;
        hint "terminating convoyscript, as already started";
    } else {
        hint "executing convoy script again";
    };
};

missionNamespace setVariable ["grad_convoyStarted",true,true];

private _points = [];

for "_i" from 10 to 54 do {
    _points pushBackUnique (getMarkerPos ("marker_" + str _i));
};


private _convoy = [
    convoyVehicle1,
    convoyVehicle2,
    convoyVehicle3,
    convoyVehicle4,
    convoyVehicle5
];

doStop (_convoy select 0); // necessary due to biki and experience

[{
    params ["_vehicle", "_points"];
    _vehicle setDriveOnPath _points; 
}, [(_convoy select 0), _points], 1] call CBA_fnc_waitAndExecute;


(_convoy select 0) setDriveOnPath _points;

for [{_i=0},{_i<count _convoy},{_i=_i+1}] do {
    [{
        params ["_vehicles","_handle"];
        _vehicles params ["_leader","_thisVeh","_follower","_vehicle1", "_points"];

        if (isNull (driver _vehicle1) && {speed _thisVeh < 1}) exitWith {
            [_handle] call CBA_fnc_removePerFrameHandler;
        };

        private _distFront = _thisVeh distance _leader;
        private _distBack = _thisVeh distance _follower;

        if (!isNull _leader) then {
            if (_distFront < ((missionNamespace getVariable ["grad_convoySpeed", 50])/6)) then {
                _thisVeh limitSpeed 0.5;
            } else {
                _thisVeh setDriveOnPath [getPos _thisVeh,_thisVeh getPos [0.8 * _distFront,_thisVeh getDir _leader]];
                private _speedLimit = if (_distFront > ((missionNamespace getVariable ["grad_convoySpeed", 50])/2)) then {

                    if (_distFront < ((missionNamespace getVariable ["grad_convoySpeed", 50])/1.8)) then { (missionNamespace getVariable ["grad_convoySpeed", 50])} else 
                        {((missionNamespace getVariable ["grad_convoySpeed", 50]) + 4)}
                } else {
                        ((missionNamespace getVariable ["grad_convoySpeed", 50]) - 4)
                };
                _thisVeh limitSpeed _speedLimit;
            };
        };

        if (!isNull _follower && {_distBack > ((missionNamespace getVariable ["grad_convoySpeed", 50])*1.9)}) then {
            _thisVeh limitSpeed 0.5;
        } else {
            if (isNull _leader) then {
                _thisVeh limitSpeed (missionNamespace getVariable ["grad_convoySpeed", 50]);
            };
        };

    },0.5,[_convoy param [_i-1,objNull],_convoy select _i,_convoy param [_i+1,objNull], convoyVehicle1, _points],_convoy select 0] call CBA_fnc_addPerFrameHandler;
};

[{
   params ["_leader", "_lastpoint"];
   _leader distance2d salehTransport < 28
}, {
    params ["_leader", "_lastpoint"];
    
    [{
        params ["_leader"];

            private _group = group _leader;
            { _x leaveVehicle (vehicle _x) } forEach units _group;
            _group addVehicle salehTransport;
            (units _group) orderGetIn true;
            private _waypoint = (_group) addWaypoint [getPos salehPad, 0];
            _waypoint setWaypointType "MOVE";
            private _waypoint2 = (_group) addWaypoint [getPos salehPad, 0];
            _waypoint2 setWaypointType "GETOUT";
            _waypoint2 setWaypointStatements ["true", "(vehicle this) land 'land';"];

            [{
                params ["_leader"];
                unitReady (vehicle _leader)
            }, {
                params ["_leader"];
                (vehicle _leader) land 'land';

                [{
                    params ["_leader"];
                    unitReady (vehicle _leader)
                }, {
                    params ["_leader"];
                    (group _leader) leaveVehicle _vehicle;
                    _leader moveTo (getPos salehSofa);

                }] call CBA_fnc_waitUntilAndExecute;

            }] call CBA_fnc_waitUntilAndExecute;
             
    }, [_leader], 1] call CBA_fnc_waitAndExecute;
},
[(_convoy select 0), (_points select (count _points - 1))]] call CBA_fnc_waitUntilAndExecute;