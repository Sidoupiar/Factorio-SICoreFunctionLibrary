-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIViewSettings =
{
	interfaceId = "sicfl-view-settings" ,
	waitFunctionId = "sicfl-view-settings" ,
	
	settings = {} ,
	settingNames = {} ,
	
	playerViewData =
	{
		view = nil ,
		settingBoxes = {} ,
		currentSettings = {}
	}
}

for name , data in pairs( SICFL.settings ) do
	if data[2] == "runtime-per-user" then
		local settingName = SICFL.realname..name:gsub( "_" , "-" )
		SIViewSettings.settings[settingName] = { data[1] , data[3] }
		table.insert( SIViewSettings.settingNames , settingName )
	end
end

SIGlobal.Create( "SIViewSettingsViews" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 窗口方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIViewSettings.OpenView( playerIndex , viewData )
	if viewData and not viewData.view then
		local player = game.players[playerIndex]
		local view = player.gui.center.add{ type = "frame" , name = "sicfl-view-settings-view" , caption = { "SICFL.view-settings-view-title" } , direction = "vertical" , style = "sicfl-view-settings-view" }
		local flow = view.add{ type = "flow" , direction = "horizontal" }
		flow.add{ type = "label" , caption = { "SICFL.view-settings-view-description" } , style = "sicfl-view-settings-label-text" }
		flow.add{ type = "label" , caption = { "SICFL.view-settings-view-note" } , style = "sicfl-view-settings-label-text" }
		
		view.add{ type = "line" , direction = "horizontal" }
		view.add{ type = "flow" , direction = "horizontal" }.add{ type = "button" , name = "sicfl-view-settings-default" , caption = { "SICFL.view-settings-default" } , style = "sicfl-view-settings-button-gray" }
		
		view.add{ type = "line" , direction = "horizontal" }
		local settingData = player.mod_settings
		for name , data in pairs( SIViewSettings.settings ) do
			local value = settingData[name].value
			flow = view.add{ type = "flow" , direction = "horizontal" }
			viewData.settingBoxes[name] = flow.add{ type = "checkbox" , state = value , caption = { "mod-setting-name."..name } , tooltip = { "mod-setting-description."..name } , style = "checkbox" }
			viewData.currentSettings[name] = value
		end
		
		view.add{ type = "line" , direction = "horizontal" }
		flow = view.add{ type = "flow" , direction = "horizontal" }
		flow.add{ type = "button" , name = "sicfl-view-settings-cancel" , caption = { "SICFL.view-settings-cancel" } , style = "sicfl-view-settings-button-red" }
		flow.add{ type = "button" , name = "sicfl-view-settings-confirm" , caption = { "SICFL.view-settings-confirm" } , style = "sicfl-view-settings-button-green" }
		
		viewData.view = view
	end
end

function SIViewSettings.CloseView( playerIndex , viewData )
	if viewData and viewData.view then
		SITitlebar.FreshViews( playerIndex , viewData.currentSettings )
		
		viewData.view.destroy()
		
		viewData.view = nil
		viewData.settingBoxes = {}
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 功能方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIViewSettings.OpenViewByPlayerIndex( playerIndex )
	local viewData = SIViewSettingsViews[playerIndex]
	if not viewData then
		viewData = table.deepcopy( SIViewSettings.playerViewData )
		SIViewSettingsViews[playerIndex] = viewData
	end
	if viewData.view then SIViewSettings.CloseView( playerIndex , viewData )
	else SIViewSettings.OpenView( playerIndex , viewData ) end
end

function SIViewSettings.SaveSettings( playerIndex , viewData )
	if viewData then
		local settingData = settings.get_player_settings( playerIndex )
		for name , data in pairs( SIViewSettings.settings ) do
			local value = viewData.settingBoxes[name].state
			viewData.currentSettings[name] = value
			settingData[name] = { value = value }
		end
	end
end

function SIViewSettings.ToDefault( viewData )
	if viewData then
		for name , data in pairs( SIViewSettings.settings ) do viewData.settingBoxes[name].state = data[2] end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIViewSettings.OnChange( event )
	if event.setting_type == "runtime-per-user" then
		local name = event.setting
		if table.Has( SIViewSettings.settingNames , name ) then
			local playerIndex = event.player_index
			local viewData = SIViewSettingsViews[playerIndex]
			viewData.currentSettings[name] = settings.get_player_settings( playerIndex )[name].value
			
			SITitlebar.FreshViews( playerIndex , viewData.currentSettings )
		end
	end
end

function SITitlebar.OnClick( event )
	local element = event.element
	if element.valid then
		local name = element.name
		if name == "sicfl-view-settings-confirm" then
			local playerIndex = event.player_index
			local viewData = SIViewSettingsViews[playerIndex]
			SIViewSettings.SaveSettings( playerIndex , viewData )
			SIViewSettings.CloseView( playerIndex , viewData )
		elseif name == "sicfl-view-settings-cancel" then
			local playerIndex = event.player_index
			SIViewSettings.CloseView( playerIndex , SIViewSettingsViews[playerIndex] )
		elseif name == "sicfl-view-settings-default" then
			SIViewSettings.ToDefault( SIViewSettingsViews[event.player_index] )
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 方法注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus
.Add( SIEvents.on_runtime_mod_setting_changed , SIViewSettings.OnChange )
.Add( SIEvents.on_gui_click , SITitlebar.OnClick )