-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local customData =
{
	working_sound = SISounds.Working( { "__base__/sound/beacon-1.ogg" , "__base__/sound/beacon-2.ogg" } , 0.2 , 3 , 0.33 )
}

-- ------------------------------------------------------------------------------------------------
-- --------- 创建插件塔 ---------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local function CreateAnimation( path )
	return
	{
		layers =
		{
			SIPics.NewLayer( path.."-bottom" , 106 , 96 ).Priority( "low" ).Repeat( 45 ).Get() ,
			SIPics.NewLayer( path.."-shadow" , 122 , 90 ).Priority( "low" ).Shift( 12 , 0 ).Repeat( 45 ).Shadow().Get() ,
			SIPics.NewLayer( path.."-top" , 48 , 70 ).Priority( "high" ).Shift( 3 , -20 ).Repeat( 45 ).Get() ,
			SIPics.NewLayer( path.."-light" , 56 , 94 ).Priority( "extra-high" ).BlendMode( "additive" ).Shift( 1 , -19 ).Anim( 9 , 45 , 0.5 ).Get()
		}
	}
end

SIGen.NewBeacon( "beacon" )
.AddFlags{ SIFlags.entityFlags.hidden }
.SetProperties( 3 , 3 , 250 , 0 , "1GW" , SIPackers.EnergySource() )
.SetEffectRadius( 64 )
.SetEffectEnergy( 10 )
.SetPluginData( 126 , { 0 , 0.5 } , 0.25 ) -- 插件槽界面每行 6 个 , 物品信息概要存储每行 7 个 , 取最小公约数 6*7=42 个 , 42 太少变成 3 倍 , 总数 42*3=126 个
.SetCorpse( "beacon-remnants" , "beacon-explosion" )
.SetPluginTypes{ SITypes.moduleEffect.speed , SITypes.moduleEffect.product , SITypes.moduleEffect.consumption , SITypes.moduleEffect.pollut }
.SetPic( "animation" , CreateAnimation( SIGen.GetLayerFile() ) )
.SetCustomData( customData )
.AddSuperArmor()