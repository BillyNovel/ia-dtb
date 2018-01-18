/*
Description:  Script that spawns in a reward after side mission succes and also displays 

Author: Unknown

Last edited: 10/07/2017 by stanhope

Edit:
changed manual selection of rewards + added some rewards + changed random spawn rate


Called by the side mission scripts using:
[] call AW_fnc_SMhintSUCCESS;
[['an enhanced FV-720 Mora', 'Land_PipeWall_concretel_8m_F'],-1] call AW_fnc_SMhintSUCCESS;
*/

private ["_veh","_vehName","_vehVarname","_completeText","_reward","_GAU","_GMG","_mortar","_HELLCAT","_waspcamo","_i","_mortar","_kuma","_slammer","_t100",
"_ATLauncher","_truck","_AA","_AAA","_ATLauncher","_AALauncher","_missilepod","_AMRAAMcount","_innerpylon","_outerpylon","_vehiclepos", "_Mini", "_Sniper"];


//First param allows to manually select a certain reward.  Second one allows you to spawn a reward without a hint.
params ["_vehChosen","_NotAReward"];

smRewards =
[
/*
A reward will be picked from this array, first entery is the display name, second the actual reward.  
Some rewards are edited after they are spawned.

The spawn rate for randomly selected rewards can be messed with by putting rewards in here multiple times.
*/

//Jets
['an A-164 Wipeout (CAS)', 'B_Plane_CAS_01_dynamicLoadout_F'],
['a V-44 X Blackfish Gunship', 'B_T_VTOL_01_armed_F'],
['an F/A-181 Black/ Wasp II', 'B_Plane_Fighter_01_F'],
['an F/A-181 Black Wasp II (Stealth)', 'B_Plane_Fighter_01_Stealth_F'],
['an A-149 Gryphon', 'I_Plane_Fighter_04_F'],

//attack helis
['an MI-48 Kajman', 'O_Heli_Attack_02_black_F'],
['an MI-48 Kajman', 'O_Heli_Attack_02_black_F'],
['an AH-99 Blackfoot', 'B_Heli_Attack_01_F'],
['an AH-99 Blackfoot', 'B_Heli_Attack_01_F'],
['a PO-30 Orca', 'O_Heli_Light_02_F'],
['a PO-30 Orca', 'O_Heli_Light_02_F'],
['an AH-9 Pawnee', 'B_Heli_Light_01_armed_F'],
['an AH-9 Pawnee', 'B_Heli_Light_01_armed_F'],
['an AH-9 Pawnee GAU - 19', 'Rabbit_F'],
['an AH-9 Pawnee GAU - 19', 'Rabbit_F'],
['an AH-9 Pawnee GMG - 20MM', 'Land_GarbageBags_F'],
['an AH-9 Pawnee GMG - 20MM', 'Land_GarbageBags_F'],
['a WY-55 Hellcat', 'I_Heli_light_03_F'],
['a WY-55 Hellcat', 'I_Heli_light_03_F'],
['a LAT WY-55 Hellcat', 'Land_NetFence_01_m_pole_F'],
['a LAT WY-55 Hellcat', 'Land_NetFence_01_m_pole_F'],


//transport helis
['an MI-290 Taru (Transport)', 'O_Heli_Transport_04_covered_F'],
['an MI-290 Taru (Transport)', 'O_Heli_Transport_04_covered_F'],
['an MI-290 Taru (Bench)', 'O_Heli_Transport_04_bench_F'],
['an MI-290 Taru (Bench)', 'O_Heli_Transport_04_bench_F'],
['an Y-32 (Infantry Transport, unarmed)', 'O_T_VTOL_02_infantry_F'],
['an Y-32 (Infantry Transport, unarmed)', 'O_T_VTOL_02_infantry_F'],
['an Y-32 (Infantry Transport, unarmed)', 'O_T_VTOL_02_infantry_F'],

//UAVs/UGVs
['a MQ-12 Falcon', 'B_T_UAV_03_F'],
['a MQ-12 Falcon', 'B_T_UAV_03_F'],
['a UCAV Sentinel', 'B_UAV_05_F'],
['a UCAV Sentinel', 'B_UAV_05_F'],
['a UCAV Sentinel', 'B_UAV_05_F'],
['a hemtt mounted Praetorian 1C', 'Land_VR_CoverObject_01_kneelHigh_F'],
['a hemtt mounted Praetorian 1C', 'Land_VR_CoverObject_01_kneelHigh_F'],
['a hemtt mounted Praetorian 1C', 'Land_VR_CoverObject_01_kneelHigh_F'],
['a hemtt mounted Mk49 Spartan', 'Land_VR_CoverObject_01_standHigh_F'],
['a hemtt mounted Mk49 Spartan', 'Land_VR_CoverObject_01_standHigh_F'],
['a hemtt mounted Mk49 Spartan', 'Land_VR_CoverObject_01_standHigh_F'],

//MBTs
['a T-100 Varsuk', 'O_MBT_02_cannon_F'],
['a T-100 Varsuk', 'O_MBT_02_cannon_F'],
['a T-100 Varsuk', 'O_MBT_02_cannon_F'],
['an enhanced T-100 Varsuk', 'Land_W_sharpStone_01'],
['an enhanced T-100 Varsuk', 'Land_W_sharpStone_01'],
['an enhanced T-100 Varsuk', 'Land_W_sharpStone_01'],
['an MBT-52 Kuma', 'I_MBT_03_cannon_F'],
['an MBT-52 Kuma', 'I_MBT_03_cannon_F'],
['an MBT-52 Kuma', 'I_MBT_03_cannon_F'],
['an enhanced MBT-52 Kuma', 'Land_BluntStones_erosion'],
['an enhanced MBT-52 Kuma', 'Land_BluntStones_erosion'],
['an enhanced MBT-52 Kuma', 'Land_BluntStones_erosion'],
['an M2A4 Slammer', 'B_T_MBT_01_cannon_F'],
['an M2A4 Slammer', 'B_T_MBT_01_cannon_F'],
['an M2A4 Slammer (Urban Purpose)', 'B_MBT_01_TUSK_F'],
['an M2A4 Slammer (Urban Purpose)', 'B_MBT_01_TUSK_F'],
['an M2A4 Slammer (Urban Purpose)', 'B_MBT_01_TUSK_F'],
['an enhanced M2A4 Slammer (Urban Purpose)', 'Land_W_sharpStone_02'],
['an enhanced M2A4 Slammer (Urban Purpose)', 'Land_W_sharpStone_02'],
['an enhanced M2A4 Slammer (Urban Purpose)', 'Land_W_sharpStone_02'],


//IFVs
['an FV-720 Mora', 'I_APC_tracked_03_cannon_F'],
['an FV-720 Mora', 'I_APC_tracked_03_cannon_F'],
['an FV-720 Mora', 'I_APC_tracked_03_cannon_F'],
['an FV-720 Mora', 'I_APC_tracked_03_cannon_F'],
['an enhanced FV-720 Mora', 'Land_PipeWall_concretel_8m_F'],
['an enhanced FV-720 Mora', 'Land_PipeWall_concretel_8m_F'],
['an enhanced FV-720 Mora', 'Land_PipeWall_concretel_8m_F'],
['an enhanced FV-720 Mora', 'Land_PipeWall_concretel_8m_F'],
['an AFV-4 Gorgon', 'I_APC_Wheeled_03_cannon_F'],
['an AFV-4 Gorgon', 'I_APC_Wheeled_03_cannon_F'],
['an AFV-4 Gorgon', 'I_APC_Wheeled_03_cannon_F'],
['an AFV-4 Gorgon', 'I_APC_Wheeled_03_cannon_F'],
['an enhanced AFV-4 Gorgon', 'Land_Net_Fence_pole_F'],
['an enhanced AFV-4 Gorgon', 'Land_Net_Fence_pole_F'],
['an enhanced AFV-4 Gorgon', 'Land_Net_Fence_pole_F'],
['an enhanced AFV-4 Gorgon', 'Land_Net_Fence_pole_F'],
['an AMV-7 Marshall', 'B_APC_Wheeled_01_cannon_F'],
['an AMV-7 Marshall', 'B_APC_Wheeled_01_cannon_F'],
['an AMV-7 Marshall', 'B_APC_Wheeled_01_cannon_F'],
['an AMV-7 Marshall', 'B_APC_Wheeled_01_cannon_F'],
['an enhanced AMV-7 Marshall', 'Land_Pipe_fence_4m_F'],
['an enhanced AMV-7 Marshall', 'Land_Pipe_fence_4m_F'],
['an enhanced AMV-7 Marshall', 'Land_Pipe_fence_4m_F'],
['an enhanced AMV-7 Marshall', 'Land_Pipe_fence_4m_F'],

//AA
['an IFV-6a Cheetah', 'B_APC_Tracked_01_AA_F'],
['an IFV-6a Cheetah', 'B_APC_Tracked_01_AA_F'],
['an IFV-6a Cheetah', 'B_APC_Tracked_01_AA_F'],
['an IFV-6a Cheetah', 'B_APC_Tracked_01_AA_F'],
['an IFV-6a Cheetah', 'B_APC_Tracked_01_AA_F'],
['an IFV-6a Cheetah', 'B_APC_Tracked_01_AA_F'],

//APC
['a CRV-6e Bobcat', 'B_APC_Tracked_01_CRV_F'],
['a CRV-6e Bobcat', 'B_APC_Tracked_01_CRV_F'],
['a CRV-6e Bobcat', 'B_APC_Tracked_01_CRV_F'],
['a minigun Bobcat', 'OfficeTable_01_new_F'],
['a minigun Bobcat', 'OfficeTable_01_new_F'],
['a minigun Bobcat', 'OfficeTable_01_new_F'],

//MRAP
['a Strider HMG', 'I_MRAP_03_hmg_F'],
['a Strider HMG', 'I_MRAP_03_hmg_F'],
['a Strider HMG', 'I_MRAP_03_hmg_F'],
['a Strider HMG', 'I_MRAP_03_hmg_F'],
['a Strider HMG', 'I_MRAP_03_hmg_F'],
['a Strider HMG', 'I_MRAP_03_hmg_F'],
['a Strider GMG', 'I_MRAP_03_gmg_F'],
['a Strider GMG', 'I_MRAP_03_gmg_F'],
['a Hunter (Minigun)', 'Land_RattanTable_01_F'],
['a Hunter (Minigun)', 'Land_RattanTable_01_F'],
['a Hunter (Minigun)', 'Land_RattanTable_01_F'],
['a Hunter (Minigun)', 'Land_RattanTable_01_F'],
['a Strider (Minigun)', 'OfficeTable_01_old_F'],
['a Strider (Minigun)', 'OfficeTable_01_old_F'],
['a Strider (Minigun)', 'OfficeTable_01_old_F'],
['a Strider (Minigun)', 'OfficeTable_01_old_F'],
['a Strider (Lynx)', 'Land_Graffiti_02_F'],
['a Strider (Lynx)', 'Land_Graffiti_02_F'],


//Cars
['an Offroad (AT)', 'Sign_Arrow_Blue_F'],
['an Offroad (AT)', 'Sign_Arrow_Blue_F'],
['an Offroad (AT)', 'Sign_Arrow_Blue_F'],
['an Offroad (AT)', 'Sign_Arrow_Blue_F'],
['an Offroad (AA)', 'Sign_Arrow_Cyan_F'],
['an Offroad (AA)', 'Sign_Arrow_Cyan_F'],
['an Offroad (AA)', 'Sign_Arrow_Cyan_F'],
['an Offroad (AA)', 'Sign_Arrow_Cyan_F'],
['an Offroad (Armed .50 cal)', 'B_G_Offroad_01_armed_F'],
['an Offroad (Armed .50 cal)', 'B_G_Offroad_01_armed_F'],
['an Offroad (Armed .50 cal)', 'B_G_Offroad_01_armed_F'],
['an Offroad (Armed .50 cal)', 'B_G_Offroad_01_armed_F'],
['an Offroad (Armed minigun)', 'Land_TableDesk_F'],
['an Offroad (Armed minigun)', 'Land_TableDesk_F'],
['an Offroad (Armed minigun)', 'Land_TableDesk_F'],
['an Offroad (Armed minigun)', 'Land_TableDesk_F'],
//['an Offroad (Armed GMG)', 'Land_InfoStand_V1_F'],
['a Qilin (Armed)', 'O_T_LSV_02_armed_F'],
['a Qilin (Armed)', 'O_T_LSV_02_armed_F'],
['a Qilin (Armed)', 'O_T_LSV_02_armed_F'],
['a Qilin (Armed)', 'O_T_LSV_02_armed_F'],
['a Qilin (Armed)', 'O_T_LSV_02_armed_F'],
['a Qilin (Armed)', 'O_T_LSV_02_armed_F'],
['an Offroad (Repair)', 'C_Offroad_01_repair_F'],
['an Offroad (Repair)', 'C_Offroad_01_repair_F'],
['an Offroad (Repair)', 'C_Offroad_01_repair_F'],
['an Offroad (Repair)', 'C_Offroad_01_repair_F'],
['an Offroad (Repair)', 'C_Offroad_01_repair_F'],
['an Offroad (Repair)', 'C_Offroad_01_repair_F'],
['a service van', 'C_Van_02_service_F'],
['a service van', 'C_Van_02_service_F'],
['a service van', 'C_Van_02_service_F'],
['a Mobile Mortar Truck', 'B_G_Offroad_01_repair_F'],
['a Mobile Mortar Truck', 'B_G_Offroad_01_repair_F'],
['a Mobile Mortar Truck', 'B_G_Offroad_01_repair_F']

];

