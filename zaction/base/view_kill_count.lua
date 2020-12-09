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
		SIViewKillCount.FreshViews( playerIndex , viewData )
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

function SIViewKillCount.OpenViewByPlayerIndex( playerIndex , currentSettings )
	local viewData = SIViewKillCountViews[playerIndex]
	if not viewData then
		viewData = table.deepcopy( SIViewKillCount.playerViewData )
		SIViewKillCountViews[playerIndex] = viewData
	end
	if currentSettings[SIViewKillCount.show] then SIViewKillCount.OpenView( playerIndex , viewData )
	else SIViewKillCount.CloseView( playerIndex , viewData ) end
end

function SIViewKillCount.FreshViews( playerIndex , viewData )
	if viewData and viewData.view then
		local statistics = game.players[playerIndex].force.kill_count_statistics
		local totalCount = 0
		local bitCount = 0
		local spawnerCount = 0
		local turretCount = 0
		for name , count in pairs( statistics.input_counts ) do totalCount = totalCount + count end
		for name , data in pairs( game.get_filtered_entity_prototypes{ { filter = "type" , type = "unit" } } ) do bitCount = bitCount + statistics.get_input_count( name ) end
		for name , data in pairs( game.get_filtered_entity_prototypes{ { filter = "type" , type = "unit-spawner" } } ) do spawnerCount = spawnerCount + statistics.get_input_count( name ) end
		for name , data in pairs( game.get_filtered_entity_prototypes{ { filter = "type" , type = "turret" } } ) do turretCount = turretCount + statistics.get_input_count( name ) end
		viewData.view.caption = { "SICFL.view-kill-count" , bitCount , spawnerCount , turretCount , totalCount-bitCount-spawnerCount-turretCount }
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

SIEventBus.AddNth( 410 , SIViewKillCount.OnCycle )