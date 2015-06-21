/*
	Author: Michał Tuśnio

	Description:
	Resolves a corpse of a Hunted. Adds intel info etc.

	Parameter(s):
	0: Corpse to be handled

	Returns:
	Nothing
*/

private ["_unit"];
_unit = _this select 0;

if(!isDedicated) then
{
    switch(side group player) do
    {
        case west:
        {
            [West, "HQ"] sideChat "Good job! Check the enemy body for any intel on the other operatives.";
            _unit addAction ["Check body", {
                [[_this select 0, _this select 1], "Mh_fnc_searchHuntedCorpse", true] call BIS_fnc_MP;
            }, [], 6, false, true, "", "_this distance _target <= 3 && !(_target getVariable [""bodyChecked"", false])"];
        };
        
        case east:
        {
            private ["_intel"];
            _intel = [_unit] call Mh_fnc_getIntelCount;
            private["_markerName", "_pos"];
            _pos = getPos _unit;
            _markerName = name _unit + "_deadintelmarker";
            
            createMarkerLocal [_markerName, _pos];
            _markerName setMarkerPosLocal _pos;
            _markerName setMarkerSizeLocal [0.75, 0.75];
            _markerName setMarkerShapeLocal "ICON";
            _markerName setMarkerTypeLocal "KIA";
            _markerName setMarkerColorLocal "ColorBlack";
            
            if(_intel > 0) then
            {
                _markerName setMarkerTextLocal (format ["%1: %2 intel", name _unit, _intel]);
                
                _unit addAction ["Recover intel", {
                    [[_this select 0, _this select 1], "Mh_fnc_searchHuntedCorpse", true] call BIS_fnc_MP;
                }, [], 6, false, true, "", "_this distance _target <= 5 && ([_target] call Mh_fnc_getIntelCount > 0);"];
            }
            else
            {
                _markerName setMarkerTextLocal (format ["%1", name _unit]);
            };
            
            _unit setVariable ["mh_deadIntelMarkerName", _markerName];
            
            
        };
    };
};

if(isServer) then
{
    private ["_positions"];
    _positions = [ ];
    {
        if(_x != _unit && side _x == east) then
        {
            _positions pushBack (position _x);
        };
    
    } forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});
    
    _unit setVariable [ "mh_playersPositions", _positions, true ];
    _unit setVariable [ "mh_deathDate", date, true ];
};

