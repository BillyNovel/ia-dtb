/*
Author: BACONMOP
Populate single Building

 
 */

#define UrbanUnits ["rhs_vdv_des_at","rhs_vdv_des_arifleman","rhs_vdv_des_efreitor","rhs_vdv_des_junior_sergeant","rhs_vdv_des_rifleman","rhs_vdv_des_rifleman_asval","rhs_vdv_des_grenadier","rhs_vdv_des_LAT","rhs_vdv_des_RShG2","rhs_vdv_des_grenadier_rpg","rhs_vdv_des_medic","rhs_vdv_des_machinegunner","rhs_vdv_des_engineer","rhs_vdv_des_aa","rhs_vdv_des_marksman"]

private _spawnedUnits = [];
private _buildingObj = _this select 0;
private _urbanGroup = createGroup east;
_urbanGroup setGroupIdGlobal [format ['AO-CacheDefenders']];
_buildingPosArray = (_buildingObj buildingPos -1);
_buildingPosNumber = random (count _buildingPosArray);
for "_x" from 0 to _buildingPosNumber do {
	_lostBuildingPos = selectRandom _buildingPosArray;
	_buildingPosArray = _buildingPosArray - [_lostBuildingPos];	
};

    {
        _x params ["_posX","_posY","_posZ"];
        //diag_log format ["x:%1 y:%2 z:%3",_posX,_posY,_posZ];
        _unit = _urbanGroup createUnit [(selectRandom UrbanUnits), [_posX,_posY,_posZ],[],0,"NONE"];
        doStop _unit;
        commandStop _unit;
        
        _unit setPos [_posX,_posY,_posZ];
		_unit setDir (random 360);
        _spawnedUnits pushBack _unit;
    } foreach (_buildingPosArray);
{_x addCuratorEditableObjects [units _urbanGroup, false];} foreach allCurators;
_spawnedUnits
