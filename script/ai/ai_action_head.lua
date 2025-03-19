
include("script/lua_class_inc.lua")

--[[
function Dim(var, init)
	rawset(_G, var, init or false)
end

setmetatable(_G, { __newindex = function(_, n) OutputLog("试图写一个未声明的全局变量"..n) end, 
				   __index = function(_, n) OutputLog("试图读一个未声明的全局变量"..n) end
				 }
			)

--]]
--------------------------------------------------------------------
--字符串替换函数  将$USER_NAME替换为玩家名字
--src：源字符串
--uid：user 实例ID
--------------------------------------------------------------------
function ReplaceUserName(src, uid)
	local username = GetUserNameByObjId(uid)
	return string.gsub(src, "$USER_NAME",  username)
end

--------------------------------------------------------------------
--字符串替换函数  将$NPC_OBJID替换为npc object id
--src：源字符串
--noid：npc 实例ID
--------------------------------------------------------------------
function ReplaceNpcObjId(src, noid)
	return string.gsub(src, "$NPC_OBJID", noid)
end

-------------------------------------------------------------------------------
--所有脚本ai基类实现
-------------------------------------------------------------------------------
CAIObject = class()

function CAIObject:ctor(id, objid)
	self.ID=id
	self.ObjID=objid
end

function CAIObject:OnInteractive(userId, event)
	return ""
end

function CAIObject:OnArrive(n, IsEndPoint)
end

function CAIObject:OnDead(killer)
end

function CAIObject:OnCreate(creatorid)	
end

function CAIObject:OnArrive(n, IsEndPoint)
end

function CAIObject:OnHpLower(rate)
end

function CAIObject:OnTalk(dwNow)
end

function CAIObject:OnTaskAccept(uid, taskid)
end

function CAIObject:OnTaskFinish(uid, taskid)
end

function CAIObject:OnFirstBeAttacked(enemy)
end

function CAIObject:OnSpecialState(dwNow)
end

function CAIObject:OnUpdate(dwNow)
end

function CAIObject:OnArrivePoint(x, y)
end

function CAIObject:OnLeaveBattle()
end

function CAIObject:OnEnterBattle()
end

function CAIObject:OnRunaway(nid, noid)
end

function CAIObject:OnStartDuel(nid, noid, tar)
end

function CAIObject:OnEndDuel(nid, noid, rate, tar)
end

function CAIObject:OnOpen(nid, noid)
end

function CAIObject:OnClose(nid, noid)
end

function CAIObject:OnEnterView(tar)
end

function CAIObject:OnLeaveView(tar)
end

function CAIObject:OnBlast(dwNow)
end

function CAIObject:OnRecvDamage(nsrcid, ndamage)
end

function CAIObject:OnInteractive_toRelated(fromnid, fromnoid, uid, event)
end

function CAIObject:OnArrive_toRelated(fromnid, fromnoid, n, IsEndPoint)
end

function CAIObject:OnDead_toRelated(fromnid, fromnoid, killer)
end

function CAIObject:OnCreate_toRelated(fromnid, fromnoid, creatorid)	
end

function CAIObject:OnHpLower_toRelated(fromnid, fromnoid, rate)
end

function CAIObject:OnTalk_toRelated(fromnid, fromnoid, dwNow)
end

function CAIObject:OnTaskAccept_toRelated(fromnid, fromnoid, uid, taskid)
end

function CAIObject:OnTaskFinish_toRelated(fromnid, fromnoid, uid, taskid)
end

function CAIObject:OnFirstBeAttacked_toRelated(fromnid, fromnoid, enemy)
end

function CAIObject:OnSpecialState_toRelated(fromnid, fromnoid, dwNow)
end

function CAIObject:OnArrivePoint_toRelated(fromnid, fromnoid, x, y)
end

function CAIObject:OnOpen_toRelated(fromnid, fromnoid)
end

function CAIObject:OnClose_toRelated(fromnid, fromnoid)
end
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
--灵芝仙 id=10 的脚本ai实现
-------------------------------------------------------------------------------
CAILingZhi = class(CAIObject)

function CAILingZhi:ctor(id, objid)
	--OutputLog("ai脚本 CAILingZhi 构造完毕 by "..objid)
end

function CAILingZhi:OnInteractive(uid, event)
	local content=""

	if event=="defaulttalk" then
		content = GetFileContent("talk/npc_talk_001.xml")
		content = ReplaceUserName(content, uid)
		content = ReplaceNpcObjId(content, self.ObjID)
	elseif event=="Step2" then
		content=GetFileContent("talk/npc_talk_002.xml")
	end

	return content
end

-------------------------------------------------------------------------------
--受伤的熊猫人 id=40 的脚本ai实现
-------------------------------------------------------------------------------
CAIXiongMao = class(CAIObject)

function CAIXiongMao:ctor(id, objid)
	--OutputLog("ai脚本 CAIXiongMao 构造完毕 by "..objid)
end

function CAIXiongMao:OnInteractive(uid, event)
	local content=""

	if event=="defaulttalk" then
		content = GetFileContent("talk/npc_talk_40.xml")
	end

	return content
end

-------------------------------------------------------------------------------
--巡逻任务测试 id= 50 的脚本ai实现
-------------------------------------------------------------------------------
CAIXunluoTask50 = class(CAIObject)

function CAIXunluoTask50:ctor(id, objid)
	--OutputLog("ai脚本 CAIXunluoTask50 构造完毕 by "..objid)
end

function CAIXunluoTask50:OnInteractive(uid, event)
	local content=""

	if event=="defaulttalk" then
		content = GetFileContent("talk/npc_talk_1000.xml")
		content = ReplaceUserName(content, uid)
	end

	return content
end

function CAIXunluoTask50:OnHpLower(rate)
	if rate<=20 then
		Say(self.ObjID, Lan("msg_script_143_onhplower_0"))
	elseif rate>20 and rate<=40 then
		Say(self.ObjID, Lan("msg_script_143_onhplower_20"))
	elseif rate>40 and rate<=60 then
		Say(self.ObjID, Lan("msg_script_143_onhplower_40"))
	elseif rate>60 and rate<80 then
		Say(self.ObjID, Lan("msg_script_143_onhplower_60"))
	end
end

function CAIXunluoTask50:OnTaskAccept(uid, taskid)
	local name = GetUserNameByObjId(uid)
	Say(self.ObjID, name..Lan("msg_script_143_ontaskaccept"))
	LockInteractive(self.ObjID)
	ActivePatrol(self.ObjID)
end

function CAIXunluoTask50:OnArrive(n, IsEndPoint)
	if IsEndPoint==1 then
		Say(self.ObjID, Lan("msg_script_143_onarrive"))
		if CheckDoingTask(self.ObjID)~=0 then
			FinishTask(self.ObjID)
			UnLockInteractive(self.ObjID)
		end
		DisActivePatrol(self.ObjID)
	end
	
	if n==2 then
		Say(self.ObjID, Lan("msg_script_143_onarrive_2"))
		CreateMyEnemy(self.ObjID, 2, 80, 3)
		GotoState(self.ObjID, "Wait")
	elseif n==3 then
		Say(self.ObjID, Lan("msg_script_143_onarrive_3"))
		CreateMyEnemy(self.ObjID, 2, 80, 3)
		GotoState(self.ObjID, "Wait")
	elseif n==4 then
		Say(self.ObjID, Lan("msg_script_143_onarrive_4"))
		CreateMyEnemy(self.ObjID, 2, 80, 3)
		GotoState(self.ObjID, "Wait")
	end
end

function CAIXunluoTask50:OnDead(killer)
	if CheckDoingTask(self.ObjID)~=0 then
		Say(self.ObjID, Lan("msg_script_143_ondead"))
		TaskFailed(self.ObjID)
	end
end

-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
--巡逻任务测试 id= 254 的脚本ai实现
-------------------------------------------------------------------------------
CAIBaoHuTask156 = class(CAIObject)

function CAIBaoHuTask156:ctor(id, objid)
	--OutputLog("ai脚本 CAIBaoHuTask156 构造完毕 by "..objid)
end

function CAIBaoHuTask156:OnInteractive(uid, event)
	local content=""

	if event=="defaulttalk" then
		content = GetFileContent("talk/npc_talk_1000.xml")
		content = ReplaceUserName(content, uid)
	end

	return content
end

function CAIBaoHuTask156:OnHpLower(rate)
	if rate<=20 then
		Say(self.ObjID, Lan("msg_script_254_onhplower_20"))
	elseif rate>20 and rate<=40 then
		Say(self.ObjID, Lan("msg_script_254_onhplower_40"))
	elseif rate>40 and rate<=60 then
		Say(self.ObjID, Lan("msg_script_254_onhplower_60"))
	elseif rate>60 and rate<80 then
		Say(self.ObjID, Lan("msg_script_254_onhplower_80"))
	end
end

function CAIBaoHuTask156:OnTaskAccept(uid, taskid)
	local name = GetUserNameByObjId(uid)
	Say(self.ObjID, name..Lan("msg_script_254_ontaskaccept"))
	LockInteractive(self.ObjID)
	ActivePatrol(self.ObjID)
end

function CAIBaoHuTask156:OnArrive(n, IsEndPoint)
	
	if IsEndPoint==1 then
		Say(self.ObjID, Lan("msg_script_254_onarrive"))
		if CheckDoingTask(self.ObjID)~=0 then
			FinishTask(self.ObjID)
			UnLockInteractive(self.ObjID)
		end
		DisActivePatrol(self.ObjID)
		Disappear(self.ObjID)
	end
	
	local rnd = math.random(2)
	
	if n==11 then
		Say(self.ObjID, Lan("msg_script_254_onarrive_5"))
		CreateMyEnemy(self.ObjID, 250, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID, 0, 80, 1)
		end
		GotoState(self.ObjID, "Wait")
	elseif n==20 then
		Say(self.ObjID, Lan("msg_script_254_onarrive_14"))
		CreateMyEnemy(self.ObjID, 250, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID, 434, 80, 1)
		end
		GotoState(self.ObjID, "Wait")
	elseif n==25 then
		Say(self.ObjID, Lan("msg_script_254_onarrive_19"))
		CreateMyEnemy(self.ObjID, 250, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID, 0, 80, 1)
		end
		GotoState(self.ObjID, "Wait")
	elseif n==29then
		Say(self.ObjID, Lan("msg_script_254_onarrive_23"))
		CreateMyEnemy(self.ObjID, 250, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID, 0, 80, 1)
		end
		GotoState(self.ObjID, "Wait")

	elseif n==26 then
		Say(self.ObjID, Lan("msg_script_254_onarrive_26"))
		CreateMyEnemy(self.ObjID, 250, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,434, 80, 1)
		end
		GotoState(self.ObjID, "Wait")

	end
end

function CAIBaoHuTask156:OnDead(killer)
	if CheckDoingTask(self.ObjID)~=0 then
		Say(self.ObjID, Lan("msg_script_254_ondead"))
		TaskFailed(self.ObjID)
	end
end

-------------------------------------------------------------------------------
--巡逻任务测试 id= 98 的脚本ai实现
-------------------------------------------------------------------------------
CAIBaoHuTask166 = class(CAIObject)

function CAIBaoHuTask166:ctor(id, objid)
	--OutputLog("ai脚本 CAIBaoHuTask166 构造完毕 by "..objid)
end

function CAIBaoHuTask166:OnInteractive(uid, event)
	local content=""

	if event=="defaulttalk" then
		content = GetFileContent("talk/npc_talk_1000.xml")
		content = ReplaceUserName(content, uid)
	end

	return content
end

function CAIBaoHuTask166:OnHpLower(rate)
	if rate<=20 then
		Say(self.ObjID, Lan("msg_script_98_onhplower_0"))
	elseif rate>20 and rate<=40 then
		Say(self.ObjID, Lan("msg_script_98_onhplower_20"))
	elseif rate>40 and rate<=60 then
		Say(self.ObjID, Lan("msg_script_98_onhplower_40"))
	elseif rate>60 and rate<80 then
		Say(self.ObjID, Lan("msg_script_98_onhplower_60"))
	elseif rate>80 and rate<100 then
		Say(self.ObjID, Lan("msg_script_98_onhplower_80"))
	end
end

function CAIBaoHuTask166:OnTaskAccept(uid, taskid)
	local name = GetUserNameByObjId(uid)
	Say(self.ObjID, name..Lan("msg_script_98_ontaskaccept"))
	LockInteractive(self.ObjID)
	ActivePatrol(self.ObjID)
end

function CAIBaoHuTask166:OnArrive(n, IsEndPoint)
	if IsEndPoint==1 then
		Say(self.ObjID, Lan("msg_script_98_onarrive"))
		if CheckDoingTask(self.ObjID)~=0 then
			FinishTask(self.ObjID)
			UnLockInteractive(self.ObjID)
		end
		DisActivePatrol(self.ObjID)
		Disappear(self.ObjID)
	end

	local rnd = math.random(2)
	
	if n==10 then
		Say(self.ObjID, Lan("msg_script_98_onarrive_4"))
		CreateMyEnemy(self.ObjID, 243, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,0, 80, 1)
		end
		GotoState(self.ObjID, "Wait")

	elseif n==13 then
		Say(self.ObjID, Lan("msg_script_98_onarrive_7"))
		CreateMyEnemy(self.ObjID, 243, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,0, 80, 1)
		end
		GotoState(self.ObjID, "Wait")

	elseif n==18 then
		Say(self.ObjID, Lan("msg_script_98_onarrive_12"))
		CreateMyEnemy(self.ObjID, 243, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,435, 80, 1)
		end
		GotoState(self.ObjID, "Wait")
	elseif n==24 then
		Say(self.ObjID, Lan("msg_script_98_onarrive_17"))
		CreateMyEnemy(self.ObjID, 243, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,0, 80, 1)
		end
		GotoState(self.ObjID, "Wait")
	elseif n==29 then
		Say(self.ObjID, Lan("msg_script_98_onarrive_23"))
		CreateMyEnemy(self.ObjID, 243, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,435, 80, 1)
		end
		GotoState(self.ObjID, "Wait")


	end
end

function CAIBaoHuTask166:OnDead(killer)
	if CheckDoingTask(self.ObjID)~=0 then
		Say(self.ObjID, Lan("msg_script_98_ondead"))
		TaskFailed(self.ObjID)
	end
end

-------------------------------------------------------------------------------
--巡逻任务测试 id= 436 的脚本ai实现
-------------------------------------------------------------------------------
CAIBaoHuTask301 = class(CAIObject)

function CAIBaoHuTask301:ctor(id, objid)
	--OutputLog("ai脚本 CAIBaoHuTask301 构造完毕 by "..objid)
end

function CAIBaoHuTask301:OnInteractive(uid, event)
	local content=""

	if event=="defaulttalk" then
		content = GetFileContent("talk/npc_talk_1000.xml")
		content = ReplaceUserName(content, uid)
	end

	return content
end

function CAIBaoHuTask301:OnHpLower(rate)
	if rate<=20 then
		Say(self.ObjID, Lan("msg_script_436_onhplower_0"))
	elseif rate>20 and rate<=40 then
		Say(self.ObjID, Lan("msg_script_436_onhplower_20"))
	elseif rate>40 and rate<=60 then
		Say(self.ObjID, Lan("msg_script_436_onhplower_40"))
	elseif rate>60 and rate<80 then
		Say(self.ObjID, Lan("msg_script_436_onhplower_60"))
	elseif rate>80 and rate<100 then
		Say(self.ObjID, Lan("msg_script_436_onhplower_80"))

	end
end

function CAIBaoHuTask301:OnTaskAccept(uid, taskid)
	local name = GetUserNameByObjId(uid)
	Say(self.ObjID, name..Lan("msg_script_436_ontaskaccept"))
	LockInteractive(self.ObjID)
	ActivePatrol(self.ObjID)
end

