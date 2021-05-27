-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local currentConstantsData = nil
local currentGroup = nil
local currentSubGroup = nil
local currentEntity = nil
local currentEntityName = nil

local currentGroup_order = 1
local currentSubGroup_order = 0
local currentEntity_order = 0
local currentTechnologyData_order = 1

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

local superArmorDataList = {}
local autoFillDataList = {}

local dataList =
{
	item    = {} ,
	fluid   = {} ,
	entity  = {}
	virtual = {}
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
		subGroupData.entity_order = currentEntity_order
		savedSubGroupData.subGroupDataList[lastSubGroupName] = subGroupData
	end
end

local function DefaultValues()
	SaveGroupData()
	SaveSubGroupData()
	
	currentConstantsData = nil
	currentGroup = nil
	currentSubGroup = nil
	currentEntity = nil
	
	currentSubGroup_order = 0
	currentEntity_order = 0
	
	savedGroupData.lastGroupName = nil
	savedSubGroupData.lastSubGroupName = nil
end

local function FinishData()
	if currentEntity and not currentEntity:HasExtend() then
		if not currentEntity:HasFill() then currentEntity:Fill() end
		SIGen.Inserter.InsertData( currentEntity )
		currentEntity:Extend():Finish()
	end
	currentEntityName = nil
end

local function InitEntity()
	currentEntity:Init()
	:DefaultFlags()
	:SetGroup( currentSubGroup )
	if currentEntity:GetType() == SITypes.technology then
		currentEntity:SetOrder( currentTechnologyData_order )
		currentTechnologyData_order = currentTechnologyData_order + 1
	else
		currentEntity:SetOrder( currentEntity_order )
		currentEntity_order = currentEntity_order + 1
	end
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
	if not currentEntity then
		e( "模块构建 : 修改实体属性时实体(Entity)不能为空" )
		return false
	end
	if not table.Has( typeCode , currentEntity:GetType() ) then
		e( "模块构建 : 当前实体不支持此属性" )
		return false
	end
	return true
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 工具函数 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local function AutoFillWithTable( data )
	for key , value in pairs( data ) do
		local dataType = type( value )
		if dataType == "function" then
			local iaAuto , codeType , cur = value()
			if iaAuto then
				local real
				if codeType == SIGen.autoFillType.item then real = dataList.item[cur]
				elseif codeType == SIGen.autoFillType.fluid then real = dataList.fluid[cur]
				elseif codeType == SIGen.autoFillType.entity then real = dataList.entity[cur]
				elseif codeType == SIGen.autoFillType.virtual then real = dataList.virtual[cur]
				else real = nil end
				data[key] = real or cur
			end
		else dataType == "table" then AutoFillWithTable( value ) end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 添加参数 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen =
{
	D  = {} , -- 调试方法
	E  = {} , -- 批量快速填充专用前缀
	F1 = {} , -- 内部自动填充专用前缀 ( 此处方法均为为自动调用 , 不能手动调用 )
	F2 = {} , -- 内部自动填充专用前缀 ( 此处方法均为为自动调用 , 不能手动调用 )
	dataFlags =
	{
		all          = SIUtils.MapAllValueToList( SITypes.all ) ,
		item         = SIUtils.MapValueToList( SITypes.item ) ,
		entity       = SIUtils.MapValueToList( SITypes.entity ) ,
		machine      = SIUtils.MapValueToList( SITypes.machine ) ,
		recipe       = { SITypes.recipe } ,
		technology   = { SITypes.technology } ,
		result       = { SITypes.item.item , SITypes.item.item_e , SITypes.recipe , SITypes.technology }
	} ,
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
	} ,
	autoFillType =
	{
		item         = "item" ,
		fluid        = "fluid" ,
		entity       = "entity" ,
		virtual      = "virtual"
	}
}

SIGen.Inserter = need( "sigen_inserter" )

