-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local currentLayer = nil
local hrVersion = nil
SIPics =
{
}

local function CreateHrVersion()
	if not hrVersion then
		hrVersion = {}
		for name , value in pairs( currentLayer ) do
			if name == "hr_version" then
			elseif name == "width" or name == "height" then hrVersion[name] = currentLayer[name] * SINumbers.pictureHrScale
			elseif name == "scale" then hrVersion[name] = currentLayer[name] * SINumbers.pictureHrScaleDown
			else hrVersion[name] = currentLayer[name] end
		end
		currentLayer.hr_version = hrVersion
	end
end

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
		hrVersion =
		{
			filename = file .. "-hr.png" ,
			width = width * SINumbers.pictureHrScale ,
			height = height * SINumbers.pictureHrScale ,
			scale = scale * SINumbers.pictureHrScaleDown
		}
		currentLayer.hr_version = hrVersion
	else hrVersion = nil end
	return SIPics
end

function SIPics.NewLayerWithFiles( files , width , height , linesPerFile , slice , scale , hasHr )
	linesPerFile = linesPerFile or 1
	slice = slice or linesPerFile
	scale = scale or 1
	local normalFiles = {}
	for i , file in pairs( files ) do table.insert( normalFiles , file..".png" ) end
	currentLayer =
	{
		filenames = normalFiles ,
		width = width ,
		height = height ,
		lines_per_file = linesPerFile ,
		slice = slice
	}
	if scale ~= 1 then currentLayer.scale = scale end
	if hasHr then
		local hrFiles = {}
		for i , file in pairs( files ) do table.insert( hrFiles , file.."-hr.png" ) end
		hrVersion =
		{
			filenames = hrFiles ,
			width = width * SINumbers.pictureHrScale ,
			height = height * SINumbers.pictureHrScale ,
			scale = scale * SINumbers.pictureHrScaleDown ,
			lines_per_file = linesPerFile ,
			slice = slice
		}
		currentLayer.hr_version = hrVersion
	else hrVersion = nil end
	return SIPics
end

function SIPics.LoadLayer( layer , file , width , height , scale )
	currentLayer = table.deepcopy( layer )
	hrVersion = currentLayer.hr_version
	if file then currentLayer.filename = file .. ".png" end
	if width then currentLayer.width = width end
	if height then currentLayer.height = height end
	if scale and scale ~= 1 then currentLayer.scale = scale end
	if hrVersion then
		if file then hrVersion.filename = file .. "-hr.png" end
		if width then hrVersion.width = width * SINumbers.pictureHrScale end
		if height then hrVersion.height = height * SINumbers.pictureHrScale end
		if scale then hrVersion.scale = scale * SINumbers.pictureHrScaleDown end
	end
	return SIPics
end

function SIPics.Get()
	return currentLayer
end

function SIPics.Copy()
	return table.deepcopy( currentLayer )
end

function SIPics.GetWaterReflection( rotate , orientationToVariation )
	return SIPackers.WaterReflection( SIPics.Priority( "extra-high" ).Get() , rotate , orientationToVariation )
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础操作 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPics.File( file )
	currentLayer.filename = file .. ".png"
	if currentLayer.filenames then
		currentLayer.filenames = nil
		currentLayer.lines_per_file = nil
		currentLayer.slice = nil
	end
	return SIPics
end

function SIPics.Files( files , linesPerFile , slice )
	linesPerFile = linesPerFile or 1
	slice = slice or linesPerFile
	local normalFiles = {}
	for i , file in pairs( files ) do table.insert( normalFiles , file..".png" ) end
	currentLayer.filenames = normalFiles
	currentLayer.lines_per_file = linesPerFile
	currentLayer.slice = slice
	if currentLayer.filename then currentLayer.filename = nil end
	return SIPics
end

function SIPics.HrFile( file )
	CreateHrVersion()
	hrVersion.filename = file .. "-hr.png"
	if hrVersion.filenames then
		hrVersion.filenames = nil
		hrVersion.lines_per_file = nil
		hrVersion.slice = nil
	end
	return SIPics
end

function SIPics.HrFiles( files , linesPerFile , slice )
	CreateHrVersion()
	linesPerFile = linesPerFile or 1
	slice = slice or linesPerFile
	local hrFiles = {}
	for i , file in pairs( files ) do table.insert( hrFiles , file.."-hr.png" ) end
	hrVersion.filenames = hrFiles
	hrVersion.lines_per_file = linesPerFile
	hrVersion.slice = slice
	if hrVersion.filename then hrVersion.filename = nil end
	return SIPics
end

function SIPics.Size( width , height )
	if width then
		currentLayer.width = width
		if hrVersion then hrVersion.width = width * SINumbers.pictureHrScale end
	end
	if height then
		currentLayer.height = height
		if hrVersion then hrVersion.height = height * SINumbers.pictureHrScale end
	end
	return SIPics
end

function SIPics.Scale( scale )
	currentLayer.scale = scale
	if hrVersion then hrVersion.scale = scale * SINumbers.pictureHrScaleDown end
	return SIPics
end

function SIPics.Priority( priority )
	currentLayer.priority = priority
	if hrVersion then hrVersion.priority = priority end
	return SIPics
end

