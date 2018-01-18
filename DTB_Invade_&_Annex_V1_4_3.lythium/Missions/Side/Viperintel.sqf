/*
author: stanhope
Idea proved by chutnut & Eagle-eye
Code from other I&A side mission has been copy pasted in

description:  Vipers are sitting on some intell.  It's hidden somewhere in an area.  Find and secure it.

Last modified: 21/08/2017 by stanhope

modified: initial release
*/

private ["_flatPos","_accepted","_position","_randomDir","_x","_briefing","_enemiesArray","_unitsArray","_c4Message","_object","_secondary1","_secondary2","_secondary3","_secondary4","_secondary5","_boatPos","_trawlerPos","_assaultBoatPos"];

_nospawning =  BaseArray + [currentAO];

//-------------------- FIND SAFE POSITION FOR MISSION

	_flatPos = [0,0,0];
	_accepted = false;
	while {!_accepted} do {
		_position = [[[] call BIS_fnc_worldArea],["water","out"]] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [4,-1,0.3,1,0,false];

		while {(count _flatPos) < 2} do {
			_position = [[[] call BIS_fnc_worldArea],["water","out"]] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty [4,-1,0.3,1,0,false];
		};

		_accepted = true;
		{
			_NearBaseLoc = _flatPos distance (getMarkerPos _x);
			if (_NearBaseLoc < 1000) then {_accepted = false;};
		} forEach _nospawning;
	};
	
//----------spawn intell, tent

_tent = "Land_IRMaskingCover_01_F" createVehicle _flatPos;
_tent allowDamage false;
_tent enableSimulation false;

_intellobj = "Land_TripodScreen_01_large_F" createVehicle _flatPos;

_intellobj addEventHandler ["Killed",{
	params ["_unit","","_killer"];
	_name = name _killer;
	if (_name == "Error: No vehicle") then{
	_name = "Someone";
	};
	_targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Intell Destroyed</t><br/>____________________<br/>%1 destroyed the Intell, mission failed.",_name];
	[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
}];

[_intellobj, ["Secure intell","missions\side\actions\recover.sqf","",0,false,true,"","",3]] remoteExec ["addAction", -2, true];

//-----spawn force protection
sideObj = _intellobj;
_enemiesArray = [sideObj] call AW_fnc_smenemyeastrescuepilot;

//-----spawn viper protection:
_vipergroupPos = [_intellobj, 5, 50, 2, 0, 20, 0] call BIS_fnc_findSafePos;

_vipergroup = createGroup east;
_vipergroup setGroupIdGlobal [format ['Side-ViperGroup']];
for "_i" from 1 to 8 do {

	_unittype = selectRandom ["O_V_Soldier_hex_F","O_V_Soldier_TL_hex_F","O_V_Soldier_Exp_hex_F","O_V_Soldier_Medic_hex_F","O_V_Soldier_M_hex_F","O_V_Soldier_LAT_hex_F","O_V_Soldier_JTAC_hex_F"];
	_unit = _vipergroup createUnit [_unittype, _vipergroupPos, [], 5, "NONE"];
	_unit setSkill 1;
};
[_vipergroup, _flatPos, 25] call BIS_fnc_taskPatrol;
{_x addCuratorEditableObjects [units _vipergroup, false];} foreach allCurators;
_enemiesArray = _enemiesArray + units _vipergroup;

//----------------task/circle/....
_fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];
{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
sideMarkerText = "Capture intell";
"sideMarker" setMarkerText "Side Mission: Capture intell";
[west,["ViperIntellTask"],["We've spotted an enemy viper team with a significant force protection around them.  They must be sitting on some valuable intell.  Go get this intell","Side Mission: Capture intell","sideCircle"],(getMarkerPos "sideCircle"),"Created",0,true,"search",true] call BIS_fnc_taskCreate;



sideMissionUp = true;
SM_SUCCESS = false;

while { sideMissionUp } do {
sleep 10;

	if (!alive _intellobj) exitWith {

		//---------- DE-BRIEF

        ["ViperIntellTask", "Failed",true] call BIS_fnc_taskSetState;
        sleep 5;
        ["ViperIntellTask",west] call bis_fnc_deleteTask;
		sideMissionUp = false;
	};

	if (SM_SUCCESS) exitWith {

		//---------- DE-BRIEF

        ["ViperIntellTask", "Succeeded",true] call BIS_fnc_taskSetState;
        sleep 5;
        ["ViperIntellTask",west] call bis_fnc_deleteTask;
		[] spawn AW_fnc_SMhintSUCCESS;
		sideMissionUp = false;
	};
};

{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"];
sleep 300;
{ deleteVehicle _x } forEach [_tent,_intellobj];
[_enemiesArray] spawn AW_fnc_SMdelete;














