-- ------------------------------------------------------------------------------------------------
-- ---------- 添加引用 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if not SIEventBus then e( "模块使用：必须启用 SIEventBus 之后才能使用 SIUnlocker 模块" ) end
if not SIGlobal then e( "模块使用：必须启用 SIGlobal 之后才能使用 SIUnlocker 模块" ) end

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIUnlocker =
{
	condition =
	{
		kill     = "kill" ,
		has      = "has" ,
		craft    = "craft" ,
		research = "research" ,
		build    = "build" ,
		mine     = "mine" ,
		use      = "use" ,
		mute     = "mute" ,
		die      = "die"
	} ,
	result =
	{
		addRecipe        = "addR" ,
		removeRecipe     = "remR" ,
		
		addSpeedCrafting = "addSC" ,
		remSpeedCrafting = "remSC" ,
		setSpeedCrafting = "setSC" ,
		addSpeedMining   = "addSM" ,
		remSpeedMining   = "remSM" ,
		setSpeedMining   = "setSM" ,
		addSpeedRunning  = "addSR" ,
		remSpeedRunning  = "remSR" ,
		setSpeedRunning  = "setSR" ,
		
		messageForce     = "msgF" ,
		messagePlayer    = "msgP"
	} ,
	defaultForceData =
	{
		canTrigger = true ,
		eventList = {} ,
		arguments =
		{
			speedCrafting = 0 ,
			speedMining   = 0 ,
			speedRunning  = 0
		}
	}
}

SIUnlocker.eventMap[SIUnlocker.condition.kill]     = SIEvents.on_entity_died
SIUnlocker.eventMap[SIUnlocker.condition.has]      = SIEvents.on_player_main_inventory_changed
SIUnlocker.eventMap[SIUnlocker.condition.craft]    = SIEvents.on_player_crafted_item
SIUnlocker.eventMap[SIUnlocker.condition.research] = SIEvents.on_research_finished
SIUnlocker.eventMap[SIUnlocker.condition.build]    = SIEvents.on_built_entity
SIUnlocker.eventMap[SIUnlocker.condition.mine]     = SIEvents.on_player_mined_entity
SIUnlocker.eventMap[SIUnlocker.condition.use]      = SIEvents.on_player_used_capsule
SIUnlocker.eventMap[SIUnlocker.condition.mute]     = SIEvents.on_player_muted
SIUnlocker.eventMap[SIUnlocker.condition.die]      = SIEvents.on_player_died

