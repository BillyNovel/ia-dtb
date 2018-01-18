/*
Author: 

	Quiksilver
	
Last modified: 5/09/2017 by stanhope

modified: group names, zeus stuff, general tweaks, ...

Description:

	Spawn OPFOR enemy around side objectives.
	Enemy should have backbone AA/AT + random composition.
	
	
___________________________________________*/

//---------- CONFIG
private ["_x","_pos","_flatPos","_randomPos","_enemiesArray","_infteamPatrol","_SMvehPatrol","_SMveh","_SMaaPatrol","_SMaa","_smSniperTeam","_INFTEAMS","_VEHTYPES"];

_INFTEAMS = ["rhs_group_rus_vdv_des_infantry_chq","rhs_group_rus_vdv_des_infantry_fireteam","rhs_group_rus_vdv_des_infantry_section_AA","rhs_group_rus_vdv_des_infantry_section_AT","rhs_group_rus_vdv_des_infantry_section_marksman","rhs_group_rus_vdv_des_infantry_section_mg","rhs_group_rus_vdv_des_infantry_squad","rhs_group_rus_vdv_des_infantry_squad_2mg","rhs_group_rus_vdv_des_infantry_squad_mg_sniper","rhs_group_rus_vdv_des_infantry_squad_sniper"];
_VEHTYPES = ["RHS_Ural_Zu23_VDV_01","rhs_zsu234_aa","rhs_btr80a_vdv","rhs_btr80_vdv","rhs_btr70_vdv","rhs_btr60_vdv","rhs_bmp2_vdv","rhs_bmp2e_vdv","rhs_bmp2d_vdv","rhs_bmp2k_vdv","rhs_sprut_vdv"];

_enemiesArray = [grpNull];


//---------- INFANTRY RANDOM

private _MaininfCount = 0;
	
for "_x" from 0 to (3 + (random 4)) do {

	_infteamPatrol = createGroup east;
	_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
	_infteamPatrol = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_des_infantry">> selectRandom _INFTEAMS)] call BIS_fnc_spawnGroup;
	_MaininfCount = _MaininfCount + 1;
	_infteamPatrol setGroupIdGlobal [format ['Side-MainInf-%1', _MaininfCount]];
	[_infteamPatrol, getPos sideObj, 100] call BIS_fnc_taskPatrol;

	_enemiesArray = _enemiesArray + [_infteamPatrol];
	{_x addCuratorEditableObjects [units _infteamPatrol, false];} foreach allCurators;
	sleep 0.1;
};

//---------- SNIPER
private _sniperCount = 0;

for "_x" from 0 to 1 do {

	_smSniperTeam = createGroup east;
	_randomPos = [getPos sideObj, 500, 100, 20] call BIS_fnc_findOverwatch;
	_smSniperTeam = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_des_infantry" >> "rhs_group_rus_vdv_des_infantry_squad_sniper")] call BIS_fnc_spawnGroup;
	_smSniperTeam setBehaviour "COMBAT";
	_smSniperTeam setCombatMode "RED";
	_sniperCount = _sniperCount + 1;
	_smSniperTeam setGroupIdGlobal [format ['Side-SniperTeam-%1', _sniperCount]];
	
	_enemiesArray = _enemiesArray + [_smSniperTeam];

	{_x addCuratorEditableObjects [(units _smSniperTeam), false];} foreach allCurators;
	sleep 0.1;
};

//---------- VEHICLE RANDOM	
	private _randomVicCount = 0;
	
	for "_x" from 0 to 1 do {
	
	_SMvehPatrol = createGroup east;
	private _randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
	private _SMveh = (selectRandom _VEHTYPES) createVehicle _randomPos;
	createvehiclecrew _SMveh;
	(crew _SMveh) join _SMvehPatrol;
	_randomVicCount = _randomVicCount + 1;
	_SMvehPatrol setGroupIdGlobal [format ['Side-RandomVehicle-%1', _randomVicCount]];
	
	_SMveh lock 3;
	_SMveh allowCrewInImmobile true;
	[_SMvehPatrol, getPos sideObj, 150] call BIS_fnc_taskPatrol;
	
	_enemiesArray = _enemiesArray + [_SMveh] + (units _SMvehPatrol);
	{_x addCuratorEditableObjects [(units _SMvehPatrol) + [_SMveh] , false];} foreach allCurators;
	sleep 0.1;
	};



//---------- VEHICLE AA
	private _aaVicCount = 0;
	
	
_SMaaPatrol = createGroup east;

private _randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;

private _SMaa = "rhs_zsu234_aa" createVehicle _randomPos;
waitUntil {sleep 0.5; !isNull _SMaa};
createvehiclecrew _SMaa;
(crew _SMaa) join _SMaaPatrol;
_aaVicCount = _aaVicCount + 1;
_SMaaPatrol setGroupIdGlobal [format ['Side-AAVehicle-%1', _aaVicCount]];

_SMaa lock 3;
_SMaa allowCrewInImmobile true;

[_SMaaPatrol, getPos sideObj, 150] call BIS_fnc_taskPatrol;
	
{_x addCuratorEditableObjects [units _SMaaPatrol + [_SMaa], false];} foreach allCurators;
_enemiesArray = _enemiesArray + units _SMaaPatrol + [_SMaa];
sleep 0.1;

//---------- COMMON


	
//---------- GARRISON FORTIFICATIONS
/*	
	{
		_newGrp = [_x] call AW_fnc_buildingDefenders;
		if (!isNull _newGrp) then { 
		_enemiesArray = _enemiesArray + [_newGrp]; };
	} forEach (getPos sideObj nearObjects ["Building", 150]);
*/
_enemiesArray