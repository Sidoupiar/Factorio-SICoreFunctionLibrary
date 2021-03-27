-- ------------------------------------------------------------------------------------------------
-- ---------- 创建界面 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen.NewStyle( "view-finder-view" ,
{
	type = "frame_style" ,
	parent = "frame" ,
	
	minimal_width = 100 ,
	minimal_height = 100 ,
	maximal_height = 650
} )
.NewStyle( "view-finder-list-flow" ,
{
	type = "vertical_flow_style" ,
	
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	
	vertical_spacing = 0
} )
.NewStyle( "view-finder-title-text" ,
{
	type = "label_style" ,
	
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	
	minimal_width = 30 ,
	height = 30 ,
	
	vertical_align = "center" ,
	horizontal_align = "center"
} )
.NewStyle( "view-finder-button-chooser" ,
{
	type = "button_style" ,
	parent = "button" ,
	
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	
	minimal_width = 30 ,
	minimal_height = 30
} )
.NewStyle( "view-finder-list-text" ,
{
	type = "label_style" ,
	
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	
	width = 500 ,
	minimal_height = 10 ,
	
	font = SICFL.textFont ,
	horizontal_align = "left"
} )
.NewStyle( "view-finder-list" ,
{
	type = "table_style" ,
	
	minimal_height = 488 ,
	cell_spacing = 2 ,
	horizontal_spacing = 1 ,
	vertical_spacing = 1
} )
.NewStyle( "view-finder-list-icon" ,
{
	type = "button_style" ,
	parent = "button" ,
	
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	
	minimal_width = 20 ,
	minimal_height = 20
} )