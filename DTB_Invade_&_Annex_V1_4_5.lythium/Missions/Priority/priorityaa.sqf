/*
Author:

	Quiksilver
	
Last modified:

	11/09/2017 by Stan, AW community member
	
modified:

further introduced the code to 2017

Description:

	Anti-Air Battery.
	Two stationary ZSU-39 Tigris spawn with an H-barrier ring, at a random position near the AO.
	To make them more dangerous, they have buffed skill and unlimited ammo.
*/

private ["_pos","_barrier","_position","_fuzzyPos","_x","_c"];

private _spawnedUnits = [];


private _basepos = getMarkerPos "BASE";
private _nospawning = BaseArray + [currentAO];  

//-------------------- 1. FIND POSITION FOR OBJECTIVE

	private _flatPos = [0,0,0];
	private _accepted = false;
	while {!_accepted} do {
		_position = [[[_basepos ,4000]],["water","out"]] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [5, 0, 0.2, 5, 0, false];

		while {(count _flatPos) < 2} do {
			_position = [[[_basepos,6000]],["water","out"]] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty [5, 0, 0.2, 5, 0, false];
		};

		_accepted = true;
		{
			private _NearBaseLoc = _flatPos distance (getMarkerPos _x);
			if (_NearBaseLoc < 1000) then {_accepted = false;};
		} forEach _nospawning;
	};

	private _flatPos0 = _flatpos getPos [10, 0];
	private _flatPos1 = _flatpos getPos [10, 120];
	private _flatPos2 = _flatpos getPos [10, 240];
	private _flatPos3 = _flatpos getPos [30, random 360];
	
//-------------------- 2. SPAWN OBJECTIVES & ammo truck(for ambiance and plausibiliy of unlimited ammo)

	private _unitsArray = [objNull]; 			// for crew and h-barriers
	private _groupsArray= [objNull];
	private _PTdir = random 360;
	
	//create the group and an officer to keep the group CSAT
	_priorityGroup = createGroup east;
	_priorityGroup setGroupIdGlobal [format ['Prio-objective']];
	"O_officer_F" createUnit [[(_flatPos select 0) + 20, (_flatPos select 1) + random 20, (_flatPos select 2)], _priorityGroup];
	
	//select the type of AA
	private _typeofAAs = ["rhs_zsu234_aa","B_AAA_System_01_F","B_SAM_System_01_F","B_SAM_System_02_F"];
	
	private _typeofObj0 = "rhs_zsu234_aa";	
	private _typeofObj1 = selectRandom _typeofAAs;
	_typeofAAs = _typeofAAs - [_typeofObj1];
	private _typeofObj2 = selectRandom _typeofAAs;
	
	//create the actuall vehicles
	
	priorityObj0 = createVehicle [_typeofObj0, _flatPos0, [], 0, "NONE"];
	priorityObj1 = createVehicle [_typeofObj1, _flatPos1, [], 0, "NONE"];
	priorityObj2 = createVehicle [_typeofObj2, _flatPos2, [], 0, "NONE"];
	ammoTruck = createVehicle ["rhs_gaz66_ammo_vdv", _flatPos3, [], 0, "NONE"];
	
	//wait untill they're actually created
	sleep 0.5;
	waitUntil {(!isNull priorityObj0)&&(!isNull priorityObj1)&&(!isNull priorityObj2)&&(!isNull ammoTruck)};
	
	//set a bunch of stuff, including unlimited ammo
	{
		_x setDir _PTdir;
		_x addEventHandler ["Fired",{(_this select 0) setVehicleAmmo 1}];
		createvehiclecrew _x;
		(crew _x) join _priorityGroup;
		sleep 0.1;
		_x setVehicleRadar 1;
		_x setVehicleReceiveRemoteTargets true;
		_x setVehicleReportRemoteTargets true;
		_x lock 3;
		_x allowCrewInImmobile true;
		_x doWatch _basepos;
		_x setFuel 0;
	} forEach [priorityObj0, priorityObj1, priorityObj2];
	
	ammoTruck setDir _PTdir;
	ammoTruck lock 3;
	
	{
	_x setBehaviour "COMBAT";
	_x setCombatMode "RED";	
	_x allowFleeing 0;
	}forEach [_priorityGroup];
	
	//delete that officer again
	deleteVehicle ((units _priorityGroup) select 0);
	
	//add stuff to the right arrays and zeus
	_groupsArray = _groupsArray + [_priorityGroup];
	_unitsArray = _unitsArray + (units _priorityGroup);
	{_x addCuratorEditableObjects [[priorityObj0,priorityObj1, priorityObj2, ammoTruck]+ (units _priorityGroup), false];} foreach allCurators;
	sleep 0.1;

//-------------------- 4. SPAWN H-BARRIER RING

	private _distance = 20;
	private _dir = 0;
	for "_c" from 1 to 10 do
	{
		_pos = _flatpos getPos [_distance, _dir];
		_barrier = "Land_HBarrierBig_F" createVehicle _pos;
		waitUntil {alive _barrier};
		_barrier setDir _dir;
		_dir = _dir + 36;
		_barrier allowDamage false; 
		_barrier setVectorUp surfaceNormal position _barrier;
		_unitsArray = _unitsArray + [_barrier];
	};	
	sleep 0.1;

//-------------------- 5. SPAWN FORCE PROTECTION

