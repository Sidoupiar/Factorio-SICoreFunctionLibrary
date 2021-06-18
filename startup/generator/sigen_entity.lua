local entity = SIGen.Base:Copy( "entity" )
entity:AddDefaultValue( "width" , -1 )
:AddDefaultValue( "height" , -1 )
:AddDefaultValue( "addenWidth" , 0 )
:AddDefaultValue( "addenHeight" , 0 )
:AddDefaultValue( "shadowWidth" , 0 )
:AddDefaultValue( "shadowHeight" , 0 )
:AddDefaultValue( "addenShiftX" , 0 )
:AddDefaultValue( "addenShiftY" , 0 )
:AddDefaultValue( "shadowShiftX" , 0 )
:AddDefaultValue( "shadowShiftY" , 0 )
:AddDefaultValue( "scale" , 1 )
:AddDefaultValue( "hasHr" , false )
:AddDefaultValue( "animShadow" , false )
:AddDefaultValue( "patchLocation" , nil )
:AddDefaultValue( "waterLocation" , nil )
:AddDefaultValue( "canGlow" , false )
:AddDefaultValue( "itemStackSize" , 0 )
:AddDefaultValue( "itemFlags" , {} )
:AddDefaultValue( "itemName" , nil )
:AddDefaultValue( "item" , nil )
:AddDefaultValue( "autoPlaceSettings" , nil )



function entity:SetAddenSize( addenWidth , addenHeight )
	self.addenWidth = addenWidth or 0
	self.addenHeight = addenHeight or 0
	return self
end

function entity:SetAddenWidth( addenWidth )
	self.addenWidth = addenWidth or 0
	return self
end

function entity:SetAddenHeight( addenHeight )
	self.addenHeight = addenHeight or 0
	return self
end

function entity:SetShadowSize( shadowWidth , shadowHeight )
	self.shadowWidth = shadowWidth or 0
	self.shadowHeight = shadowHeight or 0
	return self
end

function entity:SetShadowWidth( shadowWidth )
	self.shadowWidth = shadowWidth or 0
	return self
end

function entity:SetShadowHeight( shadowHeight )
	self.shadowHeight = shadowHeight or 0
	return self
end

function entity:SetAddenShift( x , y )
	self.addenShiftX = x or 0
	self.addenShiftY = y or 0
	return self
end

function entity:SetAddenShiftX( x )
	self.addenShiftX = x or 0
	return self
end

function entity:SetAddenShiftY( y )
	self.addenShiftY = y or 0
	return self
end

function entity:SetShadowShift( x , y )
	self.shadowShiftX = x or 0
	self.shadowShiftY = y or 0
	return self
end

function entity:SetShadowShiftX( x )
	self.shadowShiftX = x or 0
	return self
end

function entity:SetShadowShiftY( y )
	self.shadowShiftY = y or 0
	return self
end

function entity:SetScale( scale )
	self.scale = scale or 1
	return self
end

function entity:SetHasHr( hasHr )
	self.hasHr = hasHr
	return self
end

function entity:SetAnimShadow( animShadow )
	self.animShadow = animShadow
	return self
end

function entity:SetPatchLocation( x , y )
	self.patchLocation = { x , y }
	return self
end

function entity:SetWaterLocation( x , y )
	self.waterLocation = { x , y }
	return self
end

function entity:SetCanGlow( canGlow )
	self.canGlow = canGlow
	return self
end

function entity:SetItemFlags( flagOrFlagsOrPack )
	if not flagOrFlagsOrPack then return self end
	local dataType = type( flagOrFlagsOrPack )
	if dataType == "string" then self.itemFlags = { flagOrFlagsOrPack }
	elseif dataType == "table" then
		if flagOrFlagsOrPack.isPack then self.itemFlags = flagOrFlagsOrPack.data
		else self.itemFlags = flagOrFlagsOrPack end
	else e( "模块构建 : SetItemFlags 方法参数必须使用字符串/数组格式" ) end
	return self
