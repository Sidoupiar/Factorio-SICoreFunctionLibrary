-- ------------------------------------------------------------------------------------------------
-- ---------- 报错信息 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local mmess = error
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
	mmess( "_____ :: "..output..msg )
end

error = function( msg )
	log( "[错误获取] SICoreFunctionLibrary_Code: "..msg )
end

function ee( tableData )
	e( debug.TableToString( tableData ) )
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 引用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIBase = "si"
SINeedlist = {}

function need( name , notself )
	local source = debug.getinfo( 2 , "S" ).source
	if notself then
		for i = 3 , 10 , 1 do
			source = debug.getinfo( i , "S" )
			if source then
				source = source.source
				if not source:find( "__SICoreFunctionLibrary__" ) then break end
			else
				source = debug.getinfo( i-1 , "S" ).source
				break
			end
		end
	end
	local isBase = name:find( "__" )
	source = isBase and source:sub( source:find( "__" , 3 )+3 , -1 ) or source:sub( 2 , -1 )
	local path = SINeedlist[source]
	if not path then
		path = isBase and "" or source:match( "^.*/" ) or ""
		SINeedlist[source] = path
	end
	return require( path..name )
end

function needlist( basePath , ... )
	local results = {}
	for i , path in pairs{ ... } do if path then results[path] = need( basePath.."/"..path , true ) end end
	return results
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
			elseif v[2] == "runtime-global" then r[k] = function() return settings.global[key].value end
			elseif v[2] == "runtime-per-user" then b[k] = function( playerOrIndex )
					if type( playerOrIndex ) == "number" or not playerOrIndex.is_player then playerOrIndex = game.players[playerOrIndex] end
					return playerOrIndex.mod_settings[key]
				end
			end
		end
		SIStartup[class] = s
		SIRglobal[class] = r
		SIBplayer[class] = b
	end
	
	_G[class] = constants
	
	constants.base = string.sub( constants.base , 1 , 2 ) == "__" and constants.base or "__SI" .. constants.base .. "__"
	constants.core = "__SICoreFunctionLibrary__"
	constants.class = class
	constants.realname = realname
	if constants.pictureSource then
		constants.pictureSource = string.sub( constants.pictureSource , 1 , 2 ) == "__" and constants.pictureSource or "__SI" .. constants.pictureSource .. "__"
		constants.picturePath = constants.pictureSource .. "/zpic/"
	else constants.picturePath = constants.base .. "/zpic/" end
	if constants.picturePaths then
		local newPicturePaths = {}
		for path , typeList in pairs( constants.picturePaths ) do
			path = string.sub( path , 1 , 2 ) == "__" and path or "__SI" .. path .. "__"
			table.insert( newPicturePaths , { path = path , typeList = typeList } )
		end
		constants.mainPicturePath = 0
		constants.picturePaths = newPicturePaths
	end
	if constants.soundSource then
		constants.soundSource = string.sub( constants.soundSource , 1 , 2 ) == "__" and constants.soundSource or "__SI" .. constants.soundSource .. "__"
		constants.soundPath = constants.soundSource .. "/zsound/"
	else constants.soundPath = constants.base .. "/zsound/" end
	if not constants.orderCode then constants.orderCode = SIOrderCode end
	constants.orderName = ( SIOrderCode == 0 and "0000" or SIOrderCode ) .. "[" .. realname .. "o]-"
	constants.GetPicturePath = function( prototypeType )
		if not constants.picturePaths then return constants.picturePath end
		if constants.mainPicturePath > 0 then
			local dataPack = constants.picturePaths[constants.mainPicturePath]
			for code , type in pairs( dataPack.typeList ) do
				if type == prototypeType then return dataPack.path end
			end
		else
			for index , dataPack in pairs( constants.picturePaths ) do
				if index ~= constants.mainPicturePath then
					for code , type in pairs( dataPack.typeList ) do
						if type == prototypeType then return dataPack.path end
					end
				end
			end
		end
		return constants.picturePath
	end
	if constants.BeforeLoad then constants.BeforeLoad() end
	
	SIConstantsDic[constants.base] = class
	
	if SILoadingDatas and constants.autoLoad then
		local list = {}
		if constants.damage then
			for index , name in pairs( constants.damage ) do table.insert( list , { type = SITypes.damageType , name = name } ) end
		end
		if constants.categories then
			for id , category in pairs( SITypes.category ) do
				if constants.categories[category] then
					for index , name in pairs( constants.categories[category] ) do table.insert( list , { type = category , name = name } ) end
				end
			end
		end
		data:extend( list )
	end
	
	if constants.finalSettingDataList then
		class = constants.name
		for k , v in pairs( constants.finalSettingDataList ) do
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

-- 输出提醒
function message( playerOrIndex , msg )
	if SILoadingDatas then sil( msg )
	else
		if not playerOrIndex then playerOrIndex = game
		elseif type( playerOrIndex ) == "number" or not playerOrIndex.is_player then playerOrIndex = game.players[playerOrIndex] end
		playerOrIndex.print( { "SICFL.m-xt" , msg } , SIColors.printColor.green )
	end
end

-- 输出警告
function alert( playerOrIndex , customMessage )
	if SILoadingDatas then sil( msg )
	else
		if not playerOrIndex then playerOrIndex = game
		elseif type( playerOrIndex ) == "number" or not playerOrIndex.is_player then playerOrIndex = game.players[playerOrIndex] end
		playerOrIndex.print( { "SICFL.m-jg" , customMessage } , SIColors.printColor.red )
	end
end