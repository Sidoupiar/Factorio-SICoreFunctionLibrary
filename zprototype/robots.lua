local function hit_effects_flying_robot( offset_deviation , offset )
	local offset = offset or { 0 , 0 }
	return
	{
		type = "create-entity" ,
		entity_name = "flying-robot-damaged-explosion" ,
		offset_deviation = offset_deviation or { { -0.25 , -0.25 } , { 0.25 , 0.25 } } ,
		offsets = { offset } ,
		damage_type_filters = "fire"
	}
end

local function sounds_construction_robot( volume )
	local sound = {}
	for i = 1 , 9 , 1 do table.insert( sound , { filename = "__base__/sound/construction-robot-" .. i .. ".ogg" , volume = volume } ) end
	return
	{
		sound = sound ,
		max_sounds_per_type = 5 ,
		audible_distance_modifier = 1 ,
		probability = 1 / 600
	}
end

local function sounds_flying_robot( volume )
	local sound = {}
	for i = 1 , 5 , 1 do table.insert( sound , { filename = "__base__/sound/flying-robot-" .. i .. ".ogg" , volume = volume } ) end
	return
	{
		sound = sound ,
		max_sounds_per_type = 5 ,
		audible_distance_modifier = 1 ,
		probability = 1 / 600
	}
end



local animation_shift = { 0 , 0 }
local shadow_shift = { -0.75 , -0.4 }

local function adjust_anim( anim )
	local anim = util.copy( anim )
	local layers = anim.layers or { anim }
	for k , v in pairs( layers ) do
		v.frame_count = v.direction_count
		v.direction_count = 0
		v.animation_speed = 1
		v.shift = util.add_shift( v.shift , animation_shift )
		if v.hr_version then
			v.hr_version.frame_count = v.hr_version.direction_count
			v.hr_version.direction_count = 0
			v.hr_version.animation_speed = 1
			v.hr_version.shift = util.add_shift( v.hr_version.shift , animation_shift )
		end
	end
	return anim
end

local function adjust_shadow( anim )
	local anim = util.copy( anim )
	local layers = anim.layers or { anim }
	for k , v in pairs( layers ) do
		v.frame_count = v.direction_count
		v.direction_count = 0
		v.animation_speed = 1
		v.shift = util.add_shift( v.shift , shadow_shift )
		if v.hr_version then
			v.hr_version.frame_count = v.hr_version.direction_count
			v.hr_version.direction_count = 0
			v.hr_version.animation_speed = 1
			v.hr_version.shift = util.add_shift( v.hr_version.shift , shadow_shift )
		end
	end
	return anim
end

local function reversed( anim )
	local anim = util.copy( anim )
	local layers = anim.layers or { anim }
	for k , v in pairs( layers ) do
		v.run_mode = "backward"
		if v.hr_version then v.hr_version.run_mode = "backward" end
	end
	return anim
end



local function add_pic_robot( r , p , w )
	sicfl_armor_base_data( r )
	r.flags = { "placeable-player" , "player-creation" , "placeable-off-grid" , "not-on-map" }
	r.speed = 0.35
	r.speed_multiplier_when_out_of_energy = 0.2
	r.min_to_charge = 0.2
	r.max_to_charge = 0.95
	r.max_energy = "1J"
	r.energy_per_tick = "0J"
	r.energy_per_move = "0J"
	r.collision_box = { { 0 , 0 } , { 0 , 0 } }
	r.selection_box = { { -0.5 , -1.5 } , { 0.5 , -0.5 } }
	r.hit_visualization_box = { { -0.1 , -1.1 } , { 0.1 , -1 } }
	r.cargo_centered = { 0 , 0.2 }
	r.damaged_trigger_effect = hit_effects_flying_robot()
	r.water_reflection = robot_reflection( 1 )
	local pic
	for k , v in pairs( p ) do
		pic = r[k]
		if pic then
			pic.filename = v .. ".png"
			pic.priority = "high"
			if pic.hr_version then
				pic.hr_version.filename = v .. "-hr.png"
				pic.hr_version.scale = 0.5
				pic.hr_version.priority = "high"
				if not pic.hr_version.shift then pic.hr_version.shift = pic.shift end
			end
		end
	end
	r.water_reflection.pictures.filename = w
	r.dying_trigger_effect =
	{
		{
			type = "create-particle" ,
			particle_name = r.type .. "-dying-particle" ,
			initial_height = 1.8 ,
			initial_vertical_speed = 0 ,
			frame_speed = 1 ,
			frame_speed_deviation = 0.5 ,
			speed_from_center = 0 ,
			speed_from_center_deviation = 0.2 ,
			offset_deviation = { { -0.01 , -0.01 } , { 0.01 , 0.01 } } ,
			offsets = { { 0 , 0.5 } }
		}
	}