end

function entity:AddItemFlags( flagOrFlagsOrPack )
	if not flagOrFlagsOrPack then return self end
	local dataType = type( flagOrFlagsOrPack )
	if dataType == "string" then table.insert( self.itemFlags , flagOrFlagsOrPack )
	elseif dataType == "table" then
		if flagOrFlagsOrPack.isPack then flagOrFlagsOrPack = flagOrFlagsOrPack.data end
		for i , v in pairs( flagOrFlagsOrPack ) do table.insert( self.itemFlags , v ) end
	else e( "模块构建 : AddItemFlags 方法参数必须使用字符串/数组格式" ) end
	return self
end

function entity:ClearItemFlags()
	self.itemFlags = {}
	return self
end

function entity:SetItemName( itemName )
	self.itemName = itemName
	return self
end

function entity:SetItem( item )
	self.item = item
	return self
end

function entity:GetWidth()
	return self.width
end

function entity:GetHeight()
	return self.height
end

function entity:GetAddenWidth()
	return self.addenWidth
end

function entity:GetAddenHeight()
	return self.addenHeight
end

function entity:GetShadowWidth()
	return self.shadowWidth
end

function entity:GetShadowHeight()
	return self.shadowHeight
end

function entity:GetAddenShiftX()
	return self.addenShiftX
end

function entity:GetAddenShiftY()
	return self.addenShiftY
end

function entity:GetShadowShiftX()
	return self.shadowShiftX
end

function entity:GetShadowShiftY()
	return self.shadowShiftY
end

function entity:GetScale()
	return self.scale
end

function entity:GetHasHr()
	return self.hasHr
end

function entity:GetAnimShadow()
	return self.animShadow
end

function entity:GetPatchLocation()
	return self.patchLocation
end

function entity:GetWaterLocation()
	return self.waterLocation
end

function entity:GetCanGlow()
	return self.canGlow
end

function entity:GetItemStackSize()
	return self.itemStackSize
end

function entity:GetItemFlags()
	return self.itemFlags
end

function entity:GetItemName()
	return self.itemName
end

function entity:GetItem()
	return self.item
end



function entity:DefaultFlags()
	return self:SetParam( "flags" , {} )
end



function entity:SetStackSize( stackSize )
	if type( stackSize ) == "number" then self.itemStackSize = stackSize end
	return self
end

function entity:SetSize( width , height )
	if not height then height = width end
	local currentWidth = self.width
	local currentHeight = self.height
	if currentWidth ~= width or currentHeight ~= height then
		self.width = width
		self.height = height
		return self:SetParam( "selection_box" , SIPackers.BoundBox( self.width , self.height ) )
		:SetParam( "collision_box" , SIPackers.CollisionBoundBox( self.width , self.height ) )
	else return self end
end

function entity:SetMinable( minable , placeableBy , miningVisualisationTint )
	if minable then self:SetParam( "minable" , minable ) end
	if placeableBy then self:SetParam( "placeable_by" , placeableBy ) end
	if miningVisualisationTint then self:SetParam( "mining_visualisation_tint" , miningVisualisationTint ) end
	return self
end

function entity:SetLight( intensity , size , color )
	intensity = intensity or 0.75
	size = size or ( math.max( self:GetWidth() , self:GetHeight() ) * SINumbers.lightSizeMult )
	color = color or SIColors.baseColor.baseWhite
	return self:SetParam( "light" , SIPackers.Light( intensity , size , color ) )
end

function entity:SetSmoke( smoke )
	return self:SetParam( "smoke" , smoke )
end

function entity:SetMapColor( mapColor , friendlyMapColor , enemyMapColor )
	self:SetParam( "map_color" , mapColor )
	if friendlyMapColor then self:SetParam( "friendly_map_color" , friendlyMapColor )
	else self:SetParam( "friendly_map_color" , mapColor ) end
	if enemyMapColor then self:SetParam( "enemy_map_color" , enemyMapColor )
	else self:SetParam( "enemy_map_color" , mapColor ) end
	return self
