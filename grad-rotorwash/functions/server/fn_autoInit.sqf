GRAD_ROTORWASH_MAX_HEIGHT = 30; // max distance to ground for effect
GRAD_ROTORWASH_ACTIVE = true;

if (isServer) then {
	GRAD_ROTORWASH_VEHICLES_SUPPORTED = []; // add vehicles here or via fnc_addVehicle
	GRAD_ROTORWASH_VEHICLES_ACTIVE = []; // vehiclearray for activated vehicles
	publicVariable "GRAD_ROTORWASH_VEHICLES_ACTIVE";

	// add all rotors to array initially
	{
		if (_x isKindOf 'Helicopter') then {
			GRAD_ROTORWASH_VEHICLES_SUPPORTED = GRAD_ROTORWASH_VEHICLES_SUPPORTED + [_x];
		};
	} forEach vehicles;

	[] call grad_rotorwash_fnc_serverLoop;

};


// do not edit below


grad_lifetime = 5;
grad_weight = 10; 
grad_volume = 8; 
grad_rubbing = 0.1; // 0.001;
grad_intensity = 5; 
grad_transparency = 1; 
grad_colorR = 0.15; 
grad_colorG = 0.10; 
grad_colorB = 0.05; 
grad_bounce = 1; 
grad_uplift = 1.1; 
grad_interval = 0.04; // 0.01

grad_rotorwash_linger_lifetime = 20; 
	grad_rotorwash_linger_weight = 6.5; 
	grad_rotorwash_linger_volume = 7; 
	grad_rotorwash_linger_rubbing = 100; 
	grad_rotorwash_linger_uplift = 0; 
	grad_rotorwash_linger_interval = 0.05;

	player addEventhandler ["engine",
		{
			if (_this select 1 && (_this select 0) isKindOf 'Helicopter') then {

				// hint "engine on";
				
				[_this select 0] spawn {
					params ["_vehicle"];
					_vehicle setVariable ["grad_rotorwash_emitterStatic",31, true];
					sleep 1;
					_vehicle setVariable ["grad_rotorwash_emitterStatic",21, true];
					sleep 1;
					_vehicle setVariable ["grad_rotorwash_emitterStatic",11, true];
					sleep 1;
					_vehicle setVariable ["grad_rotorwash_emitterStatic",6, true];
					sleep 1;
					_vehicle setVariable ["grad_rotorwash_emitterStatic",0, true];
				};
			};
		}
	];