require("prototypes.constants")
require("prototypes.functions")

function ComputePowerDrainAndDraw(count, bld_power)
	local num_beacons = count * math.ceil(beacon_count * 0.5) + beacon_count
	local draw = bld_power * count
	
	--Draw/30 is the standard drain for an entity with power where drain is not specified, per Factorio Wiki.
	local drain = num_beacons * beacon_pwr_drain + draw / 30
	
	return draw, drain
end

function updateAssFluidBoxes(new_entity, assemblers, half_side_len)
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
	if DEBUG then
		log("Debug: createAssemblerEntity " .. name)
	end
	
	--modify here if you wish to create separate entities for normal/expensive mode.
	local draw, drain = ComputePowerDrainAndDraw(n_ass, assembler_total_pwr_draw)
		
	--Pollution
	--modify here if you wish to create separate entities for normal/expensive mode.
	local total_pollution_value = assembler_base_pollution * (assembler_per_unit_pwr_drain_penalty * (prod_mod_pollution_penalty * assembler_base_modules + 1)) * n_ass
	
	local new_entity = util.table.deepcopy(base_ass_entity)
	
	new_entity.fixed_recipe = name .. "-recipe"
	new_entity.name = name
	new_entity.crafting_speed = 1
	new_entity.crafting_categories = { name }
	new_entity.energy_source.emissions_per_minute = total_pollution_value
	new_entity.energy_source.drain = drain .. "kW"
	new_entity.energy_usage = draw .. "kW"
	new_entity.allowed_effects = nil
	new_entity.module_specification.module_slots = 0
	new_entity.scale_entity_info_icon = true
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
	
	new_entity.alert_icon_shift[1] = new_entity.alert_icon_shift[1] * scale_factor
	new_entity.alert_icon_shift[2] = new_entity.alert_icon_shift[2] * scale_factor
	new_entity.alert_icon_scale = scale_factor
	for i,_ in pairs(new_entity.animation.layers)
	do
		new_entity.animation.layers[i].scale = scale_factor
		new_entity.animation.layers[i].hr_version.scale = scale_factor
		if new_entity.animation.layers[i].hr_version.filename == "__base__/graphics/entity/assembling-machine-3/hr-assembling-machine-3.png"
		then
			new_entity.animation.layers[i].hr_version.filename = "__AssemblerUPSGrade__/graphics/entity/" .. GRAPHICS_MAP[name].icon
			new_entity.animation.layers[i].hr_version.height = 214
		end
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
		updateAssFluidBoxes(new_entity, n_ass, new_drawing_box_size)
	else
		new_entity.fluid_boxes = nil
	end
	
	--We want this before the scale factor gets reduced below.
	local edge_art = {
		filename = "__AssemblerUPSGrade__/graphics/entity/assembler-border.png",
		frame_count = new_entity.animation.layers[1].frame_count,
		line_length = new_entity.animation.layers[1].line_length,
		height = 256,
		priority = "high",
		scale = scale_factor * .5,
		width = 256,
	}
	table.insert(new_entity.animation.layers, edge_art)
	
	if DEBUG then
		log("Debug createAssemblerEntity : " .. do_dump(new_entity))
	end
	
	data:extend({new_entity})
end

