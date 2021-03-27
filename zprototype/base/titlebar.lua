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

SIGen.NewStyle( "titlebar-view" ,
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
		shadow = nil
	}
} )
.NewStyle( "titlebar-button-flow" ,
{
	type = "vertical_flow_style" ,
	
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	
	minimal_width = 0 ,
	vertical_spacing = 3 ,
	
	horizontal_align = "right"
} )
.NewStyle( "titlebar-flow" ,
{
	type = "vertical_flow_style" ,
	
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	
	minimal_width = 0 ,
	vertical_spacing = 0
} )
.NewStyle( "titlebar-open" ,
{
	type = "button_style" ,
	parent = "button" ,
	
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	
	minimal_width = 40 ,
	minimal_height = 40
} )
.NewStyle( "titlebar-finder" ,
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
.NewStyle( "view-evolution-label-text" ,
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
} )
.NewStyle( "view-kill-count-label-text" ,
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
} )
.NewStyle( "view-time-label-text" ,
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
} )
.NewStyle( "view-game-speed-button" ,
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
} )
.NewStyle( "view-game-speed-button-small" ,
{
	autoParent = true ,
	
	type = "button_style" ,
	parent = "view-game-speed-button" ,
	
	minimal_width = 15
} )
.NewStyle( "view-button-gray" , SIStyles.ColorButton( 0 , SIStyles.grayDirt ) )
.NewStyle( "view-button-green" , SIStyles.ColorButton( 68 , SIStyles.greenDirt ) )
.NewStyle( "view-button-red" , SIStyles.ColorButton( 136 , SIStyles.redDirt ) )