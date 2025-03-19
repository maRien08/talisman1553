
-- ai action

include("script/ai/AI_Table.lua")
-------------------------------------------------------------------------------
-- 脚本ai与c语言的接口函数
-------------------------------------------------------------------------------

--------------------------------------------------------------------
--事件 “OnDestroy”
--OnDestroy 摧毁脚本ai，在某些情况需要
--格式 noid   / nid    
--     实例ID / 表格ID
--------------------------------------------------------------------
function OnDestroy(noid, nid)
	local aitype = GetAIType(nid)
	if aitype then
		if AIObjTable[noid] then
			AIObjTable[noid]=nil
			--OutputLog("脚本ai对象被强制销毁，npcId="..nid.." noid="..noid)
		end
	end
end

--------------------------------------------------------------------
--事件 “OnCreate”
--OnCreate npc被创建出来的时候
--格式 noid   / nid    
--     实例ID / 表格ID 
--------------------------------------------------------------------
function OnCreate(noid, nid, creatorid)
	--OutputLog("OnCreate called nid="..nid.."noid="..noid)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnCreate(creatorid)
	end
end


--------------------------------------------------------------------
--事件 “OnDead”
--OnDead 死亡时候触发
--格式 noid   / nid    /    killer
--     实例ID / 表格ID /   被谁杀的
--------------------------------------------------------------------
function OnDead(noid, nid, killer)
	local aitype = GetAIType(nid)
	if aitype then
		local ai = CreateAI(nid, noid)
		ai:OnDead(killer)
		DeleteAI(nid, noid)
	end
end

--------------------------------------------------------------------
--事件 “OnFirstBeAttacked”
--OnFirstBeAttacked npc第一次受到攻击的时候触发
--格式 noid   / nid    /    enemy
--     实例ID / 表格ID /   被谁打的
--------------------------------------------------------------------
function OnFirstBeAttacked(noid, nid, enemy)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnFirstBeAttacked(enemy)
	end
end

--------------------------------------------------------------------
--事件 “OnArrive”
--OnArrive 巡逻npc到达某一个巡逻点时候触发
--格式 noid   / nid    /      n      / IsEndPoint   / unused
--     实例ID / 表格ID / 第n个巡逻点 / 是否巡逻终点 / 未使用
--------------------------------------------------------------------
function OnArrive(noid, nid, n, IsEndPoint, unused)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnArrive(n, IsEndPoint)
	end
end

--------------------------------------------------------------------
--事件 “OnArrivePoint”
--OnArrivePoint npc已经到达预先设定好的点
--格式 noid   / nid    
--     实例ID / 表格ID 
--------------------------------------------------------------------
function OnArrivePoint(noid, nid, x, y)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnArrivePoint(x, y)
	end
end

--------------------------------------------------------------------
--事件 “OnBeCaptured”
--OnArrivePoint 被某个玩家捕获
--格式 noid   / nid    
--     实例ID / 表格ID 
--------------------------------------------------------------------
function OnBeCaptured(noid, nid, uid)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnBeCaptured(uid)
	end
end

--------------------------------------------------------------------
--事件 “OnHpLower”
--OnHpLower npc血量低到某一个百分比触发，只触发一次
--格式  noid  /   nid  /   rate
--     实例ID / 表格ID / 血量百分比
--------------------------------------------------------------------
function OnHpLower(noid, nid, rate)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnHpLower(rate)
	end
end

--------------------------------------------------------------------
--OnTalk : 指npc开口说话，与OnInteractive不同
--格式 noid   / nid    /   dwNow 
--     实例ID / 表格ID / 当前时间
--------------------------------------------------------------------
function OnTalk(noid, nid, dwNow)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnTalk(dwNow)
	end
end

function OnBlast(noid, nid, dwNow)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnBlast(dwNow)
	end
end

--------------------------------------------------------------------
--OnInteractive 与npc交互的函数，指弹出对话框之类的交互，与OnTalk不同
--uid: int (user object id)
--nid: int (npc id)
--event: string
--返回值 string
--------------------------------------------------------------------
function OnInteractive(noid, nid, uid, event)
	local ai = CreateAI(nid, noid)
	if ai then
		return ai:OnInteractive(uid, event)
	else
		return ""
	end
end

--------------------------------------------------------------------
--OnTaskAccept : 接受任务触发
--格式 noid   / nid    /   uid   / taskid
--     实例ID / 表格ID / 玩家id  / 接受的任务id
--------------------------------------------------------------------
function OnTaskAccept(noid, nid, uid, taskid)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnTaskAccept(uid, taskid)
	end
end

--------------------------------------------------------------------
--OnTaskFinish : 完成任务触发
--格式 noid   / nid    /   uid   / taskid
--     实例ID / 表格ID / 玩家id  / 完成的任务id
--------------------------------------------------------------------
function OnTaskFinish(noid, nid, uid, taskid)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnTaskFinish(uid, taskid)
	end
