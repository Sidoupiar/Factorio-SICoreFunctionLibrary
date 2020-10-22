require( "util" )

need( "define/load" )
need( "function/load" )
need( "runtime/load" )

local constants = need( "constants" )
local constantsData = need( "constants_data" )
for k , v in pairs( constantsData ) do constants[k] = v end
load( constants )

-- ------------------------------------------------------------------------------------------------
-- ----------- 初始化 -----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function OnInit()
	local damageTypes = CreateDamageType( game.damage_prototypes )
	SetGlobalData( "SIDamageType" , damageTypes )
	-- 发送通知
	script.on_nth_tick( 30 , message )
end

function message( event )
	sip{ "SICFL.changed" , { "SICFL.data" } , date.FormatDateByTick( event.tick ) }
	script.on_nth_tick( nil )
end

script.on_init( OnInit )
script.on_configuration_changed( OnInit )

-- ------------------------------------------------------------------------------------------------
-- ---------- 测试工具 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if SIStartup.SICFL.debug_tools() then
	need( "zaction/select_tools" )
end