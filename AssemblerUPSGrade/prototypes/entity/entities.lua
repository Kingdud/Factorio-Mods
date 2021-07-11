require("prototypes.constants")
require("prototypes.functions")

function ComputePowerDrainAndDraw(count, bld_power)
	local num_beacons = count * math.ceil(beacon_count * 0.5) + beacon_count
	local draw = bld_power * count
	
	--Draw/30 is the standard drain for an entity with power where drain is not specified, per Factorio Wiki.
	local drain = num_beacons * beacon_pwr_drain + draw / 30
	
	return draw, drain
end

function updateAssFluidBoxes(new_entity, assemblers, half_side_len, fluid_per_second)
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
		
		-- for _,dir in pairs({"north", "east", "south", "west"})
		-- do
			-- for z,_ in pairs(new_entity.fluid_boxes[i].pipe_covers[dir].layers)
			-- do
				-- new_entity.fluid_boxes[i].pipe_covers[dir].layers[z].shift = {-.5,0}
				-- new_entity.fluid_boxes[i].pipe_covers[dir].layers[z].hr_version.shift = {-.5,0}
			-- end

			-- new_entity.fluid_boxes[i].pipe_picture[dir].scale = assemblers / 1.725
			-- new_entity.fluid_boxes[i].pipe_picture[dir].hr_version.scale = assemblers / 1.725
			-- new_entity.fluid_boxes[i].pipe_picture[dir].shift[1] = new_entity.fluid_boxes[i].pipe_picture[dir].shift[1] + .5
			-- new_entity.fluid_boxes[i].pipe_picture[dir].shift[2] = new_entity.fluid_boxes[i].pipe_picture[dir].shift[2] + .5
			-- new_entity.fluid_boxes[i].pipe_picture[dir].hr_version.shift[1] = new_entity.fluid_boxes[i].pipe_picture[dir].hr_version.shift[1] + .5
			-- new_entity.fluid_boxes[i].pipe_picture[dir].hr_version.shift[2] = new_entity.fluid_boxes[i].pipe_picture[dir].hr_version.shift[2] + .5
		-- end
		::continue::
	end
	
	--The vanilla entities always have inputs and outputs. We only care about inputs; ASIFs do not produce output fluids.
	if math.ceil(fluid_per_second / MAX_FLUID_PER_INPUT_PER_SECOND) > table_size(new_entity.fluid_boxes) / 2 then
		local base_fluidbox = util.table.deepcopy(new_entity.fluid_boxes[1])
		local num_additonal = math.ceil(fluid_per_second / MAX_FLUID_PER_INPUT_PER_SECOND) - table_size(new_entity.fluid_boxes) / 2
		
		for i=0, num_additonal, 1 do
			base_fluidbox.base_level = -1
			base_fluidbox.production_type = "input"
			base_fluidbox.pipe_connections[1].type = "input"
			base_fluidbox.pipe_covers = nil
			base_fluidbox.pipe_picture = nil
			if i % 2 == 0 then
				if math.floor((i+1) * (-4)) < new_entity.drawing_box[1][1] then goto try_next_pipe end
				base_fluidbox.pipe_connections[1].position[1] = math.floor((i+1) * (-4))
				base_fluidbox.pipe_connections[1].position[2] = math.floor(-1 * half_side_len)
			else
				if math.ceil((i+1) * 4) < new_entity.drawing_box[2][1] then goto try_next_pipe end
				base_fluidbox.pipe_connections[1].position[1] = math.ceil((i+1) * 4)
				base_fluidbox.pipe_connections[1].position[2] = math.floor(-1 * half_side_len)
			end
			table.insert(new_entity.fluid_boxes, base_fluidbox)
			::try_next_pipe::
		end
	end
	
	if DEBUG then
		for idx, box in pairs(new_entity.fluid_boxes) do
			if type(box) == "table" then
				log("Debug " .. new_entity.name .. " connections " .. idx .. " " .. do_dump(box.pipe_connections))
			end
		end
	end
end

