/*
	Author: Michał Tuśnio

	Description:
	Creates a marker locally. If it already exists, it will overwrite its settings
    
	Parameter(s):
	0: STRING Marker's name
    1: Position Marker's position
    2: (Optional) ARRAY Parameters in format:
        [STRING name, ANY value]
        
    i.e. ["MyMarker", [0,0,0], [ ["color", "ColorRed" ]];
    
    Parameters: size, shape, type, color, brush, text
    
	Returns:
	Marker name, nil on dedicated
*/

if(!isDedicated) then
{
    private ["_markerName", "_markerPos"];
    _markerName = _this select 0;
    _markerPos = _this select 1;
    
    createMarkerLocal [_markerName, _markerPos];
    _markerName setMarkerPosLocal _markerPos;
    
    private["_params"];
    _params = _this select 2;
    if(count _this > 2) then
    {
        {
            private["_name", "_val"];
            _name = _x select 0;
            _val = _x select 1;
            
            switch(_name) do
            {
                case "size":
                {
                    _markerName setMarkerSizeLocal _val;
                };
                
                case "shape":
                {
                    _markerName setMarkerShapeLocal _val;
                };
                
                case "type":
                {
                    _markerName setMarkerTypeLocal _val;
                };
                
                case "color":
                {
                    _markerName setMarkerColorLocal _val;
                };
                
                case "brush":
                {
                    _markerName setMarkerBrushLocal _val
                };
                
                case "text":
                {
                    _markerName setMarkerTextLocal _val;
                };
            };
        } forEach _params;
    };

    _markerName;
}
else
{
    nil;
};