function CAIBaoHuTask301:OnArrive(n, IsEndPoint)
	if IsEndPoint==1 then
		Say(self.ObjID, Lan("msg_script_436_onarrive"))
		if CheckDoingTask(self.ObjID)~=0 then
			FinishTask(self.ObjID)
			UnLockInteractive(self.ObjID)
		end
		DisActivePatrol(self.ObjID)
		Disappear(self.ObjID)
	end

	local rnd = math.random(2)
	
	if n==10 then
		Say(self.ObjID, Lan("msg_script_436_onarrive_4"))
		CreateMyEnemy(self.ObjID, 438, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,0, 80, 1)
		end
		GotoState(self.ObjID, "Wait")

	elseif n==13 then
		Say(self.ObjID, Lan("msg_script_436_onarrive_7"))
		CreateMyEnemy(self.ObjID, 438, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,0, 80, 1)
		end
		GotoState(self.ObjID, "Wait")

	elseif n==17 then
		Say(self.ObjID, Lan("msg_script_436_onarrive_11"))
		CreateMyEnemy(self.ObjID, 438, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,437, 80, 1)
		end
		GotoState(self.ObjID, "Wait")
	elseif n==23 then
		Say(self.ObjID, Lan("msg_script_436_onarrive_17"))
		CreateMyEnemy(self.ObjID, 438, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,0, 80, 1)
		end
		GotoState(self.ObjID, "Wait")
	elseif n==29 then
		Say(self.ObjID, Lan("msg_script_436_onarrive_23"))
		CreateMyEnemy(self.ObjID, 438, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,437, 80, 1)
		end
		GotoState(self.ObjID, "Wait")


	end
end

function CAIBaoHuTask301:OnDead(killer)
	if CheckDoingTask(self.ObjID)~=0 then
		Say(self.ObjID, Lan("msg_script_436_ondead"))
		TaskFailed(self.ObjID)
	end
end
-------------------------------------------------------------------------------
--捕捉任务测试 id= 244 的脚本ai实现
-------------------------------------------------------------------------------
CAI_244 = class(CAIObject)

function CAI_244:ctor(id, objid)
	--OutputLog("ai脚本 CAIBuZhuoTask710 构造完毕 by "..objid)
end

function CAI_244:OnBeCaptured(uid)
	Say(self.ObjID, Lan("msg_script_118_onbecaptured"))
	if CheckDoingTask(self.ObjID)~=0 then
		FinishTask(self.ObjID)
	end
end

function CAI_244:OnArrivePoint(x, y)
	Say(self.ObjID, Lan("msg_script_118_onarrive"))
	UnderlingLeave(self.ObjID)
	Disappear(self.ObjID)
end


-------------------------------------------------------------------------------
--捕捉任务测试 id= 3411 的脚本ai实现
-------------------------------------------------------------------------------
CAIBuZhuoTask710 = class(CAIObject)

function CAIBuZhuoTask710:ctor(id, objid)
	--OutputLog("ai脚本 CAIBuZhuoTask710 构造完毕 by "..objid)
end

function CAIBuZhuoTask710:OnBeCaptured(uid)
	Say(self.ObjID, Lan("msg_script_118_onbecaptured"))
	if CheckDoingTask(self.ObjID)~=0 then
		FinishTask(self.ObjID)
	end
end

function CAIBuZhuoTask710:OnArrivePoint(x, y)
	Say(self.ObjID, Lan("msg_script_118_onarrive"))
	UnderlingLeave(self.ObjID)
	Disappear(self.ObjID)
end

-------------------------------------------------------------------------------
--捕捉任务测试 id= 3118 的脚本ai实现
-------------------------------------------------------------------------------
CAIBuZhuoTask561 = class(CAIObject)

function CAIBuZhuoTask561:ctor(id, objid)
	--OutputLog("ai脚本 CAIBuZhuoTask561 构造完毕 by "..objid)
end

function CAIBuZhuoTask561:OnBeCaptured(uid)
	Say(self.ObjID, Lan("msg_script_118_onbecaptured"))
	if CheckDoingTask(self.ObjID)~=0 then
		FinishTask(self.ObjID)
	end
end

function CAIBuZhuoTask561:OnArrivePoint(x, y)
	Say(self.ObjID, Lan("msg_script_118_onarrive"))
	UnderlingLeave(self.ObjID)
	Disappear(self.ObjID)
end

-------------------------------------------------------------------------------
--巡逻任务测试 id= 4417 的脚本ai实现
-------------------------------------------------------------------------------
CAIBaoHuTask1188= class(CAIObject)

function CAIBaoHuTask1188:ctor(id, objid)
	--OutputLog("ai脚本 CAIBaoHuTask1188 构造完毕 by "..objid)
end

function CAIBaoHuTask1188:OnInteractive(uid, event)
	local content=""

	if event=="defaulttalk" then
		content = GetFileContent("talk/npc_talk_1000.xml")
		content = ReplaceUserName(content, uid)
	end

	return content
end

function CAIBaoHuTask1188:OnHpLower(rate)
	if rate<=20 then
		Say(self.ObjID, Lan("msg_script_4417_onhplower_0"))
	elseif rate>20 and rate<=40 then
		Say(self.ObjID, Lan("msg_script_4417_onhplower_20"))
	elseif rate>40 and rate<=60 then
		Say(self.ObjID, Lan("msg_script_4417_onhplower_40"))
	elseif rate>60 and rate<80 then
		Say(self.ObjID, Lan("msg_script_4417_onhplower_60"))
	elseif rate>80 and rate<100 then
		Say(self.ObjID, Lan("msg_script_4417_onhplower_80"))

	end
end

function CAIBaoHuTask1188:OnTaskAccept(uid, taskid)
	local name = GetUserNameByObjId(uid)
	Say(self.ObjID, name..Lan("msg_script_4417_ontaskaccept"))
	LockInteractive(self.ObjID)
	ActivePatrol(self.ObjID)
end

function CAIBaoHuTask1188:OnArrive(n, IsEndPoint)
	if IsEndPoint==1 then
		Say(self.ObjID, Lan("msg_script_4417_onarrive"))
		if CheckDoingTask(self.ObjID)~=0 then
			FinishTask(self.ObjID)
			UnLockInteractive(self.ObjID)
		end
		DisActivePatrol(self.ObjID)
		Disappear(self.ObjID)
	end
end
	
function CAIBaoHuTask1188:OnDead(killer)
	if CheckDoingTask(self.ObjID)~=0 then
		Say(self.ObjID, Lan("msg_script_4417_ondead"))
		TaskFailed(self.ObjID)
	end
end

-------------------------------------------------------------------------------
--巡逻任务测试 id= 4504 的脚本ai实现
-------------------------------------------------------------------------------
CAIBaoHuTask1231 = class(CAIObject)

function CAIBaoHuTask1231:ctor(id, objid)
	--OutputLog("ai脚本 CAIBaoHuTask1231 构造完毕 by "..objid)
end

function CAIBaoHuTask1231:OnInteractive(uid, event)
	local content=""

	if event=="defaulttalk" then
		content = GetFileContent("talk/npc_talk_1000.xml")
		content = ReplaceUserName(content, uid)
	end

	return content
end

function CAIBaoHuTask1231:OnHpLower(rate)
	if rate<=20 then
		Say(self.ObjID, Lan("msg_script_4504_onhplower_0"))
	elseif rate>20 and rate<=40 then
		Say(self.ObjID, Lan("msg_script_4504_onhplower_20"))
	elseif rate>40 and rate<=60 then
		Say(self.ObjID, Lan("msg_script_4504_onhplower_40"))
	elseif rate>60 and rate<80 then
		Say(self.ObjID, Lan("msg_script_4504_onhplower_60"))
	elseif rate>80 and rate<100 then
		Say(self.ObjID, Lan("msg_script_4504_onhplower_80"))

	end
end

function CAIBaoHuTask1231:OnTaskAccept(uid, taskid)
	local name = GetUserNameByObjId(uid)
	Say(self.ObjID, name..Lan("msg_script_4504_ontaskaccept"))
	LockInteractive(self.ObjID)
	ActivePatrol(self.ObjID)
end

function CAIBaoHuTask1231:OnArrive(n, IsEndPoint)
	if IsEndPoint==1 then
		Say(self.ObjID, Lan("msg_script_4504_onarrive"))
		if CheckDoingTask(self.ObjID)~=0 then
			FinishTask(self.ObjID)
			UnLockInteractive(self.ObjID)
		end
		DisActivePatrol(self.ObjID)
		Disappear(self.ObjID)
	end

	local rnd = math.random(2)
	
	if n==4 then
		Say(self.ObjID, Lan("msg_script_4504_onarrive_4"))
		CreateMyEnemy(self.ObjID, 4462, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,0, 80, 1)
		end
		GotoState(self.ObjID, "Wait")

	elseif n==7 then
		Say(self.ObjID, Lan("msg_script_4504_onarrive_7"))
		CreateMyEnemy(self.ObjID, 4462, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,0, 80, 1)
		end
		GotoState(self.ObjID, "Wait")

	elseif n==11 then
		Say(self.ObjID, Lan("msg_script_4504_onarrive_11"))
		CreateMyEnemy(self.ObjID, 4463, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,0, 80, 1)
		end
		GotoState(self.ObjID, "Wait")
	elseif n==17 then
		Say(self.ObjID, Lan("msg_script_4504_onarrive_17"))
		CreateMyEnemy(self.ObjID, 4463, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,0, 80, 1)
		end
		GotoState(self.ObjID, "Wait")
	elseif n==23 then
		Say(self.ObjID, Lan("msg_script_4504_onarrive_23"))
		CreateMyEnemy(self.ObjID, 4463, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,0, 80, 1)
		end
		GotoState(self.ObjID, "Wait")


	end
end

function CAIBaoHuTask1231:OnDead(killer)
	if CheckDoingTask(self.ObjID)~=0 then
		Say(self.ObjID, Lan("msg_script_4504_ondead"))
		TaskFailed(self.ObjID)
	end
end
-------------------------------------------------------------------------------
--id= 174 的脚本ai实现
-------------------------------------------------------------------------------
CAI_174 = class(CAIObject)
function CAI_174:ctor(id, objid)
end

function CAI_174:OnDead(killer)
	--OutputLog("npc be killed by "..killer)
	for i=0, 2 do
		local obj = CreateNpc(self.ObjID, 175, 0, 0, 0)
		--OutputLog("npc created "..obj)
		if obj~=0 then
			AddToHateList(obj, killer, 1)
		end
	end
end

-------------------------------------------------------------------------------
--id= 176 的脚本ai实现
-------------------------------------------------------------------------------
CAI_176 = class(CAIObject)
function CAI_176:ctor(id, objid)
end

function CAI_176:OnInteractive(uid, event)	
	local content
	if event=="defaulttalk" then
		--if CheckUserDoingTask(uid, 102)==0 then
			content = GetFileContent("talk/npc_talk_176.xml")
		--else
		--	content = GetFileContent("talk/npc_talk_176_01.xml")
		--end
		content = ReplaceUserName(content, uid)
		content = ReplaceNpcObjId(content, self.ObjID)
	elseif event=="Step2" then
		content = GetFileContent("talk/npc_talk_176_02.xml")
		content = ReplaceUserName(content, uid)
		content = ReplaceNpcObjId(content, self.ObjID)
	elseif event=="Ready" then
		local id
		--id = CreateNpc(self.ObjID, 156, 429, 864, 1)
		id = CreateNpcAtMyPos(self.ObjID, 156)
		AddToHateList(id, uid, 1)
		Disappear(self.ObjID)
	end
	
	return content
end

-------------------------------------------------------------------------------
--id= 158 的脚本ai实现
-------------------------------------------------------------------------------
CAI_158 = class(CAIObject)
function CAI_158:ctor(id, objid)
	self.dwLastTalk = 0
end

function CAI_158:OnInteractive(uid, event)	
	local content
	if event=="defaulttalk" then
		self.dwLastTalk = 0
		--if CheckUserHaveItem(uid, 341)==0 then
		content = GetFileContent("talk/npc_talk_158.xml")
		--else
		--	content = GetFileContent("talk/npc_talk_158_01.xml")
		--end
		content = ReplaceUserName(content, uid)
		content = ReplaceNpcObjId(content, self.ObjID)
	elseif event=="Step2" then
		local username = GetUserNameByObjId(uid)
		Say(self.ObjID, Lan("msg_script_158_onactive_1")..username..Lan("msg_script_158_onactive_2"))
		LockInteractive(self.ObjID)
		--AddEffect(self.ObjID, self.ObjID, )
		PlayPose(self.ObjID, "effect", false)
		AddToHateList(self.ObjID, uid, 1)
		GotoState(self.ObjID, "Talk")
		ModifyAttackFlag(self.ObjID, 0)
	end
	
	return content
end

function CAI_158:OnTalk(dwNow)
	if self.dwLastTalk==0 then
		self.dwLastTalk = dwNow
		return
	elseif dwNow-self.dwLastTalk < 3 then
		return
	end
	
	Say(self.ObjID, Lan("msg_script_158_ontalk"))
	SetModel(self.ObjID, 141)
	ModifyAttackFlag(self.ObjID, 1)
	GotoState(self.ObjID, "Combat")
end

function CAI_158:OnDead(killer)
	Say(self.ObjID, Lan("msg_script_158_ondead"))
end

-------------------------------------------------------------------------------
--id= 157 的脚本ai实现
-------------------------------------------------------------------------------
CAI_157 = class(CAIObject)
function CAI_157:ctor(id, objid)
	self.iCurrNum = 0
	self.iTotalNum = 0
	self.captainId1 = 0
	self.captainId2 = 0
	self.dwLastSpecial = 0
end

function CAI_157:ResumeInit()
	self.iCurrNum = 0
	self.iTotalNum = 0
	self.captainId1 = 0
	self.captainId2 = 0
	self.dwLastSpecial = 0
end

function CAI_157:CreateMonsterGroup(uid)
	local id1
	local id2
	id1 = CreateNpc(self.ObjID, 166, 0, 0, 0)
	id2 = CreateNpc(self.ObjID, 167, 0, 0, 0)
	
	AddTeamToHateList(id1, uid, 1)
	AddTeamToHateList(id2, uid, 1)
	
	self.iTotalNum = self.iTotalNum + 1
	Say(self.ObjID, Lan("msg_script_157_onactive"))
	
	self.captainId1 = id1
	self.captainId2 = id2
end

function CAI_157:OnInteractive(uid, event)
	local content
	if event=="defaulttalk" then
		self:ResumeInit()
		content = GetFileContent("talk/npc_talk_157.xml")
		content = ReplaceUserName(content, uid)
		content = ReplaceNpcObjId(content, self.ObjID)
	elseif event=="Step2" then
		LockInteractive(self.ObjID)
		self:CreateMonsterGroup(uid)
		--GotoState("Special")
	end
	
	return content
end

function CAI_157:OnCreate_toRelated(fromnid, fromnoid, creatorid)
	if creatorid~=self.ObjID then
		OutputLog("OnCreate_toRelated Error: creatorid~=self.ObjID")
		return
	end
	
	if self.iCurrNum>=2 then
		OutputLog("OnCreate_toRelated Error: self.iCurrNum>=2")
		return
	end
	
	self.iCurrNum = self.iCurrNum + 1
	--OutputLog("OnCreate_toRelated : self.iCurrNum=="..self.iCurrNum)
end

function CAI_157:OnDead_toRelated(fromnid, fromnoid, killer)
	self.iCurrNum = self.iCurrNum - 1
	--OutputLog("OnDead_toRelated : self.iCurrNum=="..self.iCurrNum)
	if self.iCurrNum==0 then
		if self.iTotalNum>=3 then
			--OutputLog("OnDead_toRelated : self.iTotalNum=="..self.iTotalNum..", Over")
			ModifyAttackFlag(self.ObjID, 1)
			AddTeamToHateList(self.ObjID, killer, 1)
			GotoState(self.ObjID, "Combat")
			return
		end
		--OutputLog("OnDead_toRelated : self.iTotalNum=="..self.iTotalNum)
		self:CreateMonsterGroup(killer)
	end
end

function CAI_157:OnSpecialState(dwNow)
end

-------------------------------------------------------------------------------
--id= 166 的脚本ai实现
-------------------------------------------------------------------------------
CAI_166 = class(CAIObject)
function CAI_166:ctor(id, objid)
end
-------------------------------------------------------------------------------
--id= 167 的脚本ai实现
-------------------------------------------------------------------------------
CAI_167 = class(CAIObject)
function CAI_167:ctor(id, objid)
end

-------------------------------------------------------------------------------
--id= 159 的脚本ai实现
-------------------------------------------------------------------------------
CAI_159 = class(CAIObject)
function CAI_159:ctor(id, objid)
	self.dwCreatedId = {}
	for i=1,6 do
		self.dwCreatedId[i] = 0
	end
end

