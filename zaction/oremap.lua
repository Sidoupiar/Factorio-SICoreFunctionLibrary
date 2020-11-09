-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

CreateGlobalTable( "oremap" )

oreMapSettingsDefaultData =
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
}
oreMapOreDefaultData =
{
	name = nil ,
	count = 0
}

oreMapIconRegex = "sicfl%-oremap%-ore"
oreMapIconPosition = #"sicfl-oremap-ore-" + 1

-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function OreMapSelect( event )
	if event.item == "sicfl-item-oremap" then
		local index = event.player_index
		local settings = OreMapGetSettings( index )
		for i , v in pairs( event.entities ) do
			if v.type == SITypes.entity.resource then
				local oreData = table.GetWithName( settings.oreData , v.name )
				if not oreData then
					oreData = table.deepcopy( oreMapOreDefaultData )
					oreData.name = v.name
					table.insert( settings.oreData , oreData )
				end
				oreData.count = oreData.count + v.amount
				v.destroy{ raise_destroy = true }
			end
		end
		if settings.view then OreMapFreshList( settings ) end
	end
end

function OreMapAltSelect( event )
	if event.item == "sicfl-item-oremap" then
		local index = event.player_index
		local settings = OreMapGetSettings( index )
		local tiles = event.tiles
		if settings.useSettingsAsDefault then
			if settings.count < 1 then
				settings.useSettingsAsDefault = false
				game.players[index].print( { "SICFL.oremap-settings-empty" } , SIColors.printColor.orange )
			else
				settings.tiles = tiles
				if OreMapSpawnOre( game.players[index] , settings ) and settings.view then OreMapFreshList( settings ) end
			end
		else
			settings.tiles = tiles
			OreMapOpenView( event )
		end
	end
end

function OreMapOpenView( event )
	local index = event.player_index
	local player = game.players[index]
	local settings = OreMapGetSettings( index )
	if settings.view then OreMapCloseView( event )
	else
		local view = player.gui.center.add{ type = "frame" , name = "sicfl-oremap-view" , caption = { "SICFL.oremap-view-title" } , direction = "vertical" , style = "sicfl-oremap-view" }
		
		local flow = view.add{ type = "flow" , direction = "horizontal" }
		flow.add{ type = "label" , caption = { "SICFL.oremap-view-description" } , style = "sicfl-oremap-label-text" }
		
		view.add{ type = "line" , direction = "horizontal" }
		
		flow = view.add{ type = "flow" , direction = "horizontal" }
		flow.add{ type = "label" , caption = { "SICFL.oremap-view-settings" } , style = "sicfl-oremap-label-text" }
		flow = view.add{ type = "flow" , direction = "horizontal" }
		settings.elements.useSettingsAsDefault = flow.add{ type = "checkbox" , state = settings.useSettingsAsDefault , caption = { "SICFL.oremap-view-settings-value-use-settings-as-default" } , tooltip = { "SICFL.oremap-view-settings-tooltip-use-settings-as-default" } , style="checkbox" }
		flow = view.add{ type = "flow" , direction = "horizontal" }
		settings.elements.totalMode = flow.add{ type = "checkbox" , state = settings.totalMode , caption = { "SICFL.oremap-view-settings-value-total-mode" } , tooltip = { "SICFL.oremap-view-settings-tooltip-total-mode" } , style="checkbox" }
		flow = view.add{ type = "flow" , direction = "horizontal" }
		flow.add{ type = "label" , caption = { "SICFL.oremap-view-settings-value-count" } , tooltip = { "SICFL.oremap-view-settings-tooltip-count" } , style = "sicfl-oremap-label-short" }
		settings.elements.count = flow.add{ type = "textfield" , text = tostring( settings.count ) , numeric = true , tooltip = { "SICFL.oremap-view-settings-tooltip-count" } , style="long_number_textfield" }
		
		view.add{ type = "line" , direction = "horizontal" }
		
		flow = view.add{ type = "flow" , name = "sicfl-oremap-flow-button" , direction = "horizontal" }
		flow.add{ type = "button" , name = "sicfl-oremap-clean" , caption={ "SICFL.oremap-view-clean" } , style = "sicfl-oremap-button-gray" }
		flow.add{ type = "button" , name = "sicfl-oremap-fresh" , caption={ "SICFL.oremap-view-fresh" } , style = "sicfl-oremap-button-gray" }
		flow.add{ type = "button" , name = "sicfl-oremap-sort-count" , caption={ "SICFL.oremap-view-sort-count" } , style = "sicfl-oremap-button-green" }
		flow.add{ type = "button" , name = "sicfl-oremap-sort-name" , caption={ "SICFL.oremap-view-sort-name" } , style = "sicfl-oremap-button-green" }
		settings.elements.list = view.add{ type = "scroll-pane" , name = "sicfl-oremap-scroll" , vertical_scroll_policy = "auto-and-reserve-space" , horizontal_scroll_policy = "never" }.add{ type = "table" , name = "sicfl-oremap-list" , column_count = 3 , style = "sicfl-oremap-list" }
		OreMapFreshList( settings )
		
		view.add{ type = "line" , direction = "horizontal" }
		
		flow = view.add{ type = "flow" , name = "sicfl-oremap-flow-confirm" , direction = "horizontal" }
		flow.add{ type = "button" , name = "sicfl-oremap-close" , caption={ "SICFL.oremap-view-close" } , style = "sicfl-oremap-button-red" }
		if settings.tiles then flow.add{ type = "button" , name = "sicfl-oremap-create" , caption={ "SICFL.oremap-view-create" } , style = "sicfl-oremap-button-green" } end
		
		settings.view = view
	end
