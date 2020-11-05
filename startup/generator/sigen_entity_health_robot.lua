local entity = SIGen.HealthEntity:Copy( "robot" )



function entity:DefaultFlags()
	return self:SetParam( "flags" , { SIFlags.entityFlags.placeablePlayer , SIFlags.entityFlags.playerCreation , SIFlags.entityFlags.placeableOffGrid , SIFlags.entityFlags.notOnMap } )
end



function entity:SetSpeed( speed )
	return self:SetParam( "speed" , speed )
end

function entity:SetEnergy( energyUsage , energySource )
	if energyUsage then self:SetParam( "max_energy" , energyUsage ) end
	if energySource then self:SetParam( "energy_per_tick" , energySource[1] ):SetParam( "energy_per_move" , energySource[2] ) end
	return self
end

function entity:SetSlotCount( inputSlotCount , outputSlotCount )
	return self:SetParam( "max_payload_size" , inputSlotCount )
end

return entity