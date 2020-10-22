function SetGlobalData( name , data )
	global[name] = data
end

function GetGlobalData( name )
	return global[name]
end