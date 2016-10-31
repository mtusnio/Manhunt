
if(isServer) then
{
    private["_cache", "_position", "_radius"];
    _cache = _this select 0;
    _position = getPos _cache;

    _radius = _this select 1;

    if(_radius > 0) then
    {
        private ["_randomPos"];
        private ["_ignore"];
        _ignore = [ "Cargo_House_V1_F", "Cargo_House_V2_F", "Cargo_House_V3_F", "Cargo_HQ_V1_F", "Cargo_HQ_V2_F", "Cargo_HQ_V3_F", "Cargo_Patrol_V1_F", "Cargo_Patrol_V2_F", "Cargo_Patrol_V3_F" ];
        _randomPos = [_position, _radius, _ignore] call Mh_fnc_findRandomBuildingPosition;

        if(_randomPos isEqualTo objNull) then
        {
            diag_log format["Could not find any building positions at %1", _position];
        }
        else
        {
            _cache setPos _randomPos;
        };
    };

    clearMagazineCargoGlobal _cache; 
    clearWeaponCargoGlobal _cache; 
    clearItemCargoGlobal _cache; 
    clearBackpackCargoGlobal _cache;

    _cache addMagazineCargoGlobal ["RPG32_F", 1];
    _cache addMagazineCargoGlobal ["150Rnd_762x54_Box", 1];
    _cache addMagazineCargoGlobal ["30Rnd_65x39_caseless_green", 3];
    _cache addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 2];
    _cache addMagazineCargoGlobal ["10Rnd_762x54_Mag", 3];
    _cache addMagazineCargoGlobal ["ATMine_Range_Mag", 1];
    _cache addMagazineCargoGlobal ["APERSMine_Range_Mag", 1];
    _cache addMagazineCargoGlobal ["SatchelCharge_Remote_Mag", 1];
    _cache addItemCargoGlobal ["NVGoggles_OPFOR", 1];
    _cache addItemCargoGlobal ["HandGrenade", 2];
    _cache addItemCargoGlobal ["U_O_Wetsuit", 1];
    _cache addBackpackCargoGlobal ["B_FieldPack_khk", 1];
	_cache addWeaponCargoGlobal ["arifle_Katiba_F", 1]
};