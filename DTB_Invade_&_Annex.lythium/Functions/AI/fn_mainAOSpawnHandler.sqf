#include "unitDefines.hpp"
/*
* Author: alganthe
* Description: Handles creating the AI

last edited: 18/8/2017 by stanhope

edited: reworked the garrison part and did some general tweaks

*
* Arguments:
* 0: Position of the mission <POSITION>
* 1: <ARRAY>
*    1: Place AA vehicles <BOOL>
*    2: Place  MRAPS <BOOL>
*    3: Place random vehcs <BOOL>
*    4: Place infantry groups <BOOL>
*    5: Place AA groups <BOOL>
*    6: Place AT groups <BOOL>
*    7: Place urban groups <BOOL>
*    8: Place infantry in milbuildings <BOOL>
* 2: AA vehicles amount <SCALAR> (OPTIONNAL)
* 3: MRAPs amount <SCALAR> (OPTIONNAL)
* 4: Random vehcs amount <SCALAR> (OPTIONNAL)
* 5: Infantry groups amount <SCALAR> (OPTIONNAL)
* 6: AA groups amount <SCALAR> (OPTIONNAL)
* 7: AT groups amount <SCALAR> (OPTIONNAL)
* 8: Urban groups amount <SCALAR> (OPTIONNAL)
*
* Return Value:
* Array of units created if executed on the server
* Nothing if executed anywhere else (it publicVarServer the array of spawned units instead)
*
* Example:
*
*[_pos, [true, true, false, true, true, true, true, false], 2, 1, 3, 5, 1, 1, 3] call derp_fnc_mainAOSpawnHandler;
*/
params ["_AOpos", "_settingsArray", ["_radiusSize", derp_PARAM_AOSize], ["_AAAVehcAmount", derp_PARAM_AntiAirAmount], ["_MRAPAmount", derp_PARAM_MRAPAmount], ["_randomVehcsAmount", derp_PARAM_RandomVehcsAmount], ["_infantryGroupsAmount", derp_PARAM_InfantryGroupsAmount], ["_AAGroupsAmount", derp_PARAM_AAGroupsAmount], ["_ATGroupsAmount", derp_PARAM_ATGroupsAmount], ["_urbanInfantryAmount", 2]];

_settingsArray params [["_AAAVehcSetting", false], ["_MRAPSetting", false], ["_randomVehcsSetting", false], ["_infantryGroupsSetting", false], ["_AAGroupsSetting", false], ["_ATGroupsSetting", false], ["_urbanInfantrySetting", false], ["_milbuildingInfantry", false]];

private _spawnedUnits = [];