function SIPics.BlendMode( blendMode )
	currentLayer.blend_mode = blendMode
	if hrVersion then hrVersion.blend_mode = blendMode end
	return SIPics
end

function SIPics.Shift( shiftX , shiftY )
	shiftX = shiftX or 0
	shiftY = shiftY or 0
	if shiftX or shiftY then
		currentLayer.shift = util.by_pixel( shiftX , shiftY )
		if hrVersion then hrVersion.shift = currentLayer.shift end
	end
	return SIPics
end

function SIPics.ShiftMerge( shiftX , shiftY )
	local shift = currentLayer.shift or { 0 , 0 }
	local newShift = util.by_pixel( shiftX , shiftY )
	currentLayer.shift = { shift[1]+newShift[1] , shift[2]+newShift[2] }
	if hrVersion then hrVersion.shift = currentLayer.shift end
	return SIPics
end

function SIPics.LinesPerFile( linesPerFile , slice )
	linesPerFile = linesPerFile or 1
	slice = slice or linesPerFile
	currentLayer.lines_per_file = linesPerFile
	currentLayer.slice = slice
	if hrVersion then
		hrVersion.lines_per_file = linesPerFile
		hrVersion.slice = slice
	end
	return SIPics
end

function SIPics.Frame( frameCount )
	frameCount = frameCount or 1
	currentLayer.frame_count = frameCount
	if hrVersion then hrVersion.frame_count = frameCount end
	return SIPics
end

function SIPics.Anim( lineLength , frameCount , animSpeed , directionCount )
	lineLength = lineLength or 1
	frameCount = frameCount or 1
	currentLayer.line_length = lineLength
	currentLayer.frame_count = frameCount
	if animSpeed then currentLayer.animation_speed = animSpeed end
	if directionCount then currentLayer.direction_count = directionCount end
	if hrVersion then
		hrVersion.line_length = lineLength
		hrVersion.frame_count = frameCount
		if animSpeed then hrVersion.animation_speed = animSpeed end
		if directionCount then hrVersion.direction_count = directionCount end
	end
	return SIPics
end

function SIPics.Variation( variationCount )
	variationCount = variationCount or 1
	currentLayer.variation_count = variationCount
	if hrVersion then hrVersion.variation_count = variationCount end
	return SIPics
end

function SIPics.Y( y )
	y = y or 0
	currentLayer.y = y
	if hrVersion then hrVersion.y = y end
	return SIPics
end

function SIPics.Repeat( frameCount )
	frameCount = frameCount or 1
	currentLayer.repeat_count = frameCount
	currentLayer.frame_count = 1
	if not currentLayer.line_length then currentLayer.line_length = 1 end
	if hrVersion then
		hrVersion.repeat_count = frameCount
		hrVersion.frame_count = 1
		if not hrVersion.line_length then hrVersion.line_length = 1 end
	end
	return SIPics
end

function SIPics.Tint( red , green , blue , alpha )
	local color = SIPackers.Color( red , green , blue , alpha )
	if color then
		currentLayer.tint = color
		if hrVersion then hrVersion.tint = color end
	end
	return SIPics
end

function SIPics.Shadow()
	currentLayer.draw_as_shadow = true
	if hrVersion then hrVersion.draw_as_shadow = true end
	return SIPics
end

function SIPics.Axially( axially )
	currentLayer.axially_symmetrical = axially
	if hrVersion then hrVersion.axially_symmetrical = axially end
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
		hrVersion.frame_count = 1
		hrVersion.direction_count = 1
	end
	if location then SIPics.ShiftMerge( location[1] , location[2] ) end
	return SIPics
end

function SIPics.WaterReflection( file , width , height , location , rotate , orientationToVariation )
	SIPics.BaseAnimLayer( file.."-reflection" , width , height ).Variation()
	if location then currentLayer.shift = util.by_pixel( location[1] , location[2] ) end
	return SIPics.GetWaterReflection( rotate , orientationToVariation )
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
	return SIPics.BaseAnimLayer( file.."-shadow" , width , height , hasHr , addenWidth , addenHeight ).Repeat( frameCount ).Shadow()
end

function SIPics.OffAnimLayer( file , width , height , hasHr , addenWidth , addenHeight )
	return SIPics.BaseAnimLayer( file , width , height , hasHr , addenWidth , addenHeight ).Frame()
end

function SIPics.OffAnimLayerShadow( file , width , height , hasHr , addenWidth , addenHeight )
	return SIPics.OffAnimLayer( file.."-shadow" , width , height , hasHr , addenWidth , addenHeight ).Shadow()
end

-- ------------------------------------------------------------------------------------------------
-- -------- 贴图图片结构 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPics.PictureLayer( file , width , height , hasHr , addenWidth , addenHeight , lineLength , directionCount )
	lineLength = lineLength or SINumbers.machinePictureTotalWidth
	directionCount = directionCount or SINumbers.machinePictureTotalFrameCount
	return SIPics.BaseAnimLayer( file , width , height , hasHr , addenWidth , addenHeight ).Anim( lineLength , 1 , nil , directionCount )
end

function SIPics.PictureShadow( file , width , height , hasHr , addenWidth , addenHeight , lineLength , directionCount )
	return SIPics.PictureLayer( file.."-shadow" , width , height , hasHr , addenWidth , addenHeight , lineLength , directionCount ).Shadow()
end