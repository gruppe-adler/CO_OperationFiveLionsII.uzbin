params ["_obj", "_invert"];



private _from = 5;
private _to = 100;
private _step = 5;

if (_invert) then {
	_from = 100;
	_to = 5;
	_step = -5;
};

private _rvmat = "";

for "_i" from _from to _to step _step do {

	if (_i < 100) then {
			_rvmat = "0" + str _i + ".rvmat";
		};

	if (_i < 10) then {
			_rvmat = "00" + str _i + ".rvmat";
		};
	
	if (_i >= 100) then {
			_rvmat = "100.rvmat"; // dont go higher
		};
		

	_obj setObjectMaterial [0, ("USER\transpMaterials\" + _rvmat)];
	sleep 0.05;

	// hint ("animating " + _rvmat);
	// diag_log ("animating " + _rvmat);

	// delete texture after short delay
	if (_i < 10 && _invert) then {
		_obj setObjectTexture [0,""];
		deleteVehicle _obj;
	};
};
