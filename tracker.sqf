/* ******************** Defines ***************** */

#define INFANTRY_MIN_TIME 175
#define INFANTRY_VAR 10

// Initial wait before drone tracking starts
#define INITIAL_WAIT initialDroneDelay

// Delay after drones are turned online and the first check is done
#define MIN_FIRST_TRACKING_DELAY 5
#define RAND_FIRST_TRACKING_DELAY 8

#define MAX_CHANCE 100

#define INFANTRY_CHANCE 20


// This is the time when any manned vehicles will be captured & tracked
#define VEHICLE_MIN_TIME 35
#define VEHICLE_VAR 10
// The time when only old vehicles are being checked, and no new vehicles are being added to the list
#define VEHICLE_SWEETSPOT 10

#define ROAD_DISTANCE 8

#define VEHICLE_MIN_CHANCE 30

#define VEHICLE_SPEED_CHANCE_MULT 0.475

#define VEHICLE_ROAD_CHANCE 30

#define SPOT_COUNT_VAR "mh_drone_spotcount"
#define SPOT_POSITION_VAR "mh_drone_spotposition"
#define SPOT_DISTANCE 115

/* ******************** End defines ***************** */


droneTrackerMarkers = ["drone_marker_1", "drone_marker_2", "drone_marker_3", "drone_marker_4", "drone_marker_5", "drone_marker_6", "drone_marker_7", "drone_marker_8", "drone_marker_9", "drone_marker_10"];

[[[west, "HQ"], format ["Drone are being configured and we will start monitoring the area in about %1 minutes.", round (INITIAL_WAIT/60)]], "sideChat", west] call Bis_fnc_mp;
[[[east, "HQ"], "NATO is probably setting up their drone coverage in the region to find us, we'd better move fast."], "sideChat", east] call Bis_fnc_mp;

sleep INITIAL_WAIT;

[[[west, "HQ"], "Drone coverage is now online."], "sideChat", west] call Bis_fnc_mp;
[[[east, "HQ"], "Be advised, we are receiving information that drone coverage is being turned online."], "sideChat", east] call Bis_fnc_mp;

sleep  (MIN_FIRST_TRACKING_DELAY + (random RAND_FIRST_TRACKING_DELAY));

//diag_log "Drones are online";

nextVehicleCheckUnits = [ ];

//==================================================
// Infantry checker
//==================================================
[] spawn {
    private ["_trackerMarker"];
    _trackerMarker = compileFinal preprocessFileLineNumbers "trackerMarker.sqf";
    while{true} do
    {
        private["_detected"];
        _detected = false;
        
        private["_units"];
        _units = [east, { private["_pl"]; _pl = _this select 0; alive _pl && (vehicle _pl == _pl); }] call Mh_fnc_getSideUnits;
        
        //diag_log (format ["Infantry check started for %1", _units]);
        private ["_chance"];
        _chance = INFANTRY_CHANCE;
        {
            private ["_spotCount", "_spotPosition"];
            _spotCount = _x getVariable [SPOT_COUNT_VAR, 0];
            _spotPosition = _x getVariable [SPOT_POSITION_VAR, [0,0,0]];
            
            private ["_rand"];
            _rand = floor random (MAX_CHANCE + 1);
            //diag_log format ["Checking %1 with random %2 and chance %3", name _x, _rand, _chance];
            
            private["_trackerRet"];
            _trackerRet = [_x, detectionRadius / (2 ^ _spotCount), _rand, _chance + _spotCount * (MAX_CHANCE - _chance)] call _trackerMarker;
            if(_trackerRet select 0) then
            {
                _detected = true;
                private["_pos"];
                _pos = _trackerRet select 1;
                [[[West, "HQ"], format ["Hostile on foot spotted around grid %1", mapGridPosition _pos]], "sideChat", west] call Bis_fnc_mp;

                if(_spotCount == 0 || (_spotPosition distance (getPos _x)) <= SPOT_DISTANCE) then
                {
                    _x setVariable [SPOT_POSITION_VAR, getPos _x];
                    _x setVariable [SPOT_COUNT_VAR, _spotCount + 1];
                }
                else
                {
                    _x setVariable [SPOT_COUNT_VAR, 0];
                };
                sleep 2;
            }
            else
            {
                _x setVariable [SPOT_COUNT_VAR, 0];
            };
        } forEach _units;
        
        private["_sleep"];
        _sleep = INFANTRY_MIN_TIME + (random INFANTRY_VAR);
        //diag_log format ["Drones sleeping: %1", _sleep];
        
        if(!_detected) then
        {
            [[[West, "HQ"], "Drone operators report no hostiles."], "sideChat", west] call Bis_fnc_mp;
        };
        sleep _sleep;
    };

};




