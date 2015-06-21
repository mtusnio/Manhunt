/*
	Author: Michał Tuśnio

	Description:
	Get intel count in radius.

	Parameter(s):
	0: POSITION Centre of the radius
    1: FLOAT Radius
    2: SIDE Side of the units to check.
    3: (Optional) Only alive units. Default true.
    
	Returns:
	Returns the amount of intel carried by units in specified radius.
*/

private ["_pos", "_radius", "_side", "_onlyAlive"];
_pos = [_this, 0] call BIS_fnc_param;
_radius = [_this, 1] call BIS_fnc_param;
_side = [_this, 2] call Bis_fnc_param;
_onlyAlive = [_this, 3, true, [false]] call BIS_fnc_param;

private ["_intel"];
_intel = 0;
{
    if((alive _x || !_onlyAlive) && ((getPos _x) distance _pos <= _radius)) then
    {
        _intel = _intel + ([_x] call Mh_fnc_getIntelCount);
    };


} forEach ([_side] call Mh_fnc_getSideUnits);
_intel;



