if(gpsSetting == 3 || (gpsSetting == 2 && side player == east ) || (gpsSetting == 1 && side player == west) ) then
{
    if("B_UavTerminal" in (items player + assignedItems player)) then
    {
        player removeMagazine "30Rnd_65x39_caseless_mag";
        player removeMagazine "30Rnd_65x39_caseless_mag";
        player addItem "ItemGPS";
    }
    else
    {
        player addWeapon "ItemGPS";
    };
};


if(side player == west) then
{
    earplugsIn = false;
    1 fadeSound 1;
    
    markDelay = 0;
    player addAction ["Mark grid", {
        markDelay = time + 5;
        [[player, screenToWorld [0.5,0.5], 45], "Mh_fnc_markGrid", side player] call BIS_fnc_MP;
    }, [], 6, false, true, "", "markDelay <= time"];
    

    player addAction ["Earplugs in/out", {
        if(earplugsIn) then
        {
            1 fadeSound 1;
            earPlugsIn = false;
        }
        else
        {
            1 fadeSound 0.2;
            earPlugsIn = true;
        };
    
    }, [], 0, false, true, "", "true"];
    
    player removeWeapon "Binocular";
    player addWeapon "Rangefinder";
    player removePrimaryWeaponItem "optic_Hamr";
    player removePrimaryWeaponItem "optic_Arco";
    


};