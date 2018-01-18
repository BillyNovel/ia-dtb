/*
 Author: BACONMOP
 Description: Main selector for the main AO's

Last edited: 12/08/2017 by stanhope

edited: something to prevent tasks spawning completed
 
 */
jetCounter = 0;
currentAO = "BASE";
controlledZones pushBack currentAO;
publicVariable "controlledZones";
publicVariable "manualAO";
manualAO="";

missionActive = true;

while {missionActive} do {

	// Select Location --------------------------------------

	currentAO = [currentAO] call AW_fnc_getAo;
    
    //reset manualAO
    manualAO=""; 
	
	//Spawn Enemies -----------------------------------------

	_pos = getMarkerPos currentAO;
	_mainAOUnits = [_pos, [true, true, true, true, true, true, true, true]] call derp_fnc_mainAOSpawnHandler;


	_type = (missionconfigfile >> "Main_Aos" >> "AOs" >> currentAO >> "Type") call BIS_fnc_getCfgData;
	switch(_type) do{

		case "Town":{
		};

		case "Hill":{
		};

		case "Coastline":{
		};

		case "Outpost":{
		};

		case "Field":{
		};

		case "base":{
		};
	};

	//Spawn Markers and Notifications -----------------------

	{_x setMarkerPos (getMarkerPos currentAO);} forEach ["aoCircle","aoMarker"];
	_name = (missionconfigfile >> "Main_Aos" >> "AOs" >> currentAO >> "name") call BIS_fnc_getCfgData;
	{_x setMarkerText _name;} forEach ["aoMarker"];
	_targetStartText = format
	[
		"<t align='center' size='2.2'>Nouvelle cible</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>Bon travail sur cette dernier OP. Je veux voir encore la même chose. Nous avons un nouvel objectif pour vous. Le haut commandement a décidé que %1 cela avait une valeur stratégique.<br/><br/>Ne pas oublier les cibles secondaires.",
		_name
	];
	[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
    _mainAoTaskName = format
        [
	       "Take %1",
	        _name
        ];
    _mainAoTaskDesc = format
        [
           "Effacer %1 des forces hostiles.",
            _name
        ];
    [west,["MainAoTask"],[_mainAoTaskDesc,_mainAoTaskName,currentAO],(getMarkerPos currentAO),"Created",0,true,"attack",true] call BIS_fnc_taskCreate;

	sleep 10;

	//Spawn Sub-Obj -----------------------------------------

	subObjComplete = 0;
	subObjScript = [] execVM "Missions\Main\SubObj.sqf";

	//Checks for Ao still Active ----------------------------
	switch(mainSide) do{
		case "east":{
			mainMissionTreshold = createTrigger ["EmptyDetector", getMarkerPos currentAO];
			mainMissionTreshold setTriggerArea [800, 800, 0, false];
			mainMissionTreshold setTriggerActivation ["EAST", "PRESENT", false];
			mainMissionTreshold setTriggerStatements ["this","",""];
		};
		case "resistance":{
			mainMissionTreshold = createTrigger ["EmptyDetector", getMarkerPos currentAO];
			mainMissionTreshold setTriggerArea [800, 800, 0, false];
			mainMissionTreshold setTriggerActivation ["GUER", "PRESENT", false];
			mainMissionTreshold setTriggerStatements ["this","",""];
		};
	};
	


	waitUntil {sleep 5;subObjComplete == 1 || !missionActive;};

	// Helicopter reinforcements when side is completed.
	_heliReinf = [currentAO, "airCavSpawnMarker", secondaryMainFaction] call AW_fnc_airCav;


	waitUntil {sleep 5;(count list mainMissionTreshold < PARAMS_EnemyLeftThreshhold) || !missionActive;};

	//Delete and Cleanup ------------------------------------

	controlledZones = controlledZones + [currentAO];
	publicVariable "controlledZones";
	deleteVehicle mainMissionTreshold;

	{
		if (!(isNull _x) && {alive _x}) then {
			deleteVehicle _x;
		};
	} foreach _mainAOUnits;
	{
		if (!(isNull _x) && {!alive _x}) then {
			deleteVehicle _x;
		};
	} foreach _mainAOUnits;
	{
		deleteVehicle _x;
	} foreach _heliReinf;

	/*
	if (reinforcementsSpawned == 1) then {
	};
	*/

	_type = (missionconfigfile >> "Main_Aos" >> "AOs" >> currentAO >> "type") call BIS_fnc_getCfgData;
	if (_type == "base") then {
		[] spawn {
			[currentAO] call AW_fnc_BaseManager;
		};
	};

	_targetStartText = format
	[
		"<t align='center' size='2.2'>Secured</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>Bon travail là-bas. Nous vous avons fourni quelques ressources légères pour vous aider à vous redéployer à la prochaine mission.",
		_name
	];
    ["MainAoTask", "Succeeded",true] call BIS_fnc_taskSetState;
    sleep 5;
    ["MainAoTask",west] call bis_fnc_deleteTask;
	[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];

	{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["aoCircle","aoMarker"];
	reinforcementsSpawned = 0;
	sleep 10;
	
	//End Game ------------------------------------
	
	//117 Main AO's.
	_endMissionCheck = count controlledZones;
	if (_endMissionCheck >= 100) then {
		"End1" call BIS_fnc_endMission;
	};

};
