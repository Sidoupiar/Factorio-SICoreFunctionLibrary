SITypes =
{
	group    = "item-group" ,
	subgroup = "item-subgroup" ,
	category =
	{
		ammo      = "ammo-category" ,
		equipment = "equipment-category" ,
		fuel      = "fuel-category" ,
		module    = "module-category" ,
		recipe    = "recipe-category" ,
		resource  = "resource-category"
	} ,
	item =
	{
		item          = "item" ,
		itemEntity    = "item-with-entity-data" ,
		tool          = "tool" ,
		toolRepair    = "repair-tool" ,
		railPlanner   = "rail-planner" ,
		ammo          = "ammo" ,
		armor         = "armor" ,
		capsule       = "capsule" ,
		gun           = "gun" ,
		module        = "module" ,
		blueprint     = "blueprint" ,
		blueprintBook = "blueprint-book" ,
		redprint      = "deconstruction-item" ,
		selectionTool = "selection-tool" ,
		item_t        = "item-with-tags" ,
		item_l        = "item-with-label" ,
		item_i        = "item-with-inventory"
	} ,
	stackableItem =
	{
		item          = "item" ,
		itemEntity    = "item-with-entity-data" ,
		tool          = "tool" ,
		toolRepair    = "repair-tool" ,
		railPlanner   = "rail-planner" ,
		ammo          = "ammo" ,
		capsule       = "capsule" ,
		gun           = "gun" ,
		module        = "module"
	} ,
	iconableItem =
	{
		item      = "item" ,
		item_e    = "item-with-entity-data" ,
		tool      = "tool" ,
		ammo      = "ammo" ,
		armor     = "armor" ,
		capsule   = "capsule" ,
		gun       = "gun" ,
		module    = "module" ,
		
		fluid     = "fluid"
	} ,
	fluid         = "fluid" ,
	tile          = "tile" ,
	signal        = "virtual-signal" ,
	recipe        = "recipe" ,
	technology    = "technology" ,
	damageType    = "damage-type" ,
	equipmentGrid = "equipment-grid" ,
	beam          = "beam" ,
	decorative    = "optimized-decorative" ,
	input         = "custom-input" ,
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
		corpse_c        = "character-corpse" ,
		boiler          = "boiler" ,             -- 锅炉
		generator       = "generator" ,          -- 发电机
		burnerGenerator = "burner-generator" ,   -- 燃烧发电机
		solar           = "solar-panel" ,
		reactor         = "reactor" ,
		acc             = "accumulator" ,
		pump            = "pump" ,               -- 泵
		pump_o          = "offshore-pump" ,
		mining          = "mining-drill" ,       -- 矿机
		furnace         = "furnace" ,            -- 熔炉
		machine         = "assembling-machine" , -- 组装机
		lab             = "lab" ,
		beacon          = "beacon" ,
		market          = "market" ,
		rocket          = "rocket-silo" ,
		rocket_r        = "rocket-silo-rocket" ,
		rocket_s        = "rocket-silo-rocket-shadow" ,
		belt            = "transport-belt" ,
		beltGround      = "underground-belt" ,
		belt_l          = "loader" ,
		belt_ls         = "loader-1x1" ,
		belt_s          = "splitter" ,
		pipe            = "pipe" ,               -- 管道
		pipeGround      = "pipe-to-ground" ,
		pipeHeat        = "heat-pipe" ,
		rail_str        = "straight-rail" ,
		rail_cur        = "curved-rail" ,
		rail_stop       = "train-stop" ,
		rail_sign       = "rail-signal" ,
		rail_chain      = "rail-chain-signal" ,
		z               = "inserter" ,
		container       = "container" ,
		containerLogic  = "logistic-container" ,
		containerLinked = "linked-container" ,
		containerFluid  = "storage-tank" ,
		pole_e          = "electric-pole" ,
		power_switch    = "power-switch" ,
		lamp            = "lamp" ,
		car             = "car" ,
		spiderVehicle   = "spider-vehicle" ,
		w_l             = "locomotive" ,
		w_c             = "cargo-wagon" ,
		w_f             = "fluid-wagon" ,
		w_a             = "artillery-wagon" ,
		robotConstruct  = "construction-robot" , -- 建设机器人
		robotLogistic   = "logistic-robot" ,     -- 物流机器人
		robotCombat     = "combat-robot" ,       -- 攻击机器人
		roboport        = "roboport" ,           -- 指令平台
		playerPort      = "player-port" ,
		radar           = "radar" ,
		wall            = "wall" ,
		gate            = "gate" ,
		t               = "turret" ,
		t_a             = "ammo-turret" ,
		t_e             = "electric-turret" ,
		t_r             = "artillery-turret" ,
		mine            = "land-mine" ,
		comb_a          = "arithmetic-combinator" ,
		comb_d          = "decider-combinator" ,
		comb_c          = "constant-combinator" ,
		speaker         = "programmable-speaker" ,
		cci             = "infinity-container" ,
		eei             = "electric-energy-interface" ,
		simpleEntity    = "simple-entity" ,
		simpleForce     = "simple-entity-with-force" ,
		simpleOwner     = "simple-entity-with-owner" ,
		flyingText      = "flying-text" ,
		sb              = "speech-bubble" ,
		eg              = "entity-ghost" ,
		tg              = "tile-ghost" ,
		dt              = "deconstructible-tile-proxy" ,
		ir              = "item-request-proxy" ,
		hb              = "highlight-box" ,
		fe              = "flame-thrower-explosion" ,
		ar              = "arrow" ,
		af              = "artillery-flare" ,
		ts              = "trivial-smoke" ,
		st              = "stream"
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
		pump_o          = "offshore-pump" ,
		mining          = "mining-drill" ,       -- 矿机
		furnace         = "furnace" ,            -- 熔炉
		machine         = "assembling-machine" , -- 组装机
		lab             = "lab" ,
		beacon          = "beacon" ,
		market          = "market" ,
		rocket          = "rocket-silo" ,
		belt            = "transport-belt" ,
		beltGround      = "underground-belt" ,
		belt_l          = "loader" ,
		belt_ls         = "loader-1x1" ,
		belt_s          = "splitter" ,
		pipe            = "pipe" ,
		pipeGround      = "pipe-to-ground" ,
		pipeHeat        = "heat-pipe" ,
		rail_str        = "straight-rail" ,
		rail_cur        = "curved-rail" ,
		rail_stop       = "train-stop" ,
		rail_sign       = "rail-signal" ,
		rail_chain      = "rail-chain-signal" ,
		z               = "inserter" ,
		container       = "container" ,
		containerLogic  = "logistic-container" ,
		containerLinked = "linked-container" ,
		containerFluid  = "storage-tank" ,
		pole_e          = "electric-pole" ,
		power_switch    = "power-switch" ,
		lamp            = "lamp" ,
		car             = "car" ,
		spiderVehicle   = "spider-vehicle" ,
		w_l             = "locomotive" ,
		w_c             = "cargo-wagon" ,
		w_f             = "fluid-wagon" ,
		w_a             = "artillery-wagon" ,
		robotConstruct  = "construction-robot" ,
		robotLogistic   = "logistic-robot" ,
		robotCombat     = "combat-robot" ,
		roboport        = "roboport" ,
		playerPort      = "player-port" ,
		radar           = "radar" ,
		wall            = "wall" ,
		gate            = "gate" ,
		t               = "turret" ,
		t_a             = "ammo-turret" ,
		t_e             = "electric-turret" ,
		t_r             = "artillery-turret" ,
		mine            = "land-mine" ,
		comb_a          = "arithmetic-combinator" ,
		comb_d          = "decider-combinator" ,
		comb_c          = "constant-combinator" ,
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
		pump_o          = "offshore-pump" ,
		mining          = "mining-drill" ,       -- 矿机
		furnace         = "furnace" ,            -- 熔炉
		machine         = "assembling-machine" , -- 组装机
		lab             = "lab" ,
		beacon          = "beacon" ,
		market          = "market" ,
		rocket          = "rocket-silo" ,
		belt            = "transport-belt" ,
		beltGround      = "underground-belt" ,
		belt_l          = "loader" ,
		belt_ls         = "loader-1x1" ,
		belt_s          = "splitter" ,
		pipe            = "pipe" ,
		pipeGround      = "pipe-to-ground" ,
		pipeHeat        = "heat-pipe" ,
		rail_str        = "straight-rail" ,
		rail_cur        = "curved-rail" ,
		rail_stop       = "train-stop" ,
		rail_sign       = "rail-signal" ,
		rail_chain      = "rail-chain-signal" ,
		z               = "inserter" ,
		container       = "container" ,
		containerLogic  = "logistic-container" ,
		containerLinked = "linked-container" ,
		containerFluid  = "storage-tank" ,
		pole_e          = "electric-pole" ,
		power_switch    = "power-switch" ,
		lamp            = "lamp" ,
		roboport        = "roboport" ,
		playerPort      = "player-port" ,
		radar           = "radar" ,
		wall            = "wall" ,
		gate            = "gate" ,
		t               = "turret" ,
		t_a             = "ammo-turret" ,
		t_e             = "electric-turret" ,
		t_r             = "artillery-turret" ,
		comb_a          = "arithmetic-combinator" ,
		comb_d          = "decider-combinator" ,
		comb_c          = "constant-combinator" ,
		speaker         = "programmable-speaker" ,
		cci             = "infinity-container" ,
		eei             = "electric-energy-interface"
	} ,
	equipment =
	{
		night           = "night-vision-equipment" ,
		shield          = "energy-shield-equipment" ,
		battery         = "battery-equipment" ,
		solar           = "solar-panel-equipment" ,
		generatorEquip  = "generator-equipment" ,
		active_def      = "active-defense-equipment" ,
		movement        = "movement-bonus-equipment" ,
		roboport        = "roboport-equipment" ,
		belt_immune     = "belt-immunity-equipment"
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
		all   = "all" ,
		admin = "admin" ,
		none  = "none"
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
		speed = "speed" ,
		product = "productivity" ,
		consumption = "consumption" ,
		pollut = "pollution"
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
	} ,
	energy =
	{
		electric = "electric" ,
		burner = "burner" ,
		heat = "heat" ,
		fluid = "fluid" ,
		void = "void"
	} ,
	rock =
	{
		small = "rock-small" ,
		medium = "rock-medium" ,
		big = "rock-big"
	} ,
	view =
	{
		frame = "" ,
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
	[SITypes.item.item_t]            = "item" ,
	[SITypes.item.item_l]            = "item" ,
	[SITypes.item.item_i]            = "item" ,
	
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
	[SITypes.entity.corpse_c]        = "corpse" ,
	[SITypes.entity.boiler]          = "boiler" ,           -- 锅炉
	[SITypes.entity.generator]       = "generator" ,        -- 发电机
	[SITypes.entity.burnerGenerator] = "burner-generator" , -- 燃烧发电机
	[SITypes.entity.solar]           = "solar" ,
	[SITypes.entity.reactor]         = "reactor" ,
	[SITypes.entity.acc]             = "acc" ,
	[SITypes.entity.pump]            = "pump" ,             -- 泵
	[SITypes.entity.pump_o]          = "pump" ,
	[SITypes.entity.mining]          = "mining" ,           -- 矿机
	[SITypes.entity.furnace]         = "furnace" ,          -- 熔炉
	[SITypes.entity.machine]         = "machine" ,          -- 组装机
	[SITypes.entity.lab]             = "lab" ,
	[SITypes.entity.beacon]          = "beacon" ,
	[SITypes.entity.market]          = "market" ,
	[SITypes.entity.rocket]          = "rocket" ,
	[SITypes.entity.rocket_r]        = "rocket" ,
	[SITypes.entity.rocket_s]        = "rocket" ,
	[SITypes.entity.belt]            = "belt" ,
	[SITypes.entity.beltGround]      = "belt" ,
	[SITypes.entity.belt_l]          = "loader" ,
	[SITypes.entity.belt_ls]         = "loader-1x1" ,
	[SITypes.entity.belt_s]          = "splitter" ,
	[SITypes.entity.pipe]            = "pipe" ,
	[SITypes.entity.pipeGround]      = "pipe" ,
	[SITypes.entity.pipeHeat]        = "pipe" ,
	[SITypes.entity.rail_str]        = "rail" ,
	[SITypes.entity.rail_cur]        = "rail" ,
	[SITypes.entity.rail_stop]       = "rail" ,
	[SITypes.entity.rail_sign]       = "rail" ,
	[SITypes.entity.rail_chain]      = "rail" ,
	[SITypes.entity.z]               = "inserter" ,
	[SITypes.entity.container]       = "container" ,
	[SITypes.entity.containerLogic]  = "container" ,
	[SITypes.entity.containerLinked] = "container" ,
	[SITypes.entity.containerFluid]  = "container" ,
	[SITypes.entity.pole_e]          = "pole" ,
	[SITypes.entity.power_switch]    = "switch" ,
	[SITypes.entity.lamp]            = "lamp" ,
	[SITypes.entity.car]             = "car" ,
	[SITypes.entity.spiderVehicle]   = "spider-vehicle" ,
	[SITypes.entity.w_l]             = "wagon" ,
	[SITypes.entity.w_c]             = "wagon" ,
	[SITypes.entity.w_f]             = "wagon" ,
	[SITypes.entity.w_a]             = "wagon" ,
	[SITypes.entity.robotConstruct]  = "robot" ,
	[SITypes.entity.robotLogistic]   = "robot" ,
	[SITypes.entity.robotCombat]     = "robot" ,
	[SITypes.entity.roboport]        = "roboport" ,
	[SITypes.entity.playerPort]      = "port" ,
	[SITypes.entity.radar]           = "radar" ,
	[SITypes.entity.wall]            = "wall" ,
	[SITypes.entity.gate]            = "wall" ,
	[SITypes.entity.t]               = "turret" ,
	[SITypes.entity.t_a]             = "turret" ,
	[SITypes.entity.t_e]             = "turret" ,
	[SITypes.entity.t_r]             = "turret" ,
	[SITypes.entity.mine]            = "mine" ,
	[SITypes.entity.comb_a]          = "combinator" ,
	[SITypes.entity.comb_d]          = "combinator" ,
	[SITypes.entity.comb_c]          = "combinator" ,
	[SITypes.entity.speaker]         = "speaker" ,
	[SITypes.entity.cci]             = "infinity" ,
	[SITypes.entity.eei]             = "interface" ,
	[SITypes.entity.simpleEntity]    = "simple-entity" ,
	[SITypes.entity.simpleForce]     = "simple-force" ,
	[SITypes.entity.simpleOwner]     = "simple-owner" ,
	[SITypes.entity.flyingText]      = "text" ,
	[SITypes.entity.sb]              = "speech" ,
	[SITypes.entity.eg]              = "eghost" ,
	[SITypes.entity.tg]              = "tghost" ,
	[SITypes.entity.dt]              = "dtproxy" ,
	[SITypes.entity.ir]              = "irproxy" ,
	[SITypes.entity.hb]              = "highlight" ,
	[SITypes.entity.fe]              = "flame" ,
	[SITypes.entity.ar]              = "arrow" ,
	[SITypes.entity.af]              = "flare" ,
	[SITypes.entity.ts]              = "smoke" ,
	[SITypes.entity.st]              = "stream"
}

local wl = { equipment = "equipment" }
local wi = { "group" , "subgroup" , "fluid" , "tile" , "signal" , "recipe" , "technology" }
for k , v in pairs( wl ) do for n , m in pairs( SITypes[k] ) do SIKeyw[m] = v end end
for i , v in pairs( wi ) do SIKeyw[SITypes[v]] = v end