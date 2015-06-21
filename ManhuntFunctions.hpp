class CfgFunctions
{
	class Mh
	{
		class Corpses
		{
			file = "manhunt_fnc";
			class searchHuntedCorpse {};
            class resolveHuntedCorpse {};
		};

        class Intel
        {
            file = "manhunt_fnc";
            
            class getIntelCount { };
            class changeIntelCount { };
            class clearIntelCount { };
            class setIntelCount { };
            class giveIntelCount { };
            class getIntelCountInRadius { };
        };
        
        class Actions
        {
            file = "manhunt_fnc";
            class markGrid { };
            class repair { };
            class repairPart { };
        };
        
        
        class Units
        {
            file = "manhunt_fnc";
            class getSideUnits {};
        };
        
        class Map
        {
            file = "manhunt_fnc";
            class createMarker { };
        };
        
        class Tasks
        {
            file = "manhunt_fnc";
            class removeAllTasks { };
        };
        
        class Building
        {
            file = "manhunt_fnc";
            class findRandomBuildingPosition { };
        };
        
        class UI
        {
            file = "manhunt_fnc";
            class updateUI { };
        };
	};
};