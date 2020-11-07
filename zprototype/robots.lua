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
local waterReflection =
{
	pictures = SIPics.NewLayer( "__base__/graphics/entity/construction-robot/construction-robot-reflection.png" , 12 , 12 , 5 ).Priority( "extra-high" ).Shift( 0 , 105 ).Variation( 1 ).Get() ,
	rotate = false ,
	orientation_to_variation = false
}
local customData =
{
	selection_box = { { -0.5 , -0.5 } , { 0.5 , -0.5 } } ,
	hit_visualization_box = { { -0.1 , -1.1 } , { 0.1 , -1 } } ,
	cargo_centered = { 0 , 0.2 } ,
	speed_multiplier_when_out_of_energy = 0.2 ,
	min_to_charge = 0.2 ,
	max_to_charge = 0.95 ,
	damaged_trigger_effect =
	{
		type = "create-entity" ,
		entity_name = "flying-robot-damaged-explosion" ,
		offset_deviation = offset_deviation or { { -0.25 , -0.25 } , { 0.25 , 0.25 } } ,
		offsets = { { 0 , 0 } } ,
		damage_type_filters = "fire"
	}
}

local function CreateSpark( sparkList )
	local sparks = {}
	for i , v in pairs( sparkList ) do table.insert( sparks , SIPics.NewLayer( "__base__/graphics/entity/sparks/sparks-0"..i..".png" , v[1] , v[2] ).Shift( v[3] , v[4] ).Anim( 19 , 19 , 0.3 ).Tint( 1 , 0.9 , 0 , 1 ).Get() ) end
	return sparks
end



local constructionSparks =
{
	{ 39 , 34 , -0.109375 , 0.3125 } ,
	{ 36 , 32 , 0.03125 , 0.125 } ,
	{ 42 , 29 , -0.0625 , 0.203125 } ,
	{ 40 , 35 , -0.0625 , 0.234375 } ,
	{ 39 , 29 , -0.109375 , 0.171875 } ,
	{ 44 , 36 , 0.03125 , 0.3125 }
}
local constructionSound = {}
for i = 1 , 9 , 1 do table.insert( constructionSound , { filename = "__base__/sound/construction-robot-" .. i .. ".ogg" , volume = 0.7 } ) end

SIGen.NewRobotConstruction( "robot-construction" )
.E.SetItemStackSize( 10000 )
.SetProperties( 0 , 0 , 100 , 0.45 , "1J" , { "0J" , "0J" } , 1 )
.SetCorpse( nil , "construction-robot-explosion" , dyingEffect )
.SetPic( "smoke" , SIPics.NewLayer( "__base__/graphics/entity/smoke-construction/smoke-01.png" , 39 , 32 ).Anim( 19 , 19 , 0.3 ).Get() )
.SetPic( "idle" , SIPics.NewLayer( SIGen.GetLayerFile() , 32 , 36 ).Priority( "high" ).Shift( 0 , -4.5 ).Anim( 16 , 1 , nil , 16 ).Get() )
.SetPic( "in_motion" , SIPics.NewLayer( SIGen.GetLayerFile() , 32 , 36 ).Priority( "high" ).Shift( 0 , -4.5 ).Anim( 16 , 1 , nil , 16 ).Y( 36 ).Get() )
.SetPic( "shadow_idle" , SIPics.NewLayer( SIGen.GetLayerFile().."-shadow" , 53 , 35 ).Priority( "high" ).Shift( 33.5 , 18.5 ).Anim( 16 , 1 , nil , 16 ).Shadow().Get() )
.SetPic( "shadow_in_motion" , SIPics.NewLayer( SIGen.GetLayerFile().."-shadow" , 53 , 35 ).Priority( "high" ).Shift( 33.5 , 18.5 ).Anim( 16 , 1 , nil , 16 ).Shadow().Get() )
.SetPic( "working" , SIPics.NewLayer( SIGen.GetLayerFile().."-working" , 28 , 36 ).Priority( "high" ).Shift( -0.25 , -5 ).Anim( 2 , 2 , 0.3 , 16 ).Get() )
.SetPic( "shadow_working" , SIPics.NewLayer( SIGen.GetLayerFile().."-shadow" , 53 , 35 ).Priority( "high" ).Shift( 33.5 , 18.5 ).Anim( 16 , 1 , nil , 16 ).Repeat( 2 ).Shadow().Get() )
.SetPic( "water_reflection" , waterReflection )
.SetCustomData( customData )
.SetCustomData
{
	repair_speed_modifier = 100 ,
	construction_vector = { 0.3 , 0.22 } ,
	sparks = CreateSpark( constructionSparks ) ,
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
.E.SetItemStackSize( 10000 )
.SetProperties( 0 , 0 , 100 , 0.45 , "1J" , { "0J" , "0J" } , 10 )
.SetCorpse( nil , "logistic-robot-explosion" , dyingEffect )
.SetPic( "idle" , SIPics.NewLayer( SIGen.GetLayerFile() , 41 , 42 ).Priority( "high" ).Shift( 0 , -3 ).Anim( 16 , 1 , nil , 16 ).Y( 42 ).Get() )
.SetPic( "idle_with_cargo" , SIPics.NewLayer( SIGen.GetLayerFile() , 41 , 42 ).Priority( "high" ).Shift( 0 , -3 ).Anim( 16 , 1 , nil , 16 ).Get() )
.SetPic( "in_motion" , SIPics.NewLayer( SIGen.GetLayerFile() , 41 , 42 ).Priority( "high" ).Shift( 0 , -3 ).Anim( 16 , 1 , nil , 16 ).Y( 126 ).Get() )
.SetPic( "in_motion_with_cargo" , SIPics.NewLayer( SIGen.GetLayerFile() , 41 , 42 ).Priority( "high" ).Shift( 0 , -3 ).Anim( 16 , 1 , nil , 16 ).Y( 84 ).Get() )
.SetPic( "shadow_idle" ,SIPics.NewLayer( SIGen.GetLayerFile().."-shadow" , 58 , 29 ).Priority( "high" ).Shift( 32 , 19.5 ).Anim( 16 , 1 , nil , 16 ).Y( 29 ).Shadow().Get()  )
.SetPic( "shadow_idle_with_cargo" , SIPics.NewLayer( SIGen.GetLayerFile().."-shadow" , 58 , 29 ).Priority( "high" ).Shift( 32 , 19.5 ).Anim( 16 , 1 , nil , 16 ).Shadow().Get() )
.SetPic( "shadow_in_motion" , SIPics.NewLayer( SIGen.GetLayerFile().."-shadow" , 58 , 29 ).Priority( "high" ).Shift( 32 , 19.5 ).Anim( 16 , 1 , nil , 16 ).Y( 29 ).Shadow().Get() )
.SetPic( "shadow_in_motion_with_cargo" , SIPics.NewLayer( SIGen.GetLayerFile().."-shadow" , 58 , 29 ).Priority( "high" ).Shift( 32 , 19.5 ).Anim( 16 , 1 , nil , 16 ).Shadow().Get() )
.SetPic( "water_reflection" , waterReflection )
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