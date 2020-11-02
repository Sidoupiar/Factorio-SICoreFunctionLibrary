-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local inserter =
{
	hasData = false ,
	changeData =
	{
		ClearIcon = nil
	} ,
	insertData =
	{
		InsertIcon = nil
	}
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 内部处理 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function inserter.HasData()
	return inserter.hasData
end

function inserter.InsertData( entity )
	if inserter.HasData() then
		for k , v in pairs( inserter.changeData ) do
			if v then
				for n , m in pairs( v ) do entity["Change_"..k]( entity , m ) end
			end
		end
		for k , v in pairs( inserter.insertData ) do
			if v then
				for n , m in pairs( v ) do entity["Inserter_"..k]( entity , m ) end
			end
		end
	end
	return SIGen
end

-- ------------------------------------------------------------------------------------------------
-- -------- 创建附加数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function inserter.Clear()
	inserter.hasData = false
	or k , v in pairs( inserter.changeData ) do if v then inserter.changeData[k] = nil end end
	for k , v in pairs( inserter.insertData ) do if v then inserter.insertData[k] = nil end end
	return SIGen
end

function inserter.ClearIcon()
	
end

function inserter.InsertIcon( index , iconPath , tint , mipmaps )
	local icon = inserter.insertData.InsertIcon
	if not icon then
		icon = {}
		inserter.hasData = true
		inserter.insertData.InsertIcon = icon
	end
	table.insert( icon , { index = index , iconPath = iconPath , tint = tint , mipmaps = mipmaps } )
	return SIGen
end

return inserter