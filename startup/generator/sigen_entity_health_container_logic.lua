local entity = SIGen.Container:Copy( "logic" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.containerLogic )



function entity:SetSlotCount( inputSlotCount , outputSlotCount )
	if inputSlotCount then self:SetParam( "inventory_size" , inputSlotCount ) end
	if outputSlotCount then self:SetParam( "max_logistic_slots" , outputSlotCount ) end
	return self
end

function entity:SetLogisticMode( logisticMode )
	return self:SetParam( "logistic_mode" , logisticMode )
end



function entity:SetRender_notInNetworkIcon( trueOrFalse )
	return self:SetParam( "render_not_in_network_icon" , trueOrFalse )
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