function CAI_159:AddChild(id)
	for i=1,6 do
		if self.dwCreatedId[i]==0 then
			self.dwCreatedId[i] = id
			return
		end
	end
end

function CAI_159:ClearChild()
	for i=1,6 do
		if self.dwCreatedId[i]~=0 then
			Disappear(self.dwCreatedId[i])
			self.dwCreatedId[i] = 0
		end
	end
end

function CAI_159:OnHpLower(rate)
	local pos = {}
	local id
	
	pos[1] = { 118, 201, 0 }
	pos[2] = { 110, 213, 0 }
	pos[3] = { 110, 189, 0 }
	
	Say(self.ObjID, Lan("msg_script_159_fenshen"))
	local rnd = math.random(3)
	SetPosition(self.ObjID, pos[rnd][1], pos[rnd][2])
	
	for i=1,3 do
		if i~=rnd then
			id = CreateNpc(self.ObjID, 181, pos[i][1], pos[i][2], pos[i][3])
			self:AddChild(id)
			SetHp(id, rate)
			CopyHateList(self.ObjID, id)
		end
	end
end

function CAI_159:OnDead(killer)
	self:ClearChild()
	CreateNpc(self.ObjID, 178, 118, 201, 12)
end

function CAI_159:OnLeaveBattle()
	self:ClearChild()
end

-------------------------------------------------------------------------------
--id= 173 的脚本ai实现
-------------------------------------------------------------------------------
CAI_173 = class(CAIObject)
function CAI_173:ctor(id, objid)
end

function CAI_173:OnCreate(creatorid)
	CreateNpc(self.ObjID, 158, 117, -141, 11)
end

function CAI_173:OnDead_toRelated(fromnid, fromnoid, killer)
	GotoState(self.ObjID, "Open")
end

-------------------------------------------------------------------------------
--id= 179 的脚本ai实现
-------------------------------------------------------------------------------
CAI_179 = class(CAIObject)
function CAI_179:ctor(id, objid)
end

function CAI_179:OnCreate(creatorid)
	CreateNpc(self.ObjID, 157, 59, 117, 8)
end

function CAI_179:OnDead_toRelated(fromnid, fromnoid, killer)
	GotoState(self.ObjID, "Open")
end

-------------------------------------------------------------------------------
--捕捉任务测试 id= 51 的脚本ai实现
-------------------------------------------------------------------------------
CAIBuZhuo51 = class(CAIObject)

function CAIBuZhuo51:ctor(id, objid)
	--OutputLog("ai脚本 CAIBuZhuo51 构造完毕 by "..objid)
end

function CAIBuZhuo51:OnBeCaptured(uid)
	Say(self.ObjID, Lan("msg_script_51_onbecaptured"))
end

function CAIBuZhuo51:OnArrivePoint(x, y)
	Say(self.ObjID, Lan("msg_script_51_onarrive"))
	if CheckDoingTask(self.ObjID)~=0 then
		FinishTask(self.ObjID)
	end
	UnderlingLeave(self.ObjID)
	Disappear(self.ObjID)
end

-------------------------------------------------------------------------------
--精英匪徒 id=267 的脚本ai实现
-------------------------------------------------------------------------------
CAI_267 = class(CAIObject)

function CAI_267:ctor(id, objid)
	--OutputLog("ai脚本 CAI_267 构造完毕 by "..objid)
end

function CAI_267:OnRunaway(nid, noid)
	Say(self.ObjID, Lan("msg_script_267_onrunaway"))
end

-------------------------------------------------------------------------------
--id= 323 的脚本ai实现
-------------------------------------------------------------------------------
CAI_323 = class(CAIObject)
function CAI_323:ctor(id, objid)
	self.iCurrNum = 0
	self.iTotalNum = 0
	self.captainId1 = 0
	self.captainId2 = 0
	self.dwLastSpecial = 0
end

function CAI_323:ResumeInit()
	self.iCurrNum = 0
	self.iTotalNum = 0
	self.captainId1 = 0
	self.captainId2 = 0
	self.dwLastSpecial = 0
end

function CAI_323:CreateMonsterGroup(uid)
	local id1
	local id2
	id1 = CreateNpc(self.ObjID, 331, 0, 0, 0)
	id2 = CreateNpc(self.ObjID, 332, 0, 0, 0)
	
	AddTeamToHateList(id1, uid, 1)
	AddTeamToHateList(id2, uid, 1)
	
	self.iTotalNum = self.iTotalNum + 1
	Say(self.ObjID, Lan("msg_script_323_onactive"))
	
	self.captainId1 = id1
	self.captainId2 = id2
end

function CAI_323:OnInteractive(uid, event)
	local content
	if event=="defaulttalk" then
		self:ResumeInit()
		content = GetFileContent("talk/npc_talk_323.xml")
		content = ReplaceUserName(content, uid)
		content = ReplaceNpcObjId(content, self.ObjID)
	elseif event=="Step2" then
		LockInteractive(self.ObjID)
		self:CreateMonsterGroup(uid)
		--GotoState("Special")
	end
	
	return content
end

function CAI_323:OnCreate_toRelated(fromnid, fromnoid, creatorid)
	if creatorid~=self.ObjID then
		OutputLog("OnCreate_toRelated Error: creatorid~=self.ObjID")
		return
	end
	
	if self.iCurrNum>=2 then
		OutputLog("OnCreate_toRelated Error: self.iCurrNum>=2")
		return
	end
	
	self.iCurrNum = self.iCurrNum + 1
	--OutputLog("OnCreate_toRelated : self.iCurrNum=="..self.iCurrNum)
end

function CAI_323:OnDead_toRelated(fromnid, fromnoid, killer)
	self.iCurrNum = self.iCurrNum - 1
	--OutputLog("OnDead_toRelated : self.iCurrNum=="..self.iCurrNum)
	if self.iCurrNum==0 then
		if self.iTotalNum>=3 then
			--OutputLog("OnDead_toRelated : self.iTotalNum=="..self.iTotalNum..", Over")
			ModifyAttackFlag(self.ObjID, 1)
			AddTeamToHateList(self.ObjID, killer, 1)
			GotoState(self.ObjID, "Combat")
			return
		end
		--OutputLog("OnDead_toRelated : self.iTotalNum=="..self.iTotalNum)
		self:CreateMonsterGroup(killer)
	end
end

function CAI_323:OnSpecialState(dwNow)
end

-------------------------------------------------------------------------------
--id= 331 的脚本ai实现
-------------------------------------------------------------------------------
CAI_331 = class(CAIObject)
function CAI_331:ctor(id, objid)
end
-------------------------------------------------------------------------------
--id= 332 的脚本ai实现
-------------------------------------------------------------------------------
CAI_332 = class(CAIObject)
function CAI_332:ctor(id, objid)
end

-------------------------------------------------------------------------------
--id= 3014 的脚本ai实现
-------------------------------------------------------------------------------
CAI_3014 = class(CAIObject)
function CAI_3014:ctor(id, objid)
	self.dwTarId = 0
end

function CAI_3014:OnInteractive(uid, event)

	local content=""

	if event=="defaulttalk" then
	
		if CheckUserDoingTask(uid, 507)==0 then
			content = GetFileContent("talk/npc_talk_3014.xml")
		else
			content = GetFileContent("talk/npc_talk_3014_01.xml")
		end

	elseif event=="duel" then
		self.dwTarId = uid
		GotoState(self.ObjID, "Duel")
		LockInteractive(self.ObjID)
	end

	return content
end

function CAI_3014:OnHpLower(rate)
	if rate<=20 then
		GotoState(self.ObjID, "Return")
	end
end

function CAI_3014:OnStartDuel(nid, noid, tar)
	SetDuelTarget(self.ObjID, self.dwTarId)
	AddToHateList_Ex(self.ObjID, self.dwTarId, 1, 0)
	Say(self.ObjID, Lan("msg_script_3014_onstartduel"))
	self.dwTarId = 0
end

function CAI_3014:OnEndDuel(nid, noid, rate, tar)
	if rate<=20 then
		Say(self.ObjID, Lan("msg_script_3014_onendduel_lost"))
		TaskNpcEndDuel(self.ObjID, tar, 0)
	else
		Say(self.ObjID, Lan("msg_script_3014_onendduel_win"))
		TaskNpcEndDuel(self.ObjID, tar, 1)
	end
end

-------------------------------------------------------------------------------
--id= 3104 的脚本ai实现
-------------------------------------------------------------------------------
CAI_3104 = class(CAIObject)
function CAI_3104:ctor(id, objid)
	self.dwTarId = 0
end

function CAI_3104:OnInteractive(uid, event)

	local content=""

	if event=="defaulttalk" then
	
		if CheckUserDoingTask(uid, 559)==0 then
			content = GetFileContent("talk/npc_talk_3104.xml")
		else
			content = GetFileContent("talk/npc_talk_3104_01.xml")
		end

	elseif event=="duel" then
		self.dwTarId = uid
		GotoState(self.ObjID, "Duel")
		LockInteractive(self.ObjID)
	end

	return content
end

function CAI_3104:OnHpLower(rate)
	if rate<=20 then
		GotoState(self.ObjID, "Return")
	end
end

function CAI_3104:OnStartDuel(nid, noid, tar)
	SetDuelTarget(self.ObjID, self.dwTarId)
	AddToHateList_Ex(self.ObjID, self.dwTarId, 1, 0)
	Say(self.ObjID, Lan("msg_script_3104_onstartduel"))
	self.dwTarId = 0
end

function CAI_3104:OnEndDuel(nid, noid, rate, tar)
	if rate<=20 then
		Say(self.ObjID, Lan("msg_script_3104_onendduel_lost"))
		TaskNpcEndDuel(self.ObjID, tar, 0)
	else
		Say(self.ObjID, Lan("msg_script_3104_onendduel_win"))
		TaskNpcEndDuel(self.ObjID, tar, 1)
	end
end

-------------------------------------------------------------------------------
--巡逻任务测试 id= 4635 的脚本ai实现
-------------------------------------------------------------------------------
CAIBaoHuTask1306 = class(CAIObject)

function CAIBaoHuTask1306:ctor(id, objid)
	--OutputLog("ai脚本 CAIBaoHuTask1306 构造完毕 by "..objid)
end

function CAIBaoHuTask1306:OnInteractive(uid, event)
	local content=""

	if event=="defaulttalk" then
		content = GetFileContent("talk/npc_talk_1000.xml")
		content = ReplaceUserName(content, uid)
	end

	return content
end

function CAIBaoHuTask1306:OnHpLower(rate)
	if rate<=20 then
		Say(self.ObjID, Lan("msg_script_4635_onhplower_0"))
	elseif rate>20 and rate<=40 then
		Say(self.ObjID, Lan("msg_script_4635_onhplower_20"))
	elseif rate>40 and rate<=60 then
		Say(self.ObjID, Lan("msg_script_4635_onhplower_40"))
	elseif rate>60 and rate<80 then
		Say(self.ObjID, Lan("msg_script_4635_onhplower_60"))
	elseif rate>80 and rate<100 then
		Say(self.ObjID, Lan("msg_script_4635_onhplower_80"))

	end
end

function CAIBaoHuTask1306:OnTaskAccept(uid, taskid)
	local name = GetUserNameByObjId(uid)
	Say(self.ObjID, name..Lan("msg_script_4635_ontaskaccept"))
	LockInteractive(self.ObjID)
	ActivePatrol(self.ObjID)
end

function CAIBaoHuTask1306:OnArrive(n, IsEndPoint)
	if IsEndPoint==1 then
		Say(self.ObjID, Lan("msg_script_4635_onarrive"))
		if CheckDoingTask(self.ObjID)~=0 then
			FinishTask(self.ObjID)
			UnLockInteractive(self.ObjID)
		end
		DisActivePatrol(self.ObjID)
		Disappear(self.ObjID)
	end

	local rnd = math.random(2)
	
	if n==4 then
		Say(self.ObjID, Lan("msg_script_4635_onarrive_4"))
		CreateMyEnemy(self.ObjID, 4636, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,0, 80, 1)
		end
		GotoState(self.ObjID, "Wait")

	elseif n==7 then
		Say(self.ObjID, Lan("msg_script_4635_onarrive_7"))
		CreateMyEnemy(self.ObjID, 4636, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,0, 80, 1)
		end
		GotoState(self.ObjID, "Wait")

	elseif n==11 then
		Say(self.ObjID, Lan("msg_script_4635_onarrive_11"))
		CreateMyEnemy(self.ObjID, 4636, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,0, 80, 1)
		end
		GotoState(self.ObjID, "Wait")
	elseif n==17 then
		Say(self.ObjID, Lan("msg_script_4635_onarrive_17"))
		CreateMyEnemy(self.ObjID, 4636, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,0, 80, 1)
		end
		GotoState(self.ObjID, "Wait")
	elseif n==23 then
		Say(self.ObjID, Lan("msg_script_4635_onarrive_23"))
		CreateMyEnemy(self.ObjID, 4636, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,0, 80, 1)
		end
		GotoState(self.ObjID, "Wait")


	end
end

function CAIBaoHuTask1231:OnDead(killer)
	if CheckDoingTask(self.ObjID)~=0 then
		Say(self.ObjID, Lan("msg_script_4635_ondead"))
		TaskFailed(self.ObjID)
	end
end


-------------------------------------------------------------------------------
--巡逻任务测试 id= 4695 的脚本ai实现
-------------------------------------------------------------------------------
CAIBaoHuTask805 = class(CAIObject)

function CAIBaoHuTask805:ctor(id, objid)
	--OutputLog("ai脚本 CAIBaoHuTask1306 构造完毕 by "..objid)
end

function CAIBaoHuTask805:OnInteractive(uid, event)
	local content=""

	if event=="defaulttalk" then
		content = GetFileContent("talk/npc_talk_1000.xml")
		content = ReplaceUserName(content, uid)
	end

	return content
end

function CAIBaoHuTask805:OnHpLower(rate)
	if rate<=20 then
		Say(self.ObjID, Lan("msg_script_4695_onhplower_0"))
	elseif rate>20 and rate<=40 then
		Say(self.ObjID, Lan("msg_script_4695_onhplower_20"))
	elseif rate>40 and rate<=60 then
		Say(self.ObjID, Lan("msg_script_4695_onhplower_40"))
	elseif rate>60 and rate<80 then
		Say(self.ObjID, Lan("msg_script_4695_onhplower_60"))
	elseif rate>80 and rate<100 then
		Say(self.ObjID, Lan("msg_script_4695_onhplower_80"))

	end
end

function CAIBaoHuTask805:OnTaskAccept(uid, taskid)
	local name = GetUserNameByObjId(uid)
	Say(self.ObjID, name..Lan("msg_script_4695_ontaskaccept"))
	LockInteractive(self.ObjID)
	ActivePatrol(self.ObjID)
end

function CAIBaoHuTask805:OnArrive(n, IsEndPoint)
	if IsEndPoint==1 then
		Say(self.ObjID, Lan("msg_script_4695_onarrive"))
		if CheckDoingTask(self.ObjID)~=0 then
			FinishTask(self.ObjID)
			UnLockInteractive(self.ObjID)
		end
		DisActivePatrol(self.ObjID)
		Disappear(self.ObjID)
	end

	local rnd = math.random(2)
	
	if n==10 then
		Say(self.ObjID, Lan("msg_script_4695_onarrive_6"))
		CreateMyEnemy(self.ObjID, 20, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,20, 80, 1)
		end
		GotoState(self.ObjID, "Wait")

	elseif n==14 then
		Say(self.ObjID, Lan("msg_script_4695_onarrive_9"))
		CreateMyEnemy(self.ObjID, 20, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,20, 80, 1)
		end
		GotoState(self.ObjID, "Wait")

	elseif n==18then
		Say(self.ObjID, Lan("msg_script_4695_onarrive_13"))
		CreateMyEnemy(self.ObjID, 20, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,20, 80, 1)
		end
		GotoState(self.ObjID, "Wait")
	elseif n==24 then
		Say(self.ObjID, Lan("msg_script_4695_onarrive_18"))
		CreateMyEnemy(self.ObjID, 20, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,20, 80, 1)
		end
		GotoState(self.ObjID, "Wait")
	elseif n==30 then
		Say(self.ObjID, Lan("msg_script_4695_onarrive_24"))
		CreateMyEnemy(self.ObjID, 20, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,20, 80, 1)
		end
		GotoState(self.ObjID, "Wait")


	end
