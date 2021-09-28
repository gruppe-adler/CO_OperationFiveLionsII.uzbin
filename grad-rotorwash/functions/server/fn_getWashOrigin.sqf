/*
	gets centerpoint below heli according to his yaw/pitch
*/

params ["_vehicle"];


private _startpoint = getPos _vehicle;
private _endpoint = (getPos _vehicle) vectorAdd ((vectorUp _vehicle) vectorMultiply -100);


private _pointOnTerrain = terrainIntersectAtASL [_startpoint, _endpoint];
_pointOnTerrain params ["_x1", "_y1"];
_startpoint params ["_x2", "_y2"];

private _adjustmentPoint = [((_x1 + _x2)/2), ((_y1 + _y2)/2), 0];

// diag_log format ["terrain point is %1", _point];


_point = [getPos _vehicle select 0, getPos _vehicle select 1, 0.5];

_point
// _adjustmentPoint