-- ------------------------------------------------------------------------------------------------
-- ---------- 添加引用 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if not SIEventBus then e( "模块启用[SIPlayerStatus] : 必须启用 SIEventBus 模块之后才能使用 SIPlayerStatus 模块" ) end
if not SIGlobal then e( "模块启用[SIPlayerStatus] : 必须启用 SIGlobal 模块之后才能使用 SIPlayerStatus 模块" ) end

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

Implement_SIPlayerStatus =
{
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

Implement_SIPlayerStatus.statusValue =
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

Implement_SIPlayerStatus.valueMap =
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

SIGlobal
.Create( "SIPlayerStatusData" )
.Create( "SIPlayerStatusDataList" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 项目操作 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 返回等级和属性点数
function Implement_SIPlayerStatus.CalculateLevel( experience )
	return 1 , 1
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 项目操作 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function Implement_SIPlayerStatus.GetLevel( playerIndex )
	local playerData = Implement_SIPlayerStatus.GetPlayerData( playerIndex )
	return playerData.level or Implement_SIPlayerStatus.defaultLevel
end



function Implement_SIPlayerStatus.AddExperience( playerIndex , count )
	local playerData = Implement_SIPlayerStatus.GetPlayerData( playerIndex )
	Implement_SIPlayerStatus.FreshLevel( playerData , count )
end

function Implement_SIPlayerStatus.RemoveExperience( playerIndex , count )
	local playerData = Implement_SIPlayerStatus.GetPlayerData( playerIndex )
	Implement_SIPlayerStatus.FreshLevel( playerData , -count )
end

function Implement_SIPlayerStatus.GetExperience( playerIndex )
	local playerData = Implement_SIPlayerStatus.GetPlayerData( playerIndex )
	return playerData.experience or Implement_SIPlayerStatus.defaultExperience
end



function Implement_SIPlayerStatus.AddStatusByUsePoint( playerIndex , statusName , count )
	local playerData = Implement_SIPlayerStatus.GetPlayerData( playerIndex )
	local totalAdded = Implement_SIPlayerStatus.FreshStatus( playerData , statusName , count , true )
	return totalAdded
end

function Implement_SIPlayerStatus.RemoveStatusByUsePoint( playerIndex , statusName , count )
	local playerData = Implement_SIPlayerStatus.GetPlayerData( playerIndex )
	local totalRemoved = Implement_SIPlayerStatus.FreshStatus( playerData , statusName , -count , true )
	return totalRemoved
end

function Implement_SIPlayerStatus.AddStatus( playerIndex , statusName , count )
	local playerData = Implement_SIPlayerStatus.GetPlayerData( playerIndex )
	Implement_SIPlayerStatus.FreshStatus( playerData , statusName , count )
end

function Implement_SIPlayerStatus.RemoveStatus( playerIndex , statusName , count )
	local playerData = Implement_SIPlayerStatus.GetPlayerData( playerIndex )
	Implement_SIPlayerStatus.FreshStatus( playerData , statusName , -count )
end

function Implement_SIPlayerStatus.GetStatus( playerIndex , statusName )
	local playerData = Implement_SIPlayerStatus.GetPlayerData( playerIndex )
	return playerData.statusTotal[statusName] or Implement_SIPlayerStatus.defaultStatusValue ,
		playerData.statusPointUsage[statusName] or Implement_SIPlayerStatus.defaultStatusValue ,
		playerData.statusAdd[statusName] or Implement_SIPlayerStatus.defaultStatusValue
end



function Implement_SIPlayerStatus.AddBuff( playerIndex , buffData )
	if not buffData or not buffData.id then
		e( "玩家属性管理器[SIPlayerStatus] : buff 或 buff.id 不能为空" )
		return false
	end
	local playerData = Implement_SIPlayerStatus.GetPlayerData( playerIndex )
	local result = Implement_SIPlayerStatus.FreshBuff( playerData , buffData.id , table.deepcopy( buffData ) )
	return result
end

function Implement_SIPlayerStatus.RemoveBuff( playerIndex , buffId )
	local playerData = Implement_SIPlayerStatus.GetPlayerData( playerIndex )
	Implement_SIPlayerStatus.FreshBuff( playerData , buffId )
end

function Implement_SIPlayerStatus.GetBuff( playerIndex , buffId )
	local playerData = Implement_SIPlayerStatus.GetPlayerData( playerIndex )
	return table.deepcopy( playerData.buff[buffId] )
end



function Implement_SIUnlocker.GetPlayerDataReadonly( forceName )
	return table.deepcopy( Implement_SIUnlocker.GetPlayerData( forceName ) )
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 功能方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function Implement_SIPlayerStatus.GetPlayerData( playerIndex )
	local playerData = SIPlayerStatusData[playerIndex]
	if not playerData then
		playerData = table.deepcopy( Implement_SIPlayerStatus.defaultPlayerData )
		playerData.id = playerIndex
		SIPlayerStatusData[playerIndex] = playerData
		table.insert( SIPlayerStatusDataList , playerData )
		Implement_SIPlayerStatus.InitPlayerData( playerData )
	end
	return playerData
end



function Implement_SIPlayerStatus.InitPlayerData( playerData )
	for index , code in pairs( SIPlayerStatus.valueCode ) do
		playerData.currentValue[code] = { total = Implement_SIPlayerStatus.defaultCurrentValue , real = Implement_SIPlayerStatus.defaultCurrentValue }
	end
	playerData.currentValue[SIPlayerStatus.miningTypeName] = { total = {} , real = {} }
end

function Implement_SIPlayerStatus.FreshLevel( playerData , addedExperience )
	playerData.experience = playerData.experience + addedExperience
	local level , pointCount = Implement_SIPlayerStatus.CalculateLevel( playerData.experience )
	playerData.level = level
	playerData.pointCountLevel = pointCount
	playerData.pointCountTotal = pointCount + playerData.pointCountAdd or Implement_SIPlayerStatus.defaultPointCount
end

function Implement_SIPlayerStatus.FreshStatus( playerData , statusName , count , usePoint )
	local oldTotalCount
	local result = 0
	if usePoint then
		local oldCount = playerData.statusPointUsage[statusName] or Implement_SIPlayerStatus.defaultStatusValue
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
		oldTotalCount = playerData.statusTotal[statusName] or Implement_SIPlayerStatus.defaultStatusValue -- 取旧值
		playerData.pointCountUsed = playerData.pointCountUsed + allowCount
		playerData.statusPointUsage[statusName] = newCount -- 通过点数增加的属性 , 最小值为 0
		playerData.statusTotal[statusName] = newCount + playerData.statusAdd[statusName] or Implement_SIPlayerStatus.defaultStatusValue
		result = allowCount
	else
		local oldCount = playerData.statusAdd[statusName] or Implement_SIPlayerStatus.defaultStatusValue
		local newCount = oldCount + count
		oldTotalCount = playerData.statusTotal[statusName] or Implement_SIPlayerStatus.defaultStatusValue -- 取旧值
		playerData.statusAdd[statusName] = newCount
		playerData.statusTotal[statusName] = newCount + playerData.statusPointUsage[statusName] or Implement_SIPlayerStatus.defaultStatusValue
		result = count
	end
	local player = game.get_player( playerData.id )
	local newTotalCount = playerData.statusTotal[statusName]
	for index , code in pairs( Implement_SIPlayerStatus.statusValue[statusName] ) do
		local oldTotalValue = code.size * oldTotalCount
		local newTotalValue = code.size * newTotalCount
		local totalValue = playerData.currentValue[code].total - oldTotalValue + newTotalValue
		local realValue = playerData.currentValue[code].real
		local codeData = Implement_SIPlayerStatus.valueMap[code]
		realValue = math.Range( player[codeData.name]-realValue+totalValue , codeData.min , codeData.max )
		if codeData.isInt then realValue = math.floor( realValue ) end
		player[codeData.name] = realValue
		playerData.currentValue[code].total = totalValue
		playerData.currentValue[code].real = realValue
	end
	return result
end

function Implement_SIPlayerStatus.FreshBuff( playerData , buffId , buffData )
	local player = game.get_player( playerData.id )
	local oldBuffData = playerData.buff[buffId]
	if oldBuffData then
		for code , data in pairs( oldBuffData.values ) do
			local totalValue = playerData.currentValue[code].total - data.value
			local realValue = playerData.currentValue[code].real
			local codeData = Implement_SIPlayerStatus.valueMap[code]
			realValue = math.Range( player[codeData.name]-realValue+totalValue , codeData.min , codeData.max )
			if codeData.isInt then realValue = math.floor( realValue ) end
			player[codeData.name] = realValue
			playerData.currentValue[code].total = totalValue
			playerData.currentValue[code].real = realValue
		end
	end
	playerData.buff[buffId] = buffData
	if buffData then
		if not buffData.name then buffData.name = { "SI-name."..buffId }
		elseif type( buffData.name ) ~= "table" then buffData.name = { "SI-name."..buffData.name } end
		if not buffData.description then  buffData.description = { "SI-description."..buffId }
		elseif type( buffData.description ) ~= "table" then buffData.description = { "SI-description."..buffData.description } end
		buffData.cur = 0
		buffData.lastTick = game.tick
		for code , data in pairs( buffData.values ) do
			local totalValue = playerData.currentValue[code].total + data.value
			local realValue = playerData.currentValue[code].real
			local codeData = Implement_SIPlayerStatus.valueMap[code]
			realValue = math.Range( player[codeData.name]-realValue+totalValue , codeData.min , codeData.max )
			if codeData.isInt then realValue = math.floor( realValue ) end
			player[codeData.name] = realValue
			playerData.currentValue[code].total = totalValue
			playerData.currentValue[code].real = realValue
		end
	end
	return true
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function Implement_SIPlayerStatus.OnTick( event )
	local totalTick = event.tick
	local currentTick = math.fmod( totalTick , Implement_SIPlayerStatus.checkDelay ) + 1
	local maxSize = #SIPlayerStatusDataList
	for index = currentTick , maxSize , Implement_SIPlayerStatus.checkDelay do
		local playerData = SIPlayerStatusDataList[index]
		local player = game.get_player( playerData.id )
		for id , buffData in pairs( playerData.buff ) do
			buffData.cur = buffData.cur + totalTick - buffData.lastTick
			buffData.lastTick = totalTick
			if buffData.duration > 0 and buffData.duration <= buffData.cur then Implement_SIPlayerStatus.FreshBuff( playerData , id ) end
			if buffData.damages and player.character then
				local character = player.character
				for code , damageData in pairs( buffData.damages ) do
					if character.valid then
						if damageData.sourceEntity then character.damage( damageData.damage , damageData.sourceEntity.force , damageData.damageType , damageData.sourceEntity )
						else character.damage( damageData.damage , damageData.forceName or "neutral" , damageData.damageType ) end
					else break end
				end
			end
		end
	end
end

function Implement_SIPlayerStatus.OnDie( event )
	local playerData = Implement_SIPlayerStatus.GetPlayerData( event.player_index )
	if playerData then
		for id , buffData in pairs( playerData.buff ) do
			if buffData.removeOnDeath then Implement_SIPlayerStatus.FreshBuff( playerData , id ) end
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 事件注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus
.Add( SIEvents.on_tick        , Implement_SIPlayerStatus.OnTick )
.Add( SIEvents.on_player_died , Implement_SIPlayerStatus.OnDie )

remote.add_interface( SIPlayerStatus.interfaceId ,
{
	[SIPlayerStatus.remoteKey.GetLevel]               = Implement_SIPlayerStatus.GetLevel ,
	[SIPlayerStatus.remoteKey.AddExperience]          = Implement_SIPlayerStatus.AddExperience ,
	[SIPlayerStatus.remoteKey.RemoveExperience]       = Implement_SIPlayerStatus.RemoveExperience ,
	[SIPlayerStatus.remoteKey.GetExperience]          = Implement_SIPlayerStatus.GetExperience ,
	[SIPlayerStatus.remoteKey.AddStatusByUsePoint]    = Implement_SIPlayerStatus.AddStatusByUsePoint ,
	[SIPlayerStatus.remoteKey.RemoveStatusByUsePoint] = Implement_SIPlayerStatus.RemoveStatusByUsePoint ,
	[SIPlayerStatus.remoteKey.AddStatus]              = Implement_SIPlayerStatus.AddStatus ,
	[SIPlayerStatus.remoteKey.RemoveStatus]           = Implement_SIPlayerStatus.RemoveStatus ,
	[SIPlayerStatus.remoteKey.GetStatus]              = Implement_SIPlayerStatus.GetStatus ,
	[SIPlayerStatus.remoteKey.AddBuff]                = Implement_SIPlayerStatus.AddBuff ,
	[SIPlayerStatus.remoteKey.RemoveBuff]             = Implement_SIPlayerStatus.RemoveBuff ,
	[SIPlayerStatus.remoteKey.GetBuff]                = Implement_SIPlayerStatus.GetBuff ,
	[SIPlayerStatus.remoteKey.GetPlayerData]          = Implement_SIPlayerStatus.GetPlayerDataReadonly
} )