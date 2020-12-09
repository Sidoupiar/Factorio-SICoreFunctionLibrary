-- ------------------------------------------------------------------------------------------------
-- ---------- 创建物品 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen.NewItem( "titlebar" , 1000 ).AddFlags( SIFlags.itemFlags.hidden )

-- ------------------------------------------------------------------------------------------------
-- ---------- 创建界面 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

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
		minimal_height = 50
	} ,
	["sicfl-titlebar-open"] =
	{
		type = "button_style" ,
		parent = "button" ,
		
		top_padding = 0 ,
		right_padding = 0 ,
		bottom_padding = 0 ,
		left_padding = 0 ,
		
		minimal_width = 50 ,
		minimal_height = 50
	}
}

for k , v in pairs( view ) do data.raw["gui-style"]["default"][k] = v end