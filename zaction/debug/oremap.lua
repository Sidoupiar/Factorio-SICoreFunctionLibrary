-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIOremap =
{
	interfaceId = "sicfl-oremap" ,
	toolbarButtonId = "SIOremapToolbarButton" ,
	toolbarButtonName = "sicfl-oremap-toolbar-button" ,
	
	itemName = "sicfl-item-oremap" ,
	iconName = "sicfl-oremap-ore-" ,
	
	maxCount = 4294967295 ,
	
	settingsDefaultData =
	{
		useSettingsAsDefault = false ,
		totalMode = false ,
		count = 0 ,
		selectedOreName = nil ,
		tiles = nil ,
		view = nil ,
		elements =
		{
			useSettingsAsDefault = nil ,
			totalMode = nil ,
			count = nil ,
			list = nil
		} ,
		oreData = {}
	} ,
	oreDefaultData =
	{
		name = nil ,
		count = 0
	}
}

SIOremap.iconPosition = #SIOremap.iconName + 1

SIGlobal.Create( "oremap" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 窗口方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIOremap.OpenView( playerIndex )
	local player = game.players[playerIndex]
	local settings = SIOremap.GetSettings( playerIndex )
	if settings.view then SIOremap.CloseView( playerIndex )
	else
		local view = player.gui.center.add{ type = "frame" , name = "sicfl-oremap-view" , caption = { "SICFL.oremap-view-title" } , direction = "vertical" , style = "sicfl-oremap-view" }
		
		local flow = view.add{ type = "flow" , direction = "horizontal" }
		flow.add{ type = "label" , caption = { "SICFL.oremap-view-description" } , style = "sicfl-oremap-label-text" }
		
		view.add{ type = "line" , direction = "horizontal" }
		flow = view.add{ type = "flow" , direction = "horizontal" }
		flow.add{ type = "label" , caption = { "SICFL.oremap-view-settings" } , style = "sicfl-oremap-label-text" }
		flow = view.add{ type = "flow" , direction = "horizontal" }
		settings.elements.useSettingsAsDefault = flow.add{ type = "checkbox" , state = settings.useSettingsAsDefault , caption = { "SICFL.oremap-view-settings-value-use-settings-as-default" } , tooltip = { "SICFL.oremap-view-settings-tooltip-use-settings-as-default" } , style = "checkbox" }
		flow = view.add{ type = "flow" , direction = "horizontal" }
		settings.elements.totalMode = flow.add{ type = "checkbox" , state = settings.totalMode , caption = { "SICFL.oremap-view-settings-value-total-mode" } , tooltip = { "SICFL.oremap-view-settings-tooltip-total-mode" } , style = "checkbox" }
		flow = view.add{ type = "flow" , direction = "horizontal" }
		flow.add{ type = "label" , caption = { "SICFL.oremap-view-settings-value-count" } , tooltip = { "SICFL.oremap-view-settings-tooltip-count" } , style = "sicfl-oremap-label-short" }
		settings.elements.count = flow.add{ type = "textfield" , text = tostring( settings.count ) , numeric = true , tooltip = { "SICFL.oremap-view-settings-tooltip-count" } , style = "long_number_textfield" }
		
		view.add{ type = "line" , direction = "horizontal" }
		flow = view.add{ type = "flow" , direction = "horizontal" }
		flow.add{ type = "button" , name = "sicfl-oremap-clean" , caption = { "SICFL.oremap-view-clean" } , style = "sicfl-view-button-gray" }
		flow.add{ type = "button" , name = "sicfl-oremap-fresh" , caption = { "SICFL.oremap-view-fresh" } , style = "sicfl-view-button-gray" }
		flow.add{ type = "button" , name = "sicfl-oremap-sort-count" , caption = { "SICFL.oremap-view-sort-count" } , style = "sicfl-view-button-green" }
		flow.add{ type = "button" , name = "sicfl-oremap-sort-name" , caption = { "SICFL.oremap-view-sort-name" } , style = "sicfl-view-button-green" }
		settings.elements.list = view.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" }.add{ type = "table" , column_count = 3 , style = "sicfl-oremap-list" }
		SIOremap.FreshList( settings )
		
		view.add{ type = "line" , direction = "horizontal" }
		flow = view.add{ type = "flow" , direction = "horizontal" }
		flow.add{ type = "button" , name = "sicfl-oremap-close" , caption = { "SICFL.oremap-view-close" } , style = "sicfl-view-button-red" }
		if settings.tiles then flow.add{ type = "button" , name = "sicfl-oremap-create" , caption = { "SICFL.oremap-view-create" } , style = "sicfl-view-button-green" } end
		
		settings.view = view
	end
end

function SIOremap.CloseView( playerIndex )
	local settings = SIOremap.GetSettings( playerIndex )
	if settings then
		if settings.view then
			SIOremap.SaveSettings( settings )
			
			settings.tiles = nil
			for k , v in pairs( settings.elements ) do settings.elements[k] = nil end
			settings.view.destroy()
			settings.view = nil
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 功能方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIOremap.ShowViewByPlayerIndex( playerIndex )
	SIOremap.OpenView( playerIndex )
end

function SIOremap.HideViewByPlayerIndex( playerIndex )
	SIOremap.CloseView( playerIndex )
end

function SIOremap.ShowViews()
	for playerIndex , settings in pairs( oremap ) do SIOremap.OpenView( playerIndex ) end
end

function SIOremap.HideViews()
	for playerIndex , settings in pairs( oremap ) do SIOremap.CloseView( playerIndex ) end
end

function SIOremap.GetSettings( playerIndex )
	local settings = oremap[playerIndex]
	if not settings then
		settings = table.deepcopy( SIOremap.settingsDefaultData )
		oremap[playerIndex] = settings
	end
	return settings
end

function SIOremap.SaveSettings( settings )
	settings.useSettingsAsDefault = settings.elements.useSettingsAsDefault and settings.elements.useSettingsAsDefault.state or false
	settings.totalMode = settings.elements.totalMode and settings.elements.totalMode.state or false
	settings.count = settings.elements.count and math.floor( tonumber( settings.elements.count.text ) or 0 ) or 0
end

function SIOremap.SpawnOre( player , settings )
	if settings.count < 1 then
		local subMessage = ""
		if settings.useSettingsAsDefault then subMessage = { "SICFL.oremap-settings-cannot-as-default" } end
		player.print( { "SICFL.oremap-settings-empty" , subMessage } , SIColors.printColor.orange )
		return false
	end
	local oreData = table.GetWithName( settings.oreData , settings.selectedOreName )
	if not oreData then
		player.print( { "SICFL.oremap-settings-ore-empty" } , SIColors.printColor.orange )
		return false
	end
	local tileCount = #settings.tiles
	local count = 0
	if settings.totalMode then
		if settings.count > oreData.count then
			player.print( { "SICFL.oremap-settings-ore-not-enough" } , SIColors.printColor.orange )
			return false
		end
		count = math.floor( settings.count/tileCount )
		if count > SIOremap.maxCount then
			local subMessage = ""
			if settings.useSettingsAsDefault then subMessage = { "SICFL.oremap-settings-cannot-as-default" } end
			player.print( { "SICFL.oremap-settings-too-much" , SIOremap.maxCount , subMessage } , SIColors.printColor.orange )
			return false
		end
		oreData.count = oreData.count - count * tileCount
	else
		count = settings.count
		local totalCount = count * tileCount
		if totalCount > oreData.count then
			player.print( { "SICFL.oremap-settings-ore-not-enough" } , SIColors.printColor.orange )
			return false
		end
		if count > SIOremap.maxCount then
			local subMessage = ""
			if settings.useSettingsAsDefault then subMessage = { "SICFL.oremap-settings-cannot-as-default" } end
			player.print( { "SICFL.oremap-settings-too-much" , SIOremap.maxCount , subMessage } , SIColors.printColor.orange )
			return false
		end
		oreData.count = oreData.count - totalCount
	end
	local surface = player.surface
	for i , v in pairs( settings.tiles ) do surface.create_entity{ name = oreData.name , position = v.position , amount = count } end
	if settings.useSettingsAsDefault then settings.tiles = nil end
	player.print( { "SICFL.oremap-ore-created" } , SIColors.printColor.blue )
	return true
end

function SIOremap.SortOreData( playerIndex , key )
	local settings = SIOremap.GetSettings( playerIndex )
	if settings then
		table.sort( settings.oreData , function( a , b ) return a[key] > b[key] end )
		SIOremap.FreshList( settings )
	end
end

function SIOremap.CleanOreData( playerIndex )
	local settings = SIOremap.GetSettings( playerIndex )
	if settings then
		for i = #settings.oreData , 1 , -1 do if settings.oreData[i].count == 0 then table.remove( settings.oreData , i ) end end
		SIOremap.FreshList( settings )
	end
end

function SIOremap.FreshList( settings )
	if settings.elements.list then
		local list = settings.elements.list
		list.clear()
		list.add{ type = "label" , caption = { "SICFL.oremap-view-label-icon" } , style = "sicfl-oremap-label-icon" }
		list.add{ type = "label" , caption = { "SICFL.oremap-view-label-name" } , style = "sicfl-oremap-label-long" }
		list.add{ type = "label" , caption = { "SICFL.oremap-view-label-count" } , style = "sicfl-oremap-label-long" }
		if #settings.oreData < 1 then
			list.add{ type = "sprite-button" , sprite = "item/sicfl-item-icon-empty" , style = "sicfl-oremap-list-icon" }
			list.add{ type = "label" , caption = { "SICFL.oremap-view-ore-none" } , style = "sicfl-oremap-label-long" }
			list.add{ type = "label" , caption = { "SICFL.oremap-view-ore-count-infinity" } , style = "sicfl-oremap-label-long" }
		else
			for i , v in pairs( settings.oreData ) do
				if v.name == settings.selectedOreName then
					list.add{ type = "sprite-button" , sprite = "entity/"..v.name , style = "sicfl-oremap-list-icon" }
					list.add{ type = "label" , caption = { "SICFL.oremap-view-ore-colored" , game.entity_prototypes[v.name].localised_name } , style = "sicfl-oremap-label-long" }
					list.add{ type = "label" , caption = { "SICFL.oremap-view-ore-colored" , { "SICFL.oremap-view-ore-count" , v.count } } , style = "sicfl-oremap-label-long" }
				else
					list.add{ type = "sprite-button" , name = "sicfl-oremap-ore-"..v.name , sprite = "entity/"..v.name , style = "sicfl-oremap-list-icon" }
					list.add{ type = "label" , caption = game.entity_prototypes[v.name].localised_name , style = "sicfl-oremap-label-long" }
					list.add{ type = "label" , caption = { "SICFL.oremap-view-ore-count" , v.count } , style = "sicfl-oremap-label-long" }
				end
			end
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIOremap.OnInit()
	SIToolbar.AddTool( SIOremap.toolbarButtonId , SIOremap.toolbarButtonName , SIOremap.itemName , "SICFL.oremap-toolbar-button" , "SICFL.oremap-toolbar-tooltip" , SIOremap.interfaceId , "ShowViewByPlayerIndex" )
end

function SIOremap.OnSelect( event )
	if event.item == SIOremap.itemName then
		local settings = SIOremap.GetSettings( event.player_index )
		for i , v in pairs( event.entities ) do
			if v.type == SITypes.entity.resource then
				local oreData = table.GetWithName( settings.oreData , v.name )
				if not oreData then
					oreData = table.deepcopy( SIOremap.oreDefaultData )
					oreData.name = v.name
					table.insert( settings.oreData , oreData )
				end
				oreData.count = oreData.count + v.amount
				v.destroy{ raise_destroy = true }
			end
		end
		if settings.view then SIOremap.FreshList( settings ) end
	end
end

function SIOremap.OnAltSelect( event )
	if event.item == SIOremap.itemName then
		local playerIndex = event.player_index
		local settings = SIOremap.GetSettings( playerIndex )
		local tiles = event.tiles
		if settings.useSettingsAsDefault then
			if settings.count < 1 then
				settings.useSettingsAsDefault = false
				game.players[playerIndex].print( { "SICFL.oremap-settings-empty" } , SIColors.printColor.orange )
			else
				settings.tiles = tiles
				if SIOremap.SpawnOre( game.players[playerIndex] , settings ) and settings.view then SIOremap.FreshList( settings ) end
			end
		else
			settings.tiles = tiles
			SIOremap.OpenView( playerIndex )
		end
	end
end

function SIOremap.OnOpenView( event )
	SIOremap.OpenView( event.player_index )
end

function SIOremap.OnClickView( event )
	local element = event.element
	if element.valid then
		local name = element.name
		if name == "sicfl-oremap-sort-name" then SIOremap.SortOreData( event.player_index , "name" )
		elseif name == "sicfl-oremap-sort-count" then SIOremap.SortOreData( event.player_index , "count" )
		elseif name == "sicfl-oremap-fresh" then SIOremap.FreshList( SIOremap.GetSettings( event.player_index ) )
		elseif name == "sicfl-oremap-clean" then SIOremap.CleanOreData( event.player_index )
		elseif name == "sicfl-oremap-create" then
			local playerIndex = event.player_index
			local settings = SIOremap.GetSettings( playerIndex )
			SIOremap.SaveSettings( settings )
			if SIOremap.SpawnOre( game.players[playerIndex] , settings ) then SIOremap.CloseView( playerIndex ) end
		elseif name == "sicfl-oremap-close" then SIOremap.CloseView( event.player_index )
		elseif name:StartsWith( SIOremap.iconName ) then
			local settings = SIOremap.GetSettings( event.player_index )
			settings.selectedOreName = name:sub( SIOremap.iconPosition )
			SIOremap.FreshList( settings )
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 事件注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus
.Init( SIOremap.OnInit )

.Add( SIEvents.on_player_selected_area , SIOremap.OnSelect )
.Add( SIEvents.on_player_alt_selected_area , SIOremap.OnAltSelect )

.Add( "sicfl-input-oremap" , SIOremap.OnOpenView )
.Add( SIEvents.on_gui_click , SIOremap.OnClickView )

remote.add_interface( SIOremap.interfaceId ,
{
	ShowViewByPlayerIndex = SIOremap.ShowViewByPlayerIndex ,
	HideViewByPlayerIndex = SIOremap.HideViewByPlayerIndex ,
	ShowViews = SIOremap.ShowViews ,
	HideViews = SIOremap.HideViews
} )