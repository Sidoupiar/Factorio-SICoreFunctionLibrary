require( "util" )

need( "define/load" )
need( "function/load" )

needlist( "runtime/structure" , "sievent_bus" , "global_data" )
needlist( "runtime/function" , "functions" )
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
	SIEventBus.AddWaitFunction( "message" , function( event ) sip{ "SICFL.changed" , { "SICFL.data" } , date.FormatDateByTick( event.tick ) } end )
end )