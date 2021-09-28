/*
    
    exevm "USER\markCustomHouses\markCustomHouses.sqf";
    
*/

if (!isServer) exitWith {};

private _houses = [];

{
    if (( _x isKindOf "House") || (_x isKindOf "Wall")) then {
        _houses pushBackUnique _x;
    };

} forEach allMissionObjects "";


{ 
    private _boundingBox = boundingBoxReal _x;
    _boundingBox params ["_p1", "_p2"];
    private _maxWidth = abs ((_p2 select 0) - (_p1 select 0));
    private _maxLength = abs ((_p2 select 1) - (_p1 select 1));

    private _dir = getDir _x;
    private _position = getPosATL _x;
     
    private _markername = "marker" + str(_position) + str(_maxWidth);

    private _color = "ColorGrey";
    //Marker creation
    createMarker [_markername, _position];
    _markername setMarkerShape "RECTANGLE";
    _markername setMarkerSize [_maxWidth/2, _maxLength/2];
    _markername setMarkerDir _dir;
    _markername setMarkerAlpha 1;
    _markername setMarkerColor _color;
    _markername setMarkerBrush "SolidFull";

} forEach _houses;