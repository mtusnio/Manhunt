private ["_trigger", "_scriptParams"];
_trigger = _this select 0;
_scriptParams = [_this, 1, [ ], [ [] ]] call Bis_fnc_param;

private ["_expCount", "_pos", "_exp"];
_expCount = [_scriptParams, 0, 1, [ 1 ]] call Bis_fnc_param;
_pos = [_scriptParams, 1, getPos _trigger, [ [] ]] call Bis_fnc_param;;
_exp = [_scriptParams, 2, "BO_GBU12_LGB", [ "" ]] call Bis_fnc_param;;;

for [ {_x = 0 }, {_x < _expCount}, { _x = _x + 1} ] do
{
    _exp createVehicle _pos;
};