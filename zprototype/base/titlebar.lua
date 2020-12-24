-- ------------------------------------------------------------------------------------------------
-- ---------- 创建物品 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
.NewItem( "titlebar" , 1000 ).AddFlags( SIFlags.itemFlags.hidden )
.NewItem( "finder" , 1000 ).AddFlags( SIFlags.itemFlags.hidden )

-- ------------------------------------------------------------------------------------------------
-- ---------- 创建界面 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SICFL.titlebarFont = SIGen.NewFont( "titlebar" , 10 ).GetCurrentEntityName()
SICFL.textFont = SIGen.NewFont( "text" , 12 ).GetCurrentEntityName()

local view =
{
	["sicfl-titlebar-view"] =
	{
		type = "frame_style" ,
		parent = "frame" ,
		
		top_padding = 5 ,
		right_padding = 5 ,
		bottom_padding = 5 ,
		left_padding = 5 ,
		
		minimal_width = 50 ,
		minimal_height = 50 ,
		
		graphical_set =
		{
			base = { position = { 162 , 932 } , corner_size = 8 } ,
			shadow = default_shadow
		}
	} ,
	["sicfl-titlebar-button-flow"] =
	{
		type = "vertical_flow_style" ,
		
		top_padding = 0 ,
		right_padding = 0 ,
		bottom_padding = 0 ,
		left_padding = 0 ,
		
		minimal_width = 0 ,
		vertical_spacing = 3 ,
		
		horizontal_align = "right"
	} ,
	["sicfl-titlebar-flow"] =
	{
		type = "vertical_flow_style" ,
		
		top_padding = 0 ,
		right_padding = 0 ,
		bottom_padding = 0 ,
		left_padding = 0 ,
		
		minimal_width = 0 ,
		vertical_spacing = 0
	} ,
	["sicfl-titlebar-open"] =
	{
		type = "button_style" ,
		parent = "button" ,
		
		top_padding = 0 ,
		right_padding = 0 ,
		bottom_padding = 0 ,
		left_padding = 0 ,
		
		minimal_width = 40 ,
		minimal_height = 40
	} ,
	["sicfl-titlebar-finder"] =
	{
		type = "button_style" ,
		parent = "button" ,
		
		top_padding = 0 ,
		right_padding = 0 ,
		bottom_padding = 0 ,
		left_padding = 0 ,
		
		minimal_width = 30 ,
		minimal_height = 30
	} ,
	["sicfl-view-evolution-label-text"] =
	{
		type = "label_style" ,
		
		top_padding = 0 ,
		right_padding = 0 ,
		bottom_padding = 0 ,
		left_padding = 0 ,
		
		minimal_width = 100 ,
		minimal_height = 10 ,
		
		font = SICFL.titlebarFont ,
		horizontal_align = "left"
	} ,
	["sicfl-view-kill-count-label-text"] =
	{
		type = "label_style" ,
		
		top_padding = 0 ,
		right_padding = 0 ,
		bottom_padding = 0 ,
		left_padding = 0 ,
		
		minimal_width = 100 ,
		minimal_height = 10 ,
		
		font = SICFL.titlebarFont ,
		horizontal_align = "left"
	} ,
	["sicfl-view-time-label-text"] =
	{
		type = "label_style" ,
		
		top_padding = 0 ,
		right_padding = 0 ,
		bottom_padding = 0 ,
		left_padding = 0 ,
		
		minimal_width = 100 ,
		minimal_height = 10 ,
		
		font = SICFL.titlebarFont ,
		horizontal_align = "left"
	} ,
	["sicfl-view-game-speed-button"] =
	{
		type = "button_style" ,
		parent = "button" ,
		
		top_padding = 0 ,
		right_padding = 0 ,
		bottom_padding = 0 ,
		left_padding = 0 ,
		
		minimal_width = 80 ,
		minimal_height = 15 ,
		
		font = SICFL.titlebarFont
	} ,
	["sicfl-view-game-speed-button-small"] =
	{
		type = "button_style" ,
		parent = "sicfl-view-game-speed-button" ,
		
		minimal_width = 15
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

view["sicfl-view-button-gray"] = ColorButton( 0 , SIStyles.grayDirt )
view["sicfl-view-button-green"] = ColorButton( 68 , SIStyles.greenDirt )
view["sicfl-view-button-red"] = ColorButton( 136 , SIStyles.redDirt )

for k , v in pairs( view ) do data.raw["gui-style"]["default"][k] = v end