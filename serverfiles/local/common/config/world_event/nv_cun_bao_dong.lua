dwZhuNianMaoObjId = 0;
dwZhangLang1 = 0;
dwZhangLang2 = 0;
dwZhangLang3 = 0;
dwZhangLang4 = 0;

function OnStart(pWorldEvent, nNow)
    SetWorldEventActiveFlag(pWorldEvent, 1);
    
    Random = math.random(1, 100);
    if (Random < 100) and (Random > 50) then
    
        dwZhuNianMaoObjId = WorldEventCreateNpc(4735, 2685, -54, 1, 1);
        if dwZhuNianMaoObjId == 0 then
            SetWorldEventActiveFlag(pWorldEvent, 0);
            return;
        end
        dwZhangLang1 = WorldEventCreateNpc(4736, 2693, -48, 1, 1);
        dwZhangLang2 = WorldEventCreateNpc(4736, 2686, -41, 1, 1);
        dwZhangLang3 = WorldEventCreateNpc(4736, 2676, -48, 1, 1);
        dwZhangLang4 = WorldEventCreateNpc(4736, 2689, -47, 1, 1);
    
    else
    
         dwZhuNianMaoObjId = WorldEventCreateNpc(4735, 2790, -83, 1, 1);
        if dwZhuNianMaoObjId == 0 then
            SetWorldEventActiveFlag(pWorldEvent, 0);
            return;
        end
        dwZhangLang1 = WorldEventCreateNpc(4736, 2780, -80, 1, 1);
        dwZhangLang2 = WorldEventCreateNpc(4736, 2788, -83, 1, 1);
        dwZhangLang3 = WorldEventCreateNpc(4736, 2795, -81, 1, 1);
        dwZhangLang4 = WorldEventCreateNpc(4736, 2788, -64, 1, 1);

    end
    
    SayAtMediaChannel("msg_worldevent3");
end

function OnCreatureDie(pWorldEvent, pGameCre, pKiller, nReason)
    dwCreObjId = GetCreatureObjId(pGameCre);
    if dwCreObjId == dwZhuNianMaoObjId then
        WorldEventDisappearNpc(dwZhangLang1);
        WorldEventDisappearNpc(dwZhangLang2);
        WorldEventDisappearNpc(dwZhangLang3);
        WorldEventDisappearNpc(dwZhangLang4);
        AddAllEnemyEffect(pGameCre, 2102);
	 SayAtMediaChannel("msg_worldevent3a");
    end
end

function OnCreatureLeaveWorld(pWorldEvent, pGameCre)
    dwCreObjId = GetCreatureObjId(pGameCre);
    if dwCreObjId == dwZhuNianMaoObjId then
        SetWorldEventActiveFlag(pWorldEvent, 0);
    end
end




