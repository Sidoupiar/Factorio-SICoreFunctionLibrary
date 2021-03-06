require( "util" )

need( "define/load" )
need( "function/load" )

needlist( "runtime/structure" , "sievent_bus" , "siglobal" )
needlist( "runtime/interface" , "sitoolbar" , "siunlocker" , "siplayer_status" )
needlist( "runtime/function" , "functions" )

local constants = need( "constants" )
local constantsData = need( "constants_data" )
for k , v in pairs( constantsData ) do constants[k] = v end
load( constants )

local showPatreon = SIStartup.SICFL.show_patreon()

-- ------------------------------------------------------------------------------------------------
-- ---------- 装载数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

needlist( "zaction/base" , "titlebar" , "view_evolution" , "view_kill_count" , "view_time" , "view_game_speed" )
needlist( "zaction/remote" , "view_finder" , "view_settings" , "implement_sitoolbar" , "implement_siunlocker" , "implement_siplayer_status" )
-- 测试工具
if SIStartup.SICFL.debug_tools() then
	needlist( "zaction/debug" , "delmap" , "oremap" )
end

-- ------------------------------------------------------------------------------------------------
-- ----------- 初始化 -----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus.Init( function()
	SIGlobal.Set( "SIDamageType" , SI.Damage.CreateTypeList( game.damage_prototypes ) )
	SIEventBus.AddWaitFunction( "message" , function( event ) message( event.player_index , { "SICFL.changed" , { "SICFL.data" } , date.FormatDateByTick( event.tick ) } ) end )
end )

-- ------------------------------------------------------------------------------------------------
-- ---------- 恰饭信息 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus.Add( SIEvents.on_player_joined_game , function( event )
	if showPatreon then game.players[event.player_index].print{ "SICFL.patreon" , "https://afdian.net/@Sidoupiar" , "http://azz.net/Sidoupiar" } end
end )