local entity = SIGen.HealthEntity:Copy( "roboport" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.roboport )



function entity:DefaultFlags()
	return self:SetParam( "flags" , { SIFlags.entityFlags.placeablePlayer , SIFlags.entityFlags.playerCreation } )
end



function entity:SetImage( path )
	local width = self:GetWidth()
	local height = self:GetHeight()
	if not width or width <= 0 or not height or height <= 0 then return self end
	
	local baseName = self:GetBaseName()
	local imagePath = path .. "entity/" .. baseName .. "/"
	local file = imagePath .. baseName
	local addenWidth = self:GetAddenWidth()
	local addenHeight = self:GetAddenHeight()
	local shadowWidth = self:GetShadowWidth()
	local shadowHeight = self:GetShadowHeight()
	local hasHr = self:GetHasHr()
	
	local waterLocation = self:GetWaterLocation()
	if waterLocation then self:SetParam( "water_reflection" , SIPics.WaterReflection( file , width , height , waterLocation ).Get() ) end
	
	local layers = {}
	table.insert( layers , SIPics.BaseAnimLayer( file , width , height , hasHr , addenWidth , addenHeight ).Get() )
	table.insert( layers , SIPics.BaseAnimLayer( file , width , height , hasHr , shadowWidth , shadowHeight ).Shadow().Get() )
	return self:SetParam( "icon" , path.."item/"..baseName..".png" )
	:SetParam( "icon_size" , SINumbers.iconSize )
	:SetParam( "icon_mipmaps" , SINumbers.mipMaps )
	:SetParam( "base" , { layers = layers } )
end



function entity:SetSlotCount( inputSlotCount , outputSlotCount )
	if inputSlotCount then self:SetParam( "robot_slots_count" , inputSlotCount ) end
	if outputSlotCount then self:SetParam( "material_slots_count" , outputSlotCount ) end
	return self
end

function entity:SetEffectRadius( effectRadius , linkRadius , connectRadius )
	if effectRadius then self:SetParam( "construction_radius" , effectRadius ) end
	if linkRadius then self:SetParam( "logistics_radius" , linkRadius ) end
	if connectRadius then self:SetParam( "logistics_connection_distance" , connectRadius ) end
	return self
end

function entity:SetEffectEnergy( effectEnergy , linkEnergy , connectEnergy )
	if effectEnergy then self:SetParam( "charging_energy" , effectEnergy ) end
	if linkEnergy then self:SetParam( "recharge_minimum" , linkEnergy ) end
	return self
end

function entity:SetLight( intensity , size , color )
	intensity = intensity or 0.4
	size = size or 5
	color = color or SIColors.baseColor.baseWhite
	return self:SetParam( "recharging_light" , SIPackers.Light( intensity , size , color ) )
end

function entity:SetSignalWire( distance , points , sprites , signals )
	if distance then self:SetParam( "circuit_wire_max_distance" , distance ) end
	if points then self:SetParam( "circuit_wire_connection_point" , points ) end
	if sprites then self:SetParam( "circuit_connector_sprites" , sprites ) end
	if signals then
		for k , v in pairs( signals ) do
			local signal = nil
			local dataType = type( v )
			if dataType == "string" then signal = SIPackers.Signal( v )
			else dataType == "table" then signal = v end
			if signal then self:SetParam( k , signal ) end
		end
	end
	return self
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetStackSize( 100 )
	return self
end

return entity