local entity = SIGen.Robot:Copy( "combat" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.robotCombat )



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetStackSize( 100 )
	return self
end

return entity