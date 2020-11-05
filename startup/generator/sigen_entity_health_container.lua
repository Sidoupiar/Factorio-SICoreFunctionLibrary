local entity = SIGen.HealthEntity:Copy( "container" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.container )



function entity:DefaultFlags()
	return self:SetParam( "flags" , { SIFlags.entityFlags.placeablePlayer , SIFlags.entityFlags.playerCreation } )
end



function entity:SetImage( path )
	return self
end



function entity:SetSlotCount( inputSlotCount , outputSlotCount )
	return self:SetParam( "inventory_size" , inputSlotCount )
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetStackSize( 100 )
	return self
end

return entity