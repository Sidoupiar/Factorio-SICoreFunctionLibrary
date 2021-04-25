local entity = SIGen.HealthEntity:Copy( "container" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.container )



function entity:DefaultFlags()
	return self:SetParam( "flags" , { SIFlags.entityFlags.placeablePlayer , SIFlags.entityFlags.playerCreation } )
end



function entity:SetSlotCount( inputSlotCount , outputSlotCount )
	return self:SetParam( "inventory_size" , inputSlotCount )
end



function entity:FillImage()
	local width = self:GetWidth()
	local height = self:GetHeight()
	if not width or width <= 0 or not height or height <= 0 then return self end
	
	local baseName = self:GetBaseName()
	local picturePath = self:GetPicturePath()
	
	return self:SetParam( "picture" , SIPics.BaseAnimLayer( picturePath.."entity/"..baseName.."/"..baseName , width , height ).Get() )
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetStackSize( 100 )
	return self
end

return entity