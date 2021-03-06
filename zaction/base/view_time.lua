-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIViewTime =
{
	show = "sicfl-show-time" ,
	
	playerViewData =
	{
		view = nil
	}
}

SIGlobal.Create( "SIViewTimeViews" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 窗口方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIViewTime.OpenView( playerIndex , viewData )
	if viewData and not viewData.view then
		viewData.view = SITitlebarViews[playerIndex].viewTime.add{ type = "label" , style = "sicfl-view-time-label-text" }
		SIViewTime.FreshViews( playerIndex , viewData )
	end
end

function SIViewTime.CloseView( playerIndex , viewData )
	if viewData and viewData.view then
		viewData.view.destroy()
		viewData.view = nil
		
		SITitlebarViews[playerIndex].viewTime.clear()
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 功能方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIViewTime.OpenViewByPlayerIndex( playerIndex , currentSettings )
	local viewData = SIViewTimeViews[playerIndex]
	if not viewData then
		viewData = table.deepcopy( SIViewTime.playerViewData )
		SIViewTimeViews[playerIndex] = viewData
	end
	if currentSettings[SIViewTime.show] then SIViewTime.OpenView( playerIndex , viewData )
	else SIViewTime.CloseView( playerIndex , viewData ) end
end

function SIViewTime.CloseViewByPlayerIndex( playerIndex )
	local viewData = SIViewTimeViews[playerIndex]
	SIViewTime.CloseView( playerIndex , viewData )
end

function SIViewTime.FreshViews( playerIndex , viewData )
	if viewData and viewData.view then
		viewData.view.caption = { "SICFL.view-time" , date.FormatDateByTick( game.ticks_played ) }
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIViewTime.OnCycle( event )
	for playerIndex , viewData in pairs( SIViewTimeViews ) do SIViewTime.FreshViews( playerIndex , viewData ) end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 方法注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus.AddNth( 60 , SIViewTime.OnCycle )