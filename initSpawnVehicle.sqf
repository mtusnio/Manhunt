#define INVALID_RESPAWN_ID -1

#define ALLOW_SPAWN_DISTANCE 20

private ["_unit", "_side"];
_unit = _this select 0;
_side = _this select 1;

if(isNil "respawnVehicles") then { respawnVehicles = [ ]; };

respawnVehicles pushBack _unit;
publicVariable "respawnVehicles";

_unit addEventHandler ["Killed", {
    private ["_unit"];
    _unit = _this select 0;

    private ["_respawnId"];
    _respawnId = _unit getVariable ["mh_respawnid", INVALID_RESPAWN_ID];
    
    if(_respawnId != INVALID_RESPAWN_ID) then
    {
        [west, _respawnId] call BIS_fnc_removeRespawnPosition;
    };
    respawnVehicles = respawnVehicles - [_unit];
    publicVariable "respawnVehicles";
}];


[_unit] spawn {
    private ["_unit", "_startPos"];
    _unit = _this select 0;
    _startPos = getPos _unit;
    
    while{alive _unit} do
    {
        private ["_despawn"];
        _despawn = (_startPos distance (getPos _unit)) >= 400;
        
        if(_despawn) then
        {
            {
                if(_unit distance _x <= MINIMUM_DESPAWN_DISTANCE) exitWith { _despawn = false; };
            } forEach ([west, { private["_pl"]; _pl = _this select 0; alive _pl; } ] call Mh_fnc_getSideUnits);
        };
        
        if(_despawn) exitWith { _unit setDamage 1; };
        
        sleep 17 + random 3;
    };
    
};

// Script to check if any players are around/inside the vehicle
[_unit, _side] spawn {
    private ["_unit", "_side"];
    _unit = _this select 0;
    _side = _this select 1;
    
    
    while {alive _unit} do
    {
        private ["_respawnId"];
        _respawnId = _unit getVariable ["mh_respawnid", INVALID_RESPAWN_ID];

        private ["_canRespawn"];
        _canRespawn = false;
        
        
        if({ isPlayer _x && alive _x && side _x == _side} count (crew _unit) > 0) then
        {
            _canRespawn = true;
        }
        else
        {
            if({ alive _x && vehicle _x == _x && _x distance _unit <= ALLOW_SPAWN_DISTANCE } count ([_side] call Mh_fnc_getSideUnits) > 0) then
            {
                _canRespawn = true;
            };
        };
        
        if(_canRespawn) then
        {
            if(_respawnId == INVALID_RESPAWN_ID) then
            {
                _respawnId = [_side, _unit] call Bis_fnc_addRespawnPosition;
                _unit setVariable ["mh_respawnid", _respawnId select 1];
            };
        }
        else
        {
            if(_respawnId != INVALID_RESPAWN_ID) then
            {
                [_side, _respawnId] call BIS_fnc_removeRespawnPosition;
                _unit setVariable ["mh_respawnid", INVALID_RESPAWN_ID];
            };
        };
        
        // Refresh much more often when there are actual dead people
        private ["_deadCount"];
        _deadCount = { isPlayer _x && side group _x == _side } count allDead;
       
        if(_deadCount > 0) then
        {
            sleep 3.0 + random 1;
        }
        else
        {
            sleep 15.0 + random 1;
        };
    };
    
};