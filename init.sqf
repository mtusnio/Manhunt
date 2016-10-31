call compile preProcessFileLineNumbers "initVariables.sqf";

enableSaving [ false, false ];

if(isServer) then
{
    // All assumptions here are that the game starting time is noon
    timeSkip = random 24;
    
    // Eliminate dark night time (4-6 AM)
    if(timeSkip >= 16 && timeSkip <= 18) then
    {
        timeSkip = timeSkip + 2;
    };
    
    switch (startingTime) do 
    {
        // Skip to an hour between 7 AM and 6 PM
        case 1: { timeSkip = -5 + random 11; };
        // Skip to an hour between 8 PM and 6 AM
        case 2: { timeSkip = 8 + random 10; };
    };
    publicVariable "timeSkip";
    
    setTimeMultiplier acceleratedTime;
};

execVM "randomWeather2.sqf";

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
