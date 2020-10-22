local entity = SIGen.HealthEntity:Copy( "furnace" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.furnace )



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetTotalHeight( 15 )
	currentEntity:SetStackSize( 100 )
	return self
end

return entity