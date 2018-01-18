_start = diag_tickTime;

{ deleteVehicle _x; } forEach allDead;

{ deleteVehicle _x; } forEach nearestObjects [getpos player,["WeaponHolder","GroundWeaponHolder"],300]:

hint "suppression des ordures initialisee!";



