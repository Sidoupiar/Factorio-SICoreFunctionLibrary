-- ------------------------------------------------------------------------------------------------
-- ------ 创建物品和快捷键 ------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local mapItem = SIGen.NewItem( "reqmap" , 1 )
.AddFlags{ SIFlags.itemFlags.notStackable , SIFlags.itemFlags.hidden }
.SetCustomData
{
	type = SITypes.item.selectionTool ,
	show_in_library = false ,
	selection_color = { 0.84 , 0.06 , 0.92 } ,
	selection_mode = { "any-entity" } ,
	selection_cursor_box_type = "copy" ,
	alt_selection_color = { 0.51 , 0.03 , 0.55 } ,
	alt_selection_mode = { "any-entity" } ,
	alt_selection_cursor_box_type = "copy"
}
.GetCurrentEntityName()

if SICFL.canGetDebugTools then
	SIGen.NewTechnology( mapItem.."-1" )
	.SetLevel( 1 , "infinite" )
	.SetCosts( SICFL.debugPack , 1000 )
	.AddResults( SITypes.modifier.giveItem , mapItem )
end

SIGen.NewInput( "reqmap" , "SHIFT + P" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 创建界面 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local view =
{
	["sicfl-reqmap-view"] =
	{
		type = "frame_style" ,
		parent = "frame" ,
		minimal_width = 100 ,
		minimal_height = 100 ,
		maximal_height = 700
	} ,
	["sicfl-reqmap-list"] =
	{
		type = "table_style" ,
		cell_spacing = 2 ,
		horizontal_spacing = 1 ,
		vertical_spacing = 1
	} ,
	["sicfl-reqmap-list-icon"] =
	{
		type = "button_style" ,
		parent = "button" ,
		
		top_padding = 0 ,
		right_padding = 0 ,
		bottom_padding = 0 ,
		left_padding = 0 ,
		
		minimal_width = 32 ,
		minimal_height = 32
	} ,
	["sicfl-reqmap-label-icon"] =
	{
		type = "label_style" ,
		width = 32 ,
		horizontal_align = "center"
	} ,
	["sicfl-reqmap-label-text"] =
	{
		type = "label_style" ,
		width = 250 ,
		horizontal_align = "left"
	} ,
	["sicfl-reqmap-label-short"] =
	{
		type = "label_style" ,
		minimal_width = 20 ,
		horizontal_align = "right"
	} ,
	["sicfl-reqmap-label-long"] =
	{
		type = "label_style" ,
		width = 219 ,
		horizontal_align = "center"
	}
}

local function ColorButton( location , dirt )
	return
	{
		type = "button_style" ,
		font = "default-semibold" ,
		horizontal_align = "center" ,
		vertical_align = "center" ,
		icon_horizontal_align = "center" ,
		top_padding = 0 ,
		bottom_padding = 0 ,
		left_padding = 8 ,
		right_padding = 8 ,
		minimal_width = 108 ,
		minimal_height = 28 ,
		clicked_vertical_offset = 1 ,
		default_font_color = SIColors.fontColor.black ,
		hovered_font_color = SIColors.fontColor.black ,
		clicked_font_color = SIColors.fontColor.black ,
		disabled_font_color = { 0.7 , 0.7 , 0.7 } ,
		selected_font_color = SIColors.fontColor.black ,
		selected_hovered_font_color = SIColors.fontColor.black ,
		selected_clicked_font_color = SIColors.fontColor.black ,
		strikethrough_color = { 0.5 , 0.5 , 0.5 } ,
		pie_progress_color = { 1 , 1 , 1 } ,
		default_graphical_set = { base = { position = { location , 17 } , corner_size = 8 } , shadow = SIStyles.defaultDirt } ,
		hovered_graphical_set = { base = { position = { location+34 , 17 } , corner_size = 8 } , shadow = SIStyles.defaultDirt , glow = dirt } ,
		clicked_graphical_set = { base = { position = { location+51 , 17 } , corner_size = 8 } , shadow = SIStyles.defaultDirt } ,
		disabled_graphical_set = { base = { position = { location+17 , 17 } , corner_size = 8 } , shadow = SIStyles.defaultDirt } ,
		selected_graphical_set = { base = { position = { 225 , 17 } , corner_size = 8 } , shadow = SIStyles.defaultDirt } ,
		selected_hovered_graphical_set = { base = { position = { 369 , 17 } , corner_size = 8 } , shadow = SIStyles.defaultDirt } ,
		selected_clicked_graphical_set = { base = { position = { 352 , 17 } , corner_size = 8 } , shadow = SIStyles.defaultDirt } ,
		left_click_sound = { { filename = "__core__/sound/gui-click.ogg" ,  volume = 1 } }
	}
end

view["sicfl-reqmap-button-gray"] = ColorButton( 0 , SIStyles.grayDirt )
view["sicfl-reqmap-button-green"] = ColorButton( 68 , SIStyles.greenDirt )
view["sicfl-reqmap-button-red"] = ColorButton( 136 , SIStyles.redDirt )

for k , v in pairs( view ) do data.raw["gui-style"]["default"][k] = v end