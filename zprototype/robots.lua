local hitEffect =
{
	type = "create-entity" ,
	entity_name = "flying-robot-damaged-explosion" ,
	offset_deviation = offset_deviation or { { -0.25 , -0.25 } , { 0.25 , 0.25 } } ,
	offsets = { { 0 , 0 } } ,
	damage_type_filters = "fire"
}
local dyingEffect =
{
	{
		type = "create-particle" ,
		particle_name = SITypes.entity.robotConstruct .. "-dying-particle" ,
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
local smoke =
{
	filename = "__base__/graphics/entity/smoke-construction/smoke-01.png" ,
	width = 39 ,
	height = 32 ,
	frame_count = 19 ,
	line_length = 19 ,
	shift = { 0.078125 , -0.15625} ,
	animation_speed = 0.3
}
local customData =
{
	selection_box = { { -0.5 , -0.5 } , { 0.5 , -0.5 } } ,
	hit_visualization_box = { { -0.1 , -1.1 } , { 0.1 , -1 } } ,
	cargo_centered = { 0 , 0.2 } ,
	speed_multiplier_when_out_of_energy = 0.2 ,
	min_to_charge = 0.2 ,
	max_to_charge = 0.95 ,
	damaged_trigger_effect = hitEffect
}



local constructionSound = {}
for i = 1 , 9 , 1 do table.insert( constructionSound , { filename = "__base__/sound/construction-robot-" .. i .. ".ogg" , volume = 0.7 } ) end

SIGen.NewRobotConstruction( "robot-construction" )
.SetStackSize( 10000 )
.SetProperties( 0 , 0 , 100 , 0.45 , "1J" , { "0J" , "0J" } , 1 )
.SetCorpse( nil , "construction-robot-explosion" , dyingEffect )
.SetPic( "smoke" , smoke )
.SetPic( "idle" ,  )
.SetPic( "idle_with_cargo" ,  )
.SetPic( "in_motion" ,  )
.SetPic( "in_motion_with_cargo" ,  )
.SetPic( "shadow_idle" ,  )
.SetPic( "shadow_idle_with_cargo" ,  )
.SetPic( "shadow_in_motion" ,  )
.SetPic( "shadow_in_motion_with_cargo" ,  )
.SetPic( "working" ,  )
.SetPic( "shadow_working" ,  )
.SetCustomData( customData )
.SetCustomData
{
	repair_speed_modifier = 100 ,
	construction_vector = { 0.3 , 0.22 } ,
	working_sound =
	{
		sound = constructionSound ,
		max_sounds_per_type = 5 ,
		audible_distance_modifier = 1 ,
		probability = 1 / 600
	}
}
.AddSuperArmor()

local flyingSound = {}
for i = 1 , 5 , 1 do table.insert( flyingSound , { filename = "__base__/sound/flying-robot-" .. i .. ".ogg" , volume = 0.5 } ) end

SIGen.NewRobotLogistic( "robot-logistic" )
.SetStackSize( 10000 )
.SetProperties( 0 , 0 , 100 , 0.45 , "1J" , { "0J" , "0J" } , 10 )
.SetCorpse( nil , "logistic-robot-explosion" , dyingEffect )
.SetPic( "idle" ,  )
.SetPic( "idle_with_cargo" ,  )
.SetPic( "in_motion" ,  )
.SetPic( "in_motion_with_cargo" ,  )
.SetPic( "shadow_idle" ,  )
.SetPic( "shadow_idle_with_cargo" ,  )
.SetPic( "shadow_in_motion" ,  )
.SetPic( "shadow_in_motion_with_cargo" ,  )
.SetCustomData( customData )
.SetCustomData
{
	working_sound =
	{
		sound = flyingSound ,
		max_sounds_per_type = 5 ,
		audible_distance_modifier = 1 ,
		probability = 1 / 600
	}
}
.AddSuperArmor()







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
end



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

cr.sparks = cr_sparks
cr.idle =
{
	line_length = 16 ,
	width = 32 ,
	height = 36 ,
	frame_count = 1 ,
	shift = util.by_pixel( 0 , -4.5 ) ,
	direction_count = 16
}
cr.in_motion =
{
	line_length = 16 ,
	width = 32 ,
	height = 36 ,
	frame_count = 1 ,
	shift = util.by_pixel( 0 , -4.5 ) ,
	direction_count = 16 ,
	y = 36
}
cr.shadow_idle =
{
	line_length = 16 ,
	width = 53 ,
	height = 25 ,
	frame_count = 1 ,
	shift = util.by_pixel( 33.5 , 18.5 ) ,
	direction_count = 16 ,
	draw_as_shadow = true
}
cr.shadow_in_motion =
{
	line_length = 16 ,
	width = 53 ,
	height = 25 ,
	frame_count = 1 ,
	shift = util.by_pixel( 33.5 , 18.5 ) ,
	direction_count = 16 ,
	draw_as_shadow = true
}
cr.working =
{
	line_length = 2 ,
	width = 28 ,
	height = 36 ,
	frame_count = 2 ,
	shift = util.by_pixel( -0.25 , -5 ) ,
	direction_count = 16 ,
	animation_speed = 0.3
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
	draw_as_shadow = true
}


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

lr.idle =
{
	line_length = 16 ,
	width = 41 ,
	height = 42 ,
	frame_count = 1 ,
	shift = util.by_pixel( 0 , -3 ) ,
	direction_count = 16 ,
	y = 42
}
lr.idle_with_cargo =
{
	line_length = 16 ,
	width = 41 ,
	height = 42 ,
	frame_count = 1 ,
	shift = util.by_pixel( 0 , -3 ) ,
	direction_count = 16
}
lr.in_motion =
{
	line_length = 16 ,
	width = 41 ,
	height = 42 ,
	frame_count = 1 ,
	shift = util.by_pixel( 0 , -3 ) ,
	direction_count = 16 ,
	y = 126
}
lr.in_motion_with_cargo =
{
	line_length = 16 ,
	width = 41 ,
	height = 42 ,
	frame_count = 1 ,
	shift = util.by_pixel( 0 , -3 ) ,
	direction_count = 16 ,
	y = 84
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
	draw_as_shadow = true
}
lr.shadow_idle_with_cargo =
{
	line_length = 16 ,
	width = 58 ,
	height = 29 ,
	frame_count = 1 ,
	shift = util.by_pixel( 32 , 19.5 ) ,
	direction_count = 16 ,
	draw_as_shadow = true
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
	draw_as_shadow = true
}
lr.shadow_in_motion_with_cargo =
{
	line_length = 16 ,
	width = 58 ,
	height = 29 ,
	frame_count = 1 ,
	shift = util.by_pixel( 32 , 19.5 ) ,
	direction_count = 16 ,
	draw_as_shadow = true
}