//==================================================
// Vehicle checker
//==================================================
[] spawn {
    private ["_trackerMarker"];
    _trackerMarker = compile preprocessFileLineNumbers "trackerMarker.sqf";
    private["_checkAllVehicles"];
    _checkAllVehicles = {
         private["_vehicleCheck"];
        _vehicleCheck = {
            private ["_veh"];
            _veh = _this select 0;
            
            private["_speed", "_roadChecks", "_totalChecks"];
            _speed = _veh getVariable ["mh_drone_sumspeed", 0];
            _roadChecks = _veh getVariable ["mh_drone_roadchecks", 0];
            _totalChecks = _veh getVariable ["mh_drone_totalchecks", 0];
            
            _veh setVariable ["mh_drone_sumspeed", _speed + (abs (speed _veh))];
            _veh setVariable ["mh_drone_totalchecks", _totalChecks + 1];
            
            private["_road"];
            _road = [getPos _veh, ROAD_DISTANCE, []] call BIS_fnc_nearestRoad;
            if(!(isNull _road) || (isOnRoad getPosATL _veh)) then
            {
                _veh setVariable ["mh_drone_roadchecks", _roadChecks + 1];
            };
        };
    
        private["_oldVehicles"];
        _oldVehicles = _this select 0;
        
        private ["_units"];
        _units = [east, { private["_pl"]; _pl = _this select 0; alive _pl && vehicle _pl != _pl; }] call Mh_fnc_getSideUnits;
        
        {
            private ["_vh"];
            _vh = vehicle _x;
         
            
            if(!(_vh in _oldVehicles) && !(_vh in nextVehicleCheckUnits)) then
            {
                nextVehicleCheckUnits pushBack _vh;
            };
           
            
            
        } forEach _units;
        
        private["_vehicles"];
        _vehicles = nextVehicleCheckUnits + _oldVehicles;
        
        if(count _vehicles > 0) then
        {
            //diag_log format ["Vehicle check on %1", _vehicles];
            {
                [_x] call _vehicleCheck;
            } forEach _vehicles;
        };
    };
    

        
    private ["_counter", "_sleepTime"];
    _sleepTime = 2.5;
    while {true} do
    {   
        //diag_log "New vehicle check launched";
        _counter = floor ((VEHICLE_MIN_TIME + random VEHICLE_VAR)/_sleepTime);
    
        private["_i"];
        for "_i" from 0 to _counter do
        {
            [[]] call _checkAllVehicles;
            sleep _sleepTime;
        };
                
        private ["_oldVehicles"];
        _oldVehicles = nextVehicleCheckUnits;
        nextVehicleCheckUnits = [ ];
        
        //diag_log "Sweetspot enabled";
        _counter = floor (VEHICLE_SWEETSPOT/_sleepTime);
        for "_i" from 0 to _counter do
        {
            [_oldVehicles] call _checkAllVehicles;
            sleep _sleepTime;
        };
        
        // Mark vehicles here        
        // Calculate chance & markers
        //diag_log "Marking vehicles";
        private ["_detected"];
        _detected = false;
        {
            
            if(isNull _x) then
            {
                diag_log "Attempted a check on null";
            }
            else
            {
                private ["_totalChecks"];
                _totalChecks = _x getVariable ["mh_drone_totalchecks", 0];
                if(_totalChecks == 0) then
                {
                    diag_log "TotalChecks set to 0!";
                }
                else
                {
                    private["_avgSpeed", "_checksPerc"];
                    _avgSpeed = (_x getVariable["mh_drone_sumspeed", 0]) / _totalChecks;
                    _checksPerc = (_x getVariable["mh_drone_roadchecks", 0]) / _totalChecks;
                    
                    //diag_log (format["Executing a check for: Total Checks - %1 AvgSpeed - %2 ChecksPerc - %3", _totalChecks, _avgSpeed, _checksPerc]);
                    private["_chance"];
                    _chance = VEHICLE_MIN_CHANCE + _avgSpeed * VEHICLE_SPEED_CHANCE_MULT + VEHICLE_ROAD_CHANCE * _checksPerc;
                    
                    private["_rand"];
                    _rand = floor (random MAX_CHANCE);
                    //diag_log (format["Chance is %1, randomed %2", _chance, _rand]);
                    
                    private["_trackerRet"];
                    _trackerRet = [_x, detectionRadiusVehicle, _rand, _chance] call _trackerMarker;
                    
                    if(_trackerRet select 0) then
                    {
                        private ["_vehType"];
                        _vehType = "Manned";
                        if(count crew _x == 0) then
                        {
                            _vehType = "Abandoned";
                        };
                        _detected = true;
                        [[[West, "HQ"], format ["%1 vehicle spotted at grid %2.", _vehType, mapGridPosition (_trackerRet select 1)] ], "sideChat", west] call Bis_fnc_mp;
                        sleep 2;
                    };
                    
                
                    _x setVariable ["mh_drone_sumspeed", 0];
                    _x setVariable ["mh_drone_roadchecks", 0];
                    _x setVariable ["mh_drone_totalchecks", 0];
                };
            };
        } forEach _oldVehicles;
        
        if(!_detected) then
        {
            [[[West, "HQ"], "No vehicle activity spotted."], "sideChat", west] call Bis_fnc_mp;
        };
    };
    // End while loop
};

/*private ["_droneCheck"];
_droneCheck = {
    private ["_detected"];
    _detected = false;
    
    {
        
        if(side _x == east) then
        {
            private ["_rand", "_chance"];
            _rand = floor random (MAX_CHANCE + 1);
            _chance = INFANTRY_CHANCE;
            
            if(vehicle _x != _x) then
            {
                _chance = VEHICLE_CHANCE;
            };
            
            diag_log format["Checking %1, chance is %2, random is %3", name _x, _chance, _rand];
            
            if(_rand <= _chance) then
            {
                diag_log format["Detected: %1", name _x];
                _detected = true;
                [[[_x, detectionRadius, detectionRadiusVehicle], "trackerMarker.sqf"], "BIS_fnc_execVM", West] call BIS_fnc_MP;
                sleep 2;
            };
        };
    } forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});
    
    if(!_detected) then
    {
        [[west, "Drone operators have nothing to report", "side"], "Mh_fnc_chatMessage", west] call BIS_fnc_MP;
    };
};

while{true} do
{
    call _droneCheck;
    _waitingTime = MIN_TRACKER_TIME + random TRACKER_TIME_VAR;
    diag_log format ["Drones sleeping %1 seconds", _waitingTime];
    
    sleep _waitingTime;
};*/