end

function CAIBaoHuTask805:OnDead(killer)
	if CheckDoingTask(self.ObjID)~=0 then
		Say(self.ObjID, Lan("msg_script_4695_ondead"))
		TaskFailed(self.ObjID)
	end
end

-------------------------------------------------------------------------------
--id= 3209 的脚本ai实现
-------------------------------------------------------------------------------
CAI_3209 = class(CAIObject)
function CAI_3209:ctor(id, objid)
	self.dwTarId = 0
end

function CAI_3209:OnInteractive(uid, event)

	local content=""

	if event=="defaulttalk" then
	
		if CheckUserDoingTask(uid, 605)==0 then
			content = GetFileContent("talk/npc_talk_3209.xml")
		else
			content = GetFileContent("talk/npc_talk_3209_01.xml")
		end

	elseif event=="duel" then
		self.dwTarId = uid
		GotoState(self.ObjID, "Duel")
		LockInteractive(self.ObjID)
	end

	return content
end

function CAI_3209:OnHpLower(rate)
	if rate<=20 then
		GotoState(self.ObjID, "Return")
	end
end

function CAI_3209:OnStartDuel(nid, noid, tar)
	SetDuelTarget(self.ObjID, self.dwTarId)
	AddToHateList_Ex(self.ObjID, self.dwTarId, 1, 0)
	Say(self.ObjID, Lan("msg_script_3209_onstartduel"))
	self.dwTarId = 0
end

function CAI_3209:OnEndDuel(nid, noid, rate, tar)
	if rate<=20 then
		Say(self.ObjID, Lan("msg_script_3209_onendduel_lost"))
		TaskNpcEndDuel(self.ObjID, tar, 0)
	else
		Say(self.ObjID, Lan("msg_script_3209_onendduel_win"))
		TaskNpcEndDuel(self.ObjID, tar, 1)
	end
end

-------------------------------------------------------------------------------
--id= 3314 的脚本ai实现
-------------------------------------------------------------------------------
CAI_3314 = class(CAIObject)
function CAI_3314:ctor(id, objid)
	self.dwTarId = 0
end

function CAI_3314:OnInteractive(uid, event)

	local content=""

	if event=="defaulttalk" then
	
		if CheckUserDoingTask(uid, 657)==0 then
			content = GetFileContent("talk/npc_talk_3314.xml")
		else
			content = GetFileContent("talk/npc_talk_3314_01.xml")
		end

	elseif event=="duel" then
		self.dwTarId = uid
		GotoState(self.ObjID, "Duel")
		LockInteractive(self.ObjID)
	end

	return content
end

function CAI_3314:OnHpLower(rate)
	if rate<=20 then
		GotoState(self.ObjID, "Return")
	end
end

function CAI_3314:OnStartDuel(nid, noid, tar)
	SetDuelTarget(self.ObjID, self.dwTarId)
	AddToHateList_Ex(self.ObjID, self.dwTarId, 1, 0)
	Say(self.ObjID, Lan("msg_script_3314_onstartduel"))
	self.dwTarId = 0
end

function CAI_3314:OnEndDuel(nid, noid, rate, tar)
	if rate<=20 then
		Say(self.ObjID, Lan("msg_script_3314_onendduel_lost"))
		TaskNpcEndDuel(self.ObjID, tar, 0)
	else
		Say(self.ObjID, Lan("msg_script_3314_onendduel_win"))
		TaskNpcEndDuel(self.ObjID, tar, 1)
	end
end

-------------------------------------------------------------------------------
--id= 2905 的脚本ai实现
-------------------------------------------------------------------------------
CAI_2905 = class(CAIObject)
function CAI_2905:ctor(id, objid)
end

function CAI_2905:OnCreate(creatorid)
	RegCityDoor(self.ObjID, 1)
end

-------------------------------------------------------------------------------
--id= 2914 的脚本ai实现
-------------------------------------------------------------------------------
CAI_2914 = class(CAIObject)
function CAI_2914:ctor(id, objid)
end

function CAI_2914:OnInteractive(uid, event)

	local content=""
	local content_t=""

	if event=="defaulttalk" then
	
		local wid = 0
		wid = GetNpcHome(self.ObjID)
		
		content = GetFileContent("talk/npc_talk_2914.xml")
	
		if CanTransDefender(wid)==1 and IsDefender(uid, wid)==1 then
			content = GetFileContent("talk/npc_talk_2914_2.xml")
			content_t = GetTrafficStr(self.ObjID, uid)
		elseif IsMasterGuild(uid, wid)==1 then
			content = GetFileContent("talk/npc_talk_2914_2.xml")
			content_t = GetTrafficStr(self.ObjID, uid)
		end
		
		content = content..content_t

	end

	return content
end

-------------------------------------------------------------------------------
--id= 2915 的脚本ai实现
-------------------------------------------------------------------------------
CAI_2915 = class(CAIObject)
function CAI_2915:ctor(id, objid)
end

function CAI_2915:OnInteractive(uid, event)

	local content=""
	local content_t=""

	if event=="defaulttalk" then
	
		local wid = 0
		wid = GetNpcHome(self.ObjID)
		
		content = GetFileContent("talk/npc_talk_2915.xml")
		content_t = GetTrafficStr(self.ObjID, uid)
		
		content = content..content_t

	end

	return content
end

-------------------------------------------------------------------------------
--id= 2916 的脚本ai实现
-------------------------------------------------------------------------------
CAI_2916 = class(CAIObject)
function CAI_2916:ctor(id, objid)
end

function CAI_2916:OnInteractive(uid, event)

	local content=""
	local content_t=""

	if event=="defaulttalk" then
	
		local wid = 0
		wid = GetNpcHome(self.ObjID)
		
		content = GetFileContent("talk/npc_talk_2917.xml")
		
		if IsMasterGuild(uid, wid)==1 then	
			content = GetFileContent("talk/npc_talk_2916.xml")
			content_t = GetTrafficStr(self.ObjID, uid)
		end

		content = content..content_t

	end

	return content
end

-------------------------------------------------------------------------------
--id= 2917 的脚本ai实现
-------------------------------------------------------------------------------
CAI_2917 = class(CAIObject)
function CAI_2917:ctor(id, objid)
end

function CAI_2917:OnInteractive(uid, event)

	local content=""
	local content_t=""

	if event=="defaulttalk" then
	
		local wid = 0
		wid = GetNpcHome(self.ObjID)
		
		content = GetFileContent("talk/npc_talk_2917.xml")
	
		if IsMasterGuild(uid, wid)==1 then
			content = GetFileContent("talk/npc_talk_2917_2.xml")
			content_t = GetTrafficStr(self.ObjID, uid)
		end
		
		content = content..content_t

	end

	return content
end

-------------------------------------------------------------------------------
--id= 2918 的脚本ai实现
-------------------------------------------------------------------------------
CAI_2918 = class(CAIObject)
function CAI_2918:ctor(id, objid)
end

function CAI_2918:OnInteractive(uid, event)

	local content=""
	local content_t=""

	if event=="defaulttalk" then
	
		local wid = 0
		wid = GetNpcHome(self.ObjID)
		
		content = GetFileContent("talk/npc_talk_2918.xml")
	
		if CanTransDefender(wid)==1 and IsDefender(uid, wid)==1 then
			content = GetFileContent("talk/npc_talk_2918_2.xml")
			content_t = GetTrafficStr(self.ObjID, uid)
		elseif IsMasterGuild(uid, wid)==1 then
			content = GetFileContent("talk/npc_talk_2918_2.xml")
			content_t = GetTrafficStr(self.ObjID, uid)
		end
		
		content = content..content_t

	end

	return content
end

-------------------------------------------------------------------------------
--id= 2919 的脚本ai实现
-------------------------------------------------------------------------------
CAI_2919 = class(CAIObject)
function CAI_2919:ctor(id, objid)
end

function CAI_2919:OnInteractive(uid, event)

	local content=""
	local content_t=""

	if event=="defaulttalk" then
	
		local wid = 0
		wid = GetNpcHome(self.ObjID)
		
		content = GetFileContent("talk/npc_talk_2919.xml")
	
		if CanTransDefender(wid)==1 and IsDefender(uid, wid)==1 then
			content = GetFileContent("talk/npc_talk_2919_2.xml")
			content_t = GetTrafficStr(self.ObjID, uid)
		elseif IsMasterGuild(uid, wid)==1 then
			content = GetFileContent("talk/npc_talk_2919_2.xml")
			content_t = GetTrafficStr(self.ObjID, uid)
		end
		
		content = content..content_t

	end

	return content
end

-------------------------------------------------------------------------------
--id= 4632 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4632 = class(CAIObject)
function CAI_4632:ctor(id, objid)
end

function CAI_4632:OnDead(killer)
	local id
	for i=1, 1 do
		id = CreateNpc(self.ObjID, 4573, 0, 0, 0)
		AddToHateList(id, killer, 1)
	end
end

-------------------------------------------------------------------------------
--id= 4584 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4584 = class(CAIObject)
function CAI_4584:ctor(id, objid)
	self.dwTarId = 0
end

function CAI_4584:OnInteractive(uid, event)

	local content=""

	if event=="defaulttalk" then
	
		if CheckUserDoingTask(uid, 1264)==0 then
			content = GetFileContent("talk/npc_talk_4584.xml")
		else
			content = GetFileContent("talk/npc_talk_4584_01.xml")
		end

	elseif event=="duel" then
		self.dwTarId = uid
		GotoState(self.ObjID, "Duel")
		LockInteractive(self.ObjID)
	end

	return content
end

function CAI_4584:OnHpLower(rate)
	if rate<=5 then
		GotoState(self.ObjID, "Return")
	end
end

function CAI_4584:OnStartDuel(nid, noid, tar)
	SetDuelTarget(self.ObjID, self.dwTarId)
	AddToHateList_Ex(self.ObjID, self.dwTarId, 1, 0)
	Say(self.ObjID, Lan("msg_script_4584_onstartduel"))
	self.dwTarId = 0
end

function CAI_4584:OnEndDuel(nid, noid, rate, tar)
	if rate<=5 then
		Say(self.ObjID, Lan("msg_script_4584_onendduel_lost"))
		TaskNpcEndDuel(self.ObjID, tar, 0)
	else
		Say(self.ObjID, Lan("msg_script_4584_onendduel_win"))
		TaskNpcEndDuel(self.ObjID, tar, 1)
	end
end

-------------------------------------------------------------------------------
--id= 4591 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4591 = class(CAIObject)
function CAI_4591:ctor(id, objid)
	self.dwTarId = 0
end

function CAI_4591:OnInteractive(uid, event)

	local content=""

	if event=="defaulttalk" then
	
		if CheckUserDoingTask(uid, 1279)==0 then
			content = GetFileContent("talk/npc_talk_4591.xml")
		else
			content = GetFileContent("talk/npc_talk_4591_01.xml")
		end

	elseif event=="duel" then
		self.dwTarId = uid
		GotoState(self.ObjID, "Duel")
		LockInteractive(self.ObjID)
	end

	return content
end

function CAI_4591:OnHpLower(rate)
	if rate<=5 then
		GotoState(self.ObjID, "Return")
	end
end

function CAI_4591:OnStartDuel(nid, noid, tar)
	SetDuelTarget(self.ObjID, self.dwTarId)
	AddToHateList_Ex(self.ObjID, self.dwTarId, 1, 0)
	Say(self.ObjID, Lan("msg_script_4591_onstartduel"))
	self.dwTarId = 0
end

function CAI_4591:OnEndDuel(nid, noid, rate, tar)
	if rate<=5 then
		Say(self.ObjID, Lan("msg_script_4591_onendduel_lost"))
		TaskNpcEndDuel(self.ObjID, tar, 0)
	else
		Say(self.ObjID, Lan("msg_script_4591_onendduel_win"))
		TaskNpcEndDuel(self.ObjID, tar, 1)
	end
end

-------------------------------------------------------------------------------
--id= 2902 的脚本ai实现
-------------------------------------------------------------------------------
CAI_2902 = class(CAIObject)
function CAI_2902:ctor(id, objid)
end

function CAI_2902:OnCreate(creatorid)
	AddEffect(self.ObjID, self.ObjID, 4001)
end

-------------------------------------------------------------------------------
--id= 4351 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4351 = class(CAIObject)
function CAI_4351:ctor(id, objid)
	self.iCurrNum = 0
	self.iTotalNum = 0
	self.captainId1 = 0
	self.captainId2 = 0
	self.dwLastSpecial = 0
end

function CAI_4351:CreateMonsterGroup()
	local id1
	local id2
	id1 = CreateNpc(self.ObjID, 4347, 0, 0, 0)
	id2 = CreateNpc(self.ObjID, 4348, 0, 0, 0)
		
	self.captainId1 = id1
	self.captainId2 = id2

	self.iTotalNum = self.iTotalNum + 1
end

function CAI_4351:OnCreate_toRelated(fromnid, fromnoid, creatorid)
	if creatorid~=self.ObjID then
		OutputLog("OnCreate_toRelated Error: creatorid~=self.ObjID")
		return
	end
	
	if self.iCurrNum>=2 then
		OutputLog("OnCreate_toRelated Error: self.iCurrNum>=2")
		return
	end
	
	self.iCurrNum = self.iCurrNum + 1
	OutputLog("OnCreate_toRelated : self.iCurrNum=="..self.iCurrNum)
end

function CAI_4351:OnDead_toRelated(fromnid, fromnoid, killer)
	self.iCurrNum = self.iCurrNum - 1
	--OutputLog("OnDead_toRelated : self.iCurrNum=="..self.iCurrNum)
	if self.iCurrNum==0 then
		if self.iTotalNum>=2 then
			--OutputLog("OnDead_toRelated : self.iTotalNum=="..self.iTotalNum..", Over")
			Disappear(self.ObjID)
			return
		end
		--OutputLog("OnDead_toRelated : self.iTotalNum=="..self.iTotalNum)
		self:CreateMonsterGroup(killer)
	end
end

function CAI_4351:OnOpen(nid, noid)
	GotoState(self.ObjID, "Special")
end

function CAI_4351:OnSpecialState(dwNow)
	if self.dwLastSpecial==-1 then
		return
	end

	if self.dwLastSpecial==0 then
		self.dwLastSpecial = dwNow
	end

	if dwNow-self.dwLastSpecial>5 then
		self:CreateMonsterGroup()
		self.dwLastSpecial = -1
	end
end

-------------------------------------------------------------------------------
--id= 4347 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4347 = class(CAIObject)
function CAI_4347:ctor(id, objid)
end

function CAI_4347:OnCreate(creatorid)
end

-------------------------------------------------------------------------------
--id= 4348 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4348 = class(CAIObject)
function CAI_4348:ctor(id, objid)
end

function CAI_4348:OnCreate(creatorid)
end

-------------------------------------------------------------------------------
--id= 4323 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4323 = class(CAIObject)
function CAI_4323:ctor(id, objid)
	self.dwCreatedId = {}
	for i=1,4 do
		self.dwCreatedId[i] = 0
	end
end

function CAI_4323:AddChild(id)
	for i=1,4 do
		if self.dwCreatedId[i]==0 then
			self.dwCreatedId[i] = id
			return
		end
	end
end

function CAI_4323:ClearChild()
	for i=1,4 do
		if self.dwCreatedId[i]~=0 then
			Disappear(self.dwCreatedId[i])
			self.dwCreatedId[i] = 0
		end
	end
end

function CAI_4323:OnHpLower(rate)
	local id	
	
	PlayPose(self.ObjID, "skill02", false)

	id = CreateNpc(self.ObjID, 4345,0, 0, 0)
	self:AddChild(id)
	CopyHateList(self.ObjID, id)

	id = CreateNpc(self.ObjID, 4346,0, 0, 0)
	self:AddChild(id)
	CopyHateList(self.ObjID, id)

end

function CAI_4323:OnDead(killer)
	self:ClearChild()
end

function CAI_4323:OnLeaveBattle()
	self:ClearChild()
end

-------------------------------------------------------------------------------
--id= 4345 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4345 = class(CAIObject)
function CAI_4345:ctor(id, objid)
	self.dwLastSpecial = 0
end

function CAI_4345:OnCreate(id)
	GotoState(self.ObjID, "Special")
end

