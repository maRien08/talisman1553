
include("script/game_script_base.lua")

--��ս�Ĺ��ﱻ���������,����������̺�ĳ�ս
function ResetMonsterData(creId, lev)
        --OutputLog("ResetMonsterData "..lev)
	--SetMonsterLev(creId, lev)
	SetNpcLevAndAttrib(creId, lev)
end
