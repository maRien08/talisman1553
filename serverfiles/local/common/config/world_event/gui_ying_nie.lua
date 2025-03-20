	dwZhuNianMaoObjId = 0;
dwZhangLang1 = 0;
dwZhangLang2 = 0;
dwZhangLang3 = 0;
dwZhangLang4 = 0;

function OnStart(pWorldEvent, nNow)
    SetWorldEventActiveFlag(pWorldEvent, 1);
    
    Random = math.random(1, 100);
    if (Random < 100) and (Random > 50) then
    
        dwZhuNianMaoObjId = WorldEventCreateNpc(4731, -501, -969, 1, 1);
        if dwZhuNianMaoObjId == 0 then
            SetWorldEventActiveFlag(pWorldEvent, 0);
            return;
        end
        dwZhangLang1 = WorldEventCreateNpc(4732, -501, -958, 1, 1);
        dwZhangLang2 = WorldEventCreateNpc(4732, -494, -967, 1, 1);
        dwZhangLang3 = WorldEventCreateNpc(4732, -512, -972, 1, 1);
        dwZhangLang4 = WorldEventCreateNpc(4732, -506, -986, 1, 1);
    
    else
    
         dwZhuNianMaoObjId = WorldEventCreateNpc(4731, -721, -1151, 1, 1);
        if dwZhuNianMaoObjId == 0 then
            SetWorldEventActiveFlag(pWorldEvent, 0);
            return;
        end
        dwZhangLang1 = WorldEventCreateNpc(4732, -724, -1158, 1, 1);
        dwZhangLang2 = WorldEventCreateNpc(4732, -719, -1145, 1, 1);
        dwZhangLang3 = WorldEventCreateNpc(4732, -728, -1146, 1, 1);
        dwZhangLang4 = WorldEventCreateNpc(4732, -727, -1160, 1, 1);

    end
    
    SayAtMediaChannel("msg_worldevent1");
end

function OnCreatureDie(pWorldEvent, pGameCre, pKiller, nReason)
    dwCreObjId = GetCreatureObjId(pGameCre);
    if dwCreObjId == dwZhuNianMaoObjId then
        WorldEventDisappearNpc(dwZhangLang1);
        WorldEventDisappearNpc(dwZhangLang2);
        WorldEventDisappearNpc(dwZhangLang3);
        WorldEventDisappearNpc(dwZhangLang4);
        AddAllEnemyEffect(pGameCre, 2103);
    	 SayAtMediaChannel("msg_worldevent1a");
    end
end

function OnCreatureLeaveWorld(pWorldEvent, pGameCre)
    dwCreObjId = GetCreatureObjId(pGameCre);
    if dwCreObjId == dwZhuNianMaoObjId then
        SetWorldEventActiveFlag(pWorldEvent, 0);
    end
end


