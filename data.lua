require( "util" )

SILoadingDatas = true
need( "define/load" )
need( "function/load" )

needlist( "startup" , "generator/sigen" , "packer/sipackers" , "packer/sidatagetters" , "picture/sipics" , "picture/sicovers" , "sound/sisounds" , "style/sistyles" )

local constants = need( "constants" )
local constantsData = need( "constants_data" )
for k , v in pairs( constantsData ) do constants[k] = v end
load( constants )

-- ------------------------------------------------------------------------------------------------
-- ----------- 初始化 -----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
.Init( SICFL )
.NewGroup( "others" )
.NewSubGroup( "debug-things" )

needlist( "zprototype/base" , "common" , "titlebar" , "toolbar" , "view_finder" , "view_settings" )

SIGen.NewSubGroup( "icon-things" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 测试工具 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if SIStartup.SICFL.debug_tools() then
	SICFL.canGetDebugTools = SIStartup.SICFL.can_get_debug_tools()
	SIGen.NewSubGroup( "debug-tools" )
	needlist( "zprototype/debug" , "common" , "delmap" , "oremap" ) -- "reqmap"
	SIGen.NewSubGroup( "debug-capsule" )
	needlist( "zprototype/debug" , "capsule" )
	SIGen.NewSubGroup( "debug-modules" )
	needlist( "zprototype/debug" , "modules" )
	SIGen.NewSubGroup( "debug-machines" )
	needlist( "zprototype/debug" , "beacon" , "radars" , "roboports" , "robots" , "turrent" )
end

SIGen.NewGroup( "extensions" ).Finish()