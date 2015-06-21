private ["_markerNames", "_getMarkerName", "_getVehicleMarkerType"];

_markerNames = [ ];
_getMarkerName = {
    name (_this select 0) + "_position";
};
_getVehicleMarkerType = {
    private ["_veh", "_markerType", "_markerText"];
    _veh = _this select 0;
    _markerText = "";
    _markerType = "";
    
    if(_veh in allUnitsUAV) exitWith { ["b_uav", "UAV"]; };
    if(_veh isKindOf "Helicopter") then
    {
        _markerType = "b_air";
        _markerText = "Air: ";
    }
    else
    {
        if(_veh isKindOf "Ship") then
        {
            _markerType = "b_unknown";
            _markerText = "Sea: ";
        }
        else
        {
            _markerType = "b_recon";
            _markerText = "Land: ";
        };
    };
    
    [_markerType, _markerText];

};


while{true} do
{
    private ["_units"];
    
    _units = [side player] call Mh_fnc_getSideUnits;

    private ["_oldMarkerNames"];
    _oldMarkerNames = _markerNames;
      
    _markerNames = [ ];
    
    {
        if(side player == side _x) then
        {
            if(vehicle _x != _x && _x in _units) then
            {
                private ["_crew", "_un"];
                _crew = crew vehicle _x;
                _un = _x;
                {
                    if(_x != _un) then
                    {
                        _units = _units - [ _x ];
                    };
                
                } forEach _crew;
            };
        }
        else
        {
            _units = _units - [ _x ];
        };
    } forEach ([side player] call Mh_fnc_getSideUnits);

    
    {
        private ["_markerName"];
        _markerName = [_x] call _getMarkerName;
        
        createMarkerLocal [_markerName, position _x];
        _markerName setMarkerPosLocal position _x;
        _markerName setMarkerSizeLocal [0.75, 0.75];
        _markerName setMarkerShapeLocal "ICON";
        _markerName setMarkerColorLocal "ColorWEST";
        
        _markerNames pushBack _markerName;
        
        if(vehicle _x == _x) then
        {        
            _markerName setMarkerTypeLocal "b_inf";
            _markerName setMarkerTextLocal name _x;
        }
        else
        {            
            private ["_driver", "_markerText", "_veh", "_crew"];
            _veh = vehicle _x;
            _driver = driver vehicle _x;
            _crew = crew _veh;
            
            private["_vehMark"];
            _vehMark = [_veh] call _getVehicleMarkerType;
            
            _markerText = _vehMark select 1;
            _markerName setMarkerTypeLocal (_vehMark select 0);
            
            
            {
                if(isPlayer _x) then
                {
                    _markerText = _markerText + name _x;
                    if(_crew select (count _crew - 1) != _x) then
                    {
                        _markerText = _markerText + ",";
                    };
                }
            } forEach _crew;             
            
            _markerName setMarkerTextLocal _markerText;
        };
    } forEach _units;
    
    
    private["_respawnVehicles"];
    _respawnVehicles = [ ];
    if(!isNil "respawnVehicles") then
    {        
        // Remove occupied respawn vehicles
        {
            if(count crew _x == 0) then { _respawnVehicles pushBack _x; };
        } forEach respawnVehicles;
    };
    
    private["_i"];
    _i = 0;
    {
        private ["_markerName"];
        _markerName = format ["respawn%1_position", _i];
        
        private ["_vehMark"];
        _vehMark = [_x] call _getVehicleMarkerType;
            
        createMarkerLocal [_markerName, position _x];
        _markerName setMarkerPosLocal position _x;
        _markerName setMarkerSizeLocal [0.75, 0.75];
        _markerName setMarkerShapeLocal "ICON";
        _markerName setMarkerColorLocal "ColorWEST";
        _markerName setMarkerTypeLocal (_vehMark select 0);
        _markerName setMarkerTextLocal ((_vehMark select 1) + "Respawn veh.");
        
        _markerNames pushBack _markerName;
        _i = _i + 1;
    } forEach _respawnVehicles;

    _i = 0;
    {
        if(alive _x && isUAVConnected _x) then
        {
            private ["_markerName"];
            _markerName = format ["uav%1_position", _i];
            
            private ["_vehMark"];
             _vehMark = [_x] call _getVehicleMarkerType;
            
            createMarkerLocal [_markerName, position _x];
            _markerName setMarkerPosLocal position _x;
            _markerName setMarkerSizeLocal [0.75, 0.75];
            _markerName setMarkerShapeLocal "ICON";
            _markerName setMarkerColorLocal "ColorWEST";
            _markerName setMarkerTypeLocal (_vehMark select 0);
            _markerName setMarkerTextLocal (_vehMark select 1);
            
            _markerNames pushBack _markerName;
        };
    } forEach allUnitsUAV;
    // Clear unused markers
    {
        deleteMarkerLocal _x;
    } forEach (_markerNames - _oldMarkerNames);
    
    sleep 2;
};