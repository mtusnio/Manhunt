private ["_crew"];

_crew = crew extractionChopper;

private["_intelCount", "_playerCount"];
_intelCount = 0;
_playerCount = 0;
{
    if(isPlayer _x) then
    {
        _playerCount = _playerCount + 1;
        _intelCount = _intelCount + ([_x] call Mh_fnc_getIntelCount);
    };
} forEach _crew;


if(_intelCount >= requiredIntel) then
{
    systemChat format["CSAT has managed to escape with enough intel. %1 out of %2 soldiers escaped.", _playerCount, initialOpfor];
    
    if(isServer) then
    {
        sleep 5;
        ["OpforWin","BIS_fnc_endMission",east] call BIS_fnc_MP; 
        ["NatoLoss","BIS_fnc_endMission",west, false] call BIS_fnc_MP; 
    };
}
else
{
    systemChat "Helicopter has arrived carrying not enough intel, NATO wins in 60s";
    
    if(isServer) then
    {
        sleep 60;
        ["OpforLoss","BIS_fnc_endMission",east, false] call BIS_fnc_MP; 
        ["NatoWin","BIS_fnc_endMission",west] call BIS_fnc_MP; 
    };
};

sleep 7;
endMission "END1";


