
if(isMultiplayer) then {
	gpsSetting = paramsArray select 0;
	startingTime = paramsArray select 1;
	detectionRadius =  paramsArray select 2;
	detectionRadiusVehicle =  paramsArray select 3;
	requiredObjectives = paramsArray select 4;
	availableObjectives = paramsArray select 5;
	objectiveRadius = paramsArray select 6;
	nameTags = paramsArray select 7;
	requiredIntel = paramsArray select 8;
	//startingWeather = paramsArray select 9;
	debugMode = paramsArray select 10;

	disallowTeamswitch = paramsArray select 11;
	acceleratedTime = paramsArray select 12;
	respawnTime = paramsArray select 13;
	initialDroneDelay = paramsArray select 14;
	dynamicObjectives = 0;
	maxUavs = 1;
} else {
	gpsSetting = 3;
	startingTime = 12;
	detectionRadius =  350;
	detectionRadiusVehicle = 110;
	requiredObjectives = 3;
	availableObjectives = 6;
	objectiveRadius = 1250;
	nameTags = 2;
	requiredIntel = 3;
	//startingWeather = paramsArray select 9;
	debugMode = 1;

	disallowTeamswitch = 1;
	acceleratedTime = 1;
	respawnTime = 105;
	initialDroneDelay = 240;
	dynamicObjectives = 0;
	maxUavs = 1;
}