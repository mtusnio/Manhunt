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
    ["Initialize", [player, [east], false, false, false, false, false, false, false, false]] call BIS_fnc_EGSpectator;
};
