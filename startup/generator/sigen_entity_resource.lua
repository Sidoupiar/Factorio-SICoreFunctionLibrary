local entity = SIGen.Entity:Copy( "resource" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.resource )



function entity:DefaultFlags()
	return self:SetParam( "flags" , { SIFlags.entityFlags.placeableNeutral } )
end



function entity:SetRecipeTypes( typeOrTypesOrPack )
	if not self:CheckData( typeOrTypesOrPack ) then return self end
	local dataType = type( typeOrTypesOrPack )
	if dataType == "string" then
		return self:SetParam( "category" , typeOrTypesOrPack )
	else
		e( "模块构建 : SetRecipeTypes 方法参数必须使用字符串格式" )
		return self
	end
end

function entity:AddRecipeTypes( typeOrTypesOrPack )
	e( "模块构建 : AddRecipeTypes 方法在当前实体下不可用" )
	return self
end

function entity:ClearRecipeTypes()
	return self:DeleteParam( "category" )
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
	local canGlow = self:GetCanGlow()
	
	local stages = {}
	stages.sheet = SIPics.NewLayer( path , width*SINumbers.resourcePictureSize+SINumbers.resourcePictureSide , height*SINumbers.resourcePictureSize+SINumbers.resourcePictureSide , scale , hasHr ).Priority( SIPics.priority.extraHigh ).Frame( SINumbers.resourcePictureFrameCount ).Variation( SINumbers.resourceVariationCount ).Get()
	self:SetParam( "stages" , stages )
	if canGlow then
		local effect = {}
		effect.sheet = SIPics.NewLayer( path.."-glow" , width*SINumbers.resourcePictureSize+SINumbers.resourcePictureSide , height*SINumbers.resourcePictureSize+SINumbers.resourcePictureSide , scale , hasHr ).Priority( SIPics.priority.extraHigh ).BlendMode( SIPics.blendMode.additive ).Flags{ SIPics.flag.light }.Frame( SINumbers.resourcePictureFrameCount ).Variation( SINumbers.resourceVariationCount ).Get()
		self:SetParam( "stages_effect" , effect )
	end
	return self
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	
	currentEntity:SetStackSize( 0 )
	return self
end

return entity