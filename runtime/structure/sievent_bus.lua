-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- list 内的元素结构
-- eventId =
-- {
--   isSet = bool ,
--   funcs = { id = function }
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
		notAdd = true ,
		funcs = {}
	}  ,
	list = {}
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 事件操作 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIEventBus.Init( func , id )
	if not func then
		e( "事件总线 : 不能添加空的初始化方法" )
		return SIEventBus
	end
	if not id then
		id = SIEventBus.order
		SIEventBus.order = SIEventBus.order + 1
	end
	SIEventBus.init.funcs[id] = func
	if SIEventBus.init.notAdd then
		SIEventBus.init.notAdd = false
		local baseFunc = function()
			for id , func in pairs( SIEventBus.init.funcs ) do func( id ) end
		end
		script.on_init( baseFunc )
		script.on_configuration_changed( baseFunc )
	end
	return SIEventBus
end

function SIEventBus.Load( func , id )
	if not func then
		e( "事件总线 : 不能添加空的载入存档方法" )
		return SIEventBus
	end
	if not id then
		id = SIEventBus.order
		SIEventBus.order = SIEventBus.order + 1
	end
	SIEventBus.load.funcs[id] = func
	if SIEventBus.load.notAdd then
		SIEventBus.load.notAdd = false
		script.on_load( function()
			for id , func in pairs( SIEventBus.load.funcs ) do func( id ) end
		end )
	end
	return SIEventBus
end

function SIEventBus.AddWaitFunction( id , func )
	if not func then
		e( "事件总线 : 不能添加空的缓执行方法" )
		return SIEventBus
	end
	if not id then
		id = SIEventBus.order
		SIEventBus.order = SIEventBus.order + 1
	end
	SIEventBus.wait.funcs[id] = func
	if SIEventBus.wait.notAdd then
		SIEventBus.wait.notAdd = false
		script.on_nth_tick( 1 , function( event )
			for id , func in pairs( SIEventBus.wait.funcs ) do func( event , id ) end
			script.on_nth_tick( 1 , nil )
		end )
	end
	return SIEventBus
end

function SIEventBus.Add( eventId , func , id )
	if not func then
		e( "事件总线 : 不能添加空的事件方法" )
		return SIEventBus
	end
	if not id then
		id = SIEventBus.order
		SIEventBus.order = SIEventBus.order + 1
	end
	local baseFunc = script.get_event_handler( eventId )
	if baseFunc then
		local data = SIEventBus.list[eventId]
		if data.isSet then data.funcs[id] = func
		else
			data.isSet = true
			data.funcs[id] = func
			script.on_event( eventId , function( event )
				for id , func in pairs( SIEventBus.list[event.name].funcs ) do func( event , id ) end
			end )
		end
	else
		local data = SIEventBus.list[eventId]
		if not data then
			data = {}
			SIEventBus.list[eventId] = data
		end
		data.isSet = false
		data.funcs = { [id] = func }
		script.on_event( eventId , func )
	end
	return SIEventBus
end

function SIEventBus.Set( eventId , func , id )
	if not func then
		e( "事件总线 : 不能设置空的事件方法" )
		return SIEventBus
	end
	if not id then
		e( "事件总线 : 设置事件方法时必须使用明确的 id" )
		return SIEventBus
	end
	local data = SIEventBus.list[eventId]
	if not data then
		e( "事件总线 : 当前 eventId 指定的事件列表没有记录数据" )
		return SIEventBus
	end
	local oldFunc = data.funcs[id]
	if not oldFunc then
		e( "事件总线 : 设置事件方法时必须使用列表中存在的 id" )
		return SIEventBus
	end
	if data.isSet then data.funcs[id] = func
	else
		data.funcs = { [id] = func }
		script.on_event( eventId , func )
	end
	return SIEventBus
end

function SIEventBus.Remove( eventId , id )
	if not id then
		e( "事件总线 : 移除事件方法时必须使用明确的 id" )
		return SIEventBus
	end
	local data = SIEventBus.list[eventId]
	if not data then
		e( "事件总线 : 当前 eventId 指定的事件列表没有记录数据" )
		return SIEventBus
	end
	local oldFunc = data.funcs[id]
	if not oldFunc then
		e( "事件总线 : 设置事件方法时必须使用列表中存在的 id" )
		return SIEventBus
	end
	if data.isSet then
		local funcs = {}
		local count = 0
		for oldId , oldFunc in pairs( data.funcs ) do
			if oldId ~= id then
				funcs[oldId] = oldFunc
				count = count + 1
			end
		end
		data.funcs = funcs
		if count < 2 then
			data.isSet = false
			local func = nil
			for oldId , oldFunc in pairs( data.funcs ) do
				if oldFunc then
					func = oldFunc
					break
				end
			end
			if func then script.on_event( eventId , func ) end
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