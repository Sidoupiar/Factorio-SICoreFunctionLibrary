SIGen

.NewItem( "delmap" , 1 )
.AddFlags{ SIFlags.itemFlags.notStackable , SIFlags.itemFlags.hidden }
.SetCustomData
{
	type = SITypes.item.selection_tool ,
	show_in_library = false ,
	selection_color = { 0.90 , 0.06 , 0.53 } ,
	selection_mode = { "any-entity" } ,
	selection_cursor_box_type = "copy" ,
	alt_selection_color = { 0.55 , 0.27 , 0.41 } ,
	alt_selection_mode = { "any-tile" } ,
	alt_selection_cursor_box_type = "copy"
}

.NewItem( "oremap" , 1 )
.AddFlags{ SIFlags.itemFlags.notStackable , SIFlags.itemFlags.hidden }
.SetCustomData
{
	type = SITypes.item.selection_tool ,
	show_in_library = false ,
	selection_color = { 0.70 , 0.57 , 0.00 } ,
	selection_mode = { "any-entity" } ,
	selection_cursor_box_type = "copy" ,
	alt_selection_color = { 1.00 , 0.82 , 0.00 } ,
	alt_selection_mode = { "any-tile" } ,
	alt_selection_cursor_box_type = "copy"
}