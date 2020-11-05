local entity = SIGen.HealthEntity:Copy( "radar" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.radar )



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
	
	local patchLocation = self:GetPatchLocation()
	local waterLocation = self:GetWaterLocation()
	if patchLocation then :SetParam( "integration_patch" , SIPics.Patch( file , width , height , hasHr , addenWidth , addenHeight , patchLocation ).Get() ) end
	if waterLocation then self:SetParam( "water_reflection" , SIPics.WaterReflection( file , width , height , waterLocation ).Get() ) end
	
	local layers = {}
	table.insert( layers , SIPics.OnAnimLayer( file , width , height , hasHr , addenWidth , addenHeight ).Get() )
	if animShadow then table.insert( layers , SIPics.OnAnimLayerShadow( file , width , height , hasHr , shadowWidth , shadowHeight ).Get() )
	else table.insert( layers , SIPics.OnAnimLayerShadowSingle( file , width , height , hasHr , shadowWidth , shadowHeight ).Get() ) end
	return self:SetParam( "icon" , path.."item/"..baseName..".png" )
	:SetParam( "icon_size" , SINumbers.iconSize )
	:SetParam( "icon_mipmaps" , SINumbers.mipMaps )
	:SetParam( "pictures" , { layers = layers } )
end

function entity:SetSpeed( speed )
	return self:SetParam( "rotation_speed" , speed )
end

function entity:SetEffectRadius( effectRadius , linkRadius , connectRadius )
	if effectRadius then self:SetParam( "max_distance_of_nearby_sector_revealed" , effectRadius ) end
	if linkRadius then self:SetParam( "max_distance_of_sector_revealed" , linkRadius ) end
	return self
end

function entity:SetEffectEnergy( effectEnergy , linkEnergy , connectEnergy )
	if effectEnergy then self:SetParam( "energy_per_nearby_scan" , effectEnergy ) end
	if linkEnergy then self:SetParam( "energy_per_sector" , linkEnergy ) end
	return self
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetStackSize( 100 )
	return self
end

return entity