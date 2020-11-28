-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SICovers =
{
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------------
-- -------- 创建默认贴图 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local empty64 = SIPics.NewLayer( "__SICoreFunctionLibrary__/picture/entity/cover/pipe-picture-empty" , 64 , 64 ).Priority( "extra-high" ).Shift( 0 , -32 ).Get()
SICovers.pipeConnectPictureEmpty =
{
	north = SIPics.NewLayer( "__SICoreFunctionLibrary__/picture/entity/cover/pipe-cover-picture-empty-south" , 64 , 64 ).Priority( "extra-high" ).Shift( 0 , 32 ).Get() ,
	south = SIPics.NewLayer( "__SICoreFunctionLibrary__/picture/entity/cover/pipe-connect-picture-empty-south" , 64 , 64 ).Priority( "extra-high" ).Shift( 0 , -32 ).Get() ,
	east = empty64 ,
	west = empty64
}

SICovers.pipeCoverPictureEmpty =
{
	north = empty64 ,
	south = SIPics.NewLayer( "__SICoreFunctionLibrary__/picture/entity/cover/pipe-cover-picture-empty-south" , 64 , 64 ).Priority( "extra-high" ).Get() ,
	east = empty64 ,
	west = empty64
}