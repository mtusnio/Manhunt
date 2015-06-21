call compile preProcessFileLineNumbers "initVariables.sqf";

objectivesFinished = 0;
extractionAvailable = false;
extractionFinished = false;
currentObjectives = [ ];
opforGuids = [ ];
availableUavs = 0;


publicVariable "objectivesFinished";
publicVariable "extractionAvailable";
publicVariable "extractionFinished";
publicVariable "currentObjectives";
publicVariable "availableUavs";

enableEngineArtillery false;
    
[availableObjectives] call compile preProcessFileLineNumbers "selectObjectives.sqf";

addMissionEventHandler ["HandleDisconnect", {
    private ["_unit"];
    _unit = _this select 0;
    
    if(side _unit == east) then
    {
        _unit setDamage 1;
        [[_unit], "Mh_fnc_resolveHuntedCorpse", true, true] call Bis_fnc_MP;
        true;
    }
    else
    {
        false;
    };
}];

private ["_resolveGuids"];
_resolveGuids = {
    {
        private ["_guid"];
        _guid = getPlayerUID _x;
        if(!(_guid in opforGuids)) then
        {
            opforGuids pushBack (getPlayerUID _x);
        };
    } forEach ([east] call Mh_fnc_getSideUnits);
};

call _resolveGuids;

sleep 1;

call _resolveGuids;

execVM "tracker.sqf";
execVM "checkEndConditions.sqf";