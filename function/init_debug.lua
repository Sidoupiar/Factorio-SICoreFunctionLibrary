function debug.TableToString( data , level )
	if type( data ) ~= "table" then e( "数据类型错误：无法对非 table 类型的数据进行转换" ) end
	if not level then level = 1 end
	local levelSpace = ""
	for i = 1 , level , 1 do levelSpace = levelSpace .. "    " end
	local size = 1
	local maxSize = table.Size( data )
	local s = level == 1 and "\n{" or "{"
	for k , v in pairs( data ) do
		s = s .. "\n" .. levelSpace .. ( type( k ) == "number" and "" or ( tostring( k ) .. " : " ) )
		if type( v ) == "table" then s = s .. debug.TableToString( v , level+1 )
		else s = s .. tostring( v ) end
		if size < maxSize then s = s .. " ," end
		size = size + 1
	end
	s = s .. "\n"
	for i = 1 , level-1 , 1 do s = s .. "    " end
	return s .. "}"
end