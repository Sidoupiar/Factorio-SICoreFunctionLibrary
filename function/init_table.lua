function table.Size( data )
	return table_size( data )
end

function table.HasKey( data , key )
	for k , v in pairs( data ) do
		if k == key then return true end
	end
	return false
end

function table.Has( data , value )
	for k , v in pairs( data ) do
		if v == value then return true end
	end
	return false
end

function table.GetWithName( data , name )
	for k , v in pairs( data ) do
		if v.name == name then return v end
	end
	return nil
end

function table.ShallowCopy( data )
	local new_data = {}
	for k , v in pairs( data ) do new_data[k] = v end
	return new_data
end