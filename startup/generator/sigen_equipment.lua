local entity = SIGen.Base:Copy( "equipment" )
:AddDefaultValue( "scale" , 1 )
:AddDefaultValue( "hasHr" , false )
:AddDefaultValue( "itemStackSize" , 0 )
:AddDefaultValue( "itemFlags" , {} )
:AddDefaultValue( "itemName" , nil )
:AddDefaultValue( "item" , nil )



function entity:SetScale( scale )
	self.scale = scale
	return self
end

function entity:SetHasHr( hasHr )
	self.hasHr = hasHr
	return self
end

function entity:SetItemFlags( flagOrFlagsOrPack )
	if not flagOrFlagsOrPack then return self end
	local dataType = type( flagOrFlagsOrPack )
	if dataType == "string" then self.itemFlags = { flagOrFlagsOrPack }
	elseif dataType == "table" then
		if flagOrFlagsOrPack.isPack then self.itemFlags = flagOrFlagsOrPack.data
		else self.itemFlags = flagOrFlagsOrPack end
	else e( "模块构建 : SetItemFlags 方法参数必须使用字符串/数组格式" ) end
	return self
end

function entity:AddItemFlags( flagOrFlagsOrPack )
	if not flagOrFlagsOrPack then return self end
	local dataType = type( flagOrFlagsOrPack )
	if dataType == "string" then table.insert( self.itemFlags , flagOrFlagsOrPack )
	elseif dataType == "table" then
		if flagOrFlagsOrPack.isPack then flagOrFlagsOrPack = flagOrFlagsOrPack.data end
		for i , v in pairs( flagOrFlagsOrPack ) do table.insert( self.itemFlags , v ) end
	else e( "模块构建 : AddItemFlags 方法参数必须使用字符串/数组格式" ) end
	return self
end

function entity:ClearItemFlags()
	self.itemFlags = {}
	return self
end

function entity:SetItemName( itemName )
	self.itemName = itemName
	return self
end

function entity:SetItem( item )
	self.item = item
	return self
end

function entity:GetScale()
	return self.scale
end

function entity:GetHasHr()
	return self.hasHr
end

function entity:GetItemStackSize()
	return self.itemStackSize
end

function entity:GetItemFlags()
	return self.itemFlags
end

function entity:GetItemName()
	return self.itemName
end

function entity:GetItem()
	return self.item
end



function entity:SetSize( width , height )
	if type( width ) == "table" then self:SetParam( "shape" , SIPackers.CreateEquipmentShapeWithPoints( width ) )
	else self:SetParam( "shape" , SIPackers.CreateEquipmentShape( nil , width , height ) ) end
	return self
end

function entity:SetEnergy( energyUsage , energySource )
	if energyUsage then self:SetParam( "energy_usage" , energyUsage ) end
	if energySource then
		local dataType = type( energySource )
		if dataType == "string" then
			self:SetParam( "energy_source" , SIPackers.EnergySource( energySource ) )
		elseif dataType == "table" then
			if energySource.isPack then
				self:SetParam( "energy_source" , energySource.data )
			else
				self:SetParam( "energy_source" , energySource )
			end
		else
			e( "模块构建 : SetEnergy 方法的 energySource 参数必须使用字符串/字典格式" )
			return self
		end
	end
	return self
end

function entity:SetMapColor( mapColor , friendlyMapColor , enemyMapColor )
	if mapColor then self:SetParam( "background_color" , mapColor ) end
	if friendlyMapColor then self:SetParam( "background_border_color" , friendlyMapColor ) end
	if enemyMapColor then self:SetParam( "grabbed_background_color" , enemyMapColor ) end
	return self
end



function entity:SetPluginTypes( typeOrTypesOrPack )
	if not self:CheckData( typeOrTypesOrPack ) then return self end
	local dataType = type( typeOrTypesOrPack )
	if dataType == "string" then
		return self:SetParam( "categories" , { typeOrTypesOrPack } )
	elseif dataType == "table" then
		if typeOrTypesOrPack.isPack then
			return self:SetParam( "categories" , typeOrTypesOrPack.data )
		else
			return self:SetParam( "categories" , typeOrTypesOrPack )
		end
	else
		e( "模块构建 : SetPluginTypes 方法参数必须使用字符串/数组格式" )
		return self
	end