function CAI_4345:OnSpecialState(dwNow)

	if self.dwLastSpecial==0 then
		--DisActiveAI(self.ObjID)
		self.dwLastSpecial = dwNow
		return
	end

	if dwNow-self.dwLastSpecial>3 then
		--ActiveAI(self.ObjID)
		GotoState(self.ObjID, "Idle")
	end
end

-------------------------------------------------------------------------------
--id= 4346 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4346 = class(CAIObject)
function CAI_4346:ctor(id, objid)
	self.dwLastSpecial = 0
end

function CAI_4346:OnCreate(id)
	GotoState(self.ObjID, "Special")
end

function CAI_4346:OnSpecialState(dwNow)

	if self.dwLastSpecial==0 then
		--DisActiveAI(self.ObjID)
		self.dwLastSpecial = dwNow
		return
	end

	if dwNow-self.dwLastSpecial>3 then
		--ActiveAI(self.ObjID)
		GotoState(self.ObjID, "Idle")
	end
end

-------------------------------------------------------------------------------
--id= 4352 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4352 = class(CAIObject)
function CAI_4352:ctor(id, objid)
	self.dwCreatedId = {}
	self.dwCreatedId[1] = {}
	self.dwCreatedId[2] = {}
	self.dwCreatedId[3] = {}
	self.dwCreatedId[4] = {}
	self.dwCreatedId[5] = {}
	self.dwCreatedId[6] = {}
	for i=1,6 do
		self.dwCreatedId[i] = {0, 0}
	end
	self.dwLastSpecial = 0
end

function CAI_4352:AddChild(id, nid)

	for i=1,6 do
		if self.dwCreatedId[i][1]==0 then
			self.dwCreatedId[i][1] = id
			self.dwCreatedId[i][2] = CreateNpcAtMyPos(id, nid)
			ModifyAttackFlag(self.dwCreatedId[i][2], 0)
			DisActivePatrol(self.dwCreatedId[i][2])
			return
		end
	end

end

function CAI_4352:ReleaseChild()

	for i=1,6 do
		if self.dwCreatedId[i][1]~=0 then
			GotoState(self.dwCreatedId[i][1], "Open")
			Disappear(self.dwCreatedId[i][1])
			ModifyAttackFlag(self.dwCreatedId[i][2], 1)
			ActivePatrol(self.dwCreatedId[i][2])
		end
	end

end

function CAI_4352:OnCreate(id)

	local id
	id = CreateNpc(self.ObjID, 4353, 211, -22, 10)
	self:AddChild(id, 4357)

	id = CreateNpc(self.ObjID, 4353, 221, -6, 9)
	self:AddChild(id, 4358)

	id = CreateNpc(self.ObjID, 4353, 231, 6, 10)
	self:AddChild(id, 4361)

	id = CreateNpc(self.ObjID, 4353, 195, 40, 10)
	self:AddChild(id, 4360)

	id = CreateNpc(self.ObjID, 4353, 193, 2, 8)
	self:AddChild(id, 4356)

	id = CreateNpc(self.ObjID, 4353, 191, 21, 8)
	self:AddChild(id, 4359)

end

function CAI_4352:OnSpecialState(dwNow)

	if self.dwLastSpecial==-1 then
		return
	end

	if self.dwLastSpecial==0 then
		self.dwLastSpecial = dwNow
		return
	end

	if dwNow-self.dwLastSpecial>5 then
		self:ReleaseChild()
		Disappear(self.ObjID)
		self.dwLastSpecial=-1
	end
end

function CAI_4352:OnOpen(nid, noid)
	GotoState(self.ObjID, "Special")
end

-------------------------------------------------------------------------------
--id= 4336 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4336 = class(CAIObject)
function CAI_4336:ctor(id, objid)
end

function CAI_4336:OnDead(killer)
	local id
	for i=1, 3 do
		id = CreateNpc(self.ObjID, 4366, 0, 0, 0)
		AddToHateList(id, killer, 1)
	end
end

-------------------------------------------------------------------------------
--id= 4324 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4324 = class(CAIObject)
function CAI_4324:ctor(id, objid)
	self.dwCreateId = 0
end

function CAI_4324:OnCreate(id)
	self.dwCreateId = CreateNpc(self.ObjID, 4350, 289, 200, 8)
end

function CAI_4324:OnHpLower(rate)
	local id

	if rate<=30 then
		GotoState(self.dwCreateId, "Open")
		Disappear(self.dwCreateId)

		id = CreateNpc(self.ObjID, 4362, 0, 0, 0)
		CopyHateList(self.ObjID, id)

		id = CreateNpc(self.ObjID, 4363, 0, 0, 0)
		CopyHateList(self.ObjID, id)
	end
end
-------------------------------------------------------------------------------
--id= 4471 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4471 = class(CAIObject)
function CAI_4471:ctor(id, objid)
end

function CAI_4471:OnDead(killer)
	local id
	for i=1, 3 do
		id = CreateNpc(self.ObjID, 4472, 0, 0, 0)
		AddToHateList(id, killer, 1)
	end
end

-------------------------------------------------------------------------------
--id= 4494 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4494 = class(CAIObject)
function CAI_4494:ctor(id, objid)
	self.dwCreateId = {}
	for i=1, 8 do
		self.dwCreateId[i] = 0
	end
end

function CAI_4494:OnHpLower(rate)
	local id
	if rate<=60 and rate>30 then
		self.dwCreateId[1] = CreateNpc(self.ObjID, 4489, 0, 0, 0)
		CopyHateList_Ex(self.ObjID, self.dwCreateId[1], true)

		self.dwCreateId[2] = CreateNpc(self.ObjID, 4490, 0, 0, 0)
		CopyHateList_Ex(self.ObjID, self.dwCreateId[2], true)

		self.dwCreateId[3] = CreateNpc(self.ObjID, 4491, 0, 0, 0)
		CopyHateList_Ex(self.ObjID, self.dwCreateId[3], true)

		self.dwCreateId[4] = CreateNpc(self.ObjID, 4492, 0, 0, 0)
		CopyHateList_Ex(self.ObjID, self.dwCreateId[4], true)
	end

	if rate<=30 then
		self.dwCreateId[5] = CreateNpc(self.ObjID, 4489, 0, 0, 0)
		CopyHateList_Ex(self.ObjID, self.dwCreateId[5], true)

		self.dwCreateId[6] = CreateNpc(self.ObjID, 4490, 0, 0, 0)
		CopyHateList_Ex(self.ObjID, self.dwCreateId[6], true)

		self.dwCreateId[7] = CreateNpc(self.ObjID, 4491, 0, 0, 0)
		CopyHateList_Ex(self.ObjID, self.dwCreateId[7], true)

		self.dwCreateId[8] = CreateNpc(self.ObjID, 4492, 0, 0, 0)
		CopyHateList_Ex(self.ObjID, self.dwCreateId[8], true)
	end
end

function CAI_4494:OnLeaveBattle()
	for i=1, 8 do
		Disappear(self.dwCreateId[i])
	end
end

-------------------------------------------------------------------------------
--id= 4489~92 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4489 = class(CAIObject)
function CAI_4489:ctor(id, objid)
	self.dwStart = 0
end

function CAI_4489:OnEnterBattle()
	GotoState(self.ObjID, "Blast")
	OutputLog("CAI_4489:OnEnterBattle()")
end

function CAI_4489:OnBlast(dwNow)
	if self.dwStart==0 then
		self.dwStart = dwNow
		return
	end

	if dwNow-self.dwStart>15 then
		CheckUseSkill(self.ObjID, 1171, 0, 0)
		Disappear(self.ObjID)
	end
end
-------------------------------------------------------------------------------
CAI_4490 = class(CAIObject)
function CAI_4490:ctor(id, objid)
	self.dwStart = 0
end

function CAI_4490:OnEnterBattle()
	GotoState(self.ObjID, "Blast")
end

function CAI_4490:OnBlast(dwNow)
	if self.dwStart==0 then
		self.dwStart = dwNow
		return
	end

	if dwNow-self.dwStart>15 then
		CheckUseSkill(self.ObjID, 1171, 0, 0)
		Disappear(self.ObjID)
	end
end
-------------------------------------------------------------------------------
CAI_4491 = class(CAIObject)
function CAI_4491:ctor(id, objid)
	self.dwStart = 0
end

function CAI_4491:OnEnterBattle()
	GotoState(self.ObjID, "Blast")
end

function CAI_4491:OnBlast(dwNow)
	if self.dwStart==0 then
		self.dwStart = dwNow
		return
	end

	if dwNow-self.dwStart>15 then
		CheckUseSkill(self.ObjID, 1171, 0, 0)
		Disappear(self.ObjID)
	end
end
-------------------------------------------------------------------------------
CAI_4492 = class(CAIObject)
function CAI_4492:ctor(id, objid)
	self.dwStart = 0
end

function CAI_4492:OnEnterBattle()
	GotoState(self.ObjID, "Blast")
end

function CAI_4492:OnBlast(dwNow)
	if self.dwStart==0 then
		self.dwStart = dwNow
		return
	end

	if dwNow-self.dwStart>15 then
		CheckUseSkill(self.ObjID, 1171, 0, 0)
		Disappear(self.ObjID)
	end
end
-----------------------------------------------------------------------------------------
CAI_4497 = class(CAIObject)
function CAI_4497:ctor(id, objid)
	self.dwCreateId = {}
	for i=1, 18 do
		self.dwCreateId[i] = 0
	end
end

function CAI_4497:OnLeaveBattle()
	for i=1, 18 do
		Disappear(self.dwCreateId[i])
	end

	self.dwCreateId[1] = CreateNpc(self.ObjID, 4488, 483, 198, 0)
	self.dwCreateId[2] = CreateNpc(self.ObjID, 4488, 461, 213, 0)
	self.dwCreateId[3] = CreateNpc(self.ObjID, 4488, 452, 200, 0)
	self.dwCreateId[4] = CreateNpc(self.ObjID, 4488, 440, 221, 0)
	self.dwCreateId[5] = CreateNpc(self.ObjID, 4488, 423, 188, 0)
	self.dwCreateId[6] = CreateNpc(self.ObjID, 4488, 442, 197, 0)
	self.dwCreateId[7] = CreateNpc(self.ObjID, 4488, 404, 196, 0)
	self.dwCreateId[8] = CreateNpc(self.ObjID, 4488, 405, 225, 0)
	self.dwCreateId[9] = CreateNpc(self.ObjID, 4488, 424, 233, 0)
	self.dwCreateId[10] = CreateNpc(self.ObjID, 4488, 426, 179, 0)
	self.dwCreateId[11] = CreateNpc(self.ObjID, 4488, 420, 208, 0)
	self.dwCreateId[12] = CreateNpc(self.ObjID, 4488, 436, 233, 0)
	self.dwCreateId[13] = CreateNpc(self.ObjID, 4488, 389, 211, 0)
	self.dwCreateId[14] = CreateNpc(self.ObjID, 4488, 433, 183, 0)
	self.dwCreateId[15] = CreateNpc(self.ObjID, 4488, 410, 208, 0)
	self.dwCreateId[16] = CreateNpc(self.ObjID, 4488, 420, 218, 0)
	self.dwCreateId[17] = CreateNpc(self.ObjID, 4488, 428, 204, 0)
	self.dwCreateId[18] = CreateNpc(self.ObjID, 4488, 411, 182, 0)

end

function CAI_4497:OnCreate(id)
	self.dwCreateId[1] = CreateNpc(self.ObjID, 4488, 483, 198, 0)
	self.dwCreateId[2] = CreateNpc(self.ObjID, 4488, 461, 213, 0)
	self.dwCreateId[3] = CreateNpc(self.ObjID, 4488, 452, 200, 0)
	self.dwCreateId[4] = CreateNpc(self.ObjID, 4488, 440, 221, 0)
	self.dwCreateId[5] = CreateNpc(self.ObjID, 4488, 423, 188, 0)
	self.dwCreateId[6] = CreateNpc(self.ObjID, 4488, 442, 197, 0)
	self.dwCreateId[7] = CreateNpc(self.ObjID, 4488, 404, 196, 0)
	self.dwCreateId[8] = CreateNpc(self.ObjID, 4488, 405, 225, 0)
	self.dwCreateId[9] = CreateNpc(self.ObjID, 4488, 424, 233, 0)
	self.dwCreateId[10] = CreateNpc(self.ObjID, 4488, 426, 179, 0)
	self.dwCreateId[11] = CreateNpc(self.ObjID, 4488, 420, 208, 0)
	self.dwCreateId[12] = CreateNpc(self.ObjID, 4488, 436, 233, 0)
	self.dwCreateId[13] = CreateNpc(self.ObjID, 4488, 389, 211, 0)
	self.dwCreateId[14] = CreateNpc(self.ObjID, 4488, 433, 183, 0)
	self.dwCreateId[15] = CreateNpc(self.ObjID, 4488, 410, 208, 0)
	self.dwCreateId[16] = CreateNpc(self.ObjID, 4488, 420, 218, 0)
	self.dwCreateId[17] = CreateNpc(self.ObjID, 4488, 428, 204, 0)
	self.dwCreateId[18] = CreateNpc(self.ObjID, 4488, 411, 182, 0)
end
-----------------------------------------------------------------------------------------
CAI_4488 = class(CAIObject)
function CAI_4488:ctor(id, objid)
	self.dwStart = 0
end

function CAI_4488:OnHpLower(rate)
	local id
	if rate<=10 then
		CheckUseSkill(self.ObjID, 1172, 0, 0)
		CreateNpc(self.ObjID, 4473, 0, 0, 0)
		Die(self.ObjID)
		Disappear(self.ObjID)
	end
end
----------------------------------------------------------------------------------------
CAI_4498 = class(CAIObject)
function CAI_4498:ctor(id, objid)
	self.dwCreateId = 0
end

function CAI_4498:OnInteractive(uid, event)

	local content=""

	if event=="defaulttalk" then	
	
		content = GetFileContent("talk/npc_talk_4498.xml")
		content = ReplaceUserName(content, uid)
		content = ReplaceNpcObjId(content, self.ObjID)
	
	elseif event=="Step2" then

		content = GetFileContent("talk/npc_talk_4498_01.xml")
		content = ReplaceUserName(content, uid)
		content = ReplaceNpcObjId(content, self.ObjID)

	elseif event=="Ready" then
	
		self.dwCreateId = CreateNpc(self.ObjID, 4499, 0, 0, 0)
		AddTeamToHateList(self.ObjID, uid, 1)
		CopyHateList_Ex(self.ObjID, self.dwCreateId, true)		
		LockInteractive(self.ObjID)
		PlayPose(self.ObjID, "effect", false)
		ModifyAttackFlag(self.ObjID, 1)

	end

	return content
end

-----------------------------------------------------------------------------------------
CAI_4499 = class(CAIObject)
function CAI_4499:ctor(id, objid)
	self.dwCreatorId = 0
end

function CAI_4499:OnCreate(id)
	self.dwCreatorId = id
end

function CAI_4499:OnDead(killer)
	GotoState(self.dwCreatorId, "Return")
	ModifyAttackFlag(self.dwCreatorId, 0)
	UnLockInteractive(self.dwCreatorId)
end

-----------------------------------------------------------------------------------------
CAI_4500 = class(CAIObject)
function CAI_4500:ctor(id, objid)
	self.dwPlayDieTime = 0
end
function CAI_4500:OnHpLower(rate)
	GotoState(self.ObjID, "Special")
end

function CAI_4500:OnSpecialState(dwNow)
	if self.dwPlayDieTime==0 then
		self.dwPlayDieTime = dwNow
		SetModel(self.ObjID, 4475)
		PlayPose(self.ObjID, "die", false)
		--Die(self.ObjID)
		return
	end

	if dwNow-self.dwPlayDieTime>5 then
		local id
		id = CreateNpcAtMyPos(self.ObjID, 4501)
		CopyHateList_Ex(self.ObjID, id, true)
		GotoState(id, "Special")
		Disappear(self.ObjID)
	end
end

-----------------------------------------------------------------------------------------
CAI_4501 = class(CAIObject)
function CAI_4501:ctor(id, objid)
	self.dwTime = 0
end
function CAI_4501:OnSpecialState(dwNow)
	if self.dwTime==0 then
		self.dwTime = dwNow
		PlayPose(self.ObjID, "effect", false)
		return
	end

	if dwNow-self.dwTime>4 then
		GotoState(self.ObjID, "Combat")
	end
end

