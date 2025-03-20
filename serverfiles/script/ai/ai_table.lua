
include("script/ai/AI_Action_Head.lua")

AITable = {}
AIObjTable = {}
AILanguage = {}

function GetAIType(idx)
	if AITable[idx]~=nil then
		return AITable[idx]
	else
		return nil
	end
end


function Init()

	AITable[10] = CAILingZhi		
	AITable[40] = CAIXiongMao
	AITable[143] = CAIXunluoTask50	
	AITable[254] = CAIBaoHuTask156
	AITable[98] = CAIBaoHuTask166
	AITable[436] = CAIBaoHuTask301
	AITable[244] = CAI_244
	AITable[3411] = CAIBuZhuoTask710
	AITable[3118] = CAIBuZhuoTask561
	AITable[4417] = CAIBaoHuTask1188
	AITable[4504] = CAIBaoHuTask1231
	AITable[3] = CAIBuZhuo51
	AITable[0] = CAI_323		--任务212大难临头
	AITable[331] = CAI_331		-- 召唤腐皮豺狼
	AITable[332] = CAI_332		-- 召唤红头秃鹫
	AITable[3014] = CAI_3014	-- 石笋巨人
	AITable[3104] = CAI_3104	-- 楠树守卫
	AITable[3314] = CAI_3314	-- 小灵花仙
	AITable[3209] = CAI_3209	-- 石精怪
	AITable[2905] = CAI_2905	-- 血神府城门
	AITable[2914] = CAI_2914	-- 血神使者
	AITable[2915] = CAI_2915	-- 血神使者
	AITable[2916] = CAI_2916	-- 血神使者
	AITable[2917] = CAI_2917	-- 血神使者
	AITable[2902] = CAI_2902	-- 血神使者
	AITable[2918] = CAI_2918	-- 血神使者
	AITable[2919] = CAI_2919	-- 血神使者
	AITable[4632] = CAI_4632	--宝箱
	AITable[4584] = CAI_4584	-- 打败霹雳手
	AITable[4591] = CAI_4591	-- 约战陈家庄
	AITable[4635] = CAIBaoHuTask1306  -- 护送登萍仙子
	AITable[4695] = CAIBaoHuTask805  -- 护送金蝉
	AITable[5026] = CAIBaoHuTask1458  -- 护送安雅
	AITable[4975] = CAI_1428	-- 打败护卫
	AITable[4979] = CAI_1429	-- 打败斗士
	AITable[4988] = CAI_1430	-- 打败勇士
	AITable[4995] = CAI_1431	-- 打败侠客
	AITable[5002] = CAI_1432	-- 打败侠客
	AITable[4970] = CAI_4970	-- 金角被打败后
	AITable[4977] = CAI_4977	-- 银角被打败后
	AITable[4983] = CAI_4983	-- 妖道被打败后
	AITable[4998] = CAI_4998	-- 黑风被打败后
	AITable[5001] = CAI_5001	-- 朱洪被打败后
	AITable[5003] = CAI_5003	-- 龙化被打败后
	AITable[5031] = CAI_5031	-- 胆小的村民
	AITable[5034] = CAI_5034	-- 胆小的村民
	AITable[5035] = CAI_5035	-- 采药郎中





	-------------------------------------------------------
	-- 云灵山蛇穴
	-------------------------------------------------------
	AITable[174] = CAI_174		--副本任务101被污染的蘑菇
	AITable[176] = CAI_176		--副本任务102污染者毒菌
	AITable[157] = CAI_157		--副本任务157鬼风妖道
	AITable[158] = CAI_158		--副本任务158蛇妖化身
	AITable[159] = CAI_159		--副本任务159蛇妖元神
	AITable[166] = CAI_166		--副本 召唤巡逻怪
	AITable[167] = CAI_167		--副本 召唤巡逻怪
	AITable[173] = CAI_173		--副本封印门1
	AITable[179] = CAI_179		--副本封印门2
	AITable[267] = CAI_267		--副本精英匪徒

	-------------------------------------------------------
	-- 魔宫
	-------------------------------------------------------
	AITable[4351] = CAI_4351		--副本监狱大门
	AITable[4347] = CAI_4347
	AITable[4348] = CAI_4348
	AITable[4323] = CAI_4323
	AITable[4345] = CAI_4345
	AITable[4346] = CAI_4346
	AITable[4352] = CAI_4352		--冰门
	AITable[4336] = CAI_4336		--宝箱
	AITable[4324] = CAI_4324		--铁门

	-------------------------------------------------------
	-- 妖人洞府
	-------------------------------------------------------
	AITable[4471] = CAI_4471		--宝箱
	AITable[4494] = CAI_4494		--千年水蛭
	AITable[4489] = CAI_4489		--自爆水蛭
	AITable[4490] = CAI_4490		--自爆水蛭
	AITable[4491] = CAI_4491		--自爆水蛭
	AITable[4492] = CAI_4492		--自爆水蛭

	AITable[4497] = CAI_4497		--飞天夜叉
	AITable[4488] = CAI_4488		--恐怖蜘蛛卵

	AITable[4498] = CAI_4498		--毒龙尊者
	AITable[4499] = CAI_4499		--滇西巫医

	AITable[4500] = CAI_4500		--鬼人
	AITable[4501] = CAI_4501		--鬼龙
	AITable[4503] = CAI_4503		--烈火老祖（骑马）
	
	-------------------------------------------------------
	-- 桂花山红花洞
	-------------------------------------------------------
	AITable[4667] = CAI_4667        --龙头
	AITable[4664] = CAI_4664        --食人花妖
	AITable[4666] = CAI_4666        --毒龙神将
	AITable[4676] = CAI_4676		--食人蘑菇
	AITable[4677] = CAI_4677		--食人蘑菇
	AITable[4678] = CAI_4678		--食人蘑菇
	AITable[4679] = CAI_4679		--食人蘑菇
	AITable[4675] = CAI_4675        --毒龙神将
       -------------------------------------------------------
	-- 七星台
	-------------------------------------------------------
	AITable[4762] = CAI_4762       --徐岳元神
	AITable[4763] = CAI_4763       --尉迟元元神
	AITable[4764] = CAI_4764       --崔天绶元神
       AITable[4765] = CAI_4765       --陈长谷元神
	AITable[4766] = CAI_4766       --吕四元神
	AITable[4767] = CAI_4767       --吕三元神
	AITable[4760] = CAI_4760       --吕三肉身
	AITable[4761] = CAI_4761       --吕四肉身
	AITable[4612] = CAI_4612       --召唤大蛇
	AITable[4613] = CAI_4613       --同生共死1
	AITable[4614] = CAI_4614       --同生共死2
	AITable[4615] = CAI_4615       --传出副本
	-------------------------------------------------------
	-- 文蛛洞
	-------------------------------------------------------
	AITable[4837] = CAI_4837      --千年老蝎
	AITable[4838] = CAI_4838      --万年火蛛
	AITable[4839] = CAI_4839      --魔战机甲
	AITable[4840] = CAI_4840      --巨毒文蛛
	AITable[4860] = CAI_4860	  --自爆蜘蛛卵
	AITable[4861] = CAI_4861	  --血蛛
	AITable[4877] = CAI_4877      --活动BOSS魔人
	-------------------------------------------------------
	-- 四门山副本
	-------------------------------------------------------
	AITable[4937] = CAIBaoHuTask1403  -- 护送女童
	AITable[4945] = CAI_4945          --副本任务1402幼童
	AITable[4946] = CAI_4946          --副本任务1402幼童
	AITable[4947] = CAI_4947          --副本任务1402幼童
	AITable[4948] = CAI_4948          --副本任务1402幼童
	AITable[4949] = CAI_4949          --副本任务1402幼童
	AITable[4957] = CAI_4957          --副本任务1407鼎机关
	AITable[4958] = CAI_4958          --副本任务1407鼎机关
	AITable[4959] = CAI_4959          --副本任务1407鼎机关
	AITable[4960] = CAI_4960          --副本任务1407鼎机关
	AITable[4935] = CAI_4935          --副本小怪AI
	AITable[5037] = CAI_5037          --副本任务1407鼎机关


	-------------------------------------------------------
	-- 初始化语言
	-------------------------------------------------------
	InitLanguage()
