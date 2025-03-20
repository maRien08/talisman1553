dwZhuNianMaoObjId = 0;
dwZhangLang1 = 0;
dwZhangLang2 = 0;
dwZhangLang3 = 0;
dwZhangLang4 = 0;

function OnStart(pWorldEvent, nNow)
    SetWorldEventActiveFlag(pWorldEvent, 1);
    
    Random = math.random(1, 100);
    if (Random < 100) and (Random > 50) then
    
        dwZhuNianMaoObjId = WorldEventCreateNpc(4734, 682, -502, 1, 1);
        if dwZhuNianMaoObjId == 0 then
            SetWorldEventActiveFlag(pWorldEvent, 0);
            return;
        end
        dwZhangLang1 = WorldEventCreateNpc(4733, 685, -493, 1, 1);
        dwZhangLang2 = WorldEventCreateNpc(4733, 688, -507, 1, 1);
        dwZhangLang3 = WorldEventCreateNpc(4733, 684, -518, 1, 1);
        dwZhangLang4 = WorldEventCreateNpc(4733, 677, -501, 1, 1);
    
    else
    
         dwZhuNianMaoObjId = WorldEventCreateNpc(4734, 524, -501, 1, 1);
        if dwZhuNianMaoObjId == 0 then
            SetWorldEventActiveFlag(pWorldEvent, 0);
            return;
        end
        dwZhangLang1 = WorldEventCreateNpc(4733, 530, -505, 1, 1);
        dwZhangLang2 = WorldEventCreateNpc(4733, 532, -497, 1, 1);
        dwZhangLang3 = WorldEventCreateNpc(4733, 530, -487, 1, 1);
        dwZhangLang4 = WorldEventCreateNpc(4733, 540, -492, 1, 1);

    end
    
    SayAtMediaChannel("msg_worldevent2");
end

function OnCreatureDie(pWorldEvent, pGameCre, pKiller, nReason)
    dwCreObjId = GetCreatureObjId(pGameCre);
    if dwCreObjId == dwZhuNianMaoObjId then
        WorldEventDisappearNpc(dwZhangLang1);
        WorldEventDisappearNpc(dwZhangLang2);
        WorldEventDisappearNpc(dwZhangLang3);
        WorldEventDisappearNpc(dwZhangLang4);
        AddAllEnemyEffect(pGameCre, 2101);
	 SayAtMediaChannel("msg_worldevent2a");
    end
end

function OnCreatureLeaveWorld(pWorldEvent, pGameCre)
    dwCreObjId = GetCreatureObjId(pGameCre);
    if dwCreObjId == dwZhuNianMaoObjId then
        SetWorldEventActiveFlag(pWorldEvent, 0);
    end
end



