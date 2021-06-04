-- ------------------------------------------------------------------------------------------------
-- ---------- 添加引用 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if not SIEventBus then e( "构建器启用[SIUnlocker] : 必须启用 SIEventBus 模块之后才能使用 SIUnlocker 构建器" ) end
if not SIUnlocker then e( "构建器启用[SIUnlocker] : 必须启用 SIUnlocker 接口之后才能使用 SIUnlocker 构建器" ) end

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIUnlocker.itemList = {}
SIUnlocker.itemData = nil
SIUnlocker.defaultCount = 1
SIUnlocker.defaultLevel = 1

-- ------------------------------------------------------------------------------------------------
-- ---------- 功能方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIUnlocker.AppendItem( item )
	SIUnlocker.itemList[item.id] = item
	return SIUnlocker
end

-- ------------------------------------------------------------------------------------------------
-- --------- 构造器方法 ---------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIUnlocker.Get()
	return SIUnlocker.itemData
end

function SIUnlocker.Copy()
	return table.deepcopy( SIUnlocker.itemData )
end

function SIUnlocker.Finish()
	if SIUnlocker.itemData then
		SIUnlocker.AppendItem( SIUnlocker.itemData )
		SIUnlocker.itemData = nil
	end
	return SIUnlocker
end

function SIUnlocker.NewItem( id , version )
	SIUnlocker.Finish()
	SIUnlocker.itemData =
	{
		id = id ,
		version = version
	}
	return SIUnlocker
end

function SIUnlocker.SetIcon( iconPath )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 SetIcon 方法" )
		return SIUnlocker
	end
	SIUnlocker.itemData.icon = iconPath
	return SIUnlocker
end

function SIUnlocker.SetName( nameLocalisedString )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 SetName 方法" )
		return SIUnlocker
	end
	SIUnlocker.itemData.name = nameLocalisedString
	return SIUnlocker
end

function SIUnlocker.SetDescription( descriptionLocalisedString )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 SetIcon 方法" )
		return SIUnlocker
	end
	SIUnlocker.itemData.description = descriptionLocalisedString
	return SIUnlocker
end



function SIUnlocker.AddCondition( condition )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddCondition 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.conditions then SIUnlocker.itemData.conditions = {} end
	table.insert( SIUnlocker.itemData.conditions , condition )
	return SIUnlocker
end

function SIUnlocker.AddCondition_Kill( entityName , count , damageType )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddCondition_Kill 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.conditions then SIUnlocker.itemData.conditions = {} end
	table.insert( SIUnlocker.itemData.conditions ,
	{
		type = SIUnlocker.condition.kill ,
		name = entityName ,
		count = count or SIUnlocker.defaultCount ,
		damageType = damageType
	} )
	return SIUnlocker
end

function SIUnlocker.AddCondition_Has( itemName , count )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddCondition_Has 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.conditions then SIUnlocker.itemData.conditions = {} end
	table.insert( SIUnlocker.itemData.conditions ,
	{
		type = SIUnlocker.condition.has ,
		name = itemName ,
		count = count or SIUnlocker.defaultCount
	} )
	return SIUnlocker
end

function SIUnlocker.AddCondition_Craft( recipeName , count )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddCondition_Craft 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.conditions then SIUnlocker.itemData.conditions = {} end
	table.insert( SIUnlocker.itemData.conditions ,
	{
		type = SIUnlocker.condition.craft ,
		name = recipeName ,
		count = count or SIUnlocker.defaultCount
	} )
	return SIUnlocker
end

function SIUnlocker.AddCondition_Research( technologyName , level )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddCondition_Research 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.conditions then SIUnlocker.itemData.conditions = {} end
	table.insert( SIUnlocker.itemData.conditions ,
	{
		type = SIUnlocker.condition.research ,
		name = technologyName ,
		level = level or SIUnlocker.defaultLevel
	} )
	return SIUnlocker
end

function SIUnlocker.AddCondition_Build( entityName , count )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddCondition_Build 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.conditions then SIUnlocker.itemData.conditions = {} end
	table.insert( SIUnlocker.itemData.conditions ,
	{
		type = SIUnlocker.condition.build ,
		name = entityName ,
		count = count or SIUnlocker.defaultCount
	} )
	return SIUnlocker