end

function CreateAI(idx, objid)
	if AITable[idx] then
		if AIObjTable[objid]==nil then
			AIObjTable[objid] = AITable[idx].new(idx, objid)
			--OutputLog("脚本ai对象被创建，npcId="..idx..", objId="..objid)
		end
		return AIObjTable[objid]
	else
		return nil
	end
end

function DeleteAI(idx, objid)
	if AIObjTable[objid] then
		AIObjTable[objid]=nil
		--OutputLog("脚本ai对象被销毁，npcId="..idx..", objId="..objid)
	end
end

function InitLanguage()
	_init("msg_script_254_ontaskaccept")
	_init("msg_script_254_onhplower_20")
	_init("msg_script_254_onhplower_40")
	_init("msg_script_254_onhplower_60")
	_init("msg_script_254_onhplower_80")
	_init("msg_script_254_onarrive")
	_init("msg_script_254_onarrive_5")
	_init("msg_script_254_onarrive_14")
	_init("msg_script_254_onarrive_19")
	_init("msg_script_254_onarrive_23")
	_init("msg_script_254_onarrive_26")
	_init("msg_script_254_ondead")
	
	_init("msg_script_143_onhplower_0")
	_init("msg_script_143_onhplower_20")
	_init("msg_script_143_onhplower_40")
	_init("msg_script_143_onhplower_60")
	_init("msg_script_143_onhplower_80")
	_init("msg_script_143_ontaskaccept")
	_init("msg_script_143_onarrive")
	_init("msg_script_143_onarrive_5")
	_init("msg_script_143_onarrive_14")
	_init("msg_script_143_onarrive_19")
	_init("msg_script_143_onarrive_23")
	_init("msg_script_143_onarrive_26")
	_init("msg_script_143_ondead")
	
	_init("msg_script_98_onhplower_0")
	_init("msg_script_98_onhplower_20")
	_init("msg_script_98_onhplower_40")
	_init("msg_script_98_onhplower_60")
	_init("msg_script_98_onhplower_80")
	_init("msg_script_98_ondead")
	_init("msg_script_98_onarrive")
	_init("msg_script_98_onarrive_4")
	_init("msg_script_98_onarrive_7")
	_init("msg_script_98_onarrive_12")
	_init("msg_script_98_onarrive_17")
	_init("msg_script_98_onarrive_23")
	_init("msg_script_98_ontaskaccept")
	
	_init("msg_script_436_onhplower_0")
	_init("msg_script_436_onhplower_20")
	_init("msg_script_436_onhplower_40")
	_init("msg_script_436_onhplower_60")
	_init("msg_script_436_onhplower_80")
	_init("msg_script_436_ondead")
	_init("msg_script_436_onarrive")
	_init("msg_script_436_onarrive_4")
	_init("msg_script_436_onarrive_7")
	_init("msg_script_436_onarrive_11")
	_init("msg_script_436_onarrive_17")
	_init("msg_script_436_onarrive_23")
	_init("msg_script_436_ontaskaccept")

	_init("msg_script_4417_onhplower_0")
	_init("msg_script_4417_onhplower_20")
	_init("msg_script_4417_onhplower_40")
	_init("msg_script_4417_onhplower_60")
	_init("msg_script_4417_onhplower_80")
	_init("msg_script_4417_ondead")
	_init("msg_script_4417_onarrive")
	_init("msg_script_4417_ontaskaccept")

	_init("msg_script_4504_onhplower_0")
	_init("msg_script_4504_onhplower_20")
	_init("msg_script_4504_onhplower_40")
	_init("msg_script_4504_onhplower_60")
	_init("msg_script_4504_onhplower_80")
	_init("msg_script_4504_ondead")
	_init("msg_script_4504_onarrive")
	_init("msg_script_4504_onarrive_4")
	_init("msg_script_4504_onarrive_7")
	_init("msg_script_4504_onarrive_11")
	_init("msg_script_4504_onarrive_17")
	_init("msg_script_4504_onarrive_23")
	_init("msg_script_4504_ontaskaccept")

	_init("msg_script_4635_onhplower_0")
	_init("msg_script_4635_onhplower_20")
	_init("msg_script_4635_onhplower_40")
	_init("msg_script_4635_onhplower_60")
	_init("msg_script_4635_onhplower_80")
	_init("msg_script_4635_ondead")
	_init("msg_script_4635_onarrive")
	_init("msg_script_4635_onarrive_4")
	_init("msg_script_4635_onarrive_7")
	_init("msg_script_4635_onarrive_11")
	_init("msg_script_4635_onarrive_17")
	_init("msg_script_4635_onarrive_23")
	_init("msg_script_4635_ontaskaccept")

	_init("msg_script_4695_onhplower_0")
	_init("msg_script_4695_onhplower_20")
	_init("msg_script_4695_onhplower_40")
	_init("msg_script_4695_onhplower_60")
	_init("msg_script_4695_onhplower_80")
	_init("msg_script_4695_ondead")
	_init("msg_script_4695_onarrive")
	_init("msg_script_4695_onarrive_6")
	_init("msg_script_4695_onarrive_9")
	_init("msg_script_4695_onarrive_13")
	_init("msg_script_4695_onarrive_18")
	_init("msg_script_4695_onarrive_24")
	_init("msg_script_4695_ontaskaccept")

	_init("msg_script_101_onbecaptured")
	_init("msg_script_101_onarrive")
	_init("msg_script_158_onactive_1")
	_init("msg_script_158_onactive_2")
	_init("msg_script_158_ontalk")
	_init("msg_script_158_ondead")
	_init("msg_script_157_onactive")
	_init("msg_script_159_fenshen")
	_init("msg_script_51_onbecaptured")
	_init("msg_script_51_onarrive")
	_init("msg_script_267_onrunaway")
	_init("msg_script_323_onactive")
	_init("msg_script_118_onbecaptured")
	_init("msg_script_118_onarrive")
	_init("msg_script_3014_onstartduel")
	_init("msg_script_3014_onendduel_win")
	_init("msg_script_3014_onendduel_lost")
	_init("msg_script_4584_onstartduel")
	_init("msg_script_4584_onendduel_win")
	_init("msg_script_4584_onendduel_lost")
	_init("msg_script_4591_onstartduel")
	_init("msg_script_4591_onendduel_win")
	_init("msg_script_4591_onendduel_lost")
	_init("msg_script_3104_onstartduel")
	_init("msg_script_3104_onendduel_win")
	_init("msg_script_3104_onendduel_lost")
	_init("msg_script_3209_onstartduel")
	_init("msg_script_3209_onendduel_win")
	_init("msg_script_3209_onendduel_lost")
	_init("msg_script_3314_onstartduel")
	_init("msg_script_3314_onendduel_win")
	_init("msg_script_3314_onendduel_lost")

	_init("msg_script_4664_ondead")
	_init("msg_script_4667_ondead")
	_init("msg_script_4675_onhplower_35")
	_init("msg_script_4760")
	_init("msg_script_4761")
	_init("msg_script_4837")
	_init("msg_script_4838")

	_init("msg_script_4937_onhplower_0")
	_init("msg_script_4937_onhplower_20")
	_init("msg_script_4937_onhplower_40")
	_init("msg_script_4937_onhplower_60")
	_init("msg_script_4937_onhplower_80")
	_init("msg_script_4937_ondead")
	_init("msg_script_4937_onarrive")
	_init("msg_script_4937_onarrive_6")
	_init("msg_script_4937_onarrive_9")
	_init("msg_script_4937_onarrive_13")
	_init("msg_script_4937_onarrive_18")
	_init("msg_script_4937_onarrive_24")
	_init("msg_script_4937_ontaskaccept")

	_init("msg_script_4945_onactive")

	_init("msg_script_4935a1_onhplower_80")
	_init("msg_script_4935a3_onhplower_80")
	_init("msg_script_4935a5_onhplower_80")
	_init("msg_script_4935a7_onhplower_80")
	_init("msg_script_4935a9_onhplower_80")
	_init("msg_script_4935b1_onhplower_50")
	_init("msg_script_4935b3_onhplower_50")
	_init("msg_script_4935b5_onhplower_50")
	_init("msg_script_4935b7_onhplower_50")
	_init("msg_script_4935b9_onhplower_50")
	_init("msg_script_4935c1_onhplower_20")
	_init("msg_script_4935c3_onhplower_20")
	_init("msg_script_4935c5_onhplower_20")
	_init("msg_script_4935c7_onhplower_20")
	_init("msg_script_4935c9_onhplower_20")
	_init("msg_script_4935d1_onhplower_0")
	_init("msg_script_4935d3_onhplower_0")
	_init("msg_script_4935d5_onhplower_0")

	_init("msg_script_5026_onhplower_0")
	_init("msg_script_5026_onhplower_20")
	_init("msg_script_5026_onhplower_40")
	_init("msg_script_5026_onhplower_60")
	_init("msg_script_5026_onhplower_80")
	_init("msg_script_5026_ondead")
	_init("msg_script_5026_onarrive")
	_init("msg_script_5026_onarrive_6")
	_init("msg_script_5026_onarrive_9")
	_init("msg_script_5026_onarrive_13")
	_init("msg_script_5026_onarrive_18")
	_init("msg_script_5026_onarrive_24")
	_init("msg_script_5026_ontaskaccept")

	_init("msg_script_1428_onstartduel")
	_init("msg_script_1428_onendduel_win")
	_init("msg_script_1428_onendduel_lost")
	_init("msg_script_1429_onstartduel")
	_init("msg_script_1429_onendduel_win")
	_init("msg_script_1429_onendduel_lost")
	_init("msg_script_1430_onstartduel")
	_init("msg_script_1430_onendduel_win")
	_init("msg_script_1430_onendduel_lost")
	_init("msg_script_1431_onstartduel")
	_init("msg_script_1431_onendduel_win")
	_init("msg_script_1431_onendduel_lost")
	_init("msg_script_1432_onstartduel")
	_init("msg_script_1432_onendduel_win")
	_init("msg_script_1432_onendduel_lost")

	_init("msg_script_4970d1_onhplower_0")
	_init("msg_script_4970d3_onhplower_0")
	_init("msg_script_4970d5_onhplower_0")
	_init("msg_script_4977d1_onhplower_0")
	_init("msg_script_4977d3_onhplower_0")
	_init("msg_script_4977d5_onhplower_0")
	_init("msg_script_4983d1_onhplower_0")
	_init("msg_script_4983d3_onhplower_0")
	_init("msg_script_4983d5_onhplower_0")
	_init("msg_script_4998d1_onhplower_0")
	_init("msg_script_4998d3_onhplower_0")
	_init("msg_script_4998d5_onhplower_0")
	_init("msg_script_5001d1_onhplower_0")
	_init("msg_script_5001d3_onhplower_0")
	_init("msg_script_5001d5_onhplower_0")
	_init("msg_script_5003d1_onhplower_0")
	_init("msg_script_5003d3_onhplower_0")
	_init("msg_script_5003d5_onhplower_0")

	_init("msg_script_5031d1_onhplower_0")
	_init("msg_script_5031d3_onhplower_0")
	_init("msg_script_5031d5_onhplower_0")
	_init("msg_script_5034d1_onhplower_0")
	_init("msg_script_5034d3_onhplower_0")
	_init("msg_script_5034d5_onhplower_0")
	_init("msg_script_5035d1_onhplower_0")
	_init("msg_script_5035d3_onhplower_0")
	_init("msg_script_5035d5_onhplower_0")








end

function _init(str_id)
	AILanguage[str_id]	= LoadScriptString(str_id)
end

function Lan(str_id)
	if AILanguage[str_id]==nil then
		return "unknown string"
	else 
		return AILanguage[str_id]
	end
end