-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local inserter =
{
	hasData = false ,
	changeData =
	{
		clearIcons = nil
	} ,
	insertData =
	{
		insertIcons = nil
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
-- ----------- 数据器 -----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function inserter.GetInsertData_insertIcons()
	local icons = inserter.insertData.insertIcons
	if not icons then
		icons = {}
		inserter.hasData = true
		inserter.insertData.insertIcons = icons
	end
	return icons
end

-- ------------------------------------------------------------------------------------------------
-- -------- 创建附加数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function inserter.Clear()
	inserter.hasData = false
	for k , v in pairs( inserter.changeData ) do if v then inserter.changeData[k] = nil end end
	for k , v in pairs( inserter.insertData ) do if v then inserter.insertData[k] = nil end end
	return SIGen
end

function inserter.ClearIcons()
	if not inserter.changeData.clearIcons then
		inserter.hasData = true
		inserter.changeData.clearIcons = true
	end
	return SIGen
end

function inserter.InsertIcon( index , iconPath , tint , mipmaps , scale , shift , size )
	local iconData = SIPackers.Icon( iconPath , tint , mipmaps , scale , shift , size )
	iconData.index = index
	table.insert( inserter.GetInsertData_insertIcons() , iconData )
	return SIGen
end

function inserter.InsertIconFromIconList( index , list , scale , shift )
	index = index - 1
	for i , icon in pairs( list ) do
		local iconScale = scale
		local iconShift = table.deepcopy( shift )
		if icon.shift then
			for k , v in pairs( iconShift ) do iconShift[k] = v + icon.shift[k] * iconScale end
		end
		if icon.scale then iconScale = iconScale * icon.scale end
		inserter.InsertIcon( index+i , icon.icon , icon.tint , icon.icon_mipmaps , iconScale , iconShift , icon.icon_size )
	end
	return SIGen
end

function inserter.InsertIconFromData( index , data , scale , shift )
	if data.icon then inserter.InsertIcon( index , data.icon , nil , data.icon_mipmaps , scale , shift , data.icon_size )
	elseif data.icons then inserter.InsertIconFromIconList( index , data.icons , scale , shift ) end
	return SIGen
end

return inserter