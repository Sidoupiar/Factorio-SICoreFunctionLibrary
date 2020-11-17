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

function entity:SetModuleData( slotCount , iconShift )
	return self:SetParam( "module_specification" , { module_slots = slotCount , module_info_icon_shift = iconShift } )
end

function entity:SetCorpse( corpse , explosion , triggerEffect )
	if corpse then self:SetParam( "corpse" , corpse ) end
	if explosion then self:SetParam( "dying_explosion" , explosion ) end
	if triggerEffect then self:SetParam( "dying_trigger_effect" , triggerEffect ) end
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