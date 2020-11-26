-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local entity = { codeName = "base" }

function entity:AddDefaultValue( key , defaultValue )
	if not self.__DefaultValues then self.__DefaultValues = {} end
	self.__DefaultValues[key] = defaultValue
	return self
end

function entity:InitDefaultValues()
	if self.__DefaultValues then for k , v in pairs( self.__DefaultValues ) do self[k] = v end end
	return self
end

entity:AddDefaultValue( "baseName" , "none" )
:AddDefaultValue( "sourceMod" , nil )
:AddDefaultValue( "allreadyCreate" , true )
:AddDefaultValue( "hasFill" , false )
:AddDefaultValue( "hasExtend" , false )
:AddDefaultValue( "data" , {} )
:AddDefaultValue( "isEntity" , true )

-- ------------------------------------------------------------------------------------------------
-- ---------- 继承方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function entity:Copy( codeName , isInit )
	local newEntity = setmetatable( { codeName = self.codeName .. "-" .. codeName } , { __index = self } )
	if isInit then newEntity.super = setmetatable( {} , { __index = self.super } )
	else newEntity.super = setmetatable( {} , { __index = self } ) end
	if self.__DefaultValues then newEntity.__DefaultValues = table.deepcopy( self.__DefaultValues ) end
	return newEntity
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 构建方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function entity:New( type , name , data )
	if self.AlreadyCreate then
		e( "模块构建 : 实体不能重复创建" )
		return nil
	end
	self = self:Copy( "init" , true )
	:InitDefaultValues()
	if self.defaultType then
		data = name
		name = type
		type = self.defaultType
	end
	if not type then
		e( "模块构建 : 创建时必须填写 type 属性" )
		return nil
	end
	local currentConstantsData = SIGen.GetCurrentConstantsData()
	if not currentConstantsData or not name then
		e( "模块构建 : 创建时必须注册 ConstantsData 并填写 name 属性" )
		return nil
	end
	self:SetBaseName( name )
	self.sourceMod = currentConstantsData.class
	if data then self:Import( data ) end
	self:SetParam( "type" , type )
	:SetParam( "name" , currentConstantsData.autoName and currentConstantsData.realname..SIKeyw[type].."-"..name or name )
	if data then return self
	else return self:SetImage( currentConstantsData.picturePath ) end
end

function entity:Extend()
	if not self.allreadyCreate then
		e( "模块构建 : 必须先创建才能提交" )
		return nil
	end
	if self.hasExtend then
		e( "模块提交 : 不能重复提交已经提交过的数据 , 必须重新创建 : "..self:GetName() )
		return nil
	end
	self.data.sourceMod = self.sourceMod
	SIGen.Extend{ self.data }
	self:Auto()
	self.hasExtend = true
	return self
end

-- ------------------------------------------------------------------------------------------------
-- -------- 获取基础参数 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function entity:SetBaseName( name )
	self.baseName = name
	return self
end

function entity:GetCodeName()
	return self.codeName
end

function entity:GetBaseName()
	return self.baseName
end

function entity:GetSourceMod()
	return self.sourceMod
end

function entity:GetSourceModConstantsData()
	if self.sourceMod then return _G[self.sourceMod]
	else return nil end
end

function entity:AllreadyCreate()
	return self.allreadyCreate
end

function entity:HasFill()
	return self.hasFill
end

function entity:HasExtend()
	return self.hasExtend
end

function entity:GetSourceData()
	return self.data
end

-- ------------------------------------------------------------------------------------------------
-- --------- 检查完整性 ---------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function entity:Check()
	if not self.allreadyCreate then
		e( "模块构建 : 必须先创建才能修改属性" )
		return false
	end
	return true
end

function entity:CheckData( data )
	if not self.allreadyCreate then
		e( "模块构建 : 必须先创建才能修改属性" )
		return false
	end
	if not data then
		l( "模块构建 : 加入了空的数据 : "..self:GetCodeName().." , "..self:GetBaseName() )
		return false
	end
	return true
