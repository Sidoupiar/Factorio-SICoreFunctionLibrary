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

function SIUtils.GetNumberLength( number )
	number = math.abs( number )
	local length = 0
	while number > 0 do
		length = length + 1
		number = math.floor( number/10 )
	end
	return length
end

function SIUtils.NumberToString( number , length )
	local str = "" .. number
	while str:len() < length do
		str = "0" .. str
	end
	return str
end

function SIUtils.PointsBorder( width , height )
	local points = {}
	local xMax = width - 1
	local yMax = height - 1
	for x = 0 , xMax , 1 do
		table.insert( points , { x , 0 } )
		table.insert( points , { x , yMax } )
	end
	for y = 1 , yMax-1 , 1 do
		table.insert( points , { 0 , y } )
		table.insert( points , { xMax , y } )
	end
	return points
end