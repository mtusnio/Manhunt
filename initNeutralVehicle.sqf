#define GRACE_PERIOD 30

params ["_unit"];

clearMagazineCargoGlobal _unit;
clearWeaponCargoGlobal _unit;
clearItemCargoGlobal _unit;

if(time < GRACE_PERIOD) then {
	private _handlerId = _unit addEventHandler ["HandleDamage", {
		private _v = _this select 0;
		if (!alive _v) then {
			if(call Mh_fnc_isDebug) then {
				private _markerId = floor random 10000000000;
				private _markerName = format ["debug_vehicle_%1", _markerId];
				private _marker = createMarker [_markerName, _v];
				_marker setMarkerShape "ICON";
				_marker setMarkerText format ["Destroyed %1", typeof _v];
				_marker setMarkerType "mil_dot";
				[format ["Destroyed vehicle %1 before grace period, marker with name %2 created", typeOf _v, _markerName], "systemChat", true] call Bis_fnc_mp;
			};
			deleteVehicle _v;
			_v removeEventHandler ["HandleDamage", _thisEventHandler];
		};
	}];

	[_handlerId, _unit] spawn {
		waitUntil { time >= GRACE_PERIOD };
		private _id = _this select 0;
		private _v = _this select 1;
		_v removeEventHandler ["HandleDamage", _id];
	};
};