end

function entity:HasCodeName( subCodeName )
	local codeNames = self:GetCodeName():Split( "-" )
	for i , v in pairs( codeNames ) do if v == subCodeName then return true end end
	return false
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 导入数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function entity:Import( data )
	if not self:CheckData( data ) then return self , table.deepcopy( data ) end
	local new = table.deepcopy( data )
	for k , v in pairs( new ) do self.data[k] = v end
	return self , new
end

function entity:ImportData( type , name )
	return self:Import( SIGen.GetData( type , name ) )
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 获取数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function entity:GetType()
	return self:GetParam( "type" )
end

function entity:GetName()
	return self:GetParam( "name" )
end

function entity:GetGroup()
	return self:GetParam( "group" )
end

function entity:GetSubGroup()
	return self:GetParam( "subgroup" )
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 设置属性 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function entity:SetEnabled( enabled )
	return self:SetParam( "enabled" , enabled )
end

function entity:SetValid( valid )
	return self:SetParam( "valid" , valid )
end

function entity:SetHidden( hidden)
	return self:SetParam( "hidden" , hidden )
end

function entity:SetGroup( groupEntity )
	if not self:CheckData( groupEntity ) then return self end
	local entityType = groupEntity:GetType()
	if SITypes.group == entityType then
		return self:SetParam( "group" , groupEntity:GetName() )
	elseif SITypes.subgroup == entityType then
		return self:SetParam( "group" , groupEntity:GetGroup() ):SetParam( "subgroup" , groupEntity:GetName() )
	else
		e( "模块构建 : SetGroup 方法参数必须使用分组实体" )
		return self
	end
end

function entity:SetOrder( orderCode )
	return self:SetParam( "order" , SIGen.Order( orderCode ) )
end

function entity:SetLocalisedNames( nameOrListOrPack )
	if not self:CheckData( nameOrListOrPack ) then return self end
	local dataType = type( nameOrListOrPack )
	if dataType == "string" then
		return self:SetParam( "localised_name" , { nameOrListOrPack } )
	elseif dataType == "table" then
		if nameOrListOrPack.isPack then
			return self:SetParam( "localised_name" , nameOrListOrPack.data )
		else
			return self:SetParam( "localised_name" , nameOrListOrPack )
		end
	else
		e( "模块构建 : SetLocalisedNames 方法参数必须使用字符串/数组/数据包格式" )
		return self
	end
end

function entity:SetLocalisedDescriptions( descriptionOrListOrPack )
	if not self:CheckData( descriptionOrListOrPack ) then return self end
	local dataType = type( descriptionOrListOrPack )
	if dataType == "string" then
		return self:SetParam( "localised_description" , { descriptionOrListOrPack } )
	elseif dataType == "table" then
		if descriptionOrListOrPack.isPack then
			return self:SetParam( "localised_description" , descriptionOrListOrPack.data )
		else
			return self:SetParam( "localised_description" , descriptionOrListOrPack )
		end
	else
		e( "模块构建 : SetLocalisedDescriptions 方法参数必须使用字符串/数组/数据包格式" )
		return self
	end
end

function entity:SetCustomData( data )
	self:Import( data )
	return self
end



function entity:SetFlags( flagOrFlagsOrPack )
	if not self:CheckData( flagOrFlagsOrPack ) then return self end
	local dataType = type( flagOrFlagsOrPack )
	if dataType == "string" then self:SetParam( "flags" , { flagOrFlagsOrPack } )
	elseif dataType == "table" then
		if flagOrFlagsOrPack.isPack then self:SetParam( "flags" , flagOrFlagsOrPack.data )
		else self:SetParam( "flags" , flagOrFlagsOrPack ) end
	else e( "模块构建 : SetFlags 方法参数必须使用字符串/数组格式" ) end
	return self
end

