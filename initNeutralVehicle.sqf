params ["_unit"];

if(call Mh_fnc_isDebug) then {
	_unit addEventHandler ["HandleDamage", {
		private _v = _this select 0;
		if (!alive _v) then {
			private _markerId = floor random 10000000000;
			private _markerName = format ["debug_vehicle_%1", _markerId];
			private _marker = createMarker [_markerName, _v];
			_marker setMarkerShape "ICON";
			_marker setMarkerText format ["Destroyed %1", typeof _v];
			_marker setMarkerType "mil_dot";
			[format ["Destroyed vehicle %1, marker with name %2 created", typeOf _v, _markerName], "systemChat", true] call Bis_fnc_mp;
			_v removeAllEventHandlers "HandleDamage";
		};
	}];
};

clearMagazineCargoGlobal _unit;
clearWeaponCargoGlobal _unit;
clearItemCargoGlobal _unit;