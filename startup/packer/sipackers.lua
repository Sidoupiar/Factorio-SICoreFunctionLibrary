-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIPackers =
{
	resourceAutoplace = need( "__core__/lualib/resource-autoplace" )
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 封装数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPackers.CreatePack( sourceData )
	return { isPack = true , data = sourceData }
end

-- ------------------------------------------------------------------------------------------------
-- -------- 创建颜色数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPackers.Color( red , green , blue , alpha )
	local color = {}
	if red then color.r = math.Range( red , 0 , 1 ) end
	if green then color.g = math.Range( green , 0 , 1 ) end
	if blue then color.b = math.Range( blue , 0 , 1 ) end
	if alpha then color.a = math.Range( alpha , 0 , 1 ) end
	return color
end

function SIPackers.ColorCopyWith( color , red , green , blue , alpha )
	local color = table.deepcopy( color )
	if red then color.r = math.Range( red , 0 , 1 ) end
	if green then color.g = math.Range( green , 0 , 1 ) end
	if blue then color.b = math.Range( blue , 0 , 1 ) end
	if alpha then color.a = math.Range( alpha , 0 , 1 ) end
	return color
end

function SIPackers.ColorCopyWithR( color , red )
	local color = table.deepcopy( color )
	if red then color.r = math.Range( red , 0 , 1 ) end
	return color
end

function SIPackers.ColorCopyWithG( color , green )
	local color = table.deepcopy( color )
	if green then color.g = math.Range( green , 0 , 1 ) end
	return color
end

function SIPackers.ColorCopyWithB( color , blue )
	local color = table.deepcopy( color )
	if blue then color.b = math.Range( blue , 0 , 1 ) end
	return color
end

function SIPackers.ColorCopyWithA( color , alpha )
	local color = table.deepcopy( color )
	if alpha then color.a = math.Range( alpha , 0 , 1 ) end
	return color
end

function SIPackers.Color256( red , green , blue , alpha )
	local color = {}
	if red then color.r = math.Range( red/256 , 0 , 1 ) end
	if green then color.g = math.Range( green/256 , 0 , 1 ) end
	if blue then color.b = math.Range( blue/256 , 0 , 1 ) end
	if alpha then color.a = math.Range( alpha/256 , 0 , 1 ) end
	return color
end

function SIPackers.ColorCopyWith256( color , red , green , blue , alpha )
	local color = table.deepcopy( color )
	if red then color.r = math.Range( red/256 , 0 , 1 ) end
	if green then color.g = math.Range( green/256 , 0 , 1 ) end
	if blue then color.b = math.Range( blue/256 , 0 , 1 ) end
	if alpha then color.a = math.Range( alpha/256 , 0 , 1 ) end
	return color
end

function SIPackers.ColorCopyWithR256( color , red )
	local color = table.deepcopy( color )
	if red then color.r = math.Range( red/256 , 0 , 1 ) end
	return color
end

function SIPackers.ColorCopyWithG256( color , green )
	local color = table.deepcopy( color )
	if green then color.g = math.Range( green/256 , 0 , 1 ) end
	return color
end

function SIPackers.ColorCopyWithB256( color , blue )
	local color = table.deepcopy( color )
	if blue then color.b = math.Range( blue/256 , 0 , 1 ) end
	return color
end

function SIPackers.ColorCopyWithA256( color , alpha )
	local color = table.deepcopy( color )
	if alpha then color.a = math.Range( alpha/256 , 0 , 1 ) end
	return color
end

function SIPackers.ColorBright( colorPack , bright )
	local newColor = {}
	if colorPack.r then newColor.r = math.Range( (1-colorPack.r)*bright+colorPack.r , 0 , 1 ) end
	if colorPack.g then newColor.g = math.Range( (1-colorPack.g)*bright+colorPack.g , 0 , 1 ) end
	if colorPack.b then newColor.b = math.Range( (1-colorPack.b)*bright+colorPack.b , 0 , 1 ) end
	if colorPack.a then newColor.a = colorPack.a end
	return newColor
end

function SIPackers.ColorDark( colorPack , dark )
	local newColor = {}
	if colorPack.r then newColor.r = math.Range( colorPack.r*dark , 0 , 1 ) end
	if colorPack.g then newColor.g = math.Range( colorPack.g*dark , 0 , 1 ) end
	if colorPack.b then newColor.b = math.Range( colorPack.b*dark , 0 , 1 ) end
	if colorPack.a then newColor.a = colorPack.a end
	return newColor
end

-- ------------------------------------------------------------------------------------------------
-- ------- 创建 icon 数据 -------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPackers.IconPack( iconPath , tint , mipmaps )
	return SIPackers.CreatePack( SIPackers.Icon( iconPath , tint , mipmaps ) )
end

function SIPackers.Icon( iconPath , tint , mipmaps , scale , shift , size )
	local icon = {}
	if iconPath then
		if not iconPath:EndsWith( ".png" ) then iconPath = iconPath .. ".png" end
		icon.icon = iconPath
	end
	if tint then icon.tint = tint end
	if mipmaps then icon.icon_mipmaps = mipmaps
	else icon.icon_mipmaps = 4 end
	if scale then icon.scale = scale end
	if shift then icon.shift = shift end
	if size then icon.icon_size = size end
	return icon
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
	height = height or width
	halfWidth = width / 2.0
	halfHeight = height / 2.0
	return { { -halfWidth , -halfHeight } , { halfWidth , halfHeight } }
end

function SIPackers.CollisionBoundBox( width , height )
	width = width * 0.95
	if not height then height = width
	else height = height * 0.95 end
	halfWidth = width / 2.0
	halfHeight = height / 2.0
	return { { -halfWidth , -halfHeight } , { halfWidth , halfHeight } }
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
	source.usage_priority = usage or SITypes.electricUsagePriority.secondaryInput
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
	source.fuel_inventory_size = fuelSize or 1
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
	source.max_temperature = maxTemperature or 1000
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

function SIPackers.AddEnergySourceUsage( energySourceOrPack , usage )
	local energySource = {}
	if energySourceOrPack.isPack then energySource = energySourceOrPack.data
	else energySource = energySourceOrPack end
	energySource.usage_priority = usage or SITypes.electricUsagePriority.secondaryInput
	return energySourceOrPack
end

-- ------------------------------------------------------------------------------------------------
-- -------- 创建光线数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPackers.LightPack( intensity , size , color )
	return SIPackers.CreatePack( SIPackers.Light( intensity , size , color ) )
end

function SIPackers.Light( intensity , size , color )
	return { intensity = intensity , size = size , color = color }
end

-- ------------------------------------------------------------------------------------------------
-- -------- 创建信号数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPackers.SignalsPack( name )
	return SIPackers.CreatePack{ SIPackers.Signal( name ) }
end

function SIPackers.SignalPack( name )
	return SIPackers.CreatePack( SIPackers.Signal( name ) )
end

function SIPackers.Signal( name )
	return { type = "virtual" , name = function() return true , SIGen.autoFillType.virtual , name end }
end

-- ------------------------------------------------------------------------------------------------
-- -------- 创建流体盒子 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPackers.FluidBoxPack( area , connections , baseLevel , productionType , levelHeight , filter , minTemperature , maxTemperature )
	return SIPackers.CreatePack( SIPackers.FluidBox( area , connections , baseLevel , productionType , levelHeight , filter , minTemperature , maxTemperature ) )
end

function SIPackers.FluidBox( area , connections , baseLevel , productionType , levelHeight , filter , minTemperature , maxTemperature )
	local box = {}
	if connections.position or connections.positions then box.pipe_connections = { connections }
	else
		local data = connections[1]
		if data then
			local dataType = type( data )
			if dataType == "number" then box.pipe_connections = { SIPackers.FluidBoxConnection( connections ) }
			elseif dataType == "table" then
				if connections[1].position then box.pipe_connections = connections
				else box.pipe_connections = SIPackers.FluidBoxConnections( connections ) end
			else box.pipe_connections = {} end
		else box.pipe_connections = {} end
	end
	box.base_area = area or 1
	box.base_level = baseLevel or 0
	box.production_type = productionType or SITypes.fluidBoxProductionType.none
	box.height = levelHeight or 1
	if filter then
		box.filter = filter
		if minTemperature then box.minimum_temperature = minTemperature end
		if maxTemperature then box.maximum_temperature = maxTemperature end
	end
	return box
end

function SIPackers.FluidBoxAdden( box , renderLayer , covers , picture , secondaryDrawOrders )
	if renderLayer then box.render_layer = renderLayer end
	if covers then box.pipe_covers = covers end
	if picture then box.pipe_picture = picture end
	if secondaryDrawOrders then box.secondary_draw_orders = secondaryDrawOrders end
	return box
end

function SIPackers.FluidBoxConnection( positionOrList , connectionType , maxUndergroundDistance )
	local connection = { type = connectionType or SITypes.fluidBoxConnectionType.inAndOut , max_underground_distance = maxUndergroundDistance or 0 }
	if type( positionOrList[1] ) == "table" then connection.positions = positionOrList
	else connection.position = positionOrList end
	return connection
end

function SIPackers.FluidBoxConnections( positionList , connectionType , maxUndergroundDistance )
	local connections = {}
	for i , v in pairs( positionList ) do table.insert( connections , SIPackers.FluidBoxConnection( v , connectionType , maxUndergroundDistance ) ) end
	return connections
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
	local ingredient = { type = SITypes.item.item , name = function() return true , SIGen.autoFillType.item , name end }
	if count then ingredient.amount = count
	else ingredient.amount = 1 end
	return ingredient
end

function SIPackers.SingleFluidIngredient( name , count , minTemperature , maxTemperature )
	local ingredient = { type = SITypes.fluid , name = function() return true , SIGen.autoFillType.fluid , name end }
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

function SIPackers.IngredientsWithList( dataList )
	if not dataList then return nil end
	local ingredients = {}
	for i , v in pairs( dataList ) do
		if v[1] == "fluid" then table.insert( ingredients , SIPackers.SingleFluidIngredient( v[2] , v[3] , v[4] , v[5] ) )
		else table.insert( ingredients , SIPackers.SingleItemIngredient( v[1] , v[2] ) ) end
	end
	return ingredients
end

-- ------------------------------------------------------------------------------------------------
-- -------- 创建产物数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPackers.SingleItemProductsPack( name , countOrProbability , minCount , maxCount , catalystCount )
	return SIPackers.CreatePack{ SIPackers.SingleItemProduct( name , countOrProbability , minCount , maxCount , catalystCount ) }
end

function SIPackers.SingleItemProductPack( name , countOrProbability , minCount , maxCount , catalystCount )
	return SIPackers.CreatePack( SIPackers.SingleItemProduct( name , countOrProbability , minCount , maxCount , catalystCount ) )
end

function SIPackers.SingleFluidProductsPack( name , countOrProbability , minCount , maxCount , temperature , catalystCount )
	return SIPackers.CreatePack{ SIPackers.SingleFluidProduct( name , countOrProbability , minCount , maxCount , temperature , catalystCount ) }
end

function SIPackers.SingleFluidProductPack( name , countOrProbability , minCount , maxCount , temperature , catalystCount )
	return SIPackers.CreatePack( SIPackers.SingleFluidProduct( name , countOrProbability , minCount , maxCount , temperature , catalystCount ) )
end

function SIPackers.SingleItemProduct( name , countOrProbability , minCount , maxCount , catalystCount )
	local product = { type = SITypes.item.item , name = function() return true , SIGen.autoFillType.item , name end }
	if minCount and maxCount then
		product.probability = countOrProbability
		product.amount_min = minCount
		product.amount_max = maxCount
	else
		if countOrProbability then product.amount = countOrProbability
		else product.amount = SINumbers.defaultProductCount end
	end
	if catalystCount then product.catalyst_amount = catalystCount end
	return product
end

function SIPackers.SingleFluidProduct( name , countOrProbability , minCount , maxCount , temperature , catalystCount )
	local product = { type = SITypes.fluid , name = function() return true , SIGen.autoFillType.fluid , name end }
	if minCount and maxCount then
		product.probability = countOrProbability
		product.amount_min = minCount
		product.amount_max = maxCount
	else
		if countOrProbability then product.amount = countOrProbability
		else product.amount = SINumbers.defaultProductCount end
	end
	if temperature then product.temperature = temperature end
	if catalystCount then product.catalyst_amount = catalystCount end
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
	return productsData
end

function SIPackers.ProductsWithList( dataList , count )
	if not dataList then return nil end
	if not count then count = SINumbers.defaultProductCount end
	local products = {}
	for i , v in pairs( dataList ) do
		if v[1] == "item" then table.insert( products , SIPackers.SingleItemProduct( v[2] , v[3] or count , v[4] , v[5] , v[6] ) )
		elseif v[1] == "fluid" then table.insert( products , SIPackers.SingleFluidProduct( v[2] , v[3] or count , v[4] , v[5] , v[6] , v[7] ) )
		else table.insert( products , SIPackers.SingleItemProduct( v[1] , v[2] or count , v[3] , v[4] , v[5] ) ) end
	end
	return products
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
	local unitItem = { function() return true , SIGen.autoFillType.item , name end }
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
-- -------- 水面反射数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPackers.WaterReflectionPack( layer , rotate , orientationToVariation )
	return SIPackers.CreatePack( SIPackers.WaterReflection( layer , rotate , orientationToVariation ) )
end

function SIPackers.WaterReflection( layer , rotate , orientationToVariation )
	rotate = rotate or false
	orientationToVariation = orientationToVariation or false
	return
	{
		pictures = layer ,
		rotate = rotate ,
		orientation_to_variation = orientationToVariation
	}
end

-- ------------------------------------------------------------------------------------------------
-- -------- 创建开采数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPackers.MinablePack( resultOrList , time , count , fluid , fluidCount , miningParticle , miningTrigger )
	return SIPackers.CreatePack( SIPackers.Minable( resultOrList , time , count , fluid , fluidCount , miningParticle , miningTrigger ) )
end

function SIPackers.Minable( resultOrList , time , count , fluid , fluidCount , miningParticle , miningTrigger )
	local minable = {}
	if time then minable.mining_time = time
	else minable.mining_time = SINumbers.defaultMiningTime end
	if resultOrList then
		if type( resultOrList ) == "table" then minable.results = SIPackers.ProductsWithList( resultOrList , count )
		else minable.results = { SIPackers.SingleItemProduct( resultOrList , count or SINumbers.defaultProductCount ) } end
	end
	if fluid then
		minable.required_fluid = fluid
		minable.fluid_amount = fluidCount or SINumbers.defaultMinableFluidCount
	end
	if miningParticle then minable.mining_particle = miningParticle end
	if miningTrigger then minable.mining_trigger = miningTrigger end
	return minable
end

-- ------------------------------------------------------------------------------------------------
-- -------- 创建放置数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPackers.PlaceableBy( item , count )
	local placeableBy = { item = function() return true , SIGen.autoFillType.item , item end }
	if count then placeableBy.count = count
	else placeableBy.count = 1 end
	return placeableBy
end

-- ------------------------------------------------------------------------------------------------
-- -------- 创建掉落数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPackers.LootItemPack( item , probability , countMin , countMax )
	return SIPackers.CreatePack( SIPackers.LootItem( item , probability , countMin , countMax ) )
end

function SIPackers.LootItem( item , probability , countMin , countMax )
	local lootItem = { item = function() return true , SIGen.autoFillType.item , item end }
	if probability then lootItem.probability = probability end
	if countMin then lootItem.count_min = countMin end
	if countMax then lootItem.count_max = countMax end
	return lootItem
end

-- ------------------------------------------------------------------------------------------------
-- -------- 自动放置数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

--params
--{
--   name ,
--   order ,
--   seed1 , 默认 100
--   patch_set_name ,
--   autoplace_control_name ,
--   base_density ,
--   base_spots_per_km2 , 默认 2.5
--   minimum_richness , 默认 0
--   additional_richness , 默认 0
--   richness_post_multiplier , 默认 1
--   random_probability , 默认 1
--   random_spot_size_minimum , 默认 0.25
--   random_spot_size_maximum , 默认 2
--   regular_blob_amplitude_multiplier , 默认 1
--   starting_blob_amplitude_multiplier , 默认 1
--   regular_rq_factor_multiplier , 默认 1
--   starting_rq_factor_multiplier , 默认 1
--   has_starting_area_placement , 默认 nil , true=初生区域和外部都有 , false=初生区域没有但是外部有 , nil=任意地方都有
--   candidate_spot_count , 默认 21
--}
function SIPackers.Autoplace( params )
	return SIPackers.resourceAutoplace.resource_autoplace_settings( params )
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

function SIPackers.ResistanceWithDamageType( damageType , decrease , percent )
	return SIPackers.Resistance( damageType.name , decrease , percent )
end

function SIPackers.ResistancesWithDamageTypes( damageTypeList , decrease , percent )
	local resistances = {}
	for i , v in pairs( damageTypeList ) do table.insert( resistances , SIPackers.ResistanceWithDamageType( v , decrease , percent ) ) end
	return resistances
end

-- ------------------------------------------------------------------------------------------------
-- -------- 创建攻击数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPackers.Attack_EffectDamage( damageType , amount )
	return
	{
		type = "damage" ,
		damage = { type = damageType , amount = amount }
	}
end

-- ------------------------------------------------------------------------------------------------
-- -------- 创建模块形状 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIPackers.CreateEquipmentShape( type , width , height , points )
	local shape = {}
	if type then shape.type = type
	else shape.type = SITypes.equipmentShapeType.full end
	if width then shape.width = width
	else shape.width = 1 end
	if height then shape.height = height
	else shape.height = 1 end
	if points then shape.points = points end
	return shape
end

function SIPackers.CreateEquipmentShapeWithPoints( points )
	local shape =
	{
		type = SITypes.equipmentShapeType.manual ,
		points = points
	}
	local width = 0
	local height = 0
	for index , point in pairs( points ) do
		width = math.max( width , point[1] )
		height = math.max( height , point[2] )
	end
	shape.width = width + 1
	shape.height = height + 1
	return shape
end