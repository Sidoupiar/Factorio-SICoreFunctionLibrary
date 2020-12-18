-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local customData =
{
	radius_minimap_visualisation_color = SIPackers.Color( 0.059 , 0.092 , 0.235 , 0.275 ) ,
	working_sound = SISounds.Working( "__base__/sound/radar.ogg" , 0.8 , 3 , 0.8 )
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 创建雷达 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local function Create( name , nearRadius , farRadius , nearEnergy , farEnergy )
	local radarItem = SIGen.NewRadar( name )
	.E.SetAddenSize( 2 , 32 )
	.E.SetShadowSize( 76 , -2 )
	.E.SetAddenShift( 2 , 0 )
	.E.SetShadowShift( 77 , 2 )
	.E.SetWaterLocation( 5 , 35 )
	.AddFlags{ SIFlags.entityFlags.hidden }
	.SetProperties( 3 , 3 , 250 , 0.01 , "10MW" , SIPackers.EnergySource() )
	.SetEffectRadius( nearRadius , farRadius )
	.SetEffectEnergy( nearEnergy , farEnergy )
	.SetCorpse( "radar-remnants" , "radar-explosion" )
	.SetCustomData( customData )
	.AddSuperArmor()
	.GetCurrentEntityItemName()
	
	if SICFL.canGetDebugTools then
		SIGen.NewTechnology( radarItem )
		.SetLevel( 1 , "infinite" )
		.SetCosts( SICFL.debugPack , math.pow( nearRadius , 2 )*10 )
		.AddResults( SITypes.modifier.giveItem , radarItem )
	end
end

Create( "radar-strategic" , 24 , 0 , "20MJ" , "1TJ" )
Create( "radar-sky-eye" , 60 , 0 , "20MJ" , "1TJ" )
Create( "radar-overload" , 150 , 0 , "20MJ" , "1TJ" )