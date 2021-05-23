-- ------------------------------------------------------------------------------------------------
-- ---------- 添加引用 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if not SIEventBus then e( "模块使用 : 必须启用 SIEventBus 之后才能使用 SIUnlocker 模块" ) end
if not SIGlobal then e( "模块使用 : 必须启用 SIGlobal 之后才能使用 SIUnlocker 模块" ) end

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIPlayerStatus =
{
	status =
	{
		
	} ,
	buffValue =
	{
		
	} ,
	
	defaultExperience = 0 ,
	defaultStatusValue = 0 ,
	defaultPlayerData =
	{
		id = nil ,
		experience = 0 ,
		status = {} ,
		buff = {}
	}
}

SIGlobal.Create( "SIPlayerStatusData" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 项目操作 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPlayerStatus.AddExperience( playerIndex , count )
	local playerData = SIPlayerStatus.GetPlayerData( playerIndex )
	playerData.experience = playerData.experience + count
	-- 刷新等级
	return SIPlayerStatus
end

function SIPlayerStatus.RemoveExperience( playerIndex , count )
	local playerData = SIPlayerStatus.GetPlayerData( playerIndex )
	playerData.experience = playerData.experience - count
	-- 刷新等级
	return SIPlayerStatus
end

function SIPlayerStatus.GetExperience( playerIndex )
	local playerData = SIPlayerStatus.GetPlayerData( playerIndex )
	return playerData.experience or SIPlayerStatus.defaultExperience
end

function SIPlayerStatus.AddStatus( playerIndex , statusName , count )
	local playerData = SIPlayerStatus.GetPlayerData( playerIndex )
	playerData.status[statusName] = playerData.status[statusName] or SIPlayerStatus.defaultStatusValue + count
	-- 刷新属性
	return SIPlayerStatus
end

function SIPlayerStatus.RemoveStatus( playerIndex , statusName , count )
	local playerData = SIPlayerStatus.GetPlayerData( playerIndex )
	playerData.status[statusName] = playerData.status[statusName] or SIPlayerStatus.defaultStatusValue - count
	-- 刷新属性
	return SIPlayerStatus
end

function SIPlayerStatus.GetStatus( playerIndex , statusName )
	local playerData = SIPlayerStatus.GetPlayerData( playerIndex )
	return playerData.status[statusName] or SIPlayerStatus.defaultStatusValue
end

function SIPlayerStatus.AddBuff( playerIndex , buffData )
	if not buffData or not buffData.id then
		e( "玩家属性管理器 : buff 或 buff.id 不能为空" )
		return SIPlayerStatus , false
	end
	local playerData = SIPlayerStatus.GetPlayerData( playerIndex )
	local buffData = table.deepcopy( buffData )
	-- 移除 buff
	playerData.buff[buffData.id] = buffData
	-- 应用 buff
	return SIPlayerStatus , true
end

function SIPlayerStatus.RemoveBuff( playerIndex , buffId )
	local playerData = SIPlayerStatus.GetPlayerData( playerIndex )
	-- 移除 buff
	playerData.buff[buffId] = nil
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
		-- 初始化
	end
	return playerData
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------------
-- ---------- 事件注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------