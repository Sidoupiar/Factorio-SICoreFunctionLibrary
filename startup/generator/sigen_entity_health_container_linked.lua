local entity = SIGen.Container:Copy( "linked" )
entity:AddDefaultValue( "defaultType" , SITypes.entity.containerLinked )



function entity:SetImage( path )
	local width = self:GetWidth()
	local height = self:GetHeight()
	if not width or width <= 0 or not height or height <= 0 then return self end
	
	return self:SetParam( "icon" , path.."item/"..self:GetBaseName()..".png" )
	:SetParam( "picture" , SIPics.BaseAnimLayer( path.."entity/"..self:GetBaseName().."/"..self:GetBaseName() , width , height ).Get() )
end

function entity:SetSlotCount( inputSlotCount , outputSlotCount )
	return self:SetParam( "inventory_size" , inputSlotCount )
end

function entity:SetLogisticMode( logisticMode )
	return self:SetParam( "gui_mode" , logisticMode )
end



function entity:Init( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Init( currentEntity )
	currentEntity:SetStackSize( 100 )
	return self
end

return entity