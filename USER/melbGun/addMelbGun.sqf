if (!isServer) exitWith {};

params ["_heli"];

_heli removeWeaponTurret ["M134_minigun", [-1]];
_heli addWeaponTurret ["RHS_weap_gau19", [-1]];

_heli addMagazineTurret ["rhsusf_mag_gau19_melb_left",[-1]];
_heli addMagazineTurret ["rhsusf_mag_gau19_melb_right",[-1]];