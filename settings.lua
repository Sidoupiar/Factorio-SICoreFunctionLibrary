require( "util" )

SILoadingSettings = true

need( "define/sitypes" )

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

function SISettings.CreateSetting( type , setting_type , name , default_value , minimum_value , maximum_value , allow_blank , order , per_user )
	if not allow_blank then allow_blank = false end
	local d = {}
	d.type = type .. "-setting"
	d.setting_type = setting_type
	d.name = name
	d.default_value = default_value
	if type == "int" or type == "double" then
		d.minimum_value = minimum_value
		d.maximum_value = maximum_value
	end
	if per_user then d.per_user = per_user end
	d.allow_blank = allow_blank
	d.order = order
	return d
end

function SISettings.Load( constantsData , orderCode )
	local settings = SISettings.ChangeConstants( constantsData or need( "constants" , true ) )
	if settings then
		if not orderCode or type( orderCode ) ~= "number" then orderCode = 1000 end
		local s = {}
		local order = orderCode
		for n , m in pairs( settings ) do
			order = order + 1
			table.insert( s , SISettings.CreateSetting( m[1] , m[2] , n , m[3] , m[4] , m[5] , m[6] , order , m[7] ) )
		end
		if #s > 0 then data:extend( s ) end
	end
end

SISettings.Load( need( "constants" ) )