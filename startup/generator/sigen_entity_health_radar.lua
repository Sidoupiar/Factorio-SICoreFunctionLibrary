local entity = SIGen.HealthEntity:Copy( "radar" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.radar )



function entity:DefaultFlags()
	return self:SetParam( "flags" , { SIFlags.entityFlags.placeablePlayer , SIFlags.entityFlags.playerCreation } )
end



function entity:SetSpeed( speed )
	return self:SetParam( "rotation_speed" , speed )
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetTotalHeight( 15 )
	currentEntity:SetStackSize( 100 )
	return self
end

return entity