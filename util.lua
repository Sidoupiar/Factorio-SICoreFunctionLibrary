-- ------------------------------------------------------------------------------------------------
-- ---------- 报错信息 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function e( msg )
	local output = ""
	for i = 5 , 2 , -1 do
		local a = debug.getinfo( i , "S" )
		local b = debug.getinfo( i , "l" )
		local c = debug.getinfo( i , "n" )
		if a and a.source then output = output .. a.source:sub( 2 , -1 )
		else output = output .. "[unknown]" end
		if b and b.currentline then output = output .. ":" .. b.currentline
		else output = output .. ":-1" end
		if c and c.name then output = output .. ":" .. c.name .. "()"
		else output = output .. ":[filecode]" end
		output = output .. " :: "
	end
	error( "_____ :: "..output..msg )
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 引用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIBase = "si"
SINeedlist = {}

function need( name , notself )
	local source = debug.getinfo( 2 , "S" ).source
	if notself then for i = 3 , 10 , 1 do source = debug.getinfo( i , "S" ).source if not source:find( "__SICoreFunctionLibrary__" ) then break end end end
	source = name:find( "__" ) and source:sub( source:find( "__" , 3 )+3 , -1 ) or source:sub( 2 , -1 )
	local path = SINeedlist[source]
	if not path then
		path = source:match( "^.*/" ) or ""
		SINeedlist[source] = path
	end
	return require( path..name )
end

function needlist( basePath , ... )
	local result = {}
	for i , path in pairs{ ... } do
		if path then result[path] = need( basePath.."/"..path ) end
	end
	return result
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIOrderCode = -1000
SIStartup = {}
SIRglobal = {}
SIBplayer = {}
SIConstantsDic = {}

function load( constantsData )
	SIOrderCode = SIOrderCode + 1000
	
	local constants = constantsData
	if not constants then
		constants = need( "constants" , true )
		local constantsData = need( "constants_data" , true )
		for k , v in pairs( constantsData ) do constants[k] = v end
	end
	
	local class = constants.name:upper()
	local realname = constants.name:gsub( "_" , "-" ) .. "-"
	
	if constants.settings then
		local s = {}
		local r = {}
		local b = {}
		for k , v in pairs( constants.settings ) do
			local key = realname .. k:gsub( "_" , "-" )
			if v[2] == "startup" then s[k] = function() return settings.startup[key].value end
			elseif v[2] == "runtime-global" then r[k] = function() return settings.global[key].value end end
		end
		SIStartup[class] = s
		SIRglobal[class] = r
		SIBplayer[class] = b
	end
	
	_G[class] = constants
	
	constants.base = string.sub( constants.base , 1 , 2 ) == "__" and constants.base or "__SI" .. constants.base .. "__"
	constants.cfl = "__SICoreFunctionLibrary__"
	constants.class = class
	constants.picturePath = constants.base .. "/zpic/"
	constants.realname = realname
	if not constants.orderCode then constants.orderCode = SIOrderCode end
	constants.order_name = SIOrderCode .. "[" .. realname .. "]-"
	if constants.before_load then constants.before_load() end
	
	SIConstantsDic[constants.base] = class
	
	if SILoadingDatas and constants.autoLoad then
		if constants.groups then
			local order = 0
			for k , v in pairs( constants.groups ) do
				order = order + 1
				SIGF.group( k , order , v , class )
			end
		end
		if constants.append_groups then
			for k , v in pairs( constants.append_groups ) do
				SIGF.append_group( k , SICFL.class , v , constants.orderCode )
			end
		end
		if constants.categories then
			for k , v in pairs( SIType.category ) do
				if constants.categories[k] then
					local lname = realname .. k .. "-"
					local list = {}
					for j , m in pairs( constants.categories[k] ) do list[j] = { type = v , name = lname..m } end
					data:extend( list )
				end
			end
		end
		if constants.damage then
			local list = {}
			for i , v in pairs( constants.damage ) do list[#list+1] = { type = "damage-type" , name = realname..v } end
			data:extend( list )
		end
	end
	
	if constants.final_setting_datas then
		class = constants.name
		for k , v in pairs( constants.final_setting_datas ) do
			if SIStartup[class][k] then SIStartup[class][k] = function() return v end
			elseif SIRglobal[class][k] then SIRglobal[class][k] = function() return v end
			elseif SIBplayer[class][k] then SIBplayer[class][k] = function() return v end end
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 输出信息 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 是否启用了日志输出
function enabledWriteLog()
	return settings.startup["sicfl-writelog"].value
end

-- 是否启用了 debug 工具
function enabledDebugTool()
	return settings.startup["sicfl-debug-tools"].value
end

-- 是否启用了 debug 信息输出
function enabledDebug()
	return settings.global["sicfl-debug"].value
end

-- 输出日志
function l( msg )
	if enabledWriteLog() then log( msg ) end
end

-- 输出 debug 信息
function p( msg )
	if enabledDebug() then game.print( { "SICFL.m-tz" , msg } , SIColors.printColor.orange ) end
end

-- 强制输出日志
function sil( msg )
	log( "SICoreFunctionLibrary: "..msg )
end

-- 强制输出 debug 信息
function sip( msg )
	game.print( { "SICFL.m-xt" , msg } , SIColors.printColor.green )
end

-- 输出警告
function alert( player , customMessage )
	if SILoadingDatas then sil( msg )
	else
		if not player then player = game end
		player.print( { "SICFL.m-jg" , customMessage } , SIColors.printColor.red )
	end
end