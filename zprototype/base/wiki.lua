SIGen.NewItem( "wiki" , 1000 )

local view =
{
	["sicfl-wiki-view"] =
	{
		type = "frame_style" ,
		parent = "frame" ,
		
		top_padding = 5 ,
		right_padding = 5 ,
		bottom_padding = 5 ,
		left_padding = 5 ,
		
		minimal_width = 100 ,
		minimal_height = 450 ,
		maximal_height = 450
	} ,
	["sicfl-wiki-list"] =
	{
		type = "table_style" ,
		cell_spacing = 3 ,
		horizontal_spacing = 3 ,
		vertical_spacing = 3
	} ,
	["sicfl-wiki-icon"] =
	{
		type = "button_style" ,
		parent = "button" ,
		
		top_padding = 0 ,
		right_padding = 0 ,
		bottom_padding = 0 ,
		left_padding = 0 ,
		
		minimal_width = 100 ,
		maximal_width = 100 ,
		minimal_height = 40 ,
		maximal_height = 40
	} ,
	["sicfl-wiki-view-inner"] =
	{
		type = "frame_style" ,
		parent = "frame" ,
		
		top_padding = 0 ,
		right_padding = 0 ,
		bottom_padding = 0 ,
		left_padding = 0 ,
		
		minimal_width = 500 ,
		maximal_width = 500 ,
		minimal_height = 0
	}
}

for k , v in pairs( view ) do data.raw["gui-style"]["default"][k] = v end