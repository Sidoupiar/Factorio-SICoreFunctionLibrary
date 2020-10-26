local entity = SIGen.HealthEntity:Copy( "roboport" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.roboport )



function entity:DefaultFlags()
	return self:SetParam( "flags" , { SIFlags.entityFlags.placeablePlayer , SIFlags.entityFlags.playerCreation } )
end



function entity:SetImage( path )
	return self
end



function entity:SetSlotCount( inputSlotCount , outputSlotCount )
	if inputSlotCount then self:SetParam( "robot_slots_count" , inputSlotCount ) end
	if outputSlotCount then self:SetParam( "material_slots_count" , outputSlotCount ) end
	return self
end

function entity:SetEffectRadius( effectRadius , linkRadius , connectRadius )
	if effectRadius then self:SetParam( "construction_radius" , effectRadius ) end
	if linkRadius then self:SetParam( "logistics_radius" , linkRadius ) end
	if connectRadius then self:SetParam( "logistics_connection_distance" , connectRadius ) end
	return self
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetTotalHeight( 25 )
	currentEntity:SetStackSize( 100 )
	return self
end

return entity