-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SISounds =
{
	baseVolume = 1
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SISounds.Sound( file , volume , minSpeed , maxSpeed )
	local sound = { filename = file , volume = volume or SISounds.baseVolume }
	if minSpeed then sound.min_speed = minSpeed end
	if maxSpeed then sound.max_speed = maxSpeed end
	return sound
end

function SISounds.Sounds( fileOrList , volume , minSpeed , maxSpeed )
	local dataType = type( fileOrList )
	if dataType == "string" then return { SISounds.Sound( fileOrList , volume , minSpeed , maxSpeed ) }
	elseif dataType == "table" then
		local sounds = {}
		for i , v in pairs( fileOrList ) do table.insert( sounds , SISounds.Sound( v , volume , minSpeed , maxSpeed ) ) end
		return sounds
	else
		e( "模块构建 : Sounds 方法参数必须使用字符串/数组格式" )
		return nil
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 构造方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SISounds.Working( fileOrSoundList , volume , maxCount , distanceModifier , probability , matchVolumeToActivity , fadeInTicks , fadeOutTicks )
	local working = {}
	local dataType = type( fileOrSoundList )
	if dataType == "string" then working.sound = { SISounds.Sound( fileOrSoundList , volume ) }
	elseif dataType == "table" then
		if fileOrSoundList[1] and type( fileOrSoundList[1] ) == "string" then working.sound =  SISounds.Sounds( fileOrSoundList , volume )
		else working.sound = fileOrSoundList end
	else working.sound = fileOrSoundList end
	if maxCount then working.max_sounds_per_type = maxCount end
	if distanceModifier then working.audible_distance_modifier = distanceModifier end
	if probability then working.probability = probability end
	if matchVolumeToActivity then working.match_volume_to_activity = matchVolumeToActivity end
	if fadeInTicks then working.fade_in_ticks = fadeInTicks end
	if fadeOutTicks then working.fade_out_ticks = fadeOutTicks end
	return working
end

-- ------------------------------------------------------------------------------------------------
-- -------- 声音列表数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SISounds.BaseSoundList( soundName , count , volume , startIndex )
	volume = volume or SISounds.baseVolume
	startIndex = startIndex or 1
	local length = count + startIndex - 1
	local countLength = SIUtils.GetNumberLength( length )
	local soundList = {}
	for i = startIndex , length , 1 do table.insert( soundList , SISounds.Sound( "__base__/sound/"..soundName.."-"..SIUtils.NumberToString( i , countLength )..".ogg" , volume ) ) end
	return soundList
end

-- ------------------------------------------------------------------------------------------------
-- -------- 创建默认声音 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SISounds.sounds =
{
	vehicleImpact = SISounds.BaseSoundList( "car-metal-impact" , 5 , 0.5 , 2 ) ,
	machineOpen = SISounds.Sounds( "__base__/sound/machine-open.ogg" , 0.5 ) ,
	machineClose = SISounds.Sounds( "__base__/sound/machine-close.ogg" , 0.5 )
}