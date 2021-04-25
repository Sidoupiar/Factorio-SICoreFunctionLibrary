local entity = SIGen.HealthEntity:Copy( "generator" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.generator )



function entity:DefaultFlags()
	return self:SetParam( "flags" , { SIFlags.entityFlags.placeablePlayer , SIFlags.entityFlags.playerCreation } )
end



function entity:SetEnergy( energyUsage , energySource )
	if energyUsage then self:SetParam( "max_power_output" , energyUsage ) end
	if energySource then self:SetParam( "energy_source" , energySource ) end
	return self
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetStackSize( 100 )
	return self
end

return entity