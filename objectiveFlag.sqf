private ["_trigger"];
_trigger = _this select 0;

private ["_flagPole"];
_flagPole = createVehicle ["FlagPole_F", getPos _trigger, [], 0, "CAN_COLLIDE"];
_flagPole setFlagTexture "A3\Data_F\Flags\Flag_CSAT_CO.paa";