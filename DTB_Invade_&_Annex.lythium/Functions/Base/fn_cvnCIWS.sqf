/*
Author: ansin11

description: Code that handles the AA protection for the carrier.

Last modified: 11/07/2017 by McK

modified: edited so UAV op can only see them when AA is active
*/

/*if (!(CVN_CIWS_Cooldown) && !(CVN_CIWS_Active)) then {

//activate AA
{_x setVehicleAmmo 1; _x setAutonomous true; _x setVehicleLock "LOCKED";} forEach [CVN_CIWS_1,CVN_CIWS_2,CVN_CIWS_3,CVN_RAM,CVN_SAM_2,CVN_SAM_3];
createVehicleCrew CVN_CIWS_1;
createVehicleCrew CVN_CIWS_2;
createVehicleCrew CVN_CIWS_3;
createVehicleCrew CVN_RAM;
createVehicleCrew CVN_SAM_2;
createVehicleCrew CVN_SAM_3;
CVN_CIWS_Active = true;

//deactivate and enter cooldown after 300 sec
sleep 300;
CVN_CIWS_Active = false;
CVN_CIWS_Cooldown = true;
{_x setVehicleAmmo 0; _x setVehicleLock "LOCKED";} forEach [CVN_CIWS_1,CVN_CIWS_2,CVN_CIWS_3,CVN_RAM,CVN_SAM_2,CVN_SAM_3];
deleteVehicle gunner CVN_CIWS_1;
deleteVehicle gunner CVN_CIWS_2;
deleteVehicle gunner CVN_CIWS_3;
deleteVehicle gunner CVN_RAM;
deleteVehicle gunner CVN_SAM_2;
deleteVehicle gunner CVN_SAM_3;
//cooldown complete after 900 sec
sleep 900;
CVN_CIWS_Cooldown = false;

};


if (CVN_CIWS_Active) then {player get's a local hint that AA is up};

if (CVN_CIWS_Cooldown) then {player get's a local hint that AA is cooling down};*/

