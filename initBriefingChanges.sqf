// Initialize markers
#define BLUFOR_OVERVIEW "Your team is tasked with finding and eliminating the opposing team. The OpFor team starts their game by parachuting in <marker name=""insertion_zone"">this</marker> area, their goal is to collect %3 pieces of intel and <marker name=""extraction_zone"">extract</marker> with them. There are multiple possible objectives, marked like (marked like <marker name=""obj_marker_3"">this</marker>), however only %2 of them are active for the opposing team. You do not know which ones they are heading for, however 5 minutes after an objective's completion either a flagpost with CSAT flag will appear on top of it, or another clue (for example an explosion) will be provided. As soon as %1 objectives have been completed, <marker name=""extraction_zone"">extraction</marker> becomes available, however you will not be notified of that. OpFor has three weapon caches, one is deployed <marker name=""girna_cache"">somewhere in Girna</marker>, another one has been dropped up north in an unknown location, and the third one is somewhere in <marker name=""forest_cache"">this forest</marker>. Oh, and remember, it is not a bad idea to always have a helicopter in the air circling around."

#define BLUFOR_ASSETS "<marker name=""airstation_marker"">Air Station Mike</marker> - Primary base, contains 2 vehicles with thermal cameras and multiple Hunters for transport. Fuel truck is also present for any helicopters or land vehicles needing a refuel. A mortar tube is also available (with no artillery computer). Additionally, before leaving, make sure to grab a spare <marker name=""airfield_uav"">UAV</marker> to deploy for extra coverage in the skies.<br/><marker name=""rogain_marker"">Camp Rogain</marker> - An outpost which provides one vehicle with a thermal camera, as well as regular Hunters for rapid deployment. Second mortar tube is present here.<br/><marker name=""airfield_marker"">Airfield</marker> - Secondary base, houses 3 unarmed helicopters, as well as boats/Hunters in its harbour. Fuel truck can also be found there."

#define BLUFOR_RESPAWN "You can respawn at bases as well as vehicles (helicopters, boats and hunters or striders). Vehicle respawns are only available if a friendly unit is in one of them, or there's a friendly foot soldier in the range of 20 meters. Additionally, when destroyed all vehicles eventually respawn (with varying respawn timers depending on their type), as well as they are despawned if left unattended in the field"

#define BLUFOR_DRONES "High altitude drone coverage will be made available shortly after the mission start. It will be able to provide roughly the location of any footsoldiers, and its accuracy will increase if they keep sticking around the same area. If OpFor uses vehicles the drones will not only more easily catch them, especially if they stick to roads, but it will have a chance of providing intel about any abandoned cars. There is no guarantee that every drone check will succeed in finding anything though, but it should provide enough clues to help you track down any hostiles."

#define BLUFOR_BODIES "Once an OpFor is killed you can check their body for any information about the other operatives. Simply approach the body and use the ""Check body"" action, your map will be updated with the position of all other operatives in the moment of the killed one's death. Bodies might also be carrying intel that other operatives will want to collect, so it might be wise making sure you keep track of them."

#define BLUFOR_ACTIONS "Your action menu contains two additional options: One are earplugs which might be useful when flying a helicopter. The other option is called ""Mark grid"", use it whenever you are pointing your crosshair at a target you want to report. A report will be made in chat and appropriate grid will be marked on the map."

#define BLUFOR_FASTROPING "All helicopters allow for fast roping - simply have the pilot slow the chopper down to a hover, throw the ropes and then fast rope. The rope should be safe to use up to 45 meters above ground level, just make sure the helicopter maintains a steady hover during the whole process."

#define OPFOR_OVERVIEW "You start in a helicopter and can eject anywhere within the <marker name=""insertion_zone"">insertion zone</marker>, land quickly and make sure to find a hiding spot - the hunters will be on your tail. Make sure you do not hit the ground too hard, a rocky landing can hurt or kill you! As soon as possible start moving towards some good cover, once you have died the game is over for you. Your job is to secure %3 pieces of intel and <marker name=""extraction_zone"">extract</marker> with them. Extraction will be available as soon as you have completed %1 objectives out of %2 available to you. One piece of intel is given to you for every task you complete."

#define OPFOR_INTEL "Intel is what you came here for, you need the specified amount of it to be carried by players in the extraction helicopter to win. It does not matter who lives, only how much intel is carried off the island. You can share it with another player, if you are close enough, and take it from friendly bodies. Make sure one player does not hoard all of it, and remember you can accomplish more objectives than the minimum if you want to. Finally, BluFor can not take intel from your dead friendlies, however they can search the body to recover information about your position at the time of the teammate's death!"

#define OPFOR_DRONES "BluFor will eventually get high altitude drone coverage of the region. Periodically it will feed the enemy team info about your possible location. Your best chance of avoiding it is to limit the usage of vehicles and move quickly when on foot, do not stick around one area for too long. A single small UAV is also at NATO's disposal, however it does not have any thermal cameras on it."

#define OPFOR_AMMOCACHES "There are three ammo caches for you to find: one in <marker name=""girna_cache"">Girna</marker>, the other one is deployed <marker name=""random_cache"">somewhere up north</marker>, and finally there's one in <marker name=""forest_cache"">the forest</marker>. They will contain ammo, weapons and various utilities for you. Those locations are random and BluFor is not aware of the exact location of those caches, only their general wherabouts."

