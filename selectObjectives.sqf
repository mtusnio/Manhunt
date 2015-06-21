#define MAX_OBJECTIVES 20

if(isServer) then
{
    private["_objectivesCount"];
    _objectivesCount = _this select 0;

    if(dynamicObjectives == 0) then
    {
        private["_allObjectives", "_allTasks", "_selectNextObjective"];
        
        _allObjectives = [ ];
        _allTasks = [ ];

         _selectNextObjective = {
            private ["_objectives", "_tasks", "_rand", "_o", "_t", "_taskRem", "_objRem", "_task1"];
            _objectives = _this select 0;
            _tasks = _this select 1;
        
            if(count _objectives != count _tasks) then
            {
                diag_log "ERROR! Objectives do not match tasks!";
            };
            diag_log (format ["Choosing from %1 available: %2", count _objectives, _tasks]);
            
            _rand = floor random (count _objectives);
            _o = _objectives select _rand;
            _t = _tasks select _rand;
            diag_log ("Selected task: " + _t);
            
            _task1 = missionNamespace getVariable [_t, objNull];
            
            _taskRem = [ ];
            _objRem = [ ];
            
            private ["_i"];
            for [{_i = 0}, {_i < count _objectives}, {_i = _i + 1}] do
            {
                private ["_task2", "_pos1", "_pos2"];
                _task2 = missionNamespace getVariable [_tasks select _i, objNull];
                _pos1 = position _task1;
                _pos2 = position _task2;
                
                if([_pos1 select 0, _pos1 select 1] distance [_pos2 select 0, _pos2 select 1] <= objectiveRadius) then
                {
                    _taskRem pushBack (_tasks select _i);
                    _objRem pushBack (_objectives select _i);
                };
            };
            
            diag_log (format ["Removing tasks: %1", _taskRem]);
            [_o, _t, _taskRem, _objRem];
        };
        
        private["_i"];
        for [{_i = 1}, {_i <= MAX_OBJECTIVES}, {_i = _i + 1}] do
        {
            private["_taskString", "_task", "_objective"];
            _taskString = format ["task%1", _i];
            _task = missionNamespace getVariable [_taskString, objNull];
            _objective = missionNamespace getVariable [format ["objective%1", _i], objNull];
            
            if(!(_task isEqualTo objNull) && !( _objective isEqualTo objNull) ) then
            {
                _allObjectives pushBack _objective;
                _allTasks pushBack _taskString;
            };
        };
        
        private["_selectedTriggers", "_potentialObjectives", "_potentialTasks"];
        _selectedTriggers = [ ];
        _potentialObjectives = _allObjectives;
        _potentialTasks = _allTasks;
        for [{_i = 0}, {_i < _objectivesCount}, {_i = _i + 1}] do
        {
            if(count _potentialObjectives == 0) then
            {
                diag_log "Could not create one objective, ran out of potentials";
            }
            else
            {
                private["_sel", "_obj", "_tRem", "_oRem"];
                _sel = [_potentialObjectives, _potentialTasks] call _selectNextObjective;
                
                _obj = _sel select 0;
                _task = _sel select 1;
                _tRem = _sel select 2;
                _oRem = _sel select 3;
                
                _selectedTriggers pushBack _obj;
                
                _allObjectives = _allObjectives - [_obj];
                _allTasks = _allTasks - [_task];
                
                _potentialObjectives  = _potentialObjectives - _oRem;
                _potentialTasks = _potentialTasks - _tRem;
            }
        };
        
        currentObjectives = _selectedTriggers;
        publicVariable "currentObjectives";
        
        {
            [_x] call BIS_fnc_deleteTask;
        } forEach _allTasks;
    };
};