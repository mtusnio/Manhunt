#define RESCUE_DELAY 30

#define EXTRACTION_RESPAWN 45

[East, "HQ"] sideChat "Copy that, extraction on the way";
[West, "HQ"] sideChat "Enemy extraction started!";
sleep RESCUE_DELAY;

if(isServer) then
{ 
    [[EXTRACTION_RESPAWN], "setPlayerRespawnTime", west, true] call Bis_fnc_mp;
    
    private["_sendCAS"];
    _sendCAS = {
        private ["_grp", "_airplanewp"];
        _grp = group (_this select 0);
        _airplanewp = _grp addWaypoint [getMarkerPos "extraction_cas", 90];
        _airplanewp setWaypointType "SAD";
        _airplanewp setWaypointBehaviour "COMBAT";
        _airplanewp setWaypointCombatMode "RED";
    };
  
    private ["_chopperMarker", "_airplane1Marker", "_airplane2Marker"];
    _chopperMarker = "extraction_chopper_marker";
    _airplane1Marker = "extraction_airplane_marker1";
    _airplane2Marker = "extraction_airplane_marker2";
    
    private ["_chopper", "_airplane1", "_airplane2"];
    _chopper = [[getMarkerPos _chopperMarker select 0, getMarkerPos _chopperMarker select 1], 300, "O_Heli_Transport_04_covered_black_F", East] call Bis_fnc_spawnvehicle;
    _airplane1 = [[getMarkerPos _airplane1Marker select 0, getMarkerPos _airplane1Marker select 1], 300, "O_Plane_CAS_02_F", East] call Bis_fnc_spawnvehicle;
    _airplane2 = [[getMarkerPos _airplane2Marker select 0, getMarkerPos _airplane2Marker select 1], 300, "I_Plane_Fighter_03_AA_F", East] call Bis_fnc_spawnvehicle;
    
    extractionChopper = _chopper select 0;
    publicVariable "extractionChopper";
    
    private["_chopperwp"];
    _chopperwp = (group ((_chopper select 1) select 0)) addWaypoint [getMarkerPos "extraction_zone", 0];
    _chopperwp setWaypointType "MOVE";
    _chopperwp setWaypointBehaviour "CARELESS";
    _chopperwp setWaypointStatements ["true", "null = [this, 240] execVM ""extractionLanding.sqf"" "];
    _chopperwp setWaypointCompletionRadius 10;
    
    [(_airplane1 select 1) select 0] call _sendCAS;
    [(_airplane2 select 1) select 0] call _sendCAS;
    
    _chopper = [[getMarkerPos _airplane1Marker select 0, getMarkerPos _airplane1Marker select 1], 300, "O_Heli_Attack_02_F", East] call Bis_fnc_spawnvehicle;
    [(_chopper select 1) select 0] call _sendCAS;
};


waitUntil { not isNil "extractionChopper" };
extractionChopper allowDamage false;

{
    _x allowDamage false;
} forEach crew extractionChopper;


extractionChopper addEventHandler ["GetIn", {
    private ["_crew", "_veh"];
    _veh = _this select 0;
    _crew = _this select 2;
    _crew allowDamage false;
    
    if(isPlayer _crew) then
    {
        _crew sideChat format ["Entered the chopper with %1 intel, there's now %2 inside", [_crew] call Mh_fnc_getIntelCount, [_veh] call Mh_fnc_getIntelCount];
    };
}];

extractionChopper addEventHandler ["GetOut", {
    private ["_crew", "_veh"];
    _veh = _this select 0;
    _crew = _this select 2;
    _crew allowDamage true;
    
    if(isPlayer _crew) then
    {
        _crew sideChat format ["Exited the chopper, there's now %1 intel inside", [_veh] call Mh_fnc_getIntelCount];
    };
}];
