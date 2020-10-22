local entity = SIGen.HealthEntity:Copy( "beacon" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.beacon )



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetTotalHeight( 15 )
	currentEntity:SetStackSize( 100 )
	return self
end

return entity