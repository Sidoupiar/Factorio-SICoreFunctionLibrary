local entity = SIGen.Base:Copy( "subgroup" )
entity:AddDefaultValue( "defaultType" , SITypes.subgroup )



function entity:SetOrder( orderCode )
	return self:SetParam( "order" , "z-"..SIGen.Order( orderCode ) )
end

return entity