private ["_unit"];
_unit = _this select 0;

_unit unassignItem "NVGoggles";
_unit removeItem "NVGoggles";

if(side group _unit == east) then
{
    [[_unit], "Mh_fnc_resolveHuntedCorpse", true, true] call Bis_fnc_MP;
};

if(side group _unit == west) then
{
    removeAllActions _unit;
    
    if(typeName (unitBackpack player) == "B_UAV_01_backpack_F") then
    {
        removeBackpack player;
        availableUavs = availableUavs - 1;
        publicVariable "availableUavs";
    };
};

if(_unit == player && side group player == east) then
{
    private _aliveCount = count ([east, { private["_pl"]; _pl = _this select 0; alive _pl; }] call Mh_fnc_getSideUnits);

    if(_aliveCount == 0) then
    {
        ["Initialize", [player, [east], false, true, false, false, false, false, false, false]] call BIS_fnc_EGSpectator;
    }
    else
    {
        ["Initialize", [player, [east], false, false, false, false, false, false, false, false]] call BIS_fnc_EGSpectator;
    };
};
