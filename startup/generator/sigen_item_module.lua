local entity = SIGen.Item:Copy( "module" )
entity:AddDefaultValue( "defaultType" , SITypes.item.module )



function entity:SetLevel( level , maxLevel )
	return self:SetParam( "tier" , level )
end

function entity:SetLimitation( limitation , message )
	return self:SetParam( "limitation" , limitation ):SetParam( "limitation_message_key" , message )
end

return entity