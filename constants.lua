return
{
	name = "sicfl" ,
	settings =
	{
		writelog = { "bool" , "startup" , false } ,
		debug_tools = { "bool" , "startup" , false } ,
		can_get_debug_tools = { "bool" , "startup" , false } ,
		show_patreon = { "bool" , "startup" , true } ,
		debug = { "bool" , "runtime-global" , false } ,
		
		show_evolution = { "bool" , "runtime-per-user" , false } ,
		show_kill_count = { "bool" , "runtime-per-user" , false } ,
		show_time = { "bool" , "runtime-per-user" , false } ,
		show_game_speed = { "bool" , "runtime-per-user" , false }
	}
}