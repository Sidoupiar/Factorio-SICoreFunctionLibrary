require( "util" )

SILoadingDatas = true
need( "define/load" )
need( "function/load" )

needlist( "startup" , "generator/sigen" , "packer/sipackers" , "picture/sipics" , "sound/sisounds" , "style/sistyles" )

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

needlist( "zprototype/base" , "common" , "toolbar" , "wiki" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 测试工具 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if SIStartup.SICFL.debug_tools() then
	SIGen.NewSubGroup( "debug-tools" )
	needlist( "zprototype/debug" , "delmap" , "oremap" , "reqmap" )
	SIGen.NewSubGroup( "debug-machines" )
	needlist( "zprototype/debug" , "radars" , "roboports" , "robots" )
end

SIGen.NewGroup( "extensions" ).Finish()