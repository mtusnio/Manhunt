/*
	Author: Michał Tuśnio

	Description:
	Returns an array of all player units of the given side (will also return AI units which are playable/switchable)
    
	Parameter(s):
	0: SIDE
    1: (Optional) CODE Only units which pass this condition will be returned
        Condition accepts one parameter (the object to check) plus parameters below
    2: (Optional) ARRAY Parameters to pass to the condition function, will be available using _this select 2, 3, 4...
    
	Returns:
	Array
*/

private ["_side", "_condition", "_params"];
_side = _this select 0;
_condition = { true; };
_params =  [ ];

if(count _this > 1) then
{
    _condition = _this select 1;
    if(count _this > 2) then
    {
        _params = _this select 2;
    };
};

private ["_ret"];
_ret = [ ];
{
    if((side group _x) isEqualTo _side && (([_x] + _params) call _condition)) then
    {
        _ret pushBack _x;
    };
} forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});


_ret;


