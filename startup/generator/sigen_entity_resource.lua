local entity = SIGen.Entity:Copy( "resource" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.resource )



function entity:DefaultFlags()
	return self:SetParam( "flags" , { SIFlags.entityFlags.placeableNeutral } )
end



function entity:SetImage( path )
	local width = self:GetWidth()
	local height = self:GetHeight()
	if not width or width <= 0 or not height or height <= 0 then return self end
	
	return self:SetParam( "icon" , path.."item/"..baseName..".png" )
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetStackSize( 0 )
	return self
end

return entity