private _infgroupamount = 0;
private _unitArray = (missionconfigfile >> "unitList" >> MainFaction >> "units") call BIS_fnc_getCfgData;

	for "_x" from 1 to 5 do {
		_randomPos = [_flatPos, 5, 350, 2, 0, 20, 0] call BIS_fnc_findSafePos;
		_infantryGroup = createGroup EAST;
		_infgroupamount = _infgroupamount + 1;
		_infantryGroup setGroupIdGlobal [format ['Prio-infantry-%1',_infgroupamount]];
		for "_x" from 1 to 8 do {
			_unit = selectRandom _unitArray;
			_grpMember = _infantryGroup createUnit [_unit, _randomPos, [], 0, "NONE"];
		};
		sleep 0.5;
		[_infantryGroup, _flatpos, 225] call BIS_fnc_taskPatrol;
		
		{
			_spawnedUnits pushBack _x;
			
		} foreach (units _infantryGroup);
	};
	
//--------------------- Add units to zues

{_x addCuratorEditableObjects [_spawnedUnits, true];} foreach allCurators;

sleep 0.1;	
	
//-------------------- reduce dammage

	{
		_x setVariable ["selections", []];
		_x setVariable ["gethit", []];
		_x addEventHandler
		[
			"HandleDamage",
			{
				params ["_unit","_selection","","","","",""];
				_selections = _unit getVariable ["selections", []];
				_gethit = _unit getVariable ["gethit", []];
				
				if !(_selection in _selections) then
				{
					_selections set [count _selections, _selection];
					_gethit set [count _gethit, 0];
				};
				_i = _selections find _selection;
				_olddamage = _gethit select _i;
				_damage = _olddamage + ((_this select 2) - _olddamage) * 0.5;
				_gethit set [_i, _damage];
				_damage;
			}
		];
	}forEach [priorityObj0,priorityObj1,priorityObj2];
	
//-------------------- 7. BRIEFING

	_fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["priorityMarker", "priorityCircle"];  
	
	priorityTargetText = "Anti-Air Battery";
	"priorityMarker" setMarkerText "Priority Target: Anti-Air Battery";
	
	[west,["priorAnti-AirTask"],["OPFOR forces are setting up an anti-air battery to hit you guys damned hard! We've picked up their positions with thermal imaging scans and have marked it on your map. This is a priority target, boys! They're just setting up now","Priority Target: Anti-air","priorityCircle"],(getMarkerPos "priorityCircle"),"Created",0,true,"NewPriorityTarget",true] call BIS_fnc_taskCreate;

	
//-------------------- 8. CORE LOOP

//set some stuff
private _loopVar = true;
private _LOSStartPos = getPosASL priorityObj0;

while {_loopVar} do {
	
	//check if we can still fire
	if (!(canFire priorityObj0) && !(canFire priorityObj1) && !(canFire priorityObj2)) exitWith {_loopVar = FALSE;};
	
	//reset some stuff
	private _targetList = [];
	private _doTargets = [];
	private _targetSelect = objNull;
	private _targetListEnemy = [];
	
	priorityObj0 doWatch _basepos;
	priorityObj1 doWatch _basepos;
	priorityObj2 doWatch _basepos;
	
	//start selecting targets
	_targetList = _flatPos nearEntities [["Air"],5000];
	
	//if there aren't no air contacts proceed please
	if ((count _targetList) > 0) then {
	
		//select all blufor units
		{
			if ((side _x) == west) then {
				0 = _targetListEnemy pushBack _x;
			};
		} count _targetList;
	
		//if there are blufor units in the air proceed
		if ((count _targetListEnemy) > 0) then {
		
			//check if we can see him
			{
				_LOSEndPos = getPosASL _x;
				_visableTarget = [objNull, "FIRE"] checkVisibility [_LOSStartPos, _LOSEndPos];
				if (_visableTarget > 0.5) then {_doTargets pushBack _x;};
			} forEach _targetListEnemy;
			
			//if there aren't no targets we can see, start shooting
			if ((count _doTargets) > 0) then {
			
				//i know where you are, now the AI does too 
				{_priorityGroup reveal [_x,4];} forEach _targetListEnemy;
			
				//just a quick check to make sure we can all still fire
				if (!(canFire priorityObj0) && !(canFire priorityObj1) && !(canFire priorityObj2)) exitWith {_loopVar = FALSE;};
				
				{
				if (alive _x) then {
					_targetSelect = selectRandom _doTargets;
					_x doWatch _targetSelect;
					sleep 0.5;
					_x doTarget _targetSelect;
					sleep 0.1;
					_x doFire _targetSelect;
					sleep 0.1;
					_x fireAtTarget [_targetSelect];
				};
				} forEach [priorityObj0, priorityObj1, priorityObj2];
				
				//give them a little time to shoot at stuff before moving to the next target
				sleep 3;
				
			};
		};
	};
};

//-------------------- 9. DE-BRIEF
["priorAnti-AirTask", "Succeeded",true] call BIS_fnc_taskSetState;
sleep 10;
["priorAnti-AirTask",west] call bis_fnc_deleteTask;
{_x setMarkerPos [-10000,-10000,-10000];} forEach ["priorityMarker","priorityCircle"];

//-------------------- 10. DELETE
sleep 300;

_toDelete = _unitsArray + _spawnedUnits + [priorityObj0,priorityObj1,priorityObj2,ammoTruck];
{ deleteVehicle _x } forEach _toDelete;
[_groupsArray] spawn AW_fnc_SMdelete;
