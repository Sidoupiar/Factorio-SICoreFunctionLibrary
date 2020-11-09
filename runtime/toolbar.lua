-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- toolData 内的元素结构
-- {
--   id = id ,
--   buttonName = buttonName ,
--   iconItemName = iconItemName ,
--   localizedName = localizedName ,
--   tooltips = tooltips ,
--   interfaceName = interfaceName ,
--   functionName = functionName ,
--   order = order
-- }
SIToolbar =
{
	order = 1 ,
	toolData = {} ,
	playerViewData =
	{
		open = false ,
		view = nil ,
		list = nil
	}
}

CreateGlobalTable( "SIToolbarViews" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 图标操作 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIToolbar.AddTool( id , buttonName , iconItemName , localizedName , tooltips , interfaceName , functionName )
	local order = SIToolbar.order
	SIToolbar.order = SIToolbar.order + 1
	local toolData =
	{
		id = id ,
		buttonName = buttonName ,
		iconItemName = iconItemName ,
		localizedName = localizedName ,
		tooltips , tooltips ,
		interfaceName = interfaceName ,
		functionName = functionName ,
		order = order
	}
	table.insert( SIToolbar.toolData , toolData )
	SIToolbar.FreshViews()
	return order
end

function SIToolbar.RemoveTool( id )
	local index = 0
	for i , toolData in pairs( SIToolbar.toolData ) do
		if toolData.id == id then
			index = i
			break
		end
	end
	if index > 0 then
		table.remove( SIToolbar.toolData , index )
		SIToolbar.FreshViews()
		return true
	else return false end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 窗口方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIToolbar.OpenView( playerIndex , viewData )
	if viewData then
		if not viewData.view or viewData.view.name ~= "sicfl-toolbar-view" then
			if viewData.view then viewData.view.destroy() end
			
			local player = game.players[playerIndex]
			local view = player.gui.top.add{ type = "frame" , name = "sicfl-toolbar-view" , direction = "horizontal" , style = "sicfl-toolbar-view" }
			local list = view.add{ type = "scroll-pane" , vertical_scroll_policy = "auto-and-reserve-space" , horizontal_scroll_policy = "never" }.add{ type = "table" , column_count = 2 , style = "sicfl-toolbar-list" }
			
			viewData.open = true
			viewData.view = view
			viewData.list = list
		end
	end
end

function SIToolbar.CloseView( playerIndex , viewData )
	if viewData then
		if not viewData.view or viewData.view.name ~= "sicfl-toolbar-button" then
			if viewData.view then viewData.view.destroy() end
			
			local player = game.players[playerIndex]
			local view = player.gui.top..add{ type = "sprite-button" , name = "sicfl-toolbar-button" , sprite = "item/sicfl-item-toolbar" , tooltip = { "SICFL.toolbar-open" } , style = "sicfl-toolbar-open" }
			
			viewData.open = false
			viewData.view = view
			viewData.list = nil
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 功能方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIToolbar.ShowViewByPlayerIndex( playerIndex )
	local viewData = SIToolbarViews[playerIndex]
	if not viewData then
		viewData = table.deepcopy( SIToolbar.playerViewData )
		SIToolbarViews[playerIndex] = viewData
	end
	if viewData.open then SIToolbar.OpenView( playerIndex , viewData )
	else SIToolbar.CloseView( playerIndex , viewData ) end
end

function SIToolbar.HideViewByPlayerIndex( playerIndex )
	local viewData = SIToolbarViews[playerIndex]
	if viewData then
		if viewData.view then viewData.view.destroy() end
		
		viewData.view = nil
		viewData.list = nil
	end
end

function SIToolbar.ShowViews()
	for playerIndex , viewData in pairs( SIToolbarViews ) do SIToolbar.ShowViewByPlayerIndex( playerIndex ) end
end

function SIToolbar.HideViews()
	for playerIndex , viewData in pairs( SIToolbarViews ) do SIToolbar.HideViewByPlayerIndex( playerIndex ) end
end

function SIToolbar.FreshViews()
	local count = #SIToolbar.toolData
	for playerIndex , viewData in pairs( SIToolbarViews ) do
		if count < 1 then SIToolbar.HideViewByPlayerIndex( playerIndex )
		else
			SIToolbar.ShowViewByPlayerIndex( playerIndex )
			if viewData.open then SIToolbar.FreshList( viewData.list ) end
		end
	end
end

function SIToolbar.FreshList( list )
	if list then
		list.clear()
		list.add{ type = "sprite-button" , name = "sicfl-toolbar-button" , sprite = "item/sicfl-item-toolbar" , tooltip = { "SICFL.toolbar-close" } , style = "sicfl-toolbar-close" }
		for i , toolData in pairs( SIToolbar.toolData ) do
			list.add{ type = "sprite-button" , name = toolData.buttonName , sprite = "item/"..toolData.iconItemName , tooltip = toolData.tooltips , style = "sicfl-toolbar-icon" }
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIToolbar.OnPlayerCreate( event )
	SIToolbar.ShowViewByPlayerIndex( event.player_index )
end

function SIToolbar.OnClick( event )
	local name = event.element.name
	if name == "sicfl-toolbar-button" then
		local playerIndex = event.player_index
		local viewData = SIToolbarViews[playerIndex]
		if viewData.open then SIToolbar.CloseView( playerIndex , viewData )
		else SIToolbar.OpenView( playerIndex , viewData ) end
		return
	end
	for i , toolData in pairs( SIToolbar.toolData ) do
		if name == toolData.buttonName then
			if toolData.interfaceName and toolData.functionName then
				remote.call( toolData.interfaceName , toolData.functionName , name , toolData.id , toolData.order )
			end
			return
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 方法注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus.Add( SIEvents.on_player_created , SIToolbar.OnPlayerCreate )
SIEventBus.Add( SIEvents.on_gui_click , SIToolbar.OnClick )

remote.add_interface( "sicfl-toolbar" , { AddTool = SIToolbar.AddTool , RemoveTool = SIToolbar.RemoveTool } )