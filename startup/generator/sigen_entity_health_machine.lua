local entity = SIGen.HealthEntity:Copy( "machine" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.machine )



function entity:DefaultFlags()
	return self:SetParam( "flags" , { SIFlags.entityFlags.placeablePlayer , SIFlags.entityFlags.playerCreation } )
end



function entity:SetImage( path )
	local _ , animation = self:GetParam( "animation" )
	if animation then return self end
	
	return self
end



function entity:SetSpeed( speed )
	return self:SetParam( "crafting_speed" , speed )
end

function entity:SetSlotCount( inputSlotCount , outputSlotCount )
	return self:SetParam( "ingredient_count" , inputSlotCount )
end



function entity:SetRecipeTypes( typeOrTypesOrPack )
	if not self:CheckData( typeOrTypesOrPack ) then return self end
	local dataType = type( typeOrTypesOrPack )
	if dataType == "string" then
		return self:SetParam( "crafting_categories" , { typeOrTypesOrPack } )
	elseif dataType == "table" then
		if typeOrTypesOrPack.isPack then
			return self:SetParam( "crafting_categories" , typeOrTypesOrPack.data )
		else
			return self:SetParam( "crafting_categories" , typeOrTypesOrPack )
		end
	else
		e( "模块构建 : SetRecipeTypes 方法参数必须使用字符串/表格式" )
		return self
	end
end

function entity:AddRecipeTypes( typeOrTypesOrPack )
	if not self:CheckData( typeOrTypesOrPack ) then return self end
	local _ , categories = self:GetParam( "crafting_categories" )
	if not categories then self:SetParam( "crafting_categories" , {} ) end
	local dataType = type( typeOrTypesOrPack )
	if dataType == "string" then
		return self:AddParamItem( "crafting_categories" , typeOrTypesOrPack )
	elseif dataType == "table" then
		local list = {}
		if typeOrTypesOrPack.isPack then
			list = typeOrTypesOrPack.data
		else
			list = typeOrTypesOrPack
		end
		for i , v in pairs( list ) do self:AddParamItem( "crafting_categories" , v ) end
		return self
	else
		e( "模块构建 : AddRecipeTypes 方法参数必须使用字符串/表格式" )
		return self
	end
end

function entity:ClearRecipeTypes()
	return self:DeleteParam( "crafting_categories" )
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetTotalHeight( 15 )
	currentEntity:SetStackSize( 100 )
	return self
end

return entity