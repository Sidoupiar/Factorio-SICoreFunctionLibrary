-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIViewFinder =
{
	interfaceId = "sicfl-view-finder" ,
	waitFunctionId = "sicfl-view-finder" ,
	
	playerViewData =
	{
		view = nil ,
		chooser = nil ,
		label = nil ,
		inputList = nil ,
		outputList = nil
	}
}

SIGlobal.Create( "SIViewFinderViews" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 窗口方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIViewFinder.OpenView( playerIndex , viewData , itemName )
	if viewData and not viewData.view then
		local player = game.players[playerIndex]
		local view = player.gui.center.add{ type = "frame" , name = "sicfl-view-finder-view" , caption = { "SICFL.view-finder-view-title" } , direction = "vertical" , style = "sicfl-view-finder-view" }
		
		local flow = view.add{ type = "flow" , direction = "horizontal" }
		flow.add{ type = "label" , caption = { "SICFL.view-finder-view-current-item" } , style = "sicfl-view-finder-title-text" }
		viewData.chooser = flow.add{ type = "choose-elem-button" , name = "sicfl-view-finder-chooser" , tooltip = { "SICFL.view-finder-view-chooser" } , elem_type = "item" , item = "sicfl-item-icon-empty" , style = "sicfl-view-finder-button-chooser" }
		viewData.label = flow.add{ type = "label" , name = "sicfl-view-finder-chooser-label" , style = "sicfl-view-finder-title-text" }
		
		view.add{ type = "line" , direction = "horizontal" }
		flow = view.add{ type = "flow" , direction = "horizontal" }
		
		local inputFlow = flow.add{ type = "flow" , direction = "vertical" , style = "sicfl-view-finder-list-flow" }
		inputFlow.add{ type = "label" , caption = { "SICFL.view-finder-view-input" } , style = "sicfl-view-finder-list-text" }
		viewData.inputList = inputFlow.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" }.add{ type = "table" , column_count = 2 , style = "sicfl-view-finder-list" }
		
		local outputFlow = flow.add{ type = "flow" , direction = "vertical" , style = "sicfl-view-finder-list-flow" }
		outputFlow.add{ type = "label" , caption = { "SICFL.view-finder-view-output" } , style = "sicfl-view-finder-list-text" }
		viewData.outputList = outputFlow.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" }.add{ type = "table" , column_count = 2 , style = "sicfl-view-finder-list" }
		
		view.add{ type = "line" , direction = "horizontal" }
		view.add{ type = "button" , name = "sicfl-view-finder-close" , caption = { "SICFL.view-finder-close" } , style = "sicfl-view-button-red" }
		
		viewData.view = view
		
		SIViewFinder.FreshViews( playerIndex , viewData , itemName )
	end
end

function SIViewFinder.CloseView( playerIndex , viewData )
	if viewData and viewData.view then
		viewData.view.destroy()
		
		viewData.view = nil
		viewData.chooser = nil
		viewData.label = nil
		viewData.inputList = nil
		viewData.outputList = nil
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 功能方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIViewFinder.OpenViewByPlayerIndex( playerIndex , itemName )
	local viewData = SIViewFinderViews[playerIndex]
	if not viewData then
		viewData = table.deepcopy( SIViewFinder.playerViewData )
		SIViewFinderViews[playerIndex] = viewData
	end
	if viewData.view then SIViewFinder.FreshViews( playerIndex , viewData , itemName )
	else SIViewFinder.OpenView( playerIndex , viewData , itemName ) end
end

function SIViewFinder.FreshViews( playerIndex , viewData , itemName )
	if viewData and viewData.view then
		viewData.inputList.clear()
		viewData.outputList.clear()
		
		local item = nil
		if not itemName then
			viewData.chooser.elem_value = "sicfl-item-icon-empty"
			viewData.label.caption = { "SICFL.view-finder-empty" }
			
			local player = game.players[playerIndex]
			local itemStack = player.cursor_stack
			if not itemStack or not itemStack.valid_for_read or not itemStack.valid then
				SIViewFinder.AddLine( viewData.inputList , nil , nil )
				SIViewFinder.AddLine( viewData.outputList , nil , nil )
				return
			end
			item = itemStack.prototype
			itemName = item.name
			viewData.chooser.elem_value = itemName
		else
			item = game.item_prototypes[itemName]
			if not item then
				SIViewFinder.AddLine( viewData.inputList , nil , nil )
				SIViewFinder.AddLine( viewData.outputList , nil , nil )
				return
			end
		end
		
		viewData.label.caption = { "SICFL.view-finder-view-current-item-name" , item.localised_name }
		
		local noInput = true
		for name , recipe in pairs( game.recipe_prototypes ) do
			for index , product in pairs( recipe.products ) do
				if product.name == itemName then
					SIViewFinder.AddLine( viewData.inputList , item , recipe )
					noInput = false
					break
				end
			end
		end
		if noInput then SIViewFinder.AddLine( viewData.inputList , nil , nil ) end
		
		noInput = true
		local placeResult = item.place_result or {}
		local categories = placeResult.crafting_categories or {}
		local filters = {}
		for category , enabled in pairs( categories ) do table.insert( filters , { filter = "category" , category = category } ) end
		if #filters > 0 then
			for name , recipe in pairs( game.get_filtered_recipe_prototypes( filters ) ) do
				SIViewFinder.AddLine( viewData.outputList , item , recipe )
				noInput = false
			end
		end
		if noInput then SIViewFinder.AddLine( viewData.outputList , nil , nil ) end
	end
end

function SIViewFinder.AddLine( list , item , recipe )
	if list then
		if recipe then
			local input = ""
			local count = #recipe.ingredients
			for index , ingredient in pairs( recipe.ingredients ) do
				input = input .. ingredient.amount .. "×" .. "[" .. ingredient.type .. "=" .. ingredient.name .. "]"
				if index < count then input = input .. " + " end
			end
			if input == "" then input = "[item=sicfl-item-icon-empty]" end
			local output = ""
			count = #recipe.products
			for index , product in pairs( recipe.products ) do
				output = output .. ( product.probability < 1 and "(" .. ( product.probability * 100 ) .. "%)" or "" ) .. ( product.amount and product.amount or product.amount_min .. "~" .. product.amount_max ) .. "×" .. "[" .. product.type .. "=" .. product.name .. "]"
				if index < count then output = output .. " + " end
			end
			list.add{ type = "sprite-button" , sprite = "recipe/"..recipe.name , tooltip = recipe.localised_name , style = "sicfl-view-finder-list-icon" }
			list.add{ type = "label" , caption = { "SICFL.view-finder-recipe-string" , input , output } , style = "sicfl-view-finder-list-text" }
		else
			list.add{ type = "sprite-button" , sprite = "item/sicfl-item-icon-empty" , style = "sicfl-view-finder-list-icon" }
			list.add{ type = "label" , caption = { "SICFL.view-finder-empty" } , style = "sicfl-view-finder-list-text" }
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIViewFinder.OnClick( event )
	local element = event.element
	if element.valid then
		local name = element.name
		if name == "sicfl-view-finder-close" then
			local playerIndex = event.player_index
			SIViewFinder.CloseView( playerIndex , SIViewFinderViews[playerIndex] )
		end
	end
end

function SIViewFinder.OnElemClick( event )
	local element = event.element
	if element.valid then
		local name = element.name
		if name == "sicfl-view-finder-chooser" then SIViewFinder.OpenViewByPlayerIndex( event.player_index , element.elem_value ) end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 方法注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus
.Add( SIEvents.on_gui_click , SIViewFinder.OnClick )
.Add( SIEvents.on_gui_elem_changed , SIViewFinder.OnElemClick )