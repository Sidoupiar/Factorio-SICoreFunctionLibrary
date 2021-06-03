-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIFinder =
{
	currentConstantsData
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 通用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 需要先注册 ConstantsData
function SIFinder.Init( ConstantsData )
	SIFinder.currentConstantsData = ConstantsData
	return SIFinder
end



function SIFinder.Item( baseName , type )
	local name = SIFinder.CreateName( baseName , type or SITypes.item.item )
	return SIFinder.Check( name , baseName , "item" , "物品" )
end

function SIFinder.Fluid( baseName )
	local name = SIFinder.CreateName( baseName , SITypes.fluid )
	return SIFinder.Check( name , baseName , "fluid" , "流体" )
end

function SIFinder.Equipment( baseName )
	local name = SIFinder.CreateName( baseName , SITypes.equipment.base )
	return SIFinder.Check( name , baseName , "equipment" , "装甲模块" )
end

function SIFinder.Entity( baseName , type )
	local name = SIFinder.CreateName( baseName , type or SITypes.entity.simpleEntity )
	return SIFinder.Check( name , baseName , "entity" , "实体" )
end

function SIFinder.Tile( baseName )
	local name = SIFinder.CreateName( baseName , SITypes.tile )
	return SIFinder.Check( name , baseName , "tile" , "地板" )
end

function SIFinder.Recipe( baseName )
	local name = SIFinder.CreateName( baseName , SITypes.recipe )
	return SIFinder.Check( name , baseName , "recipe" , "配方" )
end

function SIFinder.Technology( baseName )
	local name = SIFinder.CreateName( baseName , SITypes.technology )
	return SIFinder.Check( name , baseName , "technology" , "科技" )
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 功能方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIFinder.CreateName( baseName , type )
	return SITypes.CreateName( SIFinder.currentConstantsData , baseName , type )
end

function SIFinder.Check( name , baseName , typeCode , typeMessage )
	if game then
		--local list = game["get_filtered_"..typeCode.."_prototypes"]{ { filter = "name" , name = { name , baseName } } }
		local list = game[typeCode.."_prototypes"]
		if list[name] then return name
		elseif list[baseName] then return baseName
		else
			e( "名称查询器[SIFinder] : 通过名称 ["..baseName.."] 未找到有效的"..typeMessage )
			return nil
		end
	else return name end
end