//-------------------------------------------------- AA vehicles
private ["_grp1"];
private _AAvicamount = 0;
if (_AAAVehcSetting) then {
    for "_x" from 1 to _AAAVehcAmount do {
        private _randomPos = [[[_AOpos, (_radiusSize / 1.5)], []], ["water", "out"]] call BIS_fnc_randomPos;

		_AAVicList = (missionconfigfile >> "unitList" >> MainFaction >> "AAvic") call BIS_fnc_getCfgData;
        private _AAVehicle = (selectRandom _AAVicList) createVehicle _randomPos;

        _AAVehicle allowCrewInImmobile true;

        _AAVehicle lock 2;
        _grp1 = createGroup east;
		_AAvicamount = _AAvicamount + 1;
		_grp1 setGroupIdGlobal [format ['AO-AAVic-%1', _AAvicamount]];
        [_AAVehicle,_grp1,MainFaction] call AW_fnc_createCrew;

        _spawnedUnits pushBack _AAVehicle;

        {
            _spawnedUnits pushBack _x;
        } foreach (crew _AAVehicle);
		{_x addCuratorEditableObjects [(crew _AAVehicle) + [_AAVehicle], false];} foreach allCurators;

        private _group = group _AAVehicle;

        [_group, _AOpos, _radiusSize / 2] call BIS_fnc_taskPatrol;
        _group setSpeedMode "LIMITED";
    };
};
sleep 0.1;
//-------------------------------------------------- MRAP
private ["_grp1"];
private _MRAPAmount = 0;
if (_MRAPSetting) then {
    for "_x" from 1 to _MRAPAmount do {
        private _randomPos = [[[_AOpos, _radiusSize], []], ["water", "out"]] call BIS_fnc_randomPos;
		_MRAPList = (missionconfigfile >> "unitList" >> MainFaction >> "cars") call BIS_fnc_getCfgData;
        private _MRAP = (selectRandom MRAPList) createVehicle _randompos;

        _MRAP allowCrewInImmobile true;
        _MRAP lock 2;
        _grp1 = createGroup east;
		_MRAPAmount = _MRAPAmount + 1;
		_grp1 setGroupIdGlobal [format ['AO-MRAP-%1', _MRAPAmount]];
        [_MRAP,_grp1,MainFaction] call AW_fnc_createCrew;
        _spawnedUnits pushBack _MRAP;

        {
            _spawnedUnits pushBack _x;
        } foreach (crew _MRAP);
		{_x addCuratorEditableObjects [(crew _MRAP)+ [_MRAP], false];} foreach allCurators;

        private _group = group _MRAP;

        [_group, _AOpos, _radiusSize / 3] call BIS_fnc_taskPatrol;
        _group setSpeedMode "LIMITED";
    };
};
sleep 0.1;
//-------------------------------------------------- random vehcs
private ["_grp1"];
private _RandomVicAmount = 0;
if (_randomVehcsSetting) then {
    for "_x" from 1 to _randomVehcsAmount do {
        private _randomPos = [[[_AOpos, _radiusSize], []], ["water", "out"]] call BIS_fnc_randomPos;
		_RandomVehicleList = (missionconfigfile >> "unitList" >> MainFaction >> "APCs") call BIS_fnc_getCfgData;
        private _vehc = (selectRandom _RandomVehicleList) createVehicle _randompos;

        _vehc allowCrewInImmobile true;
        _vehc lock 2;
        _grp1 = createGroup east;
		_RandomVicAmount = _RandomVicAmount + 1;
		_grp1 setGroupIdGlobal [format ['AO-RandVic-%1', _RandomVicAmount]];
        [_vehc,_grp1,MainFaction] call AW_fnc_createCrew;
        _spawnedUnits pushBack _vehc;
        {
            _spawnedUnits pushBack _x;
        } foreach (crew _vehc);
		{_x addCuratorEditableObjects [(crew _vehc)+ [_vehc], false];} foreach allCurators;
        private _group = group _vehc;

        [_group, _AOpos, _radiusSize / 2] call BIS_fnc_taskPatrol;
        _group setSpeedMode "LIMITED";
    };
};
sleep 0.1;
//-------------------------------------------------- main infantry groups
private _MainInfAmount = 0;
if (_infantryGroupsSetting) then {
    for "_x" from 1 to _infantryGroupsAmount do {
        private _randomPos = [[[_AOpos, _radiusSize * 1.2], []], ["water", "out"]] call BIS_fnc_randomPos;
		private _infantryGroup = createGroup EAST;
		_MainInfAmount = _MainInfAmount + 1;
		_infantryGroup setGroupIdGlobal [format ['AO-MainInf-%1', _MainInfAmount]];
		for "_x" from 1 to 8 do {
			private _squadPos = [[[_randomPos, 10], []], ["water", "out"]] call BIS_fnc_randomPos;
			_unitArray = (missionconfigfile >> "unitList" >> MainFaction >> "units") call BIS_fnc_getCfgData;
			_unit = _unitArray call BIS_fnc_selectRandom;
			_grpMember = _infantryGroup createUnit [_unit, _squadPos, [], 0, "FORM"];
		};

        [_infantryGroup, _AOpos, _radiusSize / 1.6] call AW_FNC_taskPatrol;

        {
            _spawnedUnits pushBack _x;
        
        } foreach (units _infantryGroup);
		{_x addCuratorEditableObjects [units _infantryGroup, false];} foreach allCurators;
    };
};
sleep 0.1;
//-------------------------------------------------- AA groups
private _AAInfAmount = 0;
if (_AAGroupsSetting) then {
    for "_x" from 1 to _AAGroupsAmount do {
        private _randomPos = [[[_AOpos, _radiusSize], []], ["water", "out"]] call BIS_fnc_randomPos;
        private _infantryGroup = [_randomPos, EAST, (configfile InfantryGroupsCFGPATH (selectRandom AAGroupsList))] call BIS_fnc_spawnGroup;
		_AAInfAmount = _AAInfAmount + 1;
		_infantryGroup setGroupIdGlobal [format ['AO-AAInf-%1', _AAInfAmount]];

        [_infantryGroup, _AOpos, _radiusSize / 1.6] call AW_FNC_taskPatrol;

        {
            _spawnedUnits pushBack _x;
     
        } foreach (units _infantryGroup);
		{_x addCuratorEditableObjects [units _infantryGroup, false];} foreach allCurators;
    };
};
sleep 0.1;
//-------------------------------------------------- AT groups
private _ATInfAmount = 0;
if (_ATGroupsSetting) then {
    for "_x" from 1 to _ATGroupsAmount do {
        private _randomPos = [[[_AOpos, _radiusSize], []], ["water", "out"]] call BIS_fnc_randomPos;
        private _infantryGroup = [_randomPos, EAST, (configfile InfantryGroupsCFGPATH (selectRandom ATGroupsList))] call BIS_fnc_spawnGroup;
		_ATInfAmount = _ATInfAmount + 1;
		_infantryGroup setGroupIdGlobal [format ['AO-ATInf-%1', _ATInfAmount]];
        [_infantryGroup, _AOpos, _radiusSize / 1.6] call AW_FNC_taskPatrol;

        {
            _spawnedUnits pushBack _x;

        } foreach (units _infantryGroup);
		{_x addCuratorEditableObjects [units _infantryGroup, false];} foreach allCurators;
    };
};
sleep 0.1;
//=================Garrison inf===========================
private ["_milBuildingsarray","_milBuildingCount","_garrisongroupamount","_garrisongroup","_infBuilding","_infbuildingpos","_buildingposcount","_Garrisonpos",
"_unitArray","_unittype","_unit","_infBuildingArray","_infBuildingAmount","_MilitaryBuidings","_unitpos"];
_MilitaryBuidings = ["Land_Cargo_House_V1_F","Land_Cargo_House_V2_F","Land_Cargo_House_V3_F","Land_Medevac_house_V1_F","Land_Research_house_V1_F","Land_Cargo_HQ_V1_F",
"Land_Cargo_HQ_V2_F","Land_Cargo_HQ_V3_F","Land_Research_HQ_F","Land_Medevac_HQ_V1_F","Land_Cargo_Patrol_V1_F","Land_Cargo_Patrol_V2_F","Land_Cargo_Patrol_V3_F",
"Land_Cargo_Tower_V1_F","Land_Cargo_Tower_V2_F","Land_Cargo_Tower_V3_F","Land_i_Barracks_V1_F","Land_i_Barracks_V2_F","Land_BagBunker_Large_F","Land_BagBunker_Small_F",
"Land_BagBunker_Tower_F","Land_Bunker_01_small_F","Land_Bunker_01_tall_F","Land_Bunker_01_big_F","Land_Bunker_01_HQ_F","Land_PillboxBunker_01_rectangle_F",
"Land_PillboxBunker_01_hex_F","Land_PillboxBunker_01_big_F"];