-----------------------------------------------------------------------------------------
CAI_4503 = class(CAIObject)
function CAI_4503:ctor(id, objid)
	self.dwPlayDieTime = 0
end
function CAI_4503:OnHpLower(rate)
	GotoState(self.ObjID, "Special")
end

function CAI_4503:OnSpecialState(dwNow)
	if self.dwPlayDieTime==0 then
		self.dwPlayDieTime = dwNow
		PlayPose(self.ObjID, "die", false)
		return
	end

	if dwNow-self.dwPlayDieTime>4 then
		local id
		id = CreateNpcAtMyPos(self.ObjID, 4502)
		CopyHateList_Ex(self.ObjID, id, true)
		AddEffect(self.ObjID, id, 2001)
		Disappear(self.ObjID)
	end
end

-----------------------------------------------------------------------------------------
--龙头
CAI_4667 = class(CAIObject)
function CAI_4667:ctor(id, objid)
end

function CAI_4667:OnDead(nKillerId)
    Say(self.ObjID, Lan("msg_script_4667_ondead"))
    Npc4666ObjId = GetNpcIdByTypeId(self.ObjID, 4666)
    Disappear(Npc4666ObjId)
    CreateNpc(self.ObjID, 4675, 378, 416, 6)
end

-----------------------------------------------------------------------------------------
--食人花妖
CAI_4664 = class(CAIObject)
function CAI_4664:ctor(id, objid)
self.dwCreateId = {}
	for i=1, 8 do
		self.dwCreateId[i] = 0
	end

end

function CAI_4664:OnDead(nKillerId)
    Say(self.ObjID, Lan("msg_script_4664_ondead"))
    Npc4667ObjId = GetNpcIdByTypeId(self.ObjID, 4667)
    ModifyAttackFlag(Npc4667ObjId, 1)
end

function CAI_4664:OnHpLower(rate)
	local id
	if rate<=60 and rate>30 then
		self.dwCreateId[1] = CreateNpc(self.ObjID, 4676, 0, 0, 0)
		CopyHateList_Ex(self.ObjID, self.dwCreateId[1], true)

		self.dwCreateId[2] = CreateNpc(self.ObjID, 4677, 0, 0, 0)
		CopyHateList_Ex(self.ObjID, self.dwCreateId[2], true)

		self.dwCreateId[3] = CreateNpc(self.ObjID, 4678, 0, 0, 0)
		CopyHateList_Ex(self.ObjID, self.dwCreateId[3], true)

		self.dwCreateId[4] = CreateNpc(self.ObjID, 4679, 0, 0, 0)
		CopyHateList_Ex(self.ObjID, self.dwCreateId[4], true)
	end

	if rate<=30 then
		self.dwCreateId[5] = CreateNpc(self.ObjID, 4676, 0, 0, 0)
		CopyHateList_Ex(self.ObjID, self.dwCreateId[5], true)

		self.dwCreateId[6] = CreateNpc(self.ObjID, 4677, 0, 0, 0)
		CopyHateList_Ex(self.ObjID, self.dwCreateId[6], true)

		self.dwCreateId[7] = CreateNpc(self.ObjID, 4678, 0, 0, 0)
		CopyHateList_Ex(self.ObjID, self.dwCreateId[7], true)

		self.dwCreateId[8] = CreateNpc(self.ObjID, 4679, 0, 0, 0)
		CopyHateList_Ex(self.ObjID, self.dwCreateId[8], true)
	end
end

function CAI_4664:OnLeaveBattle()
	for i=1, 8 do
		Disappear(self.dwCreateId[i])
	end
end


-----------------------------------------------------------------------------------------
--毒龙神将
CAI_4666 = class(CAIObject)
function CAI_4666:ctor(id, objid)
self.dwPlayDieTime = 0
end

function CAI_4666:OnDead(nKillerId)
    CreateNpc(self.ObjID, 4675, 378, 416, 6)
end

-----------------------------------------------------------------------------------------
--id= 4676~79 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4676 = class(CAIObject)
function CAI_4676:ctor(id, objid)
	self.dwStart = 0
end

function CAI_4676:OnEnterBattle()
	GotoState(self.ObjID, "Blast")
	OutputLog("CAI_4676:OnEnterBattle()")
end

function CAI_4676:OnBlast(dwNow)
	if self.dwStart==0 then
		self.dwStart = dwNow
		return
	end

	if dwNow-self.dwStart>15 then
		CheckUseSkill(self.ObjID, 1189, 0, 0)
		Disappear(self.ObjID)
	end
end
-------------------------------------------------------------------------------
CAI_4677 = class(CAIObject)
function CAI_4677:ctor(id, objid)
	self.dwStart = 0
end

function CAI_4677:OnEnterBattle()
	GotoState(self.ObjID, "Blast")
end

function CAI_4677:OnBlast(dwNow)
	if self.dwStart==0 then
		self.dwStart = dwNow
		return
	end

	if dwNow-self.dwStart>15 then
		CheckUseSkill(self.ObjID, 1189, 0, 0)
		Disappear(self.ObjID)
	end
end
-------------------------------------------------------------------------------
CAI_4678 = class(CAIObject)
function CAI_4678:ctor(id, objid)
	self.dwStart = 0
end

function CAI_4678:OnEnterBattle()
	GotoState(self.ObjID, "Blast")
end

function CAI_4678:OnBlast(dwNow)
	if self.dwStart==0 then
		self.dwStart = dwNow
		return
	end

	if dwNow-self.dwStart>15 then
		CheckUseSkill(self.ObjID, 1189, 0, 0)
		Disappear(self.ObjID)
	end
end
-------------------------------------------------------------------------------
CAI_4679 = class(CAIObject)
function CAI_4492:ctor(id, objid)
	self.dwStart = 0
end

function CAI_4679:OnEnterBattle()
	GotoState(self.ObjID, "Blast")
end

function CAI_4679:OnBlast(dwNow)
	if self.dwStart==0 then
		self.dwStart = dwNow
		return
	end

	if dwNow-self.dwStart>15 then
		CheckUseSkill(self.ObjID, 1189, 0, 0)
		Disappear(self.ObjID)
	end
end

-------------------------------------------------------------------------------

--毒龙神将
CAI_4675 = class(CAIObject)
function CAI_4675:ctor(id, objid)
self.dwPlayDieTime = 0
end

function CAI_4675:OnHpLower(rate)
    if (rate <= 35) and (rate > 30) then
        Say(self.ObjID, Lan("msg_script_4675_onhplower_35"))
    else
        GotoState(self.ObjID, "Special")
    end
end

function CAI_4675:OnSpecialState(dwNow)
	if self.dwPlayDieTime==0 then
		self.dwPlayDieTime = dwNow
		PlayPose(self.ObjID, "skill03", false)
		return
	end

	if dwNow-self.dwPlayDieTime>1 then
		local id
		id = CreateNpcAtMyPos(self.ObjID, 4681)
		CopyHateList_Ex(self.ObjID, id, true)
		--GotoState(id, "Special")
		Disappear(self.ObjID)
	end
end
-------------------------------------------------------------------------------

--徐岳元神
CAI_4762 = class(CAIObject)
function CAI_4762:ctor(id, objid)
end

function CAI_4762:OnDead(nKillerId)
	self.dwCreateId[1] = CreateNpc(self.ObjID, 4780, -563, 721, 0)
end
-------------------------------------------------------------------------------

--崔天绶元神

CAI_4764 = class(CAIObject)
function CAI_4764:ctor(id, objid)
end

function CAI_4764:OnDead(nKillerId)
	Npc4763ObjId = GetNpcIdByTypeId(self.ObjID, 4763)
	Dead = IsDead(Npc4763ObjId)
	if Dead == 1 then
	self.dwCreateId[1] = CreateNpc(self.ObjID, 4781, -590, 76, 0)
	end
end

--尉迟元元神

CAI_4763 = class(CAIObject)
function CAI_4763:ctor(id, objid)
end

function CAI_4763:OnDead(nKillerId)
	Npc4764ObjId = GetNpcIdByTypeId(self.ObjID, 4764)
	Dead = IsDead(Npc4764ObjId)
	if Dead == 1  then
	self.dwCreateId[1] = CreateNpc(self.ObjID, 4781, -590, 76, 0)
	end
end
-------------------------------------------------------------------------------

--陈长谷元神

CAI_4765 = class(CAIObject)
function CAI_4765:ctor(id, objid)
end

function CAI_4765:OnDead(nKillerId)
	Npc4766ObjId = GetNpcIdByTypeId(self.ObjID, 4766)
	Dead = IsDead(Npc4766ObjId)
	if Dead == 1 then
	self.dwCreateId[1] = CreateNpc(self.ObjID, 4782, -689, 195, 0)
	end
end

--吕四元神

CAI_4766 = class(CAIObject)
function CAI_4766:ctor(id, objid)
end

function CAI_4766:OnDead(nKillerId)
	Npc4765ObjId = GetNpcIdByTypeId(self.ObjID, 4765)
	Dead = IsDead(Npc4765ObjId)
	if Dead == 1  then
	self.dwCreateId[1] = CreateNpc(self.ObjID, 4782, -689, 191, 0)
	end
end
-------------------------------------------------------------------------------

--吕三元神

CAI_4767 = class(CAIObject)
function CAI_4767:ctor(id, objid)
end

function CAI_4767:OnDead(nKillerId)
	CreateNpc(self.ObjID, 4783, -678, 615, 0)
end
-------------------------------------------------------------------------------

--吕四肉身

CAI_4760 = class(CAIObject)
function CAI_4760:ctor(id, objid)
end

function CAI_4760:OnDead(nKillerId)
	Npc4761ObjId = GetNpcIdByTypeId(self.ObjID, 4761)
	Dead = IsDead(Npc4761ObjId)
	if Dead == 1 then

	CreateNpc(self.ObjID, 4613, -142, 637, 14)
	CreateNpc(self.ObjID, 4614, -147, 641, 6)
	

       Npc4776ObjId = GetNpcIdByTypeId(self.ObjID, 4776)
       Disappear(Npc4776ObjId)

       Npc4833ObjId = GetNpcIdByTypeId(self.ObjID, 4833)
       Disappear(Npc4833ObjId)

       else
	Say(self.ObjID, Lan("msg_script_4760"))	
	end
end

--吕三肉身

CAI_4761 = class(CAIObject)
function CAI_4761:ctor(id, objid)
end

function CAI_4761:OnDead(nKillerId)
	Npc4760ObjId = GetNpcIdByTypeId(self.ObjID, 4760)
	Dead = IsDead(Npc4760ObjId)
	if Dead == 1  then

	CreateNpc(self.ObjID, 4613, -142, 637, 14)
	CreateNpc(self.ObjID, 4614, -147, 641, 6)

       Npc4776ObjId = GetNpcIdByTypeId(self.ObjID, 4776)
       Disappear(Npc4776ObjId)

	Npc4833ObjId = GetNpcIdByTypeId(self.ObjID, 4833)
       Disappear(Npc4833ObjId)

       else
	Say(self.ObjID, Lan("msg_script_4761"))
	end
end
-------------------------------------------------------------------------------
--召唤大蛇
-------------------------------------------------------------------------------
CAI_4612 = class(CAIObject)

function CAI_4612:OnHpLower(rate)

	if rate < 100 and rate >= 80 then
	CreateNpc(self.ObjID, 4789, -99, 514, 0)

	elseif rate < 80 and rate >= 60 then
	CreateNpc(self.ObjID, 4789, -99, 514, 0)

	elseif rate < 60 and rate >= 40 then
	CreateNpc(self.ObjID, 4789, -99, 514, 0)

	elseif rate < 40 and rate >= 20 then
	CreateNpc(self.ObjID, 4789, -99, 514, 0)

	else

	end
end

-------------------------------------------------------------------------------
--同生共死1
-------------------------------------------------------------------------------
CAI_4613 = class(CAIObject)

function CAI_4613:OnRecvDamage(nsrcid, ndamage)
    if nsrcid ~= 0 then
    
        Npc4614ObjId = GetNpcIdByTypeId(self.ObjID, 4614)
    
        if Npc4614ObjId ~= 0 then
            RecvDamage(Npc4614ObjId, 0, ndamage)
        end
    
    end
end

-------------------------------------------------------------------------------
--同生共死2
-------------------------------------------------------------------------------
CAI_4614 = class(CAIObject)

function CAI_4614:OnRecvDamage(nsrcid, ndamage)
    if nsrcid ~= 0 then
    
        Npc4613ObjId = GetNpcIdByTypeId(self.ObjID, 4613)
    
        if Npc4613ObjId ~= 0 then
            RecvDamage(Npc4613ObjId, 0, ndamage)
        end
    
    end
end
-------------------------------------------------------------------------------

--传出副本

CAI_4615 = class(CAIObject)
function CAI_4615:ctor(id, objid)
end

function CAI_4615:OnDead(nKillerId)
	CreateNpc(self.ObjID, 4778, 0, 0, 0)
end

-------------------------------------------------------------------------------

--千年老蝎

CAI_4837 = class(CAIObject)
function CAI_4837:ctor(id, objid)
end

function CAI_4837:OnDead(nKillerId)
	Npc4838ObjId = GetNpcIdByTypeId(self.ObjID, 4838)
	Dead = IsDead(Npc4838ObjId)
	if Dead == 1 then

	CreateNpc(self.ObjID, 4839, 1418, -1173, 14)

       else
	Say(self.ObjID, Lan("msg_script_4837"))	
	end
end


--万年火蛛

CAI_4838 = class(CAIObject)
function CAI_4838:ctor(id, objid)
end

function CAI_4838:OnDead(nKillerId)
	Npc4837ObjId = GetNpcIdByTypeId(self.ObjID, 4837)
	Dead = IsDead(Npc4837ObjId)
	if Dead == 1 then

	CreateNpc(self.ObjID, 4839, 1418, -1173, 14)

       else
	Say(self.ObjID, Lan("msg_script_4838"))	
	end
end
-------------------------------------------------------------------------------

--魔战机甲

CAI_4839 = class(CAIObject)
function CAI_4839:ctor(id, objid)
end

function CAI_4839:OnDead(nKillerId)
	CreateNpc(self.ObjID, 4849, 1416, -1168, 0)

end
-------------------------------------------------------------------------------


--巨毒文蛛

CAI_4840 = class(CAIObject)
function CAI_4840:ctor(id, objid)
end

function CAI_4840:OnDead(nKillerId)
	CreateNpc(self.ObjID, 4847, 0, 0, 0)
end
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
CAI_4860 = class(CAIObject)
function CAI_4860:ctor(id, objid)
	self.dwStart = 0
end

function CAI_4860:OnEnterBattle()
	GotoState(self.ObjID, "Blast")
end

function CAI_4860:OnBlast(dwNow)
	if self.dwStart==0 then
		self.dwStart = dwNow
		return
	end

	if dwNow-self.dwStart>20 then
		CheckUseSkill(self.ObjID, 1171, 0, 0)
		Disappear(self.ObjID)
	end
end
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
CAI_4861 = class(CAIObject)
function CAI_4861:ctor(id, objid)
	self.dwCreatorId = 0
end

function CAI_4861:OnCreate(id)
	self.dwCreatorId = id
end

function CAI_4861:OnDead(killer)
	UnLockInteractive(self.dwCreatorId)
end

-----------------------------------------------------------------------------------------
--魔人

CAI_4877 = class(CAIObject)
function CAI_4877:ctor(id, objid)
end

function CAI_4877:OnDead(nKillerId)
	for i=0, 19 do
		local NpcId = 0;
		local Random = math.random(1, 100);
    		if (Random < 100) and (Random > 95) then
        		NpcId = 4878;
    		elseif (Random <=95) and (Random > 85) then
        		NpcId = 4879;
		elseif (Random <= 85) and (Random > 65) then
        		NpcId = 4880;
		elseif (Random <= 65) and (Random > 15) then
        		NpcId = 4881;
    		else
        		NpcId = 4882;

    		end
		CreateNpc(self.ObjID, NpcId , 0, 0, 0);
	end
end
-------------------------------------------------------------------------------

--巡逻任务测试 id= 4937 的脚本ai实现
-------------------------------------------------------------------------------
CAIBaoHuTask1403 = class(CAIObject)

function CAIBaoHuTask1403:ctor(id, objid)
	--OutputLog("ai脚本 CAIBaoHuTask1306 构造完毕 by "..objid)
end

