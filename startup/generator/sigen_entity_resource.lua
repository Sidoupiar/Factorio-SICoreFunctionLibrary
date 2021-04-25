local entity = SIGen.Entity:Copy( "resource" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.resource )



function entity:DefaultFlags()
	return self:SetParam( "flags" , { SIFlags.entityFlags.placeableNeutral } )
end



function entity:FillImage()
	return self
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetStackSize( 0 )
	return self
end

return entity