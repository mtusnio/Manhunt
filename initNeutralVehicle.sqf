params ["_unit"];

if(call Mh_fnc_isDebug) then {
	_unit addEventHandler ["HandleDamage", {
		private _v = _this select 0;
		if (!alive _v) then {
			[format ["Destroyed vehicle %1", typeOf _v], "systemChat", true] call Bis_fnc_mp;
			_v removeAllEventHandlers "HandleDamage";
		};
	}];
}