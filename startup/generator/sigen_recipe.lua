local entity = SIGen.Base:Copy( "recipe" )
entity:AddDefaultValue( "defaultType" , SITypes.recipe )



function entity:Import( data )
	if not self:CheckData( data ) then return self , table.deepcopy( data ) end
	local new = table.deepcopy( data )
	local normal = nil
	for k , v in pairs( new ) do
		if k == "normal" then normal = v
		elseif k ~= "expensive" then self.data[k] = v end
	end
	if normal then for k , v in pairs( normal ) do self.data[k] = v end end
	return self , new
end



function entity:SetEnergy( energyUsage , energySource )
	return self:SetParam( "energy_required" , energyUsage )
end



function entity:SetRecipeTypes( typeOrTypesOrPack )
	if not self:CheckData( typeOrTypesOrPack ) then return self end
	if type( typeOrTypesOrPack ) ~= "string" then
		e( "模块构建 : SetRecipeTypes 方法参数必须使用字符串格式" )
		return self
	end
	return self:SetParam( "category" , typeOrTypesOrPack )
end

function entity:AddRecipeTypes( typeOrTypesOrPack )
	if not self:CheckData( typeOrTypesOrPack ) then return self end
	if type( typeOrTypesOrPack ) ~= "string" then
		e( "模块构建 : AddRecipeTypes 方法参数必须使用字符串格式" )
		return self
	end
	return self:SetParam( "category" , typeOrTypesOrPack )
end

function entity:ClearRecipeTypes()
	return self:DeleteParam( "category" )
end

function entity:SetCosts( costOrCostsOrPack , count )
	if not self:CheckData( costOrCostsOrPack ) then return self end
	local dataType = type( costOrCostsOrPack )
	if dataType == "string" then
		return self:SetParam( "ingredients" , SIPackers.SingleItemIngredientsPack( costOrCostsOrPack , count ).data )
	elseif dataType == "table" then
		if costOrCostsOrPack.isPack then
			return self:SetParam( "ingredients" , costOrCostsOrPack.data )
		else
			return self:SetParam( "ingredients" , costOrCostsOrPack )
		end
	else
		e( "模块构建 : SetCosts 方法参数必须使用字符串/数组格式" )
		return self
	end
end

function entity:AddCosts( costOrCostsOrPack , count )
	if not self:CheckData( costOrCostsOrPack ) then return self end
	self:Default( "ingredients" , {} )
	local dataType = type( costOrCostsOrPack )
	if dataType == "string" then
		return self:AddParamItem( "ingredients" , SIPackers.SingleItemIngredient( costOrCostsOrPack , count ) )
	elseif dataType == "table" then
		if costOrCostsOrPack.isPack then costOrCostsOrPack = costOrCostsOrPack.data end
		if costOrCostsOrPack[1] and type( costOrCostsOrPack[1] ) == "table" then
			for i , v in pairs( costOrCostsOrPack ) do self:AddParamItem( "ingredients" , v ) end
			return self
		else
			return self:AddParamItem( "ingredients" , costOrCostsOrPack )
		end
	else
		e( "模块构建 : AddCosts 方法参数必须使用字符串/数组格式" )
		return self
	end
end

function entity:ClearCosts()
	return self:DeleteParam( "ingredients" )
end

function entity:SetResults( resultOrResultsOrPack , resultType , count )
	if not self:CheckData( resultOrResultsOrPack ) then return self end
	if not resultType or resultType ~= SIGen.resultType.recipe then
		e( "模块构建 : 当前实体不支持此 resultType : "+resultType )
		return self
	end
	local dataType = type( resultOrResultsOrPack )
	if dataType == "string" then
		return self:SetParam( "results" , SIPackers.SingleItemProductsPack( resultOrResultsOrPack , count ).data )
	elseif dataType == "table" then
		if resultOrResultsOrPack.isPack then
			return self:SetParam( "results" , resultOrResultsOrPack.data )
		else
			return self:SetParam( "results" , resultOrResultsOrPack )
		end
	else
		e( "模块构建 : SetResults 方法参数必须使用字符串/数组格式" )
		return self
	end
end

function entity:AddResults( resultOrResultsOrPack , count )
	if not self:CheckData( resultOrResultsOrPack ) then return self end
	self:Default( "results" , {} )
	local dataType = type( resultOrResultsOrPack )
	if dataType == "string" then
		return self:AddParamItem( "results" , SIPackers.SingleItemProduct( resultOrResultsOrPack , count ) )
	elseif dataType == "table" then
		if resultOrResultsOrPack.isPack then resultOrResultsOrPack = resultOrResultsOrPack.data end
		if resultOrResultsOrPack[1] and type( resultOrResultsOrPack[1] ) == "table" then
			for i , v in pairs( resultOrResultsOrPack ) do self:AddParamItem( "results" , v ) end
			return self
		else
			return self:AddParamItem( "results" , resultOrResultsOrPack )
		end
	else
		e( "模块构建 : AddResults 方法参数必须使用字符串/数组格式" )
		return self
	end
end

function entity:ClearResults()
	return self:DeleteParam( "results" )
end



function entity:AddLastLevel( count )
	local name = self:GetBaseName()
	if name:Level() > 1 then SIGen.AddCosts( name:LastLevel() , count ) end
	return self
end



function entity:Fill( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Fill( currentEntity )
	
	currentEntity
	:Default( "icon_size" , SINumbers.iconSize )
	:Default( "icon_mipmaps" , SINumbers.mipMaps )
	:Default( "ingredients" , {} )
	:Default( "overload_multiplier" , 5 )
	:Default( "request_paste_multiplier" , 5 )
	:Default( "emissions_multiplier" , 1 )
	:Default( "always_show_made_in" , true )
	:Default( "always_show_products" , true )
	:Default( "show_amount_in_title" , false )
	:Default( "enabled" , false )
	:Default( "allow_decomposition" , false )
	return self
end

return entity