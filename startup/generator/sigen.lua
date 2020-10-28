-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local currentConstantsData = nil
local currentGroup = nil
local currentSubGroup = nil
local currentData = nil

local currentGroup_order = 1
local currentSubGroup_order = 0
local currentData_order = 0

local savedGroupData =
{
	lastGroupName = nil ,
	groupDataList = {}
}
local savedSubGroupData =
{
	lastSubGroupName = nil ,
	subGroupDataList = {}
}

local insertData =
{
	Icon = nil
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 内部处理 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local function SaveGroupData()
	local lastGroupName = savedGroupData.lastGroupName
	if lastGroupName then
		local groupData = savedGroupData.groupDataList[lastGroupName]
		if not groupData then groupData = {} end
		groupData.entity = currentGroup
		groupData.subGroup_order = currentSubGroup_order
		savedGroupData.groupDataList[lastGroupName] = groupData
	end
end

local function SaveSubGroupData()
	local lastSubGroupName = savedSubGroupData.lastSubGroupName
	if lastSubGroupName then
		local subGroupData = savedSubGroupData.subGroupDataList[lastSubGroupName]
		if not subGroupData then subGroupData = {} end
		subGroupData.entity = currentSubGroup
		subGroupData.data_order = currentData_order
		savedSubGroupData.subGroupDataList[lastSubGroupName] = subGroupData
	end
end

local function DefaultValues()
	SaveGroupData()
	SaveSubGroupData()
	
	currentConstantsData = nil
	currentGroup = nil
	currentSubGroup = nil
	currentData = nil
	
	currentSubGroup_order = 0
	currentData_order = 0
	
	savedGroupData.lastGroupName = nil
	savedSubGroupData.lastSubGroupName = nil
end

local function FinishData()
	if currentData then
		if not currentData:HasFill() then currentData:Fill() end
		for k , v in pairs( insertData ) do
			if v then
				for n , m in pairs( v ) do currentData["Insert"..k]( currentData , m ) end
			end
		end
		currentData:Extend():Finish()
	end
end

local function InitEntity()
	currentData:Init()
	:DefaultFlags()
	:SetGroup( currentSubGroup )
	:SetOrder( currentData_order )
	currentData_order = currentData_order + 1
end

-- ------------------------------------------------------------------------------------------------
-- --------- 检查完整性 ---------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local function CheckData()
	if not currentConstantsData then
		e( "模块构建 : 创建实体时基础信息(ConstantsData)不能为空" )
		return false
	end
	if not currentGroup then
		e( "模块构建 : 创建实体时分组信息(Group)不能为空" )
		return false
	end
	if not currentSubGroup then
		e( "模块构建 : 创建实体时子分组信息(SubGroup)不能为空" )
		return false
	end
	return true
end

local function CheckEntityData( typeCode )
	if not CheckData() then
		return false
	end
	if not currentData then
		e( "模块构建 : 修改实体属性时实体(Entity)不能为空" )
		return false
	end
	if not table.Has( typeCode , currentData:GetType() ) then
		e( "模块构建 : 当前实体不支持此属性" )
		return false
	end
	return true
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 添加参数 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen =
{
	dataFlags = {} ,
	resultType =
	{
		none         = "none" ,
		entity       = "entity" ,
		module       = "module" ,
		burnt        = "burnt" ,
		tile         = "tile" ,
		rocketLaunch = "rocket" ,
		recipe       = "recipe" ,
		technology   = "tech"
	}
}

SIGen.Base = need( "sigen_base" )
SIGen.Group = need( "sigen_group" )
SIGen.SubGroup = need( "sigen_subgroup" )
SIGen.Item = need( "sigen_item" )
SIGen.Tool = need( "sigen_item_tool" )
SIGen.Entity = need( "sigen_entity" )
SIGen.HealthEntity = need( "sigen_entity_health" )
SIGen.Boiler = need( "sigen_entity_health_boiler" )
SIGen.Generator = need( "sigen_entity_health_generator" )
SIGen.Pump = need( "sigen_entity_health_pump" )
SIGen.Mining = need( "sigen_entity_health_mining" )
SIGen.Furnace = need( "sigen_entity_health_furnace" )
SIGen.Machine = need( "sigen_entity_health_machine" )
SIGen.Lab = need( "sigen_entity_health_lab" )
SIGen.Beacon = need( "sigen_entity_health_beacon" )
SIGen.Roboport = need( "sigen_entity_health_roboport" )
SIGen.Container = need( "sigen_entity_health_container" )
SIGen.ContainerLogic = need( "sigen_entity_health_container_logic" )
SIGen.Recipe = need( "sigen_recipe" )
SIGen.Technology = need( "sigen_technology" )

SIGen.dataFlags.all = SIUtils.MapAllValueToList( SITypes.all )
SIGen.dataFlags.item = SIUtils.MapValueToList( SITypes.item )
SIGen.dataFlags.entity = SIUtils.MapValueToList( SITypes.entity )
SIGen.dataFlags.machine = SIUtils.MapValueToList( SITypes.machine )
SIGen.dataFlags.recipe =
{
	SITypes.recipe
}
SIGen.dataFlags.technology =
{
	SITypes.technology
}
SIGen.dataFlags.result =
{
	SITypes.item.item ,
	SITypes.item.item_e ,
	SITypes.recipe ,
	SITypes.technology
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 获取数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIGen.GetData( type , name )
	return data.raw[type][name]
end

function SIGen.GetList( type )
	return data.raw[type]
end

function SIGen.CopyData( type , name )
	local d = data.raw[type][name]
	if d then return table.deepcopy( d )
	else return nil end
end

function SIGen.CopyList( type )
	local l = data.raw[type]
	if l then return table.deepcopy( l )
	else return nil end
end

function SIGen.Extend( list )
	data:extend( list )
end

-- ------------------------------------------------------------------------------------------------
-- -------- 获取实体数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIGen.GetCurrentConstantsData()
	return currentConstantsData
end

function SIGen.GetCurrentGroupEntity()
	return currentGroup
end

function SIGen.GetCurrentSubGroupEntity()
	return currentSubGroup
end

function SIGen.GetCurrentDataEntity()
	return currentData
end

function SIGen.GetCurrentDataOrder()
	return currentData_order
end

function SIGen.GetCurrentEntityBaseName()
	if not currentData then
		e( "模块构建 : 当前没有创建过实体时不能使用 GetCurrentEntityBaseName 方法" )
		return nil
	end
	return currentData:GetBaseName()
end

function SIGen.GetCurrentEntityName()
	if not currentData then
		e( "模块构建 : 当前没有创建过实体时不能使用 GetCurrentEntityName 方法" )
		return nil
	end
	return currentData:GetName()
end

function SIGen.GetCurrentEntityItemName()
	if not currentData then
		e( "模块构建 : 当前没有创建过实体时不能使用 GetCurrentEntityItemName 方法" )
		return nil
	end
	if not currentData:HasCodeName( "entity" ) then
		e( "模块构建 : 只有实体(Entity)类型的实体才能使用 GetCurrentEntityItemName 方法" )
		return nil
	end
	if not currentData:HasFill() then currentData:Fill() end
	local item = currentData:GetItem()
	if item then return item:GetName()
	else return nil end
end

function SIGen.GetCurrentEntitySourceData()
	if not currentData then
		e( "模块构建 : 当前没有创建过实体时不能使用 GetCurrentEntitySourceData 方法" )
		return nil
	end
	return currentData:GetSourceData()
end

function SIGen.Order( orderCode )
	if type( orderCode ) == "number" then
		local o = ""
		while( orderCode > 0 ) do
			o = o .. SIOrderList[math.fmod( math.floor( orderCode ) , SIOrderListSize )+1]
			orderCode = math.floor( orderCode/SIOrderListSize )
		end
		for i = 1 , 3-o:len() , 1 do o = "-" .. o end
		return o
	else return orderCode end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 构建流程 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIGen.Init( ConstantsData )
	DefaultValues()
	currentConstantsData = ConstantsData
	return SIGen
end

function SIGen.Finish()
	FinishData()
	DefaultValues()
	return SIGen.ClearInsert()
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 创建分组 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIGen.NewGroup( name , group )
	if not currentConstantsData then
		e( "模块构建 : 创建实体时基础信息(ConstantsData)不能为空" )
		return SIGen
	end
	if savedGroupData.lastGroupName == name then return SIGen end
	SaveGroupData()
	savedGroupData.lastGroupName = name
	local groupData = savedGroupData.groupDataList[name]
	if groupData then
		currentGroup = groupData.entity
		currentSubGroup_order = groupData.subGroup_order
	else
		currentGroup = SIGen.Group:New( name , group )
		:SetOrder( currentConstantsData.orderCode..currentGroup_order )
		:Fill()
		:Extend()
		:Finish()
		currentGroup_order = currentGroup_order + 1
		currentSubGroup_order = 1
	end
	return SIGen
end

function SIGen.NewSubGroup( name , subgroup )
	if not currentConstantsData then
		e( "模块构建 : 创建实体时基础信息(ConstantsData)不能为空" )
		return SIGen
	end
	if not currentGroup then
		e( "模块构建 : 创建实体时分组信息(Group)不能为空" )
		return SIGen
	end
	if savedSubGroupData.lastSubGroupName == name then return SIGen end
	SaveSubGroupData()
	savedSubGroupData.lastSubGroupName = name
	local subGroupData = savedSubGroupData.subGroupDataList[name]
	if subGroupData then
		currentSubGroup = subGroupData.entity
		currentData_order = subGroupData.data_order
	else
		currentSubGroup = SIGen.SubGroup:New( name , subgroup )
		:SetGroup( currentGroup )
		:SetOrder( currentSubGroup_order )
		:Fill()
		:Extend()
		:Finish()
		currentSubGroup_order = currentSubGroup_order + 1
		currentData_order = 1
	end
	return SIGen
end

-- ------------------------------------------------------------------------------------------------
-- -------- 创建附加数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIGen.InsertIcon( index , iconPath , tint , mipmaps )
	local icon = insertData.Icon
	if not icon then
		icon = {}
	end
	table.insert( icon , { index = index , iconPath = iconPath , tint = tint , mipmaps = mipmaps } )
	insertData.Icon = icon
	return SIGen
end

function SIGen.ClearInsert()
	for k , v in pairs( insertData ) do if v then insertData[k] = nil end end
	return SIGen
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 创建实体 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIGen.NewEmpty( type , name , data )
	FinishData()
	if not CheckData() then return SIGen end
	currentData = SIGen.Base:New( type , name , data )
	InitEntity()
	return SIGen
end

function SIGen.NewItem( name , stackSize , item )
	FinishData()
	if not CheckData() then return SIGen end
	currentData = SIGen.Item:New( name , item )
	InitEntity()
	if stackSize then currentData:SetStackSize( stackSize ) end
	return SIGen
end

function SIGen.NewTool( name , stackSize , tool )
	FinishData()
	if not CheckData() then return SIGen end
	currentData = SIGen.Tool:New( name , tool )
	InitEntity()
	if stackSize then currentData:SetStackSize( stackSize ) end
	return SIGen
end

function SIGen.NewEntity( type , name , entity )
	FinishData()
	if not CheckData() then return SIGen end
	currentData = SIGen.Entity:New( type , name , entity )
	InitEntity()
	return SIGen
end

function SIGen.NewHealthEntity( type , name , healthEntity )
	FinishData()
	if not CheckData() then return SIGen end
	currentData = SIGen.HealthEntity:New( type , name , healthEntity )
	InitEntity()
	return SIGen
end

function SIGen.NewBoiler( name , boiler )
	FinishData()
	if not CheckData() then return SIGen end
	currentData = SIGen.Boiler:New( name , boiler )
	InitEntity()
	return SIGen
end

function SIGen.NewGenerator( name , generator )
	FinishData()
	if not CheckData() then return SIGen end
	currentData = SIGen.Generator:New( name , generator )
	InitEntity()
	return SIGen
end

function SIGen.NewPump( name , pump )
	FinishData()
	if not CheckData() then return SIGen end
	currentData = SIGen.Pump:New( name , pump )
	InitEntity()
	return SIGen
end

function SIGen.NewMining( name , mining )
	FinishData()
	if not CheckData() then return SIGen end
	currentData = SIGen.Mining:New( name , mining )
	InitEntity()
	return SIGen
end

function SIGen.NewFurnace( name , furnace )
	FinishData()
	if not CheckData() then return SIGen end
	currentData = SIGen.Furnace:New( name , furnace )
	InitEntity()
	return SIGen
end

function SIGen.NewMachine( name , machine )
	FinishData()
	if not CheckData() then return SIGen end
	currentData = SIGen.Machine:New( name , machine )
	InitEntity()
	return SIGen
end

function SIGen.NewLab( name , lab )
	FinishData()
	if not CheckData() then return SIGen end
	currentData = SIGen.Lab:New( name , lab )
	InitEntity()
	return SIGen
end

function SIGen.NewBeacon( name , beacon )
	FinishData()
	if not CheckData() then return SIGen end
	currentData = SIGen.Beacon:New( name , beacon )
	InitEntity()
	return SIGen
end

function SIGen.NewRoboport( name , roboport )
	FinishData()
	if not CheckData() then return SIGen end
	currentData = SIGen.Roboport:New( name , roboport )
	InitEntity()
	return SIGen
end

function SIGen.NewContainer( name , container )
	FinishData()
	if not CheckData() then return SIGen end
	currentData = SIGen.Container:New( name , container )
	InitEntity()
	return SIGen
end

function SIGen.NewContainerLogic( name , containerLogic , logisticMode )
	FinishData()
	if not CheckData() then return SIGen end
	currentData = SIGen.ContainerLogic:New( name , containerLogic )
	InitEntity()
	if logisticMode then currentData:SetLogisticMode( logisticMode ) end
	return SIGen
end

function SIGen.NewRecipe( name , recipe )
	FinishData()
	if not CheckData() then return SIGen end
	currentData = SIGen.Recipe:New( name , recipe )
	InitEntity()
	return SIGen
end

function SIGen.NewTechnology( name , technology )
	FinishData()
	if not CheckData() then return SIGen end
	currentData = SIGen.Technology:New( name , technology )
	InitEntity()
	return SIGen
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 自动填充 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIGen.SetItemName( itemName )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	if currentData.SetItemName then currentData:SetItemName( itemName ) end
	return SIGen
end

function SIGen.Fill()
	if not currentData then
		e( "模块构建 : 当前没有创建过实体时不能使用 Fill 方法" )
		return SIGen
	end
	if currentData:HasFill() then
		e( "模块构建 : 当前实体已经使用过 Fill 方法了" )
		return SIGen
	end
	currentData:Fill()
	return SIGen
end

-- ------------------------------------------------------------------------------------------------
-- -------- 设置实体属性 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIGen.SetLocalizedNames( nameOrListOrPack )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentData:SetLocalizedNames( nameOrListOrPack )
	return SIGen
end

function SIGen.SetLocalizedDescriptions( descriptionOrListOrPack )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentData:SetLocalizedDescriptions( descriptionOrListOrPack )
	return SIGen
end

function SIGen.SetCustomData( data )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	if type( data ) == "table" then currentData:SetCustomData( data ) end
	return SIGen
end



function SIGen.SetProperties( width , height , health , speed , energyUsage , energySource , inputSlotCount , outputSlotCount )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	if width or height then currentData:SetSize( width , height ) end
	if health then currentData:SetHealth( health ) end
	if speed then currentData:SetSpeed( speed ) end
	if energyUsage or energySource then currentData:SetEnergy( energyUsage , energySource ) end
	if inputSlotCount or outputSlotCount then currentData:SetSlotCount( inputSlotCount , outputSlotCount ) end
	return SIGen
end

function SIGen.SetSize( width , height )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	if width or height then currentData:SetSize( width , height ) end
	return SIGen
end

function SIGen.SetHealth( health , descriptionKey , descriptionValue )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	if health then currentData:SetHealth( health , descriptionKey , descriptionValue ) end
	return SIGen
end

function SIGen.SetSpeed( speed )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	if speed then currentData:SetSpeed( speed ) end
	return SIGen
end

function SIGen.SetEnergy( energyUsage , energySource )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	if energyUsage or energySource then currentData:SetEnergy( energyUsage , energySource ) end
	return SIGen
end

function SIGen.SetSlotCount( inputSlotCount , outputSlotCount )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	if inputSlotCount or outputSlotCount then currentData:SetSlotCount( inputSlotCount , outputSlotCount ) end
	return SIGen
end

function SIGen.SetEffectRadius( effectRadius , linkRadius , connectRadius )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	if effectRadius or linkRadius or connectRadius then currentData:SetEffectRadius( effectRadius , linkRadius , connectRadius ) end
	return SIGen
end

function SIGen.SetModuleData( slotCount , iconShift )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	if slotCount or iconShift then currentData:SetModuleData( slotCount , iconShift ) end
	return SIGen
end

function SIGen.SetLight( intensity , size , color )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentData:SetLight( intensity , size , color )
	return SIGen
end

function SIGen.SetCorpse( corpse , explosion , triggerEffect )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	if corpse or explosion or triggerEffect then currentData:SetCorpse( corpse , explosion , triggerEffect ) end
	return SIGen
end

function SIGen.SetLevel( level , maxLevel )
	if not CheckEntityData( SIGen.dataFlags.technology ) then return SIGen end
	if level or maxLevel then currentData:SetLevel( level , maxLevel ) end
	return SIGen
end

function SIGen.SetMainRecipe( recipeOrDataOrEntityOrPack )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentData:SetMainRecipe( recipeOrDataOrEntityOrPack )
	return SIGen
end

function SIGen.SetLogisticMode( logisticMode )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentData:SetLogisticMode( logisticMode )
	return SIGen
end



function SIGen.SetFlags( flagOrFlagsOrPack )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentData:SetFlags( flagOrFlagsOrPack )
	return SIGen
end

function SIGen.AddFlags( flagOrFlagsOrPack )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentData:AddFlags( flagOrFlagsOrPack )
	return SIGen
end

function SIGen.ClearFlags()
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentData:ClearFlags()
	return SIGen
end

function SIGen.SetResidences( residenceOrResidencesOrPack )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentData:SetResidences( residenceOrResidencesOrPack )
	return SIGen
end

function SIGen.AddResidences( residenceOrResidencesOrPack )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentData:AddResidences( residenceOrResidencesOrPack )
	return SIGen
end

function SIGen.ClearResidences()
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentData:ClearResidences()
	return SIGen
end

function SIGen.SetTechnologies( technologyOrTechnologiesOrPack )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentData:SetTechnologies( technologyOrTechnologiesOrPack )
	return SIGen
end

function SIGen.AddTechnologies( technologyOrTechnologiesOrPack )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentData:AddTechnologies( technologyOrTechnologiesOrPack )
	return SIGen
end

function SIGen.ClearTechnologies()
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentData:ClearTechnologies()
	return SIGen
end

function SIGen.SetRecipeTypes( typeOrTypesOrPack )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentData:SetRecipeTypes( typeOrTypesOrPack )
	return SIGen
end

function SIGen.AddRecipeTypes( typeOrTypesOrPack )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentData:AddRecipeTypes( typeOrTypesOrPack )
	return SIGen
end

function SIGen.ClearRecipeTypes()
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentData:ClearRecipeTypes()
	return SIGen
end

function SIGen.SetPluginTypes( typeOrTypesOrPack )
	if not CheckEntityData( SIGen.dataFlags.item ) then return SIGen end
	currentData:SetPluginTypes( typeOrTypesOrPack )
	return SIGen
end

function SIGen.AddPluginTypes( typeOrTypesOrPack )
	if not CheckEntityData( SIGen.dataFlags.item ) then return SIGen end
	currentData:AddPluginTypes( typeOrTypesOrPack )
	return SIGen
end

function SIGen.ClearPluginTypes()
	if not CheckEntityData( SIGen.dataFlags.item ) then return SIGen end
	currentData:ClearPluginTypes()
	return SIGen
end

function SIGen.SetCosts( costOrCostsOrPack , count )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentData:SetCosts( costOrCostsOrPack , count )
	return SIGen
end

function SIGen.AddCosts( costOrCostsOrPack , count )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentData:AddCosts( costOrCostsOrPack , count )
	return SIGen
end

function SIGen.ClearCosts()
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentData:ClearCosts()
	return SIGen
end

function SIGen.SetResults( resultOrResultsOrPack , resultType , count )
	if not CheckEntityData( SIGen.dataFlags.result ) then return SIGen end
	local type = currentData:GetType()
	if not resultType then
		if type == SITypes.item.item or type == SITypes.item.item_e then resultType = SIGen.resultType.entity
		elseif type == SITypes.recipe then resultType = SIGen.resultType.recipe
		elseif type == SITypes.technology then resultType = SIGen.resultType.technology
		else
			e( "模块构建 : 当前实体不支持此属性" )
			return SIGen
		end
	elseif type == SITypes.recipe and resultType and not count then
		count = resultType
		resultType = SIGen.resultType.recipe
	end
	currentData:SetResults( resultOrResultsOrPack , resultType , count )
	return SIGen
end

function SIGen.AddResults( resultOrResultsOrPack , count )
	if not CheckEntityData( SIGen.dataFlags.result ) then return SIGen end
	currentData:AddResults( resultOrResultsOrPack , count )
	return SIGen
end

function SIGen.ClearResults()
	if not CheckEntityData( SIGen.dataFlags.result ) then return SIGen end
	currentData:ClearResults()
	return SIGen
end



function SIGen.SetRender_notInNetworkIcon( trueOrFalse )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentData:SetRender_notInNetworkIcon( trueOrFalse )
	return SIGen
end