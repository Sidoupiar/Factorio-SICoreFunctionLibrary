local view =
{
	["sicfl-toolbar-view"] =
	{
		type = "frame_style" ,
		parent = "frame" ,
		minimal_width = 136 ,
		minimal_height = 68 ,
		maximal_height = 68
	} ,
	["sicfl-toolbar-list"] =
	{
		type = "table_style" ,
		cell_spacing = 2 ,
		horizontal_spacing = 1 ,
		vertical_spacing = 1
	} ,
	["sicfl-toolbar-open"] =
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
	["sicfl-toolbar-close"] =
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
	["sicfl-toolbar-icon"] =
	{
		type = "button_style" ,
		parent = "button" ,
		minimal_width = 32 ,
		minimal_height = 32 ,
		top_padding = 0 ,
		right_padding = 0 ,
		bottom_padding = 0 ,
		left_padding = 0
	}
}

for k , v in pairs( view ) do data.raw["gui-style"]["default"][k] = v end