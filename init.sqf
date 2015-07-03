call compile preProcessFileLineNumbers "initVariables.sqf";

enableSaving [ false, false ];

if(isServer) then
{
    timeSkip = random 24;
    
    // Eliminate dark night time
    if(timeSkip > 12 && timeSkip < 17) then
    {
        timeSkip = timeSkip + 5;
    };
    
    switch (startingTime) do 
    {
        case 1: { timeSkip = -4 + random 10; };
        case 2: { timeSkip = 12 + random 3; };
    };
    publicVariable "timeSkip";
    
    setTimeMultiplier acceleratedTime;
};

waitUntil { not isNil "timeSkip" };
skipTime timeSkip;

// For testing purposes we need to add a killed handler to AI
if(!isMultiplayer) then
{
    {
        if(!isPlayer _x) then
        {
            _x addEventHandler ["Killed", {_this execVM "onPlayerKilled.sqf"; }];
        };
    } forEach switchableUnits;
};

private ["_init"];
_init = false;
if(side group player == east) then
{
    _init = true;
};

[_init] execVM "CSSA3\CSSA3_init.sqf";

//Only players can be spectated. True/False
CSSA3_onlySpectatePlayers = true;

//Perspective modes that can be used.
CSSA3_allowedModes = ["firstPerson"];

//Sides that BLUFOR players can spectate.
CSSA3_bluforSpectateable = [];

//Sides that OPFOR players can spectate.
CSSA3_opforSpectateable = [opfor];
