local entity = SIGen.HealthEntity:Copy( "burner-generator" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.burnerGenerator )



function entity:DefaultFlags()
	return self:SetParam( "flags" , { SIFlags.entityFlags.placeablePlayer , SIFlags.entityFlags.playerCreation } )
end



function entity:SetImage( path )
	local width = self:GetWidth()
	local height = self:GetHeight()
	if not width or width <= 0 or not height or height <= 0 then return self end
	
	local animation =
	{
		north = SIPics.BaseAnimLayer( path.."entity/"..self:GetBaseName().."/"..self:GetBaseName().."-north" , width , height ).Get() ,
		east = SIPics.BaseAnimLayer( path.."entity/"..self:GetBaseName().."/"..self:GetBaseName().."-east" , width , height ).Get() ,
		south = SIPics.BaseAnimLayer( path.."entity/"..self:GetBaseName().."/"..self:GetBaseName().."-south" , width , height ).Get() ,
		west = SIPics.BaseAnimLayer( path.."entity/"..self:GetBaseName().."/"..self:GetBaseName().."-west" , width , height ).Get() ,
	}
	return self:SetParam( "icon" , path.."item/"..self:GetBaseName()..".png" )
	:SetParam( "icon_size" , SINumbers.iconSize )
	:SetParam( "icon_mipmaps" , SINumbers.mipMaps )
	:SetParam( "animation" , animation )
end

function entity:SetEnergy( energyUsage , energySource )
	if energyUsage then self:SetParam( "max_power_output" , energyUsage ) end
	if energySource then self:SetParam( "energy_source" , energySource ) end
	return self
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetStackSize( 100 )
	return self
end

return entity