local entity = SIGen.Robot:Copy( "logistic" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.robotLogistic )



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetStackSize( 100 )
	return self
end

return entity