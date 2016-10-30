private ["_run"];
_run = true;

initialOpfor = { isPlayer _x && side group _x == east } count allUnits;
initialBlufor = { isPlayer _x && side group _x == west } count allUnits;

publicVariable "initialOpfor";

while { _run } do
{
    private["_aliveOpfor", "_deadOpfor"];
    _aliveOpfor = { isPlayer _x && alive _x && side group _x == east } count allUnits;
    _playingBluFor = { isPlayer _x && side group _x == west } count (allUnits + allDead);
    
    // Just in case someone joins blufor mid game
    if(initialBluFor == 0 && _playingBluFor > 0) then
    {
        initialBluFor = _playingBluFor;
    };

    if(initialOpfor > 0 && initialBlufor > 0) then
    {
        if(_aliveOpfor == 0) then
        {
            ["OpforLoss","BIS_fnc_endMission",east, false] call BIS_fnc_MP; 
            ["NatoWin","BIS_fnc_endMission",west] call BIS_fnc_MP;
            _run = false;
        };
        
        if(_playingBluFor == 0) then
        {
            ["OpforWin","BIS_fnc_endMission",east] call BIS_fnc_MP; 
            ["NatoLoss","BIS_fnc_endMission",west, false] call BIS_fnc_MP;
            _run = false;
        };
    };
    
    if(_aliveOpfor == 0 && _playingBluFor == 0) then
    {
        _run = false;
    };
    
    sleep 5;
};

endMission "END1";