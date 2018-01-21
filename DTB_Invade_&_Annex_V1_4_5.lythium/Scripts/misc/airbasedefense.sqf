/*
@filename: airbaseDefense.sqf
Author: 

	Quiksilver

Last modified: 

	26/06/2017 by McKillen

Description:

	Spawns a friendly AA vehicle to protect the airbase from OPFOR air assets, for a short time.
	Activated via a laptop addAction.
	
	Benefits of doing it this way = dont need an AI vehicle sitting there at all times eating server resources, 
	and hands over interactive control to players from server.

__________________________________________________________________________*/

private ["_loopTimeout","_activeTimer","_inactiveTimer","_airdefenseGroup","_defensePos"];

_loopTimeout = 10 + (random 10);

AIRBASEDEFENSE_SWITCH = false; publicVariable "AIRBASEDEFENSE_SWITCH";

while { true } do {

	if (AIRBASEDEFENSE_SWITCH) then {
	
		hqSideChat = "Air-defense activated."; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;

		//---------- Useful stuff

		_activeTimer = 300;										// How long will it remain active for, in seconds. 300 = 5 minutes
		_inactiveTimer = 600;									// Shortest time between activations, in seconds. 900 = 15 minutes
		_defensePos = getMarkerPos "airbaseDefense";
		_airdefenseGroup = createGroup west;
		
		//---------- Spawn vehicles and attach them, adds crew and locks it so UAV op cannot control
		
	/*_truck = createVehicle ["B_Truck_01_mover_F",[_defensePos select 0, _defensePos select 1, 0], [],0,"NONE"];
	_truck allowDamage false;
	_truck setDir 0;
	_truck lock 3;*/
	_AA = createVehicle ["B_AAA_System_01_F",[_defensePos select 0, _defensePos select 1, 5], [],0,"NONE"];
	_AA allowDamage false;
	//_AA attachTo [_truck,[0,-2.9,1.5]];
	//_AA setDir 180;
	createVehicleCrew _AA;
	_AA lock 3;
	
		//---------- Configure

		_airdefenseGroup setBehaviour "COMBAT";
		_airdefenseGroup setCombatMode "RED";
		sleep 0.1;

		//---------- Active time

		sleep _activeTimer;

		//---------- Delete after use

		{ deleteVehicle _x } forEach [_AA,_truck];

		//---------- Cool-off period before next use

		sleep _inactiveTimer;
		AIRBASEDEFENSE_SWITCH = false; publicVariable "AIRBASEDEFENSE_SWITCH";
		hqSideChat = "Air-defense available."; publicVariable "hqSideChat"; 
		[WEST,"HQ"] sideChat hqSideChat;
		
	};
	
	sleep _loopTimeout;
	
};