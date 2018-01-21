/*
Author: Unknown

Description: 
	Gets a punch of params from derp revive about the killer and puts those into a some nice string.  Next prints that string in both sidechat and admin channel.

Last edited: 12/08/2017 by stanhope

edited: _adminmessage is now checked for empty vars	
*/


params ["_killed","_killer","_instigator","_weapon","_source","_instigatorobj"];
private ["_killed","_killer","_instigator","_targetStartText","_weapon","_adminmessage"];

_vehiclesource = typeOf (vehicle _source);
_vehicleinstigator = typeOf (vehicle _instigatorobj);

if (_instigator == "Error: No vehicle") then{
 
	if (_killer == _killed) then{
		_targetStartText = format["%1 KILLED HIMSELF",_killed];
		_adminmessage = format["%1 killed himself with weapon: %2. Vehicle of the TKer: %3",_killed,_weapon, _vehiclesource];
    }else {
		_targetStartText = format["%1 TEAMKILLED BY SOMEONE IN %2's VEHICLE",_killed,_killer];
		[_killed] remoteExecCall ["sendTKhintC", _source];
		_adminmessage = format["%1 got killed by: %2.  Weapon used: %3. Vehicle of the TKer: %4",_killed,_killer,_weapon, _vehiclesource];
    };
 
}else {
 
    if (_instigator == _killed) then{
		_targetStartText = format["%1 KILLED HIMSELF",_killed];
		_adminmessage = format["%1 killed himself with weapon: %2. Vehicle of the TKer: %3",_killed,_weapon, _vehicleinstigator];
    }else {
		_targetStartText = format["%1 TEAMKILLED BY %2",_killed,_instigator];
		[_killed] remoteExecCall ["sendTKhintC", _instigatorobj];
		_adminmessage = format["%1 got killed by: %2.  Weapon used: %3. Vehicle of the TKer: %4",_killed,_instigator,_weapon, _vehicleinstigator];
    };
 
};


Quartermaster sideChat _targetStartText;
Quartermaster customChat [adminChannelID, _adminmessage];




