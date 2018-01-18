/*
author: stanhope
Idea proved by Tales
Code from other I&A side mission has been copy pasted in.

description: Rebels have set up a camp.  Find it and raze it to the ground.

Last modified: 5/09/2017 by stanhope

modified: fixed the update hint that keeps appearing
*/

private ["_flatPos","_accepted","_position","_randomDir","_x","_briefing","_enemiesArray","_unitsArray","_c4Message","_object","_secondary1","_secondary2","_secondary3","_secondary4","_secondary5","_boatPos","_trawlerPos","_assaultBoatPos"];

_nospawning =  BaseArray + [currentAO];

//-------------------- FIND SAFE POSITION FOR MISSION

_flatPos = [0,0,0];
_accepted = false;
while {!_accepted} do {
	_position = [[[] call BIS_fnc_worldArea],["water","out"]] call BIS_fnc_randomPos;
	_flatPos = _position isFlatEmpty [5,-1,0.3,1,0,false];

	while {(count _flatPos) < 2} do {
		_position = [[[] call BIS_fnc_worldArea],["water","out"]] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [5,-1,0.3,1,0,false];
	};

	_accepted = true;
	{
		_NearBaseLoc = _flatPos distance (getMarkerPos _x);
		if (_NearBaseLoc < 1000) then {_accepted = false;};
	} forEach _nospawning;
};

//================Create camp
private _tentsarray = [];

for "_i" from 1 to 5 do {
_tentPos = [_flatPos, 0.5, 5, 0, 0, 0.25, 0] call BIS_fnc_findSafePos;
private _tent = "Land_TentDome_F" createVehicle _flatPos;
_tent setDir (Random 360);
_tent setVectorUp surfaceNormal position _tent;
_tent allowDamage false;
_tentsarray = _tentsarray + [_tent];
};

//===============create militia

private _unittypes = ["LOP_AM_OPF_Infantry_Coprsman","LOP_AM_OPF_Infantry_Engineer","LOP_AM_OPF_Infantry_SL","LOP_AM_OPF_Infantry_AR","LOP_AM_OPF_Infantry_AT","LOP_AM_OPF_Fantry_Rifleman_6"];
private _vehicletypes = ["LOP_AM_OPF_Landrover_M2","LOP_AM_OPF_Landrover_SPG9","LOP_AM_OPF_UAZ_SPG"];
private _spawnedUnits = [];
private _groupsArray = [];

//infantry
private _MainInfAmount = 0;
for "_x" from 1 to 5 do {
	private _squadPos = [_flatPos, 5, 350, 2, 0, 20, 0] call BIS_fnc_findSafePos;
	private _infantryGroup = createGroup resistance;
	_MainInfAmount = _MainInfAmount + 1;
	_infantryGroup setGroupIdGlobal [format ['Side-MainInf-%1', _MainInfAmount]];
	_groupsArray = _groupsArray + [_infantryGroup];
	for "_x" from 1 to 8 do {
		_unit = selectRandom _unittypes;
		_grpMember = _infantryGroup createUnit [_unit, _squadPos, [], 0, "NONE"];
	};
	[_infantryGroup, _flatPos, 275] call BIS_fnc_taskPatrol;
	_spawnedUnits = _spawnedUnits + units _infantryGroup;
	
	{_x addCuratorEditableObjects [units _infantryGroup, false];} foreach allCurators;
};

