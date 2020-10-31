-- 统计伤害类型
function CreateDamageType( list )
	local damage = {}
	for k , v in pairs( list ) do if k and v then table.insert( damage , k ) end end
	return damage
end

-- 给实体添加爆炸特效 , 并真的爆炸
function ExDestroy( entity , remnant )
	local surface = entity.surface
	if entity.health then
		if entity.prototype.dying_explosion then surface.create_entity{ name = entity.prototype.dying_explosion , position = entity.position }
		else surface.create_entity{ name = "medium-explosion" , position = entity.position } end
		if remnant then
			if entity.prototype.corpses then
				for n , m in pairs( entity.prototype.corpses ) do
					surface.create_entity{ name = n , direction = entity.direction , position = entity.position }
				end
			else surface.create_entity{ name = "big-remnants" , direction = entity.direction , position = entity.position } end
		end
		entity.destroy{ raise_destroy = true }
	elseif entity.name == "cliff" then
		surface.create_entity{ name = "ground-explosion" , position = entity.position }
		if remnant then surface.create_entity{ name = "small-scorchmark" , position = entity.position } end
		entity.destroy{ do_cliff_correction = true , raise_destroy = true }
	else entity.destroy{ raise_destroy = true } end
end