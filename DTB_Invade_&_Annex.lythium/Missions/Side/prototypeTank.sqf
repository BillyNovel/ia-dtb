/*
Author: BACONMOP
Destroy a prototype Tank

Last modified:

	19/08/2017 by stanhope
	
modified:
	
	general tweaks
*/

private [];

_nospawning =  BaseArray + ["currentAO"];  
  

// Get Location for Sidemission -----------------
_flatPos = [0,0,0];
_accepted = false;
while {!_accepted} do {
    _position = [] call BIS_fnc_randomPos;
    _flatPos = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Dome_Small_F",0,false];

    while {(count _flatPos) < 3} do {
        _position = [] call BIS_fnc_randomPos;
        _flatPos = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Dome_Small_F",0,false];
    };

    _accepted = true;
	{
		_NearBaseLoc = _flatPos distance (getMarkerPos _x);
		if (_NearBaseLoc < 1000) then {_accepted = false;};
	} forEach _nospawning;
};

// Create Objective Tank ------------------------

_grp1 = createGroup east;
_grp1 setGroupIdGlobal [format ['Side-ProtoTank']];

_protoTank = createVehicle ["rhs_t90a_tv", _flatPos,[],0,"NONE"];
[_protoTank,_grp1] call BIS_fnc_spawnCrew;
{_x lock 3;_x allowCrewInImmobile true;} forEach [_protoTank];
[_grp1, _flatPos, 200] call bis_fnc_taskPatrol;
{_x addCuratorEditableObjects [(crew _protoTank)+ [_protoTank], false];} foreach allCurators;

//Remove current weapons
{_protoTank removeMagazine _x} forEach ["24Rnd_125mm_APFSDS_T_Green", "12Rnd_125mm_HE_T_Green", "12Rnd_125mm_HEAT_T_Green"];
{_protoTank removeWeapon _x} forEach ["cannon_125mm", "LMG_coax"];

//Add new weapons
{_protoTank addWeapon _x} forEach ["Gatling_30mm_Plane_CAS_01_F","Missile_AGM_02_Plane_CAS_01_F","Rocket_04_HE_Plane_CAS_01_F"];
{_protoTank addMagazine _x} forEach ["1000Rnd_Gatling_30mm_Plane_CAS_01_F","1000Rnd_Gatling_30mm_Plane_CAS_01_F","6Rnd_Missile_AGM_02_F","7Rnd_Rocket_04_HE_F","7Rnd_Rocket_04_HE_F","7Rnd_Rocket_04_HE_F","6Rnd_Missile_AGM_02_F"];

_protoTank setVariable ["selections", []];
_protoTank setVariable ["gethit", []];
_protoTank addEventHandler
	[
		"HandleDamage",
		{
			_unit = _this select 0;
			_selections = _unit getVariable ["selections", []];
			_gethit = _unit getVariable ["gethit", []];
			_selection = _this select 1;
			if !(_selection in _selections) then
			{
				_selections set [count _selections, _selection];
				_gethit set [count _gethit, 0];
			};
			_i = _selections find _selection;
			_olddamage = _gethit select _i;
			_damage = _olddamage + ((_this select 2) - _olddamage) * 0.25;
			_gethit set [_i, _damage];
			_damage;
		}
	];
	


// Spawn SM Forces --------------------------------

_smUnits = [_flatPos,300,2,3,2,4,2,2] call AW_fnc_sideMissionEnemy;

// Breifing and Markers ---------------------------

_fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];
{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
sideMarkerText = "Prototype Tank";
"sideMarker" setMarkerText "Side Mission: Prototype Tank";
[west,["tankTask"],["We have gotten reports that OpFor have sent a prototype tank to their allies for a field test. Get over there and destroy that thing. Be careful, our operatives have said that has much more armor than standard and carries a wide array of powerful weapons.","Side Mission: Prototype Tank","sideCircle"],(getMarkerPos "sideCircle"),"Created",0,true,"protoTank",true] call BIS_fnc_taskCreate;


// WaitUntil Tank is dead -------------------------

waitUntil {sleep 5; !alive _protoTank;};

// Debrief ----------------------------------------
[] call AW_fnc_SMhintSUCCESS;
{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"];
["tankTask", "SUCCEEDED",true] call BIS_fnc_taskSetState;
sleep 5;
["tankTask",west] call bis_fnc_deleteTask;
sleep 300;
{
	if (!(isNull _x) && {alive _x}) then {
	deleteVehicle _x;
	};
} foreach units _grp1;
{
    if (!(isNull _x) && {alive _x}) then {
        deleteVehicle _x;
    };
} foreach _smUnits;
