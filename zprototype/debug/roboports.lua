-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local define = circuit_connector_definitions["roboport"]
local signals =
{
	default_available_logistic_output_signal = "signal-X" ,
	default_total_logistic_output_signal = "signal-Y" ,
	default_available_construction_output_signal = "signal-Z" ,
	default_total_construction_output_signal = "signal-T"
}
local customData =
{
	stationing_offset = { 0 , 0 } ,
	charging_offsets = { { 1.2 , 1.2 } , { 1.2 , -1.2 } , { 1.2 , -0.2 } , { -1.2 , -0.2 } , { 0 , 1.5 } , { 0 , -0.5 } , { 1.5 , 0.5 } , { -1.5 , 0.5 } } ,
	request_to_open_door_timeout = 15 ,
	spawn_and_station_height = -0.1 ,
	draw_logistic_radius_visualization = true ,
	draw_construction_radius_visualization = true ,
	working_sound = SISounds.Working( "__base__/sound/roboport-working.ogg" , 0.8 , 3 , 0.5 ) ,
	open_door_trigger_effect = { { type = "play-sound" , sound = SISounds.Sound( "__base__/sound/roboport-door.ogg" , 0.3 , 1 , 1.5 ) } } ,
	close_door_trigger_effect = { { type = "play-sound" , sound = SISounds.Sound( "__base__/sound/roboport-door-close.ogg" , 0.3 , 1 , 1.5 ) } }
}

-- ------------------------------------------------------------------------------------------------
-- -------- 创建指令平台 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local function Create( name , radius )
	SIGen.NewRoboport( name )
	.E.SetShadowSize( 19 , -27 )
	.E.SetShadowShift( 38 , 5.75 )
	.E.SetWaterLocation( 0 , 75 )
	.E.AddItemFlags( SIFlags.itemFlags.hidden )
	.SetProperties( 4 , 4 , 250 , 0 , "1GW" , SIPackers.EnergySource() , 10 , 10 )
	.SetEffectRadius( radius , 64 , radius )
	.SetEffectEnergy( "10MW" , "0J" , 3 )
	.SetLight()
	.SetCorpse( "roboport-remnants" , "roboport-explosion" )
	.SetSignalWire( 64 , define.points , define.sprites , signals )
	.SetPic( "base_patch" , SIPics.NewLayer( SIGen.GetLayerFile().."-patch" , 69 , 50 ).Shift( 1.5 , 5 ).Frame().Get() )
	.SetPic( "base_animation" , SIPics.NewLayer( SIGen.GetLayerFile().."-animation" , 41 , 29 ).Shift( -17.75 , -61.25 ).Anim( 8 , 8 , 0.5 ).Get() )
	.SetPic( "door_animation_up" , SIPics.NewLayer( SIGen.GetLayerFile().."-door-up" , 48 , 19 ).Shift( -0.25 , -28.5 ).Frame( 16 ).Get() )
	.SetPic( "door_animation_down" , SIPics.NewLayer( SIGen.GetLayerFile().."-door-down" , 48 , 20 ).Shift( -0.25 , -9.75 ).Frame( 16 ).Get() )
	.SetPic( "recharging_animation" , SIPics.NewLayer( SIGen.GetLayerFile().."-recharging" , 37 , 35 , 1.5 ).Priority( "high" ).Anim( 16 , 16 , 0.5 ).Get() )
	.SetCustomData( customData )
	.AddSuperArmor()
end

Create( "roboport-broad" , 128 )
Create( "roboport-vast" , 4800 )