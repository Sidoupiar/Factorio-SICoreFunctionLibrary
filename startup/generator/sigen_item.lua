local entity = SIGen.Base:Copy( "item" )
entity:AddDefaultValue( "defaultType" , SITypes.item.item )
:AddDefaultValue( "resultType" , SIGen.resultType.entity )



function entity:GetStackSize()
	return self:GetParam( "stack_size" )
end



function entity:DefaultFlags()
	return self:SetParam( "flags" , {} )
end



function entity:SetImage( path )
	return self:SetParam( "icon" , path.."item/"..self:GetBaseName()..".png" )
end

function entity:SetStackSize( stackSize )
	if stackSize < 1 then
		e( "模块构建 : stackSize 不能小于 1" )
		return self
	end
	if not table.Has( SITypes.stackableItem , self:GetType() ) and stackSize > 1 then
		e( "模块构建 : 不支持设置堆叠的物品" )
		return self
	end
	if stackSize > 1 then self:SetParam( "stackable" , true )
	else self:SetParam( "stackable" , false ) end
	return self:SetParam( "stack_size" , stackSize )
end

function entity:SetEnergy( energyUsage , energySource )
	return self:SetParam( "fuel_value" , energyUsage )
	:SetParam( "fuel_category" , energySource )
end



function entity:SetResults( resultOrResultsOrPack , resultType , count )
	if not self:CheckData( resultOrResultsOrPack ) then return self end
	if not resultType or resultType == SIGen.resultType.none or resultType == SIGen.resultType.recipe or resultType == SIGen.resultType.technology then
		e( "模块构建 : 当前实体不支持此 resultType : "+resultType )
		return self
	end
	if resultType ~= self.resultType then
		self:ClearResults()
		self.resultType = resultType
	end
	local dataType = type( resultOrResultsOrPack )
	if dataType == "string" then
		if resultType == SIGen.resultType.entity then
			return self:SetParam( "place_result" , resultOrResultsOrPack )
		elseif resultType == SIGen.resultType.module then
			return self:SetParam( "place_as_equipment_result" , resultOrResultsOrPack )
		elseif resultType == SIGen.resultType.burnt then
			return self:SetParam( "burnt_result" , resultOrResultsOrPack )
		else
			e( "模块构建 : 当前实体不支持使用字符串添加此 resultType : "+resultType )
			return self
		end
	elseif dataType == "table" then
		if resultType == SIGen.resultType.tile then
			if resultOrResultsOrPack.isPack then
				return self:SetParam( "place_as_tile" , resultOrResultsOrPack.data )
			else
				return self:SetParam( "place_as_tile" , resultOrResultsOrPack )
			end
		elseif resultType == SIGen.resultType.rocketLaunch then
			if resultOrResultsOrPack.isPack then
				return self:SetParam( "rocket_launch_products" , resultOrResultsOrPack.data )
			else
				return self:SetParam( "rocket_launch_products" , resultOrResultsOrPack )
			end
		else
			e( "模块构建 : 前实体不支持使用表添加此 resultType : "+resultType )
			return self
		end
	else
		e( "模块构建 : SetResults 方法参数必须使用字符串/表格式" )
		return self
	end
end

function entity:AddResults( resultOrResultsOrPack , count )
	if not self:CheckData( resultOrResultsOrPack ) then return self end
	if self.resultType == SIGen.resultType.entity or self.resultType == SIGen.resultType.module or self.resultType == SIGen.resultType.burnt or self.resultType == SIGen.resultType.tile then
		e( "模块构建 : 前实体不支持在当前 resultType 下添加 results" )
		return self
	end
	self:Default( "rocket_launch_products" , {} )
	local dataType = type( resultOrResultsOrPack )
	if dataType == "string" then
		return self:AddParamItem( "rocket_launch_products" , SIPackers.SingleItemProductsPack( resultOrResultsOrPack , count ).data )
	elseif dataType == "table" then
		if resultOrResultsOrPack.isPack then
			return self:AddParamItem( "rocket_launch_products" , resultOrResultsOrPack.data )
		else
			return self:AddParamItem( "rocket_launch_products" , resultOrResultsOrPack )
		end
	else
		e( "模块构建 : AddResults 方法参数必须使用字符串/表格式" )
		return self
	end
end

function entity:ClearResults()
	return self:DeleteParam( "place_result" )
	:DeleteParam( "place_as_equipment_result" )
	:DeleteParam( "burnt_result" )
	:DeleteParam( "place_as_tile" )
	:DeleteParam( "rocket_launch_products" )
	:SetParam( "type" , SITypes.item.item )
end



function entity:Fill( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Fill( currentEntity )
	
	currentEntity
	:Default( "icon_size" , SINumbers.iconSize )
	:Default( "icon_mipmaps" , SINumbers.mipMaps )
	:Default( "stack_size" , 100 )
	return self
end

return entity