require( "util" )

SILoadingSettings = true
need( "define/load" )
need( "function/load" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SISettings = {}

function SISettings.ChangeConstants( constants )
	if constants.settings then
		local r = constants.name:gsub( "_" , "-" ) .. "-"
		local s = {}
		local c
		for k , v in pairs( constants.settings ) do
			c = r .. k:gsub( "_" , "-" )
			s[c] = v
		end
		return s
	else return nil end
end

function SISettings.CreateSetting( type , settingType , name , defaultValue , minimumValue , maximumValue , allowedValues , allowBlank , order , localisedName , localisedDescription )
	local d = {}
	d.type = type .. "-setting"
	d.setting_type = settingType
	d.name = name
	d.default_value = defaultValue
	d.allowed_values = allowedValues
	d.allow_blank = allowBlank or false
	d.order = order
	if type == "int" or type == "double" then
		d.minimum_value = minimumValue
		d.maximum_value = maximumValue
	end
	if localisedName then d.localised_name = localisedName end
	if localisedDescription then d.localised_description = localisedDescription end
	return d
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 构造配置 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SISettings.Load( constantsData , orderCode )
	local settings = SISettings.ChangeConstants( constantsData or need( "constants" , true ) )
	if settings then
		if not orderCode or type( orderCode ) ~= "number" then orderCode = 1000 end
		local s = {}
		local order = orderCode
		for n , m in pairs( settings ) do
			order = order + 1
			table.insert( s , SISettings.CreateSetting( m[1] , m[2] , n , m[3] , m[4] , m[5] , m[6] , m[7] , order , m[8] , m[9] ) )
		end
		if #s > 0 then data:extend( s ) end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 创建配置 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SISettings.Load( need( "constants" ) )