end

function SIUnlocker.AddCondition_Mine( entityName , count )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddCondition_Mine 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.conditions then SIUnlocker.itemData.conditions = {} end
	table.insert( SIUnlocker.itemData.conditions ,
	{
		type = SIUnlocker.condition.mine ,
		name = entityName ,
		count = count or SIUnlocker.defaultCount
	} )
	return SIUnlocker
end

function SIUnlocker.AddCondition_Use( itemName , count )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddCondition_Use 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.conditions then SIUnlocker.itemData.conditions = {} end
	table.insert( SIUnlocker.itemData.conditions ,
	{
		type = SIUnlocker.condition.use ,
		name = itemName ,
		count = count or SIUnlocker.defaultCount
	} )
	return SIUnlocker
end

function SIUnlocker.AddCondition_Mute()
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddCondition_Mute 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.conditions then SIUnlocker.itemData.conditions = {} end
	table.insert( SIUnlocker.itemData.conditions , { type = SIUnlocker.condition.mute } )
	return SIUnlocker
end

function SIUnlocker.AddCondition_Die( sourceEntityName , count )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddCondition_Die 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.conditions then SIUnlocker.itemData.conditions = {} end
	table.insert( SIUnlocker.itemData.conditions ,
	{
		type = SIUnlocker.condition.die ,
		name = sourceEntityName ,
		count = count or SIUnlocker.defaultCount
	} )
	return SIUnlocker
end



function SIUnlocker.AddResult( result )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddResult 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.results then SIUnlocker.itemData.results = {} end
	table.insert( SIUnlocker.itemData.results , result )
	return SIUnlocker
end

function SIUnlocker.AddResult_AddRecipe( recipeName )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddResult_AddRecipe 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.results then SIUnlocker.itemData.results = {} end
	table.insert( SIUnlocker.itemData.results ,
	{
		type = SIUnlocker.result.addRecipe ,
		name = recipeName
	} )
	return SIUnlocker
end

function SIUnlocker.AddResult_RemoveRecipe( recipeName )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddResult_RemoveRecipe 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.results then SIUnlocker.itemData.results = {} end
	table.insert( SIUnlocker.itemData.results ,
	{
		type = SIUnlocker.result.removeRecipe ,
		name = recipeName
	} )
	return SIUnlocker
end

function SIUnlocker.AddResult_AddItem( itemName , count )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddResult_AddItem 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.results then SIUnlocker.itemData.results = {} end
	table.insert( SIUnlocker.itemData.results ,
	{
		type = SIUnlocker.result.addItem ,
		name = itemName ,
		count = count or SIUnlocker.defaultCount
	} )
	return SIUnlocker
end

function SIUnlocker.AddResult_RemoveItem( itemName , count )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddResult_RemoveItem 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.results then SIUnlocker.itemData.results = {} end
	table.insert( SIUnlocker.itemData.results ,
	{
		type = SIUnlocker.result.removeItem ,
		name = itemName ,
		count = count or SIUnlocker.defaultCount
	} )
	return SIUnlocker
end

function SIUnlocker.AddResult_ClearItem( itemName )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddResult_ClearItem 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.results then SIUnlocker.itemData.results = {} end
	table.insert( SIUnlocker.itemData.results ,
	{
		type = SIUnlocker.result.clearItem ,
		name = itemName
	} )
	return SIUnlocker
end

function SIUnlocker.AddResult_AddSpeedCrafting( value )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddResult_AddSpeedCrafting 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.results then SIUnlocker.itemData.results = {} end
	table.insert( SIUnlocker.itemData.results ,
	{
		type = SIUnlocker.result.addSpeedCrafting ,
		value = value
	} )
	return SIUnlocker
end

function SIUnlocker.AddResult_RemoveSpeedCrafting( value )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddResult_RemoveSpeedCrafting 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.results then SIUnlocker.itemData.results = {} end
	table.insert( SIUnlocker.itemData.results ,
	{
		type = SIUnlocker.result.removeSpeedCrafting ,
		value = value
	} )
	return SIUnlocker
end

