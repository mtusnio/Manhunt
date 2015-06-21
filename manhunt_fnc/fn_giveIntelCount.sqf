/*
	Author: Michał Tuśnio

	Description:
	Gives another unit the specified amount of intel. If called on server it will protect against duplication.

	Parameter(s):
	0: Unit giving the intel
    1: Unit receiving the intel
    2: Amount of intel to give away

	Returns:
	true if intel was shared.
*/

private["_giver", "_taker", "_amount"];
_giver = _this select 0;
_taker = _this select 1;
_amount = _this select 2;

private["_intel"];
_intel = [_giver] call Mh_fnc_getIntelCount;

if(_intel >= _amount) then
{
    [_giver, -_intel] call Mh_fnc_changeIntelCount;
    [_taker, _intel] call Mh_fnc_changeIntelCount;
    
    true;
}
else
{
    false;
}