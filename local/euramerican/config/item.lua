include("script/game_script_base.lua")

ItemMaxSmithingLevel                = 10;			        								-- ����������ȼ�
ItemSmithing_FailCounter_Enable     = true;                 					-- �Ƿ�����¼���ߵĴ���ʧ�ܴ���
ItemSmithing_FailCounter_Add        = { 5,5,5,5,5,5,1,1,1,1 }   			-- ����ɹ���(ʧ�ܴ��� * x%)
ItemSmithing_FailCounter_MaxAdd     = 20                    					-- ����ɹ�����󲻳���x%
ItemSmithing_TrumpEffect    	      = "eff_wlev10";                 	-- �������ﵽһ���ȼ�ʱ����Ч
ItemSmithing_TrumpLink          	  = "root";                   			-- �������ﵽһ���ȼ�ʱ����ЧLink��
ItemSmithing_ArmorEffect         	  = "eff_alev10";               		-- ���ߴﵽһ���ȼ�ʱ����Ч
ItemSmithing_ArmorLink          	  = "root";                   			-- ���ߴﵽһ���ȼ�ʱ����ЧLink��
ItemSmithing_PlusAttrib_Trump       = { 0,0,0,0,0,0,251,252,253,254 } -- ���ߵ����ض�����ȼ���ÿ������һ����������
ItemSmithing_PlusAttrib_Armor       = { 0,0,0,0,0,0,261,262,263,264 } -- ���ߵ����ض�����ȼ���ÿ������һ����������
ItemSmithing_FailCounter_Clear 			= { 1,1,1,1,1,1,1,1,1,1 } 				-- ����ɹ������ɹ����Ƿ������

CanSeeOtherEquipment                = true;
ItemEffectSmithingLevel							= 10;	        -- ���ߴﵽ�õȼ�ʱ���ӵ���Ч
ItemRiderEffect                     = "eff_ridelev10"   				-- ����ﵽһ���ȼ�ʱ����Ч
ItemRiderEffectLink                 = "root"      -- ����ﵽһ���ȼ�ʱ����Чlink��

-- ϵͳ��ʼ��
function ItemInit()
    -- ��ʼ������ 
    LOAD_LAN("MSG_SMITHING_SUCCESS")
    LOAD_LAN("MSG_SMITHING_FAIL")
    LOAD_LAN("msg_script_smithing_fail1")
end


-- ����ɹ�
function OnSmithingSuccess(user, item, origSmithingLevel, smithingLevel)
    ReceiveMsg(user, LAN("MSG_SMITHING_SUCCESS"), CHANNEL_SYS);
end


-- ����ʧ��
function OnSmithingFail(user, item, origSmithingLevel, smithingLevel, costGold, failedNum)
    ReceiveMsg(user, LAN("MSG_SMITHING_FAIL"), CHANNEL_SYS);
    
    --if (origSmithingLevel >= 0 and origSmithingLevel < 3) then
    --    ReceiveMsg(user, LAN("MSG_SMITHING_FAIL"), CHANNEL_SYS);
    --elseif (origSmithingLevel >= 3 and origSmithingLevel < 6) then
    --    ReceiveMsg(user, LAN("msg_script_smithing_fail1"), CHANNEL_SYS);
    --elseif (origSmithingLevel >= 6 and origSmithingLevel < 10) then
    --    ReceiveMsg(user, LAN("msg_script_smithing_fail1"), CHANNEL_SYS);
    --end

    if(costGold >= 600000) then
				CreateItemAndMail(user, 3990, "white", "binded", 0, 0, 0, 0);
    elseif (costGold >= 300000) then
				CreateItemAndMail(user, 3989, "white", "binded", 0, 0, 0, 0);
    elseif (costGold >= 50000) then
				CreateItemAndMail(user, 4124, "white", "binded", 0, 0, 0, 0);
    end 
        
    if(origSmithingLevel==9 and failedNum>=10 and math.mod(failedNum,5)==0) then
		    if (GetItemTypeById(user, item) == 1) then
		    		CreateItemAndMail(user, 403, "white", "binded", 0, 0, 0, 0);
		    else
		    		CreateItemAndMail(user, 403, "white", "binded", 0, 0, 0, 0);
		    end
		end
end

function CanItemEnchant(nItemType, nGemItemIndex)
    if nItemType < 1 or nItemType > 8 then
        return 0
    end
    
    return 1
end
