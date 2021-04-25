local entity = SIGen.HealthEntity:Copy( "beacon" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.beacon )



function entity:DefaultFlags()
	return self:SetParam( "flags" , { SIFlags.entityFlags.placeablePlayer , SIFlags.entityFlags.playerCreation } )
end



function entity:SetEffectRadius( effectRadius , linkRadius , connectRadius )
	return self:SetParam( "supply_area_distance" , effectRadius )
end

function entity:SetEffectEnergy( effectEnergy , linkEnergy , connectEnergy )
	return self:SetParam( "distribution_effectivity" , effectEnergy )
end



function entity:FillImage()
	local baseName = self:GetBaseName()
	local picturePath = self:GetPicturePath()
	local path = picturePath .. "entity/" .. baseName .. "/" .. baseName
	
	return self:SetParam( "radius_visualisation_picture" , SIPics.NewLayer( path.."-radius-visualization" , 10 , 10 ).Priority( "extra-high-no-scale" ).Get() )
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetStackSize( 100 )
	return self
end

return entity