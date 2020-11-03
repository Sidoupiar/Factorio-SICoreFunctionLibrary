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



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetTotalHeight( 15 )
	currentEntity:SetStackSize( 100 )
	return self
end

return entity