SIGlobal.Create( "SIUnlockerItems" )
SIGlobal.Create( "SIUnlockerForceData" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 项目操作 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- item =
-- {
--   id = "项目的 id" ,
--   conditions = -- 触发器
--   {
--     -- 以下条件仅对玩家操作生效 , 同一阵营的玩家数量累计
--     -- 采取单项满足的策略 , 所有条件不需要同时满足
--     {
--       type = SIUnlocker.condition.kill , -- 玩家击杀数
--       name = "实体的 id" ,
--       count = 击杀的次数
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
--     } ,
--     {
--       type = SIUnlocker.condition.mine , -- 玩家挖掘数
--       name = "实体的 id" ,
--       count = 挖掘的数量
--     } ,
--     {
--       type = SIUnlocker.condition.use , -- 玩家投掷数
--       name = "物品的 id" ,
--       count = 投掷的数量
--     } ,
--     {
--       type = SIUnlocker.condition.mute -- 玩家被禁言
--     } ,
--     {
--       type = SIUnlocker.condition.die , -- 玩家死亡
--       name = "凶手实体的 id" ,
--       count = 死亡的次数
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
--       sendToTrigger = 是否给最终触发的玩家发送消息
--     } ,
--     {
--       type = SIUnlocker.result.messagePlayer , -- 给最终触发的玩家发送消息
--       message = { "本地化字符串" }
--     }
--   }
-- }
function SIUnlocker.AddItem( item )
	if not item or not item.id or not item.conditions or not item.results then return SIUnlocker , false end
	local oldItem = SIUnlockerItems[item.id]
	if oldItem then
		SIUnlocker.RemoveOldItemFromForceData( oldItem )
	end
	SIUnlockerItems[item.id] = item
	SIUnlocker.AddNewItemToForceData( item )
	return SIUnlocker , true
end

function SIUnlocker.RestoreForceData( forceName )
	local forceData = SIUnlocker.GetForceData( forceName )
	SIUnlocker.InitForceData( forceData )
	return SIUnlocker , true
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 功能方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- --------------------------------------------------------
-- 在 forceData.eventList 中
-- 已完成的项目会被移除而不是标记 "已完成"
-- --------------------------------------------------------
-- 在 forceData.eventList.item.conditions 中
-- 每一个项目都会增加一个 cur 变量 , 来记录当前的完成进度
-- 已完成的项目会被移除而不是标记 "已完成"
-- --------------------------------------------------------
function SIUnlocker.GetForceData( forceName )
	local forceData = SIUnlockerForceData[forceName]
	if not forceData then
		forceData = table.deepcopy( SIUnlocker.defaultForceData )
		SIUnlockerForceData[forceName] = forceData
		SIUnlocker.InitForceData( forceData )
	end
	return forceData
end

function SIUnlocker.InitForceData( forceData )
	for id , item in pairs( SIUnlockerItems ) do
		SIUnlocker.AddItemToForceData( forceData , item )
	end
end

function SIUnlocker.AddNewItemToForceData( item )
	for name , forceData in pairs( SIUnlockerForceData ) do
		SIUnlocker.AddItemToForceData( forceData , item )
	end
end

function SIUnlocker.RemoveOldItemFromForceData( item )
	for name , data in pairs( SIUnlockerForceData ) do
		SIUnlocker.RemoveItemFromForceData( forceData , item )
	end
end



function SIUnlocker.AddItemToForceData( forceData , item )
	for index , condition in pairs( item.conditions ) do
		local list = forceData.eventList[condition.type]
		if not list then
			list = {}
			forceData.eventList[condition.type] = list
		end
		list[item.id] = item
	end
end

function SIUnlocker.RemoveItemFromForceData( forceData , item )
	for index , condition in pairs( item.conditions ) do
		local list = forceData.eventList[condition.type]
		list[item.id] = nil
		if table.Size( list ) < 1 then forceData.eventList[condition.type] = nil end
	end
end

function SIUnlocker.FireItem( forceData , item , force , player )
	SIUnlocker.RemoveItemFromForceData( forceData , item )
	for index , result in pairs( item.results ) do
		-- 解锁配方
		if result.type == SIUnlocker.result.addRecipe then force.recipes[result.name].enabled = true
		elseif result.type == SIUnlocker.result.removeRecipe then force.recipes[result.name].enabled = false
		-- 速度设置
		elseif result.type == SIUnlocker.result.addSpeedCrafting then
			force.manual_crafting_speed_modifier = force.manual_crafting_speed_modifier + result.value
			forceData.speedCrafting = forceData.speedCrafting + result.value
		elseif result.type == SIUnlocker.result.remSpeedCrafting then
			force.manual_crafting_speed_modifier = force.manual_crafting_speed_modifier - result.value
			forceData.speedCrafting = forceData.speedCrafting - result.value
		elseif result.type == SIUnlocker.result.setSpeedCrafting then
			force.manual_crafting_speed_modifier = force.manual_crafting_speed_modifier - forceData.speedCrafting + result.value
			forceData.speedCrafting = result.value
		elseif result.type == SIUnlocker.result.addSpeedMining then
			force.manual_mining_speed_modifier = force.manual_mining_speed_modifier + result.value
			forceData.speedMining = forceData.speedMining + result.value
		elseif result.type == SIUnlocker.result.remSpeedMining then
			force.manual_mining_speed_modifier = force.manual_mining_speed_modifier - result.value
			forceData.speedMining = forceData.speedMining - result.value
		elseif result.type == SIUnlocker.result.setSpeedMining then
			orce.manual_mining_speed_modifier = force.manual_mining_speed_modifier - forceData.speedMining + result.value
			forceData.speedMining = result.value
		elseif result.type == SIUnlocker.result.addSpeedRunning then
			force.character_running_speed_modifier = force.character_running_speed_modifier + result.value
			forceData.speedRunning = forceData.speedRunning + result.value
		elseif result.type == SIUnlocker.result.remSpeedRunning then
			force.character_running_speed_modifier = force.character_running_speed_modifier - result.value
			forceData.speedRunning = forceData.speedRunning - result.value
		elseif result.type == SIUnlocker.result.setSpeedRunning then
			force.character_running_speed_modifier = force.character_running_speed_modifier - forceData.speedRunning + result.value
			forceData.speedRunning = result.value
		-- 发送消息
		elseif result.type == SIUnlocker.result.messageForce then
			if result.sendToTrigger then force.print( result.message )
			else
				for index , forcePlayer in pairs( force.players ) do
					if forcePlayer.index ~= player.index then forcePlayer.print( result.message ) end
				end
			end
		elseif result.type == SIUnlocker.result.messagePlayer then player.print( result.message ) end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIUnlocker.OnKill( event )
	local cause = event.cause
	if cause and cause.valid and cause.player then
		local entity = event.entity
		if entity and entity.valid then
			local name = entity.name
			local force = cause.force
			local player = cause.player
			local forceData = SIUnlocker.GetForceData( force.name )
			if forceData.eventList[event.name] then
				for id , item in pairs( forceData.eventList[event.name] ) do
					for index , condition in pairs( item.conditions ) do
						if condition.type == SIUnlocker.condition.kill and condition.name == name then
							if not condition.cur then condition.cur = 1
							else condition.cur = condition.cur + 1 end
							if condition.cur >= condition.count then item.conditions[index] = nil end
						end
					end
					if table.Size( item.conditions ) < 1 then SIUnlocker.FireItem( forceData , item , force , player ) end
					if not forceData.eventList[event.name] then break end
				end
			end
		end
	end
end

function SIUnlocker.OnHas( event )
	
end

function SIUnlocker.OnCraft( event )
	
end

function SIUnlocker.OnResearch( event )
	
end

function SIUnlocker.OnBuild( event )
	
end

function SIUnlocker.OnMine( event )
	
end

function SIUnlocker.OnUse( event )
	
end

function SIUnlocker.OnMute( event )
	
end

function SIUnlocker.OnDie( event )
	
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 事件注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus
.Add( SIUnlocker.eventMap[SIUnlocker.condition.kill]     , SIUnlocker.OnKill )
.Add( SIUnlocker.eventMap[SIUnlocker.condition.has]      , SIUnlocker.OnHas )
.Add( SIUnlocker.eventMap[SIUnlocker.condition.craft]    , SIUnlocker.OnCraft )
.Add( SIUnlocker.eventMap[SIUnlocker.condition.research] , SIUnlocker.OnResearch )
.Add( SIUnlocker.eventMap[SIUnlocker.condition.build]    , SIUnlocker.OnBuild )
.Add( SIUnlocker.eventMap[SIUnlocker.condition.mine]     , SIUnlocker.OnMine )
.Add( SIUnlocker.eventMap[SIUnlocker.condition.use]      , SIUnlocker.OnUse )
.Add( SIUnlocker.eventMap[SIUnlocker.condition.mute]     , SIUnlocker.OnMute )
.Add( SIUnlocker.eventMap[SIUnlocker.condition.die]      , SIUnlocker.OnDie )