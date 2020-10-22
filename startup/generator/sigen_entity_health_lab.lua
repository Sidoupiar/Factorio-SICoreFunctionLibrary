local entity = SIGen.HealthEntity:Copy( "lab" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.lab )



function entity:DefaultFlags()
	return self:SetParam( "flags" , { SIFlags.entityFlags.placeablePlayer , SIFlags.entityFlags.playerCreation } )
end



function entity:SetImage( path )
	local _ , onAnimation = self:GetParam( "on_animation" )
	if onAnimation then return self end
	
	local width = self:GetWidth()
	local height = self:GetHeight()
	if not width or not height then return self end
	
	local baseName = self:GetBaseName()
	local imagePath = path .. "entity/" .. baseName .. "/"
	local onLayers = {}
	local offLayers = {}
	table.insert( onLayers , SIPics.OnAnimLayer( imagePath , baseName , width , height ) )
	table.insert( onLayers , SIPics.OnAnimLayerShadow( imagePath , baseName , width , height , 1.0 , false , self:GetTotalHeight() ) )
	table.insert( offLayers , SIPics.OffAnimLayer( imagePath , baseName , width , height ) )
	table.insert( offLayers , SIPics.OffAnimLayerShadow( imagePath , baseName , width , height , 1.0 , false , self:GetTotalHeight() ) )
	return self:SetParam( "icon" , path.."item/"..baseName..".png" )
	:SetParam( "icon_size" , SINumbers.iconSize )
	:SetParam( "icon_mipmaps" , SINumbers.mipMaps )
	:SetParam( "on_animation" , { layers = onLayers } )
	:SetParam( "off_animation" , { layers = offLayers } )
end

function entity:SetSpeed( speed )
	return self:SetParam( "researching_speed" , speed )
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetTotalHeight( 15 )
	currentEntity:SetStackSize( 100 )
	return self
end

function entity:Fill( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Fill( currentEntity )
	local _ , light = currentEntity:GetParam( "light" )
	if not light then currentEntity:SetLight() end
	return self
end

return entity