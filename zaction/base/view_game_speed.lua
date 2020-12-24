-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIViewGameSpeed =
{
	show = "sicfl-show-game-speed" ,
	
	maxSpeed = 1000 ,
	minSpeed = 0.01 ,
	
	playerViewData =
	{
		main = nil ,
		up1 = nil ,
		up2 = nil ,
		down1 = nil ,
		down2 = nil ,
		data =
		{
			lastSpeed = nil
		}
	}
}

SIGlobal.Create( "SIViewGameSpeedViews" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 窗口方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIViewGameSpeed.OpenView( playerIndex , viewData )
	if viewData and not viewData.main then
		local view = SITitlebarViews[playerIndex].viewGameSpeed
		viewData.down2 = view.add{ type = "button" , name = "sicfl-view-game-speed-down2" , caption = { "SICFL.view-game-speed-down2" } , tooltip = { "SICFL.view-game-speed-down2-description" } , style = "sicfl-view-game-speed-button-small" }
		viewData.down1 = view.add{ type = "button" , name = "sicfl-view-game-speed-down1" , caption = { "SICFL.view-game-speed-down1" } , tooltip = { "SICFL.view-game-speed-down1-description" } , style = "sicfl-view-game-speed-button-small" }
		viewData.main = view.add{ type = "button" , name = "sicfl-view-game-speed-main" , style = "sicfl-view-game-speed-button" }
		viewData.up1 = view.add{ type = "button" , name = "sicfl-view-game-speed-up1" , caption = { "SICFL.view-game-speed-up1" } , tooltip = { "SICFL.view-game-speed-up1-description" } , style = "sicfl-view-game-speed-button-small" }
		viewData.up2 = view.add{ type = "button" , name = "sicfl-view-game-speed-up2" , caption = { "SICFL.view-game-speed-up2" } , tooltip = { "SICFL.view-game-speed-up2-description" } , style = "sicfl-view-game-speed-button-small" }
		
		SIViewGameSpeed.FreshViews( playerIndex , viewData )
	end
end

function SIViewGameSpeed.CloseView( playerIndex , viewData )
	if viewData and viewData.main then
		viewData.main.destroy()
		viewData.up1.destroy()
		viewData.up2.destroy()
		viewData.down1.destroy()
		viewData.down2.destroy()
		
		viewData.main = nil
		viewData.up1 = nil
		viewData.up2 = nil
		viewData.down1 = nil
		viewData.down2 = nil
		
		SITitlebarViews[playerIndex].viewGameSpeed.clear()
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 功能方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIViewGameSpeed.OpenViewByPlayerIndex( playerIndex , currentSettings )
	local viewData = SIViewGameSpeedViews[playerIndex]
	if not viewData then
		viewData = table.deepcopy( SIViewGameSpeed.playerViewData )
		SIViewGameSpeedViews[playerIndex] = viewData
	end
	if currentSettings[SIViewGameSpeed.show] then SIViewGameSpeed.OpenView( playerIndex , viewData )
	else SIViewGameSpeed.CloseView( playerIndex , viewData ) end
end

function SIViewGameSpeed.CloseViewByPlayerIndex( playerIndex )
	local viewData = SIViewGameSpeedViews[playerIndex]
	SIViewGameSpeed.CloseView( playerIndex , viewData )
end

function SIViewGameSpeed.FreshViews( playerIndex , viewData )
	if viewData and viewData.main then
		local speed = game.speed
		viewData.main.caption = { "SICFL.view-game-speed" , speed }
		viewData.main.tooltip = { "SICFL.view-game-speed-description" , viewData.data.lastSpeed or { "SICFL.view-game-speed-description-no-last-speed" } }
		if speed >= SIViewGameSpeed.maxSpeed then
			viewData.up1.enabled = false
			viewData.up2.enabled = false
		else
			viewData.up1.enabled = true
			viewData.up2.enabled = true
		end
		if speed <= SIViewGameSpeed.minSpeed then
			viewData.down1.enabled = false
			viewData.down2.enabled = false
		else
			viewData.down1.enabled = true
			viewData.down2.enabled = true
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIViewGameSpeed.OnClick( event )
	local element = event.element
	if element.valid then
		local name = element.name
		if name == "sicfl-view-game-speed-up1" then
			local playerIndex = event.player_index
			local viewData = SIViewGameSpeedViews[playerIndex]
			viewData.data.lastSpeed = game.speed
			
			local speed = game.speed
			if speed < 1 then speed = speed + 0.1
			else speed = speed + 1 end
			if speed > SIViewGameSpeed.maxSpeed then speed = SIViewGameSpeed.maxSpeed end
			game.speed = speed
			
			SIViewGameSpeed.FreshViews( playerIndex , viewData )
		elseif name == "sicfl-view-game-speed-up2" then
			local playerIndex = event.player_index
			local viewData = SIViewGameSpeedViews[playerIndex]
			viewData.data.lastSpeed = game.speed
			
			local speed = game.speed * 2
			if speed > SIViewGameSpeed.maxSpeed then speed = SIViewGameSpeed.maxSpeed end
			game.speed = speed
			
			SIViewGameSpeed.FreshViews( playerIndex , viewData )
		elseif name == "sicfl-view-game-speed-down1" then
			local playerIndex = event.player_index
			local viewData = SIViewGameSpeedViews[playerIndex]
			viewData.data.lastSpeed = game.speed
			
			local speed = game.speed
			if speed < 1.5 then speed = speed - 0.1
			else speed = speed - 1 end
			if speed < SIViewGameSpeed.minSpeed then speed = SIViewGameSpeed.minSpeed end
			game.speed = speed
			
			SIViewGameSpeed.FreshViews( playerIndex , viewData )
		elseif name == "sicfl-view-game-speed-down2" then
			local playerIndex = event.player_index
			local viewData = SIViewGameSpeedViews[playerIndex]
			viewData.data.lastSpeed = game.speed
			
			local speed = game.speed / 2
			if speed < SIViewGameSpeed.minSpeed then speed = SIViewGameSpeed.minSpeed end
			game.speed = speed
			
			SIViewGameSpeed.FreshViews( playerIndex , viewData )
		elseif name == "sicfl-view-game-speed-main" then
			local button = event.button
			local playerIndex = event.player_index
			local viewData = SIViewGameSpeedViews[playerIndex]
			if button == defines.mouse_button_type.right then
				local lastSpeed = game.speed
				game.speed = viewData.data.lastSpeed or 1
				viewData.data.lastSpeed = lastSpeed
			else
				if game.speed ~= 1 then viewData.data.lastSpeed = game.speed end
				game.speed = 1
			end
			
			SIViewGameSpeed.FreshViews( playerIndex , viewData )
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 方法注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus
.Add( SIEvents.on_gui_click , SIViewGameSpeed.OnClick )