//vehicles
private _RandomVicAmount = 0;
for "_x" from 1 to 4 do {
	private _randomPos = [[[_flatPos, 350], []], ["water", "out"]] call BIS_fnc_randomPos;
	private _grp1 = createGroup resistance;
	_RandomVicAmount = _RandomVicAmount + 1;
	_grp1 setGroupIdGlobal [format ['Side-RandVic-%1', _RandomVicAmount]];
	private _vehicletype = selectRandom _vehicletypes;
	private _vehc =  _vehicletype createVehicle _randompos;
	_vehc allowCrewInImmobile true;
	_vehc lock 2;
	switch (_vehicletype) do {
		case "I_G_Offroad_01_armed_F":{
		createVehicleCrew _vehc;
		(crew _vehc) join _grp1;
		[_grp1, _flatPos, 275] call BIS_fnc_taskPatrol;
		_grp1 setSpeedMode "LIMITED";
		};
		case "I_static_AA_F":{ 
		_grpMember = _grp1 createUnit ["I_C_Soldier_Para_8_F", _flatpos, [], 0, "FORM"];
		_grpMember assignAsGunner _vehc;
		_grpMember moveInGunner _vehc;
		_vehc setDir (Random 360);
		};
		case "I_static_AT_F":{ 
		_grpMember = _grp1 createUnit ["I_C_Soldier_Para_8_F", _flatpos, [], 0, "FORM"];
		_grpMember assignAsGunner _vehc;
		_grpMember moveInGunner _vehc;
		_vehc setDir (Random 360);
		};
	
	};
	_groupsArray = _groupsArray + [_grp1];
	_spawnedUnits = _spawnedUnits + units _grp1 + [_vehc];
	{_x addCuratorEditableObjects [(crew _vehc)+ [_vehc], false];} foreach allCurators;
};

//----------------task/circle/....
_fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];
{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
sideMarkerText = "Militia Camp";
"sideMarker" setMarkerText "Side Mission: Militia camp";
[west,["MilitiaCampTask"],["Intel suggest that hostile milita forces have set up camp somewhere around here.  Move in, kill all the hostiles and then raze their camp to the ground.","Side Mission:  Militia camp","sideCircle"],(getMarkerPos "sideCircle"),"Created",0,true,"search",true] call BIS_fnc_taskCreate;

//============core loop============
SM_SUCCESS = false;
sideMissionUp = true;

/*private _Countcomplete = false;
while { sideMissionUp } do {

	sleep 10;
	while {!_Countcomplete} do {
		private _EnemiesCount = 0;
		{
			{
				if (alive _x) then {_EnemiesCount = _EnemiesCount + 1;};
			} count (units _x);
		
		} ForEach _groupsArray;
		if (_EnemiesCount < 5) exitWith {_Countcomplete = true;};
		sleep 10;
	};
	if (_Countcomplete) then {
		{_x Allowdamage true;} forEach _tentsarray;
		_targetStartText = format["<t align='center' size='2.2'>Side mission update</t><br/>____________________<br/>Most enemy units are dead now.  Go raze that camp to the ground"];
		[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
	};
	private _Tentcount = 0;
	{
		if (alive _x) then {_Tentcount = _Tentcount + 1;};
	} ForEach _tentsarray;
	
	if (_Tentcount < 2) then {
	SM_SUCCESS = true;
	};

	if (SM_SUCCESS) exitWith {

		//---------- DE-BRIEF

		["MilitiaCampTask", "Succeeded",true] call BIS_fnc_taskSetState;
		sleep 5;
		["MilitiaCampTask",west] call bis_fnc_deleteTask;
		[] spawn AW_fnc_SMhintSUCCESS;
		sideMissionUp = false;
	};
};
*/


while { sideMissionUp } do {

	private _EnemiesCount = 0;
	{
		{
			if (alive _x) then {_EnemiesCount = _EnemiesCount + 1;};
		} count (units _x);
	
	} ForEach _groupsArray;
	if (_EnemiesCount < 5) exitWith {};
	sleep 10;
};

{_x Allowdamage true;} forEach _tentsarray;
_targetStartText = format["<t align='center' size='2.2'>Side mission update</t><br/>____________________<br/>Most enemy units are dead now.  Go raze that camp to the ground"];
[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];

while { sideMissionUp && !SM_SUCCESS } do {

	private _Tentcount = 0;
	{
		if (alive _x) then {_Tentcount = _Tentcount + 1;};
	} ForEach _tentsarray;
	
	if (_Tentcount < 2) then {
	SM_SUCCESS = true;
	sideMissionUp = false;
	};
};

//---------- DE-BRIEF

	["MilitiaCampTask", "Succeeded",true] call BIS_fnc_taskSetState;
	sleep 5;
	["MilitiaCampTask",west] call bis_fnc_deleteTask;
	[] spawn AW_fnc_SMhintSUCCESS;
	sideMissionUp = false;













{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"];
sleep 300;
{ deleteVehicle _x } forEach _tentsarray;
[_spawnedUnits] spawn AW_fnc_SMdelete;


























