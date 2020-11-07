local entity = SIGen.HealthEntity:Copy( "machine" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.machine )



function entity:DefaultFlags()
	return self:SetParam( "flags" , { SIFlags.entityFlags.placeablePlayer , SIFlags.entityFlags.playerCreation } )
end



function entity:SetImage( path )
	return self
end

function entity:SetSpeed( speed )
	return self:SetParam( "crafting_speed" , speed )
end

function entity:SetSlotCount( inputSlotCount , outputSlotCount )
	return self:SetParam( "ingredient_count" , inputSlotCount )
end

function entity:SetMainRecipe( recipeOrDataOrEntityOrPack )
	local dataType = type( recipeOrDataOrEntityOrPack )
	if dataType == "string" then
		return self:SetParam( "fixed_recipe" , recipeOrDataOrEntityOrPack )
	elseif dataType == "table" then
		if typeOrTypesOrPack.isEntity then
			if recipeOrDataOrEntityOrPack:GetType() == SITypes.recipe then
				return self:SetParam( "fixed_recipe" , recipeOrDataOrEntityOrPack:GetName() )
			else
				e( "模块构建 : SetMainRecipe 方法参数必须使用配方的实体" )
				return self
			end
		elseif recipeOrDataOrEntityOrPack.isPack then
			return self:SetParam( "fixed_recipe" , recipeOrDataOrEntityOrPack.data )
		else
			if recipeOrDataOrEntityOrPack.type == SITypes.recipe then
				return self:SetParam( "fixed_recipe" , recipeOrDataOrEntityOrPack.name )
			else
				e( "模块构建 : SetMainRecipe 方法参数必须使用配方的 data 数据" )
				return self
			end
		end
	else
		e( "模块构建 : SetMainRecipe 方法参数必须使用字符串/表格式" )
		return self
	end
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
	currentEntity:SetStackSize( 100 )
	return self
end

return entity