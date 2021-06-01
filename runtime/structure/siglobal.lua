-- ------------------------------------------------------------------------------------------------
-- ---------- 添加引用 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if not SIEventBus then e( "模块使用[SIGlobal] : 必须启用 SIEventBus 之后才能使用 SIGlobal 模块" ) end

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGlobal =
{
	functionId = "CreateGlobalTable" ,
	added = false ,
	tableList = {} ,
	initFunctionList = {}
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

function SIGlobal.Create( name , initFunction )
	table.insert( SIGlobal.tableList , name )
	SIGlobal.initFunctionList[name] = initFunction
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
		if SIGlobal.initFunctionList[name] then SIGlobal.initFunctionList[name]( data ) end
	end
end

function SIGlobal.CreateOnLoad()
	for i , name in pairs( SIGlobal.tableList ) do _G[name] = SIGlobal.Get( name ) end
end

function SIGlobal.CreateOnMigrations()
	for i , name in pairs( SIGlobal.tableList ) do
		local data = SIGlobal.Get( name )
		if not data then
			data = {}
			_G[name] = data
			SIGlobal.Set( name , data )
		else _G[name] = data end
	end
end