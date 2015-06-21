 /*
	Author: Michał Tuśnio

	Description:
	Sets unit's intel to the desired amount. Call it on the server to avoid race conditions

	Parameter(s):
	0: Units whose intel is being modified
    1: Amount of intel to set

	Returns:
	Nothing
*/

(_this select 0) setVariable ["mh_carriedIntel", _this select 1, true];
[[],"Mh_fnc_updateUI", _unit] call BIS_fnc_MP;