#define OPFOR_EXTRACTION "Once enough intel to win is present in the wider circle of the <marker name=""extraction_zone"">this zone</marker>, and at least one person in the green zone, extraction will start. Hide until your rescue shows up, the Taru will bring armed friends. Board it as soon as possible - it doesn't matter who's in it at the end, as long as the sum of passengers' carried intel matches the mission requirement. The helicopter will not wait forever, however you are invulnerable while inside it and you can still provide covering fire!"

#define OPFOR_ENEMYASSETS "BluFor will track you down using following assets:<br/>- Striders and Hunters with thermal cameras, Hunter turrets cannot fire<br/>- Hunters with no turrets<br/>- Maximum of one UAV without any thermal capabilities<br/>- Hummingbirds<br/>- A Hellcat, the camera only has night vision mode available<br/>- Mortar tubes, however with no artillery computer<br/>- Speedboats, only the minigun is capable of engaging<br/>All BluFor vehicles act as respawn points if any BluFor players are within 20 meters of them"

#define SETTINGS_STRING "Objectives needed for extraction: %1<br/>Amount of objectives available at start: %2<br/>Intel required to win: %3"

#define CREDITS_STRING "<font size=""16"">Made by</font><br/><br/>Michał ""Mavrick"" Tuśnio, Revendel on BIStudio forums.<br/><br/><font size=""16"">Special thanks to</font><br/><br/>DMK Gman for OpFor loadouts, gameplay videos.<br/>ATi for gameplay videos<br/>ATi, DMK Gman, GuðniM, Ingi, Snake, Wezzlok for testing and suggestions.<br/><br/><font size=""16"">Scripts</font><br/><br/>Nametags by JTS <br/>Fast roping script by Zealot<br/>Random weather script by Meatball"

#define CHANGELOG_STRING "<font size=""16"">Version 2</font><br/><br/>- Removed a custom spectator mode in favour of BI's<br/>- Blufor respawn time now 105s, can be changed in parameters<br/>- Updated briefing to reflect some recent changes <br/>- Fix wrongly displayed minimum player count<br/><br/><font size=""16"">Version 1</font><br/><br/>Initial release"

// Handle markers
if(side group player == west) then
{
    private ["_bluMarkers", "_opforMarkers"];
    _bluMarkers = [ /*"airfield_marker",*/ "airfield_area", "rogain_checkpoint", "rogain_area", /*"rogain_marker",*/ "airstation_checkpoint", /*"airstation_marker",*/ "airstation_area"];
    _opforMarkers = [ "extraction_zone", "extraction_area", "insertion_zone", "insertion_area"];
    
    {
        private["_markerType"];
        _markerType = getMarkerType _x;
        if(([_markerType, 0, 1] call Bis_fnc_trimString) == "o_") then
        {
            _x setMarkerTypeLocal ("b_" + ([_markerType, 2] call Bis_fnc_trimString));
        };
        _x setMarkerColorLocal "ColorWEST";
    } forEach _bluMarkers;
    
    {
        _x setMarkerColorLocal "ColorEAST";
    } forEach _opforMarkers;
    
    private ["_removeBlufor"];
    _removeBlufor = [ "random_cache", "forest_cache" ];
    {
        deleteMarkerLocal _x;
    } forEach _removeBlufor;
}
else
{
    "girna_cache" setMarkerPosLocal (getPos (missionNamespace getVariable ["cache1", objNull]));
    "random_cache" setMarkerPosLocal (getPos (missionNamespace getVariable ["cache2", objNull]));
    "forest_cache" setMarkerPosLocal (getPos (missionNamespace getVariable ["cache3", objNull]));
        
    private ["_removeOpfor"];
    _removeOpfor = [ "airbase_fuel", "airfield_boats", "airfield_fuel", "airbase_uav" ];
    {
        deleteMarkerLocal _x;
    } forEach _removeOpfor;
};

// Handle diaries
player createDiarySubject ["Guide", "Guide"];

if(side group player == west) then
{
    player createDiaryRecord ["Guide", ["Actions", BLUFOR_ACTIONS]];
    player createDiaryRecord ["Guide", ["Fast Roping", BLUFOR_FASTROPING]];
    player createDiaryRecord ["Guide", ["Bodies", BLUFOR_BODIES]];
    player createDiaryRecord ["Guide", ["Drones", BLUFOR_DRONES]];
    player createDiaryRecord ["Guide", ["Respawn", BLUFOR_RESPAWN]];
    player createDiaryRecord ["Guide", ["Assets", BLUFOR_ASSETS]];
    player createDiaryRecord ["Guide", ["Overview", format[BLUFOR_OVERVIEW, requiredObjectives, availableObjectives, requiredIntel]]];  
}
else
{
    player createDiaryRecord ["Guide", ["Enemy assets", OPFOR_ENEMYASSETS]];
    player createDiaryRecord ["Guide", ["Extraction", OPFOR_EXTRACTION]];
    player createDiaryRecord ["Guide", ["Ammo caches", OPFOR_AMMOCACHES]];
    player createDiaryRecord ["Guide", ["Drones", OPFOR_DRONES]];
    player createDiaryRecord ["Guide", ["Intel", OPFOR_INTEL]];
    player createDiaryRecord ["Guide", ["Overview", format[OPFOR_OVERVIEW, requiredObjectives, availableObjectives, requiredIntel]]];  
};

player createDiaryRecord ["Diary", ["Situation", format[SETTINGS_STRING, requiredObjectives, availableObjectives, requiredIntel]]];
player createDiaryRecord ["Diary", ["Changelog", CHANGELOG_STRING]];
player createDiaryRecord ["Diary", ["Credits", CREDITS_STRING]];