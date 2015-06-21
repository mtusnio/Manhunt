 /*
	Author: Michał Tuśnio

	Description:
	Removes all intel carried by this unit. Call it on the server to avoid race conditions

	Parameter(s):
	0: Units whose intel is being modified

	Returns:
	Nothing
*/

(_this select 0) setVariable ["mh_carriedIntel", 0, true];