_milBuildingsarray = nearestObjects [_AOpos, _MilitaryBuidings, _radiusSize/0.9];
 _milBuildingCount = count _milBuildingsarray;
 _garrisongroupamount = 0;
if (_milBuildingCount > 0) then{

	if (_milBuildingCount > 15) then{_milBuildingCount = 15;};

	for "_i" from 1 to _milBuildingCount do {
		_infBuilding = selectRandom _milBuildingsarray;
		_milBuildingsarray = _milBuildingsarray - [_infBuilding];
		_infbuildingpos = _infBuilding buildingPos -1;
		_buildingposcount = count _infbuildingpos;
		if (_buildingposcount > 12 ) then {_buildingposcount = 12};
		
		_garrisongroupamount = _garrisongroupamount + 1;
		_garrisongroup = createGroup east;
		_garrisongroup setGroupIdGlobal [format ['AO-MilGarrisonInf-%1', _garrisongroupamount]];
		
		if (_buildingposcount > 0) then{
			for "_i" from 1 to _buildingposcount do {
				_unitpos = selectRandom _infbuildingpos;
				_infbuildingpos = _infbuildingpos - [_unitpos];
				 _unitArray = (missionconfigfile >> "unitList" >> MainFaction >> "units") call BIS_fnc_getCfgData;
				 _unittype = selectRandom _unitArray;
				 _unit = _garrisongroup createUnit [_unittype, _unitpos, [], 0, "CAN_COLLIDE"];
				
			};
		};
		{
			_spawnedUnits pushBack _x;

		} foreach (units _garrisongroup);
		{_x addCuratorEditableObjects [units _garrisongroup, false];} foreach allCurators;
		
	};
};
sleep 0.1;
_infBuildingArray = nearestObjects [_AOpos, ["house","building"], _radiusSize/0.9];
_milBuildingsarray = nearestObjects [_AOpos, _MilitaryBuidings, _radiusSize/0.9];
_infBuildingArray = _infBuildingArray - _milBuildingsarray;
_infBuildingAmount = count _infBuildingArray;
 _garrisongroupamount = 0;

