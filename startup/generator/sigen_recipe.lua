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
	local _ , ingredients = self:GetParam( "ingredients" )
	if not ingredients then self:SetParam( "ingredients" , {} ) end
	local dataType = type( costOrCostsOrPack )
	if dataType == "string" then
		return self:AddParamItem( "ingredients" , SIPackers.SingleItemIngredient( costOrCostsOrPack , count ) )
	elseif dataType == "table" then
		if costOrCostsOrPack.isPack then
			return self:AddParamItem( "ingredients" , costOrCostsOrPack.data )
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
	local _ , results = self:GetParam( "results" )
	if not results then self:SetParam( "results" , {} ) end
	local dataType = type( resultOrResultsOrPack )
	if dataType == "string" then
		return self:AddParamItem( "results" , SIPackers.SingleItemProduct( resultOrResultsOrPack , count ) )
	elseif dataType == "table" then
		if resultOrResultsOrPack.isPack then
			return self:AddParamItem( "results" , resultOrResultsOrPack.data )
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



function entity:Fill( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Fill( currentEntity )
	local _ , ingredients = currentEntity:GetParam( "ingredients" )
	if not ingredients then currentEntity:SetParam( "ingredients" , {} ) end
	local _ , overload = currentEntity:GetParam( "overload_multiplier" )
	if not overload then currentEntity:SetParam( "overload_multiplier" , 5 ) end
	local _ , request = currentEntity:GetParam( "request_paste_multiplier" )
	if not request then currentEntity:SetParam( "request_paste_multiplier" , 5 ) end
	local _ , emission = currentEntity:GetParam( "emissions_multiplier" )
	if not emission then currentEntity:SetParam( "emissions_multiplier" , 1 ) end
	local _ , showMadeIn = currentEntity:GetParam( "always_show_made_in" )
	if showMadeIn == nil then currentEntity:SetParam( "always_show_made_in" , true ) end
	local _ , showproducts = currentEntity:GetParam( "always_show_products" )
	if showproducts == nil then currentEntity:SetParam( "always_show_products" , true ) end
	local _ , showcount = currentEntity:GetParam( "show_amount_in_title" )
	if showcount == nil then currentEntity:SetParam( "show_amount_in_title" , false ) end
	local _ , enabled = currentEntity:GetParam( "enabled" )
	if enabled == nil then currentEntity:SetParam( "enabled" , false ) end
	local _ , allow = currentEntity:GetParam( "allow_decomposition" )
	if allow == nil then currentEntity:SetParam( "allow_decomposition" , false ) end
	return self
end

return entity