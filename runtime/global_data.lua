-- ------------------------------------------------------------------------------------------------
-- ---------- 存取方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SetGlobalData( name , data )
	global[name] = data
end

function GetGlobalData( name )
	return global[name]
end

-- ------------------------------------------------------------------------------------------------
-- ------- 构造全局数据包 -------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

globalTableFuncId = "CreateGlobalTable"
globalTableFuncAdded = false
globalTableList = {}

function CreateGlobalTable( name )
	table.insert( globalTableList , name )
	if not globalTableFuncAdded then
		SIEventBus.Init( CreateGlobalTableOnInit , globalTableFuncId ).Load( CreateGlobalTableOnLoad , globalTableFuncId )
		globalTableFuncAdded = true
	end
end

function CreateGlobalTableOnInit()
	for i , name in pairs( globalTableList ) do
		local oldData = GetGlobalData( name )
		if not oldData then SetGlobalData( name , {} ) end
	end
end

function CreateGlobalTableOnLoad()
	for i , name in pairs( globalTableList ) do _G[name] = GetGlobalData( name ) end
end