//List of all the markers rewards can spawn on
smMarkerList =["smReward1","smReward2","smReward3","smReward4","smReward5","smReward6","smReward7","smReward8","smReward9","smReward10","smReward11","smReward12","smReward13","smReward14","smReward15","smReward16","smReward17","smReward18","smReward19","smReward20","smReward21","smReward22","smReward23","smReward24","smReward25","smReward26","smReward27"];

//if no reward is selected chose a raondom one, else pick the selected one
if (isNil "_vehChosen") then{	
_veh = selectRandom smRewards;
}else{	
_veh = _vehChosen ;
};

//get the name and the vehicle type from the multidimensional array.
_vehName = _veh select 0;
_vehVarname = _veh select 1;

//Hint or no hint that's the question
if (isNil "_NotAReward") then {
_completeText = format["<t align='center'><t size='2.2'>Side Mission</t><br/><t size='1.5' color='#08b000'>COMPLETE</t><br/>____________________<br/>Fantastic job, lads! The OPFOR stationed on the island won't last long if you keep that up!<br/><br/>We've given you %1 to help with the fight. You'll find it at base.<br/><br/>Focus on the main objective for now; we'll relay this success to the intel team and see if there's anything else you can do for us. We'll get back to you in 10-15 minutes.</t>",_vehName];
[_completeText] remoteExec ["AW_fnc_globalHint",0,false];
_rewardtext = format["Your team received %1!", _vehName];
["Reward",_rewardtext] remoteExec ["AW_fnc_globalNotification",0,false];
};

