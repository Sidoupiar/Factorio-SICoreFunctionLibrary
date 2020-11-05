-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local currentLayer = nil
SIPics =
{
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPics.NewLayer( file , width , height , scale , hasHr )
	scale = scale or 1
	currentLayer =
	{
		filename = file .. ".png" ,
		width = width ,
		height = height
	}
	if scale ~= 1 then currentLayer.scale = scale end
	if hasHr then
		currentLayer.hr_version =
		{
			file .. ".png" ,
			width = width * SINumbers.pictureHrScale ,
			height = height * SINumbers.pictureHrScale ,
			scale = scale * SINumbers.pictureHrScaleDown
		}
	end
	return SIPics
end

function SIPics.Get()
	return currentLayer
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础操作 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPics.Shift( shiftWidth , shiftHeight )
	shiftWidth = shiftWidth or 0
	shiftHeight = shiftHeight or 0
	if shiftWidth or shiftHeight then
		currentLayer.shift = util.by_pixel( shiftWidth , shiftHeight )
		if currentLayer.hr_version then currentLayer.hr_version.shift = currentLayer.shift end
	end
	return SIPics
end

function SIPics.ShiftMerge( newShift )
	local shift = currentLayer.shift or { 0 , 0 }
	currentLayer.shift = { shift[1]+newShift[1] , shift[2]+newShift[2] }
	if currentLayer.hr_version then currentLayer.hr_version.shift = currentLayer.shift end
	return SIPics
end

function SIPics.Priority( priority )
	currentLayer.priority = priority
	if currentLayer.hr_version then currentLayer.hr_version.priority = priority end
	return SIPics
end

function SIPics.Frame( frameCount )
	frameCount = frameCount or 1
	currentLayer.frame_count = frameCount
	if currentLayer.hr_version then currentLayer.hr_version.frame_count = frameCount end
	return SIPics
end

function SIPics.Anim( lineLength , frameCount , animSpeed )
	lineLength = lineLength or 1
	frameCount = frameCount or 1
	animSpeed = animSpeed or 1
	currentLayer.line_length = lineLength
	currentLayer.frame_count = frameCount
	currentLayer.animation_speed = animSpeed
	if currentLayer.hr_version then
		currentLayer.hr_version.line_length = lineLength
		currentLayer.hr_version.frame_count = frameCount
		currentLayer.hr_version.animation_speed = animSpeed
	end
	return SIPics
end

function SIPics.Repeat( frameCount )
	frameCount = frameCount or 1
	currentLayer.repeat_count = frameCount
	currentLayer.line_length = 1
	currentLayer.frame_count = 1
	if currentLayer.hr_version then
		currentLayer.hr_version.repeat_count = frameCount
		currentLayer.hr_version.line_length = 1
		currentLayer.hr_version.frame_count = 1
	end
	return SIPics
end

function SIPics.Shadow()
	currentLayer.draw_as_shadow = true
	if currentLayer.hr_version then currentLayer.hr_version.draw_as_shadow = true end
	return SIPics
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础结构 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPics.BaseAnimLayer( file , width , height , hasHr , addenWidth , addenHeight )
	addenWidth = addenWidth or 0
	addenHeight = addenHeight or 0
	width = width * SINumbers.machinePictureSize + addenWidth
	height = height * SINumbers.machinePictureSize + addenHeight
	return SIPics.NewLayer( file , width , height , 1 , hasHr ).Shift( -addenWidth/2 , -addenHeight/2 )
end

-- ------------------------------------------------------------------------------------------------
-- -------- 补充图片结构 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPics.Patch( file , width , height , hasHr , addenWidth , addenHeight , location )
	SIPics.BaseAnimLayer( file.."-patch" , width , height , hasHr , addenWidth , addenHeight ).Priority( "low" )
	currentLayer.frame_count = 1
	currentLayer.direction_count = 1
	if hasHr then
		currentLayer.hr_version.frame_count = 1
		currentLayer.hr_version.direction_count = 1
	end
	if location then SIPics.ShiftMerge( util.by_pixel( location[1] , location[2] ) ) end
	return SIPics
end

function SIPics.WaterReflection( file , width , height , location , rotate , orientation )
	SIPics.BaseAnimLayer( file.."-reflection" , width , height )
	currentLayer.variation_count = 1
	if location then currentLayer.shift = util.by_pixel( location[1] , location[2] ) end
	return
	{
		pictures = currentLayer ,
		rotate = rotate,
		orientation_to_variation = orientation
	}
end

-- ------------------------------------------------------------------------------------------------
-- -------- 动画图片结构 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPics.OnAnimLayer( file , width , height , hasHr , addenWidth , addenHeight , lineLength , frameCount , animSpeed )
	lineLength = lineLength or SINumbers.machinePictureTotalWidth
	frameCount = frameCount or SINumbers.machinePictureTotalFrameCount
	animSpeed = animSpeed or SINumbers.machineAnimationSpeed
	return SIPics.BaseAnimLayer( file , width , height , hasHr , addenWidth , addenHeight ).Anim( lineLength , frameCount , animSpeed )
end

function SIPics.OnAnimLayerShadow( file , width , height , hasHr , addenWidth , addenHeight , lineLength , frameCount , animSpeed )
	return SIPics.OnAnimLayer( file.."-shadow" , width , height , hasHr , addenWidth , addenHeight , lineLength , frameCount , animSpeed ).Shadow()
end

function SIPics.OnAnimLayerShadowSingle( file , width , height , hasHr , addenWidth , addenHeight , frameCount )
	frameCount = frameCount or SINumbers.machinePictureTotalFrameCount
	return SIPics.BaseAnimLayer( file.."-shadow" , width , height , hasHr , addenWidth , addenHeight ).Shadow().Repeat( frameCount )
end

function SIPics.OffAnimLayer( file , width , height , hasHr , addenWidth , addenHeight )
	return SIPics.BaseAnimLayer( file , width , height , hasHr , addenWidth , addenHeight ).Frame()
end

function SIPics.OffAnimLayerShadow( file , width , height , hasHr , addenWidth , addenHeight )
	return SIPics.OffAnimLayer( file.."-shadow" , width , height , hasHr , addenWidth , addenHeight ).Shadow()
end