function entity:AddFlags( flagOrFlagsOrPack )
	if not self:CheckData( flagOrFlagsOrPack ) then return self end
	self:Default( "flags" , {} )
	local dataType = type( flagOrFlagsOrPack )
	if dataType == "string" then self:AddParamItem( "flags" , flagOrFlagsOrPack )
	elseif dataType == "table" then
		if flagOrFlagsOrPack.isPack then flagOrFlagsOrPack = flagOrFlagsOrPack.data end
		for i , v in pairs( flagOrFlagsOrPack ) do self:AddParamItem( "flags" , v ) end
	else e( "模块构建 : AddFlags 方法参数必须使用字符串/数组格式" ) end
	return self
end

function entity:ClearFlags()
	return self:DeleteParam( "flags" )
end



function entity:SetPic( key , layer )
	if key and layer then return self:SetParam( key , layer )
	else return self end
end

-- ------------------------------------------------------------------------------------------------
-- -------- 操作属性方法 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function entity:SetParam( key , value )
	if not self:Check() then return self end
	self.data[key] = value
	return self
end

function entity:DeleteParam( key )
	if not self:Check() then return self end
	self.data[key] = nil
	if type( key ) == "number" then table.remove( self.data , key ) end
	return self
end

function entity:GetParam( key )
	return self.data[key]
end



function entity:AddParamItem( key , ... )
	if not self:Check() then return self end
	local list = self.data[key]
	if type( list ) ~= "table" then
		e( "模块构建：不能对非 table 类型的属性使用该方法" )
		return self
	end
	for i , v in pairs{ ... } do table.insert( list , v ) end
	self.data[key] = list
	return self
end

function entity:InsertParamItem( key , startindex , ... )
	if not self:Check() then return self end
	local list = self.data[key]
	if type( list ) ~= "table" then
		e( "模块构建：不能对非 table 类型的属性使用该方法" )
		return self
	end
	startindex = startindex - 1
	for i , v in pairs{ ... } do table.insert( list , startindex+i , v ) end
	self.data[key] = list
	return self
end

function entity:SetParamItem( key , startindex , ... )
	if not self:Check() then return self end
	local list = self.data[key]
	if type( list ) ~= "table" then
		e( "模块构建：不能对非 table 类型的属性使用该方法" )
		return self
	end
	startindex = startindex - 1
	for i , v in pairs{ ... } do list[startindex+i] = v end
	self.data[key] = list
	return self
end

function entity:RemoveParamItem( key , length )
	if not self:Check() then return self end
	local list = self.data[key]
	if type( list ) ~= "table" then
		e( "模块构建：不能对非 table 类型的属性使用该方法" )
		return self
	end
	for i = #list-length+1 , #list , 1 do
		list[i] = nil
		table.remove( list , i )
	end
	self.data[key] = list
	return self
end

function entity:DeleteParamItem( key , ... )
	if not self:Check() then return self end
	local list = self.data[key]
	if type( list ) ~= "table" then
		e( "模块构建：不能对非 table 类型的属性使用该方法" )
		return self
	end
	for i , v in pairs{ ... } do
		list[v] = nil
		table.remove( list , v )
	end
	local param = {}
	for i , v in pairs( list ) do if v then table.insert( param , v ) end end
	self.data[key] = param
	return self
end

function entity:GetParamItem( key , index )
	local list = self.data[key]
	if type( list ) ~= "table" then
		e( "模块构建：不能对非 table 类型的属性使用该方法" )
		return self , nil
	end
	return list[index]
end



function entity:Default( key , defaultData )
	if self:GetParam( key ) == nil then self:SetParam( key , defaultData ) end
	return self
end

-- ------------------------------------------------------------------------------------------------
-- -------- 批量快速填充 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function entity:Change_clearIcons( needClearIcons )
	if needClearIcons then return self:DeleteParam( "icon" ):DeleteParam( "icons" )
	else return self end
end