//Create the actual vehicle
_vehiclepos = getMarkerPos "smReward1";
_reward = createVehicle [_vehVarname,[_vehiclepos select 0, _vehiclepos select 1, 0] ,smMarkerList,0,"NONE"];
waitUntil {!isNull _reward};


_reward setDir (markerDir "smReward1");

//=============reward altering===================

//---------jets--------
if (_reward isKindOf "B_Plane_CAS_01_dynamicLoadout_F") then {
	//an A-164 Wipeout (CAS)
	_reward removeMagazine "120Rnd_CMFlare_Chaff_Magazine";
	_reward addMagazine "60Rnd_CMFlare_Chaff_Magazine";
	{_reward removeWeapon _x} forEach ["Missile_AA_04_Plane_CAS_01_F","Missile_AGM_02_Plane_CAS_01_F","Rocket_04_HE_Plane_CAS_01_F","Rocket_04_AP_Plane_CAS_01_F","Bomb_04_Plane_CAS_01_F"];
	
	//====select random loadout=====
	_rocketpod = selectRandom ["PylonRack_12Rnd_missiles","PylonRack_12Rnd_PG_missiles","Shrieker"];
	if (_rocketpod == "PylonRack_12Rnd_PG_missiles")
	then {_missilepod = selectRandom ["PylonRack_1Rnd_Missile_AGM_02_F","PylonRack_1Rnd_LG_scalpel"];}
	else {_missilepod = selectRandom ["PylonRack_3Rnd_Missile_AGM_02_F","PylonRack_1Rnd_Missile_AGM_02_F","PylonRack_3Rnd_LG_scalpel","PylonRack_1Rnd_LG_scalpel"];};
	_bombs = selectRandom ["PylonMissile_1Rnd_Bomb_04_F","PylonMissile_1Rnd_Mk82_F","2x2"];
	
	//=========defensive AA=========
	_reward setPylonLoadOut [1, "PylonRack_1Rnd_Missile_AA_04_F",false,[]];
	_reward setPylonLoadOut [10, "PylonRack_1Rnd_Missile_AA_04_F",false,[]];
	//=========rocket pod===========
	if (_rocketpod == "Shrieker") then {
	_reward setPylonLoadOut [2, "PylonRack_7Rnd_Rocket_04_HE_F",false,[]];
	_reward setPylonLoadOut [9, "PylonRack_7Rnd_Rocket_04_AP_F",false,[]];
	}else{
	_reward setPylonLoadOut [2, _rocketpod,false,[]];
	_reward setPylonLoadOut [9, _rocketpod,false,[]];
	};
	//==========missiles==========
	_reward setPylonLoadOut [3, _missilepod,false,[]];
	_reward setPylonLoadOut [8, _missilepod,false,[]];
	//==========bombs==============
	if (_bombs == "2x2") then {
	_reward setPylonLoadOut [4, "PylonMissile_1Rnd_Mk82_F",false,[]];
	_reward setPylonLoadOut [5, "PylonMissile_1Rnd_Bomb_04_F",false,[]];
	_reward setPylonLoadOut [6, "PylonMissile_1Rnd_Bomb_04_F",false,[]];
	_reward setPylonLoadOut [7, "PylonMissile_1Rnd_Mk82_F",false,[]];
	}else{
	for "_i" from 4 to 7 do{_reward setPylonLoadOut [_i, _bombs,false,[]];};
	};
};

