local entity = SIGen.Robot:Copy( "construction" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.robotConstruct )



function entity:SetLight( intensity , size , color )
	intensity = intensity or 0.8
	size = size or 3
	color = color or SIColors.baseColor.white
	return self:SetParam( "working_light" , SIPackers.Light( intensity , size , color ) )
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetStackSize( 100 )
	return self
end

return entity