/*
Author: 
	BACONMOP
 
 Description:
	For new Spawned bases

 Last edited: 
	29/08/2017 by stanhope
 
 Edited:
	Service stations at FOBs + markers

 */

private ["_base","_baseRespawnMarker","_respawnMarkerPos","_respawnMarker","_basevisMarker","_arsenal","_arsenalBox","_targetStartText","_baseVehicles","_text","_vehType"];
 
_base = _this select 0;


// Respawn Position -------------------------------

_baseRespawnMarker = (missionconfigfile >> "Main_Aos" >> "AOs" >> _base >> "respawnPos") call BIS_fnc_getCfgData;
_respawnMarkerPos = getMarkerPos _baseRespawnMarker;
_respawnMarker = [west, _respawnMarkerPos] call BIS_fnc_addRespawnPosition;
_basevisMarker = (missionconfigfile >> "Main_Aos" >> "AOs" >> _base >> "visMrkr") call BIS_fnc_getCfgData;
{_x setMarkerPos (getMarkerPos _baseRespawnMarker);} forEach [_basevisMarker];
[]spawn {sleep 1;};

_arsenal = "B_CargoNet_01_ammo_F" createVehicle (getMarkerPos _baseRespawnMarker);
clearItemCargoGlobal _arsenal;
clearWeaponCargoGlobal _arsenal;
clearBackpackCargoGlobal _arsenal;
_arsenal enableRopeAttach false;
_arsenal setMass 5000;
_arsenalBox = [];
_arsenalBox pushBack _arsenal;
[_arsenalBox, ("ArsenalFilter" call BIS_fnc_getParamValue)] call derp_fnc_VA_filter;
[]spawn {sleep 1;};

[_arsenalBox, ("ArsenalFilter" call BIS_fnc_getParamValue)] remoteExec ["derp_fnc_VA_filter",-2,true];
[_arsenal, ["<t color='#009ACD'>Teleport To Main Base</t>","cutText ['','BLACK OUT'];sleep 2;[player,'BASE'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",0,false,true,"","('BASE' in controlledZones)"]] remoteExec ["addAction", -2, true];
[_arsenal, ["View Distance Settings", CHVD_fnc_openDialog, [], -99, false, true]] remoteExec ["addAction", -2, true];
[_arsenal, ["<t color='#006bb3'>Save gear</t>",{player setVariable ["derp_savedGear", (getUnitLoadout player)]; systemChat "gear saved";}]] remoteExec ["addAction", -2, true];

// Notification ----------------------------------------

_targetStartText = format["<t align='center' size='2.2'>Base Taken</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>Good Job. We have now setup a base at that location.<br/><br/>We have provided you with some vehicles at that the new FOB.", _basevisMarker];
[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];

// Vehicles ---------------------------------------

_baseVehicles = (missionconfigfile >> "Main_Aos" >> "AOs" >> _base >> "vehicles") call BIS_fnc_getCfgData;
{
	_veh = _x select 0;
	_mkr = _x select 1;
	_timer = _x select 2;
	
	switch (_veh) do {
		case "Random_Cas_Jet":{
			_vehType = selectRandom ["B_Plane_CAS_01_dynamicLoadout_F","B_Plane_CAS_01_dynamicLoadout_F","B_Plane_CAS_01_dynamicLoadout_F","B_Plane_Fighter_01_F"];
		};
		case "Random_AA_Jet":{
			_vehType = selectRandom ["I_Plane_Fighter_04_F","I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_AA_F"];
		};
		case "Random_Cas_Heli":{
			_vehType = selectRandom ["B_Heli_Attack_01_F","B_Heli_Attack_01_F","B_Heli_Attack_01_F","O_Heli_Attack_02_black_F","O_Heli_Attack_02_black_F"];
		};
		default {
			_vehType = _veh;
		};
	};
	_vehicle = _vehType createVehicle getMarkerPos _mkr;
	_vehicle setDir (MarkerDir _mkr);
	{_x addCuratorEditableObjects [[_vehicle], false];} foreach adminCurators;
	0 = [_vehicle,_timer,FALSE,AW_fnc_vSetup02,_base] spawn AW_fnc_vBaseMonitor;
		
	
}forEach _baseVehicles;


_fobStuff = (getMarkerPos _baseRespawnMarker) nearObjects 500;
{	
	if ( isObjectHidden _x ) then{
		_x hideObjectGlobal false;
	};
} forEach _fobStuff;

