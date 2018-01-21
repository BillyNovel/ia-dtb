/*
*autor: Vivien
*/

_west = playersNumber west;

if (_west <= 9) then {
	hint "Redéploiment Autoriser";
	sleep 5;
	player setPosATL [((getPosATL MHQ)select 0),((getPosATL MHQ)select 1),((getPosATL MHQ)select 2)+ 0.5];
};

if (_west >= 10) then {
	hint "Redéploiment NON Autoriser";
};