if (_infBuildingAmount > 0) then {
	if (_infBuildingAmount > 10 ) then { _infBuildingAmount = 10;};
	
	for "_i" from 1 to _infBuildingAmount do {
		_infBuilding = selectRandom _infBuildingArray;
		_infBuildingArray = _infBuildingArray - [_infBuilding];
		_infbuildingpos = _infBuilding buildingPos -1;
		_buildingposcount = count _infbuildingpos;
		if (_buildingposcount > 12 ) then {_buildingposcount = 12};
		
		if (_buildingposcount > 0) then {
			_garrisongroupamount = _garrisongroupamount + 1;
			_garrisongroup = createGroup east;
			_garrisongroup setGroupIdGlobal [format ['AO-CivGarrisonInf-%1', _garrisongroupamount]];
			if (_buildingposcount > 0) then{
				for "_i" from 2 to _buildingposcount do {
					_unitpos = selectRandom _infbuildingpos;
					_infbuildingpos = _infbuildingpos - [_unitpos];
					_unitArray = (missionconfigfile >> "unitList" >> MainFaction >> "units") call BIS_fnc_getCfgData;
					_unittype = selectRandom _unitArray;
					_unit = _garrisongroup createUnit [_unittype, _unitpos, [], 0, "CAN_COLLIDE"];
					
					
				};
			};
			{
				_spawnedUnits pushBack _x;

			} foreach (units _garrisongroup);
			{_x addCuratorEditableObjects [units _garrisongroup, false];} foreach allCurators;
		};
	};
};
sleep 0.1;




if (isServer) then {
    _spawnedUnits
} else {
    [_spawnedUnits, true] remoteExec ["derp_fnc_remoteAddCuratorEditableObjects", 2];
    spawnedUnits = _spawnedUnits;
    publicVariableServer "spawnedUnits";
    spawnedUnits = nil;
};
