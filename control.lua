require( "util" )

need( "define/load" )
need( "function/load" )

needlist( "runtime/structure" , "sievent_bus" , "global_data"" )
need( "runtime/function/functions" )
needlist( "runtime/remote" , "toolbar" , "wiki" )

local constants = need( "constants" )
local constantsData = need( "constants_data" )
for k , v in pairs( constantsData ) do constants[k] = v end
load( constants )

-- ------------------------------------------------------------------------------------------------
-- ---------- 测试工具 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if SIStartup.SICFL.debug_tools() then
	need( "zaction/delmap" )
	need( "zaction/oremap" )
end

-- ------------------------------------------------------------------------------------------------
-- ----------- 初始化 -----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus.Init( function()
	SetGlobalData( "SIDamageType" , CreateDamageType( game.damage_prototypes ) )
	-- 发送通知
	script.on_nth_tick( 30 , message )
end )

function message( event )
	sip{ "SICFL.changed" , { "SICFL.data" } , date.FormatDateByTick( event.tick ) }
	script.on_nth_tick( nil )
end