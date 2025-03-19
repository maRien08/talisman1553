CameraEffect = 0
ShakeRadian = 0
EffectIntensity = 0
EffectSpeed = 0

function OnTick(dwDelta)
    
    if CameraEffect == 0 then
        return    
    end
    
    if CameraEffect == 1 then
        ShakeRadian = ShakeRadian + (dwDelta / 1000);
        local z = math.abs(math.sin(EffectSpeed * ShakeRadian)) * EffectIntensity + math.random(-5, 5);
        AddCameraPos(0, 0, z)    
    end
    
end

function OnItemUseBegin(pCreature, pItem, pTarget)
    if IsControlUser(pCreature) == 1 then
        if GetItemIndex(pItem) == 1200 then
            --CameraEffect = 1;
            EffectSpeed = 4;
            ShakeRadian = 0;
            EffectIntensity = 10;
        end
    end
end

function OnItemUseEnd(pCreature, pItem, Result, pTarget)
    if IsControlUser(pCreature) == 1 then
        if CameraEffect == 1 then
            CameraEffect = 0;
        end
    end
end

