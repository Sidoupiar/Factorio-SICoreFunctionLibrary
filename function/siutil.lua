SIUtils = {}

function SIUtils.Spos( pos )
	return pos.x .. "," .. pos.y
end

function SIUtils.MapAllValueToList( map , list )
	if not list then list = {} end
	for k , v in pairs( map ) do
		if type( v ) == "table" then SIUtils.MapAllValueToList( v , list )
		elseif not table.Has( list , v ) then table.insert( list , v ) end
	end
	return list
end

function SIUtils.MapValueToList( map )
	local list = {}
	for k , v in pairs( map ) do if not table.Has( list , v ) then table.insert( list , v ) end end
	return list
end