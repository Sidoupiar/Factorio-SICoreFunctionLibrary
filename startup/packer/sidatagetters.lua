-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIDataGetters =
{
	
}

-- ------------------------------------------------------------------------------------------------
-- -------- 获取开采结果 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIDataGetters.GetMiningResult( dataPack )
	if dataPack.minable then
		local minable = dataPack.minable
		if minable then
			if minable.result then return minable.result
			elseif minable.results then return minable.results[1].name
			else return nil end
		else return nil end
	else return nil end
end

function SIDataGetters.GetMiningResults( dataPack )
	local results = {}
	if dataPack.minable then
		local minable = dataPack.minable
		if minable then
			if minable.result then table.insert( results , minable.result )
			elseif minable.results then
				for i , v in pairs( minable.results ) do
					if v and v.name then table.insert( results , v.name ) end
				end
			end
		end
	end
	return results
end