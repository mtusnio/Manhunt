params ["_unit"];

if(debugMode == 1) then {
	_unit addEventHandler ["HandleDamage", {
		private _v = _this select 0;
		if (!alive _v) then {
			[[allPlayers select 0,  format ["Destroyed vehicle %1", typeOf _v]], "globalChat", true] call Bis_fnc_mp;
			_v removeAllEventHandlers "HandleDamage";
		};
	}];
}