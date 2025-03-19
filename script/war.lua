
include("script/game_script_base.lua")

--城战的怪物被创建后调用,包括载入存盘后的城战
function ResetMonsterData(creId, lev)
        --OutputLog("ResetMonsterData "..lev)
	--SetMonsterLev(creId, lev)
	SetNpcLevAndAttrib(creId, lev)
end
