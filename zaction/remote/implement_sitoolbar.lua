-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- addToolData / SIToolbarToolData 内的元素结构
-- {
--   id = id ,
--   buttonName = buttonName ,
--   iconItemName = iconItemName ,
--   localizedName = localizedName ,
--   tooltips = tooltips ,
--   interfaceName = interfaceName ,
--   functionName = functionName ,
--   order = order ,
--   removed = true/false
-- }
Implement_SIToolbar =
{
	waitFunctionId = "sicfl-toolbar" ,
	
	emptyItemName = "sicfl-item-icon-empty" ,
	
	order = 1 ,
	addToolData = {} ,
	removeToolData = {} ,
	playerViewData =
	{
		open = false ,
		view = nil ,
		list = nil
	}
}

SIGlobal
.Create( "SIToolbarToolData" )
.Create( "SIToolbarViews" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 图标操作 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function Implement_SIToolbar.AddTool( id , buttonName , iconItemName , localizedName , tooltips , interfaceName , functionName )
	for i , toolData in pairs( Implement_SIToolbar.addToolData ) do
		if toolData.id == id then return end
	end
	local order = Implement_SIToolbar.order
	Implement_SIToolbar.order = Implement_SIToolbar.order + 1
	local toolData =
	{
		id = id ,
		buttonName = buttonName ,
		iconItemName = iconItemName ,
		localizedName = { localizedName } ,
		tooltips = { tooltips } ,
		interfaceName = interfaceName ,
		functionName = functionName ,
		order = order
	}
	table.insert( Implement_SIToolbar.addToolData , toolData )
	Implement_SIToolbar.FreshViews()
	return order
end

function Implement_SIToolbar.RemoveTool( id )
	local index = 0
	if table.Has( Implement_SIToolbar.removeToolData , id ) then return false end
	table.insert( Implement_SIToolbar.removeToolData , id )
	Implement_SIToolbar.FreshViews()
	return true
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 窗口方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function Implement_SIToolbar.OpenView( playerIndex , viewData )
	if viewData then
		if not viewData.view or viewData.view.name ~= "sicfl-toolbar-view" then
			if viewData.view then viewData.view.destroy() end
			
			local view = SITitlebarViews[playerIndex].toolbar
			view.add{ type = "sprite-button" , name = "sicfl-toolbar-button" , sprite = "item/sicfl-item-toolbar" , tooltip = { "SICFL.toolbar-close" } , style = "sicfl-toolbar-close" }
			local list = view.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "never" }.add{ type = "table" , column_count = 10 , style = "sicfl-toolbar-list" }
			
			viewData.open = true
			viewData.view = view
			viewData.list = list
			
			Implement_SIToolbar.FreshList( list , playerIndex )
		end
	end
end

function Implement_SIToolbar.CloseView( playerIndex , viewData )
	if viewData then
		if not viewData.view or viewData.view.valid and viewData.view.name ~= "sicfl-toolbar-button" then
			if viewData.view then viewData.view.clear() end
			
			local view = SITitlebarViews[playerIndex].toolbar.add{ type = "sprite-button" , name = "sicfl-toolbar-button" , sprite = "item/sicfl-item-toolbar" , tooltip = { "SICFL.toolbar-open" } , style = "sicfl-toolbar-open" }
			
			viewData.open = false
			viewData.view = view
			viewData.list = nil
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 功能方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function Implement_SIToolbar.ShowViewByPlayerIndex( playerIndex , forceOpen )
	local viewData = SIToolbarViews[playerIndex]
	if not viewData then
		viewData = table.deepcopy( Implement_SIToolbar.playerViewData )
		SIToolbarViews[playerIndex] = viewData
	end
	if forceOpen or #SIToolbarToolData > 0 then
		if viewData.open then Implement_SIToolbar.OpenView( playerIndex , viewData )
		else Implement_SIToolbar.CloseView( playerIndex , viewData ) end
	end
end

function Implement_SIToolbar.HideViewByPlayerIndex( playerIndex )
	local viewData = SIToolbarViews[playerIndex]
	if viewData then
		if viewData.view then
			if viewData.view.name == "sicfl-toolbar-button" then viewData.view.destroy()
			else viewData.view.clear() end
		end
		
		viewData.view = nil
		viewData.list = nil
		
		SITitlebarViews[playerIndex].toolbar.clear()
	end
end

function Implement_SIToolbar.ShowViews()
	for playerIndex , viewData in pairs( SIToolbarViews ) do Implement_SIToolbar.ShowViewByPlayerIndex( playerIndex , true ) end
end

function Implement_SIToolbar.HideViews()
	for playerIndex , viewData in pairs( SIToolbarViews ) do Implement_SIToolbar.HideViewByPlayerIndex( playerIndex ) end
