require( "util" )

SILoadingDatas = true

need( "define/load" )
need( "function/load" )
need( "startup/generator/load" )
need( "startup/packer/load" )
need( "startup/picture/load" )
need( "startup/sound/load" )

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
.NewItem( "empty" , 1000 )

-- ------------------------------------------------------------------------------------------------
-- ---------- 测试工具 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if SIStartup.SICFL.debug_tools() then
	SIGen.NewSubGroup( "debug-tools" )
	need( "zprototype/delmap" )
	need( "zprototype/oremap" )
	need( "zprototype/radars" )
	need( "zprototype/roboports" )
	--need( "zprototype/robots" )
end

SIGen.NewGroup( "extensions" ).Finish()