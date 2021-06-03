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

-- 添加全局存储数据 , global 表下的元素 , _G 表持有引用
function SIGlobal.Create( name , initFunction )
	_G[name] = {}
	table.insert( SIGlobal.tableList , name )
	SIGlobal.initFunctionList[name] = initFunction
	if not SIGlobal.added then
		SIGlobal.added = true
		SIEventBus.Init( SIGlobal.CreateOnInit , SIGlobal.functionId ).Load( SIGlobal.CreateOnLoad , SIGlobal.functionId )
	end
	return SIGlobal
end

-- 在 migrations 阶段中需要手动调用
function SIGlobal.CreateOnMigrations()
	for i , name in pairs( SIGlobal.tableList ) do
		local data = SIGlobal.Get( name )
		if not data then SIGlobal.InitData( name )
		else _G[name] = data end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 功能方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIGlobal.CreateOnInit()
	for i , name in pairs( SIGlobal.tableList ) do
		if not SIGlobal.Get( name ) then SIGlobal.InitData( name ) end
	end
end

function SIGlobal.CreateOnLoad()
	for i , name in pairs( SIGlobal.tableList ) do _G[name] = SIGlobal.Get( name ) end
end

function SIGlobal.InitData( name )
	local data = {}
	if _G[name] and type( _G[name] ) == "table" then data = _G[name] end
	_G[name] = data
	SIGlobal.Set( name , data )
	if SIGlobal.initFunctionList[name] then SIGlobal.initFunctionList[name]( data ) end
end