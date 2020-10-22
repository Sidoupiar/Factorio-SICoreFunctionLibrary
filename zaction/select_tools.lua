-- 圈选逻辑
function onPlayerSelectArea( event )
	if event.item == "sicfl-item-ancient-delmap" then
		for i , v in pairs( event.entities ) do
			if v and v.valid and v.prototype and v.prototype.type ~= "character" then ExDestroy( v , true ) end
		end
	end
end

function onPlayerAltSelectArea( event )
	if event.item == "sicfl-item-ancient-delmap" then
		local surface = game.players[event.player_index].surface
		for i , v in pairs( event.tiles ) do
			if #surface.find_entities_filtered{ area = { { v.position.x , v.position.y } , { v.position.x+1 , v.position.y+1 } } } < 1 then
				surface.set_tiles{ { name = "deepwater" , position = v.position } }
			end
		end
	end
end

script.on_event( SIEvents.on_player_selected_area , onPlayerSelectArea )
script.on_event( SIEvents.on_player_alt_selected_area , onPlayerAltSelectArea )