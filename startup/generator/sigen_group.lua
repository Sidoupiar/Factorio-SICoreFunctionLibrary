local entity = SIGen.Base:Copy( "group" )
entity:AddDefaultValue( "defaultType" , SITypes.group )



function entity:SetIcon( picturePath , baseName )
	return self:SetParam( "icon" , picturePath.."group/"..baseName..".png" )
	:SetParam( "icon_size" , SINumbers.iconSizeGroup )
end

function entity:SetOrder( orderCode )
	return self:SetParam( "order" , "z-"..SIGen.Order( orderCode ) )
end



function entity:Fill( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Fill( currentEntity )
	
	currentEntity
	:Default( "localised_name" , { "item-group-name."..currentEntity:GetName() } )
	:Default( "localised_description" , { "item-group-description."..currentEntity:GetName() } )
	return self
end

return entity