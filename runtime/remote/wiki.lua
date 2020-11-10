-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- wikiData 内的元素结构
-- {
--   id = id ,
--   buttonName = buttonName ,
--   localizedName = localizedName ,
--   tooltips = tooltips ,
--   interfaceName = interfaceName ,
--   functionName = functionName ,
--   order = order
-- }
SIWiki =
{
	interfaceId = "sicfl-wiki" ,
	toolbarButtonId = "SIWikiToolbarButton" ,
	toolbarButtonName = "sicfl-wiki-toolbar-button" ,
	order = 1 ,
	wikiData = {} ,
	playerViewData =
	{
		open = false ,
		last = nil ,
		view = nil ,
		list = nil ,
		panel = nil
	}
}

CreateGlobalTable( "SIWikiViews" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 卡片操作 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIWiki.AddWiki( id , buttonName , localizedName , tooltips , interfaceName , functionName )
	for i , wikiData in pairs( SIWiki.wikiData ) do
		if wikiData.id == id then return end
	end
	local order = SIWiki.order
	SIWiki.order = SIWiki.order + 1
	local wikiData =
	{
		id = id ,
		buttonName = buttonName ,
		localizedName = { localizedName } ,
		tooltips = { tooltips } ,
		interfaceName = interfaceName ,
		functionName = functionName ,
		order = order
	}
	table.insert( SIWiki.wikiData , wikiData )
	SIWiki.FreshViews()
	return order
end

function SIWiki.RemoveWiki( id )
	local index = 0
	for i , wikiData in pairs( SIWiki.wikiData ) do
		if wikiData.id == id then
			index = i
			break
		end
	end
	if index > 0 then
		table.remove( SIWiki.wikiData , index )
		SIWiki.FreshViews()
		return true
	else return false end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 窗口方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIWiki.OpenView( playerIndex , viewData )
	if viewData then
		if not viewData.view then
			local player = game.players[playerIndex]
			local view = player.gui.top.add{ type = "frame" , name = "sicfl-wiki-view" , caption = { "SICFL.wiki-view-title" } , direction = "horizontal" , style = "sicfl-wiki-view" }
			local list = view.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" }.add{ type = "table" , column_count = 1 , style = "sicfl-wiki-list" }
			local panel = view.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" }.add{ type = "frame" , direction = "vertical" , style = "sicfl-wiki-view-inner" }
			
			viewData.open = true
			viewData.last = nil
			viewData.view = view
			viewData.list = list
			viewData.panel = panel
			
			SIWiki.FreshList( list )
		end
	end
end

function SIWiki.CloseView( playerIndex , viewData )
	if viewData then
		if viewData.view then
			viewData.view.destroy()
			
			viewData.open = false
			viewData.view = nil
			viewData.list = nil
			viewData.panel = nil
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 功能方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIWiki.ShowViewByPlayerIndex( playerIndex )
	local viewData = SIWikiViews[playerIndex]
	if not viewData then
		viewData = table.deepcopy( SIWiki.playerViewData )
		SIWikiViews[playerIndex] = viewData
	end
	SIWiki.OpenView( playerIndex , viewData )
end

function SIWiki.HideViewByPlayerIndex( playerIndex )
	local viewData = SIWikiViews[playerIndex]
	if viewData then SIWiki.CloseView( playerIndex , viewData ) end
end

function SIWiki.ShowViews()
	for playerIndex , viewData in pairs( SIWikiViews ) do SIWiki.ShowViewByPlayerIndex( playerIndex ) end
end

function SIWiki.HideViews()
	for playerIndex , viewData in pairs( SIWikiViews ) do SIWiki.HideViewByPlayerIndex( playerIndex ) end
end

function SIWiki.FreshViews()
	local count = #SIWiki.wikiData
	if count < 1 then
		SIToolbar.RemoveTool( SIWiki.toolbarButtonId )
		SIWiki.HideViews()
	else
		SIToolbar.AddTool( SIWiki.toolbarButtonId , SIWiki.toolbarButtonName , "sicfl-item-wiki" , "SICFL.wiki-toolbar-button" , "SICFL.wiki-toolbar-tooltip" , SIWiki.interfaceId , "ShowViewByPlayerIndex" )
		for playerIndex , viewData in pairs( SIWikiViews ) do
			if viewData then
				if viewData.open then SIWiki.FreshList( viewData.list ) end
				if viewData.last then
					local hasLast = false
					for i , wikiData in pairs( SIWiki.wikiData ) do
						if wikiData.buttonName == viewData.last then
							hasLast = true
							break
						end
					end
					if not hasLast then viewData.panel.clear() end
				end
			end
		end
	end
end

function SIWiki.FreshList( list )
	if list then
		list.clear()
		for i , wikiData in pairs( SIWiki.wikiData ) do list.add{ type = "button" , name = wikiData.buttonName , caption = wikiData.localizedName , tooltip = wikiData.tooltips , style = "sicfl-wiki-icon" } end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIWiki.OnClick( event )
	local element = event.element
	if element.valid then
		local name = element.name
		if name == "sicfl-wiki-button" then
			local playerIndex = event.player_index
			SIWiki.CloseView( playerIndex , SIWikiViews[playerIndex] )
			return
		end
		for i , wikiData in pairs( SIWiki.wikiData ) do
			if name == wikiData.buttonName then
				local playerIndex = event.player_index
				local viewData = SIWikiViews[playerIndex]
				viewData.last = name
				if wikiData.interfaceName and wikiData.functionName then
					local panel = viewData.panel
					if panel then
						panel.clear()
						remote.call( wikiData.interfaceName , wikiData.functionName , playerIndex , panel , name , wikiData.id , wikiData.order )
					end
				end
				return
			end
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 方法注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus.Add( SIEvents.on_gui_click , SIWiki.OnClick )

remote.add_interface( SIWiki.interfaceId ,
{
	AddWiki = SIWiki.AddWiki ,
	RemoveWiki = SIWiki.RemoveWiki ,
	ShowViewByPlayerIndex = SIWiki.ShowViewByPlayerIndex ,
	HideViewByPlayerIndex = SIWiki.HideViewByPlayerIndex ,
	ShowViews = SIWiki.ShowViews ,
	HideViews = SIWiki.HideViews
} )