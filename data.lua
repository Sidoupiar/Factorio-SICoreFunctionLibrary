require( "util" )

SILoadingDatas = true

need( "define/load" )
need( "function/load" )

needlist( "startup" , "generator/sigen" , "packer/sipackers" , "picture/sipics" , "sound/sisounds" )

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

need( "zprototype/base/common" )
need( "zprototype/base/toolbar" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 测试工具 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if SIStartup.SICFL.debug_tools() then
	SIGen.NewSubGroup( "debug-tools" )
	need( "zprototype/debug/delmap" )
	need( "zprototype/debug/oremap" )
	need( "zprototype/debug/radars" )
	need( "zprototype/debug/roboports" )
	need( "zprototype/debug/robots" )
end

SIGen.NewGroup( "extensions" ).Finish()