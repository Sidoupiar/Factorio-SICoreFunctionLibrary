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
.NewSubGroup( "debug" )
.NewItem( "empty" , 1000 )
.NewGroup( "extensions" )
.Finish()