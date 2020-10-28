-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIPackers =
{
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 封装数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPackers.CreatePack( sourceData )
	return { isPack = true , data = sourceData }
end

-- ------------------------------------------------------------------------------------------------
-- ------- 创建 icon 数据 -------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPackers.IconPack( iconPath , tint , mipmaps )
	return SIPackers.CreatePack( SIPackers.Icon( iconPath , tint , mipmaps ) )
end

function SIPackers.Icon( iconPath , tint , mipmaps )
	local icon = {}
	local dataType = type( iconPath )
	if dataType == "string" then
		if iconPath then icon.icon = iconPath end
		if tint then icon.tint = tint end
		if mipmaps then icon.icon_mipmaps = mipmaps end
	elseif dataType == "table" then
		if iconPath.iconPath then icon.icon = iconPath.iconPath end
		if iconPath.tint or tint then icon.tint = iconPath.tint or tint end
		if iconPath.mipmaps or mipmaps then icon.icon_mipmaps = iconPath.mipmaps or mipmaps end
	end
	return icon
end

-- ------------------------------------------------------------------------------------------------
-- -------- 创建能源数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPackers.EnergySourcePack( energySourceType , parameters )
	return SIPackers.CreatePack( SIPackers.EnergySource( energySourceType , parameters ) )
end

function SIPackers.ElectricEnergySourcePack( usage , buffer , drain , inputLimit , outputLimit , emissions )
	return SIPackers.CreatePack( SIPackers.ElectricEnergySource( usage , buffer , drain , inputLimit , outputLimit , emissions ) )
end

function SIPackers.EnergySource( energySourceType , parameters )
	local dataType = type( parameters )
	if dataType == "table" then
		if parameters.isPack then parameters = table.deepcopy( parameters.data )
		else parameters = table.deepcopy( parameters ) end
	end
	if energySourceType == SITypes.energy.electric then return SIPackers.ElectricEnergySourceWithParameters( parameters , dataType )
	elseif energySourceType == SITypes.energy.burner then return SIPackers.BurnerEnergySourceWithParameters( parameters , dataType )
	elseif energySourceType == SITypes.energy.heat then return SIPackers.HeatEnergySourceWithParameters( parameters , dataType )
	elseif energySourceType == SITypes.energy.fluid then return SIPackers.FluidEnergySourceWithParameters( parameters , dataType )
	else return { type = SITypes.energy.void } end
end

function SIPackers.ElectricEnergySourceWithParameters( parameters , dataType )
	if not dataType then dataType = type( parameters ) end
	if dataType ~= "table" then parameters = { usage_priority = parameters } end
	return SIPackers.ElectricEnergySource( parameters.usage_priority , parameters.buffer_capacity , parameters.drain , parameters.input_flow_limit , parameters.output_flow_limit , parameters.emissions_per_second_per_watt )
end

function SIPackers.BurnerEnergySourceWithParameters( parameters , dataType )
	if not dataType then dataType = type( parameters ) end
	if dataType ~= "table" then parameters = { fuel_inventory_size = parameters }
	elseif parameters.fuel_category and not parameters.fuel_categories then parameters.fuel_categories = { parameters.fuel_category } end
	return SIPackers.BurnerEnergySource( parameters.fuel_inventory_size , parameters.burnt_inventory_size , parameters.smoke , parameters.light_flicker , parameters.effectivity , parameters.fuel_categories )
end

function SIPackers.HeatEnergySourceWithParameters( parameters , dataType )
	if not dataType then dataType = type( parameters ) end
	if dataType ~= "table" then parameters = { specific_heat = parameters , max_transfer = parameters , max_temperature = 1000 } end
	return SIPackers.HeatEnergySource( parameters.specific_heat , parameters.max_transfer , parameters.max_temperature , parameters.default_temperature , parameters.min_temperature_gradient , parameters.min_working_temperature , parameters.minimum_glow_temperature , parameters.pipe_covers , parameters.heat_pipe_covers , parameters.heat_picture , parameters.heat_glow , parameters.connections )
end

function SIPackers.FluidEnergySourceWithParameters( parameters , dataType )
	if not dataType then dataType = type( parameters ) end
	if dataType ~= "table" then parameters = { fluid_box = parameters } end
	return SIPackers.FluidEnergySource( parameters.fluid_box , parameters.smoke , parameters.light_flicker , parameters.effectivity , parameters.burns_fluid , parameters.scale_fluid_usage , parameters.fluid_usage_per_tick , parameters.maximum_temperature )
end

-- 必要 : usage
function SIPackers.ElectricEnergySource( usage , buffer , drain , inputLimit , outputLimit , emissions )
	local source = { type = SITypes.energy.electric }
	if not usage then source.usage_priority = SITypes.electricUsagePriority.secondaryInput
	else source.usage_priority = usage end
	if buffer then source.buffer_capacity = buffer end
	if drain then source.drain = drain end
	if inputLimit then source.input_flow_limit = inputLimit end
	if outputLimit then source.output_flow_limit = outputLimit end
	if emissions then source.emissions_per_second_per_watt = emissions end
	return source
end

-- 必要 : fuelSize
function SIPackers.BurnerEnergySource( fuelSize , burntSize , smoke , lightFlicker , effectivity , fuelCategories )
	local source = { type = SITypes.energy.burner }
	if not fuelSize then source.fuel_inventory_size = 1
	else source.fuel_inventory_size = fuelSize end
	if burntSize then source.burnt_inventory_size = burntSize end
	if smoke then source.smoke = smoke end
	if lightFlicker then source.light_flicker = lightFlicker end
	if effectivity then source.effectivity = effectivity end
	if fuelCategories then source.fuel_categories = fuelCategories end
	return source
end

-- 必要 : specificHeat , maxTransfer , maxTemperature
function SIPackers.HeatEnergySource( specificHeat , maxTransfer , maxTemperature , defaultTemperature , minTemperatureGradient , minWorkingTemperature , minimumGlowTemperature , pipeCovers , heatPipeCovers , heatPicture , heatGlow , connections )
	local source = { type = SITypes.energy.heat }
	if specificHeat then source.specific_heat = specificHeat end
	if maxTransfer then source.max_transfer = maxTransfer end
	if not maxTemperature then source.max_temperature = 1000
	else source.max_temperature = maxTemperature end
	if defaultTemperature then source.default_temperature = defaultTemperature end
	if minTemperatureGradient then source.min_temperature_gradient = minTemperatureGradient end
	if minWorkingTemperature then source.min_working_temperature = minWorkingTemperature end
	if minimumGlowTemperature then source.minimum_glow_temperature = minimumGlowTemperature end
	if pipeCovers then source.pipe_covers = pipeCovers end
	if heatPipeCovers then source.heat_pipe_covers = heatPipeCovers end
	if heatPicture then source.heat_picture = heatPicture end
	if heatGlow then source.heat_glow = heatGlow end
	if connections then source.connections = connections end
	return source
end

-- 必要 : fluidBox
function SIPackers.FluidEnergySource( fluidBox , smoke , lightFlicker , effectivity , burnsFluid , scaleFluidUsage , fluidUsage , maxTemperature )
	local source = { type = SITypes.energy.fluid }
	if fluidBox then source.fluid_box = fluidBox end
	if smoke then source.smoke = smoke end
	if lightFlicker then source.light_flicker = lightFlicker end
	if effectivity then source.effectivity = effectivity end
	if burnsFluid then source.burns_fluid = burnsFluid end
	if scaleFluidUsage then source.scale_fluid_usage = scaleFluidUsage end
	if fluidUsage then source.fluid_usage_per_tick = fluidUsage end
	if maxTemperature then source.maximum_temperature = maxTemperature end
	return source
end

function SIPackers.EnergySourceOtherSettings( energySourceOrPack , emissions , render_noPowerIcon , render_noNetworkIcon )
	local energySource = {}
	if energySourceOrPack.isPack then energySource = energySourceOrPack.data
	else energySource = energySourceOrPack end
	energySource.emissions_per_minute = emissions
	energySource.render_no_power_icon = render_noPowerIcon
	energySource.render_no_network_icon = render_noNetworkIcon
	return energySourceOrPack
end

-- ------------------------------------------------------------------------------------------------
-- -------- 创建原料数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPackers.SingleItemIngredientsPack( name , count )
	return SIPackers.CreatePack{ SIPackers.SingleItemIngredient( name , count ) }
end

function SIPackers.SingleItemIngredientPack( name , count )
	return SIPackers.CreatePack( SIPackers.SingleItemIngredient( name , count ) )
end

function SIPackers.SingleFluidIngredientsPack( name , count , minTemperature , maxTemperature )
	return SIPackers.CreatePack{ SIPackers.SingleFluidIngredient( name , count , minTemperature , maxTemperature ) }
end

function SIPackers.SingleFluidIngredientPack( name , count , minTemperature , maxTemperature )
	return SIPackers.CreatePack( SIPackers.SingleFluidIngredient( name , count , minTemperature , maxTemperature ) )
end

function SIPackers.SingleItemIngredient( name , count )
	local ingredient = { type = SITypes.item.item , name = name }
	if count then ingredient.amount = count
	else ingredient.amount = 1 end
	return ingredient
end

function SIPackers.SingleFluidIngredient( name , count , minTemperature , maxTemperature )
	local ingredient = { type = SITypes.fluid , name = name }
	if count then ingredient.amount = count
	else ingredient.amount = 1 end
	if minTemperature then ingredient.minimum_temperature = minTemperature end
	if maxTemperature then ingredient.maximum_temperature = maxTemperature end
	return ingredient
end

function SIPackers.AddIngredients( recipeData , ... )
	local ingredientList = { ... }
	for i , v in pairs( ingredientList ) do if v.isPack then ingredientList[i] = v.data end end
	if recipeData.normal then SIPackers.AppendIngredients( recipeData.normal , ingredientList ) end
	if recipeData.expensive then SIPackers.AppendIngredients( recipeData.expensive , ingredientList ) end
	if recipeData.ingredients then SIPackers.AppendIngredients( recipeData , ingredientList ) end
	return recipeData
end

function SIPackers.AppendIngredients( ingredientsData , newIngredients )
	if not ingredientsData.ingredients then ingredientsData.ingredients = {} end
	for i , v in pairs( newIngredients ) do table.insert( ingredientsData.ingredients , v ) end
	return ingredientsData
end

-- ------------------------------------------------------------------------------------------------
-- -------- 创建产物数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPackers.SingleItemProductsPack( name , count , probability , minCount , maxCount )
	return SIPackers.CreatePack{ SIPackers.SingleItemProduct( name , count , probability , minCount , maxCount ) }
end

function SIPackers.SingleItemProductPack( name , count , probability , minCount , maxCount )
	return SIPackers.CreatePack( SIPackers.SingleItemProduct( name , count , probability , minCount , maxCount ) )
end

function SIPackers.SingleFluidProductsPack( name , count , probability , minCount , maxCount , temperature )
	return SIPackers.CreatePack{ SIPackers.SingleFluidProduct( name , count , probability , minCount , maxCount , temperature ) }
end

function SIPackers.SingleFluidProductPack( name , count , probability , minCount , maxCount , temperature )
	return SIPackers.CreatePack( SIPackers.SingleFluidProduct( name , count , probability , minCount , maxCount , temperature ) )
end

function SIPackers.SingleItemProduct( name , count , probability , minCount , maxCount )
	local product = { type = SITypes.item.item , name = name }
	if count then product.amount = count
	else product.amount = 1 end
	if probability then product.probability = probability end
	if minCount then product.amount_min = minCount end
	if maxCount then product.amount_max = maxCount end
	return product
end

function SIPackers.SingleFluidProduct( name , count , probability , minCount , maxCount , temperature )
	local product = { type = SITypes.fluid , name = name }
	if count then product.amount = count
	else product.amount = 1 end
	if probability then product.probability = probability end
	if minCount then product.amount_min = minCount end
	if maxCount then product.amount_max = maxCount end
	if temperature then product.temperature = temperature end
	return product
end

function SIPackers.AddProducts( recipeData , ... )
	local productList = { ... }
	for i , v in pairs( productList ) do if v.isPack then productList[i] = v.data end end
	if recipeData.normal then SIPackers.AppendProducts( recipeData.normal , productList ) end
	if recipeData.expensive then SIPackers.AppendProducts( recipeData.expensive , productList ) end
	if recipeData.result or recipeData.results then SIPackers.AppendProducts( recipeData , productList ) end
	return recipeData
end

function SIPackers.AppendProducts( productsData , newProducts )
	local results = productsData.results
	if not results then
		results = {}
		if productsData.result then
			table.insert( results , SIPackers.SingleItemProduct( productsData.result , productsData.result_count ) )
			productsData.result = nil
			productsData.result_count = nil
		end
	end
	for i , v in pairs( newProducts ) do table.insert( results , v ) end
	productsData.results = results
	return ingredientsData
end

-- ------------------------------------------------------------------------------------------------
-- ------- 创建科技瓶数据 -------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPackers.UnitPack( ingredients , time , count )
	return SIPackers.CreatePack( SIPackers.Unit( ingredients , time , count ) )
end

function SIPackers.SingleIngredientsUnitPack( name , count )
	return SIPackers.CreatePack( SIPackers.Unit( SIPackers.SingleIngredientUnit( name , count ) ) )
end

function SIPackers.Unit( ingredients , count , time )
	local unit = {}
	local ingredientsType = type( ingredients )
	if ingredientsType == "string" then unit.ingredients = { SIPackers.SingleIngredientUnit( ingredients ) }
	elseif ingredientsType == "table" then
		if table.Size( ingredients ) > 0 then
			local itemType = type( ingredients[1] )
			if itemType == "string" then unit.ingredients = SIPackers.IngredientsListUnits( ingredients )
			elseif itemType == "table" then unit.ingredients = ingredients
			else unit.ingredients = SIPackers.IngredientsUnits( ingredients ) end
		end
	end
	if not unit.ingredients then unit.ingredients = {} end
	local countType = type( count )
	if countType == "number" then unit.count = count
	elseif countType == "string" then unit.count_formula = count
	else unit.count = 100 end
	if time then unit.time = time
	else unit.time = 60 end
	return unit
end

function SIPackers.IngredientsListUnits( ingredientsList )
	local unitItems = {}
	for i , v in pairs( ingredientsList ) do table.insert( unitItems , SIPackers.SingleIngredientUnit( v ) ) end
	return unitItems
end

function SIPackers.IngredientsUnits( ingredientsTable )
	local unitItems = {}
	for k , v in pairs( ingredientsTable ) do table.insert( unitItems , SIPackers.SingleIngredientUnit( k , v ) ) end
	return unitItems
end

function SIPackers.SingleIngredientUnit( name , count )
	local unitItem = { name }
	if count then table.insert( unitItem , count )
	else table.insert( unitItem , 1 ) end
	return unitItem
end

-- ------------------------------------------------------------------------------------------------
-- ------ 创建科技效果数据 ------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPackers.RecipeModifiersPack( recipeList )
	return SIPackers.CreatePack( SIPackers.RecipeModifiers( recipeList ) )
end

function SIPackers.SingleNothingModifierPack( description )
	return SIPackers.CreatePack( SIPackers.SingleNothingModifier( description ) )
end

function SIPackers.SingleModifiersPack( modifierType , param1 , param2 )
	return SIPackers.CreatePack{ SIPackers.SingleModifier( modifierType , param1 , param2 ) }
end

function SIPackers.SingleModifierPack( modifierType , param1 , param2 )
	return SIPackers.CreatePack( SIPackers.SingleModifier( modifierType , param1 , param2 ) )
end

function SIPackers.RecipeModifiers( recipeList )
	local modifier = {}
	for i , v in pairs( recipeList ) do table.insert( modifier , SIPackers.SingleModifier( nil , v ) ) end
	return modifier
end

function SIPackers.SingleNothingModifier( description )
	if type( description ) == "string" then description = { description } end
	return SIPackers.SingleModifier( SITypes.modifier.nothing , description )
end

function SIPackers.SingleModifier( modifierType , param1 , param2 )
	local modifier = {}
	if not modifierType then modifierType = SITypes.modifier.unlockRecipe end
	modifier.type = modifierType
	if modifierType == SITypes.modifier.unlockRecipe then
		modifier.recipe = param1
	elseif modifierType == SITypes.modifier.gunSpeed then
		modifier.ammo_category = param1
		modifier.modifier = param2
	elseif modifierType == SITypes.modifier.turretAttack then
		modifier.turret_id = param1
		modifier.modifier = param2
	elseif modifierType == SITypes.modifier.giveItem then
		modifier.item = param1
		modifier.count = param2
	elseif modifierType == SITypes.modifier.nothing then
		modifier.effect_description = param1
	else modifier.modifier = param1 end
	return modifier
end

-- ------------------------------------------------------------------------------------------------
-- -------- 创建边框数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPackers.BoundBoxPack( width , height )
	return SIPackers.CreatePack( SIPackers.BoundBox( width , height ) )
end

function SIPackers.CollisionBoundBoxPack( width , height )
	return SIPackers.CreatePack( SIPackers.CollisionBoundBox( width , height ) )
end

function SIPackers.BoundBox( width , height )
	if not height then height = width end
	halfWidth = width / 2.0
	halfHeight = height / 2.0
	return { { -halfWidth , -halfHeight } , { halfWidth , halfHeight } }
end

function SIPackers.CollisionBoundBox( width , height )
	width = width * 0.95
	if not height then height = width end
	halfWidth = width / 2.0
	halfHeight = height / 2.0
	return { { -halfWidth , -halfHeight } , { halfWidth , halfHeight } }
end

-- ------------------------------------------------------------------------------------------------
-- -------- 创建抗性数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPackers.ResistancesPack( name , decrease , percent )
	return SIPackers.CreatePack{ SIPackers.Resistance( name , decrease , percent ) }
end

function SIPackers.ResistancePack( name , decrease , percent )
	return SIPackers.CreatePack( SIPackers.Resistance( name , decrease , percent ) )
end

function SIPackers.Resistance( name , decrease , percent )
	local resistance = { type = name }
	if decrease then resistance.decrease = decrease end
	if percent then resistance.percent = percent end
	if not resistance.decrease and not resistance.percent then resistance.decrease = 10 end
	return resistance
end