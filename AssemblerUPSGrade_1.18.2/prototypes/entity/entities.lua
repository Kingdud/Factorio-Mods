require("prototypes.constants")
require("prototypes.functions")

function computePowerDraw(count, power_draw)
	local total_beacon_pwr_drain = (count * math.ceil(beacon_count * .5) + beacon_count) * beacon_pwr_drain
	
	return power_draw * count + total_beacon_pwr_drain
end

function updateFluidBoxes(new_entity, assemblers, half_side_len)
	for i,res in pairs(new_entity.fluid_boxes)
	do
		if type(res) ~= type(table)
		then
			goto continue
		end
		
		--Ensure negative values get more negative and pos values get more pos
		--new_entity.fluid_boxes[i].secondary_draw_orders = nil
		if new_entity.fluid_boxes[i].pipe_connections[1].position[2] > 0
		then			
			new_entity.fluid_boxes[i].pipe_connections[1].position[2] = math.ceil(half_side_len)
		else
			new_entity.fluid_boxes[i].pipe_connections[1].position[2] = math.floor(-1*half_side_len)
		end
		
		for _,dir in pairs({"north", "east", "south", "west"})
		do
			-- for z,_ in pairs(new_entity.fluid_boxes[i].pipe_covers[dir].layers)
			-- do
				-- new_entity.fluid_boxes[i].pipe_covers[dir].layers[z].shift = {-.5,0}
				-- new_entity.fluid_boxes[i].pipe_covers[dir].layers[z].hr_version.shift = {-.5,0}
			-- end

			--new_entity.fluid_boxes[i].pipe_picture[dir].scale = assemblers / 1.725
			--new_entity.fluid_boxes[i].pipe_picture[dir].hr_version.scale = assemblers / 1.725
			-- new_entity.fluid_boxes[i].pipe_picture[dir].shift[1] = new_entity.fluid_boxes[i].pipe_picture[dir].shift[1] + .5
			-- new_entity.fluid_boxes[i].pipe_picture[dir].shift[2] = new_entity.fluid_boxes[i].pipe_picture[dir].shift[2] + .5
			-- new_entity.fluid_boxes[i].pipe_picture[dir].hr_version.shift[1] = new_entity.fluid_boxes[i].pipe_picture[dir].hr_version.shift[1] + .5
			-- new_entity.fluid_boxes[i].pipe_picture[dir].hr_version.shift[2] = new_entity.fluid_boxes[i].pipe_picture[dir].hr_version.shift[2] + .5
		end
		::continue::
	end
end

function createAssemblerEntity(name, compression_ratio, n_ass, e_ass)
		
	--Pollution
	--modify here if you wish to create separate entities for normal/expensive mode.
	local total_pollution_value = assembler_base_pollution * (assembler_per_unit_pwr_drain_penalty * (prod_mod_pollution_penalty * assembler_base_modules + 1)) * n_ass
	
	local new_entity = util.table.deepcopy(base_ass_entity)
	
	new_entity.fixed_recipe = name .. "-recipe"
	new_entity.name = name
	new_entity.crafting_speed = 1
	new_entity.crafting_categories = { name }
	new_entity.energy_source.emissions_per_minute = total_pollution_value
	--modify here if you wish to create separate entities for normal/expensive mode.
	new_entity.energy_usage = computePowerDraw(n_ass, assembler_total_pwr_draw) .. "kW"
	new_entity.allowed_effects = nil
	new_entity.module_specification.module_slots = 0
	--new_entity.base_productivity = .1*assembler_base_modules
	new_entity.fast_replaceable_group = name
	new_entity.minable.result = name
	
	local new_drawing_box_size = 0
	if (3 * n_ass) % 2 == 0
	then
		new_drawing_box_size = (3 * n_ass + 1) / 2
	else
		new_drawing_box_size = (3 * n_ass) / 2
	end
	local new_collison_size = new_drawing_box_size - 0.3
	local scale_factor = n_ass / 1.725
	
	local override_size = settings.startup["max-bld-size"].value
	if override_size ~= 0
	then
		new_drawing_box_size = override_size / 2
		new_collison_size = new_drawing_box_size - 0.3
		scale_factor = override_size / 3 / 1.725
	end
	
	new_entity.alert_icon_shift[1] = new_entity.alert_icon_shift[1] * n_ass
	new_entity.alert_icon_shift[2] = new_entity.alert_icon_shift[2] * n_ass
	new_entity.alert_icon_scale = scale_factor
	for i,_ in pairs(new_entity.animation.layers)
	do
		-- new_entity.animation.layers[i].shift[1] = new_entity.animation.layers[i].shift[1] * n_ass
		-- new_entity.animation.layers[i].shift[2] = new_entity.animation.layers[i].shift[2] * n_ass
		-- new_entity.animation.layers[i].hr_version.shift[1] = new_entity.animation.layers[i].hr_version.shift[1] * n_ass
		-- new_entity.animation.layers[i].hr_version.shift[2] = new_entity.animation.layers[i].hr_version.shift[2] * n_ass
		new_entity.animation.layers[i].scale = scale_factor
		new_entity.animation.layers[i].hr_version.scale = scale_factor
		if new_entity.animation.layers[i].hr_version.filename == "__base__/graphics/entity/assembling-machine-3/hr-assembling-machine-3.png"
		then
			new_entity.animation.layers[i].hr_version.filename = "__AssemblerUPSGrade__/graphics/entity/" .. GRAPHICS_MAP[name].icon
			new_entity.animation.layers[i].hr_version.height = 214
		end
		new_entity.animation.layers[i].tint = GRAPHICS_MAP[name].tint
		--new_entity.animation.layers[i].hr_version.tint = GRAPHICS_MAP[name].tint
	end
	
	new_entity.collision_box = { {-1*new_collison_size, -1*new_collison_size}, {new_collison_size,new_collison_size} }
	new_entity.drawing_box = { {-1*new_drawing_box_size, -1*(new_drawing_box_size+.2)}, {new_drawing_box_size,new_drawing_box_size} }
	new_entity.selection_box = { {-1*new_drawing_box_size, -1*new_drawing_box_size}, {new_drawing_box_size,new_drawing_box_size} }
	
	new_entity.icon = "__AssemblerUPSGrade__/graphics/" .. GRAPHICS_MAP[name].icon
	-- new_entity.icons = {
		-- {
			-- icon = "__AssemblerUPSGrade__/graphics/" .. GRAPHICS_MAP[name].icon,
			-- icon_size = 64,
			-- tint = GRAPHICS_MAP[name].tint
		-- }
	-- }
	new_entity.icon_size = 64
	
	if has_value(NEED_FLUID_RECIPES, name)
	then
		updateFluidBoxes(new_entity, n_ass, new_drawing_box_size)
	else
		new_entity.fluid_boxes = nil
	end
	
	data:extend({new_entity})
end

function createChemPlantEntity(name, compression_ratio, n_chem, e_chem)
	local new_entity = util.table.deepcopy(base_chem_entity)
	
	new_entity.fixed_recipe = name .. "-recipe"
	new_entity.name = name
	new_entity.crafting_speed = 1
	new_entity.crafting_categories = { name }
	new_entity.energy_source.emissions_per_minute = total_pollution_value
	new_entity.energy_usage = computePowerDraw(n_chem, chem_total_pwr_draw) .. "kW"
	new_entity.allowed_effects = nil
	new_entity.module_specification.module_slots = 0
	new_entity.base_productivity = .1*chem_base_modules
	
	--todo: graphics, tint
	
	data:extend({new_entity})
end