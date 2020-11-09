SIGen

.NewItem( "oremap" , 1 )
.AddFlags{ SIFlags.itemFlags.notStackable , SIFlags.itemFlags.hidden }
.SetCustomData
{
	type = SITypes.item.selection_tool ,
	show_in_library = false ,
	selection_color = { 0.70 , 0.57 , 0.00 } ,
	selection_mode = { "any-entity" } ,
	selection_cursor_box_type = "copy" ,
	alt_selection_color = { 1.00 , 0.82 , 0.00 } ,
	alt_selection_mode = { "any-tile" } ,
	alt_selection_cursor_box_type = "copy"
}

.NewInput( "oremap" , "SHIFT + O" )

local fnc = {}
local hnc = {}
local def = { 0.01 , 0.01 , 0.01 , 0.4 }
local gra = { 0.9 , 0.9 , 0.3 , 0.5 }
local gre = { 0.35 , 1 , 0.35 , 0.5 }
local red = { 1 , 0.35 , 0.35 , 0.5 }

local function def_glow( tint_value , scale_value )
	return
	{
		position = { 200 , 128 } ,
		corner_size = 8 ,
		tint = tint_value ,
		scale = scale_value ,
		draw_type = "outer"
	}
end

local def_dirt = def_glow( def , 0.5 )
local gra_dirt = def_glow( gra , 0.5 )
local gre_dirt = def_glow( gre , 0.5 )
local red_dirt = def_glow( red , 0.5 )

local view =
{
	["sicfl-oremap-view"] =
	{
		type = "frame_style" ,
		parent = "frame" ,
		minimal_width = 100 ,
		minimal_height = 100 ,
		maximal_height = 700
	} ,
	["sicfl-oremap-list"] =
	{
		type = "table_style" ,
		cell_spacing = 2 ,
		horizontal_spacing = 1 ,
		vertical_spacing = 1
	} ,
	["sicfl-oremap-list-icon"] =
	{
		type = "button_style" ,
		parent = "button" ,
		minimal_width = 32 ,
		minimal_height = 32 ,
		top_padding = 0 ,
		right_padding = 0 ,
		bottom_padding = 0 ,
		left_padding = 0
	} ,
	["sicfl-oremap-label-icon"] =
	{
		type = "label_style" ,
		width = 32 ,
		horizontal_align = "center"
	} ,
	["sicfl-oremap-label-text"] =
	{
		type = "label_style" ,
		width = 250 ,
		horizontal_align = "left"
	} ,
	["sicfl-oremap-label-short"] =
	{
		type = "label_style" ,
		minimal_width = 20 ,
		horizontal_align = "right"
	} ,
	["sicfl-oremap-label-long"] =
	{
		type = "label_style" ,
		width = 219 ,
		horizontal_align = "center"
	}
}

local function color_button( loc , dirt )
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
		default_font_color = fnc ,
		hovered_font_color = hnc ,
		clicked_font_color = hnc ,
		disabled_font_color = { 0.7 , 0.7 , 0.7 } ,
		selected_font_color = hnc ,
		selected_hovered_font_color = hnc ,
		selected_clicked_font_color = hnc ,
		strikethrough_color = { 0.5 , 0.5 , 0.5 } ,
		pie_progress_color = { 1 , 1 , 1 } ,
		default_graphical_set = { base = { position = { loc , 17 } , corner_size = 8 } , shadow = def_dirt } ,
		hovered_graphical_set = { base = { position = { loc+34 , 17 } , corner_size = 8 } , shadow = def_dirt , glow = dirt } ,
		clicked_graphical_set = { base = { position = { loc+51 , 17 } , corner_size = 8 } , shadow = def_dirt } ,
		disabled_graphical_set = { base = { position = { loc+17 , 17 } , corner_size = 8 } , shadow = def_dirt } ,
		selected_graphical_set = { base = { position = { 225 , 17 } , corner_size = 8 } , shadow = def_dirt } ,
		selected_hovered_graphical_set = { base = { position = { 369 , 17 } , corner_size = 8 } , shadow = def_dirt } ,
		selected_clicked_graphical_set = { base = { position = { 352 , 17 } , corner_size = 8 } , shadow = def_dirt } ,
		left_click_sound = { { filename = "__core__/sound/gui-click.ogg" ,  volume = 1 } }
	}
end

view["sicfl-oremap-button-gray"] = color_button( 0 , gra_dirt )
view["sicfl-oremap-button-green"] = color_button( 68 , gre_dirt )
view["sicfl-oremap-button-red"] = color_button( 136 , red_dirt )

for k , v in pairs( view ) do data.raw["gui-style"]["default"][k] = v end