function CAIBaoHuTask1403:OnInteractive(uid, event)
	local content=""

	if event=="defaulttalk" then
		content = GetFileContent("talk/npc_talk_1000.xml")
		content = ReplaceUserName(content, uid)
	end

	return content
end

function CAIBaoHuTask1403:OnHpLower(rate)
	if rate<=20 then
		Say(self.ObjID, Lan("msg_script_4937_onhplower_0"))
	elseif rate>20 and rate<=40 then
		Say(self.ObjID, Lan("msg_script_4937_onhplower_20"))
	elseif rate>40 and rate<=60 then
		Say(self.ObjID, Lan("msg_script_4937_onhplower_40"))
	elseif rate>60 and rate<80 then
		Say(self.ObjID, Lan("msg_script_4937_onhplower_60"))
	elseif rate>80 and rate<100 then
		Say(self.ObjID, Lan("msg_script_4937_onhplower_80"))

	end
end

function CAIBaoHuTask1403:OnTaskAccept(uid, taskid)
	local name = GetUserNameByObjId(uid)
	Say(self.ObjID, name..Lan("msg_script_4937_ontaskaccept"))
	LockInteractive(self.ObjID)
	ActivePatrol(self.ObjID)
end

function CAIBaoHuTask1403:OnArrive(n, IsEndPoint)
	if IsEndPoint==1 then
		Say(self.ObjID, Lan("msg_script_4937_onarrive"))
		if CheckDoingTask(self.ObjID)~=0 then
			FinishTask(self.ObjID)
			UnLockInteractive(self.ObjID)
		end
		DisActivePatrol(self.ObjID)
		Disappear(self.ObjID)
	end

	local rnd = math.random(2)
	
	if n==7 then
		Say(self.ObjID, Lan("msg_script_4937_onarrive_6"))
		CreateMyEnemy(self.ObjID, 4931, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,0, 80, 1)
		end
		GotoState(self.ObjID, "Wait")

	elseif n==9 then
		Say(self.ObjID, Lan("msg_script_4937_onarrive_9"))
		CreateMyEnemy(self.ObjID, 4931, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,4932, 80, 2)
		end
		GotoState(self.ObjID, "Wait")

	elseif n==12then
		Say(self.ObjID, Lan("msg_script_4937_onarrive_13"))
		CreateMyEnemy(self.ObjID, 4932, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,0, 80, 1)
		end
		GotoState(self.ObjID, "Wait")
	elseif n==15 then
		Say(self.ObjID, Lan("msg_script_4937_onarrive_18"))
		CreateMyEnemy(self.ObjID, 4933, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,0, 80, 2)
		end
		GotoState(self.ObjID, "Wait")
	elseif n==18 then
		Say(self.ObjID, Lan("msg_script_4937_onarrive_24"))
		CreateMyEnemy(self.ObjID, 4933, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,4933, 80, 2)
		end
		GotoState(self.ObjID, "Wait")


	end
end

function CAIBaoHuTask1403:OnDead(killer)
	if CheckDoingTask(self.ObjID)~=0 then
		Say(self.ObjID, Lan("msg_script_4937_ondead"))
		TaskFailed(self.ObjID)
	end
end

-------------------------------------------------------------------------------
--id= 4945 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4945 = class(CAIObject)
function CAI_4945:ctor(id, objid)
	self.bSayFlag = 0
end

function CAI_4945:OnInteractive(uid, event)	
	local content
	if event=="defaulttalk" then
		if self.bSayFlag == 0 and CheckUserDoingTask(uid, 1402) == 1 then
			Say(self.ObjID, Lan("msg_script_4945_onactive"))
			AddItem(uid,4352,0,0,1)
			ActivePatrol(self.ObjID)
			self.bSayFlag = 1
		end
	end
	return content
end

function CAI_4945:OnArrive(n, IsEndPoint)
	if IsEndPoint==1 then
		--if CheckDoingTask(self.ObjID)~=0 then
		DisActivePatrol(self.ObjID)
		Disappear(self.ObjID)
	end
end
-------------------------------------------------------------------------------
--id= 4946 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4946 = class(CAIObject)
function CAI_4946:ctor(id, objid)
	self.bSayFlag = 0
end

function CAI_4946:OnInteractive(uid, event)	
	local content
	if event=="defaulttalk" then
		if self.bSayFlag == 0 and CheckUserDoingTask(uid, 1402) == 1 then
			Say(self.ObjID, Lan("msg_script_4945_onactive"))
			AddItem(uid,4352,0,0,1)
			ActivePatrol(self.ObjID)
			self.bSayFlag = 1
		end
	end
	return content
end

function CAI_4946:OnArrive(n, IsEndPoint)
	if IsEndPoint==1 then
		--if CheckDoingTask(self.ObjID)~=0 then
		DisActivePatrol(self.ObjID)
		Disappear(self.ObjID)
	end
end
-------------------------------------------------------------------------------
--id= 4947 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4947 = class(CAIObject)
function CAI_4947:ctor(id, objid)
	self.bSayFlag = 0
end

function CAI_4947:OnInteractive(uid, event)	
	local content
	if event=="defaulttalk" then
		if self.bSayFlag == 0 and CheckUserDoingTask(uid, 1402) == 1 then
			Say(self.ObjID, Lan("msg_script_4945_onactive"))
			AddItem(uid,4352,0,0,1)
			ActivePatrol(self.ObjID)
			self.bSayFlag = 1
		end
	end
	return content
end

function CAI_4947:OnArrive(n, IsEndPoint)
	if IsEndPoint==1 then
		--if CheckDoingTask(self.ObjID)~=0 then
		DisActivePatrol(self.ObjID)
		Disappear(self.ObjID)
	end
end

-------------------------------------------------------------------------------
--id= 4948 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4948 = class(CAIObject)
function CAI_4948:ctor(id, objid)
	self.bSayFlag = 0
end

function CAI_4948:OnInteractive(uid, event)	
	local content
	if event=="defaulttalk" then
		if self.bSayFlag == 0 and CheckUserDoingTask(uid, 1402) == 1 then
			Say(self.ObjID, Lan("msg_script_4945_onactive"))
			AddItem(uid,4352,0,0,1)
			ActivePatrol(self.ObjID)
			self.bSayFlag = 1
		end
	end
	return content
end

function CAI_4948:OnArrive(n, IsEndPoint)
	if IsEndPoint==1 then
		--if CheckDoingTask(self.ObjID)~=0 then
		DisActivePatrol(self.ObjID)
		Disappear(self.ObjID)
	end
end

-------------------------------------------------------------------------------
--id= 4949 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4949 = class(CAIObject)
function CAI_4949:ctor(id, objid)
	self.bSayFlag = 0
end

function CAI_4949:OnInteractive(uid, event)	
	local content
	if event=="defaulttalk" then
		if self.bSayFlag == 0 and CheckUserDoingTask(uid, 1402) == 1 then
			Say(self.ObjID, Lan("msg_script_4945_onactive"))
			AddItem(uid,4352,0,0,1)
			ActivePatrol(self.ObjID)
			self.bSayFlag = 1
		end
	end
	return content
end

function CAI_4949:OnArrive(n, IsEndPoint)
	if IsEndPoint==1 then
		--if CheckDoingTask(self.ObjID)~=0 then
		DisActivePatrol(self.ObjID)
		Disappear(self.ObjID)
	end
end

-------------------------------------------------------------------------------
--id= 4957 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4957 = class(CAIObject)
function CAI_4957:ctor(id, objid)
end

function CAI_4957:OnDead(nid, noid)
	if (IsDead(GetNpcIdByTypeId(self.ObjID, 4958)) == 1) and (IsDead(GetNpcIdByTypeId(self.ObjID, 5037)) == 1) and (IsDead(GetNpcIdByTypeId(self.ObjID, 4959)) == 1) and (IsDead(GetNpcIdByTypeId(self.ObjID, 4960)) == 1) then
		local DoorId = GetNpcIdByTypeId(self.ObjID, 4950);
		GotoState(DoorId, "Open")
		DoorId = GetNpcIdByTypeId(self.ObjID, 4951);
		GotoState(DoorId, "Open")
	end
end

-------------------------------------------------------------------------------
--id= 4958 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4958 = class(CAIObject)
function CAI_4958:ctor(id, objid)
end

function CAI_4958:OnDead(nid, noid)
	if (IsDead(GetNpcIdByTypeId(self.ObjID, 4960)) == 1) and (IsDead(GetNpcIdByTypeId(self.ObjID, 5037)) == 1) and (IsDead(GetNpcIdByTypeId(self.ObjID, 4959)) == 1) and (IsDead(GetNpcIdByTypeId(self.ObjID, 4957)) == 1) then
		local DoorId = GetNpcIdByTypeId(self.ObjID, 4950);
		GotoState(DoorId, "Open")
		DoorId = GetNpcIdByTypeId(self.ObjID, 4951);
		GotoState(DoorId, "Open")
	end
end

-------------------------------------------------------------------------------
--id= 4959 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4959 = class(CAIObject)
function CAI_4959:ctor(id, objid)
end

function CAI_4959:OnDead(nid, noid)
	if (IsDead(GetNpcIdByTypeId(self.ObjID, 4958)) == 1) and (IsDead(GetNpcIdByTypeId(self.ObjID, 5037)) == 1) and (IsDead(GetNpcIdByTypeId(self.ObjID, 4960)) == 1) and (IsDead(GetNpcIdByTypeId(self.ObjID, 4957)) == 1) then
		local DoorId = GetNpcIdByTypeId(self.ObjID, 4950);
		GotoState(DoorId, "Open")
		DoorId = GetNpcIdByTypeId(self.ObjID, 4951);
		GotoState(DoorId, "Open")
	end
end

-------------------------------------------------------------------------------
--id= 4960 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4960 = class(CAIObject)
function CAI_4960:ctor(id, objid)
end

function CAI_4960:OnDead(nid, noid)
	if (IsDead(GetNpcIdByTypeId(self.ObjID, 4958)) == 1) and (IsDead(GetNpcIdByTypeId(self.ObjID, 5037)) == 1) and (IsDead(GetNpcIdByTypeId(self.ObjID, 4959)) == 1) and (IsDead(GetNpcIdByTypeId(self.ObjID, 4957)) == 1) then
		local DoorId = GetNpcIdByTypeId(self.ObjID, 4950);
		GotoState(DoorId, "Open")
		DoorId = GetNpcIdByTypeId(self.ObjID, 4951);
		GotoState(DoorId, "Open")
	end
end

-------------------------------------------------------------------------------
--id= 5037 的脚本ai实现
-------------------------------------------------------------------------------
CAI_5037 = class(CAIObject)
function CAI_5037:ctor(id, objid)
end

function CAI_5037:OnDead(nid, noid)
	if (IsDead(GetNpcIdByTypeId(self.ObjID, 4958)) == 1) and (IsDead(GetNpcIdByTypeId(self.ObjID, 4960)) == 1) and (IsDead(GetNpcIdByTypeId(self.ObjID, 4959)) == 1) and (IsDead(GetNpcIdByTypeId(self.ObjID, 4957)) == 1) then
		local DoorId = GetNpcIdByTypeId(self.ObjID, 4950);
		GotoState(DoorId, "Open")
		DoorId = GetNpcIdByTypeId(self.ObjID, 4951);
		GotoState(DoorId, "Open")
	end
end

-------------------------------------------------------------------------------
--id= 4935 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4935 = class(CAIObject)
function CAI_4935:ctor(id, objid)
end

function CAI_4935:OnHpLower(rate)

	if rate<=30 then

		local Random = math.random(1, 30);
    		if (Random ==1) then
        		Say(self.ObjID, Lan("msg_script_4935c1_onhplower_20"))
    		elseif (Random ==2) then
        		
		elseif (Random ==5) then
        		Say(self.ObjID, Lan("msg_script_4935c3_onhplower_20"))
		elseif (Random ==4) then

        	elseif (Random ==10) then
        		Say(self.ObjID, Lan("msg_script_4935c5_onhplower_20"))
		elseif (Random ==6) then

		elseif (Random ==15) then
        		Say(self.ObjID, Lan("msg_script_4935c7_onhplower_20"))
		
		elseif (Random ==20) then
        		Say(self.ObjID, Lan("msg_script_4935c9_onhplower_20"))


    		else
        		
    		end

	elseif rate>20 and rate<=50 then

		local Random = math.random(1, 30);
    		if (Random ==1) then
        		Say(self.ObjID, Lan("msg_script_4935b1_onhplower_50"))
    		elseif (Random ==2) then
        		
		elseif (Random ==5) then
        		Say(self.ObjID, Lan("msg_script_4935b3_onhplower_50"))
		elseif (Random ==4) then
        		
    		elseif (Random ==10) then
        		Say(self.ObjID, Lan("msg_script_4935b5_onhplower_50"))
		elseif (Random ==6) then

		elseif (Random ==15) then
        		Say(self.ObjID, Lan("msg_script_4935b7_onhplower_50"))
		elseif (Random ==20) then
			Say(self.ObjID, Lan("msg_script_4935b9_onhplower_50"))
		
    		else
        		
    		end


	elseif rate>50 and rate<=80 then

		local Random = math.random(1, 30);
    		if (Random ==1) then
        		Say(self.ObjID, Lan("msg_script_4935a1_onhplower_80"))
    		elseif (Random ==2) then
        		
		elseif (Random ==5) then
        		Say(self.ObjID, Lan("msg_script_4935a3_onhplower_80"))
		elseif (Random ==4) then
        		
    		elseif (Random ==10) then
        		Say(self.ObjID, Lan("msg_script_4935a5_onhplower_80"))
		elseif (Random ==6) then

		elseif (Random ==15) then
        		Say(self.ObjID, Lan("msg_script_4935a7_onhplower_80"))
		elseif (Random ==20) then
			Say(self.ObjID, Lan("msg_script_4935a9_onhplower_80"))
		elseif (Random ==9) then
		elseif (Random ==10) then
		elseif (Random ==11) then

    		else
        		
    		end

	else
		
	end
end

function CAI_4935:OnDead(killer)
local Random = math.random(1, 15);

    		if (Random ==1) then
        		Say(self.ObjID, Lan("msg_script_4935d1_onhplower_0"))
    		elseif (Random ==2) then
        		
		elseif (Random ==5) then
        		Say(self.ObjID, Lan("msg_script_4935d3_onhplower_0"))
		elseif (Random ==10) then
        		Say(self.ObjID, Lan("msg_script_4935d5_onhplower_0"))
    		else
        		
    		end

end

-------------------------------------------------------------------------------

--巡逻任务测试 id= 5026 的脚本ai实现
-------------------------------------------------------------------------------
CAIBaoHuTask1458 = class(CAIObject)

function CAIBaoHuTask1458:ctor(id, objid)
	--OutputLog("ai脚本 CAIBaoHuTask1306 构造完毕 by "..objid)
end

function CAIBaoHuTask1458:OnInteractive(uid, event)
	local content=""

	if event=="defaulttalk" then
		content = GetFileContent("talk/npc_talk_1000.xml")
		content = ReplaceUserName(content, uid)
	end

	return content
end

function CAIBaoHuTask1458:OnHpLower(rate)
	if rate<=20 then
		Say(self.ObjID, Lan("msg_script_5026_onhplower_0"))
	elseif rate>20 and rate<=40 then
		Say(self.ObjID, Lan("msg_script_5026_onhplower_20"))
	elseif rate>40 and rate<=60 then
		Say(self.ObjID, Lan("msg_script_5026_onhplower_40"))
	elseif rate>60 and rate<80 then
		Say(self.ObjID, Lan("msg_script_5026_onhplower_60"))
	elseif rate>80 and rate<100 then
		Say(self.ObjID, Lan("msg_script_5026_onhplower_80"))

	end
end

function CAIBaoHuTask1458:OnTaskAccept(uid, taskid)
	local name = GetUserNameByObjId(uid)
	Say(self.ObjID, name..Lan("msg_script_5026_ontaskaccept"))
	LockInteractive(self.ObjID)
	ActivePatrol(self.ObjID)
end

