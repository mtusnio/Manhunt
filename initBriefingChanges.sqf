// Initialize markers
#define BLUFOR_STRING "<font size=""16"">Overview</font><br/><br/>Your team is tasked with finding and eliminating the opposing team. The OpFor team starts their game by parachuting in <marker name=""insertion_zone"">this</marker> area, their goal is to collect %1 pieces of intel and <marker name=""extraction_zone"">extract</marker> with them. Intel is collected by completing objectives (you will NOT be notified if the enemy completes an objective), the enemy team has %2 available to them chosen out of all potential ones (marked like <marker name=""obj_marker_3"">this</marker>), you do not know which ones they are heading for. As soon as %3 objectives have been completed,<marker name=""extraction_zone"">extraction</marker> becomes available, however you will not be notified of that. Respawns are available for BluFor. We are also aware that OpFor has three weapon caches, one is deployed <marker name=""girna_cache"">somewhere in Girna</marker>, another one has been dropped up north in an unknown location, and the third one is somewhere in <marker name=""forest_cache"">this forest</marker>. Oh, and remember, ALWAYS have at least one helicopter circling around.<br/><br/><font size=""16"">Drones</font><br/><br/>Drone coverage is available. Once it's online the drones will start reporting spotted hostiles and rough area where they can be found. Keep in mind, our drone operators are inexperienced and were assigned in a rush, their information might not always be of top notch quality.<br/><br/><font size=""16"">Bodies</font><br/><br/>Once an OpFor is killed you can check their body for any information about the other operatives. Simply approach the body and use the ""Check body"" action.<br/><br/><font size=""16"">Grid marking</font><br/><br/>You can also mark the area you're looking at on the map by using the ""Mark grid"" action. This will mark the grid you are looking at.<br/><br/><font size=""16"">Assets</font><br/><br/><marker name=""airstation_marker"">Air Station Mike</marker> - Primary base, contains 2 vehicles with thermal cameras and multiple Hunters for transport. Fuel truck is also present for any helicopters or land vehicles needing a refuel. A mortar tube is also available. Additionally, before leaving, make sure to grab a spare UAV to deploy for extra coverage in the skies.<br/><marker name=""rogain_marker"">Camp Rogain</marker> - An outpost which provides one vehicle with a thermal camera, as well as regular Hunters for rapid deployment. Seconds mortar tube is present here.<br/><marker name=""airfield_marker"">Airfield</marker> - Secondary base, houses 3 unarmed helicopters, as well as boats/Hunters in its harbour. Fuel truck can also be found.<br/><br/><font size=""16"">Respawn</font><br/><br/>You can respawn at bases as well as vehicles (helicopters, boats and Striders). Vehicle respawns are only available if a friendly unit is in one of them, or there's a friendly foot soldier in the range of 20 meters."

#define OPFOR_STRING "<font size=""16"">Overview</font><br/><br/>You start in a helicopter and can eject anywhere within the <marker name=""insertion_zone"">insertion zone</marker>, land quickly and make sure to find a hiding spot - the hunters will be on your tail. As soon as possible start moving towards some good cover, once you have died the game is over for you. Your job is to secure %1 pieces of intel and <marker name=""extraction_zone"">extract</marker> with them. Extraction will be available as soon as you have completed %2 of your objectives out of %3 available to you. One piece of intel is given to you for every task you complete, you can also share it between nearby teammates as well as pick them up from dead friendlies.<br/><br/><font size=""16"">Objectives</font><br/><br/>Both sides have all potential objectives marked on the map, however only the hunted know about the ones that have been picked for their current round. The only requirement to accomplish an objective is to walk into its radius. Once that is done the intel piece has been recovered by the person that activated it. After about 5 minutes visiting the objective site will give the hunters a clue regarding its state - in most cases it will be a flag pole with CSAT flag on it, in others the clue will be much more obvious.<br/><br/><font size=""16"">Drones</font><br/><br/>BluFor will get eventually get high altitude drone coverage of the region. Periodically it will feed the enemy team info about your possible location. Your best chance of avoiding it is to limit the usage of vehicles and move quickly when on foot. A single small UAV is also at NATO's disposal, however it does not have any thermal cameras on it.<br/><br/><font size=""16"">Intel</font><br/><br/>As mentioned above, you need to have people with at least %1 pieces of intel on them in the extraction helicopter once it leaves to win. Intel can be traded between people, as well as taken from bodies of dead comrades. Remember, only the person that did the objective gets the objective's intel, so make sure noone hoards all of it.<br/><br/><font size=""16"">Ammo caches</font><br/><br/>There are three ammo caches for you to find: one in <marker name=""girna_cache"">Girna</marker>, the other one is deployed <marker name=""random_cache"">somewhere up north</marker>, and finally there's one in <marker name=""forest_cache"">the forest</marker>. They will contain ammo and utilities for you.<br/><br/><font size=""16"">Extraction</font><br/><br/>After %2 objectives have been done completed <marker name=""extraction_zone"">extraction</marker> becomes available. To call for the chopper you need to have people (or bodies) with the required amount of intel near the extraction zone circle, and at least one person in the zone itself. Hide until your rescue shows up - the Taru will bring armed friends. Board it as soon as possible - it doesn't matter who's on it at the end, as long as the sum of passengers' carried intel is at least %1."

#define SETTINGS_STRING "Objectives needed for extraction: %1<br/>Amount of objectives available at start: %2<br/>Intel required to win: %3"

#define CREDITS_STRING "<font size=""16"">Made by</font><br/><br/>Michał ""Mavrick"" Tuśnio, Revendel on BIStudio forums.<br/><br/><font size=""16"">Special thanks to</font><br/><br/>DMK Gman for OpFor loadouts, gameplay videos.<br/>ATi for gameplay videos<br/>ATi, DMK Gman, GuðniM, Ingi, Snake, Wezzlok for testing and suggestions.<br/><br/><font size=""16"">Scripts</font><br/><br/>Nametags by JTS <br/>Fast roping script by Zealot<br/>Random weather script by Meatball"

#define CHANGELOG_STRING "V1 Release"

private["_guideString"];
_guideString = "ERROR: NO GUIDE";
if(side player == west) then
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

    _guideString = format [BLUFOR_STRING, requiredIntel, availableObjectives, requiredObjectives];
    
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
    
    _guideString = format [OPFOR_STRING, requiredIntel, requiredObjectives, availableObjectives];
};



player createDiaryRecord ["Diary", ["Guide", _guideString]];
player createDiaryRecord ["Diary", ["Situation", format[SETTINGS_STRING, requiredObjectives, availableObjectives, requiredIntel]]];
player createDiaryRecord ["Diary", ["Changelog", CHANGELOG_STRING]];
player createDiaryRecord ["Diary", ["Credits", CREDITS_STRING]];