//FOB specific stuff
switch (_base) do {
	case "Terminal":{
	
	//service triggers
	
	TerminalServiceGroundTrigger setPos (getPos GuardianGroundServicePad);
	TerminalServiceAirTrigger setPos (getPos GuardianAirServicePad);
	
	/*_TerminalServiceGroundTrigger = createTrigger ["EmptyDetector", (getPos GuardianGroundServicePad) , true];
	_TerminalServiceGroundTrigger setTriggerActivation [ "WEST" , "PRESENT", true];
	_TerminalServiceGroundTrigger setTriggerArea [6, 6, 0, false, 3];
	_TerminalServiceGroundTrigger setTriggerStatements ["this", "_handle = [(thisList select 0)] execVM 'scripts\vehicle\rearmGround.sqf';", ""];
	
	_TerminalServiceAirTrigger = createTrigger ["EmptyDetector", (getPos GuardianAirServicePad) , true];
	_TerminalServiceAirTrigger setTriggerActivation [ "WEST" , "PRESENT", true];
	_TerminalServiceAirTrigger setTriggerArea [6, 6, 0, false, 3];
	_TerminalServiceAirTrigger setTriggerStatements ["this", "_handle = [(thisList select 0)] execVM 'scripts\vehicle\rearmcarrier.sqf';", ""];
	*/
	//service pad markers
	_GuardianGroundServiceMarker = createMarker ["GuardianGroundService",(getPos GuardianGroundServicePad)];
	"GuardianGroundService" setMarkerShape "ICON";
	"GuardianGroundService" setMarkerType "b_maint";
	"GuardianGroundService" setMarkerText "Ground service";
	"GuardianGroundService" setMarkerSize [0.5, 0.5];
	
	_GuardianAirServiceMarker = createMarker ["GuardianAirService",(getPos GuardianAirServicePad)];
	"GuardianAirService" setMarkerShape "ICON";
	"GuardianAirService" setMarkerType "o_maint";
	"GuardianAirService" setMarkerColor "colorBLUFOR";
	"GuardianAirService" setMarkerText "Air service";
	"GuardianAirService" setMarkerSize [0.5, 0.5];
	
	//arsenal box actions
	[_arsenal, ["<t color='#009ACD'>Teleport To FOB Martian</t>","cutText ['','BLACK OUT'];sleep 2;[player,'AAC_Airfield'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",0,false,true,"","('AAC_Airfield' in controlledZones)"]] remoteExec ["addAction", -2, true];
	[_arsenal, ["<t color='#009ACD'>Teleport To FOB Marathon</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Stadium'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",0,false,true,"","('Stadium' in controlledZones)"]] remoteExec ["addAction", -2, true];
	[_arsenal, ["<t color='#009ACD'>Teleport To FOB Dirt Track</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Selakano_Town'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",0,false,true,"","('Selakano_Town' in controlledZones)"]] remoteExec ["addAction", -2, true];
	[_arsenal, ["<t color='#009ACD'>Teleport To FOB Last Stand</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Molos_Airfield'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",0,false,true,"","('Molos_Airfield' in controlledZones)"]] remoteExec ["addAction", -2, true];
	};
	
	case "AAC_Airfield":{
	
	AACServiceTrigger setPos (getPos MartianGroundServicePad);
	
	_MartianGroundServiceMarker = createMarker ["MartianGroundService",(getPos MartianGroundServicePad)];
	"MartianGroundService" setMarkerShape "ICON";
	"MartianGroundService" setMarkerType "b_maint";
	"MartianGroundService" setMarkerText "Ground service";
	"MartianGroundService" setMarkerSize [0.5, 0.5];
	
	[_arsenal, ["<t color='#009ACD'>Teleport To FOB Marathon</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Stadium'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",0,false,true,"","('Stadium' in controlledZones)"]] remoteExec ["addAction", -2, true];
	[_arsenal, ["<t color='#009ACD'>Teleport To FOB Dirt Track</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Selakano_Town'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",0,false,true,"","('Selakano_Town' in controlledZones)"]] remoteExec ["addAction", -2, true];
	[_arsenal, ["<t color='#009ACD'>Teleport To FOB Last Stand</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Molos_Airfield'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",0,false,true,"","('Molos_Airfield' in controlledZones)"]] remoteExec ["addAction", -2, true];
	[_arsenal, ["<t color='#009ACD'>Teleport To FOB Guardian</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Terminal'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",0,false,true,"","('Terminal' in controlledZones)"]] remoteExec ["addAction", -2, true];
	};
	
	case "Stadium":{
	
	StadiumServiceTrigger setPos (getPos MarathonGroundServicePad);
	
	_MarathonGroundServiceMarker = createMarker ["MarathonGroundService",(getPos MarathonGroundServicePad)];
	"MarathonGroundService" setMarkerShape "ICON";
	"MarathonGroundService" setMarkerType "b_maint";
	"MarathonGroundService" setMarkerText "Ground service";
	"MarathonGroundService" setMarkerSize [0.5, 0.5];
	
	[_arsenal, ["<t color='#009ACD'>Teleport To FOB Martian</t>","cutText ['','BLACK OUT'];sleep 2;[player,'AAC_Airfield'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",0,false,true,"","('AAC_Airfield' in controlledZones)"]] remoteExec ["addAction", -2, true];
	[_arsenal, ["<t color='#009ACD'>Teleport To FOB Dirt Track</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Selakano_Town'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",0,false,true,"","('Selakano_Town' in controlledZones)"]] remoteExec ["addAction", -2, true];
	[_arsenal, ["<t color='#009ACD'>Teleport To FOB Last Stand</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Molos_Airfield'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",0,false,true,"","('Molos_Airfield' in controlledZones)"]] remoteExec ["addAction", -2, true];
	[_arsenal, ["<t color='#009ACD'>Teleport To FOB Guardian</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Terminal'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",0,false,true,"","('Terminal' in controlledZones)"]] remoteExec ["addAction", -2, true];
	};
	
	case "Molos_Airfield":{
	
	MolosServiceGroundTrigger setPos (getPos LastStandGroundServicePad);
	MolosServiceAirTrigger setPos (getPos LastStandAirServicePad);
	
	_LastStandGroundServiceMarker = createMarker ["LastStandGroundService",(getPos LastStandGroundServicePad)];
	"LastStandGroundService" setMarkerShape "ICON";
	"LastStandGroundService" setMarkerType "b_maint";
	"LastStandGroundService" setMarkerText "Ground service";
	"LastStandGroundService" setMarkerSize [0.5, 0.5];
	
	_LastStandAirServiceMarker = createMarker ["LastStandAirService",(getPos LastStandAirServicePad)];
	"LastStandAirService" setMarkerShape "ICON";
	"LastStandAirService" setMarkerType "o_maint";
	"LastStandAirService" setMarkerColor "colorBLUFOR";
	"LastStandAirService" setMarkerText "Air service";
	"LastStandAirService" setMarkerSize [0.5, 0.5];
	
	[_arsenal, ["<t color='#009ACD'>Teleport To FOB Martian</t>","cutText ['','BLACK OUT'];sleep 2;[player,'AAC_Airfield'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",0,false,true,"","('AAC_Airfield' in controlledZones)"]] remoteExec ["addAction", -2, true];
	[_arsenal, ["<t color='#009ACD'>Teleport To FOB Marathon</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Stadium'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",0,false,true,"","('Stadium' in controlledZones)"]] remoteExec ["addAction", -2, true];
	[_arsenal, ["<t color='#009ACD'>Teleport To FOB Dirt Track</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Selakano_Town'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",0,false,true,"","('Selakano_Town' in controlledZones)"]] remoteExec ["addAction", -2, true];
	[_arsenal, ["<t color='#009ACD'>Teleport To FOB Guardian</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Terminal'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",0,false,true,"","('Terminal' in controlledZones)"]] remoteExec ["addAction", -2, true];
	};
	
	default { 
	_text = format ["ERROR with fn_BaseManager.sqf, %1 was not recognized as an FOB"];
	diag_log _text;
	};

};

/*
Removed until Defend AOs is finished.
// Base Lost --------------------------------------

waitUntil {sleep 5;!(_base in controlledZones)};

_targetStartText = format
	[
		"<t align='center' size='2.2'>Base Lost</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>The enemy have taken the base.<br/><br/>We cannot use that location anymore until we take it back."
	];
[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];

deleteVehicle _arsenal;
_respawnMarker call BIS_fnc_removeRespawnPosition;
*/