function CAIBaoHuTask1458:OnArrive(n, IsEndPoint)
	if IsEndPoint==1 then
		Say(self.ObjID, Lan("msg_script_5026_onarrive"))
		if CheckDoingTask(self.ObjID)~=0 then
			FinishTask(self.ObjID)
			UnLockInteractive(self.ObjID)
		end
		DisActivePatrol(self.ObjID)
		Disappear(self.ObjID)
	end

	local rnd = math.random(2)
	
	if n==7 then
		Say(self.ObjID, Lan("msg_script_5026_onarrive_6"))
		CreateMyEnemy(self.ObjID, 5029, 80, 4)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,0, 80, 1)
		end
		GotoState(self.ObjID, "Wait")

	elseif n==13 then
		Say(self.ObjID, Lan("msg_script_5026_onarrive_9"))
		CreateMyEnemy(self.ObjID, 5029, 80, 4)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,5029, 80,2)
		end
		GotoState(self.ObjID, "Wait")

	elseif n==17then
		Say(self.ObjID, Lan("msg_script_5026_onarrive_13"))
		CreateMyEnemy(self.ObjID, 5029, 80, 3)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,5029, 80, 1)
		end
		GotoState(self.ObjID, "Wait")
	elseif n==22 then
		Say(self.ObjID, Lan("msg_script_5026_onarrive_18"))
		CreateMyEnemy(self.ObjID, 5029, 80, 4)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,5029, 80, 2)
		end
		GotoState(self.ObjID, "Wait")
	elseif n==26 then
		Say(self.ObjID, Lan("msg_script_5026_onarrive_24"))
		CreateMyEnemy(self.ObjID, 5029, 80, 5)
		if rnd==1 then
			CreateMyEnemy(self.ObjID,0, 80, 1)
		end
		GotoState(self.ObjID, "Wait")


	end
end

function CAIBaoHuTask1458:OnDead(killer)
	if CheckDoingTask(self.ObjID)~=0 then
		Say(self.ObjID, Lan("msg_script_5026_ondead"))
		TaskFailed(self.ObjID)
	end
end

-------------------------------------------------------------------------------
--id= 4975 的脚本ai实现
-------------------------------------------------------------------------------
CAI_1428 = class(CAIObject)
function CAI_1428:ctor(id, objid)
	self.dwTarId = 0
end

function CAI_1428:OnInteractive(uid, event)

	local content=""

	if event=="defaulttalk" then
	
		if CheckUserDoingTask(uid, 1428)==0 then
			content = GetFileContent("talk/npc_talk_4975.xml")
		else
			content = GetFileContent("talk/npc_talk_4975_01.xml")
		end

	elseif event=="duel" then
		self.dwTarId = uid
		GotoState(self.ObjID, "Duel")
		LockInteractive(self.ObjID)
	end

	return content
end

function CAI_1428:OnHpLower(rate)
	if rate<=5 then
		GotoState(self.ObjID, "Return")
	end
end

function CAI_1428:OnStartDuel(nid, noid, tar)
	SetDuelTarget(self.ObjID, self.dwTarId)
	AddToHateList_Ex(self.ObjID, self.dwTarId, 1, 0)
	Say(self.ObjID, Lan("msg_script_1428_onstartduel"))
	self.dwTarId = 0
end

function CAI_1428:OnEndDuel(nid, noid, rate, tar)
	if rate<=5 then
		Say(self.ObjID, Lan("msg_script_1428_onendduel_lost"))
		TaskNpcEndDuel(self.ObjID, tar, 0)
	else
		Say(self.ObjID, Lan("msg_script_1428_onendduel_win"))
		TaskNpcEndDuel(self.ObjID, tar, 1)
	end
end
-------------------------------------------------------------------------------
--id= 4979 的脚本ai实现
-------------------------------------------------------------------------------
CAI_1429 = class(CAIObject)
function CAI_1429:ctor(id, objid)
	self.dwTarId = 0
end

function CAI_1429:OnInteractive(uid, event)

	local content=""

	if event=="defaulttalk" then
	
		if CheckUserDoingTask(uid, 1429)==0 then
			content = GetFileContent("talk/npc_talk_4979.xml")
		else
			content = GetFileContent("talk/npc_talk_4979_01.xml")
		end

	elseif event=="duel" then
		self.dwTarId = uid
		GotoState(self.ObjID, "Duel")
		LockInteractive(self.ObjID)
	end

	return content
end

function CAI_1429:OnHpLower(rate)
	if rate<=5 then
		GotoState(self.ObjID, "Return")
	end
end

function CAI_1429:OnStartDuel(nid, noid, tar)
	SetDuelTarget(self.ObjID, self.dwTarId)
	AddToHateList_Ex(self.ObjID, self.dwTarId, 1, 0)
	Say(self.ObjID, Lan("msg_script_1429_onstartduel"))
	self.dwTarId = 0
end

function CAI_1429:OnEndDuel(nid, noid, rate, tar)
	if rate<=5 then
		Say(self.ObjID, Lan("msg_script_1429_onendduel_lost"))
		TaskNpcEndDuel(self.ObjID, tar, 0)
	else
		Say(self.ObjID, Lan("msg_script_1429_onendduel_win"))
		TaskNpcEndDuel(self.ObjID, tar, 1)
	end
end

-------------------------------------------------------------------------------
--id= 4988 的脚本ai实现
-------------------------------------------------------------------------------
CAI_1430 = class(CAIObject)
function CAI_1430:ctor(id, objid)
	self.dwTarId = 0
end

function CAI_1430:OnInteractive(uid, event)

	local content=""

	if event=="defaulttalk" then
	
		if CheckUserDoingTask(uid, 1430)==0 then
			content = GetFileContent("talk/npc_talk_4988.xml")
		else
			content = GetFileContent("talk/npc_talk_4988_01.xml")
		end

	elseif event=="duel" then
		self.dwTarId = uid
		GotoState(self.ObjID, "Duel")
		LockInteractive(self.ObjID)
	end

	return content
end

function CAI_1430:OnHpLower(rate)
	if rate<=5 then
		GotoState(self.ObjID, "Return")
	end
end

function CAI_1430:OnStartDuel(nid, noid, tar)
	SetDuelTarget(self.ObjID, self.dwTarId)
	AddToHateList_Ex(self.ObjID, self.dwTarId, 1, 0)
	Say(self.ObjID, Lan("msg_script_1430_onstartduel"))
	self.dwTarId = 0
end

function CAI_1430:OnEndDuel(nid, noid, rate, tar)
	if rate<=5 then
		Say(self.ObjID, Lan("msg_script_1430_onendduel_lost"))
		TaskNpcEndDuel(self.ObjID, tar, 0)
	else
		Say(self.ObjID, Lan("msg_script_1430_onendduel_win"))
		TaskNpcEndDuel(self.ObjID, tar, 1)
	end
end

-------------------------------------------------------------------------------
--id= 4995 的脚本ai实现
-------------------------------------------------------------------------------
CAI_1431 = class(CAIObject)
function CAI_1431:ctor(id, objid)
	self.dwTarId = 0
end

function CAI_1431:OnInteractive(uid, event)

	local content=""

	if event=="defaulttalk" then
	
		if CheckUserDoingTask(uid, 1431)==0 then
			content = GetFileContent("talk/npc_talk_4995.xml")
		else
			content = GetFileContent("talk/npc_talk_4995_01.xml")
		end

	elseif event=="duel" then
		self.dwTarId = uid
		GotoState(self.ObjID, "Duel")
		LockInteractive(self.ObjID)
	end

	return content
end

function CAI_1431:OnHpLower(rate)
	if rate<=5 then
		GotoState(self.ObjID, "Return")
	end
end

function CAI_1431:OnStartDuel(nid, noid, tar)
	SetDuelTarget(self.ObjID, self.dwTarId)
	AddToHateList_Ex(self.ObjID, self.dwTarId, 1, 0)
	Say(self.ObjID, Lan("msg_script_1431_onstartduel"))
	self.dwTarId = 0
end

function CAI_1431:OnEndDuel(nid, noid, rate, tar)
	if rate<=5 then
		Say(self.ObjID, Lan("msg_script_1431_onendduel_lost"))
		TaskNpcEndDuel(self.ObjID, tar, 0)
	else
		Say(self.ObjID, Lan("msg_script_1431_onendduel_win"))
		TaskNpcEndDuel(self.ObjID, tar, 1)
	end
end

-------------------------------------------------------------------------------
--id= 5002 的脚本ai实现
-------------------------------------------------------------------------------
CAI_1432 = class(CAIObject)
function CAI_1432:ctor(id, objid)
	self.dwTarId = 0
end

function CAI_1432:OnInteractive(uid, event)

	local content=""

	if event=="defaulttalk" then
	
		if CheckUserDoingTask(uid, 1432)==0 then
			content = GetFileContent("talk/npc_talk_5002.xml")
		else
			content = GetFileContent("talk/npc_talk_5002_01.xml")
		end

	elseif event=="duel" then
		self.dwTarId = uid
		GotoState(self.ObjID, "Duel")
		LockInteractive(self.ObjID)
	end

	return content
end

function CAI_1432:OnHpLower(rate)
	if rate<=5 then
		GotoState(self.ObjID, "Return")
	end
end

function CAI_1432:OnStartDuel(nid, noid, tar)
	SetDuelTarget(self.ObjID, self.dwTarId)
	AddToHateList_Ex(self.ObjID, self.dwTarId, 1, 0)
	Say(self.ObjID, Lan("msg_script_1432_onstartduel"))
	self.dwTarId = 0
end

function CAI_1432:OnEndDuel(nid, noid, rate, tar)
	if rate<=5 then
		Say(self.ObjID, Lan("msg_script_1432_onendduel_lost"))
		TaskNpcEndDuel(self.ObjID, tar, 0)
	else
		Say(self.ObjID, Lan("msg_script_1432_onendduel_win"))
		TaskNpcEndDuel(self.ObjID, tar, 1)
	end
end

-------------------------------------------------------------------------------
--id= 4970 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4970 = class(CAIObject)
function CAI_4970:ctor(id, objid)
end

function CAI_4970:OnDead(killer)
local Random = math.random(1, 5);

    		if (Random ==1) then
        		Say(self.ObjID, Lan("msg_script_4970d1_onhplower_0"))
    		elseif (Random ==2) then
        		
		elseif (Random ==3) then
        		Say(self.ObjID, Lan("msg_script_4970d3_onhplower_0"))
		elseif (Random ==4) then
        		
    		else
        		Say(self.ObjID, Lan("msg_script_4970d5_onhplower_0"))
    		end

end
-------------------------------------------------------------------------------
--id= 4977 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4977 = class(CAIObject)
function CAI_4977:ctor(id, objid)
end

function CAI_4977:OnDead(killer)
local Random = math.random(1, 5);

    		if (Random ==1) then
        		Say(self.ObjID, Lan("msg_script_4977d1_onhplower_0"))
    		elseif (Random ==2) then
        		
		elseif (Random ==3) then
        		Say(self.ObjID, Lan("msg_script_4977d3_onhplower_0"))
		elseif (Random ==4) then
        		
    		else
        		Say(self.ObjID, Lan("msg_script_4977d5_onhplower_0"))
    		end

end
-------------------------------------------------------------------------------
--id= 4983 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4983 = class(CAIObject)
function CAI_4983:ctor(id, objid)
end

function CAI_4983:OnDead(killer)
local Random = math.random(1, 5);

    		if (Random ==1) then
        		Say(self.ObjID, Lan("msg_script_4983d1_onhplower_0"))
    		elseif (Random ==2) then
        		
		elseif (Random ==3) then
        		Say(self.ObjID, Lan("msg_script_4983d3_onhplower_0"))
		elseif (Random ==4) then
        		
    		else
        		Say(self.ObjID, Lan("msg_script_4983d5_onhplower_0"))
    		end

end
-------------------------------------------------------------------------------
--id= 4998 的脚本ai实现
-------------------------------------------------------------------------------
CAI_4998 = class(CAIObject)
function CAI_4998:ctor(id, objid)
end

function CAI_4998:OnDead(killer)
local Random = math.random(1, 5);

    		if (Random ==1) then
        		Say(self.ObjID, Lan("msg_script_4998d1_onhplower_0"))
    		elseif (Random ==2) then
        		
		elseif (Random ==3) then
        		Say(self.ObjID, Lan("msg_script_4998d3_onhplower_0"))
		elseif (Random ==4) then
        		
    		else
        		Say(self.ObjID, Lan("msg_script_4998d5_onhplower_0"))
    		end

end

-------------------------------------------------------------------------------
--id= 5001 的脚本ai实现
-------------------------------------------------------------------------------
CAI_5001 = class(CAIObject)
function CAI_5001:ctor(id, objid)
end

function CAI_5001:OnDead(killer)
local Random = math.random(1, 5);

    		if (Random ==1) then
        		Say(self.ObjID, Lan("msg_script_5001d1_onhplower_0"))
    		elseif (Random ==2) then
        		
		elseif (Random ==3) then
        		Say(self.ObjID, Lan("msg_script_5001d3_onhplower_0"))
		elseif (Random ==4) then
        		
    		else
        		Say(self.ObjID, Lan("msg_script_5001d5_onhplower_0"))
    		end

end

-------------------------------------------------------------------------------
--id= 5003 的脚本ai实现
-------------------------------------------------------------------------------
CAI_5003 = class(CAIObject)
function CAI_5003:ctor(id, objid)
end

function CAI_5003:OnDead(killer)
local Random = math.random(1, 5);

    		if (Random ==1) then
        		Say(self.ObjID, Lan("msg_script_5003d1_onhplower_0"))
    		elseif (Random ==2) then
        		
		elseif (Random ==3) then
        		Say(self.ObjID, Lan("msg_script_5003d3_onhplower_0"))
		elseif (Random ==4) then
        		
    		else
        		Say(self.ObjID, Lan("msg_script_5003d5_onhplower_0"))
    		end

end

-------------------------------------------------------------------------------
--id= 5031 的脚本ai实现
-------------------------------------------------------------------------------
CAI_5031 = class(CAIObject)
function CAI_5031:ctor(id, objid)
	self.dwLastTime = 0
end

function CAI_5031:OnUpdate(dwNow)
	if self.dwLastTime == 0 then
		self.dwLastTime = dwNow
		return
	end

	if ((dwNow - self.dwLastTime) > 35) then
		self.dwLastTime = dwNow

		local Random = math.random(1, 5);

    		if (Random ==1) then
        		Say(self.ObjID, Lan("msg_script_5031d1_onhplower_0"))
    		elseif (Random ==2) then
        		
		elseif (Random ==3) then
        		Say(self.ObjID, Lan("msg_script_5031d3_onhplower_0"))
		elseif (Random ==4) then
        		
    		else
        		Say(self.ObjID, Lan("msg_script_5031d5_onhplower_0"))
    		end

	end
end


-------------------------------------------------------------------------------
--id= 5034 的脚本ai实现
-------------------------------------------------------------------------------
CAI_5034 = class(CAIObject)
function CAI_5034:ctor(id, objid)
	self.dwLastTime = 0
end

function CAI_5034:OnUpdate(dwNow)
	if self.dwLastTime == 0 then
		self.dwLastTime = dwNow
		return
	end

	if ((dwNow - self.dwLastTime) > 20) then
		self.dwLastTime = dwNow

		local Random = math.random(1, 5);

    		if (Random ==1) then
        		Say(self.ObjID, Lan("msg_script_5034d1_onhplower_0"))
    		elseif (Random ==2) then
        		
		elseif (Random ==3) then
        		Say(self.ObjID, Lan("msg_script_5034d3_onhplower_0"))
		elseif (Random ==4) then
        		
    		else
        		Say(self.ObjID, Lan("msg_script_5034d5_onhplower_0"))
    		end

	end
end

-------------------------------------------------------------------------------
--id= 5035 的脚本ai实现
-------------------------------------------------------------------------------
CAI_5035 = class(CAIObject)
function CAI_5035:ctor(id, objid)
	self.dwLastTime = 0
end

function CAI_5035:OnUpdate(dwNow)
	if self.dwLastTime == 0 then
		self.dwLastTime = dwNow
		return
	end

	if ((dwNow - self.dwLastTime) > 20) then
		self.dwLastTime = dwNow

		local Random = math.random(1, 5);

    		if (Random ==1) then
        		Say(self.ObjID, Lan("msg_script_5035d1_onhplower_0"))
    		elseif (Random ==2) then
        		
		elseif (Random ==3) then
        		Say(self.ObjID, Lan("msg_script_5035d3_onhplower_0"))
		elseif (Random ==4) then
        		
    		else
        		Say(self.ObjID, Lan("msg_script_5035d5_onhplower_0"))
    		end

	end
end
