local entity = SIGen.Entity:Copy( "health" )



function entity:GetHealth()
	return self:GetParam( "max_health" )
end



function entity:DefaultFlags()
	return self:SetParam( "flags" , {} )
end



function entity:SetHealth( health , descriptionKey , descriptionValue )
	return self:SetParam( "max_health" , health )
end

function entity:SetEnergy( energyUsage , energySource )
	if energyUsage then self:SetParam( "energy_usage" , energyUsage ) end
	if energySource then
		local dataType = type( energySource )
		if dataType == "string" then
			self:SetParam( "energy_source" , SIPackers.EnergySource( energySource ) )
		elseif dataType == "table" then
			if energySource.isPack then
				self:SetParam( "energy_source" , energySource.data )
			else
				self:SetParam( "energy_source" , energySource )
			end
		else
			e( "模块构建 : SetEnergy 方法的 energySource 参数必须使用字符串/字典格式" )
			return self
		end
	end
	return self
end

function entity:SetPluginData( slotCount , iconShift )
	return self:SetParam( "module_specification" , { module_slots = slotCount , module_info_icon_shift = iconShift } )
end

function entity:SetCorpse( corpse , explosion , triggerEffect )
	if corpse then self:SetParam( "corpse" , corpse ) end
	if explosion then self:SetParam( "dying_explosion" , explosion ) end
	if triggerEffect then self:SetParam( "dying_trigger_effect" , triggerEffect ) end
	return self
end

function entity:SetLevel( level , maxLevel )
	if level then self:SetParam( "fast_replaceable_group" , level ) end
	if maxLevel then
		local name = self:GetName()
		if name:Level() < maxLevel then self:SetParam( "next_upgrade" , name:NextLevel() ) end
	end
	return self
end



function entity:SetResidences( residenceOrResidencesOrPack )
	if not self:CheckData( residenceOrResidencesOrPack ) then return self end
	local dataType = type( residenceOrResidencesOrPack )
	if dataType == "string" then
		return self:SetParam( "resistances" , SIPackers.ResistancesPack( residenceOrResidencesOrPack ) )
	elseif dataType == "table" then
		if residenceOrResidencesOrPack.isPack then
			return self:SetParam( "resistances" , residenceOrResidencesOrPack.data )
		else
			return self:SetParam( "resistances" , residenceOrResidencesOrPack )
		end
	else
		e( "模块构建 : SetResidences 方法参数必须使用字符串/数组格式" )
		return self
	end
end

function entity:AddResidences( residenceOrResidencesOrPack )
	if not self:CheckData( residenceOrResidencesOrPack ) then return self end
	local dataType = type( residenceOrResidencesOrPack )
	if dataType == "string" then
		return self:AddParamItem( "resistances" , SIPackers.Resistance( residenceOrResidencesOrPack ) )
	elseif dataType == "table" then
		if residenceOrResidencesOrPack.isPack then
			return self:AddParamItem( "resistances" , residenceOrResidencesOrPack.data )
		else
			return self:AddParamItem( "resistances" , residenceOrResidencesOrPack )
		end
	else
		e( "模块构建 : AddResidences 方法参数必须使用字符串/数组格式" )
		return self
	end
end

function entity:ClearResidences()
	return self:DeleteParam( "resistances" )
end

function entity:SetPluginTypes( typeOrTypesOrPack )
	if not self:CheckData( typeOrTypesOrPack ) then return self end
	local dataType = type( typeOrTypesOrPack )
	if dataType == "string" then
		return self:SetParam( "allowed_effects" , { typeOrTypesOrPack } )
	elseif dataType == "table" then
		if typeOrTypesOrPack.isPack then
			return self:SetParam( "allowed_effects" , typeOrTypesOrPack.data )
		else
			return self:SetParam( "allowed_effects" , typeOrTypesOrPack )
		end
	else
		e( "模块构建 : SetPluginTypes 方法参数必须使用字符串/数组格式" )
		return self
	end
end

function entity:AddPluginTypes( typeOrTypesOrPack )
	if not self:CheckData( typeOrTypesOrPack ) then return self end
	local dataType = type( typeOrTypesOrPack )
	if dataType == "string" then
		if not table.Has( self:GetParam( "allowed_effects" ) , typeOrTypesOrPack ) then
			return self:AddParamItem( "allowed_effects" , typeOrTypesOrPack )
		end
	elseif dataType == "table" then
		for i , effect in pairs( typeOrTypesOrPack.isPack and typeOrTypesOrPack.data or typeOrTypesOrPack ) do
			if not table.Has( self:GetParam( "allowed_effects" ) , effect ) then self:AddParamItem( "allowed_effects" , effect ) end
		end
		return self
	else
		e( "模块构建 : AddPluginTypes 方法参数必须使用字符串/数组格式" )
		return self
	end
end

function entity:ClearPluginTypes()
	return self:DeleteParam( "allowed_effects" )
end

function entity:SetFluidBoxes( areaOrBoxOrListOrPack , connections , baseLevel , productionType , levelHeight , filter , minTemperature , maxTemperature )
	if not self:CheckData( areaOrBoxOrListOrPack ) then return self end
	if type( areaOrBoxOrListOrPack ) ~= "table" then areaOrBoxOrListOrPack = { SIPackers.FluidBox( areaOrBoxOrListOrPack , connections , baseLevel , productionType , levelHeight , filter , minTemperature , maxTemperature ) } end
	if areaOrBoxOrListOrPack.isPack then areaOrBoxOrListOrPack = areaOrBoxOrListOrPack.data end
	if areaOrBoxOrListOrPack.base_area then areaOrBoxOrListOrPack = { areaOrBoxOrListOrPack } end
	return self:SetParam( "fluid_boxes" , areaOrBoxOrListOrPack )
end

function entity:AddFluidBoxes( areaOrBoxOrListOrPack , connections , baseLevel , productionType , levelHeight , filter , minTemperature , maxTemperature )
	if not self:CheckData( areaOrBoxOrListOrPack ) then return self end
	if type( areaOrBoxOrListOrPack ) ~= "table" then areaOrBoxOrListOrPack = { SIPackers.FluidBox( areaOrBoxOrListOrPack , connections , baseLevel , productionType , levelHeight , filter , minTemperature , maxTemperature ) } end
	if areaOrBoxOrListOrPack.isPack then areaOrBoxOrListOrPack = areaOrBoxOrListOrPack.data end
	if areaOrBoxOrListOrPack.base_area then areaOrBoxOrListOrPack = { areaOrBoxOrListOrPack } end
	for i , box in pairs( areaOrBoxOrListOrPack ) do self:AddParamItem( "fluid_boxes" , box ) end
	return self
end

function entity:ClearFluidBoxes()
	return self:DeleteParam( "fluid_boxes" )
end



function entity:Fill( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Fill( currentEntity )
	
	local item = currentEntity:GetItem()
	if item then currentEntity:Default( "minable" , { mining_time = currentEntity:GetHealth()/SINumbers.healthToMiningTime , result = item:GetName() } ) end
	
	currentEntity
	:Default( "alert_when_damaged" , true )
	:Default( "hide_resistances" , false )
	:Default( "vehicle_impact_sound" , SISounds.sounds.vehicleImpact )
	:Default( "open_sound" , SISounds.sounds.machineOpen )
	:Default( "close_sound" , SISounds.sounds.machineClose )
	return self
end

return entity