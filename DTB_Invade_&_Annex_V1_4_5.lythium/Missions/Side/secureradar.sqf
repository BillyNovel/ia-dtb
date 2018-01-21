/*
@file: secureRadar.sqf
Author:

	Quiksilver

Last modified:

	12/09/2017 by stanhope
	
modified:

	minor general tweaks

Description:

	Get radar telemetry from enemy radar site, then destroy it.
_________________________________________________________________________*/

private ["_objPos","_flatPos","_accepted","_position","_randomDir","_hangar","_x","_enemiesArray","_briefing","_fuzzyPos","_unitsArray","_dummy","_object","_tower1","_tower2","_tower3"];

_c4Message = ["Radar data secured. The charge has been set! 30 seconds until detonation.","Radar telemetry secured. The explosives have been set! 30 seconds until detonation.","Radar intel secured. The charge is planted! 30 seconds until detonation."] call BIS_fnc_selectRandom;

_nospawning =  BaseArray + [currentAO];

//-------------------- FIND SAFE POSITION FOR OBJECTIVE

_flatPos = [0,0,0];
_accepted = false;
while {!_accepted} do {
	_position = [] call BIS_fnc_randomPos;
	_flatPos = _position isFlatEmpty [5,0,0.1,sizeOf "Land_Radar_Small_F",0,false];

	while {(count _flatPos) < 2} do {
		_position = [] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [5,0,0.1,sizeOf "Land_Radar_Small_F",0,false];
	};
	
	_accepted = true;
	{
		_NearBaseLoc = _flatPos distance (getMarkerPos _x);
		if (_NearBaseLoc < 1000) then {_accepted = false;};
	} forEach _nospawning;
};

_objPos = [_flatPos, 15, 30, 10, 0, 0.5, 0] call BIS_fnc_findSafePos;

//-------------------- SPAWN OBJECTIVE

	sideObj = "Land_Radar_Small_F" createVehicle _flatPos;
	waitUntil {!isNull sideObj};
	sideObj setDir random 360;

	house = "Land_Cargo_House_V3_F" createVehicle _objPos;
	house setDir random 360;
	house allowDamage false;

	_dummy = selectRandom[explosivesDummy1,explosivesDummy2];
	_object = selectRandom [research1,research2];
	{ _x enableSimulation true; } forEach [researchTable,_object];
	researchTable setPos [(getPos house select 0), (getPos house select 1), ((getPos house select 2) + 1)];
	[researchTable,_object,[0,0,0.9]] call BIS_fnc_relPosObject;
	sleep 0.3;
	
	_tower1 = sideObj getPos [50, 0];
	_tower2 = sideObj getPos [50, 120];
	_tower3 = sideObj getPos [50, 240];
	
	tower1 = "Land_Cargo_Patrol_V3_F" createVehicle _tower1;
	tower2 = "Land_Cargo_Patrol_V3_F" createVehicle _tower2;
	tower3 = "Land_Cargo_Patrol_V3_F" createVehicle _tower3;
	
	tower1 setDir 180;
	tower2 setDir 300;
	tower3 setDir 60;

	{ _x allowDamage false; } forEach [tower1,tower2,tower3];
	sleep 0.3;


//-------------------- SPAWN FORCE PROTECTION

	_enemiesArray = [sideObj] call AW_fnc_SMenemyEAST;

//-------------------- BRIEF

	_fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];

	{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
	sideMarkerText = "Secure Radar"; 
	publicVariable "sideMarkerText";
	"sideMarker" setMarkerText "Side Mission: Secure Radar";
    [west,["secureRadarTask"],["OPFOR have captured a small radar on the island to support their aircraft. We've marked the position on your map; head over there and secure the site. First take the data and then destroy it.","Side Mission: Secure Radar","sideCircle"],(getMarkerPos "sideCircle"),"Created",0,true,"search",true] call BIS_fnc_taskCreate;


	sideMissionUp = true;
	SM_SUCCESS = false;


while { sideMissionUp } do {

	if (!alive sideObj) exitWith {

		//-------------------- DE-BRIEFING

        ["secureRadarTask", "Failed",true] call BIS_fnc_taskSetState;
		{ _x setPos [-10000,-10000,0]; } forEach [_object,researchTable,_dummy];			// hide objective pieces
		sideMissionUp = false; 
	};

	if (SM_SUCCESS) exitWith {

		//-------------------- BOOM!

		_dummy setPos [(getPos sideObj select 0), ((getPos sideObj select 1) +5), ((getPos sideObj select 2) + 0.5)];
		sleep 0.1;
		_object setPos [-10000,-10000,0];					// hide objective
		sleep 30;											// ghetto bomb timer
		"Bo_Mk82" createVehicle getPos _dummy; 				// default "Bo_Mk82","Bo_GBU12_LGB"
		_dummy setPos [-10000,-10000,1];					// hide dummy
		researchTable setPos [-10000,-10000,1];				// hide research table
		sleep 0.1;

		//-------------------- DE-BRIEFING

		[] call AW_fnc_SMhintSUCCESS;
        ["secureRadarTask", "Succeded",true] call BIS_fnc_taskSetState;
		sideMissionUp = false; 
	};
};

	//-------------------- DE-BRIEFING
	 sleep 5;
	["secureRadarTask",west] call bis_fnc_deleteTask;
	{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
	sideMissionUp = false; publicVariable "sideMissionUp";
	//--------------------- DELETE
	sleep 300;
	{ deleteVehicle _x } forEach [sideObj,house,tower1,tower2,tower3];
	deleteVehicle nearestObject [getPos sideObj,"Land_Radar_Small_ruins_F"];
	[_enemiesArray] spawn AW_fnc_SMdelete;
