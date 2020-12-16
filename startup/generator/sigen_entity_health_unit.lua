local entity = SIGen.HealthEntity:Copy( "unit" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.unit )



function entity:DefaultFlags()
	return self:SetParam( "flags" , { SIFlags.entityFlags.placeablePlayer , SIFlags.entityFlags.placeableEnemy , SIFlags.entityFlags.placeableOffGrid , SIFlags.entityFlags.breathsAir , SIFlags.entityFlags.notRepairable } )
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetStackSize( 100 )
	return self
end

return entity