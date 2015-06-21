class MH_Intel
{
    idd=-1;
    fadein = 0;
    duration = 1e+1000;
    fadeout = 0;
    movingEnable=1;
    name="IntelDisplay";
    enableSimulation=1;
    onLoad="uiNamespace setVariable [""mh_inteldialog"", _this select 0]";
    onUnLoad="uiNamespace setVariable [""mh_inteldialog"", nil]";

    class controls
    {
        class MH_IntelDisplay
        {
            type = CT_STATIC;
            idc = 50;
            style = ST_LEFT;
            colorBackground[] = {0, 0, 0, 0};
            colorText[] = {0.6, 1.0, 0.6, 0.75};
            font = PuristaMedium;
            sizeEx = 0.0295;
            h = 0.02;
            x = -0.3;
            y = safeZoneY + 0.01;
            w = 0.4;
            text = "Intel: 0";
        };
    };
};