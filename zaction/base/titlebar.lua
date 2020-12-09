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
		view.add{ type = "sprite-button" , name = "sicfl-view-settings-button" , sprite = "item/sicfl-item-titlebar" , tooltip = { "SICFL.view-settings-open" } , style = "sicfl-titlebar-open" }
		local toolbar = view.add{ type = "flow" , name = "sicfl-toolbar-view" , direction = "horizontal" }
		local viewEvolution = view.add{ type = "flow" , name = "sicfl-view-evolution-view" , direction = "vertical" }
		local viewKillCount = view.add{ type = "flow" , name = "sicfl-view-kill-count-view" , direction = "vertical" }
		local viewTime = view.add{ type = "flow" , name = "sicfl-view-time-view" , direction = "vertical" }
		local viewGameSpeed = view.add{ type = "flow" , name = "sicfl-view-game-speed-view" , direction = "vertical" }
		
		viewData.view = view
		viewData.toolbar = toolbar
		viewData.viewEvolution = viewEvolution
		viewData.viewKillCount = viewKillCount
		viewData.viewTime = viewTime
		viewData.viewGameSpeed = viewGameSpeed
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 功能方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SITitlebar.FreshViews( playerIndex , settings )
	SIViewEvolution.OpenViewByPlayerIndex( playerIndex , settings )
	SIViewKillCount.OpenViewByPlayerIndex( playerIndex , settings )
	SIViewTime.OpenViewByPlayerIndex( playerIndex , settings )
	SIViewGameSpeed.OpenViewByPlayerIndex( playerIndex , settings )
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
		if name == "sicfl-view-settings-button" then SIViewSettings.OpenViewByPlayerIndex( event.player_index ) end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 方法注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus
.Add( SIEvents.on_player_joined_game , SITitlebar.OnInitPlayer )
.Add( SIEvents.on_gui_click , SITitlebar.OnClick )