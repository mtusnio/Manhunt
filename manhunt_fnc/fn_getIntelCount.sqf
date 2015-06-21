/*
	Author: Michał Tuśnio

	Description:
	Returns the amount of intel carried by this unit or total amount of intel carried by units in the passed vehicle.

	Parameter(s):
	0: OBJECT Unit whose intel we want to get.
              Vehicle whose crew intel we want to get.
    
    Alternative syntax:
    0: ARRAY Objects (units and/or vehicles) whose sum intel we want to get
              

	Returns:
	Amount of intel a units/vehicle carries.
*/
private["_intel"];
_intel = 0;

if((typeName (_this select 0)) == "ARRAY") then
{
    private ["_objs"];
    _objs = _this select 0;
    {
        _intel = _intel + [_x] call Mh_fnc_getIntelCount;
    } forEach _objs;
}
else
{
    private["_obj"];
    _obj = _this select 0;

    if(_obj isKindOf "Man") then
    {
        _intel = _obj getVariable ["mh_carriedIntel", 0];
    }
    else
    {
        {
            _intel = _intel + (_x getVariable ["mh_carriedIntel", 0]);
        } forEach (crew _obj);
    };
};
_intel;