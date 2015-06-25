/*
	Author: Michał Tuśnio

	Description:
	Searches a corpse of a hunted. The corpse needs to have Mh_fns_resolveHuntedCorpse called on it beforehand.

	Parameter(s):
	0: Corpse to be searched
    1: Player who searched the corpse

	Returns:
	Nothing
*/

private ["_unit", "_pl", "_markerSalt"];
_unit = _this select 0;
_pl = _this select 1;
_markerSalt = format["%1", time];

switch(side group player) do
{
    case west:
    {
        if(!(_unit getVariable ["mh_bodyChecked", false])) then
        {
            _unit setVariable ["mh_bodyChecked", true, true];
            removeAllActions _unit;
            
            if(!isDedicated) then
            {
                _pl sideChat "Found information about the other operatives, forwarding it to our GPS system as we speak. Data will be available in about half a minute.";
                
                [_unit, _markerSalt] spawn {
                    private["_unit", "_markerSalt"];
                    _unit = _this select 0;
                    _markerSalt = _this select 1;
                    sleep 30;
                    
                    [west, "HQ"] sideChat "Mission information updated with recovered intel";
                    
                    private["_deathTime", "_positions"];
                    _positions = _unit getVariable ["mh_playersPositions", []];
                    _deathTime = _unit getVariable ["mh_deathDate", [0,0,0,0,0]];
                    
                    private ["_i"];
                    _i = 0;
                    {
                        private ["_markerName"];
                        _markerName = _markerSalt + "_deadintel_" + (format["%1", _i]);
                        
                        createMarkerLocal [_markerName, _x];
                        
                        _markerName setMarkerPosLocal _x;
                        _markerName setMarkerSizeLocal [1, 1];
                        _markerName setMarkerShapeLocal "ICON";
                        _markerName setMarkerTypeLocal "mil_dot";
                        _markerName setMarkerColorLocal "ColorEAST";
                        _markerName setMarkerTextLocal format["%1:%2", _deathTime select 3, _deathTime select 4];
                        _i = _i + 1;
                    
                    } forEach _positions;
                };
            };
        };
    };
    
    
    case east:
    {
        private ["_intel"];
        _intel = [_unit] call Mh_fnc_getIntelCount;
        if(_intel > 0) then
        {
            _pl sideChat (format["Recovering %1 intel pieces.", _intel]);

            if(local _pl) then 
            {
                [[_unit, _pl, _intel], "Mh_fnc_giveIntelCount", false] call Bis_fnc_mp;
            };
            
            private ["_markerName"];
            _markerName = _unit getVariable ["mh_deadIntelMarkerName", ""];
            
            // Just keep the name part of the string
            private ["_string"];
            _string = ([markerText _markerName, ":"] call BIS_fnc_splitString) select 0;
            _markerName setMarkerTextLocal _string;
        };
            
    };

};





