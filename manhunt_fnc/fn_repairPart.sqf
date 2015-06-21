/*
	Author: Michał Tuśnio

	Description:
	Repairs a part of a vehicle.

	Parameter(s):
	0: OBJECT Vehicle to repair
    1: STRING Name of the part

	Returns:
	Nothing
*/

private ["_veh", "_part"];
_veh = _this select 0;
_part = _this select 1;
_veh setHitPointDamage [_part, 0.0];