end

function entity:SetAutoPlace( autoPlaceSettings , stageCounts )
	if autoPlaceSettings then self.autoPlaceSettings = autoPlaceSettings end
	if stageCounts then self:SetParam( "stage_counts" , stageCounts ) end
	return self
end

function entity:SetStagesEffectsSettings( effectAnimationPeriod , effectAnimationPeriodDeviation , effectDarknessMultiplier , minEffectAlpha , maxEffectAlpha )
	if effectAnimationPeriod then self:SetParam( "effect_animation_period" , effectAnimationPeriod ) end
	if effectAnimationPeriodDeviation then self:SetParam( "effect_animation_period_deviation" , effectAnimationPeriodDeviation ) end
	if effectDarknessMultiplier then self:SetParam( "effect_darkness_multiplier" , effectDarknessMultiplier ) end
	if minEffectAlpha then self:SetParam( "min_effect_alpha" , minEffectAlpha ) end
	if maxEffectAlpha then self:SetParam( "max_effect_alpha" , maxEffectAlpha ) end
	return self
end



function entity:Fill( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Fill( currentEntity )
	
	currentEntity
	:Default( "icon_size" , SINumbers.iconSize )
	:Default( "icon_mipmaps" , SINumbers.mipMaps )
	
	local stackSize = currentEntity:GetItemStackSize()
	if stackSize and stackSize > 0 then
		local item = currentEntity:GetItem()
		if not item then
			local item = SIGen.Item:New( currentEntity:GetItemName() or currentEntity:GetBaseName() )
			:Init()
			:DefaultFlags()
			:SetGroup( SIGen.GetCurrentSubGroupEntity() )
			:SetOrder( SIGen.GetCurrentEntityOrder() )
			:AddFlags( currentEntity:GetItemFlags() )
			:SetStackSize( stackSize )
			:SetResults( currentEntity:GetName() , SIGen.resultType.entity )
			
			local localizedNames = currentEntity:GetParam( "localised_name" )
			if localizedNames then item:SetLocalisedNames( localizedNames ) end
			local localisedDescriptions = currentEntity:GetParam( "localised_description" )
			if localisedDescriptions then item:SetLocalisedDescriptions( localisedDescriptions ) end
			local flags = currentEntity:GetParam( "flags" )
			if table.Has( flags , SIFlags.entityFlags.hidden ) then item:AddFlags{ SIFlags.itemFlags.hidden } end
			
			currentEntity:SetItem( item:Fill() )
		end
	end
	return self
end

function entity:Auto( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Auto( currentEntity )
	
	local item = currentEntity:GetItem()
	if item then
		if not item:HasExtend() then item:Extend():Finish() end
		currentEntity:Default( "minable" , SIPackers.Minable( item:GetName() ) )
	end
	if currentEntity.autoPlaceSettings then
		local autoplace = currentEntity.autoPlaceSettings
		if not autoplace.name then
			local localizedNames = currentEntity:GetParam( "localised_name" )
			autoplace.name = SIGen.ControlAutoplace:New( currentEntity:GetBaseName() )
			:Init()
			:DefaultFlags()
			:SetOrder( SIGen.GetCurrentEntityOrder() )
			:SetLocalisedNames{ "" , "[entity="..currentEntity:GetName().."]" , localizedNames or { "entity-name."..currentEntity:GetName() } }
			:SetRecipeTypes( SITypes.controlAutoplaceCategory.resource )
			:SetRichness( true )
			:Fill()
			:Extend()
			:Finish()
			:GetName()
		end
		currentEntity:SetParam( "autoplace" , SIPackers.Autoplace( autoplace ) )
	end
	return self
end

return entity