end



local cri = { type = "item" }
cri.name = "sicfl-ancient-c-armor-robot"
cri.icon = "__SICoreFunctionLibrary__/zpics/items/ancient-c-armor-robot.png"
cri.stack_size = 5000

local crp =
{
	idle = "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-robot/ancient-c-armor-robot" ,
	idle_with_cargo = "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-robot/ancient-c-armor-robot" ,
	in_motion = "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-robot/ancient-c-armor-robot" ,
	in_motion_with_cargo = "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-robot/ancient-c-armor-robot" ,
	shadow_idle = "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-robot/ancient-c-armor-robot-shadow" ,
	shadow_idle_with_cargo = "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-robot/ancient-c-armor-robot-shadow" ,
	shadow_in_motion = "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-robot/ancient-c-armor-robot-shadow" ,
	shadow_in_motion_with_cargo = "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-robot/ancient-c-armor-robot-shadow" ,
	working = "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-robot/ancient-c-armor-robot-working" ,
	shadow_working = "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-robot/ancient-c-armor-robot-shadow"
}

local cr_sparks =
{
	{
		width = 39 ,
		height = 34 ,
		shift = { -0.109375 , 0.3125 }
	} ,
	{
		width = 36 ,
		height = 32 ,
		shift = { 0.03125 , 0.125 }
	} ,
	{
		width = 42 ,
		height = 29 ,
		shift = { -0.0625 , 0.203125 }
	} ,
	{
		width = 40 ,
		height = 35 ,
		shift = { -0.0625 , 0.234375 }
	} ,
	{
		width = 39 ,
		height = 29 ,
		shift = { -0.109375 , 0.171875 }
	} ,
	{
		width = 44 ,
		height = 36 ,
		shift = { 0.03125 , 0.3125 }
	}
}

for i , v in pairs( cr_sparks ) do
	v.filename = "__base__/graphics/entity/sparks/sparks-0" .. i .. ".png"
	v.frame_count = 19
	v.line_length = 19
	v.tint = { r = 1 , g = 0.9 , b = 0 , a = 1 }
	v.animation_speed = 0.3
end

