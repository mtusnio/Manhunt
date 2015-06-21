/*
	Author: Michał Tuśnio

	Description:
	Modifies the amount of intel a unit is carrying. Call it on the server to avoid race conditions

	Parameter(s):
	0: Units whose intel is being modified.
    1: Amount of intel to add/subtract

	Returns:
	New amount of intel
*/

private["_unit", "_count"];

_unit = _this select 0;
_count = _this select 1;

if(!isPlayer _unit) then
{
    diag_log "Changing intel value of non-player character!";
};

private["_newIntel"];
_newIntel = ([_unit] call Mh_fnc_getIntelCount) + _count;

if(_newIntel < 0) then
{
    _newIntel = 0;
};
_unit setVariable ["mh_carriedIntel", _newIntel, true];
[[],"Mh_fnc_updateUI", _unit] call BIS_fnc_MP;

_newIntel;