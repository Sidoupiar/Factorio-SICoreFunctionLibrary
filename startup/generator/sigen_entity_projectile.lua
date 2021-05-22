local entity = SIGen.Entity:Copy( "projectile" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.projectile )



function entity:DefaultFlags()
	return self:SetParam( "flags" , { SIFlags.entityFlags.notNoMap } )
end



function entity:SetAction( action , radiusColor )
	return self:SetParam( "action" , action )
end



function entity:FillImage()
	local width = self:GetWidth()
	local height = self:GetHeight()
	if not width or width <= 0 or not height or height <= 0 then return self end
	
	local baseName = self:GetBaseName()
	local picturePath = self:GetPicturePath()
	local path = picturePath .. "entity/" .. baseName .. "/" .. baseName
	local scale = self:GetScale()
	local hasHr = self:GetHasHr()
	
	return self:SetParam( "animation" , SIPics.NewLayer( path , width*SINumbers.projectilePictureSize , height*SINumbers.projectilePictureSize , scale , hasHr ).Priority( SIPics.priority.high ).Anim( SINumbers.projectilePictureLineLength , SINumbers.projectilePictureFrameCount , SINumbers.projectilePictureAnimSpeed ).Glow().Get() )
	:SetParam( "shadow" , SIPics.NewLayer( path.."-shadow" , width*SINumbers.projectilePictureSize , height*SINumbers.projectilePictureSize , scale , hasHr ).Priority( SIPics.priority.high ).Anim( SINumbers.projectilePictureLineLength , SINumbers.projectilePictureFrameCount , SINumbers.projectilePictureAnimSpeed ).Shadow().Get() )
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	
	currentEntity:SetStackSize( 0 )
	return self
end

return entity