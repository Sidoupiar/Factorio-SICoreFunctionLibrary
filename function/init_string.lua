function string:Split( separator )
	if separator == "" then return { self } end
	local pos = 0
	local list = {}
	for st , sp in function() return self:find( separator , pos , true ) end do
		table.insert( list , self:sub( pos , st-1 ) )
		pos = sp + 1
	end
	table.insert( list , self:sub( pos ) )
	return list
end

function string:ToABlist()
	if self and self ~= "" then
		local list = self:Split( ";" )
		if #list > 0 then
			local item
			local items = {}
			for i , v in pairs( list ) do
				if v and v ~= "" then
					item = v:Split( "," )
					if item[1] ~= "" and item[2] ~= "" and tonumber( item[2] ) then
						item[2] = math.ceil( item[2] )
						items[item[1]] = item[2] < 1 and 1 or item[2]
					end
				end
			end
			return items
		else return {} end
	else return {} end
end

function string:Spos( pos )
	self = self or ""
	return self .. pos.x .. "," .. pos.y
end

function string:Level()
	return tonumber( self:sub( -1 ) )
end

function string:LastLevel()
	return self:sub( 0 , -2 ) .. ( self:Level() - 1 )
end

function string:GetEnergyClass()
	local class = ""
	local value = self
	local pos , _ = value:find( "[a-zA-Z]" )
	if pos then
		class = value:sub( pos )
		value = value:sub( 1 , pos-1 )
	end
	return tonumber( value ) , class
end