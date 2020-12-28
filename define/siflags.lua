SIFlags =
{
	itemFlags =
	{
		notStackable = "not-stackable" ,
		hidden = "hidden"
	} ,
	entityFlags =
	{
		zk = "zkable" ,
		zw = "zwable" ,
		
		hidden = "hidden" ,
		noGapFill = "no-gap-fill-while-building" ,
		notOnMap = "not-on-map" ,
		notFlammable = "not-flammable" ,
		notRotatable = "not-rotatable" ,
		notRepairable = "not-repairable" ,
		notBlueprintable = "not-blueprintable" ,
		notDeconstructable = "not-deconstructable" ,
		placeableEnemy = "placeable-enemy" ,
		placeablePlayer = "placeable-player" ,
		placeableNeutral = "placeable-neutral" ,
		placeableOffGrid = "placeable-off-grid" ,
		hideAltInfo = "hide-alt-info" ,
		hideFromBonus = "hide-from-bonus-gui" ,
		fastReplaceableBuild = "fast-replaceable-no-build-while-moving" ,
		fastReplaceableCross = "fast-replaceable-no-cross-type-while-moving" ,
		building8Way = "building-direction-8-way" ,
		breathsAir = "breaths-air" ,
		playerCreation = "player-creation" ,
		filterDirections = "filter-directions"
	} ,
	directions = { "north" , "east" , "south" , "west" } ,
	sciencePack =
	{
		key = "description.science-pack-remaining-amount-key" ,
		value = "description.science-pack-remaining-amount-value"
	} ,
	productType =
	{
		material = "material" ,
		resource = "resource" ,
		unit = "unit"
	} ,
	trackType =
	{
		earlyGame = "early-game" , -- 载入游戏
		menuTrack = "menu-track" , -- 主菜单
		mainTrack = "main-track" , -- 游戏阶段
		interlude = "interlude"    -- 插曲
	} ,
	condition =
	{
		And = "and" ,
		Or = "or" ,
		Not = "not"
	}
}