local impactSound = {}
for i = 2 , 6 , 1 do table.insert( impactSound , { filename = "__base__/sound/car-metal-impact-" .. i .. ".ogg" , volume = 0.5 } ) end
local define = circuit_connector_definitions["roboport"]
local signals =
{
	default_available_logistic_output_signal = { type = "virtual" , name = "signal-X" } ,
	default_total_logistic_output_signal = { type = "virtual" , name = "signal-Y" } ,
	default_available_construction_output_signal = { type = "virtual" , name = "signal-Z" } ,
	default_total_construction_output_signal = { type = "virtual" , name = "signal-T" }
}
local customData =
{
	stationing_offset = { 0 , 0 } ,
	charging_offsets = { { 1.2 , 1.2 } , { 1.2 , -1.2 } , { 1.2 , -0.2 } , { -1.2 , -0.2 } , { 0 , 1.5 } , { 0 , -0.5 } , { 1.5 , 0.5 } , { -1.5 , 0.5 } } ,
	request_to_open_door_timeout = 15 ,
	spawn_and_station_height = -0.1 ,
	draw_logistic_radius_visualization = true ,
	draw_construction_radius_visualization = true ,
	vehicle_impact_sound = impactSound ,
	working_sound =
	{
		sound = { filename = "__base__/sound/roboport-working.ogg" , volume = 0.8 } ,
		max_sounds_per_type = 3 ,
		audible_distance_modifier = 0.5
	} ,
	open_door_trigger_effect =
	{
		{
			type = "play-sound" ,
			sound = { filename = "__base__/sound/roboport-door.ogg" , volume = 0.3 , min_speed = 1 , max_speed = 1.5 }
		}
	} ,
	close_door_trigger_effect =
	{
		{
			type = "play-sound" ,
			sound = { filename = "__base__/sound/roboport-door-close.ogg" , volume = 0.3 , min_speed = 1 , max_speed = 1.5 }
		}
	}
}

local function Create( name , radius )
	SIGen.NewRoboport( name )
	.E.SetAddenSize( 15 , 7 )
	.E.SetShadowSize( 19 , -27 )
	.E.SetWaterLocation( 0 , 75 )
	.SetProperties( 4 , 4 , 250 , 0 , "1GW" , SIPackers.EnergySource() , 10 , 10 )
	.SetEffectRadius( radius , 64 , radius )
	.SetEffectEnergy( "10MW" , "0J" )
	.SetLight()
	.SetCorpse( "roboport-remnants" , "roboport-explosion" )
	.SetSignalWire( 64 , define.points , define.sprites , signals )
	.SetPic( "base_patch" , SIPics.Layer( SIGen.GetLayerFile().."-patch" , 69 , 50 ).Frame().Get() )
	.SetPic( "base_animation" , SIPics.Layer( SIGen.GetLayerFile().."-animation" , 42 , 31 ).Anim( 1 , 8 , 0.5 ).Get() )
	.SetPic( "door_animation_up" , SIPics.Layer( SIGen.GetLayerFile().."-door-up" , 52 , 20 ).Frame( 16 ).Get() )
	.SetPic( "door_animation_down" , SIPics.Layer( SIGen.GetLayerFile().."-door-down" , 52 , 22 ).Frame( 16 ).Get() )
	.SetPic( "recharging_animation" , SIPics.Layer( SIGen.GetLayerFile().."-recharging" , 37 , 35 , 1.5 ).Anim( 1 , 16 , 0.5 ).Priority( "high" ).Get() )
	.SetCustomData( customData )
	.AddSuperArmor()
end

Create( "roboport-broad" , 128 )
Create( "roboport-vast" , 3200 )