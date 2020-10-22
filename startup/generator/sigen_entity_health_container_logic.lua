local entity = SIGen.Container:Copy( "logic" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.containerLogic )



function entity:SetImage( path )
	local _ , picture = self:GetParam( "picture" )
	if picture then return self end
	
	return self
end



function entity:SetSlotCount( inputSlotCount , outputSlotCount )
	if inputSlotCount then self:SetParam( "inventory_size" , inputSlotCount ) end
	if outputSlotCount then self:SetParam( "logistic_slots_count" , outputSlotCount ) end
	return self
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetTotalHeight( 15 )
	currentEntity:SetStackSize( 100 )
	return self
end

return entity