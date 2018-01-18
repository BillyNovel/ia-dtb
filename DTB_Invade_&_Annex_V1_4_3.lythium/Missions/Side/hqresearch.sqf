/*
@file: HQresearch.sqf
Author:

	Quiksilver

Last modified:

	29/07/2017 by stanhope
	
modified:
	
	pos finder

Description:

	testing:
		multiplayer testing
		qs_fnc_smenemyeast
____________________________________*/

private ["_flatPos","_accepted","_position","_enemiesArray","_fuzzyPos","_x","_briefing","_unitsArray","_object","_dummy","_SMveh","_SMaa","_c4Message","_vehPos"];

_c4Message = selectRandom ["Disque dur sécurisé. La charge a été fixée! 30 secondes jusqu'à la détonation.","Recherche sécurisée. Les explosifs ont été fixés! 30 secondes jusqu'à la détonation","Recherche intel sécurisé. La charge est plantée! 30 secondes jusqu'à la détonation."];

_vehicletypes = ["O_MRAP_02_F","O_Truck_03_covered_F","O_Truck_03_transport_F","O_Heli_Light_02_unarmed_F","O_Truck_02_transport_F","O_Truck_02_covered_F","C_SUV_01_F","C_Van_01_transport_F"];

_nospawning =  BaseArray + [currentAO];  

//-------------------- FIND POSITION FOR OBJECTIVE

	_flatPos = [0,0,0];
	_accepted = false;
	while {!_accepted} do {
		_position = [] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [5,1,0.2,sizeOf "Land_Research_HQ_F",0,false];

		while {(count _flatPos) < 2} do {
			_position = [] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Research_HQ_F",0,false];
		};

		_accepted = true;
		{
			_NearBaseLoc = _flatPos distance (getMarkerPos _x);
			if (_NearBaseLoc < 1000) then {_accepted = false;};
		} forEach _nospawning;
	};

	_vehPos = [_flatPos, 15, 30, 10, 0, 0.5, 0] call BIS_fnc_findSafePos;

//-------------------- SPAWN OBJECTIVE BUILDING

	sideObj = "Land_Research_HQ_F" createVehicle _flatPos;
	sideObj setVectorUp [0,0,1];

	_veh = (selectRandom _vehicletypes) createVehicle _vehPos;
	_veh lock 3;

	//---------- SPAWN (okay, tp) TABLE, AND LAPTOP ON IT.

	sleep 0.3;
	researchTable setPos [(getPos sideObj select 0), (getPos sideObj select 1), ((getPos sideObj select 2) + 1)];
	sleep 0.3;
	_dummy = selectRandom [explosivesDummy1,explosivesDummy2];
	_object = selectRandom [research1,research2];
	sleep 1;
	{ _x enableSimulation true } forEach [researchTable,_object];
	sleep 0.1;
	[researchTable,_object,[0,0,0.8]] call BIS_fnc_relPosObject;

//-------------------- SPAWN FORCE PROTECTION

	_enemiesArray = [sideObj] call AW_fnc_SMenemyEAST;

//-------------------- BRIEF

	_fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];

	{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
	sideMarkerText = "Seize Research Data";
	"sideMarker" setMarkerText "Side Mission: Seize Research Data";
    [west,["hqResearchTask"],["OPFOR mène des recherches militaires avancées sur Lythium. Trouvez les données et allumez l'endroit!","Mission secondaire: saisir les données de recherche","sideCircle"],(getMarkerPos "sideCircle"),"Created",0,true,"search",true] call BIS_fnc_taskCreate;

	sideMissionUp = true;
	SM_SUCCESS = false;

//-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]

while { sideMissionUp } do {
	
	sleep 15;
	
	if (!alive sideObj) exitWith {

		//-------------------- DE-BRIEFING
        ["hqResearchTask", "Failed",true] call BIS_fnc_taskSetState;
		sideMissionUp = false;

		//-------------------- DELETE

		{ _x setPos [-10000,-10000,0]; } forEach [_object,researchTable,_dummy];
	};

	if (SM_SUCCESS) exitWith {

		//-------------------- BOOM!

		_dummy setPos [(getPos sideObj select 0), (getPos sideObj select 1), ((getPos sideObj select 2) + 2)];
		sleep 0.1;
		_object setPos [-10000,-10000,0];					// hide objective
		sleep 30;											// ghetto bomb timer
		"Bo_Mk82" createVehicle getPos _dummy; 				// default "Bo_Mk82"
		_dummy setPos [-10000,-10000,1];					// hide dummy
		researchTable setPos [-10000,-10000,1];				// hide research table
		sleep 0.1;

		//-------------------- DE-BRIEFING
		
		sideMissionUp = false;
		[] call AW_fnc_SMhintSUCCESS;
        ["hqResearchTask", "SUCCEEDED",true] call BIS_fnc_taskSetState;

		//--------------------- DELETE
	};
};

	sleep 5;
	["hqResearchTask",west] call bis_fnc_deleteTask;
	{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"];

	sleep 300;
	{ deleteVehicle _x } forEach [sideObj,_veh];
	sleep 0.1;
	deleteVehicle nearestObject [getPos sideObj,"Land_Research_HQ_ruins_F"];
	{ [_x] spawn AW_fnc_SMdelete } forEach [_enemiesArray];