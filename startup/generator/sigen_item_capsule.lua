local entity = SIGen.Item:Copy( "capsule" )
entity:AddDefaultValue( "defaultType" , SITypes.item.capsule )



function entity:SetAction( action , radiusColor )
	if action then self:SetParam( "capsule_action" , action ) end
	if radiusColor then self:SetParam( "radius_color" , radiusColor ) end
	return self
end

return entity