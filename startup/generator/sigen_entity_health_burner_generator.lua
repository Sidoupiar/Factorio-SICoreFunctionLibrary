local entity = SIGen.HealthEntity:Copy( "burner-generator" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.burnerGenerator )



function entity:DefaultFlags()
	return self:SetParam( "flags" , { SIFlags.entityFlags.placeablePlayer , SIFlags.entityFlags.playerCreation } )
end



function entity:SetEnergy( energyUsage , energySource )
	if energyUsage then self:SetParam( "max_power_output" , energyUsage ) end
	if energySource then self:SetParam( "energy_source" , energySource ) end
	return self
end



function entity:FillImage()
	local width = self:GetWidth()
	local height = self:GetHeight()
	if not width or width <= 0 or not height or height <= 0 then return self end
	
	local baseName = self:GetBaseName()
	local picturePath = self:GetPicturePath()
	local path = picturePath .. "entity/" .. baseName .. "/" .. baseName .. "-"
	
	local animation =
	{
		north = SIPics.OnAnimLayer( path.."north" , width , height ).Get() ,
		east = SIPics.OnAnimLayer( path.."east" , height , width ).Get() ,
		south = SIPics.OnAnimLayer( path.."south" , width , height ).Get() ,
		west = SIPics.OnAnimLayer( path.."west" , height , width ).Get()
	}
	return self:SetParam( "animation" , animation )
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetStackSize( 100 )
	return self
end

return entity