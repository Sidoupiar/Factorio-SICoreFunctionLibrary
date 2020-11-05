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
	.SetCustomData( customData )
	.AddSuperArmor()
end

Create( "roboport-broad" , 128 )
Create( "roboport-vast" , 3200 )

local ptl =
{
	"__SICoreFunctionLibrary__/zpics/entities/ancient-armor-roboport/ancient-armor-roboport-base" ,
	"__SICoreFunctionLibrary__/zpics/entities/ancient-armor-roboport/ancient-armor-roboport-shadow"
}

local ptp =
{
	base_patch = "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-roboport/ancient-armor-roboport-base-patch" ,
	base_animation = "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-roboport/ancient-armor-roboport-base-animation" ,
	door_animation_up = "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-roboport/ancient-armor-roboport-door-up" ,
	door_animation_down = "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-roboport/ancient-armor-roboport-door-down" ,
	recharging_animation = "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-roboport/ancient-armor-roboport-recharging"
}

pt.base_patch =
{
	width = 69 ,
	height = 50 ,
	frame_count = 1 ,
	shift = { 0.03125 , 0.203125 } ,
	hr_version =
	{
		width = 138 ,
		height = 100 ,
		frame_count = 1 ,
		shift = util.by_pixel( 1.5 , 5 ) ,
		scale = 0.5
	}
}
pt.base_animation =
{
	width = 42 ,
	height = 31 ,
	frame_count = 8 ,
	animation_speed = 0.5 ,
	shift = { -0.5315 , -1.9375 } ,
	hr_version =
	{
		width = 83 ,
		height = 59 ,
		frame_count = 8 ,
		animation_speed = 0.5 ,
		shift = util.by_pixel( -17.75 , -61.25 )
	}
}
pt.door_animation_up =
{
	width = 52 ,
	height = 20 ,
	frame_count = 16 , 
	shift = { 0.015625 , -0.890625 } ,
	hr_version =
	{
		width = 97 ,
		height = 38 ,
		frame_count = 16 ,
		shift = util.by_pixel( -0.25 , -29.5 )
	}
}
pt.door_animation_down =
{
	width = 52 ,
	height = 22 ,
	frame_count = 16 ,
	shift = { 0.015625 , -0.234375 } ,
	hr_version =
	{
		width = 97 ,
		height = 41 ,
		frame_count = 16 ,
		shift = util.by_pixel( -0.25 , -9.75 )
	}
}
pt.recharging_animation =
{
	priority = "high" ,
	width = 37 ,
	height = 35 ,
	frame_count = 16 ,
	scale = 1.5 ,
	animation_speed = 0.5
}
pt.water_reflection =
{
	pictures =
	{
		priority = "extra-high" ,
		width = 28 ,
		height = 28 ,
		shift = util.by_pixel( 0 ,75 ) ,
		variation_count = 1 ,
		scale = 5
	} ,
	rotate = false ,
	orientation_to_variation = false
}