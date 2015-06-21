private["_unit", "_jip"];
_unit = _this select 0;
_jip = _this select 1;

if(_jip) then
{
    private ["_kickOff"];
    _kickOff = {
        private ["_unit", "_message", "_removeTasks"];
        _unit = _this select 0;
        _message = _this select 1;
        _removeTasks = _this select 2;
        
        if(_removeTasks) then { [[], "Mh_fnc_removeAllTasks", _unit] call Bis_fnc_mp; };
        [_message, "hintC", _unit] call Bis_fnc_Mp;
        
        sleep 1;
        ["END1", "endMission", _unit] call BIS_fnc_MP;
    };

    switch(side group _unit) do
    {
        case east:
        {
            if(time > 0) then
            {
                [_unit, "You cannot join as opfor mid-game", true] spawn _kickOff;
            };
        };
        
        case west:
        {
            if(disallowTeamswitch == 1 && (getPlayerUID _unit) in opforGuids) then
            {
                [_unit, "This server doesn't allow team switching", false] spawn _kickOff;
            }
            else
            {
                _unit setDamage 1;
            };
        };
    };
};

mh_drone_assembled = { 
    private ["_unit", "_weapon"];
    _unit = _this select 0;
    _weapon = _this select 1;

    if(typeOf _weapon == "B_UAV_01_F") then
    {
        [[_unit, "Deploying a UAV"], "sideChat", west] call Bis_fnc_mp;
        
        _weapon addEventHandler ["Killed", {
            availableUavs = availableUavs - 1;
            if(availableUavs < maxUavs) then
            {
                if(!(isNil "mh_drone_cache_refill")) then
                {
                    [] call mh_drone_cache_refill;
                }
                else
                {
                    diag_log "Refill function doesn't exist for UAV cache";
                };
            };
        }];
    };
};

switch(side group _unit) do
{
    case west:
    {
        _unit addEventHandler ["WeaponAssembled", mh_drone_assembled];
        
        _unit addEventHandler ["Respawn", {
            private ["_unit"];
            _unit = _this select 0;
            _unit addEventHandler ["WeaponAssembled", mh_drone_assembled];  
        }];
    };
};