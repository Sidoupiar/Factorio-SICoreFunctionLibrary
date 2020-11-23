-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGlobal =
{
	functionId = "CreateGlobalTable" ,
	added = false ,
	tableList = {}
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 存取方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIGlobal.Set( name , data )
	global[name] = data
	return SIGlobal
end

function SIGlobal.Get( name )
	return global[name]
end

-- ------------------------------------------------------------------------------------------------
-- ------- 构造全局数据包 -------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIGlobal.Create( name )
	table.insert( SIGlobal.tableList , name )
	if not SIGlobal.added then
		SIGlobal.added = true
		SIEventBus.Init( SIGlobal.CreateOnInit , SIGlobal.functionId ).Load( SIGlobal.CreateOnLoad , SIGlobal.functionId )
	end
end

function SIGlobal.CreateOnInit()
	for i , name in pairs( SIGlobal.tableList ) do
		local data = SIGlobal.Get( name )
		if not data then
			data = {}
			_G[name] = data
			SIGlobal.Set( name , data )
		end
	end
end

function SIGlobal.CreateOnLoad()
	for i , name in pairs( SIGlobal.tableList ) do _G[name] = SIGlobal.Get( name ) end
end

function SIGlobal.CreateOnLoad_M()
	for i , name in pairs( SIGlobal.tableList ) do _G[name] = SIGlobal.Get( name ) end
end