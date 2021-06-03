-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIUnlocker =
{
	interfaceId = "SIUnlocker" ,
	remoteKey =
	{
		AddItem          = "AddItem" ,
		RestoreForceData = "RestoreForceData" ,
		GetForceData     = "GetForceData"
	} ,
	
	-- 触发器类型 , 参数列表见下放数据结构
	condition =
	{
		kill     = "kill" ,     -- 玩家击杀数
		has      = "has" ,      -- 玩家持有数 , 要求物品在同一个背包内
		craft    = "craft" ,    -- 玩家手搓数
		research = "research" , -- 科技完成时
		build    = "build" ,    -- 玩家建造数
		mine     = "mine" ,     -- 玩家挖掘数
		use      = "use" ,      -- 玩家投掷数
		mute     = "mute" ,     -- 玩家被禁言
		die      = "die"        -- 玩家死亡
	} ,
	-- 回报类型 , 参数列表见下放数据结构
	result =
	{
		addRecipe        = "addR" ,  -- 解锁配方
		removeRecipe     = "remR" ,  -- 重新锁定配方
		
		addItem          = "addI" ,  -- 添加物品 , 添加到玩家的背包 , 当最终由 SIUnlocker.condition.research 触发项目时此项无效
		removeItem       = "remI" ,  -- 移除物品 , 添加到玩家的背包 , 当最终由 SIUnlocker.condition.research 触发项目时此项无效
		clearItem        = "cleI" ,  -- 清空物品 , 添加到玩家的背包 , 当最终由 SIUnlocker.condition.research 触发项目时此项无效
		
		addSpeedCrafting = "addSC" , -- 提高手搓速度
		remSpeedCrafting = "remSC" , -- 降低手搓速度
		setSpeedCrafting = "setSC" , -- 设置手搓速度
		addSpeedMining   = "addSM" , -- 提高挖掘速度
		remSpeedMining   = "remSM" , -- 降低挖掘速度
		setSpeedMining   = "setSM" , -- 设置挖掘速度
		addSpeedRunning  = "addSR" , -- 提高移动速度
		remSpeedRunning  = "remSR" , -- 降低移动速度
		setSpeedRunning  = "setSR" , -- 设置移动速度
		
		messageForce     = "msgF" ,  -- 给阵营的玩家发送消息
		messagePlayer    = "msgP"    -- 给最终触发的玩家发送消息 , 当最终由 SIUnlocker.condition.research 触发项目时此项无效
	}
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 接口方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- --------------------------------------------------------
-- 添加项目 , 应该在 control.init 阶段添加
-- 即应该在 script.on_init 或 script.on_configuration_changed 的时候添加
-- 如果使用 SIEventBus 则为 SIEventBus.Init 的时候添加
-- --------------------------------------------------------
-- 数据结构
-- item =
-- {
--   id = "项目的 id" ,
--   version = 版本 ,                   -- 数字 , 相同版本的项目将不会互相覆盖
--   name = { "本地化字符串" } ,        -- 显示名称
--   description = { "本地化字符串" } , -- 显示描述
--   conditions = -- 触发器
--   {
--     -- 以下条件仅对玩家操作生效 , 同一阵营的玩家数量累计
--     -- 采取单项满足的策略 , 所有条件不需要同时满足
--     {
--       type = SIUnlocker.condition.kill , -- 玩家击杀数
--       name = "实体的 id" ,
--       count = 击杀的次数 ,
--       damageType = "攻击类型的 id" -- 可选
--       -- cur = 数字 -- 自动填写 , 注册时不需要填 , 当前数量进度 , 默认为 nil , 触发过这个条件之后才会有数字
--     } ,
--     {
--       type = SIUnlocker.condition.has , -- 玩家持有数 , 要求物品在同一个背包内
--       name = "物品的 id" ,
--       count = 拥有的数量
--     } ,
--     {
--       type = SIUnlocker.condition.craft , -- 玩家手搓数
--       name = "配方的 id" ,
--       count = 合成的次数
--       -- cur = 数字 -- 自动填写 , 注册时不需要填 , 当前数量进度 , 默认为 nil , 触发过这个条件之后才会有数字
--     } ,
--     {
--       type = SIUnlocker.condition.research , -- 科技完成时
--       name = "科技的 id" ,
--       level = 研究的等级 -- 仅对无限科技有效
--     } ,
--     {
--       type = SIUnlocker.condition.build , -- 玩家建造数
--       name = "实体的 id" ,
--       count = 建造的数量
--       -- cur = 数字 -- 自动填写 , 注册时不需要填 , 当前数量进度 , 默认为 nil , 触发过这个条件之后才会有数字
--     } ,
--     {
--       type = SIUnlocker.condition.mine , -- 玩家挖掘数
--       name = "实体的 id" ,
--       count = 挖掘的数量
--       -- cur = 数字 -- 自动填写 , 注册时不需要填 , 当前数量进度 , 默认为 nil , 触发过这个条件之后才会有数字
--     } ,
--     {
--       type = SIUnlocker.condition.use , -- 玩家投掷数
--       name = "物品的 id" ,
--       count = 投掷的数量
--       -- cur = 数字 -- 自动填写 , 注册时不需要填 , 当前数量进度 , 默认为 nil , 触发过这个条件之后才会有数字
--     } ,
--     {
--       type = SIUnlocker.condition.mute -- 玩家被禁言
--     } ,
--     {
--       type = SIUnlocker.condition.die , -- 玩家死亡
--       name = "凶手实体的 id" ,
--       count = 死亡的次数
--       -- cur = 数字 -- 自动填写 , 注册时不需要填 , 当前数量进度 , 默认为 nil , 触发过这个条件之后才会有数字
--     }
--   } ,
--   results =
--   {
--     -- 按照实际定义的顺序逐个执行
--     {
--       type = SIUnlocker.result.addRecipe , -- 解锁配方
--       name = "配方的 id"
--     } ,
--     {
--       type = SIUnlocker.result.removeRecipe , -- 重新锁定配方
--       name = "配方的 id"
--     } ,
--     {
--       type = SIUnlocker.result.addItem , -- 添加物品 , 添加到玩家的背包 , 当最终由 SIUnlocker.condition.research 触发项目时此项无效
--       name = "物品的 id" ,
--       count = 数量
--     } ,
--     {
--       type = SIUnlocker.result.removeItem , -- 移除物品 , 添加到玩家的背包 , 当最终由 SIUnlocker.condition.research 触发项目时此项无效
--       name = "物品的 id" ,
--       count = 数量
--     } ,
--     {
--       type = SIUnlocker.result.clearItem , -- 清空物品 , 添加到玩家的背包 , 当最终由 SIUnlocker.condition.research 触发项目时此项无效
--       name = "物品的 id"
--     } ,
--
--     {
--       type = SIUnlocker.result.addSpeedCrafting , -- 提高手搓速度
--       value = 增长的数值 ,
--     } ,
--     {
--       type = SIUnlocker.result.remSpeedCrafting , -- 降低手搓速度
--       value = 降低的数值 ,
--     } ,
--     {
--       type = SIUnlocker.result.setSpeedCrafting , -- 设置手搓速度
--       value = 设置的数值 ,
--     } ,
--     {
--       type = SIUnlocker.result.addSpeedMining , -- 提高挖掘速度
--       value = 增长的数值 ,
--     } ,
--     {
--       type = SIUnlocker.result.remSpeedMining , -- 降低挖掘速度
--       value = 降低的数值 ,
--     } ,
--     {
--       type = SIUnlocker.result.setSpeedMining , -- 设置挖掘速度
--       value = 设置的数值 ,
--     } ,
--     {
--       type = SIUnlocker.result.addSpeedRunning , -- 提高移动速度
--       value = 增长的数值 ,
--     } ,
--     {
--       type = SIUnlocker.result.remSpeedRunning , -- 降低移动速度
--       value = 降低的数值 ,
--     } ,
--     {
--       type = SIUnlocker.result.setSpeedRunning , -- 设置移动速度
--       value = 设置的数值 ,
--     } ,
--
--     {
--       type = SIUnlocker.result.messageForce , -- 给阵营的玩家发送消息
--       message = { "本地化字符串" } ,
--       sendToTrigger = 是否给最终触发的玩家发送消息 -- 对于 SIUnlocker.condition.research 此项无效且强制为 true
--     } ,
--     {
--       type = SIUnlocker.result.messagePlayer , -- 给最终触发的玩家发送消息 , 当最终由 SIUnlocker.condition.research 触发项目时此项无效
--       message = { "本地化字符串" }
--     }
--   } ,
--   repeatSettings = -- 可选项目 , 默认触发一次
--   {
--     maxCount = 数字 -- 重复的最大次数 , 只有触发次数达到这个数字的时候 , 项目才不会被再次触发 , -1 表示无限次
--   }
--   -- repeatCount = 触发过的次数 -- 自动填写 , 注册时不需要填 , 触发过的次数 , 默认为 nil , 触发项目之后才会有数字
-- }
-- --------------------------------------------------------
function SIUnlocker.AddItem( item )
	return remote.call( SIUnlocker.interfaceId , SIUnlocker.remoteKey.AddItem , item )
end

-- --------------------------------------------------------
-- 重置指定阵营的所有项目
-- --------------------------------------------------------
function SIUnlocker.RestoreForceData( forceName )
	return remote.call( SIUnlocker.interfaceId , SIUnlocker.remoteKey.RestoreForceData , forceName )
end

-- --------------------------------------------------------
-- 获取指定阵营的数据 , 只读
-- --------------------------------------------------------
-- 在 forceData.eventList 中
-- 已完成的项目会被移除而不是标记 "已完成"
-- --------------------------------------------------------
-- 在 forceData.eventList.item.conditions 中
-- 每一个项目都会增加一个 cur 变量 , 来记录当前的完成进度
-- 已完成的项目会被移除而不是标记 "已完成"
-- --------------------------------------------------------
function SIUnlocker.GetForceData( forceName )
	return remote.call( SIUnlocker.interfaceId , SIUnlocker.remoteKey.GetForceData , forceName )
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 构造方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

