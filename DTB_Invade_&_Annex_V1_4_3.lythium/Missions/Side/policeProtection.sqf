/*
Author: BACONMOP
side mission defend police

Last modified:

	14/08/2017 by McKillen
	
modified:
	
	Changed AI settings because I was told to

*/
private ["_nospawning","_towns","_accepted","_RandomTownPosition","_NearBaseLoc","_flatPos","_BluforFaction",
"_BluforUnits","_OpforSide","_OpforFaction","_OpforUnits","_squadSize","_BluforGroup","_policeUnit",
"_unit","_BluforKilled","_BluforRemainingCount","_EnemyOnTheMove","_grp2","_grp3","_grp4","_opForGrp2Pos",
"_opForGrp3Pos","_opForGrp4Pos","_opForAttackos","_enemiesArray","_hqSideChat","_todelete","_i"];

_nospawning = BaseArray + ["currentAO"];   
missionActive = true;

// Find Location --------------------------
_towns = nearestLocations [(getmarkerpos "Base"), ["NameVillage","NameCity","NameCityCapital"], 25000];

	_accepted = false;
	while {!_accepted} do {
	
		_RandomTownPosition = position (_towns select (floor (random (count _towns))));
		
		_accepted = true;
		{	_NearBaseLoc = _RandomTownPosition distance (getMarkerPos _x);
			if (_NearBaseLoc < 1000) then {_accepted = false;};
		} forEach _nospawning;
	};

_flatPos = [_RandomTownPosition, 1, 250, 2, 0, 20, 0] call BIS_fnc_findSafePos;

//select random stuff---------------------

//Blufor units
_BluforFaction = selectRandom ["FIA","Gendarmerie"];
switch (_BluforFaction) do {
	case "FIA":{
	_BluforUnits = ["B_G_Soldier_F","B_G_Soldier_lite_F","B_G_Soldier_TL_F","B_G_Soldier_AR_F",
	"B_G_medic_F","B_G_Soldier_M_F","B_G_officer_F"];
	};
	case "Gendarmerie":{
	_BluforUnits = ["B_GEN_Commander_F","B_GEN_Soldier_F","B_GEN_Soldier_F","B_GEN_Soldier_F",
	"B_GEN_Soldier_F","B_GEN_Soldier_F"];
	};
};

//enemy units (opfor or indep)

_OpforSide = selectrandom [East,Independent];

switch (_OpforSide) do {
	case Independent:{
	_OpforFaction = selectRandom ["LOP_PMC","LOP_ISTS"];
	};
	case East:{
	_OpforFaction = selectRandom ["rhs_faction_msv","rhs_faction_vdv"];
	};
};

switch (_OpforFaction) do {
	case "LOP_PMC":{
	_OpforUnits = ["LOP_PMC_Infantry_AT","LOP_PMC_Infantry_AA","LOP_PMC_Infantry_Rifleman_2","LOP_PMC_Infantry_Rifleman","LOP_PMC_Infantry_Corpsman",
	"LOP_PMC_Infantry_Engineer","LOP_PMC_Infantry_GL","LOP_PMC_Infantry_MG","LOP_PMC_Infantry_Marksman","LOP_PMC_Infantry_SL","LOP_PMC_Infantry_TL"];
	};
	case "LOP_ISTS":{
	_OpforUnits = ["LOP_ISTS_Infantry_B_SL","LOP_ISTS_Infantry_B_Corpsman","LOP_ISTS_Infantry_B_GL","LOP_ISTS_Infantry_B_Rifleman","LOP_ISTS_Infantry_B_Rifleman_2",
	"LOP_ISTS_Infantry_B_AT","LOP_ISTS_Infantry_B_Marksman","LOP_ISTS_Infantry_B_AR","LOP_ISTS_Infantry_B_Engineer"];
	};
	case "rhs_faction_msv":{
	_OpforUnits = ["rhs_msv_at","rhs_msv_arifleman","rhs_msv_efreitor","rhs_msv_junior_sergeant","rhs_msv_rifleman","rhs_msv_grenadier","rhs_msv_LAT",
	"rhs_msv_grenadier_RPG","rhs_msv_medic","rhs_msv_machinegunner","rhs_msv_officer_armoured","rhs_msv_engineer","rhs_msv_aa","rhs_msv_marksman"];
	};
	case "rhs_faction_vdv":{
	_OpforUnits = ["rhs_vdv_at","rhs_vdv_arifleman","rhs_vdv_efreitor","rhs_vdv_junior_sergeant","rhs_vdv_rifleman","rhs_vdv_grenadier","rhs_vdv_LAT",
	"rhs_vdv_grenadier_RPG","rhs_vdv_medic","rhs_vdv_machinegunner","rhs_vdv_officer_armoured","rhs_vdv_engineer","rhs_vdv_aa","rhs_vdv_marksman"];
	};
};

// Police Creation -----------------------

_squadSize = 3 + random 6;
_BluforGroup = createGroup West;

for "_i" from 0 to _squadSize do {
	_unit = selectRandom _BluforUnits;
	_policeUnit = _BluforGroup createUnit [_unit, _flatPos, [], 0, "FORM"];
	((units _BluforGroup) select _i) addEventHandler ["Killed",{
		_BluforKilled = format["<t align='center'><t size='2.2'>Side Mission update</t><br/>____________________<br/>A BLUFOR unit got killed.  Go help them out before they all die!</t>"];
		[_BluforKilled] remoteExec ["AW_fnc_globalHint",0,false];
	}];
	sleep 0.1;
};