function createAssemblerEntity(name, compression_ratio, n_ass, e_ass, fluid_per_second)
	if DEBUG then
		log("Debug: createAssemblerEntity " .. name)
	end
	
	--modify here if you wish to create separate entities for normal/expensive mode.
	local draw, drain = ComputePowerDrainAndDraw(n_ass, assembler_total_pwr_draw_prod)
		
	--Pollution
	--modify here if you wish to create separate entities for normal/expensive mode.
	local total_pollution_value = assembler_base_pollution * (assembler_per_unit_pwr_drain_penalty_prod * (prod_mod_pollution_penalty * assembler_base_modules + 1)) * n_ass
	
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
	local scale_factor = 0
	
	--params: bld size, beacons on one side per bld, compression ratio
	new_drawing_box_size, scale_factor = getScaleFactors(3, 4, n_ass)
	
	local new_collison_size = new_drawing_box_size - 0.3
	
	local override_size = settings.startup["max-bld-size"].value
	if override_size ~= 0
	then
		new_drawing_box_size = override_size / 2
		new_collison_size = new_drawing_box_size - 0.3
		scale_factor = override_size / 3 / 1.875
	end

	local scale_adjust = 1.05
	new_entity.alert_icon_shift[1] = new_entity.alert_icon_shift[1] * scale_factor
	new_entity.alert_icon_shift[2] = new_entity.alert_icon_shift[2] * scale_factor
	new_entity.alert_icon_scale = scale_factor
	for i,_ in pairs(new_entity.animation.layers)
	do
		new_entity.animation.layers[i].scale = scale_factor * scale_adjust
		new_entity.animation.layers[i].hr_version.scale = scale_factor * scale_adjust
		
		if new_entity.animation.layers[i].hr_version.filename == "__base__/graphics/entity/assembling-machine-3/hr-assembling-machine-3.png" then
			new_entity.animation.layers[i].hr_version.filename = "__AssemblerUPSGrade__/graphics/entity/assembler-model.png"
		end

	end
	
	new_entity.collision_box = { {-1*new_collison_size, -1*new_collison_size}, {new_collison_size,new_collison_size} }
	new_entity.drawing_box = { {-1*new_drawing_box_size, -1*(new_drawing_box_size)}, {new_drawing_box_size,new_drawing_box_size} }
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
		updateAssFluidBoxes(new_entity, n_ass, new_drawing_box_size, fluid_per_second)
	else
		new_entity.fluid_boxes = nil
	end
	
	local edge_art = {
		filename = "__AssemblerUPSGrade__/graphics/entity/assembler-border.png",
		frame_count = new_entity.animation.layers[1].frame_count,
		line_length = new_entity.animation.layers[1].line_length,
		height = 256,
		priority = "high",
		scale = scale_factor * .75,
		width = 256,
	}
	table.insert(new_entity.animation.layers, edge_art)
	
	local color_mask = {
		filename = "__AssemblerUPSGrade__/graphics/entity/ass-mach-tint_mask.png",
		frame_count = new_entity.animation.layers[1].frame_count,
		line_length = new_entity.animation.layers[1].line_length,
		height = 237,
		priority = "high",
		scale = scale_factor * scale_adjust,
		width = 214,
		tint = GRAPHICS_MAP[name].tint,
		flags = {"mask"},
		apply_runtime_tint = true,
		shift = new_entity.animation.layers[1].hr_version.shift
	}
	table.insert(new_entity.animation.layers, color_mask)
	
	if DEBUG then
		log("Debug createAssemblerEntity : " .. do_dump(new_entity))
	end
	
	createEntityRadar(name, new_drawing_box_size)
	
	data:extend({new_entity})
end

