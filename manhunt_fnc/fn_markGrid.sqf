/*
	Author: Michał Tuśnio

	Description:
	Marks a grid at the specified coordinates, then spawns a script to remove the marker after the specified amounts of seconds.
    Run locally at each PC that needs to have the marker.

	Parameter(s):
	0: Unit marking the grid
    1: Position whose grid we are marking
    2: Delay before removing the marker (0 to disable removal);

	Returns:
	Nothing
*/

private ["_pos", "_unit"];
_unit = _this select 0;
_pos = _this select 1;

private["_posX", "_posY"];
_posX = _pos select 0;
_posY = _pos select 1;

_posX = floor (_posX / 50) * 50;
_posY = floor (_posY / 50) * 50;

if(_posX mod 100 == 0) then
{
    _posX = _posX + 50;
};

if(_posY mod 100 == 0) then
{
    _posY = _posY + 50;
};

_pos = [_posX, _posY, 0];

private["_areaName"];
_areaName = name _unit + "_reportingarea";

createMarkerLocal [_areaName, _pos];

_areaName setMarkerPosLocal _pos;
_areaName setMarkerSizeLocal [50, 50];
_areaName setMarkerShapeLocal "RECTANGLE";
_areaName setMarkerBrushLocal "DiagGrid";
_areaName setMarkerColorLocal "ColorEAST";

private["_markerName"];
_markerName = name _unit + "_reportingmarker";
createMarkerLocal [_markerName, _pos];
_markerName setMarkerPosLocal _pos;
_markerName setMarkerSizeLocal [0.75, 0.75];
_markerName setMarkerShapeLocal "ICON";
_markerName setMarkerTypeLocal "o_unknown";
_markerName setMarkerColorLocal "ColorEast";
_markerName setMarkerTextLocal name _unit;

_unit sideChat ("Reporting a contact in grid: " + mapGridPosition _pos);    

private["_delay"];
_delay = _this select 2;

if(_delay > 0) then
{
    [_delay, _areaName, _markerName, _pos] spawn {
        private["_delay", "_areaName", "_markerName", "_pos"];
        _delay = _this select 0;
        _areaName = _this select 1;
        _markerName = _this select 2;
        _pos = _this select 3;
        sleep _delay;

        if((getMarkerPos _areaName distance _pos) < 5) then
        {
            deleteMarkerLocal _areaName;
            deleteMarkerLocal _markerName;
        };
    };
   
};