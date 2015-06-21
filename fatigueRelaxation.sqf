private ["_lastFatigue"];
_lastFatigue = 0;
while{true} do
{
    private ["_multiplier"];
    _multiplier = 0.35;
    if(side player != west) then
    {
        _multiplier = 0.75;
    };
    
    private ["_diff", "_cur"];
    _cur = getFatigue player;
    _diff = _cur - _lastFatigue;
    
    if(_diff > 0) then
    {
        player setFatigue ( _lastFatigue + _diff * _multiplier );
    };
    
    _lastFatigue = _cur;
    sleep 1;
};