end

function OreMapCloseView( event )
	local settings = OreMapGetSettings( event.player_index )
	if settings then
		if settings.view then
			OreMapSaveSettings( settings )
			
			settings.tiles = nil
			for k , v in pairs( settings.elements ) do settings.elements[k] = nil end
			settings.view.destroy()
			settings.view = nil
		end
	end
end

function OreMapClickView( event )
	local element = event.element
	if element.valid then
		local name = element.name
		if name == "sicfl-oremap-sort-name" then OreMapSortOreData( event.player_index , "name" )
		elseif name == "sicfl-oremap-sort-count" then OreMapSortOreData( event.player_index , "count" )
		elseif name == "sicfl-oremap-fresh" then OreMapFreshList( OreMapGetSettings( event.player_index ) )
		elseif name == "sicfl-oremap-clean" then OreMapCleanOreData( event.player_index )
		elseif name == "sicfl-oremap-create" then
			local index = event.player_index
			local settings = OreMapGetSettings( index )
			OreMapSaveSettings( settings )
			if OreMapSpawnOre( game.players[index] , settings ) then OreMapCloseView( event ) end
		elseif name == "sicfl-oremap-close" then
			OreMapCloseView( event )
		elseif name:find( oreMapIconRegex ) then
			local settings = OreMapGetSettings( event.player_index )
			settings.selectedOreName = name:sub( oreMapIconPosition )
			OreMapFreshList( settings )
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 功能方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function OreMapGetSettings( index )
	local settings = oremap[index]
	if not settings then
		settings = table.deepcopy( oreMapSettingsDefaultData )
		oremap[index] = settings
	end
	return settings
end

function OreMapSaveSettings( settings )
	settings.useSettingsAsDefault = settings.elements.useSettingsAsDefault and settings.elements.useSettingsAsDefault.state or false
	settings.totalMode = settings.elements.totalMode and settings.elements.totalMode.state or false
	settings.count = settings.elements.count and math.floor( tonumber( settings.elements.count.text ) ) or 0
end

function OreMapSpawnOre( player , settings )
	if settings.count < 1 then
		player.print( { "SICFL.oremap-settings-empty" } , SIColors.printColor.orange )
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
		oreData.count = oreData.count - count * tileCount
	else
		count = settings.count
		local totalCount = count * tileCount
		if totalCount > oreData.count then
			player.print( { "SICFL.oremap-settings-ore-not-enough" } , SIColors.printColor.orange )
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

function OreMapSortOreData( index , key )
	local settings = OreMapGetSettings( index )
	if settings then
		table.sort( settings.oreData , function( a , b ) return a[key] > b[key] end )
		OreMapFreshList( settings )
	end
end

function OreMapCleanOreData( index )
	local settings = OreMapGetSettings( index )
	if settings then
		for i = #settings.oreData , 1 , -1 do if settings.oreData[i].count == 0 then table.remove( settings.oreData , i ) end end
		OreMapFreshList( settings )
	end
end

function OreMapFreshList( settings )
	if settings.elements.list then
		local list = settings.elements.list
		list.clear()
		list.add{ type = "label" , caption = { "SICFL.oremap-view-label-icon" } , style="sicfl-oremap-label-icon" }
		list.add{ type = "label" , caption = { "SICFL.oremap-view-label-name" } , style="sicfl-oremap-label-long" }
		list.add{ type = "label" , caption = { "SICFL.oremap-view-label-count" } , style="sicfl-oremap-label-long" }
		if #settings.oreData < 1 then
			list.add{ type = "sprite-button" , sprite = "item/sicfl-item-empty" , style = "sicfl-oremap-list-icon" }
			list.add{ type = "label" , caption = { "SICFL.oremap-view-ore-none" } , style="sicfl-oremap-label-long" }
			list.add{ type = "label" , caption = { "SICFL.oremap-view-ore-count-infinity" } , style="sicfl-oremap-label-long" }
		else
			for i , v in pairs( settings.oreData ) do
				if v.name == settings.selectedOreName then
					list.add{ type = "sprite-button" , sprite = "entity/"..v.name , style = "sicfl-oremap-list-icon" }
					list.add{ type = "label" , caption = { "SICFL.oremap-view-ore-colored" , game.entity_prototypes[v.name].localised_name } , style="sicfl-oremap-label-long" }
					list.add{ type = "label" , caption = { "SICFL.oremap-view-ore-colored" , { "SICFL.oremap-view-ore-count" , v.count } } , style="sicfl-oremap-label-long" }
				else
					list.add{ type = "sprite-button" , name = "sicfl-oremap-ore-"..v.name , sprite = "entity/"..v.name , style = "sicfl-oremap-list-icon" }
					list.add{ type = "label" , caption = game.entity_prototypes[v.name].localised_name , style="sicfl-oremap-label-long" }
					list.add{ type = "label" , caption = { "SICFL.oremap-view-ore-count" , v.count } , style="sicfl-oremap-label-long" }
				end
			end
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 事件注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus

.Add( SIEvents.on_player_selected_area , OreMapSelect )
.Add( SIEvents.on_player_alt_selected_area , OreMapAltSelect )

.Add( "sicfl-oremap" , OreMapOpenView )
.Add( SIEvents.on_gui_click , OreMapClickView )