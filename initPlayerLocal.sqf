call compile preProcessFileLineNumbers "initVariables.sqf";
call compile preprocessFileLineNumbers "initBriefingChanges.sqf";

enableEngineArtillery false;

if(isMultiplayer) then
{
    call compile preProcessFileLineNumbers "addStartingEquipment.sqf";
};


if(side player == west) then
{
    [] execVM "mapMarkers.sqf";
    [] execVM "zlt_fastrope.sqf";
};

sleep 1;

if((side player == west && nameTags == 1) || nameTags == 2) then
{
    122014 cutrsc ["NameTag","PLAIN"]; // This executes nametags. Add this to your Init.sqf
};

execVM "fatigueRelaxation.sqf";

if(side player == east) then
{
    100 cutrsc ["MH_Intel", "PLAIN", 0, false];
    setplayerrespawntime 100000;
    {
        if(side _x == east && _x != player) then
        {
            _x addAction [format["Give %1 an intel piece", name _x], {
            
                    [[_this select 1, _this select 0, 1], "Mh_fnc_giveIntelCount", false] call Bis_fnc_mp;
                    [[_this select 0, format ["Received an intel piece from %1", name (_this select 1)]], "sideChat", east] call BIS_fnc_MP;
                    
                }, [], 1, false, true, "", "alive _target && _this distance _target <= 3 && ([_this] call Mh_fnc_getIntelCount > 0);"]; 
        };
    } forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});
};

if(debugMode == 1) then
{
    setPlayerRespawnTime 5;
};

