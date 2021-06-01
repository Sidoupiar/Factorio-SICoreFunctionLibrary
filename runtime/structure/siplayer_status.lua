-- ------------------------------------------------------------------------------------------------
-- ---------- 添加引用 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if not SIEventBus then e( "模块使用[SIPlayerStatus] : 必须启用 SIEventBus 之后才能使用 SIPlayerStatus 模块" ) end
if not SIGlobal then e( "模块使用[SIPlayerStatus] : 必须启用 SIGlobal 之后才能使用 SIPlayerStatus 模块" ) end

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIPlayerStatus =
{
	statusName =
	{
		health             = "h" ,
		slotInv            = "si" ,
		slotTrash          = "st" ,
		robotCount         = "rc" ,
		speedCrafting      = "sc" ,
		speedMining        = "sm" ,
		speedRunning       = "sr" ,
		distanceBuild      = "db" ,
		distanceDrop       = "dd" ,
		distanceReach      = "dr" ,
		distanceReachRes   = "drr" ,
		distancePickupItem = "dpi" ,
		distancePickupLoot = "dpl"
	} ,
	valueCode =
	{
		health             = "h" ,
		slotInv            = "si" ,
		slotTrash          = "st" ,
		robotCount         = "rc" ,
		speedCrafting      = "sc" ,
		speedMining        = "sm" ,
		speedRunning       = "sr" ,
		distanceBuild      = "db" ,
		distanceDrop       = "dd" ,
		distanceReach      = "dr" ,
		distanceReachRes   = "drr" ,
		distancePickupItem = "dpi" ,
		distancePickupLoot = "dpl"
	} ,
	miningTypeName = "mt" , -- character_additional_mining_categories
	checkDelay = 6 ,
	
	defaultPlayerData =
	{
		id = nil ,
		level = 0 ,
		experience = 0 ,
		pointCountLevel = 0 ,
		pointCountAdd = 0 ,
		pointCountTotal = 0 ,
		pointCountUsed = 0 ,
		statusPointUsage = {} ,
		statusAdd = {} ,
		statusTotal = {} ,
		buff = {} ,
		currentValue = {}
	} ,
	defaultLevel = 0 ,
	defaultExperience = 0 ,
	defaultPointCount = 0 ,
	defaultStatusValue = 0 ,
	defaultCurrentValue = 0
}

SIPlayerStatus.statusValue =
{
	[SIPlayerStatus.statusName.health]             = { { code = SIPlayerStatus.valueCode.health             , size = 1    } } ,
	[SIPlayerStatus.statusName.slotInv]            = { { code = SIPlayerStatus.valueCode.slotInv            , size = 1    } } ,
	[SIPlayerStatus.statusName.slotTrash]          = { { code = SIPlayerStatus.valueCode.slotTrash          , size = 1    } } ,
	[SIPlayerStatus.statusName.robotCount]         = { { code = SIPlayerStatus.valueCode.robotCount         , size = 1    } } ,
	[SIPlayerStatus.statusName.speedCrafting]      = { { code = SIPlayerStatus.valueCode.speedCrafting      , size = 0.01 } } ,
	[SIPlayerStatus.statusName.speedMining]        = { { code = SIPlayerStatus.valueCode.speedMining        , size = 0.01 } } ,
	[SIPlayerStatus.statusName.speedRunning]       = { { code = SIPlayerStatus.valueCode.speedRunning       , size = 0.01 } } ,
	[SIPlayerStatus.statusName.distanceBuild]      = { { code = SIPlayerStatus.valueCode.distanceBuild      , size = 0.1  } } ,
	[SIPlayerStatus.statusName.distanceDrop]       = { { code = SIPlayerStatus.valueCode.distanceDrop       , size = 0.1  } } ,
	[SIPlayerStatus.statusName.distanceReach]      = { { code = SIPlayerStatus.valueCode.distanceReach      , size = 0.1  } } ,
	[SIPlayerStatus.statusName.distanceReachRes]   = { { code = SIPlayerStatus.valueCode.distanceReachRes   , size = 0.1  } } ,
	[SIPlayerStatus.statusName.distancePickupItem] = { { code = SIPlayerStatus.valueCode.distancePickupItem , size = 0.1  } } ,
	[SIPlayerStatus.statusName.distancePickupLoot] = { { code = SIPlayerStatus.valueCode.distancePickupLoot , size = 0.1  } }
}

