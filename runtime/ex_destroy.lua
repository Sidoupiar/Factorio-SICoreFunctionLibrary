function ExDestroy( entity , remnant )
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
	elseif entity.name == "cliff" then
		surface.create_entity{ name = "ground-explosion" , position = entity.position }
		if remnant then surface.create_entity{ name = "small-scorchmark" , position = entity.position } end
		entity.destroy{ do_cliff_correction = true , raise_destroy = true }
	else entity.destroy{ raise_destroy = true } end
end