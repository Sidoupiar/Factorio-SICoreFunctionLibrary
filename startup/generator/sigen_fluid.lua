local entity = SIGen.Base:Copy( "fluid" )
entity:AddDefaultValue( "defaultType" , SITypes.fluid )



function entity:SetFuel( value , category , emissionsMult , accelerationMult , topSpeedMult , glowColor )
	if value then self:SetParam( "fuel_value" , value ) end
	if category then self:SetParam( "heat_capacity" , category ) end
	if emissionsMult then self:SetParam( "emissions_multiplier" , emissionsMult ) end
	return self
end

function entity:SetTemperature( defaultTemperature , maxTemperature , gasTemperature )
	if defaultTemperature then self:SetParam( "default_temperature" , defaultTemperature ) end
	if maxTemperature then self:SetParam( "max_temperature" , maxTemperature ) end
	if gasTemperature then self:SetParam( "gas_temperature" , gasTemperature ) end
	return self
end

function entity:SetMapColor( mapColor , friendlyMapColor , enemyMapColor )
	if mapColor then self:SetParam( "base_color" , mapColor ) end
	if friendlyMapColor then self:SetParam( "flow_color" , friendlyMapColor ) end
	return self
end



function entity:Fill( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Fill( currentEntity )
	
	currentEntity
	:Default( "icon_size" , SINumbers.iconSize )
	:Default( "icon_mipmaps" , SINumbers.mipMaps )
	return self
end

return entity