if (_reward isKindOf "B_Plane_Fighter_01_F") then {
	//an F/A-181 Black Wasp II
	_waspcamo = selectRandom [
	['a3\air_f_jets\plane_fighter_01\data\Fighter_01_fuselage_01_co.paa','a3\air_f_jets\plane_fighter_01\data\Fighter_01_fuselage_02_co.paa'],
	['a3\air_f_jets\plane_fighter_01\data\Fighter_01_fuselage_01_camo_co.paa','a3\air_f_jets\plane_fighter_01\data\Fighter_01_fuselage_02_camo_co.paa']];
	_u setObjectTextureGlobal[0, (_waspcamo select 0)];
	_u setObjectTextureGlobal[1, (_waspcamo select 1)];
	_u removeMagazine "240Rnd_CMFlare_Chaff_Magazine";
	_u addMagazine "120Rnd_CMFlare_Chaff_Magazine";
	_u removeWeapon "weapon_AGM_65Launcher";
	//====select random loadout=====
	_outerpylon = selectRandom ["PylonRack_Missile_AGM_02_x1","PylonMissile_Bomb_GBU12_x1","PylonRack_Missile_BIM9X_x1","PylonRack_Missile_AMRAAM_D_x1","PylonRack_Missile_AMRAAM_D_x2","PylonRack_Missile_BIM9X_x2"];
	switch (_outerpylon) do {
		case "PylonMissile_Bomb_GBU12_x1":{
			_AMRAAMcount = selectRandom ["2","4"];
			_innerpylon = selectRandom ["PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AGM_02_x2","PylonRack_Missile_BIM9X_x2","PylonRack_Missile_AMRAAM_D_x2"];
		};
		case "PylonRack_Missile_AGM_02_x1":{
			_AMRAAMcount = selectRandom ["2","4"];
			_innerpylon = selectRandom ["PylonRack_Missile_AGM_02_x2","PylonRack_Missile_AGM_02_x1","PylonRack_Bomb_GBU12_x2","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1","PylonRack_Missile_BIM9X_x2","PylonRack_Missile_AMRAAM_D_x1"];
		};
		case "PylonRack_Missile_BIM9X_x1":{
			_AMRAAMcount = selectRandom ["2","2","4"];
			_innerpylon = selectRandom ["PylonRack_Missile_AGM_02_x2","PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AGM_02_x1","PylonRack_Bomb_GBU12_x2","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1"];
		};
		case "PylonRack_Missile_BIM9X_x2":{
			_AMRAAMcount = selectRandom ["2","2","2","4"];
			_innerpylon = selectRandom ["PylonRack_Missile_AGM_02_x2","PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AGM_02_x1","PylonRack_Bomb_GBU12_x2","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1"];
		};
		case "PylonRack_Missile_AMRAAM_D_x1":{
			_AMRAAMcount = selectRandom ["2","2","4"];
			_innerpylon = selectRandom ["PylonRack_Missile_AGM_02_x2","PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AGM_02_x1","PylonRack_Bomb_GBU12_x2","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1"];
		};
		case "PylonRack_Missile_AMRAAM_D_x2":{
			_AMRAAMcount = selectRandom ["2","2","2","4"];
			_innerpylon = selectRandom ["PylonRack_Missile_AGM_02_x2","PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AGM_02_x1","PylonRack_Bomb_GBU12_x2","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1"];
		};
		default {
		_innerpylon = selectRandom ["PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AGM_02_x2","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1","PylonRack_Missile_BIM9X_x1","PylonRack_Missile_BIM9X_x2","PylonRack_Missile_AMRAAM_D_x1","PylonRack_Missile_AMRAAM_D_x2"];
		};
	};
	
	//======outer pylons=========
	_u setPylonLoadOut [1, _outerpylon,false,[]];
	_u setPylonLoadOut [2, _outerpylon,false,[]];
	//========inner pylons=========
	_u setPylonLoadOut [3, _innerpylon,false,[]];
	_u setPylonLoadOut [4, _innerpylon,false,[]];
	//========outer AA bays=========
	_u setPylonLoadOut [5, "PylonRack_Missile_BIM9X_x1",false,[]];
	_u setPylonLoadOut [6, "PylonRack_Missile_BIM9X_x1",false,[]];
	//=====outer and middle inner bay
	if (_AMRAAMcount == "2")then {
	_u setPylonLoadOut [7, "PylonMissile_Missile_AMRAAM_D_INT_x1",false,[]];
	_u setPylonLoadOut [8, "PylonMissile_Missile_AMRAAM_D_INT_x1",false,[]];
	_u setPylonLoadOut [9, "",false,[]];
	_u setPylonLoadOut [10, "",false,[]];
	};
	if (_AMRAAMcount == "4")then {	
	for "_i" from 7 to 10 do{_u setPylonLoadOut [_i, "PylonMissile_Missile_AMRAAM_D_INT_x1",false,[]];};
	};
	//=====inner pylons inner bay====
	_u setPylonLoadOut [11, "PylonMissile_Bomb_GBU12_x1",false,[]];
	_u setPylonLoadOut [12, "PylonMissile_Bomb_GBU12_x1",false,[]];	
};

if (_reward isKindOf "B_Plane_Fighter_01_Stealth_F") then {
	//an F/A-181 Black Wasp II (stealth)
	_waspcamo = selectRandom [
	['a3\air_f_jets\plane_fighter_01\data\Fighter_01_fuselage_01_co.paa','a3\air_f_jets\plane_fighter_01\data\Fighter_01_fuselage_02_co.paa'],
	['a3\air_f_jets\plane_fighter_01\data\Fighter_01_fuselage_01_camo_co.paa','a3\air_f_jets\plane_fighter_01\data\Fighter_01_fuselage_02_camo_co.paa']];
	_reward setObjectTextureGlobal[0, (_waspcamo select 0)];
	_reward setObjectTextureGlobal[1, (_waspcamo select 1)];
	_reward removeMagazine "240Rnd_CMFlare_Chaff_Magazine";
	_reward addMagazine "120Rnd_CMFlare_Chaff_Magazine";
	//====select random loadout=====
	_AMRAAMcount = selectRandom ["2","2","4"];
	
	//========outer AA bays=========
	_reward setPylonLoadOut [5, "PylonRack_Missile_BIM9X_x1",false,[]];
	_reward setPylonLoadOut [6, "PylonRack_Missile_BIM9X_x1",false,[]];
	//=====outer and middle inner bay
	if (_AMRAAMcount == "2")then {
	_reward setPylonLoadOut [7, "PylonMissile_Missile_AMRAAM_D_INT_x1",false,[]];
	_reward setPylonLoadOut [8, "PylonMissile_Missile_AMRAAM_D_INT_x1",false,[]];
	_reward setPylonLoadOut [9, "",false,[]];
	_reward setPylonLoadOut [10, "",false,[]];
	};
	if (_AMRAAMcount == "4")
	then {	for "_i" from 7 to 10 do{_reward setPylonLoadOut [_i, "PylonMissile_Missile_AMRAAM_D_INT_x1",false,[]];};};
	//=====inner pylons inner bay====
	_reward setPylonLoadOut [11, "PylonMissile_Missile_AMRAAM_D_INT_x1",false,[]];
	_reward setPylonLoadOut [12, "PylonMissile_Missile_AMRAAM_D_INT_x1",false,[]];
};

