SI =
{
	Damage = {} ,
	Explosion = {} ,
	Equipment = {}
}



-- 统计伤害类型
function SI.Damage.CreateTypeList( list )
	local damage = {}
	for k , v in pairs( list ) do if k and v then table.insert( damage , k ) end end
	return damage
end



-- 给实体添加爆炸特效 , 并真的爆炸
function SI.Explosion.Destroy( entity , remnant )
	local surface = entity.surface
	if entity.health then
		surface.create_entity{ name = "medium-explosion" , position = entity.position }
		if remnant then
			if entity.prototype.corpses then
				for n , m in pairs( entity.prototype.corpses ) do
					surface.create_entity{ name = n , direction = entity.direction , position = entity.position }
				end
			else surface.create_entity{ name = "big-remnants" , direction = entity.direction , position = entity.position } end
		end
		entity.destroy{ raise_destroy = true }
	elseif entity.type == SITypes.entity.cliff then
		surface.create_entity{ name = "ground-explosion" , position = entity.position }
		if remnant then surface.create_entity{ name = "small-scorchmark" , position = entity.position } end
		entity.destroy{ do_cliff_correction = true , raise_destroy = true }
	elseif entity.type == SITypes.entity.resource then
		surface.create_entity{ name = "medium-explosion" , position = entity.position }
		if remnant then surface.create_entity{ name = "small-scorchmark" , position = entity.position } end
		entity.destroy{ raise_destroy = true }
	else entity.destroy{ raise_destroy = true } end
end



-- 获取模块信息
function SI.Equipment.FindByName( entity , name )
	if entity.grid then
		for index , equipment in pairs( entity.grid.equipment ) do
			if equipment.name == name then return equipment end
		end
	end
	return nil
end

function SI.Equipment.UseEnergy( equipment , energy )
	if equipment and equipment.valid then
		if equipment.energy >= energy then
			equipment.energy = equipment.energy - energy
			return true
		else return false end
	else return false end
end