
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



local function add_pic_radar( r , l , p , w )
	SIGen.NewRadar( name )
	.SetProperties( 3 , 3 , 100 , 0.01 , "10MW" , SIPackers.EnergySource() )
	.SetCorpse( "radar-remnants" , "radar-explosion" )
	.AddArmor()
	
	sicfl_armor_base_data( r )
	r.radius_minimap_visualisation_color = { r = 0.059 , g = 0.092 , b = 0.235 , a = 0.275 }
	r.damaged_trigger_effect = hit_effects_entity()
	r.vehicle_impact_sound = sounds_generic_impact
	r.working_sound =
	{
		sound = { filename = "__base__/sound/radar.ogg" , volume = 0.8 } ,
		max_sounds_per_type = 3 ,
		audible_distance_modifier = 0.8 ,
	}
	local pic
	for i , v in pairs( l ) do
		pic = r.pictures.layers[i]
		if pic then
			pic.filename = v .. ".png"
			pic.priority = "low"
			if pic.hr_version then
				pic.hr_version.filename = v .. "-hr.png"
				pic.hr_version.priority = "low"
				pic.hr_version.scale = 0.5
				if not pic.hr_version.shift then pic.hr_version.shift = pic.shift end
			end
		end
	end
	for k , v in pairs( p ) do
		pic = r[k]
		if pic then
			pic.filename = v .. ".png"
			pic.priority = "low"
			if pic.hr_version then
				pic.hr_version.filename = v .. "-hr.png"
				pic.hr_version.priority = "low"
				pic.hr_version.scale = 0.5
				if not pic.hr_version.shift then pic.hr_version.shift = pic.shift end
			end
		end
	end
	r.water_reflection.pictures.filename = w
end

local rti = { type = "item" }
rti.name = "sicfl-ancient-armor-radar"
rti.icon = "__SICoreFunctionLibrary__/zpics/items/ancient-armor-radar.png"
rti.stack_size = 200

local rtl =
{
	"__SICoreFunctionLibrary__/zpics/entities/ancient-armor-radar/ancient-armor-radar" ,
	"__SICoreFunctionLibrary__/zpics/entities/ancient-armor-radar/ancient-armor-radar-shadow"
}

local rtp =
{
	integration_patch = "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-radar/ancient-armor-radar-integration"
}

local rt = { type = "radar" }
rt.name = "sicfl-ancient-armor-radar"
rt.icon = "__SICoreFunctionLibrary__/zpics/items/ancient-armor-radar.png"
rt.max_distance_of_nearby_sector_revealed = 10
rt.max_distance_of_sector_revealed = 0
rt.energy_per_nearby_scan = "20MJ"
rt.energy_per_sector = "1TJ"
rt.pictures =
{
	layers =
	{
		{
			width = 98 ,
			height = 128 ,
			apply_projection = false ,
			direction_count = 64 ,
			line_length = 8 ,
			shift = util.by_pixel( 1 , -16 ) ,
			hr_version =
			{
				width = 196 ,
				height = 254 ,
				apply_projection = false ,
				direction_count = 64 ,
				line_length = 8
			}
		} ,
		{
			width = 172 ,
			height = 94 ,
			apply_projection = false ,
			direction_count = 64 ,
			line_length = 8 ,
			shift = util.by_pixel( 39 , 3 ) ,
			draw_as_shadow = true,
			hr_version =
			{
				width = 343 ,
				height = 186 ,
				apply_projection = false ,
				direction_count = 64 ,
				line_length = 8 ,
				shift = util.by_pixel( 39.25 , 3 ) ,
				draw_as_shadow = true
			}
		}
	}
}
rt.integration_patch =
{
	width = 119 ,
	height = 108 ,
	direction_count = 1 ,
	shift = util.by_pixel( 1.5 , 4 ) ,
	hr_version =
	{
		width = 238 ,
		height = 216 ,
		direction_count = 1
	}
}
rt.water_reflection =
{
	pictures =
	{
		priority = "extra-high" ,
		width = 28 ,
		height = 32 ,
		shift = util.by_pixel( 5 , 35 ) ,
		variation_count = 1 ,
		scale = 5
	} ,
	rotate = false ,
	orientation_to_variation = false
}
add_pic_radar( rt , rtl , rtp , "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-radar/ancient-armor-radar-reflection.png" )



local rsi = table.deepcopy( rti )
rsi.name = "sicfl-ancient-armor-radar-super"
rsi.icon = "__SICoreFunctionLibrary__/zpics/items/ancient-armor-radar-super.png"

local rs = table.deepcopy( rt )
rs.name = "sicfl-ancient-armor-radar-super"
rs.icon = "__SICoreFunctionLibrary__/zpics/items/ancient-armor-radar-super.png"
rs.max_distance_of_nearby_sector_revealed = 100
rs.max_distance_of_sector_revealed = 0
rs.energy_per_nearby_scan = "20MJ"
rs.energy_per_sector = "1TJ"
add_pic_radar( rs , copy_p( rtl , "-super" ) , copy_p( rtp , "-super" ) , "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-radar/ancient-armor-radar-reflection-super.png" )



local rfi = table.deepcopy( rti )
rfi.name = "sicfl-ancient-armor-radar-finder"
rfi.icon = "__SICoreFunctionLibrary__/zpics/items/ancient-armor-radar-finder.png"

local rf = table.deepcopy( rt )
rf.name = "sicfl-ancient-armor-radar-finder"
rf.icon = "__SICoreFunctionLibrary__/zpics/items/ancient-armor-radar-finder.png"
rf.max_distance_of_nearby_sector_revealed = 0
rf.max_distance_of_sector_revealed = 60
rf.energy_per_nearby_scan = "8MJ"
rf.energy_per_sector = "500kJ"
add_pic_radar( rf , copy_p( rtl , "-finder" ) , copy_p( rtp , "-finder" ) , "__SICoreFunctionLibrary__/zpics/entities/ancient-armor-radar/ancient-armor-radar-reflection-finder.png" )



return { rti , rt , rsi , rs , rfi , rf }