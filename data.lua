require( "util" )

SILoadingDatas = true
need( "define/load" )
need( "function/load" )

needlist( "startup" , "generator/sigen" , "packer/sipackers" , "picture/sipics" , "picture/sicovers" , "sound/sisounds" , "style/sistyles" )

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

needlist( "zprototype/base" , "common" , "titlebar" , "toolbar" , "view_settings" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 测试工具 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if SIStartup.SICFL.debug_tools() then
	SIGen.NewSubGroup( "debug-tools" )
	--needlist( "zprototype/debug" , "delmap" , "oremap" , "reqmap" )
	needlist( "zprototype/debug" , "delmap" , "oremap" )
	SIGen.NewSubGroup( "debug-modules" )
	needlist( "zprototype/debug" , "modules" )
	SIGen.NewSubGroup( "debug-machines" )
	needlist( "zprototype/debug" , "beacon" , "radars" , "roboports" , "robots" )
end

SIGen.NewGroup( "extensions" ).Finish()