
--全局的游戏数据配置

--npc分布倍率
NpcAssignRate = 1

--副本的极限存在时间 （分钟）
MaxEctypeExistTime = 720

--个人1小时内能创建的最多副本数量
UserCreateEctypeNum = 10

--服务器最多同时存在的副本数量
MaxEctypeNum = 200

--是否生成npc--调试用
IsCreateNpc = true

--每个npc掉落道具最大数量
MaxDropItemNum = 10

--道具掉落概率
ItemDropRate = 1

--金钱掉落概率
GoldDropRate = 1

--绿色装备掉落概率
GreenItemDropRate = 1

--蓝色装备掉落概率
BlueItemDropRate = 1

--金色装备掉落概率
GoldenItemDropRate = 1

--经验比率
ExpRate = 1

--灵气比率
NimbusRate = 1

--宠物经验比率
PetExpRate = 2

--世界频道每分钟最多发言次数
WorldChatLimit = 1

--城战区域配置
WarArea = {}
WarArea[0] = { 1, 6, 20, 0 } -- format: id, weekday, hour, minute

--组队经验分配比率
TeamExp = 
{
    [2] = 1.05,
    [3] = 1.1,
    [4] = 1.15,
    [5] = 1.2
}

TeamNimbus = 
{
    [2] = 1.05,
    [3] = 1.1,
    [4] = 1.15,
    [5] = 1.2
}