SIGen.Base = need( "sigen_base" )
SIGen.Group = need( "sigen_group" )
SIGen.SubGroup = need( "sigen_subgroup" )
SIGen.Item = need( "sigen_item" )
SIGen.Capsule = need( "sigen_item_capsule" )
SIGen.Module = need( "sigen_item_module" )
SIGen.Tool = need( "sigen_item_tool" )
SIGen.Fluid = need( "sigen_fluid" )
SIGen.Entity = need( "sigen_entity" )
SIGen.Resource = need( "sigen_entity_resource" )
SIGen.Projectile = need( "sigen_entity_projectile" )
SIGen.HealthEntity = need( "sigen_entity_health" )
SIGen.Unit = need( "sigen_entity_health_unit" )
SIGen.Spawner = need( "sigen_entity_health_spawner" )
SIGen.Boiler = need( "sigen_entity_health_boiler" )
SIGen.Generator = need( "sigen_entity_health_generator" )
SIGen.BurnerGenerator = need( "sigen_entity_health_burner_generator" )
SIGen.Pump = need( "sigen_entity_health_pump" )
SIGen.Mining = need( "sigen_entity_health_mining" )
SIGen.Furnace = need( "sigen_entity_health_furnace" )
SIGen.Machine = need( "sigen_entity_health_machine" )
SIGen.Lab = need( "sigen_entity_health_lab" )
SIGen.Beacon = need( "sigen_entity_health_beacon" )
SIGen.Pipe = need( "sigen_entity_health_pipe" )
SIGen.Container = need( "sigen_entity_health_container" )
SIGen.ContainerLogic = need( "sigen_entity_health_container_logic" )
SIGen.ContainerLinked = need( "sigen_entity_health_container_linked" )
SIGen.Robot = need( "sigen_entity_health_robot" )
SIGen.RobotConstruction = need( "sigen_entity_health_robot_construction" )
SIGen.RobotLogistic = need( "sigen_entity_health_robot_logistic" )
SIGen.RobotCombat = need( "sigen_entity_health_robot_combat" )
SIGen.Roboport = need( "sigen_entity_health_roboport" )
SIGen.Radar = need( "sigen_entity_health_radar" )
SIGen.Recipe = need( "sigen_recipe" )
SIGen.Technology = need( "sigen_technology" )
SIGen.ControlAutoplace = need( "sigen_control_autoplace" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 调试方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIGen.D.EE()
	ee( currentEntity )
	return SIGen
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 获取数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIGen.GetList( type )
	return data.raw[type] or {}
end

function SIGen.GetData( type , name )
	return SIGen.GetList( type )[name]
end

function SIGen.CopyData( type , name )
	local d = data.raw[type][name]
	if d then return table.deepcopy( d )
	else return nil end
end

function SIGen.CopyList( type )
	local list = data.raw[type]
	if list then return table.deepcopy( list )
	else return nil end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 修改数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIGen.ClearList( type )
	data.raw[type] = {}
	return SIGen
end

function SIGen.Extend( list )
	data:extend( list )
	table.insert( autoFillDataList , list )
	return SIGen
end

-- ------------------------------------------------------------------------------------------------
-- ------ 获取自动填充数据 ------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIGen.GetAutoItem( name )
	return dataList.item[name] or name
end

function SIGen.GetAutoFluid( name )
	return dataList.fluid[name] or name
end

function SIGen.GetAutoEntity( name )
	return dataList.entity[name] or name
end

function SIGen.GetAutoVirtual( name )
	return dataList.virtual[name] or name
end

-- ------------------------------------------------------------------------------------------------
-- -------- 获取实体数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIGen.GetCurrentConstantsData()
	return currentConstantsData
end

function SIGen.GetPicturePath( type )
	return currentConstantsData.GetPicturePath( type )
end

function SIGen.GetCurrentGroupEntity()
	return currentGroup
end

function SIGen.GetCurrentSubGroupEntity()
	return currentSubGroup
end

function SIGen.GetCurrentEntity()
	return currentEntity
end

function SIGen.GetCurrentEntityOrder()
	return currentEntity_order
end

function SIGen.GetCurrentEntityBaseName()
	if not currentEntity then
		e( "模块构建 : 当前没有创建过实体时不能使用 GetCurrentEntityBaseName 方法" )
		return nil
	end
	return currentEntity:GetBaseName()
end

function SIGen.GetCurrentEntityName()
	if currentEntityName then return currentEntityName end
	if not currentEntity then
		e( "模块构建 : 当前没有创建过实体时不能使用 GetCurrentEntityName 方法" )
		return nil
	end
	return currentEntity:GetName()
end

function SIGen.GetIconFile()
	if not currentEntity then
		e( "模块构建 : 当前没有创建过实体时不能使用 GetIconFile 方法" )
		return nil
	end
	return currentConstantsData.GetPicturePath( SITypes.item.item ) .. "item/" .. currentEntity:GetBaseName()
end

function SIGen.GetLayerFile()
	if not currentEntity then
		e( "模块构建 : 当前没有创建过实体时不能使用 GetLayerFile 方法" )
		return nil
	end
	local baseName = currentEntity:GetBaseName()
	return currentConstantsData.GetPicturePath( currentEntity:GetType() ) .. "entity/" .. baseName .. "/" .. baseName
end

function SIGen.GetCurrentEntityItem()
	if not currentEntity then
		e( "模块构建 : 当前没有创建过实体时不能使用 GetCurrentEntityItemName 方法" )
		return nil
	end
	if not currentEntity:HasCodeName( "entity" ) then
		e( "模块构建 : 只有实体(Entity)类型的实体才能使用 GetCurrentEntityItemName 方法" )
		return nil
	end
	if not currentEntity:HasFill() then currentEntity:Fill() end
	return currentEntity:GetItem()
end

function SIGen.GetCurrentEntityItemName()
	if not currentEntity then
		e( "模块构建 : 当前没有创建过实体时不能使用 GetCurrentEntityItemName 方法" )
		return nil
	end
	if not currentEntity:HasCodeName( "entity" ) then
		e( "模块构建 : 只有实体(Entity)类型的实体才能使用 GetCurrentEntityItemName 方法" )
		return nil
	end
	if not currentEntity:HasFill() then currentEntity:Fill() end
	local item = currentEntity:GetItem()
	if item then return item:GetName()
	else return nil end
end

function SIGen.GetCurrentEntitySourceData()
	if not currentEntity then
		e( "模块构建 : 当前没有创建过实体时不能使用 GetCurrentEntitySourceData 方法" )
		return nil
	end
	return currentEntity:GetSourceData()
end

function SIGen.CreateName( baseName , type )
	local keyw = SIKeyw[type]
	return currentConstantsData.autoName and currentConstantsData.realname .. ( keyw and keyw.."-" or "" ) .. baseName or baseName
end

function SIGen.Order( orderCode )
	if type( orderCode ) == "number" then
		local o = ""
		while( orderCode > 0 ) do
			local code = math.fmod( math.floor( orderCode ) , SIOrderListSize )
			if code == 0 then code = SIOrderListSize end
			o = SIOrderList[code] .. o
			orderCode = math.floor( orderCode/SIOrderListSize )
		end
		for i = 1 , 3-o:len() , 1 do o = "-" .. o end
		if currentConstantsData then o = currentConstantsData.orderName .. o end
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
	return SIGen.Inserter.Clear()
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 创建分组 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- nameOrSettings =
-- {
--   name , 原始名称
--   autoName , 是否自动构建名称 , 即给名称添加前缀
-- }
function SIGen.NewGroup( nameOrSettings , group )
	if not currentConstantsData then
		e( "模块构建 : 创建实体时基础信息(ConstantsData)不能为空" )
		return SIGen
	end
	local name = ""
	local autoName = true
	if type( nameOrSettings ) == "table" then
		name = nameOrSettings.name
		autoName = nameOrSettings.autoName
	else name = nameOrSettings end
	if savedGroupData.lastGroupName == name then return SIGen end
	SaveGroupData()
	savedGroupData.lastGroupName = name
	local groupData = savedGroupData.groupDataList[name]
	if groupData then
		currentGroup = groupData.entity
		currentSubGroup_order = groupData.subGroup_order
	else
		local data = SIGen.GetData( SITypes.group , autoName and SIGen.CreateName( name , SITypes.group ) or name )
		if data then
			currentGroup = SIGen.Base:New( SITypes.group , name )
			:SetCustomData( data )
		else
			currentGroup = SIGen.Group:New( name , group )
			:SetOrder( currentConstantsData.orderName..currentGroup_order )
			:Fill()
			:Extend()
			:Finish()
			currentGroup_order = currentGroup_order + 1
		end
		currentSubGroup_order = 1
	end
	return SIGen
end

-- nameOrSettings =
-- {
--   name , 原始名称
--   autoName , 是否自动构建名称 , 即给名称添加前缀
-- }
function SIGen.NewSubGroup( nameOrSettings , subgroup )
	FinishData()
	if not currentConstantsData then
		e( "模块构建 : 创建实体时基础信息(ConstantsData)不能为空" )
		return SIGen
	end
	if not currentGroup then
		e( "模块构建 : 创建实体时分组信息(Group)不能为空" )
		return SIGen
	end
	local name = ""
	local autoName = true
	if type( nameOrSettings ) == "table" then
		name = nameOrSettings.name
		autoName = nameOrSettings.autoName
	else name = nameOrSettings end
	if savedSubGroupData.lastSubGroupName == name then return SIGen end
	SaveSubGroupData()
	savedSubGroupData.lastSubGroupName = name
	local subGroupData = savedSubGroupData.subGroupDataList[name]
	if subGroupData then
		currentSubGroup = subGroupData.entity
		currentEntity_order = subGroupData.entity_order
	else
		local data = SIGen.GetData( SITypes.subgroup , autoName and SIGen.CreateName( name , SITypes.subgroup ) or name )
		if data and data.group == currentGroup:GetName() then
			currentSubGroup = SIGen.Base:New( SITypes.subgroup , name )
			:SetCustomData( data )
		else
			currentSubGroup = SIGen.SubGroup:New( name , subgroup )
			:SetGroup( currentGroup )
			:SetOrder( currentSubGroup_order )
			:Fill()
			:Extend()
			:Finish()
			currentSubGroup_order = currentSubGroup_order + 1
		end
		currentEntity_order = 1
	end
	return SIGen
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 创建杂项 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIGen.NewTypeDamage( name )
	if not currentConstantsData then
		e( "模块构建 : 创建按键时基础信息(ConstantsData)不能为空" )
		return SIGen
	end
	SIGen.Extend{ { type = SITypes.damageType , name = name } }
	return SIGen
end

function SIGen.NewTypeAmmo( name )
	if not currentConstantsData then
		e( "模块构建 : 创建按键时基础信息(ConstantsData)不能为空" )
		return SIGen
	end
	SIGen.Extend{ { type = SITypes.category.ammo , name = name } }
	return SIGen
end

function SIGen.NewTypeEquipment( name )
	if not currentConstantsData then
		e( "模块构建 : 创建按键时基础信息(ConstantsData)不能为空" )
		return SIGen
	end
	SIGen.Extend{ { type = SITypes.category.equipment , name = name } }
	return SIGen
end

function SIGen.NewTypeFuel( name )
	if not currentConstantsData then
		e( "模块构建 : 创建按键时基础信息(ConstantsData)不能为空" )
		return SIGen
	end
	SIGen.Extend{ { type = SITypes.category.fuel , name = name } }
	return SIGen
end

function SIGen.NewTypeModule( name )
	if not currentConstantsData then
		e( "模块构建 : 创建按键时基础信息(ConstantsData)不能为空" )
		return SIGen
	end
	SIGen.Extend{ { type = SITypes.category.module , name = name } }
	return SIGen
end

function SIGen.NewTypeRecipe( name )
	if not currentConstantsData then
		e( "模块构建 : 创建按键时基础信息(ConstantsData)不能为空" )
		return SIGen
	end
	SIGen.Extend{ { type = SITypes.category.recipe , name = name } }
	return SIGen
end

function SIGen.NewTypeResource( name )
	if not currentConstantsData then
		e( "模块构建 : 创建按键时基础信息(ConstantsData)不能为空" )
		return SIGen
	end
	SIGen.Extend{ { type = SITypes.category.resource , name = name } }
	return SIGen
end

function SIGen.NewInput( name , key )
	if not currentConstantsData then
		e( "模块构建 : 创建按键时基础信息(ConstantsData)不能为空" )
		return SIGen
	end
	SIGen.Extend{ { type = SITypes.input , name = SIGen.CreateName( name , SITypes.input ) , key_sequence = key } }
	return SIGen
end

function SIGen.NewAmbientSound( name , trackType , soundOrFile , volume )
	FinishData()
	if not currentConstantsData then
		e( "模块构建 : 创建按键时基础信息(ConstantsData)不能为空" )
		return SIGen
	end
	currentEntityName = SIGen.CreateName( name , SITypes.ambientSound )
	trackType = trackType or SIFlags.trackType.mainTrack
	local sound = {}
	if soundOrFile then
		if type( soundOrFile ) == "table" then sound = soundOrFile
		else sound.filename = soundOrFile end
	else sound.filename = currentConstantsData.soundPath .. name .. ".ogg" end
	if volume then sound.volume = volume end
	SIGen.Extend
	{
		{
			type = SITypes.ambientSound ,
			name = currentEntityName ,
			track_type = trackType ,
			sound = sound
		}
	}
	return SIGen
end

function SIGen.NewFont( name , size , border , border_color , from )
	FinishData()
	if not currentConstantsData then
		e( "模块构建 : 创建按键时基础信息(ConstantsData)不能为空" )
		return SIGen
	end
	currentEntityName = SIGen.CreateName( name , SITypes.font )
	SIGen.Extend
	{
		{
			type = SITypes.font ,
			name = currentEntityName ,
			size = size or 14 ,
			border = border or false ,
			border_color = border and ( border_color or {} ) or nil ,
			from = from or "default"
		}
	}
	return SIGen
end

function SIGen.NewStyle( name , settings )
	FinishData()
	if not currentConstantsData then
		e( "模块构建 : 创建按键时基础信息(ConstantsData)不能为空" )
		return SIGen
	end
	currentEntityName = SIGen.CreateName( name )
	local style = SIGen.GetData( "gui-style" , "default" )
	if style[currentEntityName] then
		e( "模块构建 : 已经存在名为 "..currentEntityName.." 的样式了" )
		return SIGen
	end
	for k , v in pairs( settings ) do
		if k:EndsWith( "graphical_set" ) then
			if settings[k].newGUI then
				settings[k].filename = "__SICoreFunctionLibrary__/zpic/gui/gui.png"
			end
		end
	end
	if settings.autoParent then settings.parent = currentConstantsData.autoName and currentConstantsData.realname..settings.parent or settings.parent end
	style[currentEntityName] = settings
	return SIGen
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 创建实体 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIGen.NewEmpty( type , name , data )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Base:New( type , name , data )
	InitEntity()
	return SIGen
end

function SIGen.NewItem( name , stackSize , item )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Item:New( name , item )
	InitEntity()
	dataList.item[name] = currentEntity:GetName()
	if stackSize then currentEntity:SetStackSize( stackSize ) end
	return SIGen
end

function SIGen.NewCapsule( name , stackSize , capsule )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Capsule:New( name , capsule )
	InitEntity()
	dataList.item[name] = currentEntity:GetName()
	if stackSize then currentEntity:SetStackSize( stackSize ) end
	return SIGen
end

function SIGen.NewModule( name , stackSize , module )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Module:New( name , module )
	InitEntity()
	dataList.item[name] = currentEntity:GetName()
	if stackSize then currentEntity:SetStackSize( stackSize ) end
	return SIGen
end

function SIGen.NewTool( name , stackSize , tool )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Tool:New( name , tool )
	InitEntity()
	dataList.item[name] = currentEntity:GetName()
	if stackSize then currentEntity:SetStackSize( stackSize ) end
	return SIGen
end

function SIGen.NewFluid( name , fluid )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Fluid:New( name , fluid )
	InitEntity()
	dataList.fluid[name] = currentEntity:GetName()
	return SIGen
end

function SIGen.NewEntity( type , name , entity )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Entity:New( type , name , entity )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	return SIGen
end

function SIGen.NewResource( name , resource )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Resource:New( name , resource )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	return SIGen
end

function SIGen.NewProjectile( name , projectile )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Projectile:New( name , projectile )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	return SIGen
end

function SIGen.NewHealthEntity( type , name , healthEntity )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.HealthEntity:New( type , name , healthEntity )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	return SIGen
end

function SIGen.NewUnit( name , unit )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Unit:New( name , unit )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	return SIGen
end

function SIGen.NewSpawner( name , spawner )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Spawner:New( name , spawner )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	return SIGen
end

function SIGen.NewBoiler( name , boiler )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Boiler:New( name , boiler )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	return SIGen
end

function SIGen.NewGenerator( name , generator )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Generator:New( name , generator )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	return SIGen
end

function SIGen.NewBurnerGenerator( name , burnerGenerator )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.BurnerGenerator:New( name , burnerGenerator )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	return SIGen
end

function SIGen.NewPump( name , pump )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Pump:New( name , pump )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	return SIGen
end

function SIGen.NewMining( name , mining )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Mining:New( name , mining )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	return SIGen
end

function SIGen.NewFurnace( name , furnace )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Furnace:New( name , furnace )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	return SIGen
end

function SIGen.NewMachine( name , machine )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Machine:New( name , machine )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	return SIGen
end

function SIGen.NewLab( name , lab )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Lab:New( name , lab )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	return SIGen
end

function SIGen.NewBeacon( name , beacon )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Beacon:New( name , beacon )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	return SIGen
end

function SIGen.NewPipe( name , pipe )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Pipe:New( name , pipe )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	return SIGen
end

function SIGen.NewContainer( name , container )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Container:New( name , container )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	return SIGen
end

function SIGen.NewContainerLogic( name , containerLogic , logisticMode )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.ContainerLogic:New( name , containerLogic )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	if logisticMode then currentEntity:SetLogisticMode( logisticMode ) end
	return SIGen
end

function SIGen.NewContainerLinked( name , containerLinked , linkedMode )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.ContainerLinked:New( name , containerLinked )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	if linkedMode then currentEntity:SetLogisticMode( linkedMode ) end
	return SIGen
end

function SIGen.NewRobot( name , robot )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Robot:New( name , robot )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	return SIGen
end

function SIGen.NewRobotConstruction( name , robotConstruction )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.RobotConstruction:New( name , robotConstruction )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	return SIGen
end

function SIGen.NewRobotLogistic( name , robotLogistic )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.RobotLogistic:New( name , robotLogistic )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	return SIGen
end

function SIGen.NewRobotCombat( name , robotCombat )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.RobotCombat:New( name , robotCombat )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	return SIGen
end

function SIGen.NewRoboport( name , roboport )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Roboport:New( name , roboport )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	return SIGen
end

function SIGen.NewRadar( name , radar )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Radar:New( name , radar )
	InitEntity()
	dataList.entity[name] = currentEntity:GetName()
	return SIGen
end

function SIGen.NewRecipe( name , recipe )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Recipe:New( name , recipe )
	InitEntity()
	return SIGen
end

function SIGen.NewTechnology( name , technology )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.Technology:New( name , technology )
	InitEntity()
	return SIGen
end

function SIGen.NewControlAutoplace( name , controlAutoplace )
	FinishData()
	if not CheckData() then return SIGen end
	currentEntity = SIGen.ControlAutoplace:New( name , controlAutoplace )
	InitEntity()
	return SIGen
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 自动填充 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIGen.AddLastLevel( count )
	currentEntity:AddLastLevel( count )
	return SIGen
end

function SIGen.Fill()
	if not currentEntity then
		e( "模块构建 : 当前没有创建过实体时不能使用 Fill 方法" )
		return SIGen
	end
	if currentEntity:HasFill() then
		e( "模块构建 : 当前实体已经使用过 Fill 方法了" )
		return SIGen
	end
	currentEntity:Fill()
	return SIGen
end

function SIGen.FinishData()
	FinishData()
	return SIGen
end

-- ------------------------------------------------------------------------------------------------
-- -------- 设置实体属性 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIGen.SetLocalisedNames( nameOrListOrPack )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:SetLocalisedNames( nameOrListOrPack )
	return SIGen
end

function SIGen.SetLocalisedDescriptions( descriptionOrListOrPack )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:SetLocalisedDescriptions( descriptionOrListOrPack )
	return SIGen
end

function SIGen.SetCustomData( data )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	if type( data ) == "table" then currentEntity:SetCustomData( data ) end
	return SIGen
end



function SIGen.SetProperties( width , height , health , speed , energyUsage , energySource , inputSlotCount , outputSlotCount )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	if width or height then currentEntity:SetSize( width , height ) end
	if health then currentEntity:SetHealth( health ) end
	if speed then currentEntity:SetSpeed( speed ) end
	if energyUsage or energySource then currentEntity:SetEnergy( energyUsage , energySource ) end
	if inputSlotCount or outputSlotCount then currentEntity:SetSlotCount( inputSlotCount , outputSlotCount ) end
	return SIGen
end

function SIGen.SetSize( width , height )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	if width or height then currentEntity:SetSize( width , height ) end
	return SIGen
end

function SIGen.SetHealth( health , descriptionKey , descriptionValue )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	if health then currentEntity:SetHealth( health , descriptionKey , descriptionValue ) end
	return SIGen
end

function SIGen.SetSpeed( speed )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	if speed then currentEntity:SetSpeed( speed ) end
	return SIGen
end

function SIGen.SetEnergy( energyUsage , energySource )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	if energyUsage or energySource then currentEntity:SetEnergy( energyUsage , energySource ) end
	return SIGen
end

function SIGen.SetSlotCount( inputSlotCount , outputSlotCount )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	if inputSlotCount or outputSlotCount then currentEntity:SetSlotCount( inputSlotCount , outputSlotCount ) end
	return SIGen
end

function SIGen.SetMinable( minable , placeableBy , miningVisualisationTint )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentEntity:SetMinable( minable , placeableBy , miningVisualisationTint )
	return SIGen
end

function SIGen.SetAction( action , radiusColor )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:SetAction( action , radiusColor )
	return SIGen
end

function SIGen.SetEffectRadius( effectRadius , linkRadius , connectRadius )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	if effectRadius or linkRadius or connectRadius then currentEntity:SetEffectRadius( effectRadius , linkRadius , connectRadius ) end
	return SIGen
end

function SIGen.SetEffectEnergy( effectEnergy , linkEnergy , connectEnergy )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	if effectEnergy or linkEnergy or connectEnergy then currentEntity:SetEffectEnergy( effectEnergy , linkEnergy , connectEnergy ) end
	return SIGen
end

function SIGen.SetPluginData( slotCount , iconShift )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	if slotCount or iconShift then currentEntity:SetPluginData( slotCount , iconShift ) end
	return SIGen
end

function SIGen.SetLight( intensity , size , color )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentEntity:SetLight( intensity , size , color )
	return SIGen
end

function SIGen.SetSmoke( smoke )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentEntity:SetSmoke( smoke )
	return SIGen
end

function SIGen.SetCorpse( corpse , explosion , triggerEffect )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	if corpse or explosion or triggerEffect then currentEntity:SetCorpse( corpse , explosion , triggerEffect ) end
	return SIGen
end

function SIGen.SetLevel( level , maxLevel )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	if level or maxLevel then currentEntity:SetLevel( level , maxLevel ) end
	return SIGen
end

function SIGen.SetMainRecipe( recipeOrDataOrEntityOrPack )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentEntity:SetMainRecipe( recipeOrDataOrEntityOrPack )
	return SIGen
end

function SIGen.SetLimitation( limitation , message )
	if not CheckEntityData( SIGen.dataFlags.item ) then return SIGen end
	currentEntity:SetLimitation( limitation , message )
	return SIGen
end

function SIGen.SetLogisticMode( logisticMode )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentEntity:SetLogisticMode( logisticMode )
	return SIGen
end

function SIGen.SetSignalWire( distance , points , sprites , signals )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentEntity:SetSignalWire( distance , points , sprites , signals )
	return SIGen
end

function SIGen.SetEnabled( enabled )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:SetEnabled( enabled )
	return SIGen
end

function SIGen.SetMapColor( mapColor , friendlyMapColor , enemyMapColor )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:SetMapColor( mapColor , friendlyMapColor , enemyMapColor )
	return SIGen
end

function SIGen.SetAutoPlace( autoPlaceSettings , stageCounts )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:SetAutoPlace( autoPlaceSettings , stageCounts )
	return SIGen
end

function SIGen.SetStagesEffectsSettings( effectAnimationPeriod , effectAnimationPeriodDeviation , effectDarknessMultiplier , minEffectAlpha , maxEffectAlpha )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:SetStagesEffectsSettings( effectAnimationPeriod , effectAnimationPeriodDeviation , effectDarknessMultiplier , minEffectAlpha , maxEffectAlpha )
	return SIGen
end



function SIGen.SetFlags( flagOrFlagsOrPack )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:SetFlags( flagOrFlagsOrPack )
	return SIGen
end

function SIGen.AddFlags( flagOrFlagsOrPack )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:AddFlags( flagOrFlagsOrPack )
	return SIGen
end

function SIGen.ClearFlags()
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:ClearFlags()
	return SIGen
end

function SIGen.SetResidences( residenceOrResidencesOrPack )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentEntity:SetResidences( residenceOrResidencesOrPack )
	return SIGen
end

function SIGen.AddResidences( residenceOrResidencesOrPack )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentEntity:AddResidences( residenceOrResidencesOrPack )
	return SIGen
end

function SIGen.ClearResidences()
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentEntity:ClearResidences()
	return SIGen
end

function SIGen.SetTechnologies( technologyOrTechnologiesOrPack )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:SetTechnologies( technologyOrTechnologiesOrPack )
	return SIGen
end

function SIGen.AddTechnologies( technologyOrTechnologiesOrPack )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:AddTechnologies( technologyOrTechnologiesOrPack )
	return SIGen
end

function SIGen.ClearTechnologies()
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:ClearTechnologies()
	return SIGen
end

function SIGen.SetRecipeTypes( typeOrTypesOrPack )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:SetRecipeTypes( typeOrTypesOrPack )
	return SIGen
end

function SIGen.AddRecipeTypes( typeOrTypesOrPack )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:AddRecipeTypes( typeOrTypesOrPack )
	return SIGen
end

function SIGen.ClearRecipeTypes()
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:ClearRecipeTypes()
	return SIGen
end

function SIGen.SetPluginTypes( typeOrTypesOrPack )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:SetPluginTypes( typeOrTypesOrPack )
	return SIGen
end

function SIGen.AddPluginTypes( typeOrTypesOrPack )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:AddPluginTypes( typeOrTypesOrPack )
	return SIGen
end

function SIGen.ClearPluginTypes()
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:ClearPluginTypes()
	return SIGen
end

function SIGen.SetCosts( costOrCostsOrPack , count )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:SetCosts( costOrCostsOrPack , count )
	return SIGen
end

function SIGen.AddCosts( costOrCostsOrPack , count )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:AddCosts( costOrCostsOrPack , count )
	return SIGen
end

function SIGen.ClearCosts()
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:ClearCosts()
	return SIGen
end

function SIGen.SetResults( resultOrResultsOrPack , resultType , count )
	if not CheckEntityData( SIGen.dataFlags.result ) then return SIGen end
	local type = currentEntity:GetType()
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
	currentEntity:SetResults( resultOrResultsOrPack , resultType , count )
	return SIGen
end

function SIGen.AddResults( resultOrResultsOrPack , count )
	if not CheckEntityData( SIGen.dataFlags.result ) then return SIGen end
	currentEntity:AddResults( resultOrResultsOrPack , count )
	return SIGen
end

function SIGen.ClearResults()
	if not CheckEntityData( SIGen.dataFlags.result ) then return SIGen end
	currentEntity:ClearResults()
	return SIGen
end

function SIGen.SetFluidBoxes( areaOrBoxOrListOrPack , connections , baseLevel , productionType , levelHeight , filter , minTemperature , maxTemperature )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentEntity:SetFluidBoxes( areaOrBoxOrListOrPack , connections , baseLevel , productionType , levelHeight , filter , minTemperature , maxTemperature )
	return SIGen
end

function SIGen.AddFluidBoxes( areaOrBoxOrListOrPack , connections , baseLevel , productionType , levelHeight , filter , minTemperature , maxTemperature )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentEntity:AddFluidBoxes( areaOrBoxOrListOrPack , connections , baseLevel , productionType , levelHeight , filter , minTemperature , maxTemperature )
	return SIGen
end

function SIGen.ClearFluidBoxes()
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentEntity:ClearFluidBoxes()
	return SIGen
end



function SIGen.SetRender_notInNetworkIcon( trueOrFalse )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentEntity:SetRender_notInNetworkIcon( trueOrFalse )
	return SIGen
end

function SIGen.SetTreeSettings( treeRemovalProbability , treeRemovalMaxDistance )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentEntity:SetTreeSettings( treeRemovalProbability , treeRemovalMaxDistance )
	return SIGen
end

function SIGen.SetResourceSettings( normalCount , minimumCount , infiniteDepletionAmount , resourcePatchSearchRadius , isInfinite , isHighlight , useMapGrid )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentEntity:SetResourceSettings( normalCount , minimumCount , infiniteDepletionAmount , resourcePatchSearchRadius , isInfinite , isHighlight , useMapGrid )
	return SIGen
end

function SIGen.SetRichness( richness )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentEntity:SetRichness( richness )
	return SIGen
end

function SIGen.SetAcceleration( acceleration , turningSpeedIncreasesExponentiallyWithProjectileSpeed )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentEntity:SetAcceleration( acceleration , turningSpeedIncreasesExponentiallyWithProjectileSpeed )
	return SIGen
end

function SIGen.SetHitCollision( collisionMask , hitAtCollisionPosition )
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentEntity:SetHitCollision( collisionMask , hitAtCollisionPosition )
	return SIGen
end

function SIGen.SetSelfIcon( name )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:SetSelfIcon( name )
	return SIGen
end

function SIGen.AddLastLevel( count )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:AddLastLevel( count )
	return SIGen
end

function SIGen.AddSuperArmor()
	if not CheckEntityData( SIGen.dataFlags.entity ) then return SIGen end
	currentEntity:AddSuperArmor()
	table.insert( superArmorDataList , { currentEntity:GetType() , currentEntity:GetName() } )
	return SIGen
end



function SIGen.FillImage()
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:FillImage()
	return SIGen
end

function SIGen.SetPic( key , layer )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:SetPic( key , layer )
	return SIGen
end

function SIGen.SetSound( key , sound )
	if not CheckEntityData( SIGen.dataFlags.all ) then return SIGen end
	currentEntity:SetSound( key , sound )
	return SIGen
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 快速填充 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIGen.E.SetPictureData( count , hasLight , lightTint )
	if currentEntity.SetPictureData then currentEntity:SetPictureData( count , hasLight , lightTint ) end
	return SIGen
end

function SIGen.E.SetPictureCount( count )
	if currentEntity.SetPictureCount then currentEntity:SetPictureCount( count ) end
	return SIGen
end

function SIGen.E.SetPictureHasLight( hasLight , lightTint )
	if currentEntity.SetPictureHasLight then currentEntity:SetPictureHasLight( hasLight , lightTint ) end
	return SIGen
end



function SIGen.E.SetAddenSize( addenWidth , addenHeight )
	if currentEntity.SetAddenSize then currentEntity:SetAddenSize( addenWidth , addenHeight ) end
	return SIGen
end

function SIGen.E.SetAddenWidth( addenWidth )
	if currentEntity.SetAddenWidth then currentEntity:SetAddenWidth( addenWidth ) end
	return SIGen
end

function SIGen.E.SetAddenWidth( addenWidth )
	if currentEntity.SetAddenWidth then currentEntity:SetAddenWidth( addenWidth ) end
	return SIGen
end

function SIGen.E.SetShadowSize( shadowWidth , shadowHeight )
	if currentEntity.SetShadowSize then currentEntity:SetShadowSize( shadowWidth , shadowHeight ) end
	return SIGen
end

function SIGen.E.SetShadowWidth( shadowWidth )
	if currentEntity.SetShadowWidth then currentEntity:SetShadowWidth( shadowWidth ) end
	return SIGen
end

function SIGen.E.SetShadowHeight( shadowHeight )
	if currentEntity.SetShadowHeight then currentEntity:SetShadowHeight( shadowHeight ) end
	return SIGen
end

function SIGen.E.SetAddenShift( x , y )
	if currentEntity.SetAddenShift then currentEntity:SetAddenShift( x , y ) end
	return SIGen
end

function SIGen.E.SetAddenShiftX( x )
	if currentEntity.SetAddenShiftX then currentEntity:SetAddenShiftX( x ) end
	return SIGen
end

function SIGen.E.SetAddenShiftY( y )
	if currentEntity.SetAddenShiftY then currentEntity:SetAddenShiftY( y ) end
	return SIGen
end

function SIGen.E.SetShadowShift( x , y )
	if currentEntity.SetShadowShift then currentEntity:SetShadowShift( x , y ) end
	return SIGen
end

function SIGen.E.SetShadowShiftX( x )
	if currentEntity.SetShadowShiftX then currentEntity:SetShadowShiftX( x ) end
	return SIGen
end

function SIGen.E.SetShadowShiftY( y )
	if currentEntity.SetShadowShiftY then currentEntity:SetShadowShiftY( y ) end
	return SIGen
end

function SIGen.E.SetScale( scale )
	if currentEntity.SetScale then currentEntity:SetScale( scale ) end
	return SIGen
end

function SIGen.E.SetHasHr( hasHr )
	if currentEntity.SetHasHr then currentEntity:SetHasHr( hasHr ) end
	return SIGen
end

function SIGen.E.SetAnimShadow( animShadow )
	if currentEntity.SetAnimShadow then currentEntity:SetAnimShadow( animShadow ) end
	return SIGen
end

function SIGen.E.SetPatchLocation( x , y )
	if currentEntity.SetPatchLocation then currentEntity:SetPatchLocation( x , y ) end
	return SIGen
end

function SIGen.E.SetWaterLocation( x , y )
	if currentEntity.SetWaterLocation then currentEntity:SetWaterLocation( x , y ) end
	return SIGen
end

function SIGen.E.SetCanGlow( canGlow )
	if currentEntity.SetCanGlow then currentEntity:SetCanGlow( canGlow ) end
	return SIGen
end

function SIGen.E.SetItemStackSize( itemStackSize )
	if currentEntity.SetStackSize then currentEntity:SetStackSize( itemStackSize ) end
	return SIGen
end

function SIGen.E.SetItemFlags( flagOrFlagsOrPack )
	if currentEntity.SetItemFlags then currentEntity:SetItemFlags( flagOrFlagsOrPack ) end
	return SIGen
end

function SIGen.E.AddItemFlags( flagOrFlagsOrPack )
	if currentEntity.AddItemFlags then currentEntity:AddItemFlags( flagOrFlagsOrPack ) end
	return SIGen
end

function SIGen.E.ClearItemFlags()
	if currentEntity.ClearItemFlags then currentEntity:ClearItemFlags() end
	return SIGen
end

function SIGen.E.SetItemName( itemName )
	if currentEntity.SetItemName then currentEntity:SetItemName( itemName ) end
	return SIGen
end

function SIGen.E.SetItem( item )
	if currentEntity.SetItem then currentEntity:SetItem( item ) end
	return SIGen
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 最终构建 ---------- ( 此处方法均为为自动调用 , 不能手动调用 ) -----------------------
-- ------------------------------------------------------------------------------------------------

function SIGen.F1.AutoFill()
	if #autoFillDataList > 0 then
		for index , data in pairs( autoFillDataList ) do
			if type( data ) == "table" then AutoFillWithTable( data ) end
		end
		autoFillDataList = {}
	end
end

function SIGen.F2.CreateArmor()
	if #superArmorDataList > 0 then
		local resistances = SIPackers.ResistancesWithDamageTypes( SIGen.GetList( SITypes.damageType ) , 35 , 98 )
		for i , settings in pairs( superArmorDataList ) do
			local data = SIGen.GetData( settings[1] , settings[2] )
			data.max_health = data.max_health * 100
			data.resistances = resistances
		end
	end
end