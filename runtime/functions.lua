function CreateDamageType( list )
	local damage = {}
	for k , v in pairs( list ) do if k and v then table.insert( damage , k ) end end
	return damage
end