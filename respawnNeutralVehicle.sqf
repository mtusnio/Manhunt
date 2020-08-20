if(isServer) then
{
    [[[_this select 0, _this select 1],"initNeutralVehicle.sqf"], "BIS_fnc_execVM", true, true] call BIS_fnc_MP;
};