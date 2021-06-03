-- ------------------------------------------------------------------------------------------------
-- ---------- 添加引用 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if not SIEventBus then e( "模块使用[SIUnlocker] : 必须启用 SIEventBus 之后才能使用 SIUnlocker 模块" ) end
if not SIGlobal then e( "模块使用[SIUnlocker] : 必须启用 SIGlobal 之后才能使用 SIUnlocker 模块" ) end

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

Implement_SIUnlocker =
{
	defaultForceData =
	{
		canTrigger = true ,
		eventList = {} ,
		arguments =
		{
			speedCrafting = 0 ,
			speedMining   = 0 ,
			speedRunning  = 0
		}
	}
}

Implement_SIUnlocker.eventMap =
{
	[SIUnlocker.condition.kill]     = SIEvents.on_entity_died ,
	[SIUnlocker.condition.has]      = SIEvents.on_player_main_inventory_changed ,
	[SIUnlocker.condition.craft]    = SIEvents.on_player_crafted_item ,
	[SIUnlocker.condition.research] = SIEvents.on_research_finished ,
	[SIUnlocker.condition.build]    = SIEvents.on_built_entity ,
	[SIUnlocker.condition.mine]     = SIEvents.on_player_mined_entity ,
	[SIUnlocker.condition.use]      = SIEvents.on_player_used_capsule ,
	[SIUnlocker.condition.mute]     = SIEvents.on_player_muted ,
	[SIUnlocker.condition.die]      = SIEvents.on_player_died
}

