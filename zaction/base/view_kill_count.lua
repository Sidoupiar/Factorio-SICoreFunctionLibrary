-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIViewKillCount =
{
	show = "sicfl-show-kill-count" ,
	
	playerViewData =
	{
		view = nil
	}
}

SIGlobal.Create( "SIViewKillCountViews" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 窗口方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIViewKillCount.OpenView( playerIndex , viewData )
	if viewData and not viewData.view then
		viewData.view = SITitlebarViews[playerIndex].viewKillCount.add{ type = "label" , style = "sicfl-view-kill-count-label-text" }
		SIViewEvolution.FreshViews( playerIndex , viewData )
	end
end

function SIViewKillCount.CloseView( playerIndex , viewData )
	if viewData and viewData.view then
		viewData.view.destroy()
		viewData.view = nil
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 功能方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIViewKillCount.OpenViewByPlayerIndex( playerIndex , settings )
	local viewData = SIViewKillCountViews[playerIndex]
	if not viewData then
		viewData = table.deepcopy( SIViewKillCount.playerViewData )
		SIViewKillCountViews[playerIndex] = viewData
	end
	if settings[SIViewKillCount.show] and not viewData.view then SIViewKillCount.OpenView( playerIndex , viewData )
	else SIViewKillCount.CloseView( playerIndex , viewData ) end
end

function SIViewKillCount.FreshViews( playerIndex , viewData )
	if viewData and viewData.view then
		local statistics = game.players[playerIndex].force.kill_count_statistics
		viewData.view.caption = { "SICFL.view-kill-count" , 1 , 1 , 1 }
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIViewKillCount.OnCycle( event )
	for playerIndex , viewData in pairs( SIViewKillCountViews ) do SIViewKillCount.FreshViews( playerIndex , viewData ) end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 方法注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus.AddNth( 60 , SIViewKillCount.OnCycle )