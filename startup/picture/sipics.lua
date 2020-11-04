-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIPics =
{
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPics.Layer( file , width , height , scale , hasHr )
	scale = scale or 1
	local layer =
	{
		filename = file .. ".png" ,
		width = width ,
		height = height
	}
	if scale ~= 1 then layer.scale = scale end
	if hasHr then layer.hr_version = SIPics.Layer( file , width*SINumbers.pictureHrScale , height*SINumbers.pictureHrScale , scale*SINumbers.pictureHrScaleDown ) end
	return layer
end

function SIPics.Shift( layer , shiftWidth , shiftHeight )
	shiftWidth = shiftWidth or 0
	shiftHeight = shiftHeight or 0
	if shiftWidth or shiftHeight then
		layer.shift = util.by_pixel( shiftWidth , shiftHeight )
		if layer.hr_version then layer.hr_version.shift = layer.shift end
	end
	return layer
end

function SIPics.ShiftMerge( layer , newShift )
	local shift = layer.shift or { 0 , 0 }
	layer.shift = { shift[1]+newShift[1] , shift[2]+newShift[2] }
	if layer.hr_version then layer.hr_version.shift = layer.shift end
	return layer
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础结构 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPics.BaseAnimLayer( file , width , height , hasHr , addenWidth , addenHeight )
	addenWidth = addenWidth or 0
	addenHeight = addenHeight or 0
	width = width * SINumbers.machinePictureSize + addenWidth
	height = height * SINumbers.machinePictureSize + addenHeight
	return SIPics.Shift( SIPics.Layer( file , width , height , 1 , hasHr ) , -addenWidth/2 , -addenHeight/2 )
end

-- ------------------------------------------------------------------------------------------------
-- -------- 补充图片结构 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPics.Patch( file , width , height , hasHr , addenWidth , addenHeight , location )
	local layer = SIPics.BaseAnimLayer( file.."-patch" , width , height , hasHr , addenWidth , addenHeight )
	layer.priority = "low"
	layer.direction_count = 1
	if hasHr then
		layer.hr_version.priority = "low"
		layer.hr_version.direction_count = 1
	end
	if location then layer = SIPics.ShiftMerge( layer , util.by_pixel( location[1] , location[2] ) ) end
	return layer
end

function SIPics.WaterReflection( file , width , height , location , rotate , orientation )
	local layer = SIPics.BaseAnimLayer( file.."-reflection" , width , height )
	if location then layer.shift = util.by_pixel( location[1] , location[2] ) end
	return
	{
		pictures = layer ,
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
	local layer = SIPics.BaseAnimLayer( file , width , height , hasHr , addenWidth , addenHeight )
	layer.line_length = lineLength
	layer.frame_count = frameCount
	layer.animation_speed = animSpeed
	if hasHr then
		layer.hr_version.line_length = lineLength
		layer.hr_version.frame_count = frameCount
		layer.hr_version.animation_speed = animSpeed
	end
	return layer
end

function SIPics.OnAnimLayerShadow( file , width , height , hasHr , addenWidth , addenHeight , lineLength , frameCount , animSpeed )
	local layer = SIPics.OnAnimLayer( file.."-shadow" , width , height , hasHr , addenWidth , addenHeight , lineLength , frameCount , animSpeed )
	layer.draw_as_shadow = true
	if hasHr then layer.hr_version.draw_as_shadow = true end
	return layer
end

function SIPics.OnAnimLayerShadowSingle( file , width , height , hasHr , addenWidth , addenHeight , frameCount )
	frameCount = frameCount or SINumbers.machinePictureTotalFrameCount
	local layer = SIPics.BaseAnimLayer( file.."-shadow" , width , height , hasHr , addenWidth , addenHeight )
	layer.repeat_count = frameCount
	layer.line_length = 1
	layer.frame_count = 1
	layer.draw_as_shadow = true
	if hasHr then
		layer.hr_version.repeat_count = frameCount
		layer.hr_version.line_length = 1
		layer.hr_version.frame_count = 1
		layer.hr_version.draw_as_shadow = true
	end
	return layer
end

function SIPics.OffAnimLayer( file , width , height , hasHr , addenWidth , addenHeight )
	local layer = SIPics.BaseAnimLayer( file , width , height , hasHr , addenWidth , addenHeight )
	layer.frame_count = 1
	if hasHr then layer.hr_version.frame_count = 1 end
	return layer
end

function SIPics.OffAnimLayerShadow( file , width , height , hasHr , addenWidth , addenHeight )
	local layer = SIPics.OffAnimLayer( file.."-shadow" , width , height , hasHr , addenWidth , addenHeight )
	layer.draw_as_shadow = true
	if hasHr then layer.hr_version.draw_as_shadow = true end
	return layer
end