function createChemFluidBoxes(entity, fluid_per_second, side_length)

	--If you change this, you need to change the if case (next_pos list / section) below. It assumes there is more room toward the center.
	local new_pipe_con_edge_offset = (side_length/3)
	local new_pipe_conn_pos = { 
		-- in-left
		{math.floor(-1*side_length+new_pipe_con_edge_offset),	math.floor(-1*side_length)}, 
		-- in-right
		{math.ceil(side_length - new_pipe_con_edge_offset),math.floor(-1*side_length)}, 
		-- out-left
		{math.floor(-1*side_length+new_pipe_con_edge_offset),math.ceil(side_length)}, 
		-- out-right
		{math.ceil(side_length - new_pipe_con_edge_offset),math.ceil(side_length)}
	}

	local pipe_counter = {1,3} -- input,output
	for i,res in pairs(entity.fluid_boxes)
	do
		if type(res) ~= type(table)
		then
			goto continue
		end
		
		--Ensure negative values get more negative and pos values get more pos
		if entity.fluid_boxes[i].pipe_connections[1].type == "input"
		then
			entity.fluid_boxes[i].pipe_connections[1].position[1] = new_pipe_conn_pos[pipe_counter[1]][1]
			entity.fluid_boxes[i].pipe_connections[1].position[2] = new_pipe_conn_pos[pipe_counter[1]][2]
			pipe_counter[1] = pipe_counter[1] + 1
		else
			entity.fluid_boxes[i].pipe_connections[1].position[1] = new_pipe_conn_pos[pipe_counter[2]][1]
			entity.fluid_boxes[i].pipe_connections[1].position[2] = new_pipe_conn_pos[pipe_counter[2]][2]
			pipe_counter[2] = pipe_counter[2] + 1
		end
		::continue::
	end
	if math.ceil(fluid_per_second / MAX_FLUID_PER_INPUT_PER_SECOND) > table_size(entity.fluid_boxes) / 2 then
		local next_pos = {
			["left_left"] = new_pipe_conn_pos[1][1] + 4,
			["left_right"] = new_pipe_conn_pos[1][1] - 4,
			["right_left"] = new_pipe_conn_pos[2][1] - 4,
			["right_right"] = new_pipe_conn_pos[2][1] + 4
		}
		--The vanilla entities always have inputs and outputs. We only care about inputs; ASIFs do not produce output fluids.
		local num_additonal = math.ceil(fluid_per_second / MAX_FLUID_PER_INPUT_PER_SECOND) - table_size(entity.fluid_boxes) / 2
		
		if num_additonal > (side_length*2) / 4 then
			log("Warning! Building too small for all required inputs. Need " .. num_additonal .. " have room for " .. (side_length*2) / 4)
			num_additonal = (side_length*2) / 4
		end
		local base_fluidbox = util.table.deepcopy(entity.fluid_boxes[1])
		
		--If we have an odd number of boxes, the extra box goes in the middle.
		if num_additonal % 2 == 1 then
			base_fluidbox.base_level = -1
			base_fluidbox.production_type = "input"
			base_fluidbox.pipe_covers = nil
			base_fluidbox.pipe_picture = nil
			base_fluidbox.pipe_connections[1].type = "input"
			base_fluidbox.pipe_connections[1].position[1] = 0
			base_fluidbox.pipe_connections[1].position[2] = math.floor(-1*side_length)
		end
		
		for i=1, num_additonal, 1 do
			base_fluidbox.base_level = -1
			base_fluidbox.production_type = "input"
			base_fluidbox.pipe_covers = nil
			base_fluidbox.pipe_picture = nil
			base_fluidbox.pipe_connections[1].type = "input"
			
			--All this complexity is because I wanted to not have the inputs move between standard 2-in config and 3+; I wanted the 2 at the middle of the pipes to still be there with 3+ connections. Additionals would be placed to the left and right of those.
			if i % 4 == 0 then
				--in-left-left (left input, to outer edge)
				if next_pos.left_left < -1 * side_length then
					base_fluidbox.pipe_connections[1].position[1] = next_pos.left_right
					--We will always have more room for inputs on the side toward the center.
					next_pos.left_right = next_pos.left_right - 4
				else
					base_fluidbox.pipe_connections[1].position[1] = next_pos.left_left
				end
				base_fluidbox.pipe_connections[1].position[2] = math.floor(-1*side_length)
				next_pos.left_left = next_pos.left_left + 4
			elseif i % 4 == 1 then
				--in-left-right (left input, to center)
				base_fluidbox.pipe_connections[1].position[1] = next_pos.left_right
				base_fluidbox.pipe_connections[1].position[2] = math.floor(-1*side_length)
				next_pos.left_right = next_pos.left_right - 4
			elseif i % 4 == 2 then
				--in-right-left (right input, to center)
				base_fluidbox.pipe_connections[1].position[1] = next_pos.right_left
				base_fluidbox.pipe_connections[1].position[2] = math.floor(-1*side_length)
				next_pos.right_left = next_pos.right_left - 4
			else
				--in-right-right (right input, to outer edge)
				if next_pos.right_right < -1 * side_length then
					base_fluidbox.pipe_connections[1].position[1] = next_pos.right_left
					--We will always have more room for inputs on the side toward the center.
					next_pos.right_left = next_pos.right_left - 4
				else
					base_fluidbox.pipe_connections[1].position[1] = next_pos.right_right
				end
				base_fluidbox.pipe_connections[1].position[2] = math.floor(-1*side_length)
				next_pos.right_right = next_pos.right_right + 4
			end
			table.insert(entity.fluid_boxes, base_fluidbox)
			::try_next_chem_pipe::
		end
	end
	
	if DEBUG then
		for idx, box in pairs(entity.fluid_boxes) do
			log("Debug connections " .. idx .. " " .. do_dump(box.pipe_connections))
		end
	end
