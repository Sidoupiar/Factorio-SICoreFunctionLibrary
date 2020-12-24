-- ------------------------------------------------------------------------------------------------
-- ---------- 创建界面 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local view =
{
	["sicfl-view-settings-view"] =
	{
		type = "frame_style" ,
		parent = "frame" ,
		
		minimal_width = 100 ,
		minimal_height = 100 ,
		maximal_height = 700
	} ,
	["sicfl-view-settings-label-text"] =
	{
		type = "label_style" ,
		
		width = 500 ,
		
		font = SICFL.textFont ,
		single_line = false ,
		horizontal_align = "left"
	}
}

for k , v in pairs( view ) do data.raw["gui-style"]["default"][k] = v end