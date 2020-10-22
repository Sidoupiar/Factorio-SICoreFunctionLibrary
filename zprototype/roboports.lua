local function hit_effects_entity( offset_deviation , offset )
	local offset = offet or { 0 , 1 }
	return
	{
		type = "create-entity" ,
		entity_name = "spark-explosion" ,
		offset_deviation = offset_deviation or { { -0.5 , -0.5 } , { 0.5 , 0.5 } } ,
		offsets = { offset } ,
		damage_type_filters = "fire"
	}
end

local function copy_p( p , w )
	local np = table.deepcopy( p )
	for i , v in pairs( np ) do np[i] = v .. w end
	return np
end

local sounds_generic_impact = {}
for i = 2 , 6 , 1 do table.insert( sounds_generic_impact , { filename = "__base__/sound/car-metal-impact-" .. i .. ".ogg" , volume = 0.5 } ) end



local function add_pic_roboport( r , l , p , w )
	sicfl_armor_base_data( r )
	r.flags = { "placeable-player" , "player-creation" }
	r.charge_approach_distance = 4
	r.logistics_radius = 64
	r.robot_slots_count = 10
	r.material_slots_count = 10
	r.energy_usage = "10MW"
	r.charging_energy = "10MW"
	r.recharge_minimum = "0J"
	r.stationing_offset = { 0 , 0 }
	r.collision_box = { { -1.7 , -1.7 } , { 1.7 , 1.7 } }
	r.selection_box = { { -2 , -2 } , { 2 , 2 } }
	r.charging_offsets = { { -1.5 , -0.5 } , { 1.5 , -0.5 } , { 1.5 , 1.5 } , { -1.5 , 1.5 } }
	r.corpse = "roboport-remnants"
	r.dying_explosion = "roboport-explosion"
	r.energy_source =
	{
		type = "void" ,
		buffer_capacity = "1TJ"
	}
	r.request_to_open_door_timeout = 15
	r.spawn_and_station_height = -0.1
	r.recharging_light = { intensity = 0.4 , size = 5 , color = { r = 1 , g = 1 , b = 1 } }
	r.draw_logistic_radius_visualization = true
	r.draw_construction_radius_visualization = true
	r.circuit_wire_max_distance = 64
	r.circuit_wire_connection_point = circuit_connector_definitions["roboport"].points
	r.circuit_connector_sprites = circuit_connector_definitions["roboport"].sprites
	r.default_available_logistic_output_signal = { type = "virtual" , name = "signal-X" }
	r.default_total_logistic_output_signal = { type = "virtual" , name = "signal-Y" }
	r.default_available_construction_output_signal = { type = "virtual" , name = "signal-Z" }
	r.default_total_construction_output_signal = { type = "virtual" , name = "signal-T" }
	r.damaged_trigger_effect = hit_effects_entity()
	r.vehicle_impact_sound = sounds_generic_impact
	r.working_sound =
	{
		sound = { filename = "__base__/sound/roboport-working.ogg" , volume = 0.8 } ,
		max_sounds_per_type = 3 ,
		audible_distance_modifier = 0.5
	}
	r.open_door_trigger_effect =
	{
		{
			type = "play-sound" ,
			sound = { filename = "__base__/sound/roboport-door.ogg" , volume = 0.3 , min_speed = 1 , max_speed = 1.5 }
		}
	}
	r.close_door_trigger_effect =
	{
		{
			type = "play-sound" ,
			sound = { filename = "__base__/sound/roboport-door-close.ogg" , volume = 0.3 , min_speed = 1 , max_speed = 1.5 }
		}
	}
	local pic
	for i , v in pairs( l ) do
		pic = r.base.layers[i]
		if pic then
			pic.filename = v .. ".png"
			if pic.hr_version then
				pic.hr_version.filename = v .. "-hr.png"
				pic.hr_version.scale = 0.5
			end
		end
	end
	for k , v in pairs( p ) do
		pic = r[k]
		if pic then
			pic.filename = v .. ".png"
			if not pic.priority then pic.priority = "medium" end
			if pic.hr_version then
				pic.hr_version.filename = v .. "-hr.png"
				pic.hr_version.scale = 0.5
				if not pic.hr_version.priority then pic.hr_version.priority = "medium" end
			end
		end
	end
	r.water_reflection.pictures.filename = w
end



local pti = { type = "item" }
pti.name = "sicfl-ancient-armor-roboport"
pti.icon = "__SICoreFunctionLibrary__/zpics/items/ancient-armor-roboport.png"
pti.stack_size = 200

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

local pt = { type = "roboport" }
pt.name = "sicfl-ancient-armor-roboport"
pt.icon = "__SICoreFunctionLibrary__/zpics/items/ancient-armor-roboport.png"
pt.construction_radius = 128
pt.base =
{
	layers =
	{
		{
			width = 143 ,
			height = 135 ,
			shift = { 0.5 , 0.25 } ,
			hr_version =
			{
				width = 228 ,
				height = 277 ,
				shift = util.by_pixel( 2 , 7.75 )
			}
		} ,
		{
			width = 147 ,
			height = 101 ,
			draw_as_shadow = true ,
			shift = util.by_pixel( 28.5 , 19.25 ) ,
			hr_version =
			{
				width = 294 ,
				height = 201 ,
				draw_as_shadow = true ,
				force_hr_shadow = true ,
				shift = util.by_pixel( 28.5 , 19.25 )
			}
		}
	}
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
add_pic_roboport( pt , ptl , ptp , "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-roboport/ancient-armor-roboport-reflection.png" )



local psi = table.deepcopy( pti )
psi.name = "sicfl-ancient-armor-roboport-super"
psi.icon = "__SICoreFunctionLibrary__/zpics/items/ancient-armor-roboport-super.png"

local ps = table.deepcopy( pt )
ps.name = "sicfl-ancient-armor-roboport-super"
ps.icon = "__SICoreFunctionLibrary__/zpics/items/ancient-armor-roboport-super.png"
ps.construction_radius = 3200
add_pic_roboport( ps , copy_p( ptl , "-super" ) , copy_p( ptp , "-super" ) , "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-roboport/ancient-armor-roboport-reflection-super.png" )



return { pti , pt , psi , ps }