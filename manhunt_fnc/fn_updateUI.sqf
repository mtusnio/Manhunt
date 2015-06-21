 /*
	Author: Michał Tuśnio

	Description:
	Updates all custom UI controls.
    
	Parameter(s):
	None

	Returns:
	Nothing
*/

disableSerialization;

private["_dialog"];
_dialog = uiNamespace getVariable ["mh_inteldialog", displayNull];

if(!isNull _dialog) then { (_dialog displayCtrl 50) ctrlSetText (format ["Intel: %1", [player] call Mh_fnc_getIntelCount]); };