end

function Implement_SIToolbar.FreshViews()
	if not SIToolbarViews then SIEventBus.AddWaitFunction( Implement_SIToolbar.waitFunctionId , Implement_SIToolbar.FreshViews )
	else
		-- 添加/移除工具按钮
		if Implement_SIToolbar.addToolData and #Implement_SIToolbar.addToolData > 0 then
			for i , toolData in pairs( Implement_SIToolbar.addToolData ) do
				local hasData = false
				for j , oldToolData in pairs( SIToolbarToolData ) do
					if oldToolData.id == toolData.id then
						hasData = true
						SIToolbarToolData[j] = toolData
						break
					end
				end
				if not hasData then table.insert( SIToolbarToolData , toolData ) end
			end
			Implement_SIToolbar.addToolData = {}
		end
		if Implement_SIToolbar.removeToolData and #Implement_SIToolbar.removeToolData > 0 then
			for i , id in pairs( Implement_SIToolbar.removeToolData ) do
				for j , oldToolData in pairs( SIToolbarToolData ) do
					if oldToolData.id == id then
						table.remove( SIToolbarToolData , j )
						break
					end
				end
			end
			Implement_SIToolbar.removeToolData = {}
		end
		-- 处理物品按钮
		for i , toolData in pairs( SIToolbarToolData ) do
			if not game.item_prototypes[toolData.iconItemName] then toolData.removed = true
			else toolData.removed = false end
		end
		-- 控制显示隐藏主按钮
		local count = #SIToolbarToolData
		for playerIndex , viewData in pairs( SIToolbarViews ) do
			if count < 1 then Implement_SIToolbar.HideViewByPlayerIndex( playerIndex )
			else
				Implement_SIToolbar.ShowViewByPlayerIndex( playerIndex )
				if viewData.open then Implement_SIToolbar.FreshList( viewData.list , playerIndex ) end
			end
		end
	end
end

function Implement_SIToolbar.FreshList( list , playerIndex )
	if list then
		list.clear()
		local player = game.players[playerIndex]
		for i , toolData in pairs( SIToolbarToolData ) do
			if toolData.iconItemName == "sicfl-item-oremap" then
				local inventory = player.get_main_inventory()
				if inventory and inventory.get_item_count( "sicfl-item-oremap" ) > 0 then list.add{ type = "sprite-button" , name = toolData.buttonName , sprite = "item/"..toolData.iconItemName , tooltip = toolData.tooltips , style = "sicfl-toolbar-icon" } end
			else
				local itemName = toolData.iconItemName
				local tooltips = toolData.tooltips
				if toolData.removed then
					itemName = Implement_SIToolbar.emptyItemName
					tooltips = { "SICFL.toolbar-tool-empty" }
				end
				list.add{ type = "sprite-button" , name = toolData.buttonName , sprite = "item/"..itemName , tooltip = tooltips , style = "sicfl-toolbar-icon" }
			end
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function Implement_SIToolbar.OnClick( event )
	local element = event.element
	if element.valid then
		local name = element.name
		if name == "sicfl-toolbar-button" then
			local playerIndex = event.player_index
			local viewData = SIToolbarViews[playerIndex]
			if viewData.open then Implement_SIToolbar.CloseView( playerIndex , viewData )
			else Implement_SIToolbar.OpenView( playerIndex , viewData ) end
			return
		end
		for i , toolData in pairs( SIToolbarToolData ) do
			if name == toolData.buttonName then
				if toolData.interfaceName and toolData.functionName then
					local playerIndex = event.player_index
					if remote.interfaces[toolData.interfaceName] then remote.call( toolData.interfaceName , toolData.functionName , playerIndex , name , toolData.id , toolData.order )
					else alert( playerIndex , { "SICFL.toolbar-tool-removed" } ) end
				end
				return
			end
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 方法注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus
.Add( SIEvents.on_gui_click , Implement_SIToolbar.OnClick )

remote.add_interface( SIToolbar.interfaceId ,
{
	[SIToolbar.remoteKey.AddTool]               = Implement_SIToolbar.AddTool ,
	[SIToolbar.remoteKey.RemoveTool]            = Implement_SIToolbar.RemoveTool ,
	[SIToolbar.remoteKey.ShowViewByPlayerIndex] = Implement_SIToolbar.ShowViewByPlayerIndex ,
	[SIToolbar.remoteKey.HideViewByPlayerIndex] = Implement_SIToolbar.HideViewByPlayerIndex ,
	[SIToolbar.remoteKey.ShowViews]             = Implement_SIToolbar.ShowViews ,
	[SIToolbar.remoteKey.HideViews]             = Implement_SIToolbar.HideViews
} )