SINumbers =
{
	lineMax = 10 ,
	
	iconSize = 64 ,
	iconSizeGroup = 64 ,
	iconSizeTechnology = 128 ,
	mipMaps = 4 ,
	iconPictureScale = 0.25 ,
	
	defaultMiningTime = 1 ,
	defaultProductCount = 1 ,
	defaultMinableFluidCount = 1 ,
	
	pictureHrScale = 2 ,
	pictureHrScaleDown = 0.5 ,
	machinePictureSize = 32 ,
	machinePictureTotalWidth = 8 ,
	machinePictureTotalHeight = 8 ,
	moduleInfoIconScale = 0.4 ,
	resourcePictureSize = 32 ,
	resourcePictureSide = 32 ,
	resourcePictureFrameCount = 8 ,
	resourceVariationCount = 8 ,
	projectilePictureSize = 32 ,
	projectilePictureLineLength = 8 ,
	projectilePictureFrameCount = 16 ,
	projectilePictureAnimSpeed = 0.25 ,
	equipmentPictureSize = 32 ,
	
	healthToMiningTime = 800 ,
	lightSizeMult = 2.4 ,
	
	ticksPerDay = 25000 ,
	ticksPerHalfDay = 12500
}

SINumbers.machinePictureSize_hr = SINumbers.machinePictureSize * SINumbers.pictureHrScale
SINumbers.machinePictureTotalFrameCount = SINumbers.machinePictureTotalWidth * SINumbers.machinePictureTotalHeight
SINumbers.machineAnimationSpeed = SINumbers.machinePictureTotalFrameCount / 60



local innerSINumbers = table.deepcopy( SINumbers )

function SINumbers_RestoreDefault()
	for key , value in pairs( table.deepcopy( innerSINumbers ) ) do
		SINumbers[key] = value
	end
end