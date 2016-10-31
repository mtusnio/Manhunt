#define TIER2_SPREAD 10
#define TIER3_SPREAD 20

#define TIER2_MULTIPLIER 1.6
#define TIER3_MULTIPLIER 2.5

#define MARKER_STAYING_TIME 240

#define WATER_RETRIES 20

if(isNil "currentMarkers") then { currentMarkers = [ ]; };

private _calculateRadius = {
    private["_rand"];
    _rand = _this select 0;
    
    private ["_tier1", "_tier2", "_tier3"];
    _tier1 = _this select 1;
    _tier2 = _tier1 + TIER2_SPREAD;
    _tier3 = _tier2 + TIER3_SPREAD;
    
    private["_radius"];
    _radius = _this select 2;
    if(_rand > _tier3) then
    {
        _radius = 0;
    }
    else
    {
        if(_rand > _tier1) then
        {
            if(_rand > _tier2) then
            {
                _radius = _radius * TIER3_MULTIPLIER;
            }
            else
            {
                _radius = _radius * TIER2_MULTIPLIER;
            };
        };
    };
    
    _radius;
};

private _calculatePosition = {
    params ["_target", "_radius"];
    private _pos = position _target;
    private _markerPos = [];
    // Regardless if the player is in water or not we want to run some retries to make sure the marker ends up on the mainland
    // This way, unless the target is out in the sea, the marker will always stay close to the coast giving less info regarding the position of the player
    // Not an ideal solution, especially since it runs a retry per every fail, but it should be enough for now
    for "_i" from 0 to WATER_RETRIES do
    {
        private _yDist = _radius - random ( _radius * 2);
        private _maxX = sqrt ( _radius^2 - _yDist^2 );
        private _xDist = _maxX - random (_maxX * 2);
        
        _markerPos =  [(_pos select 0) + _xDist,(_pos select 1) + _yDist, 0];
        if(!surfaceIsWater _markerPos) exitWith { };
    };
    _markerPos;
};

private ["_target", "_radius", "_rand", "_chance"];
_target = _this select 0;
_radius = _this select 1;
_rand = _this select 2;
_chance = _this select 3;


_radius = [_rand, _chance, _radius] call _calculateRadius;

if(_radius > 0) then
{
    private["_markerName", "_timerMarkerName"];
    _markerName = [droneTrackerMarkers] call BIS_fnc_arrayShift;
    droneTrackerMarkers pushBack _markerName;
    
    _timeMarkerName = _markerName + "_time";

    private _markerPos = [_target, _radius] call _calculatePosition;

    private ["_markerColor"];
    _markerColor = "ColorRed";
    if(!(_target isKindOf "Man")) then
    {
        _markerColor = "ColorYellow";
    };
    
    [[_markerName, _markerPos, [
    ["size", [_radius, _radius]], ["shape", "ELLIPSE"], ["brush", "SolidBorder"], ["color", _markerColor] 
    ] ], "Mh_fnc_createMarker", west] call Bis_fnc_MP;
    /*createMarkerLocal [_markerName,_markerPos];
    _markerName setMarkerPosLocal _markerPos;
    _markerName setMarkerSizeLocal [_radius, _radius];
    _markerName setMarkerShapeLocal "ELLIPSE";
    _markerName setMarkerBrushLocal "SolidBorder";
    _markerName setMarkerColorLocal "ColorRed";*/

    [[_timeMarkerName, _markerPos, [ 
    ["size", [0.75, 0.75]], ["shape", "ICON"], ["type", "hd_unknown"], ["color", "ColorBlack"], ["text", format["%1:%2", date select 3, date select 4]] 
    ] ], "Mh_fnc_createMarker", west] call Bis_fnc_MP;
    /*createMarkerLocal [_timeMarkerName,_markerPos];
    _timeMarkerName setMarkerPosLocal _markerPos;
    _timeMarkerName setMarkerSizeLocal [0.75, 0.75];
    _timeMarkerName setMarkerShapeLocal "ICON";
    _timeMarkerName setMarkerTypeLocal "hd_unknown";
    _timeMarkerName setMarkerColorLocal "ColorBlack";
    _timeMarkerName setMarkerTextLocal format["%1:%2", date select 3, date select 4];*/
    
    private["_elem"];
    _elem = objNull;
    
    {
        if(_markerName in _x) exitWith { _elem = _x; };
    } forEach currentMarkers;
    currentMarkers = currentMarkers - [_elem];
    currentMarkers pushBack [_markerName, _timeMarkerName, time];
    
    private ["_clearMarkers"];
    _clearMarkers = [ ];
    {
        private ["_time"];
        _time = _x select 2;
        
        if(time - _time >= MARKER_STAYING_TIME) then
        {
            [_x select 0, "deleteMarkerLocal", west] call Bis_fnc_mp;
            [_x select 1, "deleteMarkerLocal", west] call Bis_fnc_mp;
            _clearMarkers pushBack _x;
        };
    } forEach currentMarkers;
    
    currentMarkers = currentMarkers - _clearMarkers;
    
    [true, _markerPos];
}
else
{
    [false, []];
};
