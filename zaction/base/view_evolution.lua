-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIViewEvolution =
{
	show = "sicfl-show-evolution" ,
	
	playerViewData =
	{
		view = nil
	}
}

SIGlobal.Create( "SIViewEvolutionViews" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 窗口方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIViewEvolution.OpenView( playerIndex , viewData )
	if viewData and not viewData.view then
		viewData.view = SITitlebarViews[playerIndex].viewEvolution.add{ type = "label" , style = "sicfl-view-evolution-label-text" }
		SIViewEvolution.FreshViews( playerIndex , viewData )
	end
end

function SIViewEvolution.CloseView( playerIndex , viewData )
	if viewData and viewData.view then
		viewData.view.destroy()
		viewData.view = nil
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 功能方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIViewEvolution.OpenViewByPlayerIndex( playerIndex , currentSettings )
	local viewData = SIViewEvolutionViews[playerIndex]
	if not viewData then
		viewData = table.deepcopy( SIViewEvolution.playerViewData )
		SIViewEvolutionViews[playerIndex] = viewData
	end
	if currentSettings[SIViewEvolution.show] and not viewData.view then SIViewEvolution.OpenView( playerIndex , viewData )
	else SIViewEvolution.CloseView( playerIndex , viewData ) end
end

function SIViewEvolution.FreshViews( playerIndex , viewData )
	if viewData and viewData.view then
		viewData.view.caption = { "SICFL.view-evolution" , string.format( "%.3f" , game.forces["enemy"].evolution_factor*100 ) }
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIViewEvolution.OnCycle( event )
	for playerIndex , viewData in pairs( SIViewEvolutionViews ) do SIViewEvolution.FreshViews( playerIndex , viewData ) end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 方法注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus.AddNth( 60 , SIViewEvolution.OnCycle )