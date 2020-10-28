local entity = SIGen.Container:Copy( "logic" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.containerLogic )



function entity:SetImage( path )
	return self
end



function entity:SetSlotCount( inputSlotCount , outputSlotCount )
	if inputSlotCount then self:SetParam( "inventory_size" , inputSlotCount ) end
	if outputSlotCount then self:SetParam( "logistic_slots_count" , outputSlotCount ) end
	return self
end

function entity:SetLogisticMode( logisticMode )
	return self:SetParam( "logistic_mode" , logisticMode )
end



function entity:SetRender_notInNetworkIcon( trueOrFalse )
	return self:SetParam( "render_not_in_network_icon" , trueOrFalse )
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetTotalHeight( 15 )
	currentEntity:SetStackSize( 100 )
	return self
end

return entity