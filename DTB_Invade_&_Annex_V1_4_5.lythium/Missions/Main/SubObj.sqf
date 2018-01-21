/*
 Author: BACONMOP
 Description: Creates and handles Sub Objectives
 
 Last edited: 30/08/2017 by stanhope	
 
 edited: Tweaked HQ mission a bit
 
 */
reinforcementsSpawned = 0;
subObjComplete = 0;
_subObjMission = [
	"AmmoCache",
	"RadioTower",
	"HQ"
	//"Reinforcements"
];
_subObj = _subObjMission call BIS_fnc_selectRandom;

switch(_subObj) do{

	case "AmmoCache":{
		_aoLoaction = getMarkerPos currentAO;
		_cacheBuildingArray1 = nearestObjects [_aoLoaction, ["house"], 750];
		_cacheBuildingArray2 = nearestObjects [_aoLoaction, ["building"], 750];
		_cacheBuildingArray = _cacheBuildingArray1 + _cacheBuildingArray2;
		_cacheBuildingArrayAmount = count _cacheBuildingArray;
		if (_cacheBuildingArrayAmount > 0) then {
			_cacheBuilding = _cacheBuildingArray call BIS_fnc_selectRandom;
			_cacheBuildingLocationFinal = _cacheBuilding buildingPos (1 + (random 4));
			if !(_cacheBuildingLocationFinal isEqualTo [0,0,0]) then {
				ammoCrate = "O_supplyCrate_F" createVehicle _aoLoaction;
				ammoCrate allowdamage false;
				ammoCrate setPos _cacheBuildingLocationFinal;
				ammoCrate allowdamage true;
			} else {
				_accepted = false;
				while {!_accepted} do {
					_cacheBuilding = _cacheBuildingArray call BIS_fnc_selectRandom;
					_cacheBuildingLocationFinal = _cacheBuilding buildingPos (1 + (random 4));
					if !(_cacheBuildingLocationFinal isEqualTo [0,0,0]) then {
						ammoCrate = "O_supplyCrate_F" createVehicle _aoLoaction;
						ammoCrate allowdamage false;
						ammoCrate setPos _cacheBuildingLocationFinal;
						ammoCrate allowdamage true;
						_accepted = true;
					};
				};
			};
			sleep 1;
			_dt = createTrigger ["EmptyDetector", _cacheBuildingLocationFinal];
			_dt setTriggerArea [225, 225, 0, false];
			_fuzzyMarkerPos = [[[_dt, 225],[]],[]] call BIS_fnc_randomPos;
			deleteVehicle _dt;
			{ _x setMarkerPos _fuzzyMarkerPos; } forEach ["radioMarker","radioCircle"];
			{_x setMarkerText "Sub-Objective: Cache"} forEach ["radioMarker"];
			if ((getMarkerPos "radioMarker") isEqualTo [0,0,0]) exitWith {execVM "Missions\Main\SubObj.sqf";};
			_defenders = [_cacheBuilding] call AW_fnc_buildingDefenders;
			_targetStartText = format
			[
				"<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Supply Cache</t><br/>____________________<br/>Nous avons reçu des informations de combattants de la résistance locale selon lesquelles OPFOR a camouflé une cache d'armes dans la région. Prenez-la et attendez-vous à se quel soit surveillé.<br/><br/>"
			];
			[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
            [west,["SubAoTask"],["Nous avons reçu des informations de combattants de la résistance locale selon lesquelles OPFOR a camouflé une cache d'armes dans la région. Prenez-la et attendez-vous à se quel soit surveillé.","Ammo Cache","radioCircle"],(getMarkerPos "radioCircle"),"Created",0,true,"destroy",true] call BIS_fnc_taskCreate;
			
			ammoCrate addEventHandler ["Killed",{
				params ["_unit","","_killer"];
				_name = name _killer;
				if (_name == "Error: No vehicle") then{
				_name = "Someone";
				};
				_targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Cache détruit</t><br/>____________________<br/>%2 destruction de la cache dans %1, bon travail tout le monde!",currentAO,_name];
				[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
			}];
			waitUntil {sleep 5;!alive ammoCrate || !missionActive;};
			sleep 10;
            ["SubAoTask", "Succeeded",true] call BIS_fnc_taskSetState;
            sleep 5;
            ["SubAoTask",west] call bis_fnc_deleteTask;
			{ [_x] spawn AW_fnc_SMdelete } forEach [_defenders];
			deleteVehicle ammoCrate;
		};
	};

	case "RadioTower":{
		_dt = createTrigger ["EmptyDetector", getMarkerPos currentAO];
		_dt setTriggerArea [800, 800, 0, false];
		_dt setTriggerActivation ["EAST", "PRESENT", false];
		_dt setTriggerStatements ["this","",""];
		_position = [[[getMarkerPos currentAO, PARAMS_AOSize],_dt],["water","out"]] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty[3, 1, 0.3, 30, 0, false];

		while {(count _flatPos) < 1} do {
			_position = [[[getMarkerPos currentAO, PARAMS_AOSize],_dt],["water","out"]] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty[3, 1, 0.3, 30, 0, false];
		};

		_roughPos =
		[
			((_flatPos select 0) - 200) + (random 400),
			((_flatPos select 1) - 200) + (random 400),
			0
		];

		radioTower = "Land_TTowerBig_2_F" createVehicle _flatPos;
		radioTower addEventHandler ["Killed",{
			params ["_unit","","_killer"];
			_name = name _killer;
			if (_name == "Error: No vehicle") then{
			_name = "someone";
			};
			_targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Complete</t><br/>____________________<br/>Bon travail avec cette tour de radio, %2 détruit. OPFOR devrait avoir plus de mal à organiser ses efforts aériens en %1.",currentAO,_name];
			[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
		}];
		waitUntil { sleep 0.5; alive radioTower || !missionActive;};
		radioTower setVectorUp [0,0,1];
		radioTowerAlive = true;
		deleteVehicle _dt;
		{ _x setMarkerPos _position; } forEach ["radioMarker","radioCircle"];
		{_x setMarkerText "Sub-Objective: Radio Tower"} forEach ["radioMarker"];
		_targetStartText = format
			[
				"<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Radio Tower</t><br/>____________________<br/>OPFOR a installé une tour de communication radio dans l'AO. Prenez rapidement ou bien ils vont l'utiliser pour appeler des frappes aériennes.<br/><br/>"
			];
		[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
        [west,["SubAoTask"],["OPFOR a installé une tour de communication radio dans l'AO. Prenez rapidement ou bien ils vont l'utiliser pour appeler des frappes aériennes.","Radio Tower","radioCircle"],(getMarkerPos "radioCircle"),"Created",0,true,"destroy",true] call BIS_fnc_taskCreate;
		[] spawn {
			sleep (30 + (random 180));
			if (alive radioTower) then {
				while {(alive radioTower)} do {
					if (jetCounter < 3) then {
					[] call AW_fnc_airfieldJet;
					sleep (720 + (random 480));
					};
				};
			};
		};
		waitUntil {sleep 3; !alive radioTower};
        ["SubAoTask", "Succeeded",true] call BIS_fnc_taskSetState;
        sleep 5;
        ["SubAoTask",west] call bis_fnc_deleteTask;
		sleep 30;
		deleteVehicle nearestObject[_flatPos, "Land_TTowerBig_2_ruins_F"];
	};
	case "HQ":{
		_dt = createTrigger ["EmptyDetector", getMarkerPos currentAO];
		_dt setTriggerArea [800, 800, 0, false];
		_dt setTriggerActivation ["EAST", "PRESENT", false];
		_dt setTriggerStatements ["this","",""];
		_position = [[[getMarkerPos currentAO, PARAMS_AOSize],_dt],["water","out"]] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Cargo_HQ_V1_F",0,false];
					
		while {(count _flatPos) < 1} do {
			_position = [[[getMarkerPos currentAO, PARAMS_AOSize],_dt],["water","out"]] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty[10,1,0.2,sizeOf "Land_Cargo_HQ_V1_F",0,false];
		};

		_roughPos =[((_flatPos select 0) - 200) + (random 400),((_flatPos select 1) - 200) + (random 400),0];
		
		//adds in a HQ building and adds an event handler to the officer inside it
		HQBuilding = "Land_Cargo_HQ_V1_F" createVehicle _flatPos;
		_HQpos = HQBuilding buildingPos -1;
		_garrisongroup = createGroup east;
		_garrisongroup setGroupIdGlobal [format ['AO-subobjgroup']];
		_officerPos = _HQpos select 0;
		_HQpos = _HQpos - [_officerPos];
		
		private _unitsarray = [];
		
		officerTarget = _garrisongroup createUnit ["rhs_vdv_officer", _officerPos, [], 0, "CAN_COLLIDE"];
		_unitsarray = _unitsarray + [officerTarget];
		{_x addCuratorEditableObjects [[officerTarget], false];} foreach allCurators; 
		officerTarget disableAI "PATH";
		removeAllWeapons officerTarget;
		
		officerTarget addEventHandler ["Killed",
			{
				params ["_unit","","_killer"];
				_name = name _killer;
				if (_name == "Error: No vehicle") then{
				_name = "someone";
				};
				
				_targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Complete</t><br/>____________________<br/>Bon travail tout le monde, %2 a été neutralisé. OPFOR devrait trouver plus difficile de coordonner leurs attaques dans %1.",currentAO,_name];
				[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
			}
		];
		
		waitUntil { sleep 0.5; alive officerTarget || !missionActive;};
		officerTarget setVectorUp [0,0,1];
		deleteVehicle _dt;
		
		{ _x setMarkerPos _roughPos; } forEach ["radioMarker","radioCircle"];
		{_x setMarkerText "Sub-Objective: HQ Building"} forEach ["radioMarker"];
		_targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>HQ Building</t><br/>____________________<br/>L'OPFOR a installé un bâtiment dans l'AO. A l'intérieur il y a un officier, le neutraliser en utilisant toute la force nécessaire<br/><br/>"];
		[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
		
        [west,["SubAoTask"],["L'OPFOR a installé un bâtiment dans l'AO. A l'intérieur il y a un officier, le neutraliser en utilisant toute la force nécessaire","HQ Building","radioCircle"],(getMarkerPos "radioCircle"),"Created",0,true,"destroy",true] call BIS_fnc_taskCreate;
		
		_infunits = ["rhs_vdv_des_at", "rhs_vdv_des_machinegunner", "rhs_vdv_des_efreitor", "rhs_vdv_des_arifleman", "rhs_vdv_des_grenadier", "rhs_vdv_des_rifleman", "rhs_vdv_des_rifleman", "rhs_vdv_des_rifleman"];
				
		_Garrisonpos = count _HQpos;
		for "_i" from 1 to _Garrisonpos do {
		_unitpos = selectRandom _HQpos ;
		_HQpos = _HQpos - [_unitpos];
		_unittype = selectRandom _infunits;
		_unit = _garrisongroup createUnit [_unittype, _unitpos, [], 0, "CAN_COLLIDE"];
		_unit disableAI "PATH";
		_unitsarray = _unitsarray + [_unit];
		{_x addCuratorEditableObjects [units _garrisongroup, false];} foreach allCurators;
		sleep 0.1;
		};
		
		waitUntil {sleep 3; !alive officerTarget};
        ["SubAoTask", "Succeeded",true] call BIS_fnc_taskSetState;
        sleep 5;
        ["SubAoTask",west] call bis_fnc_deleteTask;
		sleep 15;
		{deleteVehicle _x}forEach _unitsarray;
		if (isNil "HQBuilding") then {
			deleteVehicle (nearestObject [_roughPos, "Land_Cargo_HQ_V1_ruins_F"]);	
		} else {
			deleteVehicle HQBuilding;		
		};	
		
	};
	


	case "Reinforcements":{
		reinfAO = [currentAO] call AW_fnc_getAo;
		_controlled = true;
		if (reinfAO in controlledZones) then {
			while {_controlled} do{
				reinfAO = [currentAO] call AW_fnc_getAo;
				if !(reinfAO in controlledZones) then {
					_controlled = false;
				};
			};
		};
		_mkrPos = getMarkerPos reinfAO;
		{_x setMarkerPos _mkrPos; } forEach ["radioMarker","radioCircle"];
		{_x setMarkerText "Sub-Objective: Enemy Reinforcements"} forEach ["radioMarker"];
		_targetStartText = format
		[
			"<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Enemy Reinforcements</t><br/>____________________<br/>Heads up. We have just received intel that OPFOR are amassing to reinforce the current objective. We estimate that you have about 5 minutes before they begin to move.<br/><br/>"
		];
		[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
		["NewSub", "Reinforcements"] remoteExec ["AW_fnc_globalNotification",0,false];
		_delay = 120 + random 300;
		sleep _delay;
		reinforcementsSpawned = 1;
	};
	
};
{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["radioMarker","radioCircle"];
subObjComplete = 1;