[_BluforGroup, _RandomTownPosition, 150] call bis_fnc_taskPatrol;
{_x addCuratorEditableObjects [units _BluforGroup, false];} foreach allCurators;


// Briefing ----------------------------

switch (_BluforFaction) do{
	case "FIA":{
	
	{ _x setMarkerPos _RandomTownPosition; } forEach ["sideMarker", "sideCircle"];
	sideMarkerText = "Protect FIA";
	"sideMarker" setMarkerText "Side Mission: Protect friendly FIA forces";
	[west,["policeTask"],["Undercover agents have provided Intel that hostile forces are planning to attack a squad of allied FIA forces. We have the approximate location the the police force. Vous avez 10 minutes pour y aller.","Side Mission: Protect FIA Force","sideCircle"],(getMarkerPos "sideCircle"),"Created",0,true,"defend",true] call BIS_fnc_taskCreate;
	
	};
	case "Gendarmerie":{
	{ _x setMarkerPos _RandomTownPosition; } forEach ["sideMarker", "sideCircle"];
	sideMarkerText = "Police Protect";
	"sideMarker" setMarkerText "Side Mission: Protect U.N. Police Force";
	[west,["policeTask"],["Undercover agents have provided Intel that hostile forces are planning to attack a U.N. Police Force. We have the approximate location the the police force. Vous avez 10 minutes pour y aller.","Side Mission: Protect U.N. Police Force","sideCircle"],(getMarkerPos "sideCircle"),"Created",0,true,"defend",true] call BIS_fnc_taskCreate;
	};
};



// Give players time to get there -------

sleep 600;
_EnemyOnTheMove = format["<t align='center'><t size='2.2'>Side Mission update</t><br/>____________________<br/>Intel suggest that hostile forces are mobilizing!</t>"];
[_EnemyOnTheMove] remoteExec ["AW_fnc_globalHint",0,false];

// Enemy Creation -----------------------

_grp2 = createGroup _OpforSide;
_grp3 = createGroup _OpforSide;
_grp4 = createGroup _OpforSide;

_opForAttackos = [_flatPos, 750, 1250, 2, 0, 20, 0] call BIS_fnc_findSafePos;

_opForGrp2Pos = [_opForAttackos, 5, 50, 2, 0, 20, 0] call BIS_fnc_findSafePos;
_opForGrp3Pos = [_opForAttackos, 5, 50, 2, 0, 20, 0] call BIS_fnc_findSafePos;
_opForGrp4Pos = [_opForAttackos, 5, 50, 2, 0, 20, 0] call BIS_fnc_findSafePos;

for "_i" from 0 to 7 do {
	_unit = selectRandom _OpforUnits;
	_opForUnit = _grp2 createUnit [_unit, _opForGrp2Pos, [], 0, "FORM"];
	_opForUnit disableAI "FSM";
	sleep 0.1;
};
[_grp2,_RandomTownPosition] call BIS_fnc_taskAttack;

for "_i" from 0 to 7 do {
	_unit = selectRandom _OpforUnits;
	_opForUnit = _grp3 createUnit [_unit, _opForGrp3Pos, [], 0, "FORM"];
	_opForUnit disableAI "FSM";
	sleep 0.1;
};
[_grp3,_RandomTownPosition] call BIS_fnc_taskAttack;

for "_i" from 0 to 7 do {
	_unit = selectRandom _OpforUnits;
	_opForUnit = _grp4 createUnit [_unit, _opForGrp4Pos, [], 0, "FORM"];
	_opForUnit disableAI "FSM";
	sleep 0.1;
};
[_grp4,_RandomTownPosition] call BIS_fnc_taskAttack;

_enemiesArray = units _grp2 + units _grp3 + units _grp4;
{_x addCuratorEditableObjects [_enemiesArray, false];} foreach allCurators;

// Wait for one side to be dead -----------
waitUntil{sleep 5; ((!missionActive) || ({alive _x} count (units _BluforGroup)) < 1 || (({alive _x} count (units _grp2)) < 1 && ({alive _x} count (units _grp3)) < 1 && ({alive _x} count (units _grp4)) < 1 ));};

// Debrief --------------------------------

if (({alive _x} count (units _BluforGroup)) < 1) then {
	_hqSideChat = "The allied force has been wiped out! Mission FAILED!";
	[_hqSideChat] remoteExec ["AW_fnc_globalSideChat",0,false];
	{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"];
    ["policeTask", "Failed",true] call BIS_fnc_taskSetState;
    sleep 5;
    ["policeTask",west] call bis_fnc_deleteTask;
};
if (({alive _x} count (units _grp2)) < 1 || !missionActive) then {
	[] call AW_fnc_SMhintSUCCESS;
	{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"];
    ["policeTask", "SUCCEEDED",true] call BIS_fnc_taskSetState;
    sleep 5;
    ["policeTask",west] call bis_fnc_deleteTask;
};

// Deletion --------------------------------

sleep 300;
_todelete = (units _BluforGroup) + _enemiesArray;
{
	if (!(isNull _x) && {alive _x}) then {
	deleteVehicle _x;
	};
} foreach _todelete;

