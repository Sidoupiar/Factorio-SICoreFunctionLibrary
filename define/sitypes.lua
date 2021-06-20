SITypes =
{
	group            = "item-group" ,
	subgroup         = "item-subgroup" ,
	fluid            = "fluid" ,
	tile             = "tile" ,
	signal           = "virtual-signal" ,
	recipe           = "recipe" ,
	technology       = "technology" ,
	damageType       = "damage-type" ,
	equipmentGrid    = "equipment-grid" ,
	beam             = "beam" ,
	decorative       = "optimized-decorative" ,
	input            = "custom-input" ,
	ambientSound     = "ambient-sound" ,
	font             = "font" ,
	controlAutoplace = "autoplace-control" ,
	category =
	{
		ammo            = "ammo-category" ,
		equipment       = "equipment-category" ,
		fuel            = "fuel-category" ,
		module          = "module-category" ,
		recipe          = "recipe-category" ,
		resource        = "resource-category"
	} ,
	item =
	{
		item            = "item" ,
		itemEntity      = "item-with-entity-data" ,
		tool            = "tool" ,
		toolRepair      = "repair-tool" ,
		railPlanner     = "rail-planner" ,
		ammo            = "ammo" ,
		armor           = "armor" ,
		capsule         = "capsule" ,
		gun             = "gun" ,
		module          = "module" ,
		blueprint       = "blueprint" ,
		blueprintBook   = "blueprint-book" ,
		redprint        = "deconstruction-item" ,
		selectionTool   = "selection-tool" ,
		itemTag         = "item-with-tags" ,
		itemLabel       = "item-with-label" ,
		itemInventory   = "item-with-inventory"
	} ,
	stackableItem =
	{
		item            = "item" ,
		itemEntity      = "item-with-entity-data" ,
		tool            = "tool" ,
		toolRepair      = "repair-tool" ,
		railPlanner     = "rail-planner" ,
		ammo            = "ammo" ,
		capsule         = "capsule" ,
		gun             = "gun" ,
		module          = "module"
	} ,
	iconableItem =
	{
		item            = "item" ,
		itemEntity      = "item-with-entity-data" ,
		tool            = "tool" ,
		ammo            = "ammo" ,
		armor           = "armor" ,
		capsule         = "capsule" ,
		gun             = "gun" ,
		module          = "module" ,
		
		fluid           = "fluid"
	} ,
	entity =
	{
		fire            = "fire" ,
		sticker         = "sticker" ,
		projectile      = "projectile" ,
		particle        = "particle" ,
		cliff           = "cliff" ,
		resource        = "resource" ,           -- 矿物
		tree            = "tree" ,
		character       = "character" ,
		fish            = "fish" ,
		unit            = "unit" ,
		spawner         = "unit-spawner" ,
		corpse          = "corpse" ,
		corpseCharacter = "character-corpse" ,
		boiler          = "boiler" ,             -- 锅炉
		generator       = "generator" ,          -- 发电机
		burnerGenerator = "burner-generator" ,   -- 燃烧发电机
		solar           = "solar-panel" ,
		reactor         = "reactor" ,
		acc             = "accumulator" ,
		pump            = "pump" ,               -- 泵
		pumpOffshore    = "offshore-pump" ,
		mining          = "mining-drill" ,       -- 矿机
		furnace         = "furnace" ,            -- 熔炉
		machine         = "assembling-machine" , -- 组装机
		lab             = "lab" ,
		beacon          = "beacon" ,
		market          = "market" ,
		rocket          = "rocket-silo" ,
		rocketRocket    = "rocket-silo-rocket" ,
		rocketShadow    = "rocket-silo-rocket-shadow" ,
		belt            = "transport-belt" ,
		beltGround      = "underground-belt" ,
		beltLinked      = "linked-belt" ,
		beltLoader      = "loader" ,
		beltLoaderSmall = "loader-1x1" ,
		beltSplitter    = "splitter" ,
		pipe            = "pipe" ,               -- 管道
		pipeGround      = "pipe-to-ground" ,
		pipeHeat        = "heat-pipe" ,
		railStraight    = "straight-rail" ,
		railCurved      = "curved-rail" ,
		railStop        = "train-stop" ,
		railSign        = "rail-signal" ,
		railChain       = "rail-chain-signal" ,
		inserter        = "inserter" ,
		container       = "container" ,
		containerLogic  = "logistic-container" ,
		containerLinked = "linked-container" ,
		containerFluid  = "storage-tank" ,
		pole            = "electric-pole" ,
		powerSwitch     = "power-switch" ,
		lamp            = "lamp" ,
		car             = "car" ,
		spiderVehicle   = "spider-vehicle" ,
		wagonLocomotive = "locomotive" ,
		wagonCargo      = "cargo-wagon" ,
		wagonFluid      = "fluid-wagon" ,
		wagonArtillery  = "artillery-wagon" ,
		robotConstruct  = "construction-robot" , -- 建设机器人
		robotLogistic   = "logistic-robot" ,     -- 物流机器人
		robotCombat     = "combat-robot" ,       -- 攻击机器人
		roboport        = "roboport" ,           -- 指令平台
		playerPort      = "player-port" ,
		radar           = "radar" ,
		wall            = "wall" ,
		gate            = "gate" ,
		turret          = "turret" ,
		turretAmmo      = "ammo-turret" ,
		turretElectric  = "electric-turret" ,
		turretArtillery = "artillery-turret" ,
		mine            = "land-mine" ,
		combAri         = "arithmetic-combinator" ,
		combDec         = "decider-combinator" ,
		combCon         = "constant-combinator" ,
		speaker         = "programmable-speaker" ,
		cci             = "infinity-container" ,
		eei             = "electric-energy-interface" ,
		simpleEntity    = "simple-entity" ,
		simpleForce     = "simple-entity-with-force" ,
		simpleOwner     = "simple-entity-with-owner" ,
		flyingText      = "flying-text" ,
		speechBubble    = "speech-bubble" ,
		ghostEntity     = "entity-ghost" ,
		ghostTile       = "tile-ghost" ,
		proxyDt         = "deconstructible-tile-proxy" ,
		proxyIr         = "item-request-proxy" ,
		highlight       = "highlight-box" ,
		flame           = "flame-thrower-explosion" ,
		arrow           = "arrow" ,
		flare           = "artillery-flare" ,
		smoke           = "trivial-smoke" ,
		stream          = "stream"
	} ,
	healthEntity =
	{
		tree            = "tree" ,
		player          = "player" ,
		fish            = "fish" ,
		unit            = "unit" ,
		spawner         = "unit-spawner" ,
		boiler          = "boiler" ,             -- 锅炉
		generator       = "generator" ,          -- 发电机
		burnerGenerator = "burner-generator" ,   -- 燃烧发电机
		solar           = "solar-panel" ,
		reactor         = "reactor" ,
		acc             = "accumulator" ,
		pump            = "pump" ,               -- 泵
		pumpOffshore    = "offshore-pump" ,
		mining          = "mining-drill" ,       -- 矿机
		furnace         = "furnace" ,            -- 熔炉
		machine         = "assembling-machine" , -- 组装机
		lab             = "lab" ,
		beacon          = "beacon" ,
		market          = "market" ,
		rocket          = "rocket-silo" ,
		belt            = "transport-belt" ,
		beltGround      = "underground-belt" ,
		beltLinked      = "linked-belt" ,
		beltLoader      = "loader" ,
		beltLoaderSmall = "loader-1x1" ,
		beltSplitter    = "splitter" ,
		pipe            = "pipe" ,
		pipeGround      = "pipe-to-ground" ,
		pipeHeat        = "heat-pipe" ,
		railStraight    = "straight-rail" ,
		railCurved      = "curved-rail" ,
		railStop        = "train-stop" ,
		railSign        = "rail-signal" ,
		railChain       = "rail-chain-signal" ,
		inserter        = "inserter" ,
		container       = "container" ,
		containerLogic  = "logistic-container" ,
		containerLinked = "linked-container" ,
		containerFluid  = "storage-tank" ,
		pole            = "electric-pole" ,
		powerSwitch     = "power-switch" ,
		lamp            = "lamp" ,
		car             = "car" ,
		spiderVehicle   = "spider-vehicle" ,
		wagonLocomotive = "locomotive" ,
		wagonCargo      = "cargo-wagon" ,
		wagonFluid      = "fluid-wagon" ,
		wagonArtillery  = "artillery-wagon" ,
		robotConstruct  = "construction-robot" ,
		robotLogistic   = "logistic-robot" ,
		robotCombat     = "combat-robot" ,
		roboport        = "roboport" ,
		playerPort      = "player-port" ,
		radar           = "radar" ,
		wall            = "wall" ,
		gate            = "gate" ,
		turret          = "turret" ,
		turretAmmo      = "ammo-turret" ,
		turretElectric  = "electric-turret" ,
		turretArtillery = "artillery-turret" ,
		mine            = "land-mine" ,
		combAri         = "arithmetic-combinator" ,
		combDec         = "decider-combinator" ,
		combCon         = "constant-combinator" ,
		speaker         = "programmable-speaker" ,
		cci             = "infinity-container" ,
		eei             = "electric-energy-interface"
	} ,
	machine =
	{
		pump            = "pump" ,               -- 泵
		furnace         = "furnace" ,            -- 熔炉
		machine         = "assembling-machine"   -- 组装机
	} ,
	freelocEntity =
	{
		boiler          = "boiler" ,             -- 锅炉
		generator       = "generator" ,          -- 发电机
		burnerGenerator = "burner-generator" ,   -- 燃烧发电机
		solar           = "solar-panel" ,
		reactor         = "reactor" ,
		acc             = "accumulator" ,
		pump            = "pump" ,               -- 泵
		pumpOffshore    = "offshore-pump" ,
		mining          = "mining-drill" ,       -- 矿机
		furnace         = "furnace" ,            -- 熔炉
		machine         = "assembling-machine" , -- 组装机
		lab             = "lab" ,
		beacon          = "beacon" ,
		market          = "market" ,
		rocket          = "rocket-silo" ,
		belt            = "transport-belt" ,
		beltGround      = "underground-belt" ,
		beltLinked      = "linked-belt" ,
		beltLoader      = "loader" ,
		beltLoaderSmall = "loader-1x1" ,
		beltSplitter    = "splitter" ,
		pipe            = "pipe" ,
		pipeGround      = "pipe-to-ground" ,
		pipeHeat        = "heat-pipe" ,
		railStraight    = "straight-rail" ,
		railCurved      = "curved-rail" ,
		railStop        = "train-stop" ,
		railSign        = "rail-signal" ,
		railChain       = "rail-chain-signal" ,
		inserter        = "inserter" ,
		container       = "container" ,
		containerLogic  = "logistic-container" ,
		containerLinked = "linked-container" ,
		containerFluid  = "storage-tank" ,
		pole            = "electric-pole" ,
		powerSwitch     = "power-switch" ,
		lamp            = "lamp" ,
		roboport        = "roboport" ,
		playerPort      = "player-port" ,
		radar           = "radar" ,
		wall            = "wall" ,
		gate            = "gate" ,
		turret          = "turret" ,
		turretAmmo      = "ammo-turret" ,
		turretElectric  = "electric-turret" ,
		turretArtillery = "artillery-turret" ,
		combAri         = "arithmetic-combinator" ,
		combDec         = "decider-combinator" ,
		combCon         = "constant-combinator" ,
		speaker         = "programmable-speaker" ,
		cci             = "infinity-container" ,
		eei             = "electric-energy-interface"
	} ,
	containerEntity =
	{
		character       = "character" ,
		container       = "container" ,
		containerLogic  = "logistic-container" ,
		containerLinked = "linked-container" ,
		car             = "car" ,
		spiderVehicle   = "spider-vehicle" ,
		wagonCargo      = "cargo-wagon" ,
		wagonArtillery  = "artillery-wagon" ,
		turretAmmo      = "ammo-turret" ,
	} ,
	equipment =
	{
		base            = "equipment" , -- 此项不能使用
		night           = "night-vision-equipment" ,
		shield          = "energy-shield-equipment" ,
		battery         = "battery-equipment" ,
		solar           = "solar-panel-equipment" ,
		generatorEquip  = "generator-equipment" ,
		activeDefense   = "active-defense-equipment" ,
		movement        = "movement-bonus-equipment" ,
		roboport        = "roboport-equipment" ,
		beltImmunity    = "belt-immunity-equipment"
	} ,
	
	
	
	equipmentShapeType =
	{
		full            = "full" ,
		manual          = "manual"
	} ,
	logisticMode =
	{
		passive         = "passive-provider" , -- 红箱
		storage         = "storage" ,          -- 黄箱
		buffer          = "buffer" ,           -- 绿箱
		requester       = "requester" ,        -- 蓝箱
		active          = "active-provider"    -- 紫箱
	} ,
	linkedMode =
	{
		all             = "all" ,
		admin           = "admin" ,
		none            = "none"
	} ,
	energy =
	{
		electric        = "electric" ,
		burner          = "burner" ,
		heat            = "heat" ,
		fluid           = "fluid" ,
		void            = "void"
	} ,
	electricUsagePriority =
	{
		primaryInput    = "primary-input" ,
		primaryOutput   = "primary-output" ,
		secondaryInput  = "secondary-input" ,
		secondaryOutput = "secondary-output" ,
		tertiary        = "tertiary" ,
		solar           = "solar" ,
		lamp            = "lamp"
	} ,
	fluidBoxProductionType =
	{
		none            = "None" ,
		input           = "input" ,
		output          = "output" ,
		inAndOut        = "input-output"
	} ,
	fluidBoxConnectionType =
	{
		input           = "input" ,
		output          = "output" ,
		inAndOut        = "input-output"
	} ,
	moduleEffect =
	{
		speed           = "speed" ,
		product         = "productivity" ,
		consumption     = "consumption" ,
		pollut          = "pollution"
	} ,
	rock =
	{
		small           = "rock-small" ,
		medium          = "rock-medium" ,
		big             = "rock-big"
	} ,
	controlAutoplaceCategory =
	{
		resource        = "resource" ,
		terrain         = "terrain" ,
		enemy           = "enemy"
	} ,
	view =
	{
		frame           = "" ,
	} ,
	modifier =
	{
		unlockRecipe                            = "unlock-recipe" ,
		gunSpeed                                = "gun-speed" ,
		ammoDamage                              = "ammo-damage" ,
		turretAttack                            = "turret-attack" ,
		giveItem                                = "give-item" ,
		nothing                                 = "nothing" ,
		
		inserterStackSizeBonus                  = "inserter-stack-size-bonus" ,
		stackInserterCapacityBonus              = "stack-inserter-capacity-bonus" ,
		miningDrillProductivityBonus            = "mining-drill-productivity-bonus" ,
		trainBrakingForceBonus                  = "train-braking-force-bonus" ,
		artilleryRange                          = "artillery-range" ,
		
		laboratorySpeed                         = "laboratory-speed" ,
		laboratoryProductivity                  = "laboratory-productivity" ,
		
		maximumFollowingRobotsCount             = "maximum-following-robots-count" ,
		followerRobotLifetime                   = "follower-robot-lifetime" ,
		workerRobotSpeed                        = "worker-robot-speed" ,
		workerRobotStorage                      = "worker-robot-storage" ,
		workerRobotBattery                      = "worker-robot-battery" ,
		
		ghostTimeToLive                         = "ghost-time-to-live" ,
		deconstructionTimeToLive                = "deconstruction-time-to-live" ,
		
		characterHealthBonus                    = "character-health-bonus" ,
		characterInventorySlotsBonus            = "character-inventory-slots-bonus" ,
		characterCraftingSpeed                  = "character-crafting-speed" ,
		characterMiningSpeed                    = "character-mining-speed" ,
		characterRunningSpeed                   = "character-running-speed" ,
		characterBuildDistance                  = "character-build-distance" ,
		characterItemDropDistance               = "character-item-drop-distance" ,
		characterReachDistance                  = "character-reach-distance" ,
		characterResourceReachDistance          = "character-resource-reach-distance" ,
		characterItemPickupDistance             = "character-item-pickup-distance" ,
		characterLootPickupDistance             = "character-loot-pickup-distance" ,
		characterLogisticSlots                  = "character-logistic-slots" ,
		characterLogisticTrashSlots             = "character-logistic-trash-slots" ,
		characterLogisticRequests               = "character-logistic-requests" ,
		characterAdditionalMiningCategories     = "character-additional-mining-categories" ,
		autoCharacterLogisticTrashSlots         = "auto-character-logistic-trash-slots" ,
		
		zoomToWorldEnabled                      = "zoom-to-world-enabled" ,
		zoomToWorldGhostBuildingEnabled         = "zoom-to-world-ghost-building-enabled" ,
		zoomToWorldBlueprintEnabled             = "zoom-to-world-blueprint-enabled" ,
		zoomToWorldDeconstructionPlannerEnabled = "zoom-to-world-deconstruction-planner-enabled" ,
		zoomToWorldUpgradePlannerEnabled        = "zoom-to-world-upgrade-planner-enabled" ,
		zoomToWorldSelectionToolEnabled         = "zoom-to-world-selection-tool-enabled" ,
		
		maxFailedAttemptsPerTickPerConstructionQueue     = "max-failed-attempts-per-tick-per-construction-queue" ,
		maxSuccessfulAttemptsPerTickPerConstructionQueue = "max-successful-attempts-per-tick-per-construction-queue"
	}
}

