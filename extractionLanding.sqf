#define LAST_MESSAGE_TIME 20

private["_landingTime", "_chopper", "_pilot", "_grp"];
_landingTime = _this select 1;
_chopper = vehicle (_this select 0);
_pilot = (crew _chopper) select 0;
_grp = group _pilot;

_pilot disableAI "Target";
_pilot disableAI "Autotarget";



if(isServer) then
{
    private["_objs"];
    _objs = nearestObjects [getMarkerPos "extraction_zone", ["Helicopter", "LandVehicle"], 10];
    
    {
        private["_veh"];
        _veh = _x;
        {
            _x action ["GetOut", _veh];
            _x action ["Eject", _veh];
        } forEach crew _x;
        
        deleteVehicle _veh;
    } forEach _objs;
    
    "Chemlight_green" createVehicle getMarkerPos "extraction_zone";

    private ["_pos", "_randomDir", "_randomDist"];
    _randomDir = random 360;
    _randomDist = 8;
    _pos = [getMarkerPos "extraction_zone", _randomDist, _randomDir] call BIS_fnc_relPos;  
    "SmokeShell" createVehicle _pos;
    _pos = [getMarkerPos "extraction_zone", _randomDist, _randomDir - 180] call BIS_fnc_relPos;
    "SmokeShell" createVehicle _pos;
};

sleep 2; 
_chopper land "GET IN"; 

waitUntil { (getPosATL _chopper) select 2 <= 3 };
_pilot sideChat "Landing, we are not going to be waiting for you long."; 


sleep _landingTime - LAST_MESSAGE_TIME;
_pilot sideChat "We are leaving in a moment, hurry!";

sleep LAST_MESSAGE_TIME;

if(isServer) then
{
    extractionFinished = true;
    publicVariable "extractionFinished";
    
    private ["_chopperwp"];
    _chopperwp = _grp addWaypoint [getMarkerPos "getaway_zone", 50];
    _chopperwp setWaypointType "MOVE";
};

_pilot sideChat "We're out of here.";

sleep 2;

_chopper setVehicleLock "LOCKED";
