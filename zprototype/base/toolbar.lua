-- ------------------------------------------------------------------------------------------------
-- ---------- 创建物品 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen.NewItem( "toolbar" , 1000 ).AddFlags( SIFlags.itemFlags.hidden )

-- ------------------------------------------------------------------------------------------------
-- ---------- 创建界面 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local view =
{
	["sicfl-toolbar-list"] =
	{
		type = "table_style" ,
		
		cell_spacing = 3 ,
		vertical_spacing = 3 ,
		horizontal_spacing = 3
	} ,
	["sicfl-toolbar-open"] =
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
	["sicfl-toolbar-close"] =
	{
		type = "button_style" ,
		parent = "sicfl-toolbar-open" ,
		
		default_graphical_set = { base = { position = { 136 , 17 } , corner_size = 8 } , shadow = SIStyles.defaultDirt } ,
		hovered_graphical_set = { base = { position = { 170 , 17 } , corner_size = 8 } , shadow = SIStyles.defaultDirt , glow = SIStyles.redDirt } ,
		clicked_graphical_set = { base = { position = { 187 , 17 } , corner_size = 8 } , shadow = SIStyles.defaultDirt } ,
		disabled_graphical_set = { base = { position = { 153 , 17 } , corner_size = 8 } , shadow = SIStyles.defaultDirt }
	} ,
	["sicfl-toolbar-icon"] =
	{
		type = "button_style" ,
		parent = "sicfl-toolbar-open" ,
		
		minimal_width = 30 ,
		minimal_height = 30
	}
}

for k , v in pairs( view ) do data.raw["gui-style"]["default"][k] = v end