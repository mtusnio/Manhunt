#define OBJECTIVE_DELAY 300

private["_unit", "_trigger"];
_unit = (crew (_this select 0)) select 0;
_trigger = _this select 1;

setupFinalObjective = {
    if(!isDedicated) then
    {   
        /*if(side group player == west) then
        {
            _allTasks = simpleTasks player;
            
            {
                if(taskState _x == "Created") then
                {
                    _x setTaskState "Canceled";
                };
                
            } forEach _allTasks;
        };*/
        
        _task = player createSimpleTask ["task_extraction"];
        if(side group player == east) then
        {
            _task setSimpleTaskDescription [format["Reach the LZ and extract (%1 intel needed)", requiredIntel],"Extraction",""];
            _task setSimpleTaskDestination (getMarkerPos "extraction_zone");        
        }
        else
        {
            sleep 15;
            if(side group player == west) then
            {
                _task setSimpleTaskDescription ["Reach the LZ and prevent extraction","Stop the extraction",""];
                _task setSimpleTaskDestination (getMarkerPos "extraction_zone");
            };
        };
        ["TaskAssigned",["","Extraction"]] call BIS_fnc_showNotification;
    };
};


if(isServer) then
{
    private ["_objectiveScript"];
    _objectiveScript = [_this, 2, "objectiveFlag.sqf", [""]] call Bis_fnc_param;
    
    objectivesFinished = objectivesFinished + 1;
    publicVariable "objectivesFinished";
    
    [_unit, 1] call Mh_fnc_changeIntelCount;
    [[_unit, "Recovered a piece of intel."], "sideChat", side _unit] call BIS_fnc_MP;
    
    if(objectivesFinished == requiredObjectives) then
    {
        extractionAvailable = true;
        publicVariable "extractionAvailable";
        sleep 3;
        [[], "setupFinalObjective", true, true] call BIS_fnc_MP;
    };

    if(_objectiveScript != "") then
    {
        private ["_scriptParams"];
        _scriptParams = [_this, 3, [], [ [] ]] call Bis_fnc_param;
        
        sleep OBJECTIVE_DELAY;
    
        [_trigger, _scriptParams] call compile preprocessFileLineNumbers _objectiveScript;
    };
};