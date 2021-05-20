local entity = SIGen.Base:Copy( "control-autoplace" )
entity:AddDefaultValue( "defaultType" , SITypes.controlAutoplace )



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

return entity