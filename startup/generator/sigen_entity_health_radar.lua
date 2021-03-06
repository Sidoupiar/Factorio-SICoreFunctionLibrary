local entity = SIGen.HealthEntity:Copy( "radar" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.radar )



function entity:DefaultFlags()
	return self:SetParam( "flags" , { SIFlags.entityFlags.placeablePlayer , SIFlags.entityFlags.playerCreation } )
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



function entity:FillImage()
	local width = self:GetWidth()
	local height = self:GetHeight()
	if not width or width <= 0 or not height or height <= 0 then return self end
	
	local baseName = self:GetBaseName()
	local picturePath = self:GetPicturePath()
	local path = picturePath .. "entity/" .. baseName .. "/" .. baseName
	local addenWidth = self:GetAddenWidth()
	local addenHeight = self:GetAddenHeight()
	local shadowWidth = self:GetShadowWidth()
	local shadowHeight = self:GetShadowHeight()
	local addenShiftX = self:GetAddenShiftX()
	local addenShiftY = self:GetAddenShiftY()
	local shadowShiftX = self:GetShadowShiftX()
	local shadowShiftY = self:GetShadowShiftY()
	local hasHr = self:GetHasHr()
	
	local patchLocation = self:GetPatchLocation()
	local waterLocation = self:GetWaterLocation()
	if patchLocation then self:SetParam( "integration_patch" , SIPics.Patch( path , width , height , hasHr , addenWidth , addenHeight , patchLocation ).Get() ) end
	if waterLocation then self:SetParam( "water_reflection" , SIPics.WaterReflection( path , width , height , waterLocation ) ) end
	
	local layers = {}
	table.insert( layers , SIPics.PictureLayer( path , width , height , hasHr , addenWidth , addenHeight ).ShiftMerge( addenShiftX , addenShiftY ).Get() )
	table.insert( layers , SIPics.PictureShadow( path , width , height , hasHr , shadowWidth , shadowHeight ).ShiftMerge( shadowShiftX , shadowShiftY ).Get() )
	return self:SetParam( "pictures" , { layers = layers } )
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetStackSize( 100 )
	return self
end

return entity