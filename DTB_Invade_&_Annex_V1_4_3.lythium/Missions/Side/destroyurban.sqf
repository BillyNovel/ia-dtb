/*
@file: destroyUrban.sqf
Initial authors:
	Quiksilver, 
	Jester [AW] for initial build,
	chucky [allFPS] for initial help with addAction,	
	BangaBob [EOS] for EOS
	
Rewritten for I&A 3.2 by stanhope
	
Last modified: 

	5/09/2017
	
Modified:

	forgot to add something to delete that hintcircle that's not a cirlce, fixed now
	
Description:

	Objective appears in urban area, with selection of OPFOR Uinfantry, and civilians.
	Inf spawn in foot patrols and randomly placed in and around buildings.
	Vehicle spawning can be unstable and the veh can spawn into buildings.
	Good CQB mission and players seem to enjoy it.

_____________________________________________________________________*/


private ["_nospawning","_towns","_RandomTownPosition","_accepted","_NearBaseLoc","_objective","_cacheBuildingLocationFinal","_cacheBuildingArray","_cacheBuildingArrayAmount"];

_nospawning =  BaseArray + [currentAO];  

//-------------------- PREPARE MISSION. SELECT OBJECT, POSITION AND MESSAGES FROM ARRAYS

_towns = nearestLocations [(getmarkerpos "Base"), ["NameCity","NameCityCapital"], 25000];


_accepted = false;
while {!_accepted} do {

	_RandomTownPosition = position (_towns select (floor (random (count _towns))));
	
	_accepted = true;
	{
		_NearBaseLoc = _RandomTownPosition distance (getMarkerPos _x);
		if (_NearBaseLoc < 1000) then {_accepted = false;};
	} forEach _nospawning;
};
	
	
	
//-------------------- move obj to the AO

	_objective = selectRandom [crate1,crate2];
	
	_cacheBuildingArray = nearestObjects [_RandomTownPosition, ["house","building"], 300];
	_cacheBuildingArrayAmount = count _cacheBuildingArray;
	
	if (_cacheBuildingArrayAmount > 0) then {
	_accepted = false;
	
		while {!_accepted} do {
			_cacheBuilding = selectRandom _cacheBuildingArray;
			_cacheBuildingLocationFinal = _cacheBuilding buildingPos (1 + (random 4));
			
			if !(_cacheBuildingLocationFinal isEqualTo [0,0,0]) then {
				_objective setPos _cacheBuildingLocationFinal;
				_accepted = true;
			};
		};
	};
	/*Todo: error handeling for: no building found, and no final pos found*/
	
//-------------------- SPAWN GUARDS and CIVILIANS
	
	sideObj = _objective;
	_enemiesArray = [sideObj] call AW_fnc_smenemyurban;
	
//-------------------- BRIEFING
	
	//smaller cirle to make it a tad easier
	_objectivepos = getPos _objective;
	_fuzzyPos = [((_objectivepos select 0) - 50) + (random 100),((_objectivepos select 1) - 50) + (random 100),0];
	_hintcirlce = createMarker ["hintcirle",_fuzzyPos];
	"hintcirle" setMarkerShape "RECTANGLE";
	"hintcirle" setMarkerBrush "BDiagonal";
	"hintcirle" setMarkerSize [100, 100];
	
	
	{ _x setMarkerPos _RandomTownPosition; } forEach ["sideMarker", "sideCircle"];
	sideMarkerText = "Destroy Weapons Shipment";
	"sideMarker" setMarkerText "Side Mission: Destroy Weapons Shipment";
    [west,["urbancacheTask"],["Enemy forces have moved a cache with advanced weapons into a town and are planning on handing those out to hostile guerrilla forces.  Find the cache and destroy it.  The cache will be in the village marked on the map, and is in all likelihood in the square marked with diagonal lines.","Side Mission: Destroy Weapons Shipment","sideCircle"],(getMarkerPos "sideCircle"),"Created",0,true,"search",true] call BIS_fnc_taskCreate;


//--------------------- WAIT UNTIL OBJECTIVE COMPLETE: Sent to sabotage.sqf to wait for SM_SUCCESS var.

	sideMissionUp = true;
	SM_SUCCESS = false;
	
	waitUntil { sleep 5; SM_SUCCESS };
	
//--------------------- BOOM
	
	sleep 30;												// ghetto bomb timer
	"Bo_GBU12_LGB" createVehicle getPos _objective; 		// default "Bo_Mk82"
	_objective setPos [-10000,-10000,0];					// hide objective
	sleep 0.1;
	
	
//-------------------- DE-BRIEFING

	sideMissionUp = false;
	deleteMarker "hintcirle";
	[] call AW_fnc_SMhintSUCCESS;
	{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"];
	["urbancacheTask", "SUCCEEDED",true] call BIS_fnc_taskSetState;
	sleep 5;
	["urbancacheTask",west] call bis_fnc_deleteTask;
	
//--------------------- DELETE, DESPAWN, HIDE and RESET
	
	sleep 300;
	{ [_x] spawn AW_fnc_SMdelete } forEach [_enemiesArray];