end

--------------------------------------------------------------------
--OnSpecialState : 进入特殊状态触发
--格式 noid   / nid    /   dwNow 
--     实例ID / 表格ID / 当前时间
--------------------------------------------------------------------
function OnSpecialState(noid, nid, dwNow)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnSpecialState(dwNow)
	end
end

--------------------------------------------------------------------
--OnUpdate :
--格式 noid   / nid    /   dwNow 
--     实例ID / 表格ID / 当前时间
--------------------------------------------------------------------
function OnUpdate(noid, nid, dwNow)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnUpdate(dwNow)
	end
end

--------------------------------------------------------------------
--OnLeaveBattle : 脱离战斗触发
--格式 noid   / nid    /   dwNow 
--     实例ID / 表格ID / 当前时间
--------------------------------------------------------------------
function OnLeaveBattle(noid, nid)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnLeaveBattle()
	end
end

--------------------------------------------------------------------
--OnEnterBattle : 进入战斗触发
--格式 noid   / nid    /   dwNow 
--     实例ID / 表格ID / 当前时间
--------------------------------------------------------------------
function OnEnterBattle(noid, nid)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnEnterBattle()
	end
end

--------------------------------------------------------------------
--OnRunaway : 逃跑触发
--格式 noid   / nid    /   dwNow 
--     实例ID / 表格ID / 当前时间
--------------------------------------------------------------------
function OnRunaway(noid, nid)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnRunaway(nid, noid)
	end
end

--------------------------------------------------------------------
--OnStartDuel : 决斗开始触发
--格式 noid   / nid    /   tar 
--     实例ID / 表格ID / 目标
--------------------------------------------------------------------
function OnStartDuel(noid, nid, tar)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnStartDuel(nid, noid, tar)
	end
end

--------------------------------------------------------------------
--OnEndDuel : 决斗结束触发
--格式 noid   / nid    /   rate / tar 
--     实例ID / 表格ID / 目标
--------------------------------------------------------------------
function OnEndDuel(noid, nid, rate, tar)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnEndDuel(nid, noid, rate, tar)
	end
end

--------------------------------------------------------------------
--OnOpen : 开门触发
--格式 noid   / nid    /   rate / tar 
--     实例ID / 表格ID / 目标
--------------------------------------------------------------------
function OnOpen(noid, nid)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnOpen(nid, noid)
	end
end

--------------------------------------------------------------------
--OnClose : 关门触发
--格式 noid   / nid    /   rate / tar 
--     实例ID / 表格ID / 目标
--------------------------------------------------------------------
function OnClose(noid, nid)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnClose(nid, noid)
	end
end

--------------------------------------------------------------------
--OnEnterView : 进入视野
--格式 noid   / nid    /   tar 
--     实例ID / 表格ID / 目标
--------------------------------------------------------------------
function OnEnterView(noid, nid, tar)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnEnterView(tar)
	end
end

--------------------------------------------------------------------
--OnLeaveView : 离开视野
--格式 noid   / nid    /   tar 
--     实例ID / 表格ID / 目标
--------------------------------------------------------------------
function OnLeaveView(noid, nid, tar)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnLeaveView(tar)
	end
end

--------------------------------------------------------------------
--OnRecvDamage : 受到攻击触发
--格式 noid   / nid    / srcoid   / damage
--     实例ID / 表格ID / 攻击者   / 伤害值
--------------------------------------------------------------------
function OnRecvDamage(noid, nid, nsrcid, ndamage)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnRecvDamage(nsrcid, ndamage)
	end
end

--------------------------------------------------------------------
-- 以下，发给关联npc的
--------------------------------------------------------------------

--------------------------------------------------------------------
--事件 “OnCreate”
--OnCreate npc被创建出来的时候
--格式 noid   / nid    
--     实例ID / 表格ID 
--------------------------------------------------------------------
function OnCreate_toRelated(noid, nid, fromnoid, fromnid, creatorid)
	--OutputLog("OnCreate called nid="..nid.."noid="..noid)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnCreate_toRelated(fromnid, fromnoid, creatorid)
	end
end

--------------------------------------------------------------------
--事件 “OnDead”
--OnArrive 巡逻npc到达某一个巡逻点时候触发
--格式 noid   / nid    /    killer
--     实例ID / 表格ID /   被谁杀的
--------------------------------------------------------------------
function OnDead_toRelated(noid, nid, fromnoid, fromnid, killer)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnDead_toRelated(fromnid, fromnoid, killer)
	end
end

