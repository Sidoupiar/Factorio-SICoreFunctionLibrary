-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIToolbar =
{
	interfaceId = "sicfl-toolbar" ,
	remoteKey =
	{
		AddTool               = "AddTool" ,
		RemoveTool            = "RemoveTool" ,
		ShowViewByPlayerIndex = "ShowViewByPlayerIndex" ,
		HideViewByPlayerIndex = "HideViewByPlayerIndex" ,
		ShowViews             = "ShowViews" ,
		HideViews             = "HideViews"
	}
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 接口方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- --------------------------------------------------------
-- 添加一个工具图标
-- --------------------------------------------------------
function SIToolbar.AddTool( id , buttonName , iconItemName , localizedName , tooltips , interfaceName , functionName )
	return remote.call( SIToolbar.interfaceId , SIToolbar.remoteKey.AddTool , id , buttonName , iconItemName , localizedName , tooltips , interfaceName , functionName )
end

-- --------------------------------------------------------
-- 移除一个工具图标
-- --------------------------------------------------------
function SIToolbar.RemoveTool( id )
	return remote.call( SIToolbar.interfaceId , SIToolbar.remoteKey.RemoveTool , id )
end

-- --------------------------------------------------------
-- 显示一个玩家的工具栏
-- --------------------------------------------------------
function SIToolbar.ShowViewByPlayerIndex( playerIndex , forceOpen )
	return remote.call( SIToolbar.interfaceId , SIToolbar.remoteKey.ShowViewByPlayerIndex , playerIndex , forceOpen )
end

-- --------------------------------------------------------
-- 隐藏一个玩家的工具栏
-- --------------------------------------------------------
function SIToolbar.HideViewByPlayerIndex( playerIndex )
	return remote.call( SIToolbar.interfaceId , SIToolbar.remoteKey.HideViewByPlayerIndex , playerIndex )
end

-- --------------------------------------------------------
-- 显示所有玩家的工具栏
-- --------------------------------------------------------
function Implement_SIToolbar.ShowViews()
	return remote.call( SIToolbar.interfaceId , SIToolbar.remoteKey.ShowViews )
end

-- --------------------------------------------------------
-- 隐藏所有玩家的工具栏
-- --------------------------------------------------------
function Implement_SIToolbar.HideViews()
	return remote.call( SIToolbar.interfaceId , SIToolbar.remoteKey.HideViews )
end