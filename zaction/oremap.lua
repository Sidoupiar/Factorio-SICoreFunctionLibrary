-- 创建数据
CreateGlobalTable( "oremap" )

-- 左键圈选
SIEventBus.Add( SIEvents.on_player_selected_area , function( event )
	if event.item == "sicfl-item-oremap" then
		for i , v in pairs( event.entities ) do
			if v.prototype == SITypes.entity.resource then
				
			end
		end
	end
end )

-- shift+左键圈选
SIEventBus.Add( SIEvents.on_player_alt_selected_area , function( event )
	if event.item == "sicfl-item-oremap" then
		local index = event.player_index
		local settings = oremap[index]
		if not settings then
			game.players[index].print( { "sicfl.oremap-settings-empty" } , SIColors.printColor.orange )
			return
		end
		local surface = game.players[index].surface
		for i , v in pairs( event.tiles ) do
			
		end
	end
end )