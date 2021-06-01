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
	local list = game.get_filtered_item_prototypes{ { filter = "name" , name = { name , baseName } } }
	if list[name] then return name
	elseif list[baseName] then return baseName
	else e( "名称查询器[SIFinder] : 通过名称 ["..baseName.."] 未找到有效的物品" ) end
end

function SIFinder.Entity( baseName , type )
	local name = SIFinder.CreateName( baseName , type or SITypes.entity.simpleEntity )
	local list = game.get_filtered_item_prototypes{ { filter = "name" , name = { name , baseName } } }
	if list[name] then return name
	elseif list[baseName] then return baseName
	else e( "名称查询器[SIFinder] : 通过名称 ["..baseName.."] 未找到有效的实体" ) end
end

function SIFinder.Recipe( baseName )
	local name = SIFinder.CreateName( baseName , SITypes.recipe )
	local list = game.get_filtered_item_prototypes{ { filter = "name" , name = { name , baseName } } }
	if list[name] then return name
	elseif list[baseName] then return baseName
	else e( "名称查询器[SIFinder] : 通过名称 ["..baseName.."] 未找到有效的配方" ) end
end

function SIFinder.Technology( baseName )
	local name = SIFinder.CreateName( baseName , SITypes.technology )
	local list = game.get_filtered_item_prototypes{ { filter = "name" , name = { name , baseName } } }
	if list[name] then return name
	elseif list[baseName] then return baseName
	else e( "名称查询器[SIFinder] : 通过名称 ["..baseName.."] 未找到有效的科技" ) end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 功能方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIFinder.CreateName( baseName , type )
	return SITypes.CreateName( SIFinder.currentConstantsData , baseName , type )
end