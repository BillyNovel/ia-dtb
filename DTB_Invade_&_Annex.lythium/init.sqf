/*
Author:

	BACONMOP

Description:

	Things that may run on both server and client.
	Deprecated initialization file, still using until the below is correctly partitioned between server and client.
______________________________________________________*/
missionActive = true;
enableSaving false;
//CVN_CIWS_Active = false;
//CVN_CIWS_Cooldown = false;
jetspawnpos = 0;

BaseArray = ["respawn_west"]; 

// ====================================================================================	
//R3F
// ====================================================================================	
execVM "scripts\R3F_LOG\init.sqf";
// ====================================================================================
// take force radio
//=====================================================================================
tf_no_auto_long_range_radio = 1;
enableSaving [false, false];

tf_no_auto_long_range_radio = true;
tf_radio_channel_name = "TASK FORCE RADIO - [FR] =DTB= COOP";
tf_radio_channel_password = "456";
player setVariable ["tf_receivingDistanceMultiplicator", 4];
TF_terrain_interception_coefficient = 2;

//TK message
sendTKhintC = { 
	params["_killed"];
	hintC format ["%1, vous venez teamkilled %2, ce qui est interdit. Vous devriez présenter des excuses à %2.", name player, _killed];
};

if ( isServer ) then {
	//admin channel
	adminChannelID = radioChannelCreate [[0.8, 0, 0, 1], "Admin Channel", "%UNIT_NAME", [], true];
	publicVariable "adminChannelID";
};
adminChannelID radioChannelAdd [Quartermaster];

//---------------------------------- Mission vars (for all clients)
derp_PARAM_AOSize = "AOSize" call BIS_fnc_getParamValue;
derp_PARAM_AntiAirAmount = "AntiAirAmount" call BIS_fnc_getParamValue;
derp_PARAM_MRAPAmount = "MRAPAmount" call BIS_fnc_getParamValue;
derp_PARAM_InfantryGroupsAmount = "InfantryGroupsAmount" call BIS_fnc_getParamValue;
derp_PARAM_AAGroupsAmount = "AAGroupsAmount" call BIS_fnc_getParamValue;
derp_PARAM_ATGroupsAmount = "ATGroupsAmount" call BIS_fnc_getParamValue;
derp_PARAM_RandomVehcsAmount = "RandomVehcsAmount" call BIS_fnc_getParamValue;

derp_PARAM_AIAimingAccuracy = "AIAimingAccuracy" call BIS_fnc_getParamValue;
derp_PARAM_AIAimingShake = "AIAimingShake" call BIS_fnc_getParamValue;
derp_PARAM_AIAimingSpeed = "AIAimingSpeed" call BIS_fnc_getParamValue;
derp_PARAM_AISpotingDistance = "AISpotingDistance" call BIS_fnc_getParamValue;
derp_PARAM_AISpottingSpeed = "AISpottingSpeed" call BIS_fnc_getParamValue;
derp_PARAM_AICourage = "AICourage" call BIS_fnc_getParamValue;
derp_PARAM_AIReloadSpeed = "AIReloadSpeed" call BIS_fnc_getParamValue;
derp_PARAM_AICommandingSkill = "AICommandingSkill" call BIS_fnc_getParamValue;
derp_PARAM_AIGeneralSkill = "AIGeneralSkill" call BIS_fnc_getParamValue;


["Initialize"] call BIS_fnc_dynamicGroups;
for [ {_i = 0}, {_i < count(paramsArray)}, {_i = _i + 1} ] do {
	call compile format
	[
		"PARAMS_%1 = %2",
		(configName ((missionConfigFile >> "Params") select _i)),
		(paramsArray select _i)
	];
};

/*//====zeus stuff====
if ( isServer ) then{	
    addMissionEventHandler ["HandleDisconnect", 
		{
			params ["_unit"];
			if !( isNil {_unit getVariable 'zeusModule'} ) then{	
				_zeus = _unit getVariable 'zeusModule';
				unassignCurator (zeusModules select _zeus);
			};
			false
		}
	];
};*/
// ====================================================================================	
//ASR_AI3
// ====================================================================================	

