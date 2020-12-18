-- ------------------------------------------------------------------------------------------------
-- ---------- 创建物品 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local mapItem = SIGen.NewItem( "delmap" , 1 )
.AddFlags{ SIFlags.itemFlags.notStackable , SIFlags.itemFlags.hidden }
.SetCustomData
{
	type = SITypes.item.selectionTool ,
	show_in_library = false ,
	selection_color = { 0.90 , 0.06 , 0.53 } ,
	selection_mode = { "any-entity" } ,
	selection_cursor_box_type = "copy" ,
	alt_selection_color = { 0.55 , 0.27 , 0.41 } ,
	alt_selection_mode = { "any-tile" } ,
	alt_selection_cursor_box_type = "copy"
}
.GetCurrentEntityName()

if SICFL.canGetDebugTools then
	SIGen.NewTechnology( mapItem.."-1" )
	.SetLevel( 1 , "infinite" )
	.SetCosts( SICFL.debugPack , 40000 )
	.AddResults( SITypes.modifier.giveItem , mapItem )
end