if (_reward isKindOf "I_Plane_Fighter_04_F") then {
	//an A-149 Gryphon
	_reward setObjectTextureGlobal[0, 'a3\air_f_jets\plane_fighter_04\data\Fighter_04_fuselage_01_co.paa'];
	_reward setObjectTextureGlobal[1, 'a3\air_f_jets\plane_fighter_04\data\Fighter_04_fuselage_02_co.paa'];
	_reward removeMagazine "240Rnd_CMFlare_Chaff_Magazine";
	_reward addMagazine "120Rnd_CMFlare_Chaff_Magazine";
	{_reward removeWeapon _x} forEach ["weapon_AGM_65Launcher","weapon_AMRAAMLauncher","weapon_GBU12Launcher","weapon_BIM9xLauncher"];
	//=======random loadout=========
	_wingtipAA = selectRandom ["PylonMissile_Missile_BIM9X_x1","PylonRack_Missile_AMRAAM_C_x1"];
	_middlepylon = selectRandom ["PylonRack_Missile_AMRAAM_C_x1","PylonRack_Missile_BIM9X_x1","PylonRack_Missile_AGM_02_x1"];
	if (_middlepylon =="PylonRack_Missile_AMRAAM_C_x1" ||  _middlepylon =="PylonRack_Missile_BIM9X_x1") then {
	_innerpylon = selectRandom ["PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AGM_02_x2","PylonMissile_Bomb_GBU12_x1"];
	};
	if (_middlepylon =="PylonRack_Missile_AGM_02_x1") then {
	_innerpylon = selectRandom ["PylonMissile_Bomb_GBU12_x1","PylonRack_Missile_AGM_02_x1","PylonRack_Missile_BIM9X_x2","PylonRack_Missile_AMRAAM_C_x2"];
	};
	
	//=========wingtips===========
	_reward setPylonLoadOut [1, _wingtipAA,false,[]];
	_reward setPylonLoadOut [2, _wingtipAA,false,[]];
	
	//======middle pylons=========
	_reward setPylonLoadOut [3, _middlepylon,false,[]];
	_reward setPylonLoadOut [4, _middlepylon,false,[]];
	
	//======inner pylons===========
	_reward setPylonLoadOut [5, _innerpylon,false,[]];
	_reward setPylonLoadOut [6, _innerpylon,false,[]];
};

if (_reward isKindOf "I_Plane_Fighter_03_dynamicLoadout_F") then {
	//a buzzard
	{_reward removeWeapon _x} forEach ["missiles_SCALPEL","missiles_ASRAAM","GBU12BombLauncher_Plane_Fighter_03_F","GBU12BombLauncher","weapon_GBU12Launcher"];
	//=======random loadout=========
	_maingun = "PylonWeapon_300Rnd_20mm_shells";
	_wingtipAA = selectRandom ["PylonRack_1Rnd_AAA_missiles","PylonRack_1Rnd_Missile_AA_04_F"];
	_middlepylon = selectRandom ["PylonRack_1Rnd_AAA_missiles","PylonRack_1Rnd_Missile_AA_04_F","PylonRack_1Rnd_GAA_missiles"];
	_innerpylon = "PylonRack_1Rnd_GAA_missiles";
	
	//=========wingtips===========
	_reward setPylonLoadOut [1, _wingtipAA,false,[]];
	_reward setPylonLoadOut [7, _wingtipAA,false,[]];
	
	//======middle pylons=========
	_reward setPylonLoadOut [2, _middlepylon,false,[]];
	_reward setPylonLoadOut [6, _middlepylon,false,[]];
	
	//======inner pylons===========
	_reward setPylonLoadOut [3, _innerpylon,false,[]];
	_reward setPylonLoadOut [5, _innerpylon,false,[]];
	
	//==========main gun==========
	_reward setPylonLoadOut [1, _maingun,false,[]];
};