local cr = { type = "construction-robot" }
cr.name = "sicfl-ancient-c-armor-robot"
cr.icon = "__SICoreFunctionLibrary__/zpics/items/ancient-c-armor-robot.png"
cr.max_payload_size = 1
cr.repair_speed_modifier = 100
cr.dying_explosion = "construction-robot-explosion"
cr.construction_vector = { 0.3 , 0.22 }
cr.working_light = { intensity = 0.8 , size = 3 , color = { r = 0.8 , g = 0.8 , b = 0.8 } }
cr.smoke =
{
	filename = "__base__/graphics/entity/smoke-construction/smoke-01.png" ,
	width = 39 ,
	height = 32 ,
	frame_count = 19 ,
	line_length = 19 ,
	shift = { 0.078125 , -0.15625} ,
	animation_speed = 0.3
}
cr.sparks = cr_sparks
cr.idle =
{
	line_length = 16 ,
	width = 32 ,
	height = 36 ,
	frame_count = 1 ,
	shift = util.by_pixel( 0 , -4.5 ) ,
	direction_count = 16 ,
	hr_version =
	{
		line_length = 16 ,
		width = 66 ,
		height = 76 ,
		frame_count = 1 ,
		direction_count = 16
	}
}
cr.in_motion =
{
	line_length = 16 ,
	width = 32 ,
	height = 36 ,
	frame_count = 1 ,
	shift = util.by_pixel( 0 , -4.5 ) ,
	direction_count = 16 ,
	y = 36 ,
	hr_version =
	{
		line_length = 16 ,
		width = 66 ,
		height = 76 ,
		frame_count = 1 ,
		direction_count = 16 ,
		y = 76
	}
}
cr.shadow_idle =
{
	line_length = 16 ,
	width = 53 ,
	height = 25 ,
	frame_count = 1 ,
	shift = util.by_pixel( 33.5 , 18.5 ) ,
	direction_count = 16 ,
	draw_as_shadow = true ,
	hr_version =
	{
		line_length = 16 ,
		width = 104 ,
		height = 49 ,
		frame_count = 1 ,
		shift = util.by_pixel( 33.5 , 18.75 ) ,
		direction_count = 16 ,
		draw_as_shadow = true
	}
}
cr.shadow_in_motion =
{
	line_length = 16 ,
	width = 53 ,
	height = 25 ,
	frame_count = 1 ,
	shift = util.by_pixel( 33.5 , 18.5 ) ,
	direction_count = 16 ,
	draw_as_shadow = true ,
	hr_version =
	{
		line_length = 16 ,
		width = 104 ,
		height = 49 ,
		frame_count = 1 ,
		shift = util.by_pixel( 33.5 , 18.75 ) ,
		direction_count = 16 ,
		draw_as_shadow = true
	}
}
cr.working =
{
	line_length = 2 ,
	width = 28 ,
	height = 36 ,
	frame_count = 2 ,
	shift = util.by_pixel( -0.25 , -5 ) ,
	direction_count = 16 ,
	animation_speed = 0.3 ,
	hr_version =
	{
		line_length = 2 ,
		width = 57 ,
		height = 74 ,
		frame_count = 2 ,
		direction_count = 16 ,
		animation_speed = 0.3
	}
}
cr.shadow_working =
{
	line_length = 16 ,
	width = 53 ,
	height = 25 ,
	frame_count = 1 ,
	repeat_count = 2 ,
	shift = util.by_pixel( 33.5 , 18.5 ) ,
	direction_count = 16 ,
	draw_as_shadow = true ,
	hr_version =
	{
		line_length = 16 ,
		width = 104 ,
		height = 49 ,
		frame_count = 1 ,
		repeat_count = 2 ,
		shift = util.by_pixel( 33.5 , 18.75 ) ,
		direction_count = 16 ,
		draw_as_shadow = true
	}
}
cr.working_sound = sounds_construction_robot( 0.7 )
add_pic_robot( cr , crp , "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-robot/ancient-armor-robot-reflection.png" )



local lri = { type = "item" }
lri.name = "sicfl-ancient-l-armor-robot"
lri.icon = "__SICoreFunctionLibrary__/zpics/items/ancient-l-armor-robot.png"
lri.stack_size = 5000

local lrp =
{
	idle = "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-robot/ancient-l-armor-robot" ,
	idle_with_cargo = "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-robot/ancient-l-armor-robot" ,
	in_motion = "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-robot/ancient-l-armor-robot" ,
	in_motion_with_cargo = "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-robot/ancient-l-armor-robot" ,
	shadow_idle = "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-robot/ancient-l-armor-robot-shadow" ,
	shadow_idle_with_cargo = "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-robot/ancient-l-armor-robot-shadow" ,
	shadow_in_motion = "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-robot/ancient-l-armor-robot-shadow" ,
	shadow_in_motion_with_cargo = "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-robot/ancient-l-armor-robot-shadow"
}