--------------------------------------------------------------------
--事件 “OnFirstBeAttacked”
--OnFirstBeAttacked npc第一次受到攻击的时候触发
--格式 noid   / nid    /    enemy
--     实例ID / 表格ID /   被谁打的
--------------------------------------------------------------------
function OnFirstBeAttacked_toRelated(noid, nid, fromnoid, fromnid, enemy)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnFirstBeAttacked_toRelated(fromnid, fromnoid, enemy)
	end
end

--------------------------------------------------------------------
--事件 “OnArrive”
--OnArrive 巡逻npc到达某一个巡逻点时候触发
--格式 noid   / nid    /      n      / IsEndPoint   / unused
--     实例ID / 表格ID / 第n个巡逻点 / 是否巡逻终点 / 未使用
--------------------------------------------------------------------
function OnArrive_toRelated(noid, nid, fromnoid, fromnid, n, IsEndPoint, unused)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnArrive_toRelated(fromnid, fromnoid, n, IsEndPoint)
	end
end

--------------------------------------------------------------------
--事件 “OnArrivePoint”
--OnArrivePoint npc已经到达预先设定好的点
--格式 noid   / nid    
--     实例ID / 表格ID 
--------------------------------------------------------------------
function OnArrivePoint_toRelated(noid, nid, fromnoid, fromnid, x, y)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnArrivePoint_toRelated(fromnid, fromnoid, x, y)
	end
end

--------------------------------------------------------------------
--事件 “OnBeCaptured”
--OnBeCaptured 被某个玩家捕获
--格式 noid   / nid    
--     实例ID / 表格ID 
--------------------------------------------------------------------
function OnBeCaptured_toRelated(noid, nid, fromnoid, fromnid, uid)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnBeCaptured_toRelated(fromnid, fromnoid, uid)
	end
end

--------------------------------------------------------------------
--事件 “OnHpLower”
--OnHpLower npc血量低到某一个百分比触发，只触发一次
--格式  noid  /   nid  /   rate
--     实例ID / 表格ID / 血量百分比
--------------------------------------------------------------------
function OnHpLower_toRelated(noid, nid, fromnoid, fromnid, rate)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnHpLower_toRelated(fromnid, fromnoid, rate)
	end
end

--------------------------------------------------------------------
--OnTalk : 指npc开口说话，与OnInteractive不同
--格式 noid   / nid    /   dwNow 
--     实例ID / 表格ID / 当前时间
--------------------------------------------------------------------
function OnTalk_toRelated(noid, nid, fromnoid, fromnid, dwNow)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnTalk_toRelated(fromnid, fromnoid, dwNow)
	end
end

--------------------------------------------------------------------
--OnInteractive 与npc交互的函数，指弹出对话框之类的交互，与OnTalk不同
--uid: int (user object id)
--nid: int (npc id)
--event: string
--返回值 string
--------------------------------------------------------------------
function OnInteractive_toRelated(noid, nid, fromnoid, fromnid, uid, event)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnInteractive_toRelated(fromnid, fromnoid, uid, event)
	end
end

--------------------------------------------------------------------
--OnTaskAccept : 接受任务触发
--格式 noid   / nid    /   uid   / taskid
--     实例ID / 表格ID / 玩家id  / 接受的任务id
--------------------------------------------------------------------
function OnTaskAccept_toRelated(noid, nid, fromnoid, fromnid, uid, taskid)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnTaskAccept_toRelated(fromnid, fromnoid, uid, taskid)
	end
end

--------------------------------------------------------------------
--OnTaskFinish : 完成任务触发
--格式 noid   / nid    /   uid   / taskid
--     实例ID / 表格ID / 玩家id  / 完成的任务id
--------------------------------------------------------------------
function OnTaskFinish_toRelated(noid, nid, fromnoid, fromnid, uid, taskid)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnTaskFinish_toRelated(fromnid, fromnoid, uid, taskid)
	end
end

--------------------------------------------------------------------
--OnSpecialState : 进入特殊状态触发
--格式 noid   / nid    /   dwNow 
--     实例ID / 表格ID / 当前时间
--------------------------------------------------------------------
function OnSpecialState_toRelated(noid, nid, fromnoid, fromnid, dwNow)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnSpecialState_toRelated(fromnid, fromnoid, dwNow)
	end
end

--------------------------------------------------------------------
--事件 “OnOpen”
--格式 noid   / nid    /   
--     实例ID / 表格ID /   
--------------------------------------------------------------------
function OnOpen_toRelated(noid, nid, fromnoid, fromnid)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnOpen_toRelated(fromnid, fromnoid)
	end
end

--------------------------------------------------------------------
--事件 “OnClose”
--格式 noid   / nid    /   
--     实例ID / 表格ID /   
--------------------------------------------------------------------
function OnClose_toRelated(noid, nid, fromnoid, fromnid)
	local ai = CreateAI(nid, noid)
	if ai then
		ai:OnClose_toRelated(fromnid, fromnoid)
	end
end
