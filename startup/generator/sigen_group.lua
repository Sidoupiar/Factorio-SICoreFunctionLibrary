local entity = SIGen.Base:Copy( "group" )
entity:AddDefaultValue( "defaultType" , SITypes.group )



function entity:SetIcon( picturePath , baseName )
	return self:SetParam( "icon" , picturePath.."group/"..baseName..".png" )
	:SetParam( "icon_size" , SINumbers.iconSizeGroup )
end

function entity:SetOrder( orderCode )
	return self:SetParam( "order" , "z-"..SIGen.Order( orderCode ) )
end

return entity