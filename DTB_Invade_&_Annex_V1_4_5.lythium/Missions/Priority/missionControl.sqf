/*
Author: 

	Quiksilver

Last modified: 

	4/02/2016

Description:

	Priority Mission control

To do:

______________________________________________*/

private ["_mission","_missionList","_currentMission","_nextMission","_delay","_loopTimeout","_playerCount","_minPlayerCount"];

_delay = 5400 + (random 600);
_loopTimeout = 10 + (random 10);

_missionList = [
	"Priorityarty",
	"priorityAA",
	"Priorityarty",
	"priorityreinforceAO",
	"Priorityarty",
	"priorityAA",
	"priorityreinforceAO",
	"Priorityarty"
];

PRIO_SWITCH = true; publicVariable "PRIO_SWITCH";
	
while { true } do {

	if (isMultiplayer) then {
		_playerCount = count playableUnits;
	} else {
		_playerCount = count switchableUnits;
	};
	_minPlayerCount = 3+ random 5;
	if (PRIO_SWITCH && (_playerCount >= _minPlayerCount)) then {
	
		hqSideChat = "Priority mission assigned.";
		[hqSideChat] remoteExec ["AW_fnc_globalSideChat",0,false];
		
	
		sleep 3;
	
		_mission = selectRandom _missionList;
		_currentMission = execVM format ["missions\Priority\%1.sqf", _mission];
	
		waitUntil {
			sleep 3;
			scriptDone _currentMission
		};
	
		sleep _delay;
		
		PRIO_SWITCH = true; publicVariable "PRIO_SWITCH";
	};
	sleep _loopTimeout;
};
