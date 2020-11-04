local entity = SIGen.HealthEntity:Copy( "lab" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.lab )



function entity:DefaultFlags()
	return self:SetParam( "flags" , { SIFlags.entityFlags.placeablePlayer , SIFlags.entityFlags.playerCreation } )
end



function entity:SetImage( path )
	local width = self:GetWidth()
	local height = self:GetHeight()
	if not width or width <= 0 or not height or height <= 0 then return self end
	
	local baseName = self:GetBaseName()
	local imagePath = path .. "entity/" .. baseName .. "/"
	local file = imagePath .. baseName
	local addenWidth = self:GetAddenWidth()
	local addenHeight = self:GetAddenHeight()
	local shadowWidth = self:GetShadowWidth()
	local shadowHeight = self:GetShadowHeight()
	local hasHr = self:GetHasHr()
	local animShadow = self:GetAnimShadow()
	
	local onLayers = {}
	local offLayers = {}
	table.insert( onLayers , SIPics.OnAnimLayer( file , width , height , hasHr , addenWidth , addenHeight ) )
	if animShadow then table.insert( onLayers , SIPics.OnAnimLayerShadow( file , width , height , hasHr , shadowWidth , shadowHeight ) )
	else table.insert( onLayers , SIPics.OnAnimLayerShadowSingle( file , width , height , hasHr , shadowWidth , shadowHeight ) ) end
	table.insert( offLayers , SIPics.OffAnimLayer( file , width , height , hasHr , addenWidth , addenHeight ) )
	table.insert( offLayers , SIPics.OffAnimLayerShadow( file , width , height , hasHr , shadowWidth , shadowHeight ) )
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