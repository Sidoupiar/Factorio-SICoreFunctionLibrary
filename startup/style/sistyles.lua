-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIStyles =
{
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIStyles.CreateGlow( tint , scale )
	return
	{
		position = { 200 , 128 } ,
		corner_size = 8 ,
		tint = tint ,
		scale = scale ,
		draw_type = "outer"
	}
end

function SIStyles.ColorButton( location , dirt )
	return
	{
		type = "button_style" ,
		font = "default-semibold" ,
		horizontal_align = "center" ,
		vertical_align = "center" ,
		icon_horizontal_align = "center" ,
		top_padding = 0 ,
		bottom_padding = 0 ,
		left_padding = 8 ,
		right_padding = 8 ,
		minimal_width = 108 ,
		minimal_height = 28 ,
		clicked_vertical_offset = 1 ,
		default_font_color = SIColors.fontColor.black ,
		hovered_font_color = SIColors.fontColor.black ,
		clicked_font_color = SIColors.fontColor.black ,
		disabled_font_color = { 0.7 , 0.7 , 0.7 } ,
		selected_font_color = SIColors.fontColor.black ,
		selected_hovered_font_color = SIColors.fontColor.black ,
		selected_clicked_font_color = SIColors.fontColor.black ,
		strikethrough_color = { 0.5 , 0.5 , 0.5 } ,
		pie_progress_color = { 1 , 1 , 1 } ,
		default_graphical_set = { base = { position = { location , 17 } , corner_size = 8 } , shadow = SIStyles.defaultDirt } ,
		hovered_graphical_set = { base = { position = { location+34 , 17 } , corner_size = 8 } , shadow = SIStyles.defaultDirt , glow = dirt } ,
		clicked_graphical_set = { base = { position = { location+51 , 17 } , corner_size = 8 } , shadow = SIStyles.defaultDirt } ,
		disabled_graphical_set = { base = { position = { location+17 , 17 } , corner_size = 8 } , shadow = SIStyles.defaultDirt } ,
		selected_graphical_set = { base = { position = { 225 , 17 } , corner_size = 8 } , shadow = SIStyles.defaultDirt } ,
		selected_hovered_graphical_set = { base = { position = { 369 , 17 } , corner_size = 8 } , shadow = SIStyles.defaultDirt } ,
		selected_clicked_graphical_set = { base = { position = { 352 , 17 } , corner_size = 8 } , shadow = SIStyles.defaultDirt } ,
		left_click_sound = { { filename = "__core__/sound/gui-click.ogg" ,  volume = 1 } }
	}
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 构建数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIStyles.defaultDirt = SIStyles.CreateGlow( SIColors.buttonColor.default , 0.5 )
SIStyles.grayDirt = SIStyles.CreateGlow( SIColors.buttonColor.gray , 0.5 )
SIStyles.greenDirt = SIStyles.CreateGlow( SIColors.buttonColor.green , 0.5 )
SIStyles.redDirt = SIStyles.CreateGlow( SIColors.buttonColor.red , 0.5 )