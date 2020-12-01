require( "util" )

need( "define/load" )
need( "function/load" )

needlist( "runtime/structure" , "sievent_bus" , "siglobal" )
needlist( "runtime/function" , "functions" )
needlist( "runtime/remote" , "toolbar" , "wiki" )

local constants = need( "constants" )
local constantsData = need( "constants_data" )
for k , v in pairs( constantsData ) do constants[k] = v end
load( constants )

local showPatreon = SIStartup.SICFL.show_patreon()

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
	SIGlobal.Set( "SIDamageType" , CreateDamageType( game.damage_prototypes ) )
	SIEventBus.AddWaitFunction( "message" , function( event ) sip{ "SICFL.changed" , { "SICFL.data" } , date.FormatDateByTick( event.tick ) } end )
	if showPatreon then SIEventBus.AddWaitFunction( "patreon" , function( event ) sip{ "SICFL.patreon" , "https://afdian.net/@Sidoupiar" , "http://azz.net/Sidoupiar" } end ) end
end )

-- ------------------------------------------------------------------------------------------------
-- ---------- 恰饭信息 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if showPatreon then
	SIEventBus.Load( function()
		SIEventBus.AddWaitFunction( "patreon" , function( event ) sip{ "SICFL.patreon" , "https://afdian.net/@Sidoupiar" , "http://azz.net/Sidoupiar" } end )
	end )
end