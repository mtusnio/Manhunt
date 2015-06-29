#define UAV_RESPAWN_TIME 600

private ["_cache"];
_cache = _this select 0;

if(isServer) then
{
    sleep 1;
    
    clearMagazineCargoGlobal _cache;   
    clearWeaponCargoGlobal _cache;   
    clearItemCargoGlobal _cache;   
    clearBackpackCargoGlobal _cache;


    _cache addBackpackCargoGlobal ["B_UAV_01_backpack_F", maxUavs];
    _cache addItemCargoGlobal ["B_UavTerminal", maxUavs];
    
    availableUavs = maxUavs;
    uavCache = _cache;
    
    mh_drone_cache_refill = {
        [] spawn {
            sleep UAV_RESPAWN_TIME;
            [[[West, "HQ"], "A UAV has been delivered at the base"], "sideChat", west] call Bis_fnc_mp;
            uavCache addBackpackCargoGlobal ["B_UAV_01_backpack_F", 1];
            uavCache addItemCargoGlobal ["B_UavTerminal", 1];
        };
    };
};

if(!isDedicated) then
{
    _cache addAction [format["Destroy UAV", name _x], {
            private ["_caller"];
            _caller = _this select 1;
            [[[West, "HQ"], format ["%1 has destroyed all UAVs", name _caller] ], "sideChat", west] call Bis_fnc_mp;

            {
                _x setDamage 1.0;
            } forEach allUnitsUAV;
            
    
        }, [], 0, false, true, "", "side _this == west && count allUnitsUAV > 0"]; 
};