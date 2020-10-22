local entity = SIGen.Item:Copy( "tool" )
entity:AddDefaultValue( "defaultType" , SITypes.item.tool )



function entity:SetHealth( health , descriptionKey , descriptionValue )
	return self:SetParam( "durability" , health )
	:SetParam( "durability_description_key" , descriptionKey )
	:SetParam( "durability_description_value" , descriptionValue )
end

return entity