-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus =
{
	order = 1 ,
	list = {}
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 事件操作 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIEventBus.add( eventId , func , id )
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
		if data.isSet then data.events[id] = func
		else
			data.isSet = true
			data.events[id] = func
			script.on_event( eventId , function( event )
				for id , func in pairs( SiEventBus.list[event.name] ) do func( event , id ) end
			end )
		end
	else
		local data = SIEventBus.list[eventId]
		if not data then
			SIEventBus.list[eventId] = {}
			data = SIEventBus.list[eventId]
		end
		data.isSet = false
		data.events = { [id] = func }
		script.on_event( eventId , func )
	end
	return SIEventBus
end

function SIEventBus.set( eventId , func , id )
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
	local oldFunc = data.events[id]
	if not oldFunc then
		e( "事件总线 : 设置事件方法时必须使用列表中存在的 id" )
		return SIEventBus
	end
	if data.isSet then data.events[id] = func
	else
		data.events = { [id] = func }
		script.on_event( eventId , func )
	end
	return SIEventBus
end

function SIEventBus.remove( eventId , id )
	if not id then
		e( "事件总线 : 移除事件方法时必须使用明确的 id" )
		return SIEventBus
	end
	local data = SIEventBus.list[eventId]
	if not data then
		e( "事件总线 : 当前 eventId 指定的事件列表没有记录数据" )
		return SIEventBus
	end
	local oldFunc = data.events[id]
	if not oldFunc then
		e( "事件总线 : 设置事件方法时必须使用列表中存在的 id" )
		return SIEventBus
	end
	if data.isSet then
		local events = {}
		local count = 0
		for oldId , oldFunc in pairs( data.events ) do
			if oldId ~= id then
				events[oldId] = oldFunc
				count = count + 1
			end
		end
		data.events = events
		if count < 2 then
			data.isSet = false
			local func = nil
			for oldId , oldFunc in pairs( data.events ) do
				if oldFunc then
					func = oldFunc
					break
				end
			end
			if func then script.on_event( eventId , func ) end
		end
	else SIEventBus.clear( eventId ) end
	return SIEventBus
end

function SIEventBus.clear( eventId )
	local data = SIEventBus.list[eventId]
	if data then SIEventBus.list[eventId] = nil end
	script.on_event( eventId )
	return SIEventBus
end