SIGlobal.Create( "SIUnlockerItems" )
SIGlobal.Create( "SIUnlockerForceData" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 项目操作 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function Implement_SIUnlocker.AddItem( item )
	if not item or not item.id then
		e( "解锁器[SIUnlocker] : 项目或项目 id 不能为空" )
		return false
	end
	if item.conditions then
		local conditions = {}
		for index , condition in pairs( item.conditions ) do
			if table.Has( SIUnlocker.condition , condition.type ) then table.insert( conditions , condition ) end
		end
		item.conditions = conditions
	end
	if not item.conditions or table.Size( item.conditions ) < 1 then
		e( "解锁器[SIUnlocker] : 项目必须包含有效的触发条件" )
		return false
	end
	if item.results then
		local results = {}
		for index , result in pairs( item.results ) do
			if table.Has( SIUnlocker.result , result.type ) then table.insert( results , result ) end
		end
		item.results = results
	end
	if not item.results or table.Size( item.results ) < 1 then
		e( "解锁器[SIUnlocker] : 项目必须包含有效的回报内容" )
		return false
	end
	-- 自动填充属性
	item = table.deepcopy( item )
	if not item.name then item.name = { "SI-name."..item.id }
	elseif type( item.name ) ~= "table" then item.name = { "SI-name."..item.name } end
	if not item.description then item.description = { "SI-description."..item.id }
	elseif type( item.description ) ~= "table" then item.description = { "SI-description."..item.description } end
	-- 添加到现有项目列表和阵营数据中
	local oldItem = SIUnlockerItems[item.id]
	if not oldItem or oldItem.version ~= item.version then
		if oldItem then Implement_SIUnlocker.RemoveOldItemFromForceData( oldItem ) end
		SIUnlockerItems[item.id] = item
		Implement_SIUnlocker.AddNewItemToForceData( item )
	end
	return true
end

function Implement_SIUnlocker.RestoreForceData( forceName )
	local forceData = Implement_SIUnlocker.GetForceData( forceName )
	Implement_SIUnlocker.InitForceData( forceData )
	return true
end

function Implement_SIUnlocker.GetForceDataReadonly( forceName )
	return table.deepcopy( Implement_SIUnlocker.GetForceData( forceName ) )
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 功能方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function Implement_SIUnlocker.GetForceData( forceName )
	local forceData = SIUnlockerForceData[forceName]
	if not forceData then
		forceData = table.deepcopy( Implement_SIUnlocker.defaultForceData )
		SIUnlockerForceData[forceName] = forceData
		Implement_SIUnlocker.InitForceData( forceData )
	end
	return forceData
end

function Implement_SIUnlocker.InitForceData( forceData )
	for id , item in pairs( table.deepcopy( SIUnlockerItems ) ) do
		Implement_SIUnlocker.AddItemToForceData( forceData , item )
	end
end

function Implement_SIUnlocker.AddNewItemToForceData( item )
	for name , forceData in pairs( SIUnlockerForceData ) do
		Implement_SIUnlocker.AddItemToForceData( forceData , table.deepcopy( item ) )
	end
end

function Implement_SIUnlocker.RemoveOldItemFromForceData( item )
	for name , data in pairs( SIUnlockerForceData ) do
		Implement_SIUnlocker.RemoveItemFromForceData( forceData , item )
	end
end



function Implement_SIUnlocker.AddItemToForceData( forceData , item )
	for index , condition in pairs( SIUnlockerItems[item.id].conditions ) do
		local list = forceData.eventList[Implement_SIUnlocker.eventMap[condition.type]]
		if not list then
			list = {}
			forceData.eventList[Implement_SIUnlocker.eventMap[condition.type]] = list
		end
		list[item.id] = item
	end
end

function Implement_SIUnlocker.RemoveItemFromForceData( forceData , item )
	for index , condition in pairs( SIUnlockerItems[item.id].conditions ) do
		local list = forceData.eventList[Implement_SIUnlocker.eventMap[condition.type]]
		list[item.id] = nil
		if table.Size( list ) < 1 then forceData.eventList[Implement_SIUnlocker.eventMap[condition.type]] = nil end
	end
end

function Implement_SIUnlocker.FireItem( forceData , item , force , player )
	Implement_SIUnlocker.RemoveItemFromForceData( forceData , item )
	for index , result in pairs( item.results ) do
		-- 解锁配方
		if result.type == SIUnlocker.result.addRecipe then
			local recipe = force.recipes[result.name]
			if not recipe.enabled then
				recipe.enabled = true
				for index , player in pairs( force.players ) do player.add_recipe_notification( recipe.name ) end
			end
		elseif result.type == SIUnlocker.result.removeRecipe then force.recipes[result.name].enabled = false
		-- 添加物品
		elseif result.type == SIUnlocker.result.addItem then
			if player then
				local totalInsert = player.get_main_inventory().insert{ name = result.name , count = result.count }
				if totalInsert < result.count then player.surface.spill_item_stack( player.position , { name = result.name , count = result.count-totalInsert } , true , player.force , true ) end
			end
		elseif result.type == SIUnlocker.result.removeItem then
			if player then player.get_main_inventory().remove{ name = result.name , count = result.count } end
		elseif result.type == SIUnlocker.result.clearItem then
			if player then
				local inventory = player.get_main_inventory()
				inventory.remove{ name = result.name , count = inventory.get_item_count( result.name ) }
			end
		-- 速度设置
		elseif result.type == SIUnlocker.result.addSpeedCrafting then
			force.manual_crafting_speed_modifier = force.manual_crafting_speed_modifier + result.value
			forceData.arguments.speedCrafting = forceData.arguments.speedCrafting + result.value
		elseif result.type == SIUnlocker.result.remSpeedCrafting then
			force.manual_crafting_speed_modifier = force.manual_crafting_speed_modifier - result.value
			forceData.arguments.speedCrafting = forceData.arguments.speedCrafting - result.value
		elseif result.type == SIUnlocker.result.setSpeedCrafting then
			force.manual_crafting_speed_modifier = force.manual_crafting_speed_modifier - forceData.arguments.speedCrafting + result.value
			forceData.arguments.speedCrafting = result.value
		elseif result.type == SIUnlocker.result.addSpeedMining then
			force.manual_mining_speed_modifier = force.manual_mining_speed_modifier + result.value
			forceData.arguments.speedMining = forceData.arguments.speedMining + result.value
		elseif result.type == SIUnlocker.result.remSpeedMining then
			force.manual_mining_speed_modifier = force.manual_mining_speed_modifier - result.value
			forceData.arguments.speedMining = forceData.arguments.speedMining - result.value
		elseif result.type == SIUnlocker.result.setSpeedMining then
			orce.manual_mining_speed_modifier = force.manual_mining_speed_modifier - forceData.arguments.speedMining + result.value
			forceData.arguments.speedMining = result.value
		elseif result.type == SIUnlocker.result.addSpeedRunning then
			force.character_running_speed_modifier = force.character_running_speed_modifier + result.value
			forceData.arguments.speedRunning = forceData.arguments.speedRunning + result.value
		elseif result.type == SIUnlocker.result.remSpeedRunning then
			force.character_running_speed_modifier = force.character_running_speed_modifier - result.value
			forceData.arguments.speedRunning = forceData.arguments.speedRunning - result.value
		elseif result.type == SIUnlocker.result.setSpeedRunning then
			force.character_running_speed_modifier = force.character_running_speed_modifier - forceData.arguments.speedRunning + result.value
			forceData.arguments.speedRunning = result.value
		-- 发送消息
		elseif result.type == SIUnlocker.result.messageForce then
			if result.sendToTrigger then force.print( result.message )
			else
				if player then
					for index , forcePlayer in pairs( force.players ) do
						if forcePlayer.index ~= player.index then forcePlayer.print( result.message ) end
					end
				else force.print( result.message ) end
			end
		elseif result.type == SIUnlocker.result.messagePlayer then
			if player then player.print( result.message ) end
		end
	end
	if item.repeatSettings then
		local count = item.repeatCount or 1
		local maxCount = item.repeatSettings.maxCount or 0
		if maxCount < 0 or count < maxCount then
			local newItem = table.deepcopy( SIUnlockerItems[item.id] )
			newItem.repeatCount = count + 1
			Implement_SIUnlocker.AddItemToForceData( forceData , newItem )
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function Implement_SIUnlocker.OnKill( event )
	local cause = event.cause
	if cause and cause.valid and cause.type == SITypes.entity.character and cause.player then
		local entity = event.entity
		if entity and entity.valid then
			local name = entity.name
			local damageType = event.damage_type
			local player = cause.player
			local force = player.force
			local forceData = Implement_SIUnlocker.GetForceData( force.name )
			if forceData.eventList[event.name] then
				for id , item in pairs( forceData.eventList[event.name] ) do
					for index , condition in pairs( item.conditions ) do
						if condition.type == SIUnlocker.condition.kill and condition.name == name then
							if condition.damageType and condition.damageType == damageType or not condition.damageType then
								if not condition.cur then condition.cur = 1
								else condition.cur = condition.cur + 1 end
								if condition.cur >= condition.count then item.conditions[index] = nil end
							end
						end
					end
					if table.Size( item.conditions ) < 1 then Implement_SIUnlocker.FireItem( forceData , item , force , player ) end
					if not forceData.eventList[event.name] then break end
				end
			end
		end
	end
end

function Implement_SIUnlocker.OnHas( event )
	local player = game.get_player( event.player_index )
	local inventory = player.get_main_inventory()
	if inventory then
		local force = player.force
		local forceData = Implement_SIUnlocker.GetForceData( force.name )
		if forceData.eventList[event.name] then
			for id , item in pairs( forceData.eventList[event.name] ) do
				for index , condition in pairs( item.conditions ) do
					if condition.type == SIUnlocker.condition.has and condition.count <= inventory.get_item_count( condition.name ) then item.conditions[index] = nil end
				end
				if table.Size( item.conditions ) < 1 then Implement_SIUnlocker.FireItem( forceData , item , force , player ) end
				if not forceData.eventList[event.name] then break end
			end
		end
	end
end

function Implement_SIUnlocker.OnCraft( event )
	local name = event.recipe.name
	local player = game.get_player( event.player_index )
	local force = player.force
	local forceData = Implement_SIUnlocker.GetForceData( force.name )
	if forceData.eventList[event.name] then
		for id , item in pairs( forceData.eventList[event.name] ) do
			for index , condition in pairs( item.conditions ) do
				if condition.type == SIUnlocker.condition.craft and condition.name == name then
					if not condition.cur then condition.cur = 1
					else condition.cur = condition.cur + 1 end
					if condition.cur >= condition.count then item.conditions[index] = nil end
				end
			end
			if table.Size( item.conditions ) < 1 then Implement_SIUnlocker.FireItem( forceData , item , force , player ) end
			if not forceData.eventList[event.name] then break end
		end
	end
end

function Implement_SIUnlocker.OnResearch( event )
	local tech = event.research
	local name = tech.name
	local hasLevel = tech.upgrade
	local level = tech.level
	local force = tech.force
	local forceData = Implement_SIUnlocker.GetForceData( force.name )
	if forceData.eventList[event.name] then
		for id , item in pairs( forceData.eventList[event.name] ) do
			for index , condition in pairs( item.conditions ) do
				if condition.type == SIUnlocker.condition.research and condition.name == name then
					if hasLevel then
						if condition.level <= level then item.conditions[index] = nil end
					else item.conditions[index] = nil end
				end
			end
			if table.Size( item.conditions ) < 1 then Implement_SIUnlocker.FireItem( forceData , item , force ) end
			if not forceData.eventList[event.name] then break end
		end
	end
end

function Implement_SIUnlocker.OnBuild( event )
	local entity = event.created_entity
	if entity and entity.valid then
		local name = entity.name
		local player = game.get_player( event.player_index )
		local force = player.force
		local forceData = Implement_SIUnlocker.GetForceData( force.name )
		if forceData.eventList[event.name] then
			for id , item in pairs( forceData.eventList[event.name] ) do
				for index , condition in pairs( item.conditions ) do
					if condition.type == SIUnlocker.condition.build and condition.name == name then
						if not condition.cur then condition.cur = 1
						else condition.cur = condition.cur + 1 end
						if condition.cur >= condition.count then item.conditions[index] = nil end
					end
				end
				if table.Size( item.conditions ) < 1 then Implement_SIUnlocker.FireItem( forceData , item , force , player ) end
				if not forceData.eventList[event.name] then break end
			end
		end
	end
end

function Implement_SIUnlocker.OnMine( event )
	local entity = event.entity
	if entity and entity.valid then
		local name = entity.name
		local player = game.get_player( event.player_index )
		local force = player.force
		local forceData = Implement_SIUnlocker.GetForceData( force.name )
		if forceData.eventList[event.name] then
			for id , item in pairs( forceData.eventList[event.name] ) do
				for index , condition in pairs( item.conditions ) do
					if condition.type == SIUnlocker.condition.mine and condition.name == name then
						if not condition.cur then condition.cur = 1
						else condition.cur = condition.cur + 1 end
						if condition.cur >= condition.count then item.conditions[index] = nil end
					end
				end
				if table.Size( item.conditions ) < 1 then Implement_SIUnlocker.FireItem( forceData , item , force , player ) end
				if not forceData.eventList[event.name] then break end
			end
		end
	end
end

function Implement_SIUnlocker.OnUse( event )
	local name = event.item.name
	local player = game.get_player( event.player_index )
	local force = player.force
	local forceData = Implement_SIUnlocker.GetForceData( force.name )
	if forceData.eventList[event.name] then
		for id , item in pairs( forceData.eventList[event.name] ) do
			for index , condition in pairs( item.conditions ) do
				if condition.type == SIUnlocker.condition.use and condition.name == name then
					if not condition.cur then condition.cur = 1
					else condition.cur = condition.cur + 1 end
					if condition.cur >= condition.count then item.conditions[index] = nil end
				end
			end
			if table.Size( item.conditions ) < 1 then Implement_SIUnlocker.FireItem( forceData , item , force , player ) end
			if not forceData.eventList[event.name] then break end
		end
	end
end

function Implement_SIUnlocker.OnMute( event )
	local player = game.get_player( event.player_index )
	local force = player.force
	local forceData = Implement_SIUnlocker.GetForceData( force.name )
	if forceData.eventList[event.name] then
		for id , item in pairs( forceData.eventList[event.name] ) do
			for index , condition in pairs( item.conditions ) do
				if condition.type == SIUnlocker.condition.mute then item.conditions[index] = nil end
			end
			if table.Size( item.conditions ) < 1 then Implement_SIUnlocker.FireItem( forceData , item , force , player ) end
			if not forceData.eventList[event.name] then break end
		end
	end
end

function Implement_SIUnlocker.OnDie( event )
	local entity = event.cause
	if entity and entity.valid then
		local name = entity.name
		local player = game.get_player( event.player_index )
		local force = player.force
		local forceData = Implement_SIUnlocker.GetForceData( force.name )
		if forceData.eventList[event.name] then
			for id , item in pairs( forceData.eventList[event.name] ) do
				for index , condition in pairs( item.conditions ) do
					if condition.type == SIUnlocker.condition.die and condition.name == name then
						if not condition.cur then condition.cur = 1
						else condition.cur = condition.cur + 1 end
						if condition.cur >= condition.count then item.conditions[index] = nil end
					end
				end
				if table.Size( item.conditions ) < 1 then Implement_SIUnlocker.FireItem( forceData , item , force , player ) end
				if not forceData.eventList[event.name] then break end
			end
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 事件注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus
.Add( Implement_SIUnlocker.eventMap[SIUnlocker.condition.kill]     , Implement_SIUnlocker.OnKill )
.Add( Implement_SIUnlocker.eventMap[SIUnlocker.condition.has]      , Implement_SIUnlocker.OnHas )
.Add( Implement_SIUnlocker.eventMap[SIUnlocker.condition.craft]    , Implement_SIUnlocker.OnCraft )
.Add( Implement_SIUnlocker.eventMap[SIUnlocker.condition.research] , Implement_SIUnlocker.OnResearch )
.Add( Implement_SIUnlocker.eventMap[SIUnlocker.condition.build]    , Implement_SIUnlocker.OnBuild )
.Add( Implement_SIUnlocker.eventMap[SIUnlocker.condition.mine]     , Implement_SIUnlocker.OnMine )
.Add( Implement_SIUnlocker.eventMap[SIUnlocker.condition.use]      , Implement_SIUnlocker.OnUse )
.Add( Implement_SIUnlocker.eventMap[SIUnlocker.condition.mute]     , Implement_SIUnlocker.OnMute )
.Add( Implement_SIUnlocker.eventMap[SIUnlocker.condition.die]      , Implement_SIUnlocker.OnDie )

remote.add_interface( SIUnlocker.interfaceId ,
{
	[SIUnlocker.remoteKey.AddItem]          = Implement_SIUnlocker.AddItem ,
	[SIUnlocker.remoteKey.RestoreForceData] = Implement_SIUnlocker.RestoreForceData ,
	[SIUnlocker.remoteKey.GetForceData]     = Implement_SIUnlocker.GetForceDataReadonly
} )