function SIUnlocker.AddResult_SetSpeedCrafting( value )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddResult_SetSpeedCrafting 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.results then SIUnlocker.itemData.results = {} end
	table.insert( SIUnlocker.itemData.results ,
	{
		type = SIUnlocker.result.setSpeedCrafting ,
		value = value
	} )
	return SIUnlocker
end

function SIUnlocker.AddResult_AddSpeedMining( value )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddResult_AddSpeedMining 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.results then SIUnlocker.itemData.results = {} end
	table.insert( SIUnlocker.itemData.results ,
	{
		type = SIUnlocker.result.addSpeedMining ,
		value = value
	} )
	return SIUnlocker
end

function SIUnlocker.AddResult_RemoveSpeedMining( value )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddResult_RemoveSpeedMining 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.results then SIUnlocker.itemData.results = {} end
	table.insert( SIUnlocker.itemData.results ,
	{
		type = SIUnlocker.result.removeSpeedMining ,
		value = value
	} )
	return SIUnlocker
end

function SIUnlocker.AddResult_SetSpeedMining( value )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddResult_SetSpeedMining 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.results then SIUnlocker.itemData.results = {} end
	table.insert( SIUnlocker.itemData.results ,
	{
		type = SIUnlocker.result.setSpeedMining ,
		value = value
	} )
	return SIUnlocker
end

function SIUnlocker.AddResult_AddSpeedRunning( value )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddResult_AddSpeedRunning 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.results then SIUnlocker.itemData.results = {} end
	table.insert( SIUnlocker.itemData.results ,
	{
		type = SIUnlocker.result.addSpeedRunning ,
		value = value
	} )
	return SIUnlocker
end

function SIUnlocker.AddResult_RemoveSpeedRunning( value )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddResult_RemoveSpeedRunning 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.results then SIUnlocker.itemData.results = {} end
	table.insert( SIUnlocker.itemData.results ,
	{
		type = SIUnlocker.result.removeSpeedRunning ,
		value = value
	} )
	return SIUnlocker
end

function SIUnlocker.AddResult_SetSpeedRunning( value )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddResult_SetSpeedRunning 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.results then SIUnlocker.itemData.results = {} end
	table.insert( SIUnlocker.itemData.results ,
	{
		type = SIUnlocker.result.setSpeedRunning ,
		value = value
	} )
	return SIUnlocker
end

function SIUnlocker.AddResult_MessageForce( message , sendToTrigger )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddResult_MessageForce 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.results then SIUnlocker.itemData.results = {} end
	table.insert( SIUnlocker.itemData.results ,
	{
		type = SIUnlocker.result.messageForce ,
		message = message ,
		sendToTrigger = sendToTrigger
	} )
	return SIUnlocker
end

function SIUnlocker.AddResult_MessagePlayer( message )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddResult_MessagePlayer 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.results then SIUnlocker.itemData.results = {} end
	table.insert( SIUnlocker.itemData.results ,
	{
		type = SIUnlocker.result.messagePlayer ,
		message = message
	} )
	return SIUnlocker
end

function SIUnlocker.AddResult_TriggerInterface( interfaceId , functionId , params )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 AddResult_TriggerInterface 方法" )
		return SIUnlocker
	end
	if not SIUnlocker.itemData.results then SIUnlocker.itemData.results = {} end
	table.insert( SIUnlocker.itemData.results ,
	{
		type = SIUnlocker.result.triggerInterface ,
		interfaceId = interfaceId ,
		functionId = functionId ,
		params = params
	} )
	return SIUnlocker
end



function SIUnlocker.SetRepeatSettings( maxCount )
	if not SIUnlocker.itemData then
		e( "模块构建[SIUnlocker] : 当前没有创建过项目时不能使用 SetRepeatSettings 方法" )
		return SIUnlocker
	end
	SIUnlocker.itemData.repeatSettings = { maxCount = maxCount }
	return SIUnlocker
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIUnlocker.OnInit()
	for id , item in pairs( SIUnlocker.itemList ) do
		if not SIUnlocker.AddItem( item ) then
			e( "模块构建[SIUnlocker] : 添加项目到 SIUnlocker 接口失败" )
			break
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 事件注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus.Init( SIUnlocker.OnInit )