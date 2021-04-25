local entity = SIGen.HealthEntity:Copy( "lab" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.lab )



function entity:DefaultFlags()
	return self:SetParam( "flags" , { SIFlags.entityFlags.placeablePlayer , SIFlags.entityFlags.playerCreation } )
end



function entity:SetSpeed( speed )
	return self:SetParam( "researching_speed" , speed )
end



function entity:FillImage()
	local width = self:GetWidth()
	local height = self:GetHeight()
	if not width or width <= 0 or not height or height <= 0 then return self end
	
	local baseName = self:GetBaseName()
	local picturePath = self:GetPicturePath()
	local path = picturePath .. "entity/" .. baseName .. "/" .. baseName
	local addenWidth = self:GetAddenWidth()
	local addenHeight = self:GetAddenHeight()
	local shadowWidth = self:GetShadowWidth()
	local shadowHeight = self:GetShadowHeight()
	local hasHr = self:GetHasHr()
	local animShadow = self:GetAnimShadow()
	
	local onLayers = {}
	local offLayers = {}
	table.insert( onLayers , SIPics.OnAnimLayer( path , width , height , hasHr , addenWidth , addenHeight ).Get() )
	if animShadow then table.insert( onLayers , SIPics.OnAnimLayerShadow( path , width , height , hasHr , shadowWidth , shadowHeight ).Get() )
	else table.insert( onLayers , SIPics.OnAnimLayerShadowSingle( path , width , height , hasHr , shadowWidth , shadowHeight ).Get() ) end
	table.insert( offLayers , SIPics.OffAnimLayer( path , width , height , hasHr , addenWidth , addenHeight ).Get() )
	table.insert( offLayers , SIPics.OffAnimLayerShadow( path , width , height , hasHr , shadowWidth , shadowHeight ).Get() )
	return self:SetParam( "on_animation" , { layers = onLayers } )
	:SetParam( "off_animation" , { layers = offLayers } )
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetStackSize( 100 )
	return self
end

function entity:Fill( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Fill( currentEntity )
	
	if not currentEntity:GetParam( "light" ) then currentEntity:SetLight() end
	return self
end

return entity