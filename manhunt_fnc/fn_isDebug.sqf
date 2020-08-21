/*
	Author: Michał Tuśnio

	Description:
	Returns true if debug mode is enabled, false otherwise. This function is useful since some initialization
	scripts run before init.sqf, and will not read a variable describing debug mode properly. Similarly, we do
	not read paramsArray in single player.

	Parameter(s):
	None

	Returns:
	Boolean
*/

if(!isMultiplayer) then {
	true;
} else {
	(paramsArray select 10) == 1;
}


