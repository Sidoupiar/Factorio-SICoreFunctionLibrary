-- ------------------------------------------------------------------------------------------------
-- ------ 创建物品和快捷键 ------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local mapItem = SIGen.NewItem( "reqmap" , 1 )
.AddFlags{ SIFlags.itemFlags.notStackable , SIFlags.itemFlags.hidden }
.SetCustomData
{
	type = SITypes.item.selectionTool ,
	show_in_library = false ,
	selection_color = { 0.84 , 0.06 , 0.92 } ,
	selection_mode = { "any-entity" } ,
	selection_cursor_box_type = "copy" ,
	alt_selection_color = { 0.51 , 0.03 , 0.55 } ,
	alt_selection_mode = { "any-entity" } ,
	alt_selection_cursor_box_type = "copy"
}
.GetCurrentEntityName()

if SICFL.canGetDebugTools then
	SIGen.NewTechnology( mapItem.."-1" )
	.SetLevel( 1 , "infinite" )
	.SetCosts( SICFL.debugPack , 1000 )
	.AddResults( SITypes.modifier.giveItem , mapItem )
end

SIGen.NewInput( "reqmap" , "SHIFT + P" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 创建界面 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen.NewStyle( "reqmap-view" ,
{
	type = "frame_style" ,
	parent = "frame" ,
	
	minimal_width = 100 ,
	minimal_height = 100 ,
	maximal_height = 700
} )
.NewStyle( "reqmap-list" ,
{
	type = "table_style" ,
	
	cell_spacing = 2 ,
	horizontal_spacing = 1 ,
	vertical_spacing = 1
} )
.NewStyle( "reqmap-list-icon" ,
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
.NewStyle( "reqmap-label-icon" ,
{
	type = "label_style" ,
	
	width = 32 ,
	
	horizontal_align = "center"
} )
.NewStyle( "reqmap-label-text" ,
{
	type = "label_style" ,
	
	width = 250 ,
	
	horizontal_align = "left"
} )
.NewStyle( "reqmap-label-short" ,
{
	type = "label_style" ,
	
	minimal_width = 20 ,
	
	horizontal_align = "right"
} )
.NewStyle( "reqmap-label-long" ,
{
	type = "label_style" ,
	
	width = 219 ,
	
	horizontal_align = "center"
} )