local lr = { type = "logistic-robot" }
lr.name = "sicfl-ancient-l-armor-robot"
lr.icon = "__SICoreFunctionLibrary__/zpics/items/ancient-l-armor-robot.png"
lr.max_payload_size = 10
lr.dying_explosion = "logistic-robot-explosion"
lr.idle =
{
	line_length = 16 ,
	width = 41 ,
	height = 42 ,
	frame_count = 1 ,
	shift = util.by_pixel( 0 , -3 ) ,
	direction_count = 16 ,
	y = 42 ,
	hr_version =
	{
		line_length = 16 ,
		width = 80 ,
		height = 84 ,
		frame_count = 1 ,
		direction_count = 16 ,
		y = 84
	}
}
lr.idle_with_cargo =
{
	line_length = 16 ,
	width = 41 ,
	height = 42 ,
	frame_count = 1 ,
	shift = util.by_pixel( 0 , -3 ) ,
	direction_count = 16 ,
	hr_version =
	{
		line_length = 16 ,
		width = 80 ,
		height = 84 ,
		frame_count = 1 ,
		direction_count = 16
	}
}
lr.in_motion =
{
	line_length = 16 ,
	width = 41 ,
	height = 42 ,
	frame_count = 1 ,
	shift = util.by_pixel( 0 , -3 ) ,
	direction_count = 16 ,
	y = 126 ,
	hr_version =
	{
		line_length = 16 ,
		width = 80 ,
		height = 84 ,
		frame_count = 1 ,
		direction_count = 16 ,
		y = 252
	}
}
lr.in_motion_with_cargo =
{
	line_length = 16 ,
	width = 41 ,
	height = 42 ,
	frame_count = 1 ,
	shift = util.by_pixel( 0 , -3 ) ,
	direction_count = 16 ,
	y = 84 ,
	hr_version =
	{
		line_length = 16 ,
		width = 80 ,
		height = 84 ,
		frame_count = 1 ,
		direction_count = 16 ,
		y = 168
	}
}
lr.shadow_idle =
{
	line_length = 16 ,
	width = 58 ,
	height = 29 ,
	frame_count = 1 ,
	shift = util.by_pixel( 32 , 19.5 ) ,
	direction_count = 16 ,
	y = 29 ,
	draw_as_shadow = true ,
	hr_version =
	{
		line_length = 16 ,
		width = 115 ,
		height = 57 ,
		frame_count = 1 ,
		shift = util.by_pixel( 31.75 , 19.75 ) ,
		direction_count = 16 ,
		y = 57 ,
		draw_as_shadow = true
	}
}
lr.shadow_idle_with_cargo =
{
	line_length = 16 ,
	width = 58 ,
	height = 29 ,
	frame_count = 1 ,
	shift = util.by_pixel( 32 , 19.5 ) ,
	direction_count = 16 ,
	draw_as_shadow = true ,
	hr_version =
	{
		line_length = 16 ,
		width = 115 ,
		height = 57 ,
		frame_count = 1 ,
		shift = util.by_pixel( 31.75 , 19.75 ) ,
		direction_count = 16 ,
		draw_as_shadow = true
	}
}
lr.shadow_in_motion =
{
	line_length = 16 ,
	width = 58 ,
	height = 29 ,
	frame_count = 1 ,
	shift = util.by_pixel( 32 , 19.5 ) ,
	direction_count = 16 ,
	y = 29 ,
	draw_as_shadow = true ,
	hr_version =
	{
		line_length = 16 ,
		width = 115 ,
		height = 57 ,
		frame_count = 1 ,
		shift = util.by_pixel( 31.75 , 19.75 ) ,
		direction_count = 16 ,
		y = 171 ,
		draw_as_shadow = true
	}
}
lr.shadow_in_motion_with_cargo =
{
	line_length = 16 ,
	width = 58 ,
	height = 29 ,
	frame_count = 1 ,
	shift = util.by_pixel( 32 , 19.5 ) ,
	direction_count = 16 ,
	draw_as_shadow = true ,
	hr_version =
	{
		line_length = 16 ,
		width = 115 ,
		height = 57 ,
		frame_count = 1 ,
		shift = util.by_pixel( 31.75 , 19.75 ) ,
		direction_count = 16 ,
		y = 114 ,
		draw_as_shadow = true
	}
}
lr.working_sound = sounds_flying_robot( 0.5 )
add_pic_robot( lr , lrp , "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-robot/ancient-armor-robot-reflection.png" )



return { cri , cr , lri , lr }