SITypes.all = {}
local al = { "group" , "subgroup" , "item" , "fluid" , "tile" , "signal" , "recipe" , "technology" , "damageType" , "equipmentGrid" , "beam" , "entity" , "equipment" }
for i , v in pairs( al ) do SITypes.all[v] = SITypes[v] end

SIKeyw =
{
	[SITypes.item.item]              = "item" ,
	[SITypes.item.itemEntity]        = "item" ,
	[SITypes.item.tool]              = "tool" ,
	[SITypes.item.toolRepair]        = "tool" ,
	[SITypes.item.railPlanner]       = "rail" ,
	[SITypes.item.ammo]              = "ammo" ,
	[SITypes.item.armor]             = "armor" ,
	[SITypes.item.capsule]           = "capsule" ,
	[SITypes.item.gun]               = "gun" ,
	[SITypes.item.module]            = "module" ,
	[SITypes.item.blueprint]         = "tool" ,
	[SITypes.item.blueprintBook]     = "tool" ,
	[SITypes.item.redprint]          = "tool" ,
	[SITypes.item.selectionTool]     = "tool" ,
	[SITypes.item.itemTag]           = "item" ,
	[SITypes.item.itemLabel]         = "item" ,
	[SITypes.item.itemInventory]     = "item" ,
	
	[SITypes.entity.fire]            = "fire" ,
	[SITypes.entity.sticker]         = "sticker" ,
	[SITypes.entity.projectile]      = "projectile" ,
	[SITypes.entity.cliff]           = "cliff" ,
	[SITypes.entity.resource]        = "resource" ,
	[SITypes.entity.tree]            = "tree" ,
	[SITypes.entity.character]       = "character" ,
	[SITypes.entity.fish]            = "fish" ,
	[SITypes.entity.unit]            = "unit" ,
	[SITypes.entity.spawner]         = "spawner" ,
	[SITypes.entity.corpse]          = "corpse" ,
	[SITypes.entity.corpseCharacter] = "corpse" ,
	[SITypes.entity.boiler]          = "boiler" ,           -- 锅炉
	[SITypes.entity.generator]       = "generator" ,        -- 发电机
	[SITypes.entity.burnerGenerator] = "burner-generator" , -- 燃烧发电机
	[SITypes.entity.solar]           = "solar" ,
	[SITypes.entity.reactor]         = "reactor" ,
	[SITypes.entity.acc]             = "acc" ,
	[SITypes.entity.pump]            = "pump" ,             -- 泵
	[SITypes.entity.pumpOffshore]    = "pump" ,
	[SITypes.entity.mining]          = "mining" ,           -- 矿机
	[SITypes.entity.furnace]         = "furnace" ,          -- 熔炉
	[SITypes.entity.machine]         = "machine" ,          -- 组装机
	[SITypes.entity.lab]             = "lab" ,
	[SITypes.entity.beacon]          = "beacon" ,
	[SITypes.entity.market]          = "market" ,
	[SITypes.entity.rocket]          = "rocket" ,
	[SITypes.entity.rocketRocket]    = "rocket" ,
	[SITypes.entity.rocketShadow]    = "rocket" ,
	[SITypes.entity.belt]            = "belt" ,
	[SITypes.entity.beltGround]      = "belt" ,
	[SITypes.entity.beltLinked]      = "belt" ,
	[SITypes.entity.beltLoader]      = "loader" ,
	[SITypes.entity.beltLoaderSmall] = "loader-1x1" ,
	[SITypes.entity.beltSplitter]    = "splitter" ,
	[SITypes.entity.pipe]            = "pipe" ,
	[SITypes.entity.pipeGround]      = "pipe" ,
	[SITypes.entity.pipeHeat]        = "pipe" ,
	[SITypes.entity.railStraight]    = "rail" ,
	[SITypes.entity.railCurved]      = "rail" ,
	[SITypes.entity.railStop]        = "rail" ,
	[SITypes.entity.railSign]        = "rail" ,
	[SITypes.entity.railChain]       = "rail" ,
	[SITypes.entity.inserter]        = "inserter" ,
	[SITypes.entity.container]       = "container" ,
	[SITypes.entity.containerLogic]  = "container" ,
	[SITypes.entity.containerLinked] = "container" ,
	[SITypes.entity.containerFluid]  = "container" ,
	[SITypes.entity.pole]            = "pole" ,
	[SITypes.entity.powerSwitch]     = "switch" ,
	[SITypes.entity.lamp]            = "lamp" ,
	[SITypes.entity.car]             = "car" ,
	[SITypes.entity.spiderVehicle]   = "spider-vehicle" ,
	[SITypes.entity.wagonLocomotive] = "wagon" ,
	[SITypes.entity.wagonCargo]      = "wagon" ,
	[SITypes.entity.wagonFluid]      = "wagon" ,
	[SITypes.entity.wagonArtillery]  = "wagon" ,
	[SITypes.entity.robotConstruct]  = "robot" ,
	[SITypes.entity.robotLogistic]   = "robot" ,
	[SITypes.entity.robotCombat]     = "robot" ,
	[SITypes.entity.roboport]        = "roboport" ,
	[SITypes.entity.playerPort]      = "port" ,
	[SITypes.entity.radar]           = "radar" ,
	[SITypes.entity.wall]            = "wall" ,
	[SITypes.entity.gate]            = "wall" ,
	[SITypes.entity.turret]          = "turret" ,
	[SITypes.entity.turretAmmo]      = "turret" ,
	[SITypes.entity.turretElectric]  = "turret" ,
	[SITypes.entity.turretArtillery] = "turret" ,
	[SITypes.entity.mine]            = "mine" ,
	[SITypes.entity.combAri]         = "combinator" ,
	[SITypes.entity.combDec]         = "combinator" ,
	[SITypes.entity.combCon]         = "combinator" ,
	[SITypes.entity.speaker]         = "speaker" ,
	[SITypes.entity.cci]             = "infinity" ,
	[SITypes.entity.eei]             = "interface" ,
	[SITypes.entity.simpleEntity]    = "simple" ,
	[SITypes.entity.simpleForce]     = "simple" ,
	[SITypes.entity.simpleOwner]     = "simple" ,
	[SITypes.entity.flyingText]      = "text" ,
	[SITypes.entity.speechBubble]    = "speech" ,
	[SITypes.entity.ghostEntity]     = "ghost" ,
	[SITypes.entity.ghostTile]       = "ghost" ,
	[SITypes.entity.proxyDt]         = "proxy" ,
	[SITypes.entity.proxyIr]         = "proxy" ,
	[SITypes.entity.highlight]       = "highlight" ,
	[SITypes.entity.flame]           = "flame" ,
	[SITypes.entity.arrow]           = "arrow" ,
	[SITypes.entity.flare]           = "flare" ,
	[SITypes.entity.smoke]           = "smoke" ,
	[SITypes.entity.stream]          = "stream"
}

local wl = { equipment = "equipment" }
local wi = { "group" , "subgroup" , "fluid" , "tile" , "signal" , "recipe" , "technology" , "input" }
for k , v in pairs( wl ) do for n , m in pairs( SITypes[k] ) do SIKeyw[m] = v end end
for i , v in pairs( wi ) do SIKeyw[SITypes[v]] = v end



-- 三个参数必须填全
function SITypes.CreateName( ConstantsData , baseName , type )
	local keyw = SIKeyw[type]
	return ConstantsData.autoName and ConstantsData.realname .. ( keyw and keyw.."-" or "" ) .. baseName or baseName
end