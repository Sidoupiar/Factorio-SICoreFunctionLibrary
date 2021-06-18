local entity = SIGen.Item:Copy( "module" )
entity:AddDefaultValue( "defaultType" , SITypes.item.module )



function entity:SetLevel( level , maxLevel )
	return self:SetParam( "tier" , level )
end

function entity:SetLimitation( limitation , message )
	return self:SetParam( "limitation" , limitation ):SetParam( "limitation_message_key" , message )
end



function entity:SetPluginTypes( typeOrTypesOrPack )
	if not self:CheckData( typeOrTypesOrPack ) then return self end
	if type( typeOrTypesOrPack ) ~= "string" then
		e( "模块构建 : SetPluginTypes 方法参数必须使用字符串格式" )
		return self
	end
	return self:SetParam( "category" , typeOrTypesOrPack )
end

function entity:AddPluginTypes( typeOrTypesOrPack )
	if not self:CheckData( typeOrTypesOrPack ) then return self end
	if type( typeOrTypesOrPack ) ~= "string" then
		e( "模块构建 : AddPluginTypes 方法参数必须使用字符串格式" )
		return self
	end
	return self:SetParam( "category" , typeOrTypesOrPack )
end

function entity:ClearPluginTypes()
	return self:DeleteParam( "category" )
end

return entity