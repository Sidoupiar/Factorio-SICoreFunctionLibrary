-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SITitlebar =
{
	interfaceId = "sicfl-titlebar" ,
	waitFunctionId = "sicfl-titlebar" ,
	
	playerViewData =
	{
		view = nil ,
		toolbar = nil ,
		viewEvolution = nil ,
		viewKillCount = nil ,
		viewTime = nil ,
		viewGameSpeed = nil
	}
}

SIGlobal.Create( "SITitlebarViews" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 窗口方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SITitlebar.OpenView( playerIndex , viewData )
	if viewData and not viewData.view then
		local player = game.players[playerIndex]
		local view = player.gui.top.add{ type = "frame" , name = "sicfl-titlebar-view" , direction = "horizontal" , style = "sicfl-titlebar-view" }
		local flow = view.add{ type = "flow" , direction = "vertical" , style = "sicfl-titlebar-button-flow" }
		flow.add{ type = "sprite-button" , name = "sicfl-view-settings-button" , sprite = "item/sicfl-item-titlebar" , tooltip = { "SICFL.view-settings-open" } , style = "sicfl-titlebar-open" }
		flow.add{ type = "sprite-button" , name = "sicfl-view-finder-button" , sprite = "item/sicfl-item-finder" , tooltip = { "SICFL.view-finder-open" } , style = "sicfl-titlebar-finder" }
		flow = view.add{ type = "flow" , direction = "vertical" , style = "sicfl-titlebar-flow" }
		viewData.viewEvolution = flow.add{ type = "flow" , name = "sicfl-view-evolution-view" , direction = "vertical" }
		viewData.viewKillCount = flow.add{ type = "flow" , name = "sicfl-view-kill-count-view" , direction = "vertical" }
		viewData.viewTime = flow.add{ type = "flow" , name = "sicfl-view-time-view" , direction = "vertical" }
		viewData.viewGameSpeed = flow.add{ type = "flow" , name = "sicfl-view-game-speed-view" , direction = "horizontal" }
		viewData.toolbar = view.add{ type = "flow" , name = "sicfl-toolbar-view" , direction = "horizontal" }
		
		viewData.view = view
		
		-- 显示工具栏
		Implement_SIToolbar.ShowViewByPlayerIndex( playerIndex )
		-- 读取当前默认设置
		local currentSettings = {}
		local settingData = player.mod_settings
		for name , data in pairs( SIViewSettings.settings ) do currentSettings[name] = settingData[name].value end
		SITitlebar.FreshViews( playerIndex , currentSettings )
	end
end

function SITitlebar.CloseView( playerIndex , viewData )
	if viewData and viewData.view then
		-- 移除工具栏
		Implement_SIToolbar.HideViewByPlayerIndex( playerIndex )
		-- 移除各个组件
		SIViewEvolution.CloseViewByPlayerIndex( playerIndex )
		SIViewKillCount.CloseViewByPlayerIndex( playerIndex )
		SIViewTime.CloseViewByPlayerIndex( playerIndex )
		SIViewGameSpeed.CloseViewByPlayerIndex( playerIndex )
		
		viewData.view.destroy()
		
		viewData.view = nil
		
		viewData.viewEvolution = nil
		viewData.viewKillCount = nil
		viewData.viewTime = nil
		viewData.viewGameSpeed = nil
		viewData.toolbar = nil
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 功能方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SITitlebar.FreshViews( playerIndex , currentSettings )
	SIViewEvolution.OpenViewByPlayerIndex( playerIndex , currentSettings )
	SIViewKillCount.OpenViewByPlayerIndex( playerIndex , currentSettings )
	SIViewTime.OpenViewByPlayerIndex( playerIndex , currentSettings )
	SIViewGameSpeed.OpenViewByPlayerIndex( playerIndex , currentSettings )
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SITitlebar.OnInitPlayer( event )
	local playerIndex = event.player_index
	local viewData = SITitlebarViews[playerIndex]
	if not viewData then
		viewData = table.deepcopy( SITitlebar.playerViewData )
		SITitlebarViews[playerIndex] = viewData
	end
	SITitlebar.OpenView( playerIndex , viewData )
end

function SITitlebar.OnClick( event )
	local element = event.element
	if element.valid then
		local name = element.name
		if name == "sicfl-view-settings-button" then SIViewSettings.OpenViewByPlayerIndex( event.player_index )
		elseif name == "sicfl-view-finder-button" then SIViewFinder.OpenViewByPlayerIndex( event.player_index ) end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 方法注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus
.Add( SIEvents.on_player_joined_game , SITitlebar.OnInitPlayer )
.Add( SIEvents.on_gui_click , SITitlebar.OnClick )