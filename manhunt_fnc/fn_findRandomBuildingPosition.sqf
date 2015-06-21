/*
	Author: Michał Tuśnio

	Description:
	Finds a random position in a random building in the given radius around position.

	Parameter(s):
	0: POSITION Centre of the radius
    1: FLOAT Radius
    2: (Optional) ARRAY String If a building name contains any of those strings it will be ignored.

    Alternative syntax
    0: ARRAY Buildings from which we should choose the position
    
	Returns:
	objNull if none found, otherwise position is returned
*/

private ["_objs"];
_objs = [ ];

if(count _this == 1) then
{
    _objs = _this select 0;
}
else
{

    private ["_pos", "_radius"];
    _pos = _this select 0;
    _radius = _this select 1;


    _objs = _pos nearObjects ["House", _radius];

    // Exclude buildings with no poses
    if(count _this > 2) then
    {
        private["_delHouses"];
        _delHouses = [ ];
        {
            private["_positions"];
            _positions = [_x] call BIS_fnc_buildingPositions;
           
            private["_ignored"];
            _ignored = _this select 2;
            private["_house"];
            _house = _x;
            {
                if([_x, typeOf _house] call Bis_fnc_inString) then
                {
                    _delHouses pushBack _house;
                };
            } forEach _ignored;

        } forEach _objs;
        _objs = _objs - _delHouses;
    };
};

private ["_emptyHouses"];
_emptyHouses = [ ];
{
    private["_positions"];
    _positions = [_x] call BIS_fnc_buildingPositions;
    
    if(count _positions == 0) then
    {
        _emptyHouses pushBack _x;
    };
    
} forEach _objs;

_objs = _objs - _emptyHouses;

if(count _objs == 0) then
{
    objNull;
}
else
{

    private["_house"];
    _house = _objs call BIS_fnc_selectRandom;
    
    private["_positions", "_ret"];
    _positions = [_house] call BIS_fnc_buildingPositions;
   
    _positions call BIS_fnc_selectRandom;
};