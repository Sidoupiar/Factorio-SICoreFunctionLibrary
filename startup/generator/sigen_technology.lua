local entity = SIGen.Base:Copy( "technology" )
entity:AddDefaultValue( "defaultType" , SITypes.technology )



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



function entity:SetGroup( groupEntity )
	return self
end



function entity:SetImage( path )
	return self:SetParam( "icon" , path.."technology/"..self:GetBaseName()..".png" )
end

function entity:SetStackSize( stackSize )
	local unit = self:GetParam( "unit" )
	if not unit then
		e( "模块构建：unit 属性为空时无法使用 SetStackSize 方法" )
		return self
	end
	if type( stackSize ) == "number" then
		unit.count = stackSize
		table.remove( unit , "count_formula" )
	elseif type( stackSize ) == "string" then
		unit.count_formula = stackSize
		table.remove( unit , "count" )
	else
		table.remove( unit , "count" )
		table.remove( unit , "count_formula" )
	end
	return self:SetParam( "unit" , unit )
end

function entity:SetSpeed( speed )
	local unit = self:GetParam( "unit" )
	if not unit then
		e( "模块构建：unit 属性为空时无法使用 SetSpeed 方法" )
		return self
	end
	unit.time = speed
	return self:SetParam( "unit" , unit )
end

function entity:SetLevel( level , maxLevel )
	if self:GetParam( "max_level" ) ~= maxLevel then self:SetParam( "max_level" , maxLevel ) end
	return self
end



function entity:SetTechnologies( technologyOrTechnologiesOrPack )
	if not self:CheckData( technologyOrTechnologiesOrPack ) then return self end
	local dataType = type( technologyOrTechnologiesOrPack )
	if dataType == "string" then
		return self:SetParam( "prerequisites" , { technologyOrTechnologiesOrPack } )
	elseif dataType == "table" then
		if technologyOrTechnologiesOrPack.isPack then
			return self:SetParam( "prerequisites" , technologyOrTechnologiesOrPack.data )
		else
			return self:SetParam( "prerequisites" , technologyOrTechnologiesOrPack )
		end
	else
		e( "模块构建 : SetTechnologies 方法参数必须使用字符串/数组格式" )
		return self
	end
end

function entity:AddTechnologies( technologyOrTechnologiesOrPack )
	if not self:CheckData( technologyOrTechnologiesOrPack ) then return self end
	self:Default( "prerequisites" , {} )
	local dataType = type( technologyOrTechnologiesOrPack )
	if dataType == "string" then
		return self:AddParamItem( "prerequisites" , technologyOrTechnologiesOrPack )
	elseif dataType == "table" then
		local list = {}
		if technologyOrTechnologiesOrPack.isPack then
			list = technologyOrTechnologiesOrPack.data
		else
			list = technologyOrTechnologiesOrPack
		end
		for i , v in pairs( list ) do self:AddParamItem( "prerequisites" , v ) end
		return self
	else
		e( "模块构建 : AddTechnologies 方法参数必须使用字符串/数组格式" )
		return self
	end
end

function entity:ClearTechnologies()
	return self:DeleteParam( "prerequisites" )
end

function entity:SetCosts( costOrCostsOrPack , count )
	if not self:CheckData( costOrCostsOrPack ) then return self end
	local dataType = type( costOrCostsOrPack )
	if dataType == "string" then
		return self:SetParam( "unit" , SIPackers.Unit( costOrCostsOrPack , count ) )
	elseif dataType == "table" then
		if costOrCostsOrPack.isPack then
			return self:SetParam( "unit" , costOrCostsOrPack.data )
		else
			if count then return self:SetParam( "unit" , SIPackers.Unit( costOrCostsOrPack , count ) )
			else return self:SetParam( "unit" , costOrCostsOrPack ) end
		end
	else
		e( "模块构建 : SetCosts 方法参数必须使用字符串/数组格式" )
		return self
	end
end