function createChemPlantEntity(name, compression_ratio, n_chem, e_chem)
	--Pollution
	--modify here if you wish to create separate entities for normal/expensive mode.
	local total_pollution_value = chem_base_pollution * (chem_per_unit_pwr_drain_penalty * (prod_mod_pollution_penalty * chem_base_modules + 1)) * n_chem

	local new_entity = util.table.deepcopy(base_chem_entity)
	local draw, drain = ComputePowerDrainAndDraw(n_chem, chem_total_pwr_draw)
	
	new_entity.fixed_recipe = name .. "-recipe"
	new_entity.name = name
	new_entity.crafting_speed = 1
	new_entity.crafting_categories = { name }
	new_entity.energy_source.emissions_per_minute = total_pollution_value
	new_entity.energy_source.drain = drain .. "kW"
	new_entity.energy_usage = draw .. "kW"
	new_entity.allowed_effects = nil
	new_entity.module_specification.module_slots = 0
	new_entity.scale_entity_info_icon = true
	--new_entity.base_productivity = .1*chem_base_modules
	new_entity.fast_replaceable_group = name
	new_entity.minable.result = name
	
	local new_drawing_box_size = 0
	if (3 * n_chem) % 2 == 0
	then
		new_drawing_box_size = (3 * n_chem + 1) / 2
	else
		new_drawing_box_size = (3 * n_chem) / 2
	end
	local new_collison_size = new_drawing_box_size - 0.3
	local scale_factor = n_chem / 2
	
	local override_size = settings.startup["max-bld-size"].value
	if override_size ~= 0
	then
		new_drawing_box_size = override_size / 2
		new_collison_size = new_drawing_box_size - 0.3
		scale_factor = override_size / 3 / 2
	end
	
	--We want this before the scale factor gets reduced below.
	local edge_art = {
		filename = "__AssemblerUPSGrade__/graphics/entity/chem-border.png",
		frame_count = new_entity.animation["north"].layers[1].frame_count,
		line_length = 6,
		height = 256,
		priority = "high",
		scale = scale_factor * .75,
		width = 256,
	}
	
	--This is the smokestack color and the window color bit being scaled to the correct size.
	for i,_ in pairs(new_entity.working_visualisations) do
		--smokestack
		if new_entity.working_visualisations[i].animation then
			new_entity.working_visualisations[i].animation.scale = scale_factor
			new_entity.working_visualisations[i].animation.hr_version.scale = scale_factor
			new_entity.working_visualisations[i].animation.shift[1] = new_entity.working_visualisations[i].animation.shift[1] * scale_factor
			new_entity.working_visualisations[i].animation.shift[2] = new_entity.working_visualisations[i].animation.shift[2] * scale_factor
			new_entity.working_visualisations[i].animation.hr_version.shift[1] = new_entity.working_visualisations[i].animation.hr_version.shift[1] * scale_factor
			new_entity.working_visualisations[i].animation.hr_version.shift[2] = new_entity.working_visualisations[i].animation.hr_version.shift[2] * scale_factor
			
			for _, dir in pairs({"north_position","east_position","west_position","south_position"}) do
				new_entity.working_visualisations[i][dir][1] = new_entity.working_visualisations[i][dir][1] * scale_factor * 2
				--For reasons that are unclear to me, the outside smoke animation needs a little extra bump north for some reason.
				if i == 3 then
					new_entity.working_visualisations[i][dir][2] = new_entity.working_visualisations[i][dir][2] * scale_factor * 2.25
				else
					new_entity.working_visualisations[i][dir][2] = new_entity.working_visualisations[i][dir][2] * scale_factor * 2
				end
			end
		else
			for _, dir in pairs({"north_animation","east_animation","west_animation","south_animation"}) do
				new_entity.working_visualisations[i][dir].scale = scale_factor
				new_entity.working_visualisations[i][dir].hr_version.scale = scale_factor
				new_entity.working_visualisations[i][dir].shift[1] = new_entity.working_visualisations[i][dir].shift[1] * scale_factor * 2
				new_entity.working_visualisations[i][dir].shift[2] = new_entity.working_visualisations[i][dir].shift[2] * scale_factor * 2
				new_entity.working_visualisations[i][dir].hr_version.shift[1] = new_entity.working_visualisations[i][dir].hr_version.shift[1] * scale_factor * 2
				new_entity.working_visualisations[i][dir].hr_version.shift[2] = new_entity.working_visualisations[i][dir].hr_version.shift[2] * scale_factor * 2
			end
		end
	end
	
	--Reduce scale factor since the original art is actually too large for the entity box.
	scale_factor = scale_factor - 1.5

	new_entity.alert_icon_scale = scale_factor
	
	for _,dir in pairs({"north","east","south","west"})
	do
		for i,_ in pairs(new_entity.animation[dir].layers)
		do
			-- new_entity.animation[dir].layers[i].shift[1] = new_entity.animation[dir].layers[i].shift[1] * scale_factor
			new_entity.animation[dir].layers[i].shift[2] = new_entity.animation[dir].layers[i].shift[2] - 2
			-- new_entity.animation[dir].layers[i].hr_version.shift[1] = new_entity.animation[dir].layers[i].hr_version.shift[1] * scale_factor
			new_entity.animation[dir].layers[i].hr_version.shift[2] = new_entity.animation[dir].layers[i].hr_version.shift[2] - 2
			new_entity.animation[dir].layers[i].scale = scale_factor
			new_entity.animation[dir].layers[i].hr_version.scale = scale_factor
		end
		table.insert(new_entity.animation[dir].layers, edge_art)
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
	
	local new_pipe_con_edge_offset = (new_drawing_box_size/3)
	local new_pipe_conn_pos = { 
		-- in-left
		{math.floor(-1*new_drawing_box_size+new_pipe_con_edge_offset),	math.floor(-1*new_drawing_box_size)}, 
		-- in-right
		{math.ceil(new_drawing_box_size - new_pipe_con_edge_offset),math.floor(-1*new_drawing_box_size)}, 
		-- out-left
		{math.floor(-1*new_drawing_box_size+new_pipe_con_edge_offset),math.ceil(new_drawing_box_size)}, 
		-- out-right
		{math.ceil(new_drawing_box_size - new_pipe_con_edge_offset),math.ceil(new_drawing_box_size)}
	}
	local pipe_counter = {1,3} -- input,output
	for i,res in pairs(new_entity.fluid_boxes)
	do
		if type(res) ~= type(table)
		then
			goto continue
		end
		
		--Ensure negative values get more negative and pos values get more pos
		--new_entity.fluid_boxes[i].secondary_draw_orders = nil
		if new_entity.fluid_boxes[i].pipe_connections[1].type == "input"
		then
			new_entity.fluid_boxes[i].pipe_connections[1].position[1] = new_pipe_conn_pos[pipe_counter[1]][1]
			new_entity.fluid_boxes[i].pipe_connections[1].position[2] = new_pipe_conn_pos[pipe_counter[1]][2]
			pipe_counter[1] = pipe_counter[1] + 1
		else
			new_entity.fluid_boxes[i].pipe_connections[1].position[1] = new_pipe_conn_pos[pipe_counter[2]][1]
			new_entity.fluid_boxes[i].pipe_connections[1].position[2] = new_pipe_conn_pos[pipe_counter[2]][2]
			pipe_counter[2] = pipe_counter[2] + 1
		end
		::continue::
	end
	
	data:extend({new_entity})
end