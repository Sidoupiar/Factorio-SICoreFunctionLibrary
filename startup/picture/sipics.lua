SIPics =
{
}



function SIPics.BaseAnimLayer( path , baseName , width , height , scale , hasHr , pixelPerLength )
	if not scale then scale = 1.0 end
	if not pixelPerLength then pixelPerLength = SINumbers.machinePictureSize end
	local layer = 
	{
		filename = path .. baseName .. ".png" ,
		width = width * scale * pixelPerLength ,
		height = height * scale * pixelPerLength ,
		shift = util.by_pixel( 0 , 0 )
	}
	if hasHr then
		layer.hr_version = SIPics.BaseAnimLayer( path , baseName.."-hr" , width , height , scale , false , SINumbers.machinePictureSize_hr )
		layer.hr_version.scale = 0.5
	end
	return layer
end



function SIPics.OnAnimLayer( path , baseName , width , height , scale , hasHr , pixelPerLength )
	local layer = SIPics.BaseAnimLayer( path , baseName , width , height , scale , hasHr , pixelPerLength )
	layer.line_length = SINumbers.machinePictureTotalWidth
	layer.frame_count = SINumbers.machinePictureTotalFrameCount
	layer.animation_speed = SINumbers.machineAnimationSpeed
	if hasHr then
		layer.hr_version.line_length = SINumbers.machinePictureTotalWidth
		layer.hr_version.frame_count = SINumbers.machinePictureTotalFrameCount
		layer.hr_version.animation_speed = SINumbers.machineAnimationSpeed
	end
	return layer
end

function SIPics.OnAnimLayerShadow( path , baseName , width , height , scale , hasHr , totalHeight , pixelPerLength )
	if not totalHeight then totalHeight = 0 end
	local layer = SIPics.OnAnimLayer( path , baseName.."-shadow" , width+totalHeight , height , scale , hasHr , pixelPerLength )
	layer.repeat_count = layer.frame_count
	layer.line_length = 1
	layer.frame_count = 1
	layer.draw_as_shadow = true
	if hasHr then
		layer.hr_version.repeat_count = layer.hr_version.frame_count
		layer.hr_version.line_length = 1
		layer.hr_version.frame_count = 1
		layer.hr_version.draw_as_shadow = true
	end
	return layer
end

function SIPics.OffAnimLayer( path , baseName , width , height , scale , hasHr , pixelPerLength )
	local layer = SIPics.BaseAnimLayer( path , baseName , width , height , scale , hasHr , pixelPerLength )
	layer.frame_count = 1
	if hasHr then
		layer.hr_version.frame_count = 1
	end
	return layer
end

function SIPics.OffAnimLayerShadow( path , baseName , width , height , scale , hasHr , totalHeight , pixelPerLength )
	if not totalHeight then totalHeight = 0 end
	local layer = SIPics.OffAnimLayer( path , baseName.."-shadow" , width+totalHeight , height , scale , hasHr , pixelPerLength )
	layer.frame_count = 1
	layer.draw_as_shadow = true
	if hasHr then
		layer.hr_version.frame_count = 1
		layer.hr_version.draw_as_shadow = true
	end
	return layer
end