function entity:Inserter_insertIcons( iconData )
	if not iconData then
		e( "模块构建：不能插入空的图标数据" )
		return self
	end
	local icon = self:GetParam( "icon" )
	local icons = self:GetParam( "icons" )
	if icon then
		icons = {}
		self:DeleteParam( "icon" )
		table.insert( icons , SIPackers.Icon( icon , nil , self:GetParam( "icon_mipmaps" ) ) )
	else
		if not icons then icons = {} end
	end
	if iconData.index < 1 or iconData.index > #icons then table.insert( icons , iconData )
	else table.insert( icons , iconData.index , iconData ) end
	return self:SetParam( "icons" , icons )
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 默认标识 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function entity:DefaultFlags()
	return self
end

-- ------------------------------------------------------------------------------------------------
-- -------- 子类设置属性 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function entity:SetImage( path )
	return self
end

function entity:SetStackSize( stackSize )
	return self
end

function entity:SetSize( width , height )
	return self
end

function entity:SetHealth( health , descriptionKey , descriptionValue )
	return self
end

function entity:SetSpeed( speed )
	return self
end

function entity:SetEnergy( energyUsage , energySource )
	return self
end

function entity:SetSlotCount( inputSlotCount , outputSlotCount )
	return self
end

function entity:SetEffectRadius( effectRadius , linkRadius , connectRadius )
	return self
end

function entity:SetEffectEnergy( effectEnergy , linkEnergy , connectEnergy )
	return self
end

function entity:SetModuleData( slotCount , iconShift )
	return self
end

function entity:SetLight( intensity , size , color )
	return self
end

function entity:SetCorpse( corpse , explosion , triggerEffect )
	return self
end

function entity:SetLevel( level , maxLevel )
	return self
end

function entity:SetMainRecipe( recipeOrDataOrEntityOrPack )
	return self
end

function entity:SetLogisticMode( logicType )
	return self
end

function entity:SetSignalWire( distance , points , sprites , signals )
	return self
end

function entity:SetFluidBox( areaOrBoxOrPack , connections , baseLevel , productionType , levelHeight , filter , minTemperature , maxTemperature )
	return self
end

function entity:SetEnabled( enabled )
	return self
end



function entity:SetResidences( residenceOrResidencesOrPack )
	return self
end

function entity:AddResidences( residenceOrResidencesOrPack )
	return self
end

function entity:ClearResidences()
	return self
end

function entity:SetTechnologies( technologyOrTechnologiesOrPack )
	return self
end

function entity:AddTechnologies( technologyOrTechnologiesOrPack )
	return self
end

function entity:ClearTechnologies()
	return self
end

function entity:SetRecipeTypes( typeOrTypesOrPack )
	return self
end

function entity:AddRecipeTypes( typeOrTypesOrPack )
	return self
end

function entity:ClearRecipeTypes()
	return self
end

function entity:SetPluginTypes( typeOrTypesOrPack )
	return self
end

function entity:AddPluginTypes( typeOrTypesOrPack )
	return self
end

function entity:ClearPluginTypes()
	return self
end

function entity:SetCosts( costOrCostsOrPack , count )
	return self
end

function entity:AddCosts( costOrCostsOrPack , count )
	return self
end

function entity:ClearCosts()
	return self
end

function entity:SetResults( resultOrResultsOrPack , resultType , count )
	return self
end

function entity:AddResults( resultOrResultsOrPack , count )
	return self
end

function entity:ClearResults()
	return self
end



function entity:SetRender_notInNetworkIcon( trueOrFalse )
	return self
end

function entity:SetSelfIcon( name )
	return self
end

function entity:AddLastLevel( count )
	return self
end

function entity:AddSuperArmor()
	return self
end

-- ------------------------------------------------------------------------------------------------
-- -------- 子类流程控制 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function entity:Init( currentEntity )
	return self
end

function entity:Fill( currentEntity )
	if not currentEntity then currentEntity = self end
	currentEntity.hasFill = true
	return self
end

function entity:Auto( currentEntity )
	return self
end

function entity:Finish( currentEntity )
	return self
end

return entity