asr_ai3_main_enabled = 1; // All the other settings matter only if we have 1 here; set 0 to disable all scripted features
asr_ai3_main_radiorange = 200; // Maximum range for AI radios (warning: increasing this impacts game performance); AI groups share known enemy locations over radio (set to 0 to disable)
asr_ai3_main_seekcover = 1; // Set to 1 if AI should move to near cover in combat when they're exposed in the open, 0 to disable.
asr_ai3_main_usebuildings = 0.9; // Chance the AI group members may enter nearby building positions (0 to 1 values, 0 will disable the feature)
asr_ai3_main_getinweapons = 0.1; // Chance the AI group will mount nearby static and vehicle weapons in combat (0 to 1 values, 0 will disable the feature)
asr_ai3_main_packNVG = 0; // Automatically un-equip NVG during the day (store them in the vest/backpack) and re-equip when it gets dark
asr_ai3_main_disableAIPGfatigue = 1; // Disables fatigue for AI units in player's group so they are able to keep up (0 - disabled, 1 - enabled)
asr_ai3_main_onteamswitch = 1; // Teamswitch handler: makes unit switched into the group leader; prevents AI left in place from sending stupid orders (0 - disabled, 1 - enabled)
asr_ai3_main_debug = 0; // Log extra debugging info to RPT, create debug markers and hints (1-enabled, 0-disabled)

asr_ai3_main_setskills = 1; // Override AI skills based on their unit type (faction, training etc.; 0 - disabled, 1 - enabled)
asr_ai3_main_joinlast = 2; // Groups left with only this number of units will merge with nearest group of the same faction (set to 0 to disable)
asr_ai3_main_removegimps = 300; // Units unable to walk for this time will separate from their group to prevent slowing it down (time in seconds, set 0 to disable)
asr_ai3_main_rearm = 40; // Enable basic AI rearming (resupply radius in meters; set to 0 to disable feature)
asr_ai3_main_gunshothearing = 0.8; // Gunshot hearing range coefficient (applied to shooter's weapon sound range; 0 will disable the feature)

asr_ai3_main_sets = [ // for each level: skilltype, [<min value>, <random value added to min>]
[ "general",[1.00,0.0], "aiming",[1.00,0.00], "spotting",[1.00,0.0] ], // 0: super-AI (only used for testing)
[ "general",[1.00,0.0], "aiming",[0.30,0.25], "spotting",[0.40,0.1] ], // 1: sf 1
[ "general",[1.00,0.0], "aiming",[0.30,0.25], "spotting",[0.45,0.1] ], // 2: sf 2 (recon units, divers and spotters)
[ "general",[1.00,0.0], "aiming",[0.20,0.15], "spotting",[0.40,0.1] ], // 3: regular 1 (regular army leaders, marksmen)
[ "general",[1.00,0.0], "aiming",[0.20,0.15], "spotting",[0.40,0.1] ], // 4: regular 2 (regulars)
[ "general",[1.00,0.0], "aiming",[0.20,0.15], "spotting",[0.40,0.1] ], // 5: militia or trained insurgents, former regulars (insurgent leaders, marksmen)
[ "general",[1.00,0.0], "aiming",[0.20,0.15], "spotting",[0.45,0.1] ], // 6: some military training (insurgents)
[ "general",[1.00,0.0], "aiming",[0.20,0.15], "spotting",[0.40,0.1] ], // 7: no military training
[ "general",[1.00,0.0], "aiming",[0.15,0.15], "spotting",[0.45,0.1] ], // 8: pilot 1 (regular)
[ "general",[1.00,0.0], "aiming",[0.15,0.15], "spotting",[0.40,0.1] ], // 9: pilot 2 (insurgent)
[ "general",[1.00,0.0], "aiming",[0.50,0.30], "spotting",[0.90,0.1] ] // 10: sniper
];

ace_nightvision_fogScaling = 0;
ace_nightvision_effectScaling = 0.2;
ace_nightvision_aimDownSightsBlur = 0,2;

asr_ai3_main_levels_units = [
[], // 0: super-AI (only used for testing)
[], // 1: sf 1
[], // 2: sf 2 (recon units, divers and spotters)
[], // 3: regular 1 (regular army leaders, marksmen)
[], // 4: regular 2 (regulars)
[], // 5: militia or trained insurgents, former regulars (insurgent leaders, marksmen)
[], // 6: civilians with some military training (insurgents)
[], // 7: civilians without military training
[], // 8: pilot 1 (regular)
[], // 9: pilot 2 (insurgent)
[] // 10: sniper
];