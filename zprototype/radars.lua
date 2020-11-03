local sounds_generic_impact = {}
for i = 2 , 6 , 1 do table.insert( sounds_generic_impact , { filename = "__base__/sound/car-metal-impact-" .. i .. ".ogg" , volume = 0.5 } ) end
local working_sound =
{
	sound = { filename = "__base__/sound/radar.ogg" , volume = 0.8 } ,
	max_sounds_per_type = 3 ,
	audible_distance_modifier = 0.8
}



local function CreateRadar( name , nearRadius , farRadius , nearEnergy , farEnergy )
	SIGen.NewRadar( name )
	.SetProperties( 3 , 3 , 100 , 0.01 , "10MW" , SIPackers.EnergySource() )
	.SetEffectRadius( nearRadius , farRadius )
	.SetEffectEnergy( nearEnergy , farEnergy )
	.SetCorpse( "radar-remnants" , "radar-explosion" )
	.SetCustomData
	{
		radius_minimap_visualisation_color = { r = 0.059 , g = 0.092 , b = 0.235 , a = 0.275 } ,
		vehicle_impact_sound = sounds_generic_impact ,
		working_sound = working_sound ,
	}
	.AddArmor()
end

CreateRadar( "radar-strategic" , 24 , 0 , "20MJ" , "1TJ" )
CreateRadar( "radar-sky-eye" , 60 , 0 , "20MJ" , "1TJ" )
CreateRadar( "radar-overload" , 150 , 0 , "20MJ" , "1TJ" )