//---------heli--------
if (_reward isKindOf "B_Heli_Light_01_armed_F") then {
	//an AH-9 Pawnee
	_reward setObjectTextureGlobal[0, 'A3\Air_F\Heli_Light_01\Data\skins\heli_light_01_ext_digital_co.paa'];
};
if (_reward isKindOf "Rabbit_F") then {
	//an AH-9 Pawnee GAU - 19
	deleteVehicle _reward;
	_GAU = createVehicle ["B_Heli_Light_01_armed_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_GAU setDir 284;
	_GAU removeMagazine ("5000Rnd_762x51_Belt");
	_GAU removeWeapon ("M134_minigun");
	_GAU addWeapon ("HMG_127_APC");
	_GAU addMagazine ("500Rnd_127x99_mag_Tracer_Red");
	_GAU setObjectTextureGlobal[0, 'A3\Air_F\Heli_Light_01\Data\skins\heli_light_01_ext_digital_co.paa'];
	{_x addCuratorEditableObjects [[_GAU], false];} foreach allCurators;
};
if (_reward isKindOf "Land_GarbageBags_F") then {
	//an AH-9 Pawnee GMG - 20MM
	deleteVehicle _reward;
	_GMG = createVehicle ["B_Heli_Light_01_armed_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_GMG setDir 284;
	_GMG removeMagazine ("5000Rnd_762x51_Belt");
	_GMG removeWeapon ("M134_minigun");
	_GMG addWeapon ("GMG_20mm");
	_GMG addMagazine ("40Rnd_20mm_G_belt");
	_GMG addMagazine ("40Rnd_20mm_G_belt");
	_GMG setObjectTextureGlobal[0, 'A3\Air_F\Heli_Light_01\Data\skins\heli_light_01_ext_digital_co.paa'];
	{_x addCuratorEditableObjects [[_GMG], false];} foreach allCurators;
};
if (_reward isKindOf "I_Heli_light_03_F") then {
	//Hellcat
	_reward setObjectTextureGlobal [0, "\a3\air_F_EPB\Heli_Light_03\Data\Heli_Light_03_base_CO.paa"]; 
};
if (_reward isKindOf "Land_NetFence_01_m_pole_F") then {
	//a LAT WY-55 Hellcat
	//created by McKillen, edited by stan
	deleteVehicle _reward;
	_Hellcat = createVehicle ["I_Heli_light_03_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_Hellcat setObjectTextureGlobal [0, "\a3\air_F_EPB\Heli_Light_03\Data\Heli_Light_03_base_CO.paa"]; 
	_Hellcat setDir 284;
	_Hellcat removeMagazinesTurret ["24Rnd_missiles",[-1]];
	_Hellcat removeWeaponTurret ["missiles_DAR",[-1]];
	_Hellcat addWeaponTurret ["rockets_Skyfire",[-1]];
	_Hellcat addMagazineTurret ["38Rnd_80mm_rockets",[-1]];
	{_x addCuratorEditableObjects [[_Hellcat], false];} foreach allCurators;
};
if (_reward isKindOf "O_T_VTOL_02_infantry_F") then {
	//an Y-32 Xi'an (Infantry Transport, unarmed)
	_reward removeMagazine "250Rnd_30mm_HE_shells_Tracer_Green";
	_reward removeMagazine "250Rnd_30mm_APDS_shells_Tracer_Green";
	_reward removeMagazine "8Rnd_LG_scalpel";
	_reward removeMagazine "38Rnd_80mm_rockets";
	_reward removeWeapon ("gatling_30mm_VTOL_02");
	_reward removeWeapon ("missiles_SCALPEL");
	_reward removeWeapon ("rockets_Skyfire");

};

if (_reward isKindOf "O_Heli_Light_02_F") then {
	//orca
	_reward setObjectTextureGlobal [0, "\a3\air_f\Heli_Light_02\Data\heli_light_02_ext_co.paa"]; 
};
//--------UAV/UGV------

if (_reward isKindOf "B_T_UAV_03_F") then {
	//a MQ-12 Falcon
	createVehicleCrew _reward;

};
if (_reward isKindOf "B_UAV_05_F") then {
	//a UCAV Sentinel
	createVehicleCrew _reward;
};
if (_reward isKindOf "Land_VR_CoverObject_01_kneelHigh_F") then {
	//a hemtt mounted Praetorian 1C
	deleteVehicle _reward;
	_truck = createVehicle ["B_Truck_01_mover_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_AAA = createVehicle ["B_AAA_System_01_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_AAA attachTo [_truck,[0,-2.5,2.1]];
	createVehicleCrew _AAA;
	{_x addCuratorEditableObjects [[_truck,_AAA], false];} foreach allCurators;
};	
if (_reward isKindOf "Land_VR_CoverObject_01_standHigh_F") then {
	//a hemtt mounted Mk49 Spartan
	deleteVehicle _reward;
	_truck = createVehicle ["B_Truck_01_mover_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_truck setDir 0;
	_AA = createVehicle ["B_SAM_System_01_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_AA attachTo [_truck,[0,-2.9,1.5]];
	_AA setDir 180;
	createVehicleCrew _AA;
	{_x addCuratorEditableObjects [[_truck,_AA], false];} foreach allCurators;
};

//--------MBTs---------

if (_reward isKindOf "Land_W_sharpStone_01") then {
	//enhanced kuma
	deleteVehicle _reward;
	_t100 = createVehicle ["O_MBT_02_cannon_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_t100 setDir 0;
	_t100 removeMagazine ("2000Rnd_762x51_Belt_Green");
	_t100 removeMagazine ("2000Rnd_762x51_Belt_Green");
	_t100 removeWeapon ("LMG_coax");
	_t100 addWeaponTurret ["HMG_127_MBT",[0]];
	for "_i" from 1 to 4 do {
		_t100 addMagazineTurret ["500Rnd_127x99_mag_Tracer_Red",[0]];
	};	
	_t100 addMagazineTurret ["12Rnd_125mm_HEAT_T_Green",[0]];
	{_x addCuratorEditableObjects [[_t100], false];} foreach allCurators;
};

if (_reward isKindOf "Land_BluntStones_erosion") then {
	//enhanced kuma
	deleteVehicle _reward;
	_kuma = createVehicle ["I_MBT_03_cannon_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_kuma setDir 0;
	_kuma removeMagazine ("2000Rnd_762x51_Belt_Yellow");
	_kuma removeMagazine ("2000Rnd_762x51_Belt_Yellow");
	_kuma removeWeapon ("LMG_coax");
	_kuma addWeaponTurret ["HMG_127_MBT",[0]];
	for "_i" from 1 to 4 do {
		_kuma addMagazineTurret ["500Rnd_127x99_mag_Tracer_Red",[0]];
	};	
	_kuma addMagazineTurret ["14Rnd_120mm_HE_shells_Tracer_Yellow",[0]];
	{_x addCuratorEditableObjects [[_kuma], false];} foreach allCurators;
};

if (_reward isKindOf "Land_W_sharpStone_02") then {
	//enhanced slammer
	deleteVehicle _reward;
	_slammer = createVehicle ["B_MBT_01_TUSK_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_slammer setDir 0;
	_slammer removeMagazine ("40Rnd_105mm_APFSDS_T_Red");
	_slammer removeMagazine ("20Rnd_105mm_HEAT_MP_T_Red");
	_slammer removeMagazine ("2000Rnd_65x39_belt");
	_slammer removeMagazine ("2000Rnd_65x39_belt");
	_slammer removeWeapon ("cannon_105mm");
	_slammer removeWeapon ("LMG_M200_body");
	_slammer addWeaponTurret ["cannon_120mm",[0]];
	_slammer addMagazineTurret ["32Rnd_120mm_APFSDS_shells_Tracer_Red",[0]];
	_slammer addMagazineTurret ["16Rnd_120mm_HE_shells_Tracer_Red",[0]];
	_slammer addMagazineTurret ["16Rnd_120mm_HE_shells_Tracer_Red",[0]];
	_slammer addWeaponTurret ["HMG_127_MBT",[0]];
	for "_i" from 1 to 4 do {
		_slammer addMagazineTurret ["500Rnd_127x99_mag_Tracer_Red",[0]];
	};	
	{_x addCuratorEditableObjects [[_slammer], false];} foreach allCurators;
};

//--------IFVs---------

if (_reward isKindOf "Land_PipeWall_concretel_8m_F") then {
	deleteVehicle _reward;
	_reward = createVehicle ["I_APC_tracked_03_cannon_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_reward setDir 0;
	_reward removeMagazine ("1000Rnd_762x51_Belt_Yellow");
	_reward removeMagazine ("1000Rnd_762x51_Belt_Yellow");
	_reward removeWeapon ("LMG_coax");
	_reward addWeaponTurret ["HMG_127_MBT",[0]];
	for "_i" from 1 to 4 do {
		_reward addMagazineTurret ["500Rnd_127x99_mag_Tracer_Red",[0]];
	};	
	_reward addMagazineTurret ["60Rnd_30mm_APFSDS_shells_Tracer_Yellow",[0],40];
	_reward addMagazineTurret ["140Rnd_30mm_MP_shells_Tracer_Yellow",[0],60];
};

if (_reward isKindOf "Land_Net_Fence_pole_F") then {
	deleteVehicle _reward;
	_reward = createVehicle ["I_APC_Wheeled_03_cannon_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_reward setDir 0;
	_reward setObjectTextureGlobal [0, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_co.paa"]; 
	_reward setObjectTextureGlobal [1, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext2_co.paa"]; 
	_reward setObjectTextureGlobal [2, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\rcws30_co.paa"]; 
	_reward setObjectTextureGlobal [3, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_alpha_co.paa"]; 
	_reward removeMagazine ("1000Rnd_65x39_Belt_Yellow");
	_reward removeWeapon ("LMG_M200");
	_reward addWeaponTurret ["HMG_127_MBT",[0]];
	for "_i" from 1 to 4 do {
		_reward addMagazineTurret ["500Rnd_127x99_mag_Tracer_Red",[0]];
	};	
	_reward addMagazineTurret ["60Rnd_30mm_APFSDS_shells_Tracer_Yellow",[0],40];
	_reward addMagazineTurret ["140Rnd_30mm_MP_shells_Tracer_Yellow",[0],60];
};

if (_reward isKindOf "Land_Pipe_fence_4m_F") then {
	deleteVehicle _reward;
	_reward = createVehicle ["B_APC_Wheeled_01_cannon_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_reward setDir 0;
	_reward removeMagazine ("2000Rnd_65x39_belt");
	_reward removeWeapon ("LMG_M200_body");
	_reward addWeaponTurret ["HMG_127_MBT",[0]];
	for "_i" from 1 to 4 do {
		_reward addMagazineTurret ["500Rnd_127x99_mag_Tracer_Red",[0]];
	};	
	_reward addMagazineTurret ["60Rnd_40mm_GPR_Tracer_Red_shells",[0]];
	_reward addMagazineTurret ["60Rnd_40mm_GPR_Tracer_Red_shells",[0]];
	_reward addMagazineTurret ["40Rnd_40mm_APFSDS_Tracer_Red_shells",[0]];
	_reward addMagazineTurret ["40Rnd_40mm_APFSDS_Tracer_Red_shells",[0]];
};

if (_reward isKindOf "I_APC_Wheeled_03_cannon_F") then {
	_reward setObjectTextureGlobal [0, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_co.paa"]; 
	_reward setObjectTextureGlobal [1, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext2_co.paa"]; 
	_reward setObjectTextureGlobal [2, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\rcws30_co.paa"]; 
	_reward setObjectTextureGlobal [3, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_alpha_co.paa"]; 
};


//--------APCs---------

if (_reward isKindOf "OfficeTable_01_new_F") then {
	//a Minigun bobcat
	deleteVehicle _reward;
	_Mini = createVehicle ["B_T_APC_Tracked_01_CRV_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_Mini removeMagazine ("2000Rnd_65x39_belt");
	_Mini removeMagazine ("2000Rnd_65x39_belt");
	_Mini removeWeapon ("LMG_RCWS");
	_Mini addWeapon ("LMG_Minigun_Transport");
	_Mini addMagazine ("500Rnd_65x39_Belt_Tracer_Green_Splash");
	_Mini addMagazine ("500Rnd_65x39_Belt_Tracer_Green_Splash");
	_Mini addMagazine ("500Rnd_65x39_Belt_Tracer_Green_Splash");
	_Mini addMagazine ("500Rnd_65x39_Belt_Tracer_Green_Splash");
	_Mini setDir 0;
	{_x addCuratorEditableObjects [[_Mini], false];} foreach allCurators;
};

//----------AA---------

//--------MRAPs--------
if (_reward isKindOf "I_MRAP_03_hmg_F") then {
	_reward setObjectTextureGlobal [0,'\A3\soft_f_beta\mrap_03\data\mrap_03_ext_co.paa']; 
	_reward setObjectTextureGlobal [1,'\A3\data_f\vehicles\turret_co.paa']; 
};
if (_reward isKindOf "I_MRAP_03_gmg_F") then {
	_reward setObjectTextureGlobal [0,'\A3\soft_f_beta\mrap_03\data\mrap_03_ext_co.paa']; 
	_reward setObjectTextureGlobal [1,'\A3\data_f\vehicles\turret_co.paa']; 
};
if (_reward isKindOf "Land_RattanTable_01_F") then {
	//a Hunter Minigun
	deleteVehicle _reward;
	_Mini = createVehicle ["B_MRAP_01_hmg_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_Mini removeMagazine ("200Rnd_127x99_mag_Tracer_Red");
	_Mini removeMagazine ("200Rnd_127x99_mag_Tracer_Red");
	_Mini removeWeapon ("HMG_127");
	_Mini addWeapon ("LMG_Minigun_Transport");
	_Mini addMagazine ("500Rnd_65x39_Belt_Tracer_Green_Splash");
	_Mini addMagazine ("500Rnd_65x39_Belt_Tracer_Green_Splash");
	_Mini addMagazine ("500Rnd_65x39_Belt_Tracer_Green_Splash");
	_Mini setDir 0;
	{_x addCuratorEditableObjects [[_Mini], false];} foreach allCurators;
};

if (_reward isKindOf "OfficeTable_01_old_F") then {
	//a strider Minigun
	deleteVehicle _reward;
	_Mini = createVehicle ["I_MRAP_03_hmg_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_Mini removeMagazine ("200Rnd_127x99_mag_Tracer_Yellow");
	_Mini removeMagazine ("200Rnd_127x99_mag_Tracer_Yellow");
	_Mini removeWeapon ("HMG_127");
	_Mini addWeapon ("LMG_Minigun_Transport");
	_Mini addMagazine ("500Rnd_65x39_Belt_Tracer_Green_Splash");
	_Mini addMagazine ("500Rnd_65x39_Belt_Tracer_Green_Splash");
	_Mini addMagazine ("500Rnd_65x39_Belt_Tracer_Green_Splash");
	_Mini setObjectTextureGlobal [0,'\A3\soft_f_beta\mrap_03\data\mrap_03_ext_co.paa']; 
	_Mini setObjectTextureGlobal [1,'\A3\data_f\vehicles\turret_co.paa']; 
	_Mini setDir 0;
	{_x addCuratorEditableObjects [[_Mini], false];} foreach allCurators;
};

if (_reward isKindOf "Land_Graffiti_02_F") then {
	//a Lynx Strider
	deleteVehicle _reward;
	_Sniper = createVehicle ["I_MRAP_03_hmg_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_Sniper removeMagazine ("200Rnd_127x99_mag_Tracer_Yellow");
	_Sniper removeMagazine ("200Rnd_127x99_mag_Tracer_Yellow");
	_Sniper removeWeapon ("HMG_127");
	_Sniper addWeapon ("srifle_GM6_camo_LRPS_F");
	_Sniper addMagazine ("5Rnd_127x108_APDS_Mag");
	_Sniper addMagazine ("5Rnd_127x108_APDS_Mag");
	_Sniper addMagazine ("5Rnd_127x108_APDS_Mag");
	_Sniper addMagazine ("5Rnd_127x108_APDS_Mag");
	_Sniper addMagazine ("5Rnd_127x108_APDS_Mag");
	_Sniper addMagazine ("5Rnd_127x108_APDS_Mag");
	_Sniper setObjectTextureGlobal [0,'\A3\soft_f_beta\mrap_03\data\mrap_03_ext_co.paa']; 
	_Sniper setObjectTextureGlobal [1,'\A3\data_f\vehicles\turret_co.paa']; 
	_Sniper setDir 0;
	{_x addCuratorEditableObjects [[_Sniper], false];} foreach allCurators;
};

	
	
//--------cars----------

if (_reward isKindOf "O_T_LSV_02_armed_F") then {
	_reward setObjectTextureGlobal[0, '\A3\soft_f_exp\LSV_02\data\CSAT_LSV_01_black_CO.paa'];
	_reward setObjectTextureGlobal[1, '\A3\soft_f_exp\LSV_02\data\CSAT_LSV_02_black_CO.paa'];
	_reward setObjectTextureGlobal[2, '\A3\soft_f_exp\LSV_02\data\CSAT_LSV_03_black_CO.paa'];
};

if (_reward isKindOf "Land_TableDesk_F") then {
	//a Minigun offroad
	deleteVehicle _reward;
	_Mini = createVehicle ["B_G_Offroad_01_armed_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	for "_i" from 1 to 4 do{_Mini removeMagazine ("100Rnd_127x99_mag_Tracer_Yellow");};
	_Mini removeWeapon ("HMG_M2");
	_Mini addWeapon ("LMG_Minigun_Transport");
	_Mini addMagazine ("500Rnd_65x39_Belt_Tracer_Green_Splash");
	_Mini addMagazine ("500Rnd_65x39_Belt_Tracer_Green_Splash");
	_Mini addMagazine ("500Rnd_65x39_Belt_Tracer_Green_Splash");
	_Mini setDir 0;
	{_x addCuratorEditableObjects [[_Mini], false];} foreach allCurators;
};

if (_reward isKindOf "Sign_Arrow_Blue_F") then {
	//an Offroad (AT)
	deleteVehicle _reward;
	_truck = createVehicle ["B_G_Offroad_01_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_truck setDir 0;
	_ATLauncher = createVehicle ["B_static_AT_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_ATLauncher attachTo [_truck,[0,-1.5,.4]];
	_ATLauncher setDir 180;
	for "_i" from 1 to 6 do {_ATLauncher addMagazine "1Rnd_GAT_missiles";};
	{_x addCuratorEditableObjects [[_truck,_ATLauncher], false];} foreach allCurators;
};
if (_reward isKindOf "Sign_Arrow_Cyan_F") then {
	//an Offroad (AA)
	deleteVehicle _reward;
	_truck = createVehicle ["B_G_Offroad_01_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_truck setDir 0;
	_AALauncher = createVehicle ["B_static_AA_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_AALauncher attachTo [_truck,[0,-1.5,.4]];
	_AALauncher setDir 180;
	for "_i" from 1 to 4 do {_AALauncher addMagazine "1Rnd_GAA_missiles";};
	{_x addCuratorEditableObjects [[_truck,_AALauncher], false];} foreach allCurators;
};
if (_reward isKindOf "Land_InfoStand_V1_F") then {
	//an Offroad (Armed GMG)
	deleteVehicle _reward;
	_truck = createVehicle ["B_G_Offroad_01_repair_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_GMG = createVehicle ["B_GMG_01_high_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_GMG attachTo [_truck,[0,-2.5,.8]];
	{_x addCuratorEditableObjects [[_truck,_GMG], false];} foreach allCurators;
};
if (_reward isKindOf "B_G_Offroad_01_repair_F") then {
	//a Mobile Mortar Truck
	_mortar = createVehicle ["B_Mortar_01_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_mortar attachTo [_reward,[0,-2.5,.3]];
	{_x addCuratorEditableObjects [[_reward,_mortar], false];} foreach allCurators;
};


//====================================================
//============== misc stuff ==========================
//====================================================

//if reward is a plane move it to the carrier
if (_reward isKindOf "Plane") then {
//get the pos to move it to
_freedompos = getPosWorld Freedom;
_posarray = [[-7.8,171.1,25.9],[-8.8,149.6,25.9],[-10,126.1,25.9],[-12.3,106.6,25.9]];
_relativepos =  _posarray select jetspawnpos;
_tosetpos = [(_freedompos select 0) + (_relativepos select 0),(_freedompos select 1) + (_relativepos select 1),(_freedompos select 2) + (_relativepos select 2)+0.5 ];
//VTOL is big, move it up some more
if (_reward isKindOf "B_T_VTOL_01_armed_F") then {_tosetpos = [_tosetpos select 0, _tosetpos select 1, (_tosetpos select 2)+4.5]};
//actually move it
_reward setPosWorld _tosetpos;
_reward setDir 133;
//make suer it dosn't spawn in the same place
jetspawnpos = jetspawnpos + 1;
publicVariable "jetspawnpos";
if (jetspawnpos > 3) then {jetspawnpos = 0;publicVariable "jetspawnpos";};
};

//Adds any reward that hasen't been altered to zeus
if !(isNil "_reward" ) then {
{_x addCuratorEditableObjects [[_reward], false];} foreach allCurators;
};

//let it spawn in first
sleep 3;

//heal baby heal
if !(isNil "_slammer" ) then { _reward setDamage 0;};
if !(isNil "_t100" ) then { _reward setDamage 0;};
if !(isNil "_kuma" ) then { _reward setDamage 0;};
if !(isNil "_mortar" ) then { _mortar setDamage 0;};
if !(isNil "_truck" ) then { _truck setDamage 0;};
if !(isNil "_Hellcat" ) then { _Hellcat setDamage 0;};
if !(isNil "_GAU" ) then { _GAU setDamage 0;};
if !(isNil "_GMG" ) then { _GMG setDamage 0;};
if !(isNil "_ucav" ) then { _ucav setDamage 0;};
if !(isNil "_Mini" ) then { _Mini setDamage 0;};
if !(isNil "_reward" ) then { _reward setDamage 0;};

