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
	collisionMask =
	{
		ground        = "ground-tile" ,
		water         = "water-tile" ,
		resource      = "resource-layer" ,
		doodad        = "doodad-layer" ,
		floor         = "floor-layer" ,
		item          = "item-layer" ,
		ghost         = "ghost-layer" ,
		object        = "object-layer" ,
		player        = "player-layer" ,
		train         = "train-layer" ,
		rail          = "rail-layer" ,
		transportBelt = "transport-belt-layer" ,
		_13           = "layer-13" ,
		_14           = "layer-14" ,
		_15           = "layer-15" ,
		_16           = "layer-16" ,
		_17           = "layer-17" ,
		_18           = "layer-18" ,
		_19           = "layer-19" ,
		_20           = "layer-20" ,
		_21           = "layer-21" ,
		_22           = "layer-22" ,
		_23           = "layer-23" ,
		_24           = "layer-24" ,
		_25           = "layer-25" ,
		_26           = "layer-26" ,
		_27           = "layer-27" ,
		_28           = "layer-28" ,
		_29           = "layer-29" ,
		_30           = "layer-30" ,
		_31           = "layer-31" ,
		_32           = "layer-32" ,
		_33           = "layer-33" ,
		_34           = "layer-34" ,
		_35           = "layer-35" ,
		_36           = "layer-36" ,
		_37           = "layer-37" ,
		_38           = "layer-38" ,
		_39           = "layer-39" ,
		_40           = "layer-40" ,
		_41           = "layer-41" ,
		_42           = "layer-42" ,
		_43           = "layer-43" ,
		_44           = "layer-44" ,
		_45           = "layer-45" ,
		_46           = "layer-46" ,
		_47           = "layer-47" ,
		_48           = "layer-48" ,
		_49           = "layer-49" ,
		_50           = "layer-50" ,
		_51           = "layer-51" ,
		_52           = "layer-52" ,
		_53           = "layer-53" ,
		_54           = "layer-54" ,
		_55           = "layer-55" ,
		
		notCollidingWithItself  = "not-colliding-with-itself" ,
		considerTileTransitions = "consider-tile-transitions" ,
		collidingWithTilesOnly  = "colliding-with-tiles-only"
		
	} ,
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