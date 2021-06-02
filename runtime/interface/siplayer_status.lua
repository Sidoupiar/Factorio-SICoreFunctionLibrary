-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIPlayerStatus =
{
	interfaceId = "SIPlayerStatus" ,
	remoteKey =
	{
		GetLevel               = "GetLevel" ,
		AddExperience          = "AddExperience" ,
		RemoveExperience       = "RemoveExperience" ,
		GetExperience          = "GetExperience" ,
		AddStatusByUsePoint    = "AddStatusByUsePoint" ,
		RemoveStatusByUsePoint = "RemoveStatusByUsePoint" ,
		AddStatus              = "AddStatus" ,
		RemoveStatus           = "RemoveStatus" ,
		GetStatus              = "GetStatus" ,
		AddBuff                = "AddBuff" ,
		RemoveBuff             = "RemoveBuff" ,
		GetBuff                = "GetBuff" ,
		GetPlayerData          = "GetPlayerData"
	} ,
	
	-- 属性列表
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
	-- buff 效果列表
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
	miningTypeName = "mt" , -- character_additional_mining_categories , 暂时不可用
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 接口方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- --------------------------------------------------------
-- 获取玩家当前等级 , 只读
-- 只能在 control.init 后使用
-- --------------------------------------------------------
function SIPlayerStatus.GetLevel( playerIndex )
	return remote.call( SIPlayerStatus.interfaceId , SIPlayerStatus.remoteKey.GetLevel , playerIndex )
end



-- --------------------------------------------------------
-- 增加玩家经验
-- 只能在 control.init 后使用
-- --------------------------------------------------------
function SIPlayerStatus.AddExperience( playerIndex , count )
	return remote.call( SIPlayerStatus.interfaceId , SIPlayerStatus.remoteKey.AddExperience , playerIndex , count )
end

-- --------------------------------------------------------
-- 减少玩家经验
-- 只能在 control.init 后使用
-- --------------------------------------------------------
function SIPlayerStatus.RemoveExperience( playerIndex , count )
	return remote.call( SIPlayerStatus.interfaceId , SIPlayerStatus.remoteKey.RemoveExperience , playerIndex , count )
end

-- --------------------------------------------------------
-- 获取玩家当前经验 , 只读
-- 只能在 control.init 后使用
-- --------------------------------------------------------
function SIPlayerStatus.GetExperience( playerIndex )
	return remote.call( SIPlayerStatus.interfaceId , SIPlayerStatus.remoteKey.GetExperience , playerIndex )
end



-- --------------------------------------------------------
-- 增加玩家属性 , 使用属性点
-- 只能在 control.init 后使用
-- --------------------------------------------------------
function SIPlayerStatus.AddStatusByUsePoint( playerIndex , statusName , count )
	return remote.call( SIPlayerStatus.interfaceId , SIPlayerStatus.remoteKey.AddStatusByUsePoint , playerIndex , statusName , count )
end

-- --------------------------------------------------------
-- 减少玩家属性 , 使用属性点
-- 只能在 control.init 后使用
-- --------------------------------------------------------
function SIPlayerStatus.RemoveStatusByUsePoint( playerIndex , statusName , count )
	return remote.call( SIPlayerStatus.interfaceId , SIPlayerStatus.remoteKey.RemoveStatusByUsePoint , playerIndex , statusName , count )
end

-- --------------------------------------------------------
-- 增加玩家属性 , 无条件
-- 只能在 control.init 后使用
-- --------------------------------------------------------
function SIPlayerStatus.AddStatus( playerIndex , statusName , count )
	return remote.call( SIPlayerStatus.interfaceId , SIPlayerStatus.remoteKey.AddStatus , playerIndex , statusName , count )
end

-- --------------------------------------------------------
-- 减少玩家属性 , 无条件
-- 只能在 control.init 后使用
-- --------------------------------------------------------
function SIPlayerStatus.RemoveStatus( playerIndex , statusName , count )
	return remote.call( SIPlayerStatus.interfaceId , SIPlayerStatus.remoteKey.RemoveStatus , playerIndex , statusName , count )
end

-- --------------------------------------------------------
-- 获取玩家当前属性 , 只读
-- 只能在 control.init 后使用
-- --------------------------------------------------------
function SIPlayerStatus.GetStatus( playerIndex , statusName )
	return remote.call( SIPlayerStatus.interfaceId , SIPlayerStatus.remoteKey.GetStatus , playerIndex , statusName )
end



-- --------------------------------------------------------
-- 增加玩家 buff
-- 只能在 control.init 后使用
-- --------------------------------------------------------
-- buffData =
-- {
--   id = "buffId" ,
--   name = { "本地化字符串" } 或 "本地化字符串后半部分" ,        -- 可选 , 只填字符串的话 , 会自动生成 { "本地化字符串" } 的形式 , 如果不填则使用 id 生成
--   description = { "本地化字符串" } 或 "本地化字符串后半部分" , -- 可选 , 只填字符串的话 , 会自动生成 { "本地化字符串" } 的形式 , 如果不填则使用 id 生成
--   duration = 7200 ,                                            -- 持续时间 , 负数 = 永继 buff
--   removeOnDeath = 是否在死亡时清除这个 buff ,
--   values =                                                     -- 效果列表
--   {
--     [SIPlayerStatus.valueCode.xxxx] = { value = 数值 } -- 数值可以是负数
--   }
-- }
-- --------------------------------------------------------
function SIPlayerStatus.AddBuff( playerIndex , buffData )
	return remote.call( SIPlayerStatus.interfaceId , SIPlayerStatus.remoteKey.AddBuff , playerIndex , buffData )
end

-- --------------------------------------------------------
-- 减少玩家 buff
-- 只能在 control.init 后使用
-- --------------------------------------------------------
function SIPlayerStatus.RemoveBuff( playerIndex , buffId )
	return remote.call( SIPlayerStatus.interfaceId , SIPlayerStatus.remoteKey.RemoveBuff , playerIndex , buffId )
end

-- --------------------------------------------------------
-- 获取玩家当前的 buff , 只读
-- 只能在 control.init 后使用
-- --------------------------------------------------------
function SIPlayerStatus.GetBuff( playerIndex , buffId )
	return remote.call( SIPlayerStatus.interfaceId , SIPlayerStatus.remoteKey.GetBuff , playerIndex , buffId )
end



-- --------------------------------------------------------
-- 获取玩家当前的属性 , 只读
-- 只能在 control.init 后使用
-- --------------------------------------------------------
function SIPlayerStatus.GetPlayerData( playerIndex )
	return remote.call( SIPlayerStatus.interfaceId , SIPlayerStatus.remoteKey.GetPlayerData , playerIndex )
end