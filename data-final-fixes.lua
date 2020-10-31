-- ------------------------------------------------------------------------------------------------
-- ---------- 调整数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen.GetData( SITypes.fluid , "steam" ).max_temperature = 3000

-- ------------------------------------------------------------------------------------------------
-- ---------- 测试工具 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if SIStartup.SICFL.debug_tools() then
	SIGen
	.Init( SICFL )
	.NewGroup( "others" )
	.NewSubGroup( "others-admin" )
	
	need( "zprototype/delmap" )
	need( "zprototype/oremap" )
	--need( "zprototype/radars" )
	--need( "zprototype/roboports" )
	--need( "zprototype/robots" )
	
	SIGen.Finish()
end