SIPlayerStatus.valueMap =
{
	[SIPlayerStatus.valueCode.health]             = { name = "character_health_bonus"                        , min = 0  , max = 100000000 , isInt = true  } ,
	[SIPlayerStatus.valueCode.slotInv]            = { name = "character_inventory_slots_bonus"               , min = 0  , max = 100000000 , isInt = true  } ,
	[SIPlayerStatus.valueCode.slotTrash]          = { name = "character_trash_slot_count_bonus"              , min = 0  , max = 100000000 , isInt = true  } ,
	[SIPlayerStatus.valueCode.robotCount]         = { name = "character_maximum_following_robot_count_bonus" , min = 0  , max = 100000000 , isInt = true  } ,
	[SIPlayerStatus.valueCode.speedCrafting]      = { name = "character_crafting_speed_modifier"             , min = -1 , max = 100000000 , isInt = false } ,
	[SIPlayerStatus.valueCode.speedMining]        = { name = "character_mining_speed_modifier"               , min = -1 , max = 100000000 , isInt = false } ,
	[SIPlayerStatus.valueCode.speedRunning]       = { name = "character_running_speed_modifier"              , min = -1 , max = 100000000 , isInt = false } ,
	[SIPlayerStatus.valueCode.distanceBuild]      = { name = "character_build_distance_bonus"                , min = 0  , max = 100000000 , isInt = true  } ,
	[SIPlayerStatus.valueCode.distanceDrop]       = { name = "character_item_drop_distance_bonus"            , min = 0  , max = 100000000 , isInt = true  } ,
	[SIPlayerStatus.valueCode.distanceReach]      = { name = "character_reach_distance_bonus"                , min = 0  , max = 100000000 , isInt = true  } ,
	[SIPlayerStatus.valueCode.distanceReachRes]   = { name = "character_resource_reach_distance_bonus"       , min = 0  , max = 100000000 , isInt = true  } ,
	[SIPlayerStatus.valueCode.distancePickupItem] = { name = "character_item_pickup_distance_bonus"          , min = 0  , max = 100000000 , isInt = true  } ,
	[SIPlayerStatus.valueCode.distancePickupLoot] = { name = "character_loot_pickup_distance_bonus"          , min = 0  , max = 100000000 , isInt = true  }
}

