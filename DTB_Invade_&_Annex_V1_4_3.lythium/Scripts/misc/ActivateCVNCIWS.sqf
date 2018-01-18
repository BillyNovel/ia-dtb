/*
author: stanhope

description: executes the function that controlls the AA

*/

remoteExec ["AW_fnc_cvnCIWS", 2];

if ((not CVN_CIWS_Cooldown) && (not CVN_CIWS_Active)) then {hint "Activating ... activating ... activated";};

if (CVN_CIWS_Active) then {hint "The Close-In Weapon Systems are already active.";};

if (CVN_CIWS_Cooldown) then {hint "The Close-In Weapon Systems are currently on cooldown.";};