function entity:AddCosts( costOrCostsOrPack , count )
	if not self:CheckData( costOrCostsOrPack ) then return self end
	local unit = self:GetParam( "unit" )
	if not unit or not unit.ingredients then
		e( "模块构建：unit 属性为空时无法使用 AddCosts 方法" )
		return self
	end
	local dataType = type( costOrCostsOrPack )
	if dataType == "string" then
		table.insert( unit.ingredients , SIPackers.SingleIngredientUnit( costOrCostsOrPack , count ) )
		return self:SetParam( "unit" , unit )
	elseif dataType == "table" then
		if costOrCostsOrPack.isPack then
			if type( costOrCostsOrPack.data ) == "table" then for i , v in pairs( costOrCostsOrPack.data ) do table.insert( unit.ingredients , v ) end
			else table.insert( unit.ingredients , costOrCostsOrPack.data ) end
			return self:SetParam( "unit" , unit )
		else
			table.insert( unit.ingredients , costOrCostsOrPack )
			return self:SetParam( "unit" , unit )
		end
	else
		e( "模块构建 : AddCosts 方法参数必须使用字符串/数组格式" )
		return self
	end
end

function entity:ClearCosts()
	return self:DeleteParam( "unit" )
end

function entity:SetResults( resultOrResultsOrPack , resultType , count )
	if not self:CheckData( resultOrResultsOrPack ) then return self end
	if not resultType or resultType ~= SIGen.resultType.technology then
		e( "模块构建 : 当前实体不支持此 resultType : "+resultType )
		return self
	end
	local dataType = type( resultOrResultsOrPack )
	if dataType == "string" then
		if count then return self:SetParam( "effects" , SIPackers.SingleModifiersPack( resultOrResultsOrPack , count ).data )
		else return self:SetParam( "effects" , SIPackers.SingleModifiersPack( SITypes.modifier.unlockRecipe , resultOrResultsOrPack ).data ) end
	elseif dataType == "table" then
		if resultOrResultsOrPack.isPack then
			return self:SetParam( "effects" , resultOrResultsOrPack.data )
		else
			return self:SetParam( "effects" , resultOrResultsOrPack )
		end
	else
		e( "模块构建 : SetResults 方法参数必须使用字符串/数组格式" )
		return self
	end
end

function entity:AddResults( resultOrResultsOrPack , count )
	if not self:CheckData( resultOrResultsOrPack ) then return self end
	self:Default( "effects" , {} )
	local dataType = type( resultOrResultsOrPack )
	if dataType == "string" then
		if count then return self:AddParamItem( "effects" , SIPackers.SingleModifier( resultOrResultsOrPack , count ) )
		else return self:AddParamItem( "effects" , SIPackers.SingleModifier( SITypes.modifier.unlockRecipe , resultOrResultsOrPack ) ) end
	elseif dataType == "table" then
		if resultOrResultsOrPack.isPack then resultOrResultsOrPack = resultOrResultsOrPack.data end
		if resultOrResultsOrPack[1] and type( resultOrResultsOrPack[1] ) == "table" then
			for i , v in pairs( resultOrResultsOrPack ) do self:AddParamItem( "effects" , v ) end
			return self
		else
			return self:AddParamItem( "effects" , resultOrResultsOrPack )
		end
	else
		e( "模块构建 : AddResults 方法参数必须使用字符串/数组格式" )
		return self
	end
end

function entity:ClearResults()
	return self:DeleteParam( "effects" )
end



function entity:AddLastLevel( count )
	local name = self:GetName()
	if name:Level() > 1 then SIGen.AddTechnologies{ name:LastLevel() } end
	return self
end



function entity:Fill( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Fill( currentEntity )
	
	currentEntity:Default( "icon_size" , SINumbers.iconSizeTechnology )
	local maxLevel = currentEntity:GetParam( "max_level" )
	if maxLevel and maxLevel == "infinite" or ( type( maxLevel ) == "number" and maxLevel > 1 ) then currentEntity:SetParam( "upgrade" , true )
	else currentEntity:SetParam( "upgrade" , false ) end
	return self
end

return entity