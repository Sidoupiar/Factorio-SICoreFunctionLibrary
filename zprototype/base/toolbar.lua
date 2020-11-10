SIGen.NewItem( "toolbar" , 1000 )

local view =
{
	["sicfl-toolbar-view"] =
	{
		type = "frame_style" ,
		parent = "frame" ,
		
		top_padding = 5 ,
		right_padding = 5 ,
		bottom_padding = 5 ,
		left_padding = 5 ,
		
		minimal_width = 50 ,
		minimal_height = 50
	} ,
	["sicfl-toolbar-list"] =
	{
		type = "table_style" ,
		cell_spacing = 3 ,
		horizontal_spacing = 3 ,
		vertical_spacing = 3
	} ,
	["sicfl-toolbar-open"] =
	{
		type = "button_style" ,
		parent = "button" ,
		minimal_width = 50 ,
		minimal_height = 50 ,
		top_padding = 0 ,
		right_padding = 0 ,
		bottom_padding = 0 ,
		left_padding = 0
	} ,
	["sicfl-toolbar-close"] =
	{
		type = "button_style" ,
		parent = "button" ,
		minimal_width = 50 ,
		minimal_height = 50 ,
		top_padding = 0 ,
		right_padding = 0 ,
		bottom_padding = 0 ,
		left_padding = 0 ,
		default_graphical_set = { base = { position = { 136 , 17 } , corner_size = 8 } , shadow = SIStyles.defaultDirt } ,
		hovered_graphical_set = { base = { position = { 170 , 17 } , corner_size = 8 } , shadow = SIStyles.defaultDirt , glow = SIStyles.greenDirt } ,
		clicked_graphical_set = { base = { position = { 187 , 17 } , corner_size = 8 } , shadow = SIStyles.defaultDirt } ,
		disabled_graphical_set = { base = { position = { 153 , 17 } , corner_size = 8 } , shadow = SIStyles.defaultDirt }
	} ,
	["sicfl-toolbar-icon"] =
	{
		type = "button_style" ,
		parent = "button" ,
		minimal_width = 40 ,
		minimal_height = 40 ,
		top_padding = 0 ,
		right_padding = 0 ,
		bottom_padding = 0 ,
		left_padding = 0
	}
}

for k , v in pairs( view ) do data.raw["gui-style"]["default"][k] = v end