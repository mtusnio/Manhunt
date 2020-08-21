private _lastFatigue = 0;
while{true} do
{

    private _multiplier = 0.35;
    if(side player != west) then
    {
        _multiplier = 0.75;
    };

    private _cur = getFatigue player;
    private _diff = _cur - _lastFatigue;
    private _newFatigue = _lastFatigue + _diff * _multiplier;

    if(_diff > 0) then
    {
        player setFatigue _newFatigue;
    };

    _lastFatigue = _newFatigue;
    sleep 0.5;
};