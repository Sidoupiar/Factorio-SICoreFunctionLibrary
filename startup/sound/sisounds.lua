-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SISounds =
{
	baseVolume = 1 ,
	working =
	{
		maxCount = 5 ,
		distanceModifier = 1 ,
		probability = 1 / 600
	}
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SISounds.Sound( file , volume )
	return { filename = file , volume = volume }
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 构造方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SISounds.Working( soundList , maxCount , distanceModifier , probability )
	maxCount = maxCount or SISounds.working.maxCount
	distanceModifier = distanceModifier or SISounds.working.distanceModifier
	probability = probability or SISounds.working.probability
	return
	{
		sound = soundList ,
		max_sounds_per_type = maxCount ,
		audible_distance_modifier = distanceModifier ,
		probability = probability
	}
end

-- ------------------------------------------------------------------------------------------------
-- -------- 声音列表数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SISounds.BaseSoundList( soundName , count , volume )
	volume = volume or SISounds.baseVolume
	local soundList = {}
	for i = 1 , count , 1 do table.insert( soundList , SISounds.Sound( "__base__/sound/"..soundName.."-"..i..".ogg" , volume ) ) end
	return soundList
end