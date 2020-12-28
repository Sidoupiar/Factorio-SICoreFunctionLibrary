SINumbers =
{
	lineMax = 10 ,
	
	iconSize = 64 ,
	iconSizeGroup = 64 ,
	iconSizeTechnology = 128 ,
	mipMaps = 4 ,
	iconPictureScale = 0.25 ,
	
	pictureHrScale = 2 ,
	pictureHrScaleDown = 0.5 ,
	
	machinePictureSize = 32 ,
	machinePictureTotalWidth = 8 ,
	machinePictureTotalHeight = 8 ,
	moduleInfoIconScale = 0.4 ,
	
	healthToMiningTime = 800 ,
	lightSizeMult = 2.4 ,
	
	ticksPerDay = 25000 ,
	ticksPerHalfDay = 12500
}

SINumbers.machinePictureSize_hr = SINumbers.machinePictureSize * SINumbers.pictureHrScale
SINumbers.machinePictureTotalFrameCount = SINumbers.machinePictureTotalWidth * SINumbers.machinePictureTotalHeight
SINumbers.machineAnimationSpeed = SINumbers.machinePictureTotalFrameCount / 60