end

function entity:AddPluginTypes( typeOrTypesOrPack )
	if not self:CheckData( typeOrTypesOrPack ) then return self end
	local dataType = type( typeOrTypesOrPack )
	if dataType == "string" then
		if not table.Has( self:GetParam( "categories" ) , typeOrTypesOrPack ) then
			return self:AddParamItem( "categories" , typeOrTypesOrPack )
		end
	elseif dataType == "table" then
		for i , effect in pairs( typeOrTypesOrPack.isPack and typeOrTypesOrPack.data or typeOrTypesOrPack ) do
			if not table.Has( self:GetParam( "categories" ) , effect ) then self:AddParamItem( "categories" , effect ) end
		end
		return self
	else
		e( "模块构建 : AddPluginTypes 方法参数必须使用字符串/数组格式" )
		return self
	end
end

function entity:ClearPluginTypes()
	return self:DeleteParam( "categories" )
end

function entity:SetResults( resultOrResultsOrPack , resultType , count )
	if not self:CheckData( resultOrResultsOrPack ) then return self end
	if not resultType or resultType ~= SIGen.resultType.none and resultType ~= SIGen.resultType.equipment then
		e( "模块构建 : 当前实体不支持此 resultType : "..(resultType and "无" or resultType) )
		return self
	end
	if type( resultOrResultsOrPack ) == "string" then
		return self:SetParam( "take_result" , resultOrResultsOrPack )
	else
		e( "模块构建 : AddResults 方法参数必须使用字符串格式" )
		return self
	end
end

function entity:AddResults( resultOrResultsOrPack , count )
	if type( resultOrResultsOrPack ) == "string" then
		return self:SetParam( "take_result" , resultOrResultsOrPack )
	else
		e( "模块构建 : AddResults 方法参数必须使用字符串格式" )
		return self
	end
end

function entity:ClearResults()
	return self:DeleteParam( "take_result" )
end



function entity:FillImage()
	local shape = self:GetParam( "shape" )
	local width = ( shape and shape.width ) or 1
	local height = ( shape and shape.height ) or 1
	if not width or width <= 0 or not height or height <= 0 then return self end
	
	local baseName = self:GetBaseName()
	local picturePath = self:GetPicturePath()
	local path = picturePath .. "equipment/" .. baseName .. "/" .. baseName
	local scale = self:GetScale()
	local hasHr = self:GetHasHr()
	
	return self:SetParam( "sprite" , SIPics.NewLayer( path , width*SINumbers.equipmentPictureSize , height*SINumbers.equipmentPictureSize , scale , hasHr ).Get() )
end



function entity:Fill( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Fill( currentEntity )
	
	currentEntity
	:Default( "shape" , SIPackers.CreateEquipmentShape() )
	
	local stackSize = currentEntity:GetItemStackSize()
	if stackSize and stackSize > 0 then
		local item = currentEntity:GetItem()
		if not item then
			local item = SIGen.Item:New( currentEntity:GetItemName() or currentEntity:GetBaseName() )
			:Init()
			:DefaultFlags()
			:SetGroup( SIGen.GetCurrentSubGroupEntity() )
			:SetOrder( SIGen.GetCurrentEntityOrder() )
			:AddFlags( currentEntity:GetItemFlags() )
			:SetStackSize( stackSize )
			:SetResults( currentEntity:GetName() , SIGen.resultType.equipment )
			
			local localizedNames = currentEntity:GetParam( "localised_name" )
			if localizedNames then item:SetLocalisedNames( localizedNames ) end
			local localisedDescriptions = currentEntity:GetParam( "localised_description" )
			if localisedDescriptions then item:SetLocalisedDescriptions( localisedDescriptions ) end
			
			currentEntity:SetItem( item:Fill() )
		end
	end
	return self
end

function entity:Auto( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Auto( currentEntity )
	
	local item = currentEntity:GetItem()
	if item then
		if not item:HasExtend() then item:Extend():Finish() end
		currentEntity:Default( "take_result" , item:GetName() )
	end
	return self
end

return entity