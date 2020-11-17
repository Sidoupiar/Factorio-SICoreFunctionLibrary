local entity = SIGen.HealthEntity:Copy( "pipe" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.pipe )



function entity:DefaultFlags()
	return self:SetParam( "flags" , { SIFlags.entityFlags.placeablePlayer , SIFlags.entityFlags.playerCreation , SIFlags.entityFlags.fastReplaceableBuild } )
end



function entity:SetImage( path )
	local width = self:GetWidth()
	local height = self:GetHeight()
	if not width or width <= 0 or not height or height <= 0 then return self end
	
	local baseName = self:GetBaseName()
	local imagePath = path .. "entity/" .. baseName .. "/"
	local hasHr = self:GetHasHr()
	width = self:GetWidth() * SINumbers.SINumbers.machinePictureSize + 32
	height = self:GetHeight() * SINumbers.SINumbers.machinePictureSize + 32
	
	return self:SetParam( "icon" , path.."item/"..baseName..".png" )
	:SetParam( "pictures" ,
	{
		straight_vertical_single = SIPics.NewLayer( "straight-vertical-single" , width+16 , height+16 , nil , hasHr ).Priority( "extra-high" ).Get() ,
		straight_vertical = SIPics.NewLayer( "straight-vertical" , width , height , nil , hasHr ).Priority( "extra-high" ).Copy() ,
		straight_horizontal = SIPics.File( "straight-horizontal" ).Copy() ,
		straight_vertical_window = SIPics.File( "straight-vertical-window" ).Copy() ,
		straight_horizontal_window = SIPics.File( "straight-horizontal-window" ).Copy() ,
		vertical_window_background = SIPics.File( "vertical-window-background" ).Copy() ,
		horizontal_window_background = SIPics.File( "horizontal-window-background" ).Copy() ,
		corner_up_left = SIPics.File( "corner-up-left" ).Copy() ,
		corner_up_right = SIPics.File( "corner-up-right" ).Copy() ,
		corner_down_left = SIPics.File( "corner-down-left" ).Copy() ,
		corner_down_right = SIPics.File( "corner-down-right" ).Copy() ,
		t_up = SIPics.File( "t-up" ).Copy() ,
		t_down = SIPics.File( "t-down" ).Copy() ,
		t_left = SIPics.File( "t-left" ).Copy() ,
		t_right = SIPics.File( "t-right" ).Copy() ,
		cross = SIPics.File( "cross" ).Copy() ,
		ending_up = SIPics.File( "ending-up" ).Copy() ,
		ending_down = SIPics.File( "ending-down" ).Copy() ,
		ending_left = SIPics.File( "ending-left" ).Copy() ,
		ending_right = SIPics.File( "ending-right" ).Get() ,
		fluid_background = SIPics.NewLayer( "fluid-background" , 32 , 20 ).Priority( "extra-high" ).Get() ,
		low_temperature_flow = SIPics.NewLayer( "fluid-flow-low-temperature" , 160 , 18 ).Priority( "extra-high" ).Copy() ,
		middle_temperature_flow = SIPics.File( "fluid-flow-medium-temperature" ).Copy() ,
		high_temperature_flow = SIPics.File( "fluid-flow-high-temperature" ).Get() ,
		gas_flow = SIPics.NewLayer( "steam" , 24 , 15 ).Priority( "extra-high" ).Anim( 10 , 60 , nil , 1 ).Axially( false ).Get()
	} )
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetStackSize( 100 )
	return self
end

function entity:Fill( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Fill( currentEntity )
	
	currentEntity
	:Default( "fast_replaceable_group" , "pipe" )
	:Default( "working_sound" , SISounds.Working( "__base__/sound/pipe.ogg" , 0.45 , nil , 0.3 , nil , true , 4 , 60 ) )
	return self
end

return entity