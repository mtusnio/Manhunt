#define LAST_MESSAGE_TIME 30

#define FULL_AWAITING_TIME 30

private["_landingTime", "_chopper", "_pilot", "_grp"];
_landingTime = _this select 1;
_chopper = vehicle (_this select 0);
_pilot = (crew _chopper) select 0;
_grp = group _pilot;

if(isServer) then
{
    _pilot disableAI "Target";
    _pilot disableAI "Autotarget";

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

    sleep 2; 
    _chopper land "GET IN"; 

    waitUntil { (getPosATL _chopper) select 2 <= 3 };
    [[_pilot, "Landing, we are not going to be waiting for you long."], "sideChat", side _pilot] call Bis_fnc_mp;
    
    while{_landingTime > 0} do
    {
        if(_landingTime > FULL_AWAITING_TIME && ([_chopper] call Mh_fnc_getIntelCount >= requiredIntel)) then
        {
            _landingTime = 0;
            
            private ["_chopperCount"];
            _chopperCount = count ([east, { private ["_pl", "_chopper"]; _pl = _this select 0; _chopper = _this select 1; alive _pl && (vehicle _pl == _chopper); }, [_chopper]] call Mh_fnc_getSideUnits);
            if(_chopperCount == count ([east, { alive (_this select 0); }] call Mh_fnc_getSideUnits)) then
            {
                //[[_pilot, "All are in, we're leaving"], "sideChat", side _pilot] call Bis_fnc_mp;
            }
            else
            {
                [[_pilot, format ["We have all the intel we need, we'll wait %1 more seconds for the rest of you", FULL_AWAITING_TIME]], "sideChat", side _pilot] call Bis_fnc_mp;
                
                sleep FULL_AWAITING_TIME;
            };
        }
        else
        {
            if(_landingTime == LAST_MESSAGE_TIME) then
            {
                [[_pilot, format["We are leaving in %1 seconds, hurry!", LAST_MESSAGE_TIME] ], "sideChat", side _pilot] call Bis_fnc_mp;
            };
            
            _landingTime = _landingTime - 1;
            sleep 1;
        };
    };
    
    extractionFinished = true;
    publicVariable "extractionFinished";
    
    private ["_chopperwp"];
    _chopperwp = _grp addWaypoint [getMarkerPos "getaway_zone", 50];
    _chopperwp setWaypointType "MOVE";

    [[_pilot, "We're out of here."], "sideChat", side _pilot] call Bis_fnc_mp ;

    _chopper setVehicleLock "LOCKED";
};