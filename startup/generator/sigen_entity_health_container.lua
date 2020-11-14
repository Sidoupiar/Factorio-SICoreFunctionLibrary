local entity = SIGen.HealthEntity:Copy( "container" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.container )



function entity:DefaultFlags()
	return self:SetParam( "flags" , { SIFlags.entityFlags.placeablePlayer , SIFlags.entityFlags.playerCreation } )
end



function entity:SetImage( path )
	local width = self:GetWidth()
	local height = self:GetHeight()
	if not width or width <= 0 or not height or height <= 0 then return self end
	
	return self:SetParam( "icon" , path.."item/"..self:GetBaseName()..".png" )
	:SetParam( "icon_size" , SINumbers.iconSize )
	:SetParam( "icon_mipmaps" , SINumbers.mipMaps )
	:SetParam( "picture" , SIPics.BaseAnimLayer( path.."entity/"..self:GetBaseName().."/"..self:GetBaseName() , width , height ).Get() )
end

function entity:SetSlotCount( inputSlotCount , outputSlotCount )
	return self:SetParam( "inventory_size" , inputSlotCount )
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetStackSize( 100 )
	return self
end

return entity