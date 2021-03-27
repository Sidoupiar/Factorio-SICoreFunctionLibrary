-- ------------------------------------------------------------------------------------------------
-- ------ 创建物品和快捷键 ------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local mapItem = SIGen.NewItem( "oremap" , 1 )
.AddFlags{ SIFlags.itemFlags.notStackable , SIFlags.itemFlags.hidden }
.SetCustomData
{
	type = SITypes.item.selectionTool ,
	show_in_library = false ,
	selection_color = { 0.70 , 0.57 , 0.00 } ,
	selection_mode = { "any-entity" } ,
	selection_cursor_box_type = "copy" ,
	alt_selection_color = { 1.00 , 0.82 , 0.00 } ,
	alt_selection_mode = { "any-tile" } ,
	alt_selection_cursor_box_type = "copy"
}
.GetCurrentEntityName()

if SICFL.canGetDebugTools then
	SIGen.NewTechnology( mapItem.."-1" )
	.SetLevel( 1 , "infinite" )
	.SetCosts( SICFL.debugPack , 20000 )
	.AddResults( SITypes.modifier.giveItem , mapItem )
end

SIGen.NewInput( "oremap" , "SHIFT + O" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 创建界面 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen.NewStyle( "oremap-view" ,
{
	type = "frame_style" ,
	parent = "frame" ,
	
	minimal_width = 100 ,
	minimal_height = 100 ,
	maximal_height = 700
} )
.NewStyle( "oremap-list" ,
{
	type = "table_style" ,
	
	cell_spacing = 2 ,
	horizontal_spacing = 1 ,
	vertical_spacing = 1
} )
.NewStyle( "oremap-list-icon" ,
{
	type = "button_style" ,
	parent = "button" ,
	
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	
	minimal_width = 32 ,
	minimal_height = 32
} )
.NewStyle( "oremap-label-icon" ,
{
	type = "label_style" ,
	
	width = 32 ,
	
	horizontal_align = "center"
} )
.NewStyle( "oremap-label-text" ,
{
	type = "label_style" ,
	
	width = 250 ,
	
	horizontal_align = "left"
} )
.NewStyle( "oremap-label-short" ,
{
	type = "label_style" ,
	
	minimal_width = 20 ,
	
	horizontal_align = "right"
} )
.NewStyle( "oremap-label-long" ,
{
	type = "label_style" ,
	
	width = 219 ,
	
	horizontal_align = "center"
} )