local entity = SIGen.Base:Copy( "group" )
entity:AddDefaultValue( "defaultType" , SITypes.group )



function entity:SetImage( path )
	return self:SetParam( "icon" , path.."group/"..self:GetBaseName()..".png" )
	:SetParam( "icon_size" , SINumbers.iconSizeGroup )
	:SetParam( "icon_mipmaps" , SINumbers.mipMaps )
end

return entity