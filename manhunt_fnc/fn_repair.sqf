/*
	Author: Michał Tuśnio

	Description:
	Starts the repair of a vehicle

	Parameter(s):
	0: OBJECT Vehicle to repair
    1: OBJECT Unit which does the repairs

	Returns:
	Nothing
*/

[_this select 0, _this select 1] spawn {
    private ["_calculateTime"];
    _calculateTime = {
        private ["_vehicle"];
        _vehicle = _this select 0;
        
        private ["_time"];
        _time = 40;
        if(_vehicle isKindOf "Helicopter") then
        {
            _time = 60;
        };
        
        _time;
    };

    private["_repairParts"];
    _repairParts = ["HitLFWheel", "HitLBWheel", "HitLMWheel", "HitLF2Wheel", "HitRFWheel", "HitRBWheel", "HitRMWheel",
    "HitRF2Wheel", "HitEngine", "HitLTrack","HitRTrack", "HitFuel", "HitAvionics", "HitVRotor", "HitHRotor"];

    private ["_caller", "_target"];
    _target = _this select 0;
    _caller = _this select 1;

    _caller playActionNow "medicStart";

    private["_repairTime", "_fullRepairTime"];
    _fullRepairTime = [_target] call _calculateTime;

    _repairTime = _fullRepairTime;
       
    while{_repairTime > 0 && alive _caller && _caller distance _target <= 5 && speed _target < 2 && ((_fullRepairTime - _repairTime < 2) || ["medic", animationState _caller] call BIS_fnc_inString )} do
    {
        if(_repairTime mod 5 == 0) then
        {
            hint format["Time remaining: %1s", _repairTime];
        };
        
        _repairTime = _repairTime - 1;
        sleep 1;
    };

    if(_repairTime <= 0) then
    {
        {
            [[_target, _x], "Mh_fnc_repairPart", _target] call BIS_fnc_MP; 
           
        } forEach _repairParts;
        
        _target setDamage 0;
        
        if(fuel _target < 0.1) then
        {
            [[_target, 0.1], "setFuel", _target] call Bis_fnc_mp;
        };
        hint "Done";
    };

    _caller playActionNow "medicstop";
};