end

function createChemPlantEntity(name, compression_ratio, n_chem, e_chem, fluid_per_second)
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
	local scale_factor = 0
	
	--params: bld size, beacons on one side per bld, compression ratio
	new_drawing_box_size, scale_factor = getScaleFactors(3, 4, n_chem)
	
	local new_collison_size = new_drawing_box_size - 0.3
	
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
			--All offsets taken with water in the bottom-right corner.
			new_entity.working_visualisations[i].animation.scale = scale_factor
			new_entity.working_visualisations[i].animation.hr_version.scale = scale_factor
			new_entity.working_visualisations[i].animation.shift[1] = (new_entity.working_visualisations[i].animation.shift[1]) * scale_factor  --+ is right, - is left
			new_entity.working_visualisations[i].animation.shift[2] = (new_entity.working_visualisations[i].animation.shift[2] + .35) * scale_factor --+ is down, - is up
			new_entity.working_visualisations[i].animation.hr_version.shift[1] = (new_entity.working_visualisations[i].animation.hr_version.shift[1]) * scale_factor
			new_entity.working_visualisations[i].animation.hr_version.shift[2] = (new_entity.working_visualisations[i].animation.hr_version.shift[2] + .35) * scale_factor
			
			for _, dir in pairs({"north_position","east_position","west_position","south_position"}) do
				--And, for reasons unknown, west continues to be a problem.
				if dir == "north_position" then
					new_entity.working_visualisations[i][dir][1] = (new_entity.working_visualisations[i][dir][1] * 2 + .1) * scale_factor
					--For reasons that are unclear to me, the outside smoke animation needs a little extra bump north for some reason.
					if i == 3 then
						new_entity.working_visualisations[i][dir][2] = (new_entity.working_visualisations[i][dir][2] * 2.25) * scale_factor
					else
						new_entity.working_visualisations[i][dir][2] = (new_entity.working_visualisations[i][dir][2] * 2) * scale_factor
					end
				else
					new_entity.working_visualisations[i][dir][1] = (new_entity.working_visualisations[i][dir][1] * 2 - .2) * scale_factor  --+ is right, - is left
					--For reasons that are unclear to me, the outside smoke animation needs a little extra bump north for some reason.
					if i == 3 then
						new_entity.working_visualisations[i][dir][2] = (new_entity.working_visualisations[i][dir][2] * 2.25 - .1) * scale_factor --+ is down, - is up
					else
						new_entity.working_visualisations[i][dir][2] = (new_entity.working_visualisations[i][dir][2] * 2 - .1) * scale_factor --+ is down, - is up
					end
				end
			end
		else
			--Mixing window
			for _, dir in pairs({"north_animation","east_animation","west_animation","south_animation"}) do
				new_entity.working_visualisations[i][dir].scale = scale_factor
				new_entity.working_visualisations[i][dir].hr_version.scale = scale_factor

				--And, for reasons unknown, east is out of alignment with the other animations.
				if dir == "north_animation" then
					new_entity.working_visualisations[i][dir].shift[1] = (new_entity.working_visualisations[i][dir].shift[1] + .5) * scale_factor
					new_entity.working_visualisations[i][dir].shift[2] = (new_entity.working_visualisations[i][dir].shift[2] + .4) * scale_factor
					new_entity.working_visualisations[i][dir].hr_version.shift[1] = (new_entity.working_visualisations[i][dir].hr_version.shift[1] + .5) * scale_factor
					new_entity.working_visualisations[i][dir].hr_version.shift[2] = (new_entity.working_visualisations[i][dir].hr_version.shift[2] + .4) * scale_factor
				else
					new_entity.working_visualisations[i][dir].shift[1] = (new_entity.working_visualisations[i][dir].shift[1] + .1) * scale_factor --+ is right, - is left
					new_entity.working_visualisations[i][dir].shift[2] = (new_entity.working_visualisations[i][dir].shift[2] + .6) * scale_factor --+ is down, - is up
					new_entity.working_visualisations[i][dir].hr_version.shift[1] = (new_entity.working_visualisations[i][dir].hr_version.shift[1] + .1) * scale_factor
					new_entity.working_visualisations[i][dir].hr_version.shift[2] = (new_entity.working_visualisations[i][dir].hr_version.shift[2] + .6) * scale_factor
				end
			end
		end
	end
	
	--Reduce scale factor since the original art is actually too large for the entity box.
	scale_factor = scale_factor * .85

	new_entity.alert_icon_scale = scale_factor
	
	for _,dir in pairs({"north","east","south","west"})
	do
		for i,_ in pairs(new_entity.animation[dir].layers)
		do
			-- new_entity.animation[dir].layers[i].shift[1] = new_entity.animation[dir].layers[i].shift[1] * scale_factor
			new_entity.animation[dir].layers[i].shift[2] = new_entity.animation[dir].layers[i].shift[2] - (.1*scale_factor)
			-- new_entity.animation[dir].layers[i].hr_version.shift[1] = new_entity.animation[dir].layers[i].hr_version.shift[1] * scale_factor
			new_entity.animation[dir].layers[i].hr_version.shift[2] = new_entity.animation[dir].layers[i].hr_version.shift[2] - (.1*scale_factor)
			new_entity.animation[dir].layers[i].scale = scale_factor
			new_entity.animation[dir].layers[i].hr_version.scale = scale_factor
		end
		table.insert(new_entity.animation[dir].layers, edge_art)
	end
	
	new_entity.collision_box = { {-1*new_collison_size, -1*new_collison_size}, {new_collison_size,new_collison_size} }
	new_entity.drawing_box = { {-1*new_drawing_box_size, -1*(new_drawing_box_size)}, {new_drawing_box_size,new_drawing_box_size} }
	new_entity.selection_box = { {-1*new_drawing_box_size, -1*new_drawing_box_size}, {new_drawing_box_size,new_drawing_box_size} }
	
	if DEBUG then
		log("Debug bld size " .. do_dump(new_entity.collision_box))
	end
	
	new_entity.icon = "__AssemblerUPSGrade__/graphics/" .. GRAPHICS_MAP[name].icon
	-- new_entity.icons = {
		-- {
			-- icon = "__AssemblerUPSGrade__/graphics/" .. GRAPHICS_MAP[name].icon,
			-- icon_size = 64,
			-- tint = GRAPHICS_MAP[name].tint
		-- }
	-- }
	new_entity.icon_size = 64
	
	createChemFluidBoxes(new_entity, fluid_per_second, new_drawing_box_size)
	
	createEntityRadar(name, new_drawing_box_size)
	
	data:extend({new_entity})
end