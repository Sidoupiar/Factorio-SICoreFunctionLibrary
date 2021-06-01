-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- list 内的元素结构
-- eventId =
-- {
--   isSet = bool ,
--   funcs = { { id = idString , func = function } }
-- }
SIEventBus =
{
	order = 1 ,
	init = 
	{
		notAdd = true ,
		funcs = {}
	} ,
	load =
	{
		notAdd = true ,
		funcs = {}
	} ,
	wait =
	{
		funcs = {} ,
		listener = {}
	}  ,
	nth = {} ,
	list = {}
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 事件操作 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIEventBus.Init( func , id )
	if not func then
		e( "事件总线[SIEventBus] : 不能添加空的初始化方法" )
		return SIEventBus
	end
	if not id then
		id = SIEventBus.order
		SIEventBus.order = SIEventBus.order + 1
	end
	table.insert( SIEventBus.init.funcs , { id = id , func = func } )
	if SIEventBus.init.notAdd then
		SIEventBus.init.notAdd = false
		local baseFunc = function()
			for index , funcData in pairs( SIEventBus.init.funcs ) do funcData.func( funcData.id ) end
		end
		script.on_init( baseFunc )
		script.on_configuration_changed( baseFunc )
	end
	return SIEventBus
end

function SIEventBus.Load( func , id )
	if not func then
		e( "事件总线[SIEventBus] : 不能添加空的载入存档方法" )
		return SIEventBus
	end
	if not id then
		id = SIEventBus.order
		SIEventBus.order = SIEventBus.order + 1
	end
	table.insert( SIEventBus.load.funcs , { id = id , func = func } )
	if SIEventBus.load.notAdd then
		SIEventBus.load.notAdd = false
		script.on_load( function()
			for index , funcData in pairs( SIEventBus.load.funcs ) do funcData.func( funcData.id ) end
		end )
	end
	return SIEventBus
end

function SIEventBus.AddWaitFunction( id , func )
	if not func then
		e( "事件总线[SIEventBus] : 不能添加空的缓执行方法" )
		return SIEventBus
	end
	if not id then
		id = SIEventBus.order
		SIEventBus.order = SIEventBus.order + 1
	end
	table.insert( SIEventBus.wait.funcs , { id = id , func = func } )
	SIEventBus.wait.listener[id] = {}
	return SIEventBus
end

function SIEventBus.AddNth( count , func , id )
	if not func then
		e( "事件总线[SIEventBus] : 不能添加空的事件方法" )
		return SIEventBus
	end
	if not id then
		id = SIEventBus.order
		SIEventBus.order = SIEventBus.order + 1
	end
	local data = SIEventBus.nth[count]
	if not data then
		data = {}
		data.isSet = false
		data.funcs = {}
		SIEventBus.nth[count] = data
	end
	if data.isSet then table.insert( data.funcs , { id = id , func = func } )
	else
		data.isSet = true
		table.insert( data.funcs , { id = id , func = func } )
		script.on_nth_tick( count , function( event )
			for index , funcData in pairs( SIEventBus.nth[event.nth_tick].funcs ) do funcData.func( event , funcData.id ) end
		end )
	end
	return SIEventBus
end

function SIEventBus.SetNth( count , func , id )
	if not func then
		e( "事件总线[SIEventBus] : 不能设置空的事件方法" )
		return SIEventBus
	end
	if not id then
		e( "事件总线[SIEventBus] : 设置事件方法时必须使用明确的 id" )
		return SIEventBus
	end
	local data = SIEventBus.nth[count]
	if not data then
		e( "事件总线[SIEventBus] : 当前 count 指定的事件列表没有记录数据" )
		return SIEventBus
	end
	local oldIndex
	for index , funcData in pairs( data.funcs ) do
		if funcData.id == id then
			oldIndex = index
			break
		end
	end
	if not oldIndex then
		e( "事件总线[SIEventBus] : 设置事件方法时必须使用列表中存在的 id" )
		return SIEventBus
	end
	data.funcs[oldIndex] = { id = id , func = func }
	return SIEventBus
end

function SIEventBus.RemoveNth( count , id )
	if not id then
		e( "事件总线[SIEventBus] : 移除事件方法时必须使用明确的 id" )
		return SIEventBus
	end
	local data = SIEventBus.nth[count]
	if not data then
		e( "事件总线[SIEventBus] : 当前 count 指定的事件列表没有记录数据" )
		return SIEventBus
	end
	local oldIndex
	for index , funcData in pairs( data.funcs ) do
		if funcData.id == id then
			oldIndex = index
			break
		end
	end
	if not oldIndex then
		e( "事件总线[SIEventBus] : 设置事件方法时必须使用列表中存在的 id" )
		return SIEventBus
	end
	if table.Size( data.funcs ) > 1 then
		local funcs = {}
		for index , funcData in pairs( data.funcs ) do
			if oldIndex ~= index then table.insert( funcs , funcData ) end
		end
		data.funcs = funcs
	else SIEventBus.ClearNth( count ) end
	return SIEventBus
end

function SIEventBus.ClearNth( count )
	local data = SIEventBus.nth[count]
	if data then SIEventBus.nth[count] = nil end
	script.on_nth_tick( count )
	return SIEventBus
end

function SIEventBus.Add( eventId , func , id )
	if not func then
		e( "事件总线[SIEventBus] : 不能添加空的事件方法" )
		return SIEventBus
	end
	if not id then
		id = SIEventBus.order
		SIEventBus.order = SIEventBus.order + 1
	end
	local baseFunc = script.get_event_handler( eventId )
	if baseFunc then
		local data = SIEventBus.list[eventId]
		if data.isSet then table.insert( data.funcs , { id = id , func = func } )
		else
			data.isSet = true
			table.insert( data.funcs , { id = id , func = func } )
			script.on_event( eventId , function( event )
				for index , funcData in pairs( SIEventBus.list[event.name].funcs ) do funcData.func( event , funcData.id ) end
			end )
		end
	else
		local data = SIEventBus.list[eventId]
		if not data then
			data = {}
			SIEventBus.list[eventId] = data
		end
		data.isSet = false
		data.funcs = { { id = id , func = func } }
		script.on_event( eventId , func )
	end
	return SIEventBus
end

function SIEventBus.Set( eventId , func , id )
	if not func then
		e( "事件总线[SIEventBus] : 不能设置空的事件方法" )
		return SIEventBus
	end
	if not id then
		e( "事件总线[SIEventBus] : 设置事件方法时必须使用明确的 id" )
		return SIEventBus
	end
	local data = SIEventBus.list[eventId]
	if not data then
		e( "事件总线[SIEventBus] : 当前 eventId 指定的事件列表没有记录数据" )
		return SIEventBus
	end
	local oldIndex
	for index , funcData in pairs( data.funcs ) do
		if funcData.id == id then
			oldIndex = index
			break
		end
	end
	if not oldIndex then
		e( "事件总线[SIEventBus] : 设置事件方法时必须使用列表中存在的 id" )
		return SIEventBus
	end
	if data.isSet then data.funcs[oldIndex] = { id = id , func = func }
	else
		data.funcs = { { id = id , func = func } }
		script.on_event( eventId , func )
	end
	return SIEventBus
end

function SIEventBus.Remove( eventId , id )
	if not id then
		e( "事件总线[SIEventBus] : 移除事件方法时必须使用明确的 id" )
		return SIEventBus
	end
	local data = SIEventBus.list[eventId]
	if not data then
		e( "事件总线[SIEventBus] : 当前 eventId 指定的事件列表没有记录数据" )
		return SIEventBus
	end
	local oldIndex
	for index , funcData in pairs( data.funcs ) do
		if funcData.id == id then
			oldIndex = index
			break
		end
	end
	if not oldIndex then
		e( "事件总线[SIEventBus] : 设置事件方法时必须使用列表中存在的 id" )
		return SIEventBus
	end
	if data.isSet then
		local funcs = {}
		for index , funcData in pairs( data.funcs ) do
			if oldIndex ~= index then table.insert( funcs , funcData ) end
		end
		data.funcs = funcs
		if #funcs < 2 then
			data.isSet = false
			local funcData = funcs[1]
			if funcData then script.on_event( eventId , funcData.func ) end
		end
	else SIEventBus.Clear( eventId ) end
	return SIEventBus
end

function SIEventBus.Clear( eventId )
	local data = SIEventBus.list[eventId]
	if data then SIEventBus.list[eventId] = nil end
	script.on_event( eventId )
	return SIEventBus
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 事件注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus.Add( SIEvents.on_player_joined_game , function( event )
	local playerIndex = event.player_index
	for index , funcData in pairs( SIEventBus.wait.funcs ) do
		local listeners = SIEventBus.wait.listener[funcData.id]
		if not table.Has( listeners , playerIndex ) then
			table.insert( listeners , playerIndex )
			funcData.func( event , funcData.id )
		end
	end
end )