SIGlobal.Create( "SIPlayerStatusData" )
SIGlobal.Create( "SIPlayerStatusDataList" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 项目操作 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 返回等级和属性点数
function SIPlayerStatus.CalculateLevel( experience )
	return 1 , 1
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 项目操作 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPlayerStatus.GetLevel( playerIndex )
	local playerData = SIPlayerStatus.GetPlayerData( playerIndex )
	return playerData.level or SIPlayerStatus.defaultLevel
end



function SIPlayerStatus.AddExperience( playerIndex , count )
	local playerData = SIPlayerStatus.GetPlayerData( playerIndex )
	SIPlayerStatus.FreshLevel( playerData , count )
	return SIPlayerStatus
end

function SIPlayerStatus.RemoveExperience( playerIndex , count )
	local playerData = SIPlayerStatus.GetPlayerData( playerIndex )
	SIPlayerStatus.FreshLevel( playerData , -count )
	return SIPlayerStatus
end

function SIPlayerStatus.GetExperience( playerIndex )
	local playerData = SIPlayerStatus.GetPlayerData( playerIndex )
	return playerData.experience or SIPlayerStatus.defaultExperience
end



function SIPlayerStatus.AddStatusByUsePoint( playerIndex , statusName , count )
	local playerData = SIPlayerStatus.GetPlayerData( playerIndex )
	local totalAdded = SIPlayerStatus.FreshStatus( playerData , statusName , count , true )
	return SIPlayerStatus , totalAdded
end

function SIPlayerStatus.RemoveStatusByUsePoint( playerIndex , statusName , count )
	local playerData = SIPlayerStatus.GetPlayerData( playerIndex )
	local totalRemoved = SIPlayerStatus.FreshStatus( playerData , statusName , -count , true )
	return SIPlayerStatus , totalRemoved
end

function SIPlayerStatus.AddStatus( playerIndex , statusName , count )
	local playerData = SIPlayerStatus.GetPlayerData( playerIndex )
	SIPlayerStatus.FreshStatus( playerData , statusName , count )
	return SIPlayerStatus
end

function SIPlayerStatus.RemoveStatus( playerIndex , statusName , count )
	local playerData = SIPlayerStatus.GetPlayerData( playerIndex )
	SIPlayerStatus.FreshStatus( playerData , statusName , -count )
	return SIPlayerStatus
end

function SIPlayerStatus.GetStatus( playerIndex , statusName )
	local playerData = SIPlayerStatus.GetPlayerData( playerIndex )
	return playerData.statusTotal[statusName] or SIPlayerStatus.defaultStatusValue ,
		playerData.statusPointUsage[statusName] or SIPlayerStatus.defaultStatusValue ,
		playerData.statusAdd[statusName] or SIPlayerStatus.defaultStatusValue
end



-- buffData =
-- {
--   id = "buffId" ,
--   name = { "本地化字符串" } ,
--   description = { "本地化字符串" } ,
--   duration = 7200 , -- 持续时间 , 负数 = 永继 buff
--   removeOnDeath = 是否在死亡时清除这个 buff ,
--   values = -- 效果列表
--   {
--     [SIPlayerStatus.valueCode.xxxx] = { value = 数值 } -- 数值可以是负数
--   }
-- }
function SIPlayerStatus.AddBuff( playerIndex , buffData )
	if not buffData or not buffData.id then
		e( "玩家属性管理器[SIPlayerStatus] : buff 或 buff.id 不能为空" )
		return SIPlayerStatus , false
	end
	local playerData = SIPlayerStatus.GetPlayerData( playerIndex )
	local result = SIPlayerStatus.FreshBuff( playerData , buffData.id , table.deepcopy( buffData ) )
	return SIPlayerStatus , result
end

function SIPlayerStatus.RemoveBuff( playerIndex , buffId )
	local playerData = SIPlayerStatus.GetPlayerData( playerIndex )
	SIPlayerStatus.FreshBuff( playerData , buffId )
	return SIPlayerStatus
end

function SIPlayerStatus.GetBuff( playerIndex , buffId )
	local playerData = SIPlayerStatus.GetPlayerData( playerIndex )
	return playerData.buff[buffId]
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 功能方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPlayerStatus.GetPlayerData( playerIndex )
	local playerData = SIPlayerStatusData[playerIndex]
	if not playerData then
		playerData = table.deepcopy( SIPlayerStatus.defaultPlayerData )
		playerData.id = playerIndex
		SIPlayerStatusData[playerIndex] = playerData
		table.insert( SIPlayerStatusDataList , playerData )
		SIPlayerStatus.InitPlayerData( playerData )
	end
	return playerData
end



function SIPlayerStatus.InitPlayerData( playerData )
	for index , code in pairs( SIPlayerStatus.valueCode ) do
		playerData.currentValue[code] = { total = SIPlayerStatus.defaultCurrentValue , real = SIPlayerStatus.defaultCurrentValue }
	end
	playerData.currentValue[SIPlayerStatus.miningTypeName] = { total = {} , real = {} }
end

function SIPlayerStatus.FreshLevel( playerData , addedExperience )
	playerData.experience = playerData.experience + addedExperience
	local level , pointCount = SIPlayerStatus.CalculateLevel( playerData.experience )
	playerData.level = level
	playerData.pointCountLevel = pointCount
	playerData.pointCountTotal = pointCount + playerData.pointCountAdd or SIPlayerStatus.defaultPointCount
end

function SIPlayerStatus.FreshStatus( playerData , statusName , count , usePoint )
	local oldTotalCount
	local result = 0
	if usePoint then
		local oldCount = playerData.statusPointUsage[statusName] or SIPlayerStatus.defaultStatusValue
		local allowCount
		if count > 0 then
			local pointCountLeft = playerData.pointCountTotal - playerData.pointCountUsed
			allowCount = math.min( count , pointCountLeft ) -- 最多不超过剩余可以用点数
			if allowCount < 0 then return 0 end
		else
			allowCount = math.max( count , -oldCount ) -- 最多不超过在这项属性上已使用的点数 , 当前两个数都是负数
			if allowCount > 0 then return 0 end
		end
		local newCount = oldCount + allowCount -- 应该始终是正数或 0
		oldTotalCount = playerData.statusTotal[statusName] or SIPlayerStatus.defaultStatusValue -- 取旧值
		playerData.pointCountUsed = playerData.pointCountUsed + allowCount
		playerData.statusPointUsage[statusName] = newCount -- 通过点数增加的属性 , 最小值为 0
		playerData.statusTotal[statusName] = newCount + playerData.statusAdd[statusName] or SIPlayerStatus.defaultStatusValue
		result = allowCount
	else
		local oldCount = playerData.statusAdd[statusName] or SIPlayerStatus.defaultStatusValue
		local newCount = oldCount + count
		oldTotalCount = playerData.statusTotal[statusName] or SIPlayerStatus.defaultStatusValue -- 取旧值
		playerData.statusAdd[statusName] = newCount
		playerData.statusTotal[statusName] = newCount + playerData.statusPointUsage[statusName] or SIPlayerStatus.defaultStatusValue
		result = count
	end
	local player = game.get_player( playerData.id )
	local newTotalCount = playerData.statusTotal[statusName]
	for index , code in pairs( SIPlayerStatus.statusValue[statusName] ) do
		local oldTotalValue = code.size * oldTotalCount
		local newTotalValue = code.size * newTotalCount
		local totalValue = playerData.currentValue[code].total - oldTotalValue + newTotalValue
		local realValue = playerData.currentValue[code].real
		local codeData = SIPlayerStatus.valueMap[code]
		realValue = math.Range( player[codeData.name]-realValue+totalValue , codeData.min , codeData.max )
		if codeData.isInt then realValue = math.floor( realValue ) end
		player[codeData.name] = realValue
		playerData.currentValue[code].real = realValue
	end
	return result
end

function SIPlayerStatus.FreshBuff( playerData , buffId , buffData )
	local player = game.get_player( playerData.id )
	local oldBuffData = playerData.buff[buffId]
	if oldBuffData then
		for code , data in pairs( oldBuffData.values ) do
			local totalValue = playerData.currentValue[code].total - data.value
			local realValue = playerData.currentValue[code].real
			local codeData = SIPlayerStatus.valueMap[code]
			realValue = math.Range( player[codeData.name]-realValue+totalValue , codeData.min , codeData.max )
			if codeData.isInt then realValue = math.floor( realValue ) end
			player[codeData.name] = realValue
			playerData.currentValue[code].real = realValue
		end
	end
	playerData.buff[buffId] = buffData
	if buffData then
		buffData.cur = 0
		buffData.lastTick = game.tick
		for code , data in pairs( buffData.values ) do
			local totalValue = playerData.currentValue[code].total + data.value
			local realValue = playerData.currentValue[code].real
			local codeData = SIPlayerStatus.valueMap[code]
			realValue = math.Range( player[codeData.name]-realValue+totalValue , codeData.min , codeData.max )
			if codeData.isInt then realValue = math.floor( realValue ) end
			player[codeData.name] = realValue
			playerData.currentValue[code].real = realValue
		end
	end
	return true
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPlayerStatus.OnTick( event )
	local currentTick = math.fmod( event.tick , SIPlayerStatus.checkDelay ) + 1
	local maxSize = #SIPlayerStatusDataList
	for index = currentTick , maxSize , SIPlayerStatus.checkDelay do
		local playerData = SIPlayerStatusDataList[index]
		for id , buffData in pairs( playerData.buff ) do
			buffData.cur = buffData.cur + currentTick - buffData.lastTick
			buffData.lastTick = currentTick
			if buffData.duration > 0 and buffData.duration <= buffData.cur then SIPlayerStatus.FreshBuff( playerData , id ) end
		end
	end
end

function SIPlayerStatus.OnDie( event )
	local playerData = SIPlayerStatus.GetPlayerData( event.player_index )
	if playerData then
		for id , buffData in pairs( playerData.buff ) do
			if buffData.removeOnDeath then SIPlayerStatus.FreshBuff( playerData , id ) end
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 事件注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus
.Add( SIEvents.on_tick        , SIPlayerStatus.OnTick )
.Add( SIEvents.on_player_died , SIPlayerStatus.OnDie )